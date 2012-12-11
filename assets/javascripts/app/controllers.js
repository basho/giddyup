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
  sortProperties: ['name', 'platform', 'backend'],
  objectAtContent: function(index){
    return GiddyUp.TestController.create({
      scorecard: this.get('scorecard'),
      content: this.get('arrangedContent').objectAt(index)
    });
  }
});

GiddyUp.TestController = Ember.ObjectController.extend({
  scorecard: null,

  test_results: function(){
    return GiddyUp.TestResultsController.create({
      test: this.get('content'),
      scorecard: this.get('scorecard')
    });
  }.property('content', 'scorecard'),

  status: function(){
    return GiddyUp.TestStatus.create({test: this});
  }.property()
});

GiddyUp.TestStatus = Ember.Object.extend({
  totalBinding: 'test.test_results.length',
  latestBinding: 'test.test_results.firstObject.success',

  percent: function(){
    var total = this.get('total'),
        succeeded = this.get('test.test_results').filterProperty('success', true).length;
    if(total === 0){
      return 0.0;
    } else {
      return succeeded / total;
    }
  }.property('total', 'test.test_results.@each.success')
});

GiddyUp.TestResultsController = Ember.ArrayController.extend({
  test: null,
  scorecard: null,

  content: function(){
    var test = this.get('test'),
        scorecard = this.get('scorecard');

    return GiddyUp.TestResult.filter(function(result){
      return result.get('test') === test &&
        result.get('scorecard') === scorecard;
    });
  }.property('test', 'scorecard'),
  sortProperties: ['created_at'],
  sortAscending: false
});

GiddyUp.TestResultController = Ember.ObjectController.extend();

GiddyUp.LogController = Ember.ObjectController.extend();
