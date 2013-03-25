GiddyUp.Project = DS.Model.extend({
  name: DS.attr('string'),
  scorecards: DS.hasMany('GiddyUp.Scorecard')
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('GiddyUp.Project'),
  testInstances: DS.hasMany('GiddyUp.TestInstance')
});

GiddyUp.TestInstance = DS.Model.extend({
  scorecard: DS.belongsTo('GiddyUp.Scorecard'),
  testResults: DS.hasMany('GiddyUp.TestResult'),
  name: DS.attr('string'),
  platform: DS.attr('string'),
  backend: DS.attr('string'),
  upgradeVersion: DS.attr('string')
});

GiddyUp.TestResult = DS.Model.extend({
  testInstance: DS.belongsTo('GiddyUp.TestInstance'),
  status: DS.attr('boolean'),
  logUrl: DS.attr('string'),
  // Hack until we can get real artifacts
  log: function(){
    return GiddyUp.Log.find(this.get('id'));
  }.property('id'),
  createdAt: DS.attr('date'),
  longVersion: DS.attr('string')
});

GiddyUp.Log = DS.Model.extend({
  body: DS.attr('string')
});
