require 'json'
module GiddyUp
  # Context that creates a test result
  class CreateTestResult
    def initialize
      @test_result = TestResult.new
    end

    def id
      @test_result.id ||= TestResult.next_id
    end

    def create_test_result(data)
      @test_result.test_id = data['test_id'] || data['id']
      @test_result.status = data['status']
      @test_result.long_version = data['version']
      project = Project.find_by_name(data['project'])
      version = GiddyUp.version(data['version'])
      @test_result.scorecard = project.scorecards.find_or_create_by_name(version)
      @test_result.save!
      create_log data['log']
      publish_test_result
      true
    rescue => e
      $stderr.puts "Test result creation failed!"
      $stderr.puts e.message, "    " + e.backtrace.join("\n    ")
      500
    end

    def publish_test_result
      result = TestResultSerializer.new(@test_result)

      GiddyUp::Events.publish('events', 'id' => id,
                              'event' => 'test_result',
                              'data' => {test_result: result.serializable_hash})
    end

    def create_log(data)
      if data.present?
        CreateArtifact.new(id).create_artifact('body' => data,
                                               'path' => "#{id}.log")
      end
    end
  end

  # Context that creates an artifact
  class CreateArtifact
    attr_reader :artifact
    def initialize(test_result_id)
      @test_result = TestResult.find(test_result_id)
      if @test_result.present?
        @artifact = @test_result.artifacts.build
      end
    end

    def id
      @artifact.id ||= Artifact.next_id
    end

    def can_create?
      @artifact.present?
    end

    def create_artifact(data)
      directory = S3.directories.get(LogBucket) || S3.directories.create(:key => LogBucket, :public => true)
      # If it starts with the test result id (i.e. it's the test
      # output log), just use that. Otherwise prefix the path with the
      # test result ID.
      fname = if data['path'] =~ /^#{@test_result.id}/
                data['path']
              else
                File.join("#{@test_result.id}", data['path'])
              end
      file = directory.files.get(fname) || directory.files.new(:key => fname)
      file.public = true
      file.body = data['body'].to_s
      file.content_type = data['content_type'] || "text/plain"
      file.save
      @artifact.update_attributes!(:url => file.public_url,
                                   :content_type => file.content_type)
      publish_artifact
      true
    rescue => e
      $stderr.puts "Artifact creation failed!"
      $stderr.puts e.message, "    " + e.backtrace.join("\n    ")
      500
    end

    def publish_artifact
      result = ArtifactSerializer.new(@artifact)
      GiddyUp::Events.publish('events',
                              'id' => @artifact.id,
                              'event' => 'artifact',
                              'data' => {artifact: result.serializable_hash})
    end
  end
end
