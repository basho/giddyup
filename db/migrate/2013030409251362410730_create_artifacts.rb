class CreateArtifacts < ActiveRecord::Migration
  def up
    create_table :artifacts do |t|
      t.string :url
      t.string :content_type
      t.references :test_result
      t.timestamps
    end

    say_with_time "Converting log URLs to artifact records" do
      TestResult.find_each do |result|
        result.artifacts.create!(:content_type => "text/plain",
                                 :url => result[:log_url])
      end
    end

    remove_column :test_results, :log_url
  end

  def down
    # Don't do this, you'll lose shit. Well, the records... the files
    # will still be in the S3 bucket.
    add_column :test_results, :log_url

    TestResult.reset_column_information

    say_with_time "Converting artifact records back to log URLs" do
      TestResult.find_each(:include => :artifacts) do |result|
        result.update_attributes!(:log_url => result.artifacts.first.url)
      end
    end

    drop_table :artifacts
  end
end
