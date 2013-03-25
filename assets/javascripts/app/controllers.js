/* global $ */
require('matrix');
require('progress');

GiddyUp.ApplicationController = Ember.Controller.extend({
  toggleHelp: function(){
    $('#help').fadeToggle(250);
  }
});

GiddyUp.ProjectsController = Ember.ArrayController.extend({
  sortProperties: ['name']
});

GiddyUp.ScorecardsController = Ember.ArrayController.extend({
  sortProperties: ['name'],
  sortAscending: false
});

GiddyUp.TestInstancesController = GiddyUp.MatrixController.extend(
  GiddyUp.ProgressMixin,
  {
    dimensions: ['name', 'platform'],
    orderByProperties: ['backend', 'upgradeVersion'],
    itemController: 'test_instance'
  }
);

GiddyUp.TestInstanceController = Ember.ObjectController.extend({
  status: function(){
    var length = this.get('testResults.length'),
        isLoaded = this.get('testResults').everyProperty('isLoaded'),
        latestStatus = this.get('testResults.lastObject.status');
    if(length === 0){
      return null;
    } else if(isLoaded === true){
      return latestStatus;
    } else {
      return undefined;
    }
  }.property('testResults.length',
             'testResults.@each.isLoaded',
             'testResults.lastObject.status'),

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
  sortAscending: false,
  itemController: 'test_result'
});

GiddyUp.TestResultController = Ember.ObjectController.extend({

});
