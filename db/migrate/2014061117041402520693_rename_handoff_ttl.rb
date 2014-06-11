class RenameHandoffTtl < ActiveRecord::Migration
  def up
    Test.where(name: 'handoff_ttl').update_all(name: 'verify_membackend')
  end

  def down
    Test.where(name: 'verify_membackend').update_all(name: 'handoff_ttl')
  end
end
