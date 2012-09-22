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
  tests: DS.hasMany('GiddyUp.Test', { embedded: true }),
  scorecards: DS.hasMany('GiddyUp.Scorecard', { key: 'scorecard_ids' }),
  platforms: function(){
    return this.get('tests').getEach('platform').sort().uniq();
  }.property('tests').cacheable(),
  testNames: function(){
    return this.get('tests').getEach('name').sort().uniq();
  }.property('tests').cacheable()
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('GiddyUp.Project', {key: 'project'}),
  test_results: DS.hasMany('GiddyUp.TestResult', { key: 'test_result_ids' }),
  cells: function(){
    var scorecard = this;
    var platforms = this.get('project').get('platforms');
    var testNames = this.get('project').get('testNames');
    return testNames.map(function(name){
      return platforms.map(function(platform){
        return GiddyUp.ScorecardCell.create({
          platform: platform,
          name: name,
          scorecard: scorecard
        });
      });
    })
  }.property().cacheable()
});

GiddyUp.TestResult = DS.Model.extend({
  test: function(){
    var id = this.get('test_id');
    if(Ember.none(id)){
      return null;
    }
    return this.getPath('scorecard.project.tests').findProperty('id', id);
  }.property('test_id').cacheable(),
  test_id: DS.attr('number'),
  scorecard: DS.belongsTo('GiddyUp.Scorecard'),
  status: DS.attr('boolean'),
  log_url: DS.attr('string'),
  created_at: DS.attr('date'),
  platformBinding: 'test.platform',
  backendBinding: 'test.backend',
  nameBinding: 'test.name'
});

GiddyUp.Test = DS.Model.extend({
  name: DS.attr('string'),
  tags: DS.attr('hash'),
  platform: function(){ return this.get('tags').platform; }.property('tags').cacheable(),
  backend: function(){ return this.get('tags').backend; }.property('tags').cacheable()
});

GiddyUp.ScorecardCell = Ember.Object.extend({
  platform: null, // from the platform tag on the test
  name: null, // from the test name
  scorecard: null, // the scorecard
  subcells: function(){
    var name = this.get('name');
    var platform = this.get('platform');
    var scorecard = this.get('scorecard');
    var cell = this;
    var tests = scorecard.getPath('project.tests').filter(function(test){
      return test.get('name') === name && test.get('platform') === platform;
    });
    return tests.map(function(test){
      return GiddyUp.ScorecardSubcell.create({
        cell: cell,
        scorecard: scorecard,
        test: test
      });
    });
  }.property().cacheable()
});

GiddyUp.ScorecardSubcell = Ember.Object.extend({
  cell: null,
  scorecard: null,
  test: null,
  test_results: function(){
    var id = this.getPath('test.id');
    var results = this.getPath('scorecard.test_results').filterProperty('test_id', id);
    if(this.getPath('cell.platform') === 'smartos-64')
      console.log(this.getPath('cell.name') + '/' +
                  this.getPath('cell.platform') + '/'
                  + id + ':'
                  + results.length);
    return results;
  }.property('scorecard.test_results.@each.isLoaded'),
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
