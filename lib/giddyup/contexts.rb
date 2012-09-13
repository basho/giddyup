module GiddyUp
  # Context that creates a test result
  class CreateTestResult
    attr_reader :test_result, :scorecard, :test, :platform, :log
    attr_accessor :status, :author
    
    def initialize
      @test_result = TestResult.new
    end

    def id
      @test_result.save!(:validate => false) if @test_result.new_record?
      @test_result.id
    end

    def create_test_result(data)
      self.test = data.delete('test')
      self.platform = data.delete('platform')
      self.scorecard = data.delete('version')
      self.log = data.delete['log']
    end

    def scorecard=(
    
    def attributes
      {
        :test => test,
        :platform => platform,
        :scorecard => scorecard
      }
    end
  end
end
