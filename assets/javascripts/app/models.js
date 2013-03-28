/* global $ */
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
  artifacts: DS.hasMany('GiddyUp.Artifact'),
  status: DS.attr('boolean'),
  logUrl: DS.attr('string'),
  createdAt: DS.attr('date'),
  longVersion: DS.attr('string')
});

GiddyUp.Artifact = DS.Model.extend({
  url: DS.attr('string'),
  contentType: DS.attr('string'),
  testResult: DS.belongsTo('GiddyUp.TestResult'),
  text: function(){
    var url = this.get('url'),
        ctype = this.get('contentType'),
        id = this.get('id');

    if(Ember.isNone(ctype) || Ember.isNone(url) || !ctype.match(/^text/))
      return '';

    // l33t h4x - avert thine eyes
    var adapter = GiddyUp.__container__.lookup('store:main').get('_adapter'),
        root = adapter.rootForType(GiddyUp.Artifact);

    url = adapter.buildURL(root, id);

    $.ajax(url, {
      cache: false,
      accepts: {'text': ctype},
      context: this,
      dataType: 'text',
      success: function(data){
        this.set('text', data);
      },
      error: function(){
        this.set('text', 'Could not load the log the GiddyUp server!');
      }
    });
    return 'Loading...';
  }.property('url', 'contentType')
});
