class Cleanup20TestsAndPlatforms < ActiveRecord::Migration
  def up
    # Ubuntu 11 is not LTS
    say_with_time("Deprecating Ubuntu 11.04") do
      Test.tagged('platform' => 'ubuntu-1104-64').each do |test|
        print "."
        test.tags['max_version'] ||= '1.4.99'
        test.save!
      end
    end
    say_with_time("Deprecating SmartOS") do
      Test.tagged('platform' => 'smartos-64').each do |test|
        print "."
        test.tags['max_version'] ||= '1.4.99'
        test.save!
      end
    end
    say_with_time("Removing legacy from replication2_upgrade/1.4") do
      Test.where(:name => 'replication2_upgrade').
        tagged('upgrade_version' => 'legacy').each do |test|
          print "."
          test.tags['min_version'] = '2.0.0'
          test.save!
      end
    end
  end

  def down
    raise "Irreversible migration"
  end
end
