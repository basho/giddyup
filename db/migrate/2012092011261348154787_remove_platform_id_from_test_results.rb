class RemovePlatformIdFromTestResults < ActiveRecord::Migration
  def change
    change_table :test_results do |t|
      t.remove_references :platform
    end
  end
end
