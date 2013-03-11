// Mixin for Ember.ArrayController that supports tracking the loading
// progress of proxied models.
GiddyUp.ProgressMixin = Ember.Mixin.create({
  isLoaded: function(){
    if(this.get('length') === 0)
      return false;
    else
      return this.everyProperty('isLoaded');
  }.property('length', '@each.isLoaded'),

  progressTotal: Ember.computed.alias('length'),

  progressComplete: function(){
    return this.filterProperty('isLoaded', true).length;
  }.property('@each.isLoaded'),

  progressPercent: function(){
    var total = this.get('progressTotal'),
        complete = this.get('progressComplete');

    if(total === 0)
      return 0.0;
    else
      return (total / complete) * 100.0;
  }.property('progressTotal', 'progressComplete')
});
