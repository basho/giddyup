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
    var length = this.get('content.testResults.length'),
        isLoaded = this.get('content.testResults').everyProperty('isLoaded'),
        latestStatus = this.get('content.testResults.lastObject.status');
    if(length === 0){
      return null;
    } else if(isLoaded === true){
      return latestStatus;
    } else {
      return undefined;
    }
  }.property('content.testResults.length',
             'content.testResults.@each.isLoaded',
             'content.testResults.lastObject.status')
});

GiddyUp.TestResultsController = Ember.ArrayController.extend({
  sortProperties: ['createdAt'],
  sortAscending: false
});
