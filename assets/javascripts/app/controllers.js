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
    orderByProperties: ['backend', 'upgradeVersion']
  }
);

GiddyUp.TestResultsController = Ember.ArrayController.extend({
  sortProperties: ['createdAt'],
  sortAscending: false
});
