$: << 'lib'
require 'bundler/setup'
require 'rake-pipeline'
require 'pathname'
require 'date'

task :environment do
  Bundler.require(:default, ENV["RACK_ENV"] || :development)
  require 'giddyup'
end

namespace :assets do
  task :precompile do
    Rake::Pipeline::Project.new("Assetfile").invoke
  end
end

task :jshint do
  jsfiles = Dir["assets/javascripts/app/**/*.js"]
  result = system "jshint", "--config" , ".jshintrc", *jsfiles
  exit result || 1
end

namespace :db do
  desc "Generates a new migration"
  task :new_migration, :name do |t, args|
    name = args[:name]
    date = Time.now.strftime('%Y%m%d%H%M%s')
    require 'active_support/core_ext/string/inflections'
    underscored_name = name.underscore
    camelized_name = name.camelize
    File.open("db/migrate/#{date}_#{underscored_name}.rb", "w") do |f|
      puts "Creating #{f.path}"
      f.write "class #{camelized_name} < ActiveRecord::Migration\n  def up\n  end\n\n  def down\n  end\nend\n"
    end
  end

  task :migrate => :environment do
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate([Pathname.new('db/migrate')], ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end
    Rake::Task['db:schema:dump'].invoke
  end

  task :seed => :migrate do
    load 'db/seed.rb'
  end

  task :backfill_log_url => :environment do
    TestResult.where('log_url IS NULL').each do |result|
      puts "Backfilling test result: #{result.id}."
      begin
        result.log_url = GiddyUp::S3.directories.get(GiddyUp::LogBucket).files.new(:key => "#{result.id}.log").public_url
      rescue Excon::Errors::Error => e
        puts "  Failed! #{e.message.split(/\n/).first}"
      else
        result.save
      end
    end
  end

  namespace :schema do
    task :dump => :environment do
      require 'active_record/schema_dumper'
      filename = ENV['SCHEMA'] || "db/schema.rb"
      File.open(filename, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end
end
