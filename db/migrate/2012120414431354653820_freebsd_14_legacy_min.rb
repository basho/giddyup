class Freebsd14LegacyMin < ActiveRecord::Migration
  def up
    say_with_time "Setting min_version on freebsd legacy upgrade tests to 1.4.0" do
      Test.where(:name => %w{verify_basic_upgrade loaded_upgrade}).
        where(['tests.tags::hstore @> ?',
               HstoreSerializer.dump('platform' => 'freebsd-9-64',
                                     'upgrade_version' => 'legacy')]).each do |test|
        test.tags['min_version'] = '1.4.0'
        test.save!
      end
    end
  end

  def down
    say_with_time "Removing min_version on freebsd legacy upgrade tests" do
      Test.where(:name => %w{verify_basic_upgrade loaded_upgrade}).
        where(['tests.tags::hstore @> ?',
               HstoreSerializer.dump('platform' => 'freebsd-9-64',
                                     'upgrade_version' => 'legacy')]).each do |test|
        test.tags.delete('min_version')
        test.save!
      end
    end
  end
end
