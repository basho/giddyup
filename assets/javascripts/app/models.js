// Hack to allow the 'tags' field on Test, which is an hstore column
// in postgresql.
DS.attr.transforms.hash = {
  from: function(serialized) {
    return Ember.none(serialized) ? null : serialized;
  },
  to: function(deserialized) {
    return Ember.none(deserialized) ? null : deserialized;
  }
};

GiddyUp.Project = DS.Model.extend({
  primaryKey: 'name',
  name: DS.attr('string'),
  scorecards: DS.hasMany('GiddyUp.Scorecard', { key: 'scorecard_ids' })
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('GiddyUp.Project', { key: 'project' }),
  test_results: DS.hasMany('GiddyUp.TestResult', { key: 'test_result_ids' }),
  tests: DS.hasMany('GiddyUp.Test', { embedded: true }),
  cells: function(){
    if(!this.get('project.isLoaded')){
      return [];
    }
    var scorecard = this;
    var platforms = this.get('platforms');
    var testNames = this.get('testNames');
    return testNames.map(function(name){
      return platforms.map(function(platform){
        return GiddyUp.ScorecardCell.create({
          platform: platform,
          name: name,
          scorecard: scorecard
        });
      });
    })
  }.property('project.isLoaded'),
  platforms: function(){
    return this.get('tests').getEach('platform').sort().uniq();
  }.property('tests').cacheable(),
  testNames: function(){
    return this.get('tests').getEach('name').sort().uniq();
  }.property('tests').cacheable()
});

GiddyUp.TestResult = DS.Model.extend({
  test: function(){
    var id = this.get('test_id');
    var tests;

    if(Ember.none(id)){
      return null;
    }

    tests = this.get('scorecard.tests');

    if(tests) {
      return tests.findProperty('id', id);
    } else {
      return [];
    }
  }.property('test_id').cacheable(),

  test_id: DS.attr('number'),
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
  platform: function(){ return this.get('tags.platform'); }.property('tags'),
  backend: function(){ return this.get('tags.backend'); }.property('tags'),
  upgrade_version: function(){
    return this.get('tags.upgrade_version')
  }.property('tags')
});

GiddyUp.Log = DS.Model.extend({
  body: DS.attr('string'),

  directPath: function() {
    var router = GiddyUp.get('router');
    return router.urlForEvent('showLog', this);
  }.property()
});

var propertyComparator = function() {
  var fields = arguments;
  return function(a,b){
    for(i = 0; i < fields.length; i++){
      var field = fields[i];
      var av = a.get(field);
      var bv = b.get(field);
      if(av < bv) return -1;
      if(bv < av) return 1;
    }
    return 0;
  }
};

GiddyUp.ScorecardCell = Ember.Object.extend({
  platform: null, // from the platform tag on the test
  name: null, // from the test name
  scorecard: null, // the scorecard
  isLoadedBinding: 'scorecard.test_results.@each.isLoaded',
  subcells: function(){
    if(!this.get('isLoaded'))
      return [];
    var name = this.get('name');
    var platform = this.get('platform');
    var scorecard = this.get('scorecard');
    var cell = this;
    var tests = scorecard.get('tests').filter(function(test){
      return test.get('name') === name && test.get('platform') === platform;
    }).sort(propertyComparator('backend', 'upgrade_version'));
    return tests.map(function(test){
      return GiddyUp.ScorecardSubcell.create({
        cell: cell,
        scorecard: scorecard,
        test: test
      });
    });
  }.property('isLoaded')
});

GiddyUp.ScorecardSubcellStatus = Ember.Object.extend({
  subcell: null,

  total: function(){
    return this.get('subcell.test_results').length;
  }.property('subcell.test_results'),

  numPassing: function(){
    return this.get('subcell.test_results').
      filterProperty('status',true).length;
  }.property('subcell.test_results.@each.status'),

  numFailing: function(){
    return this.get('total') - this.get('numPassing');
  }.property('total', 'numPassing'),

  percent: function(){
    if(this.get('total') === 0)
      return 0.0;
    else
      return (this.get('numPassing') / this.get('total')) * 100;
  }.property('total', 'numPassing'),

  latestBinding: 'subcell.test_results.firstObject.status'
});

GiddyUp.ScorecardSubcell = Ember.Object.extend({
  cell: null,
  scorecard: null,
  test: null,
  test_results: function(){
    var id = this.get('test.id');
    var results = this.get('scorecard.test_results');
    var filteredResults = results.filterProperty('test_id', id);
    var sortedResults = filteredResults.sort(function(a,b){
      at = a.get('created_at')
      bt = b.get('created_at')
      return (at < bt) ? -1 : ((bt < at) ? 1 : 0);
    }).reverse(); // Sort in reverse order by created_at timestamp
    return sortedResults;
  }.property('scorecard.test_results.isLoaded', 'scorecard.test_results.@each.isLoaded'),
  status: function(){
    return GiddyUp.ScorecardSubcellStatus.create({subcell: this});
  }.property()
});

GiddyUp.ScorecardSubcellRouterProxy = Ember.Object.extend({
  test_results: function() {
    var name = this.get('test.name');
    var backend = this.get('test.backend');
    var platform = this.get('test.platform');
    var tests = this.get('scorecard.tests');

    var selectedTest;
    var selectedResults;

    if(tests) {
      selectedTest = tests.find(function(test){
        if(test.get('backend')) {
          return test.get('name') === name &&
                 test.get('platform') === platform &&
                 test.get('backend') === backend;
        } else {
          return test.get('name') === name &&
                 test.get('platform') === platform;
        }
      });

      selectedResults = this.get('scorecard.test_results').filter(function(test_result) {
        return test_result.get('test') == selectedTest;
      });

      return selectedResults;
    } else {
      return [];
    }
  }.property('scorecard.test_results.isLoaded', 'scorecard.test_results.@each.isLoaded')
});
