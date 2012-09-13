class TestResultSerializer < ActiveModel::Serializer
  attributes :id, :result, :author, :log_url, :test, :platform, :backend, :backend_shortname

  def test
    test_result.test.name
  end

  def platform
    test_result.platform.name
  end

  def backend
    test_result.backend.name
  end

  def backend_shortname
    test_result.backend.shortname
  end
end

class ScorecardSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  attributes :id, :name, :project
  has_many :test_results
  
  def project
    scorecard.project.name
  end
end
