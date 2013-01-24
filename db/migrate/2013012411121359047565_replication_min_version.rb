class ReplicationMinVersion < ActiveRecord::Migration
  def up
    say_with_time "Setting min_version on new replication tests to 1.3.0" do
      Test.where(:name => %w{replication2 replication2_dirty}).each do |test|
        test.tags['min_version'] = '1.3.0'
        test.save!
      end
    end
    say_with_time "Setting max_version on old replication tests to 1.4.99" do
      Test.where(:name => %w{replication replication_ssl replication_upgrade}).each do |test|
        test.tags['max_version'] ||= '1.4.99'
        test.save!
      end
    end
  end

  def down
    say_with_time "Removing version constraints from replication tests" do
      Test.where(:name => %w{replication replication_ssl replication2 replication2_dirty replication_upgrade}).each do |test|
        test.tags.delete('min_version') unless test.tags['platform'] =~ /freebsd/ and test.name =~ /upgrade/
        test.tags.delete('max_version')
        test.save!
      end
    end
  end
end
r
