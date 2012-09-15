class RemovePlatform < ActiveRecord::Migration
  def change
    remove_table :platforms
    remove_table :platforms_tests
  end
end
