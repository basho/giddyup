GiddyUp.Project = DS.Model.extend({
  name: DS.attr('string'),
  scorecards: DS.hasMany('GiddyUp.Scorecard')
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('GiddyUp.Project'),
  test_instances: DS.hasMany('GiddyUp.TestInstance')
});

GiddyUp.Test = DS.Model.extend({
  name: DS.attr('string'),
  tags: DS.attr('hash'),
  platformBinding: 'tags.platform',
  backendBinding: 'tags.backend',
  upgradeVersionBinding: 'tags.upgrade_version'
});

GiddyUp.TestInstanceResults = Ember.ArrayProxy.extend(Ember.SortableMixin, {
  sortProperties: ['created_at'],
  sortAscending: false,

  totalBinding: 'length',
  latestBinding: 'firstObject.success',

  percent: function(){
    var total = this.get('total'),
        succeeded = this.get('arrangedContent').filterProperty('success', true).length;
    if(total === 0){
      return 0.0;
    } else {
      return succeeded / total;
    }
  }.property('total', '@each.success')
});

GiddyUp.TestInstance = DS.Model.extend({
  test: DS.belongsTo('GiddyUp.Test'),
  scorecard: DS.belongsTo('GiddyUp.Scorecard'),
  test_results: DS.hasMany('GiddyUp.TestResult'),
  nameBinding: 'test.name',
  backendBinding: 'test.backend',
  upgradeVersionBinding: 'test.upgradeVersion',
  platformBinding: 'test.platform',
  sortedResults: function(){
    return GiddyUp.TestInstanceResults.create({
      content: this.get('test_results')
    });
  }.property(),
  statusBinding: 'sortedResults',
  // Used for generating a string to put in the URL
  tagString: function(){
    var n = this.get('name'),
        p = this.get('platform'),
        b = this.get('backend'),
        u = this.get('upgradeVersion'),
        result;
    result = n.toString();
    if(p) result += "-" + p;
    if(b) result += "-" + b;
    if(u) result += "-" + u;
    return result;
  }.property('name', 'platform', 'backend', 'upgradeVersion')
});

GiddyUp.TestResult = DS.Model.extend({
  test_instance: DS.belongsTo('GiddyUp.TestInstance'),
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
  platformBinding: 'test_instance.test.platform',
  backendBinding: 'test_instance.test.backend',
  nameBinding: 'test_instance.test.name'
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
