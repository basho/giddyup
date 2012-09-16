GiddyUp.Project = DS.Model.extend({
  primaryKey: 'name',
  name: DS.attr('string'),
  tests: DS.hasMany('GiddyUp.Test', { embedded: true }),
  scorecards: DS.hasMany('GiddyUp.Scorecard', { key: 'scorecard_ids' })
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.attr('string'),
  test_results: DS.hasMany('GiddyUp.TestResult', { key: 'test_result_ids' })
});

GiddyUp.TestResult = DS.Model.extend({
  test: DS.belongsTo('GiddyUp.Test'),
  platform: DS.attr('string'),
  status: DS.attr('boolean'),
  log_url: DS.attr('string')
});

GiddyUp.Test = DS.Model.extend({
  name: DS.attr('string')
  // TODO: tags
});

// Test data.

GiddyUp.store.load(GiddyUp.Project, {
  "name":"riak",
  "tests":[
    {"id":1, "name":"verify_build_cluster",
     "tags":{"platform":"ubuntu-1004-64"}},
    {"id":2, "name":"secondary_index_tests",
    "tags":{"backend":"eleveldb", "platform":"ubuntu-1004-64"}}
  ]
});

GiddyUp.store.load(GiddyUp.Project, {
  "name":"riak_ee",
  "tests":[
    {"id":3, "name":"enterprise_maven_test",
     "tags":{"platform":"ubuntu-1004-64"}},
    {"id":4, "name":"enterprise_soap_test",
    "tags":{"backend":"eleveldb", "platform":"ubuntu-1004-64"}}
  ]
});

GiddyUp.store.load(GiddyUp.Project, {
  "name":"stanchion",
  "tests":[]
});
