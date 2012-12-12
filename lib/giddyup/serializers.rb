class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :scorecard_ids
  has_many :tests

  def include_tests?
    scope == :filtered
  end
end

class LogSerializer < ActiveModel::Serializer
  attributes :id, :body
end

class TestInstanceSerializer < ActiveModel::Serializer
  attributes :id, :scorecard_id, :test_id, :test_result_ids
end

class TestResultSerializer < ActiveModel::Serializer
  attributes :id, :status, :log_url, :test_instance_id, :created_at, :long_version

  def test_instance_id
    TestInstance.new(test_result.scorecard_id, test_result.test_id).id
  end
end

class TestSerializer < ActiveModel::Serializer
  attributes :id, :name, :tags
end

class ScorecardSerializer < ActiveModel::Serializer
  attributes :id, :name, :project, :test_instance_ids

  def project
    # We key the project off the name
    scorecard.project.name
  end

  def test_instance_ids
    scorecard.test_ids.map {|id| TestInstance.new(scorecard.id, id).id }
  end
end
