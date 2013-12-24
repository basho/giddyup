class RemoveYzFlagTransitions < ActiveRecord::Migration
  def up
    Test.where(name: 'yz_flag_transitions').destroy_all
  end

  def down
    raise 'irreversible'
  end
end
