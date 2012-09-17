class RemovePlatform < ActiveRecord::Migration
  def change
    drop_table :platforms
    drop_table :platforms_projects
  end
end
