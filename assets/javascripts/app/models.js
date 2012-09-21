// Hack to allow the 'tags' field on Test, which is an hstore column
// in postgresql.
DS.attr.transforms.hash = {
  from: function(serialized) {
    return Ember.none(serialized) ? null : serialized;
  },
  to: function(deserialized) {
    return Ember.none(deserialized) ? null : deserialized;
  }
}

GiddyUp.Project = DS.Model.extend({
  primaryKey: 'name',
  name: DS.attr('string'),
  tests: DS.hasMany('GiddyUp.Test', { embedded: true }),
  scorecards: DS.hasMany('GiddyUp.Scorecard', { key: 'scorecard_ids' })
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('GiddyUp.Project', {key: 'project'}),
  test_results: DS.hasMany('GiddyUp.TestResult', { key: 'test_result_ids' })
});

GiddyUp.TestResult = DS.Model.extend({
  test: function(){
    var id = this.get('test_id');
    if(Ember.none(id)){
      return null;
    }
    var test = this.getPath('scorecard.project.tests').findProperty('id', id);
    console.log("TEST matchup: "+id+":"+test.get('id'));
    return test;
  }.property('test_id').cacheable(),
  test_id: DS.attr('number'),
  scorecard: DS.belongsTo('GiddyUp.Scorecard'),
  status: DS.attr('boolean'),
  log_url: DS.attr('string'),
  created_at: DS.attr('date')
});

GiddyUp.Test = DS.Model.extend({
  name: DS.attr('string'),
  tags: DS.attr('hash')
});
