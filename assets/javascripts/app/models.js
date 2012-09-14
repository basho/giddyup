GiddyUp.Project = DS.Model.extend({
  primaryKey: 'name',
  name: DS.attr('string'),
  tests: DS.hasMany('GiddyUp.Test', { embedded: true })
});

GiddyUp.Test = DS.Model.extend({
  name: DS.attr('string')
  // tags
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.attr('string'),
  test_results: DS.hasMany('GiddyUp.TestResult', { key: 'test_result_ids' })
});

GiddyUp.TestResult = DS.Model.extend({
  test: DS.attr('string'),
  platform: DS.attr('string'),
  status: DS.attr('boolean'),
  log_url: DS.attr('string')
});
