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
  platformBinding: 'test.platform',
  backendBinding: 'test.backend',
  nameBinding: 'test.name'
});

GiddyUp.Test = DS.Model.extend({
  name: DS.attr('string'),
  tags: DS.attr('hash'),
  platform: function(){ return this.get('tags.platform'); }.property('tags'),
  backend: function(){ return this.get('tags.backend'); }.property('tags')
});

GiddyUp.Log = DS.Model.extend({
  content: DS.attr('string'),

  directPath: function() {
    var router = GiddyUp.get('router');
    return router.urlForEvent('showLog', this);
  }.property()
});

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
    });
    return tests.map(function(test){
      return GiddyUp.ScorecardSubcell.create({
        cell: cell,
        scorecard: scorecard,
        test: test
      });
    });
  }.property('isLoaded')
});

GiddyUp.ScorecardSubcell = Ember.Object.extend({
  cell: null,
  scorecard: null,
  test: null,
  test_results: function(){
    // if(!this.get('scorecard.test_results.isLoaded'))
    //   return [];
    var id = this.get('test.id');
    var results = this.get('scorecard.test_results');
    var filteredResults = results.filterProperty('test_id', id);
    return filteredResults;
  }.property('scorecard.test_results.isLoaded', 'scorecard.test_results.@each.isLoaded'),
  status: function(){
    var tr = this.get('test_results');
    var total = tr.length;
    var passing = tr.filterProperty('status', true).length;
    return {
      total: total,
      passing: passing,
      failing: total - passing,
      percent: (total === 0) ? 0.0 : (passing / total) * 100
    };
  }.property('test_results')
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
