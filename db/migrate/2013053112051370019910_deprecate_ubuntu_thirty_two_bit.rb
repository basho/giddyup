class DeprecateUbuntuThirtyTwoBit < ActiveRecord::Migration
  def up
    say_with_time "Setting max version on ubuntu-1004-32 tests to 1.3.99" do
      Test.where(['tests.tags::hstore @> ?',
                  HstoreSerializer.dump('platform' => 'ubuntu-1004-32')]).each do |test|
        unless test.tags['max_version'] && test.tags['max_version'] != '1.3.99'
          test.tags['max_version'] = '1.3.99'
          test.save!
        end
      end
    end
  end

  def down
    say_with_time "Removing max version on ubuntu-1004-32 tests" do
      Test.where(['tests.tags::hstore @> ?',
                  HstoreSerializer.dump('platform' => 'ubuntu-1004-32',
                                        'max_version' =>  '1.3.99')]).each do |test|
        test.tags.delete('max_version')
        test.save!
      end
    end
  end
end
