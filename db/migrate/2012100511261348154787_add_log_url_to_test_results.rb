class AddLogUrlToTestResults < ActiveRecord::Migration
  def change
    change_table :test_results do |t|
      t.column :log_url, :string
    end
  end
end
