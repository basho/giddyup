GiddyUp.Project = DS.Model.extend({
  name: DS.attr('string'),
  scorecards: DS.hasMany('GiddyUp.Scorecard')
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('GiddyUp.Project'),
  test_results: DS.hasMany('GiddyUp.TestResult'),
  tests: DS.hasMany('GiddyUp.Test')
});

GiddyUp.TestResult = DS.Model.extend({
  test: DS.belongsTo('GiddyUp.Test'),
  scorecard: DS.belongsTo('GiddyUp.Scorecard'),

  status: DS.attr('boolean'),

  success: function() {
    return this.get('status') === true;
  }.property('status'),

  failure: function() {
    return this.get('status') === false;
  }.property('status'),

  log_url: DS.attr('string'),
  created_at: DS.attr('date'),
  long_version: DS.attr('string'),
  platformBinding: 'test.platform',
  backendBinding: 'test.backend',
  nameBinding: 'test.name'
});

GiddyUp.Test = DS.Model.extend({
  name: DS.attr('string'),
  tags: DS.attr('hash'),
  test_results: DS.hasMany('GiddyUp.TestResult'),
  platformBinding: 'tags.platform',
  backendBinding: 'tags.backend',
  upgradeVersionBinding: 'tags.upgrade_version'
});

GiddyUp.Log = DS.Model.extend({
  body: DS.attr('string'),

  directPath: function() {
    var router = GiddyUp.get('router');
    return router.urlForEvent('showLog', this);
  }.property()
});

// Immutability!
GiddyUp.TestResult.immutable = GiddyUp.Log.immutable = true;
