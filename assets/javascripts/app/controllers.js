require('matrix');

GiddyUp.ProjectsController = Ember.ArrayController.extend({
  sortProperties: ['name']
});

GiddyUp.ScorecardsController = Ember.ArrayController.extend({
  sortProperties: ['name'],
  sortAscending: false
});

GiddyUp.TestInstancesController = GiddyUp.MatrixController.extend({
  itemController: 'testInstance',
  dimensions: ['name', 'platform'],
  orderByProperties: ['backend', 'upgradeVersion'],

  isLoaded: function(){
    return this.everyProperty('isLoaded', true);
  }.property('@each.isLoaded')
});

GiddyUp.TestInstanceController = Ember.ObjectController.extend({
  resultsLoaded: function(){
    return this.get('testResults').everyProperty('isLoaded', true);
  }.property('testResults.@each.isLoaded')
});
