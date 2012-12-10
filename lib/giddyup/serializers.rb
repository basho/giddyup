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

class TestResultSerializer < ActiveModel::Serializer
  attributes :id, :status, :log_url, :test_id, :scorecard_id, :created_at, :long_version
end

class TestSerializer < ActiveModel::Serializer
  attributes :id, :name, :tags
end

class ScorecardSerializer < ActiveModel::Serializer
  attributes :id, :name, :project, :test_result_ids, :test_ids

  def project
    # We key the project off the name
    scorecard.project.name
  end
end
