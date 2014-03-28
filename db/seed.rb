$projects = %w{riak riak_ee riak_cs smoke-tests}.inject({}) do |hash, key|
  hash.merge key => Project.find_or_create_by_name(key)
end

platforms = %w{
  ubuntu-1004-64
  ubuntu-1104-64
  ubuntu-1204-64
  fedora-17-64
  centos-5-64
  centos-6-64
  solaris-10u9-64
  freebsd-9-64
  smartos-64
  osx-64
}

backends = %w{
  bitcask
  eleveldb
  memory
}

riak_tests = %w{
  basic_command_line
  client_java_verify
  gh_riak_core_154
  gh_riak_core_155
  gh_riak_core_176
  mapred_verify_rt
  partition_repair
  riaknostic_rt
  rt_basic_test
  verify_backup_restore
  verify_build_cluster
  verify_busy_dist_port
  verify_capabilities
  verify_claimant
  verify_commit_hooks
  verify_down
  verify_leave
  verify_link_walk_urls
  verify_listkeys
  verify_mr_prereduce_node_down
  verify_riak_lager
  verify_riak_stats
  verify_search
  verify_staged_clustering
}

PLATFORM_SKIPS = {
  '2.0' => /ubuntu(-11|.*32)|fedora-15|smartos/,
  '1.4' => /ubuntu.*32|fedora-15/,
  '1.3' => /fedora-15/
}

def create_riak_test(name, *args)
  tags = args.pop || {}
  projects = args.first || %w{riak riak_ee}
  unless Test.where(:name => name).tagged(tags).exists?
    $stdout.puts "Creating test #{name} with #{tags.inspect} for projects #{projects.inspect}"
    test = Test.create(:name => name, :tags => tags)
    projects.each do |p|
      $projects[p].tests << test
    end
  end
end

riak_tests.each do |t|
  platforms.each do |p|
    create_riak_test t, 'platform' => p
  end
end

## Special handling for 2i
platforms.each do |p|
  ['eleveldb', 'memory'].each do |b|
    create_riak_test "secondary_index_tests", 'platform' => p, 'backend' => b
  end
end

## Special handling for Ruby and Python tests
platforms.each do |p|
  create_riak_test "client_ruby_verify", 'platform' => p, 'backend' => 'memory'
  create_riak_test "client_python_verify", 'platform' => p, 'backend' => 'eleveldb'
end

## Test upgrades on only persistent backends, from two different versions
platforms.each do |p|
  %w{previous legacy}.each do |v|
    # FreeBSD was not supported before 1.2, so don't run legacy
    # upgrades until 1.4
    tags = (p =~ /freebsd/ && v == 'legacy') ? {'min_version' => '1.4.0'} : {}

    %w{bitcask eleveldb}.each do |b|
      create_riak_test "loaded_upgrade", tags.merge('platform' => p, 'backend' => b, 'upgrade_version' => v)
    end
    create_riak_test "verify_basic_upgrade", tags.merge('platform' => p, 'upgrade_version' => v)
    create_riak_test "rolling_capabilities", tags.merge('platform' => p, 'upgrade_version' => v)
  end
end

## Riak 1.3 features
platforms.each do |p|
  next if p =~ PLATFORM_SKIPS['1.3']
  tags = {'platform' => p, 'min_version' => '1.3.0'}
  create_riak_test "verify_reset_bucket_props", tags
  create_riak_test "verify_kv_health_check", tags
end

## Riak 1.3.1+
platforms.each do |p|
  next if p =~ PLATFORM_SKIPS['1.3']
  tags = {'platform' => p, 'min_version' => '1.3.1'}
  create_riak_test 'verify_secondary_index_reformat', tags.merge('backend' => 'eleveldb',
                                                                 'max_version' => '1.4.99')
  create_riak_test 'pr_pw', tags
end

