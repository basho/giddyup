class DeprecateFedora15 < ActiveRecord::Migration
  def up
    say_with_time "Setting max_version on fedora-15 tests to 1.2.99" do
      Test.where(['tests.tags::hstore @> ?',
                  HstoreSerializer.dump('platform' => 'fedora-15-64')]).each do |test|
        test.tags['max_version'] = '1.2.99'
        test.save!
      end
    end
  end

  def down
    say_with_time "Removing max_version from fedora-15 tests" do
      Test.where(['tests.tags::hstore @> ?',
                  HstoreSerializer.dump('platform' => 'fedora-15-64',
                                        'max_version' =>  '1.2.99')]).each do |test|
        test.tags.delete('max_version')
        test.save!
      end
    end
  end
end
