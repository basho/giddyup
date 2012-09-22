GiddyUp.ApplicationView = Ember.View.extend({
  templateName: 'application'
});

GiddyUp.ProjectsView = Ember.View.extend({
  templateName: 'projects'
});

GiddyUp.ScorecardsView = Ember.View.extend({
  templateName: 'scorecards'
});

GiddyUp.ProjectView = Ember.View.extend({
  templateName: 'project'
});

GiddyUp.ScorecardView = Ember.View.extend({
  templateName: 'scorecard'
});

GiddyUp.ScorecardSubcellView = Ember.View.extend({
  tagName: 'span',
  labelClass: 'badge',
  classNameBindings: ['labelClass', 'statusClass'],
  statusClass: function(){
    var status = this.getPath('content.status');
    if(status.total === 0)
      return '';
    else if(status.passing === status.total)
      return 'badge-success';
    else if(status.failing === status.total)
      return 'badge-important';
    else
      return 'badge-warning';
  }.property().volatile(),
  percent: function(){
    var status = this.getPath('content.status');
    return status.percent.toFixed(1).toString() + "%";
  }.property().volatile(),
  backendAbbr: function(){
    var backend = this.getPath('content.test.backend');
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
      return null;
    }
  }.property()
});
