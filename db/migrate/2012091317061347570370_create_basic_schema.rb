class CreateBasicSchema < ActiveRecord::Migration
  def change
    # Test
    create_table :tests do |t|
      t.string :name
      t.text :tags      
    end
    add_index :tests, :name

    # Project
    create_table :projects do |t|
      t.string :name
    end
    add_index :projects, :name
    
    # Platform
    create_table :platforms do |t|
      t.string :name
      t.integer :position
    end
    add_index :platforms, :position
    
    # Scorecard
    create_table :scorecards do |t|
      t.string :name
      t.references :project  
    end
    add_index :scorecards, :project_id
    
    # TestResult
    create_table :test_results do |t|
      t.boolean :status
      t.string :author
      t.references :test
      t.references :platform
      t.references :scorecard      
      t.timestamps
    end
    add_index :test_results, :scorecard_id

    # Join Platform <-> Project
    create_table :platforms_projects, :id => false do |t|
      t.references :platform
      t.references :project
    end
    add_index :platforms_projects, [:project_id, :platform_id]
    
    # Join Test <-> Project
    create_table :projects_tests, :id => false do |t|
      t.references :project
      t.references :test
    end
    add_index :projects_tests, [:project_id, :test_id]
  end
end
