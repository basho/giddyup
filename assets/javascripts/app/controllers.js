/* global $ */
require('matrix');
require('progress');
require('dropdown');

GiddyUp.ApplicationController = Ember.Controller.extend({
  toggleHelp: function(){
    $('#help').fadeToggle(250);
  }
});

GiddyUp.ProjectsController = Ember.ArrayController.extend({
  sortProperties: ['name']
});

GiddyUp.ScorecardsController = GiddyUp.MatrixController.extend(
  GiddyUp.ProgressMixin,
  GiddyUp.DropdownMixin,
  {
    dimensions: ['version'],
    orderByProperties: ['name'],
    matrix: function(){
      var index = this._super();
      index.set('sortAscending', false);
      return index;
    }.property('content', 'dimensions', 'dimensionValues')
  }
);

GiddyUp.TestInstancesController = GiddyUp.MatrixController.extend(
  GiddyUp.ProgressMixin,
  {
    dimensions: ['name', 'platform'],
    orderByProperties: ['backend', 'upgradeVersion'],
    itemController: 'test_instance'
  }
);

GiddyUp.TestInstanceController = Ember.ObjectController.extend({
  testResults: function(){
    return GiddyUp.TestResultsController.create({
      content: this.get('content.testResults')
    });
  }.property('content.testResults'),

  status: function(){
    var length = this.get('content.testResults.length'),
        isLoaded = this.get('content.testResults').everyProperty('isLoaded'),
        latestStatus = this.get('testResults.firstObject.status');
    if(length === 0){
      return null;
    } else if(isLoaded === true){
      return latestStatus;
    } else {
      return undefined;
    }
  }.property('content.testResults.length',
             'content.testResults.@each.isLoaded',
             'testResults.firstObject.status'),

  descriptor: function(){
    var name = this.get('name'),
        platform = this.get('platform'),
        backend = this.get('backend'),
        version = this.get('upgradeVersion'),
        desc = [];

    if(name) desc.push(name);
    if(platform) desc.push(platform);
    if(backend) desc.push(backend);
    if(version) desc.push(version);
    return desc.join(" / ");
  }.property('name', 'platform', 'backend', 'upgradeVersion')
});

GiddyUp.TestResultsController = Ember.ArrayController.extend({
  sortProperties: ['createdAt'],
  sortAscending: false
});

GiddyUp.ArtifactsController = Ember.ArrayController.extend(GiddyUp.ProgressMixin,
{
  sortProperties: ['id']
});

GiddyUp.ArtifactController = Ember.ObjectController.extend({
});
