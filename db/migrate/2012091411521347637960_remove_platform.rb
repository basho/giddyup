class RemovePlatform < ActiveRecord::Migration
  def up
    drop_table :platforms
    drop_table :platforms_projects
  end

  def down
    # Platform
    create_table :platforms do |t|
      t.string :name
      t.integer :position
    end
    add_index :platforms, :position

    # Join Platform <-> Project
    create_table :platforms_projects, :id => false do |t|
      t.references :platform
      t.references :project
    end
    add_index :platforms_projects, [:project_id, :platform_id]
  end
end
