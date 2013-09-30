class RemoveRepl2Legacy14 < ActiveRecord::Migration
  def up
    Test.where(name: 'replication2_upgrade').
      tagged('min_version' => '1.4.0',
             'upgrade_version'=> 'legacy').
      delete_all
  end

  def down
    raise "Irreversible migration"
  end
end
