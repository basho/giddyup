require 'set'
class FixLevelDbBackendName < ActiveRecord::Migration
  def up
    say_with_time "Fixing LevelDB backend name 'leveldb' -> 'eleveldb'" do
      tests = Hash.new {|h,k| h[k] = 0 }
      Test.where(['tests.tags::hstore @> ?',
                  HstoreSerializer.dump('backend' => 'leveldb')]).each do |test|
        tests[test.name] += 1
        test.tags['backend'] = 'eleveldb'
        test.save!
      end
      tests.each {|k,v| say "#{k}: #{v} instances", true }
    end
  end

  def down
    # don't do this
  end
end
