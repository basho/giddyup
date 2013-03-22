require('selectable');

GiddyUp.ProjectItemView = Ember.View.extend(GiddyUp.Selectable);
GiddyUp.ScorecardItemView = Ember.View.extend(GiddyUp.Selectable);
GiddyUp.HelpView = Ember.View.extend();

GiddyUp.BubbleView = Ember.View.extend({
  tagName: 'div',
  statusClasses: function(){
    var status = this.get('content.status'),
        classes = ['badge'];

    if(status === true) {
      classes.push('badge-success');
    }
    if(status === false) {
      classes.push('badge-important');
    }
    if(status === undefined) {
      classes.push('badge-loading');
    }
    return classes.join(' ');
  }.property('content.status')
});
