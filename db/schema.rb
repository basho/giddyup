# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2012111418271352935658) do

  create_table "projects", :force => true do |t|
    t.string "name"
  end

  add_index "projects", ["name"], :name => "index_projects_on_name"

  create_table "projects_tests", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "test_id"
  end

  add_index "projects_tests", ["project_id", "test_id"], :name => "index_projects_tests_on_project_id_and_test_id"

  create_table "scorecards", :force => true do |t|
    t.string  "name"
    t.integer "project_id"
  end

  add_index "scorecards", ["project_id"], :name => "index_scorecards_on_project_id"

  create_table "test_results", :force => true do |t|
    t.boolean  "status"
    t.string   "author"
    t.integer  "test_id"
    t.integer  "scorecard_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "log_url"
    t.string   "long_version"
  end

  add_index "test_results", ["scorecard_id"], :name => "index_test_results_on_scorecard_id"

  create_table "tests", :force => true do |t|
    t.string "name"
    t.hstore "tags"
  end

  add_index "tests", ["name"], :name => "index_tests_on_name"
  add_index "tests", ["tags"], :name => "tests_tags_index"

end
