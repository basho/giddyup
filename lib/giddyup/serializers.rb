class ProjectSerializer < ActiveModel::Serializer
  attributes :name
  has_many :tests
  has_many :scorecards

  def include_scorecards?
    scope == :single
  end
end

class TestResultSerializer < ActiveModel::Serializer
  attributes :status, :log_url, :test_id, :scorecard_id
end

class ScorecardSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  attributes :id, :name, :project
  has_many :test_results

  def project
    scorecard.project.name
  end

  def include_test_results?
    scope == :single
  end
end
