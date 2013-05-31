$projects = %w{riak riak_ee riak_cs stanchion}.inject({}) do |hash, key|
  hash.merge key => Project.find_or_create_by_name(key)
end

platforms = %w{
  ubuntu-1004-32
  ubuntu-1004-64
  ubuntu-1104-64
  ubuntu-1204-64
  fedora-15-64
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
  leveldb
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
  '1.4' => /ubuntu.*32|fedora-15/,
  '1.3' => /fedora-15/
}

def create_riak_test(name, *args)
  tags = args.pop || {}
  projects = args.first || %w{riak riak_ee}
  unless Test.where(:name => name).where(['tests.tags::hstore @> ?', HstoreSerializer.dump(tags) ]).exists?
    if tags['platform'] =~ /fedora-15/
      tags['max_version'] = '1.2.99'
    end
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
  create_riak_test 'verify_secondary_index_reformat', tags.merge('backend' => 'eleveldb')
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
     verify_api_timeouts}.each do |t|
    create_riak_test t, tags
  end
  %w{previous legacy}.each do |u|
    create_riak_test "verify_riak_object_reformat", tags.merge("upgrade_version" => u)
  end
end

## Riak EE-only tests
platforms.each do |p|
  %w{jmx_verify verify_snmp}.each do |t|
    create_riak_test t, %w{riak_ee}, 'platform' => p
  end
  %w{replication replication_ssl}.each do |t|
    # "Classic" repl is going to be removed in the version after 1.4
    create_riak_test t, %w{riak_ee}, 'platform' => p, 'max_version' => '1.4.99'
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
                     tags.merge('platform' => p, 'upgrade_version' => v, 'max_version' => '1.4.99')

    # "New" repl can upgrade from previous in 1.3, legacy in 1.4
    unless p =~ PLATFORM_SKIPS['1.4']
      create_riak_test 'replication2_upgrade', %w{riak_ee},
                       {'platform' => p, 'upgrade_version' => v,
                        'min_version' => v == 'legacy' ? '1.4.0' : '1.3.0' }.merge(tags)
    end
  end

  %w{replication2_fsschedule replication2_pg replication2_ssl}.each do |t|
    next if p =~ PLATFORM_SKIPS['1.4']
    create_riak_test t, %w{riak_ee}, 'platform' => p, 'min_version' => '1.4.0'
  end
end
