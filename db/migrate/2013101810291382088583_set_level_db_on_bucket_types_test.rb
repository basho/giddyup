class SetLevelDbOnBucketTypesTest < ActiveRecord::Migration
  def up
    Test.where(name: 'bucket_types').each do |t|
      t.tags['backend'] = 'eleveldb'
      t.save!
    end
  end

  def down
    raise "irreversible migration"
  end
end
