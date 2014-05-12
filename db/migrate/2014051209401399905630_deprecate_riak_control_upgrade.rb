class DeprecateRiakControlUpgrade < ActiveRecord::Migration
  def up
    Test.where(name: 'riak_control_upgrade').
      where(["NOT exist(tests.tags::hstore, 'max_version') OR " +
             "(tests.tags::hstore -> 'max_version' >= ?)",
             '2.0.0']).
      update_all("tags = tags || hstore('max_version', '1.4.99')")
  end

  def down
    Test.where(name: 'riak_control_upgrade').
      where(["tests.tags::hstore -> 'max_version' = ?", '1.4.99']).
      update_all("tags = delete(tags, 'max_version')")
  end
end
