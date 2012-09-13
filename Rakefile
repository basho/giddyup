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
  end
end
