class Platform < ActiveRecord::Base
  # name string
  # position integer
  default_scope order(:position)
end

class Test < ActiveRecord::Base
  # name string
  default_scope order(:name)
end

class TestResult < ActiveRecord::Base
  # result boolean -- did it pass or not
  # author string -- who ran it
  # test_id
  # platform_id
  # scorecard_id
  default_scope joins(:test, :platform, :backend).
    order('test.name ASC, platform.position ASC, backend.name ASC')
  belongs_to :test
  belongs_to :platform
  belongs_to :backend
  belongs_to :scorecard
end

class Backend < ActiveRecord::Base
  # name string -- 'bitcask' or 'leveldb'
  default_scope order(:name)
  
  def shortname
    name[0..1].upcase
  end
end

class Project < ActiveRecord::Base
  # name string -- 'riak' or 'riak_ee' or 'riak_cs'
  has_many :scorecards
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :tests
end

class Scorecard < ActiveRecord::Base
  # name string -- the flattened version/build
  has_many :test_results
  belongs_to :project
end