## Riak 1.4
platforms.each do |p|
  next if p =~ PLATFORM_SKIPS['1.4']
  tags = {'platform' => p, 'min_version' => '1.4.0'}
  # Tests without a backend defined
  %w{bucket_props_roundtrip mapred_basic_compat mapred_buffer_prereduce
     mapred_dead_pipe mapred_javascript post_generate_key
     pipe_verify_basics pipe_verify_examples pipe_verify_exceptions
     pipe_verify_handoff pipe_verify_handoff_blocking
     pipe_verify_restart_input_forwarding pipe_verify_sink_types
     verify_asis_put verify_api_timeouts verify_counter_converge}.each do |t|
    create_riak_test t, tags
  end
  # Upgrades
  %w{previous legacy}.each do |u|
    create_riak_test "verify_riak_object_reformat", tags.merge("upgrade_version" => u)
  end
  # Multiple backends on dynamic ring test
  backends.each do |b|
    create_riak_test 'verify_dynamic_ring', tags.merge('backend' => b)
  end
  # New 2I tests
  %w{eleveldb memory}.each do |b|
    %w{verify_2i_stream verify_2i_limit verify_2i_returnterms
       verify_cs_bucket}.each do |t|
      create_riak_test t, tags.merge('backend' => b)
    end
    %w{previous legacy}.each do |u|
        create_riak_test "verify_2i_mixed_cluster",
            tags.merge('upgrade_version' => u,
                      'backend' => b)
    end
  end
  # Riak 1.4.1
  create_riak_test "riak_control_upgrade", tags.merge('min_version' => '1.4.1')
  create_riak_test "riak_control", tags.merge('min_version' => '1.4.1')
  %w{eleveldb memory}.each do |b|
    create_riak_test "verify_2i_timeout", tags.merge('backend' => b,
                                                     'min_version' => '1.4.1')
  end
  # Riak 1.4.2
  tags = tags.merge('max_version' => '1.4.99') if p =~ PLATFORM_SKIPS['2.0']
  create_riak_test 'mapred_http_errors', tags.merge('min_version' => '1.4.2')
  # Riak 1.4.4
  %w{eleveldb memory multi}.each do |b|
      create_riak_test 'verify_2i_aae', tags.merge('min_version' => '1.4.4',
                                                  'backend' => b)
  end
  # max_version should already be set if the platform is skipped for
  # 2.0
  create_riak_test 'verify_aae', tags.merge('min_version' => '1.4.8')
  create_riak_test 'verify_object_limits', tags.merge('min_version' => '1.4.8')
end

## Riak 2.0
platforms.each do |p|
  next if p =~ PLATFORM_SKIPS['2.0']
  tags = {'platform' => p, 'min_version' => '2.0.0'}

  ## Yokozuna tests
  yz = %w{aae_test yokozuna_essential yz_errors yz_fallback yz_dt_test
          yz_monitor_solr yz_security yz_stat_test yz_index_admin
          yz_languages yz_mapreduce yz_pb yz_rs_migration_test
          yz_schema_admin yz_siblings yz_wm_extract_test
          yz_solr_start_timeout}

  ## Core tests
  core = %w{verify_dt_converge http_security
            pb_security cuttlefish_configuration
            riak_control_authentication cluster_meta_basic
            verify_counter_capability verify_crdt_capability
            sibling_explosion pb_cipher_suites riak_admin_console_tests}
  (yz + core).each do |t|
    create_riak_test t, tags
  end
  ## Bucket types need leveldb so the 2i sections run
  %w{bucket_types http_bucket_types}.each do |t|
    create_riak_test t, tags.merge('backend' => 'eleveldb')
  end
  %w{handoff_ttl overload}.each do |t|
    create_riak_test t, tags.merge('backend' => 'memory')
  end
  ## Upgrade tests
  %w{verify_handoff_mixed}.each do |t|
    %w{previous legacy}.each do |u|
      create_riak_test t, tags.merge('upgrade_version' => u)
    end
  end
  # verify_no_writes_on_read valid for 1.4+ but not backporting in
  # riak_test, only valid on bitcask backend
  create_riak_test 'verify_no_writes_on_read', tags.merge('backend' => 'bitcask')
end

