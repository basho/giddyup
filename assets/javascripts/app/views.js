GiddyUp.ApplicationView = Ember.View.extend({
  templateName: 'application'
});

GiddyUp.ProjectsView = Ember.View.extend({
  templateName: 'projects',
  isLoadedBinding: 'controller.@each.isLoaded'
});

GiddyUp.ScorecardsView = Ember.View.extend({
  templateName: 'scorecards',
  isLoadedBinding: 'controller.content.isLoaded'
});

GiddyUp.ScorecardView = Ember.View.extend({
  templateName: 'scorecard',
  isLoaded: function(){
    var result = this.get('controller.content.isLoaded') &&
      this.get('controller.content.test_results').getEach('isLoaded').
      every(function(l){ return l; });
    return result;
  }.property('controller.content.isLoaded',
             'controller.content.test_results.@each.isLoaded')
});

GiddyUp.TestResultsView = Ember.View.extend({
  templateName: 'test_results'
});

GiddyUp.TestResultView = Ember.View.extend({
  templateName: 'test_result'
});

GiddyUp.ScorecardSubcellView = Ember.View.extend({
  tagName: 'span',
  labelClass: 'badge',
  classNameBindings: ['labelClass', 'statusClass'],
  attributeBindings: ['title'],
  titleBinding: 'percent',
  statusClass: function(){
    var status = this.get('content.status');
    if(status.total === 0)
      return '';
    else if(status.passing === status.total)
      return 'badge-success';
    else if(status.failing === status.total)
      return 'badge-important';
    else
      return 'badge-warning';
  }.property('content.status'),
  percent: function(){
    var status = this.get('content.status');
    return status.percent.toFixed(1).toString() + "%";
  }.property('content.status'),
  backendAbbr: function(){
    var backend = this.get('content.test.backend');
    switch(backend){
    case 'bitcask':
      return 'B';
      break;
    case 'eleveldb':
      return 'L';
      break;
    case 'memory':
      return 'M';
      break;
    default:
      return 'U';
    }
  }.property('content.test.backend')
});
