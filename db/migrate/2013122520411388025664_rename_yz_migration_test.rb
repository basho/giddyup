class RenameYzMigrationTest < ActiveRecord::Migration
  def up
    Test.where(name: 'yz_rs_migration').update_all(name: 'yz_rs_migration_test')
  end

  def down
    Test.where(name: 'yz_rs_migration_test').update_all(name: 'yz_rs_migration')
  end
end
