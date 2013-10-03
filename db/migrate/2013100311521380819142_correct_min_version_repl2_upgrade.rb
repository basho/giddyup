class CorrectMinVersionRepl2Upgrade < ActiveRecord::Migration
  def up
    Test.where(name: 'replication2_upgrade').each do |t|
      case t.tags['upgrade_version']
      when 'legacy'
        t.tags['min_version'] = '2.0.0'
      when 'previous'
        t.tags['min_version'] = '1.4.0'
      end
      say "Updating replication2_upgrade with #{t.tags}"
      t.save!
    end
  end

  def down
    raise "Irreversible migration"
  end
end
