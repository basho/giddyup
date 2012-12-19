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
  rolling_capabilities
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
  verify_riak_lager
  verify_riak_stats
  verify_staged_clustering
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
  end
end

## Riak 1.3 features
platforms.each do |p|
  next if p =~ /fedora-15/
  create_riak_test "verify_reset_bucket_props", 'platform' => p, 'min_version' => '1.3.0'
end
