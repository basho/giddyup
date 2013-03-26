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
  attributes :id, :scorecard_id, :test_result_ids, :name, :platform, :backend, :upgrade_version

  def name; test_instance.test.name; end
  def platform; test_instance.test.tags['platform']; end
  def backend; test_instance.test.tags['backend']; end
  def upgrade_version; test_instance.test.tags['upgrade_version']; end
end

class TestResultSerializer < ActiveModel::Serializer
  attributes :id, :status, :test_instance_id, :created_at, :long_version, :artifact_ids

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

class ArtifactSerializer < ActiveModel::Serializer
  attributes :url, :content_type, :test_result_id
end
