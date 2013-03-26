class AddIndexToArtifacts < ActiveRecord::Migration
  def up
    add_index :artifacts, [:test_result_id, :created_at]
  end

  def down
    remove_index :artifacts, :column => [:test_result_id, :created_at]
  end
end
