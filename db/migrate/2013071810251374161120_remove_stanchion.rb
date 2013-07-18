class RemoveStanchion < ActiveRecord::Migration
  def up
    Project.where(:name => 'stanchion').destroy_all
  end

  def down
    Project.find_or_create_by_name('stanchion')
  end
end
