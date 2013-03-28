require('selectable');

GiddyUp.ProjectItemView = Ember.View.extend(GiddyUp.Selectable);
GiddyUp.ScorecardItemView = Ember.View.extend(GiddyUp.Selectable);
GiddyUp.TestResultItemView = Ember.View.extend(GiddyUp.Selectable);
GiddyUp.ArtifactItemView = Ember.View.extend(GiddyUp.Selectable);
GiddyUp.HelpView = Ember.View.extend();

GiddyUp.ArtifactView = Ember.View.extend({
  classNames: ['span9'],
  templateName: function(){
    var ctype = this.get('controller.contentType'),
        type, major, minor;

    if(Ember.isNone(ctype))
      return 'artifact/download';

    type = ctype.toString().split(";")[0].trim().split("/");
    major = type[0];
    minor = type[1];

    if(major === 'text')
      return 'artifact/text';
    else if (major === 'image')
      return 'artifact/image';
    else
      return 'artifact/download';
  }.property('controller.contentType')
});

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