## Riak EE-only tests
platforms.each do |p|
  %w{jmx_verify verify_snmp}.each do |t|
    create_riak_test t, %w{riak_ee}, 'platform' => p
  end
  repl1_max = p =~ PLATFORM_SKIPS['1.4'] ? '1.3.99' : '1.4.99'
  %w{replication replication_ssl}.each do |t|
    next if p =~ PLATFORM_SKIPS['1.4']
    # "Classic" repl is going to be removed in the version after 1.4
    create_riak_test t, %w{riak_ee}, 'platform' => p, 'max_version' => repl1_max
  end
  %w{replication2 replication2_dirty}.each do |t|
    # "New" repl is only in 1.3 and later
    create_riak_test t, %w{riak_ee}, 'platform' => p, 'min_version' => '1.3.0'
  end
  %w{previous legacy}.each do |v|
    # FreeBSD was not supported before 1.2, so don't run legacy
    # upgrades until 1.4
    tags = (p =~ /freebsd/ && v == 'legacy') ? {'min_version' => '1.4.0'} : {}
    # "Classic" repl is going to be removed in the version after 1.4
    create_riak_test 'replication_upgrade', %w{riak_ee},
         tags.merge('platform' => p, 'upgrade_version' => v,
                    'max_version' => repl1_max)

    # New repl upgrade
    unless p =~ PLATFORM_SKIPS['1.4']
      if p =~ PLATFORM_SKIPS['2.0']
        # We need to ensure we don't add legacy for 1.4, see migration
        # Repl2Legacy14
        next if v == 'legacy'
        tags = tags.merge('max_version' => '1.4.99')
      end
      repl2_min = (v == 'legacy') ? '2.0.0' : '1.4.0'
      # Don't inject tests with disjoint ranges
      next if tags['max_version'] && tags['max_version'] < repl2_min
      create_riak_test 'replication2_upgrade', %w{riak_ee},
                       tags.merge({'platform' => p, 'upgrade_version' => v,
                                   'min_version' => repl2_min})
    end
  end

  # Riak EE 1.4
  %w{replication2_fsschedule replication2_ssl rt_cascading
     replication2_pg:test_basic_pg_mode_repl13
     replication2_pg:test_basic_pg_mode_mixed
     replication2_pg:test_12_pg_mode_repl12
     replication2_pg:test_12_pg_mode_repl_mixed
     replication2_pg:test_mixed_pg
     replication2_pg:test_multiple_sink_pg
     replication2_pg:test_bidirectional_pg
     replication2_pg:test_pg_proxy
     replication2_pg:test_basic_pg_mode_repl13_ssl
     replication2_pg:test_basic_pg_mode_mixed_ssl
     replication2_pg:test_12_pg_mode_repl12_ssl
     replication2_pg:test_12_pg_mode_repl_mixed_ssl
     replication2_pg:test_mixed_pg_ssl
     replication2_pg:test_multiple_sink_pg_ssl
     replication2_pg:test_bidirectional_pg_ssl
     replication2_pg:test_pg_proxy_ssl
     verify_counter_repl
     repl_rt_heartbeat
    }.each do |t|
    next if p =~ PLATFORM_SKIPS['1.4']
    tags = {'platform' => p, 'min_version' => '1.4.0'}
    tags = tags.merge('max_version' => '1.4.99') if p =~ PLATFORM_SKIPS['2.0']
    create_riak_test t, %w{riak_ee}, tags
  end

  # Riak EE 1.4.4.
  unless p =~ PLATFORM_SKIPS['1.4']
    tags = {'platform' => p, 'min_version' => '1.4.4'}
    tags = tags.merge('max_version' => '1.4.99') if p =~ PLATFORM_SKIPS['2.0']
    create_riak_test 'replication2_rt_sink_connection', %w{riak_ee}, tags
    create_riak_test 'replication2_connections', %w{riak_ee}, tags
    create_riak_test 'repl_aae_fullsync', %w{riak_ee}, tags
  end

  # Riak EE 1.4.8.
  unless p =~ PLATFORM_SKIPS['1.4']
    tags = {'platform' => p, 'min_version' => '1.4.8'}
    tags = tags.merge('max_version' => '1.4.99') if p =~ PLATFORM_SKIPS['2.0']
    create_riak_test 'replication', %w{riak_ee}, tags
    create_riak_test 'replication_ssl', %w{riak_ee}, tags
    create_riak_test 'replication_upgrade', %w{riak_ee}, tags
  end

  # Riak EE 2.0
  %w{replication2_rt_sink_connection
     replication2_connections
     repl_aae_fullsync
     verify_dvv_repl
     repl_bucket_types
     replication_object_reformat
     replication2_console_tests
     repl_consistent_object_filter
     repl_aae_fullsync_custom_n
     repl_rt_cascading_rtq
     repl_fs_stat_caching}.each do |t|
    next if p =~ PLATFORM_SKIPS['2.0']
    tags = {'platform' => p, 'min_version' => '2.0.0'}
    create_riak_test t, %w{riak_ee}, tags
  end

  # Riak EE 2.1
  %w{repl_reduced}.each do |t|
    next if p =~ PLATFORM_SKIPS['2.0']
    tags = {'platform' => p, 'min_version' => '2.1.0'}
    create_riak_test t, %w{riak_ee}, tags
  end
end

# Riak CS tests
platforms.each do |p|
  # Riak CS started using giddyup after the Riak 1.4 cycle and uses
  # the same platforms as Riak, so we filter out platforms that
  # aren't supported in that version.
  next if p =~ PLATFORM_SKIPS['1.4']
  %w{cs296_regression_test cs347_regression_test cs436_regression_test
     cs512_regression_test external_client_tests list_objects_test
     mp_upload_test object_get_conditional_test object_get_test repl_test
     stats_test too_large_entity_test}.each do |cstest|
    create_riak_test cstest, %w{riak_cs}, 'platform' => p
  end
end

# Eunit and Dialyzer tests, including dependencies we have forks on
%w{ basho_stats bear bitcask canola cluster_info cuttlefish ebloom
    eleveldb eper erlang_js folsom getopt lager lager_syslog
    merge_index mochiweb neotoma node_package pbkdf2 poolboy
    protobuffs ranch riak_api riak_auth_mods riak_control riak_core
    riak_dt riak_ensemble riak_jmx riak_kv riak_pb riak_pipe
    riak_repl riak_repl_pb_api riak_search riak_snmp riak_sysmon
    riaknostic sext sidejob syslog webmachine yokozuna }.each do |t|
  %w{ubuntu-1204-64 unofficial}.each do |p|
    create_riak_test "#{t}:eunit", %w{smoke-tests}, {'platform' => p}
    create_riak_test "#{t}:dialyzer", %w{smoke-tests}, {'platform' => p}
    create_riak_test "#{t}:xref", %w{smoke-tests}, {'platform' => p}
  end
end
