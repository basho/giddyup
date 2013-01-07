GiddyUp.Project = DS.Model.extend({
  name: DS.attr('string'),
  scorecards: DS.hasMany('GiddyUp.Scorecard')
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('GiddyUp.Project'),
  test_instances: DS.hasMany('GiddyUp.TestInstance')
});

GiddyUp.TestInstanceStatus = Ember.ArrayProxy.extend(Ember.SortableMixin, {
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
      return (succeeded / total) * 100;
    }
  }.property('total', '@each.success')
});

GiddyUp.TestInstance = DS.Model.extend({
  scorecard: DS.belongsTo('GiddyUp.Scorecard'),
  test_results: DS.hasMany('GiddyUp.TestResult'),
  name: DS.attr('string'),
  platform: DS.attr('string'),
  backend: DS.attr('string'),
  upgradeVersion: DS.attr('string'),
  status: function(){
    return GiddyUp.TestInstanceStatus.create({
      content: this.get('test_results')
    });
  }.property(),
  // Used for generating a string to put in the URL
  tagString: function(){
    var props = this.getProperties(['name', 'platform',
                                    'backend', 'upgradeVersion']);
    var result = [props.name];
    if(props.platform) result.push(props.platform);
    if(props.backend) result.push(props.backend);
    if(props.upgradeVersion) result.push(props.upgradeVersion);
    return result.join("-");
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

  log: function(){
    var id = this.get('id');
    return GiddyUp.Log.find(id);
  }.property(),

  log_url: DS.attr('string'),
  created_at: DS.attr('date'),
  long_version: DS.attr('string'),

  notification: function() {
    var status    = this.get('status') === true ? "pass" : "fail";
    var instance  = this.get('test_instance');
    var scorecard = instance.get('scorecard');
    var project   = scorecard.get('project');
    var backend   = instnace.get('backend') || "undefined";

    return {
      title:   "GiddyUp: New " + status + " on " +
               project.get('name') + " " +
               scorecard.get('name'),
      message: instance.get('name') + " | " +
               instance.get('backend') + " | " +
               instance.get('platform')
    };
  }.property()
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
