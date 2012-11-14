class ConsolidateScorecards < ActiveRecord::Migration
  def up
    # First, we capture the entire version name in the test result
    # table (for later reference)
    add_column :test_results, :long_version, :string

    TestResult.reset_column_information
    say_with_time "Recording long_version info on test results" do
      TestResult.find_each do |result|
        result.update_attributes(:long_version => result.scorecard.name)
      end
    end

    # Now we consolidate scorecards by VERSION_REGEX, per project
    say_with_time "Consolidating scorecards" do
      Project.all.each do |project|
        project.scorecards.each do |scorecard|
          normalized_version = scorecard.name[Test::VERSION_REGEX, 0]
          if normalized_version.blank?
            say("#{project.name}: #{scorecard.name} SKIP", true)
            next
          end
          say "#{project.name}: #{scorecard.name} -> #{normalized_version}", true
          if existing_scorecard = project.scorecards.where(:name => normalized_version).first
            # If the normalized scorecard name already exists, give it the test_results from this one.
            existing_scorecard.test_results << scorecard.test_results
            scorecard.destroy
          else
            scorecard.update_attributes(:name => normalized_version)
          end
        end
      end
    end
  end

  def down
    # This is lossy!
    remove_column :test_results, :long_version
  end
end
