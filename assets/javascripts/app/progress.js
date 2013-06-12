// Mixin for Ember.ArrayController that supports tracking the loading
// progress of proxied models.
GiddyUp.ProgressMixin = Ember.Mixin.create({
  isLoaded: function(){
    return this.get('content').everyProperty('isLoaded');
  }.property('content', 'content.@each', 'content.@each.isLoaded'),

  progressTotal: Ember.computed.alias('content.length'),

  progressComplete: function(){
    return this.get('content').filterProperty('isLoaded').length;
  }.property('content', 'content.@each.isLoaded'),

  progressPercent: function(){
    var total = this.get('progressTotal'),
        complete = this.get('progressComplete');

    if(total < 1 || !complete)
      return 0.0;
    else
      return (complete / total) * 100.0;
  }.property('progressTotal', 'progressComplete'),

  // TODO: Should this be on a view?
  progressStyle: function(){
    var percent = Math.round(this.get('progressPercent'));
    return "width: " + percent + "%";
  }.property('@each.isLoaded', 'progressPercent'),

  progressMessages: function(){
    var content = this.get('content');
    return GiddyUp.quipsFor(content);
  }.property('content'),

  progressMessage: function(){
    var percent = this.get('progressPercent'),
        quips = this.get('progressMessages');

    var index = Math.floor((percent / 100.0) * (quips.length - 1));
    return quips[index];
  }.property('progressPercent', 'progressMessages')
});
