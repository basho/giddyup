class RemoveBackupRestoreTest < ActiveRecord::Migration
  def up
    Test.where(name: 'verify_backup_restore').each do |t|
      t.tags['max_version'] = '1.4.99'
      t.save!
    end
  end

  def down
    Test.where(name: 'verify_backup_restore').each do |t|
      t.tags.delete 'max_version'
      t.save!
    end
  end
end
