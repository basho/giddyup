class PruneOldTestResults < ActiveRecord::Migration
  def up
    say_with_time "Cleaning up scorecards, test results, and artifacts for versions < 1.4" do
      projects = Project.where(name: %w{riak riak_ee smoke-tests}).select(:id).map(&:id)
      Scorecard.where(project_id: projects).
        where(["name = ? or name < ? or name like ?",
               'unknown', '1.4.0', 'riak%']).
        destroy_all
    end
  end

  def down
    say "It's gone, get a backup"
  end
end
