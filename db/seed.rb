projects = %w{riak riak_ee riak_cs stanchion}.inject({}) do |hash, key|
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
  gh_riak_core_154
  gh_riak_core_155
  gh_riak_core_176
  mapred_verify_rt
  riaknostic_rt
  rolling_capabilities
  rt_basic_test
  upgrade
  verify_basic_upgrade
  verify_build_cluster
  verify_capabilities
  verify_claimant
  verify_down
  verify_leave
  verify_riak_lager
  verify_riak_stats
  verify_staged_clustering
}

riak_tests.each do |t|
  platforms.each do |p|
    tags = { 'platform' => p }

    unless Test.where(:name => t).where(['tests.tags::hstore @> ?', HstoreSerializer.dump(tags) ]).exists?
      test = Test.create(:name => t, :tags => tags)
      projects['riak'].tests << test
      projects['riak_ee'].tests << test
    end
  end
end

## Special handling for 2i
platforms.each do |p|
  ['eleveldb', 'memory'].each do |b|
    t = "secondary_index_tests"
    tags = { 'platform' => p, 'backend' => b }

    unless Test.where(:name => t).where(['tests.tags::hstore @> ?', HstoreSerializer.dump(tags) ]).exists?
      test = Test.create(:name => t, :tags => tags)
      projects['riak'].tests << test
      projects['riak_ee'].tests << test
    end
  end
end
