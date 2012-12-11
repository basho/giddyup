GiddyUp.ApplicationController = Ember.Controller.extend();

GiddyUp.ProjectsController = Ember.ArrayController.extend();

GiddyUp.ScorecardsController = Ember.ArrayController.extend();

GiddyUp.ProjectController = Ember.ObjectController.extend();

GiddyUp.ScorecardController = Ember.ObjectController.extend({
  tests: function(){
    return GiddyUp.TestsController.create({
      // content: this.get('content.tests'),
      scorecard: this.get('content')
    });
  }.property('content')
});

GiddyUp.TestsController = Ember.ArrayController.extend({
  scorecard: null, // Set by parent controller
  contentBinding: 'scorecard.tests',
  sortProperties: ['name', 'platform', 'backend']
});

GiddyUp.TestController = Ember.ObjectController.extend({
  scorecard: null,
  test_results: function(){
    return GiddyUp.TestResultsController.create({
      test: this.get('content'),
      scorecard: this.get('scorecard')
    });
  }.property('content.test_results', 'scorecard')
});

GiddyUp.TestResultsController = Ember.ObjectController.extend({
  test: null,
  scorecard: null,

  content: function(){
    var test = this.get('test'),
        scorecard = this.get('scorecard');

    return GiddyUp.TestResult.filter(function(result){
      console.log(result);
      return result.get('test') === test &&
        result.get('scorecard') === scorecard;
    });
  }.property('test', 'scorecard'),
  sortProperties: ['created_at'],
  sortAscending: false
});

GiddyUp.TestResultController = Ember.ObjectController.extend();

GiddyUp.LogController = Ember.ObjectController.extend();
