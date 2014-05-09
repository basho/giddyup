class AddIndexesToScorecards < ActiveRecord::Migration
  def up
    remove_index :scorecards, column: 'project_id'
    add_index :scorecards, %w{project_id name}, name: 'index_scorecards_on_project_id_and_name'
  end

  def down
    remove_index :scorecards, name: 'index_scorecards_on_project_id_and_name'
    add_index :scorecards, :project_id
  end
end
