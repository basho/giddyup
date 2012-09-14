class AddHstoreSupport < ActiveRecord::Migration
  def up
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    change_table :tests do |t|
      t.remove :tags
      t.column :tags, :hstore
    end
    execute "CREATE INDEX tests_tags_index ON tests USING gin(tags)"
  end

  def down
    execute "DROP INDEX tests_tags_index ON tests"
    change_table :tests do |t|
      t.remove :tags
      t.text :tags
    end
    execute "DROP EXTENSION IF EXISTS hstore"
  end
end
