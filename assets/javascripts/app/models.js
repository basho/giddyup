/* global $ */
GiddyUp.Project = DS.Model.extend({
  name: DS.attr('string'),
  scorecards: DS.hasMany({async: true})
});

GiddyUp.Scorecard = DS.Model.extend({
  name: DS.attr('string'),
  project: DS.belongsTo('project'),
  testInstances: DS.hasMany({async: true}),
  version: function(){
    var name = this.get('name'),
        num_version = /\d+(?:\.\d+)+/.exec(name);

    if(num_version === undefined || num_version === null){
      return name;
    } else {
      num_version = num_version[0];
      digits = num_version.split('.');
      for(var i = 0; i < (3 - digits.length); i++){
          num_version += ".0";
      }
      return num_version;
    }
  }.property('name')
});

GiddyUp.TestInstance = DS.Model.extend({
  scorecard: DS.belongsTo('scorecard', {async: true}),
  testResults: DS.hasMany({async: true}),
  name: DS.attr('string'),
  platform: DS.attr('string'),
  backend: DS.attr('string'),
  upgradeVersion: DS.attr('string')
});

GiddyUp.TestResult = DS.Model.extend({
  testInstance: DS.belongsTo('test_instance', {async: true}),
  artifacts: DS.hasMany({async: true}),
  status: DS.attr('boolean'),
  logUrl: DS.attr('string'),
  createdAt: DS.attr('date'),
  longVersion: DS.attr('string')
});

GiddyUp.Artifact = DS.Model.extend({
  url: DS.attr('string'),
  contentType: DS.attr('string'),
  testResult: DS.belongsTo('test_result', {async: true}),
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
