require 'bundler/setup'
require 'rake-pipeline'

namespace :assets do
  task :precompile do
    Rake::Pipeline::Project.new("Assetfile").invoke
  end
end
