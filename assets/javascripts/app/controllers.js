GiddyUp.ApplicationController = Ember.Controller.extend();

GiddyUp.ProjectsController = Ember.ArrayController.extend();

GiddyUp.ScorecardsController = Ember.ArrayController.extend();

GiddyUp.ProjectController = Ember.ObjectController.extend();

GiddyUp.ScorecardController = Ember.ObjectController.extend();

GiddyUp.TestInstancesController = Ember.Matrix.Controller.extend({
  dimensions: ['name', 'platform'],
  isLoaded: function() {
    var content = Ember.A(this.get('content'));
    return content.everyProperty('isLoaded', true);
  }.property('content.@each.isLoaded')
});

// GiddyUp.TestInstancesController = Ember.ArrayController.extend({
//   sortProperties: ['name', 'platform', 'backend', 'upgradeVersion']
// });

GiddyUp.TestInstanceController = Ember.ObjectController.extend({});

GiddyUp.TestResultsController = Ember.ArrayController.extend({
  sortProperties: ['created_at'],
  sortAscending: false
});

GiddyUp.TestResultController = Ember.ObjectController.extend();

GiddyUp.LogController = Ember.ObjectController.extend();
