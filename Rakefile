$: << 'lib'
require 'bundler/setup'
require 'rake-pipeline'
require 'pathname'

task :environment do
  Bundler.require(:default, ENV["RACK_ENV"] || :development)
  require 'giddyup'
end

namespace :assets do
  task :precompile do
    Rake::Pipeline::Project.new("Assetfile").invoke
  end
end

namespace :db do
  task :migrate => :environment do
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate([Pathname.new('db/migrate')], ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end
    Rake::Task['db:schema:dump'].invoke
  end

  namespace :schema do
    task :dump => :environment do
      puts "#{ActiveRecord::Base.connection.native_database_types.inspect}"
      require 'active_record/schema_dumper'
      filename = ENV['SCHEMA'] || "db/schema.rb"
      File.open(filename, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end
end
