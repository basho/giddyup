// View mixin that does Bootstrap-style selection marking.
GiddyUp.Selectable = Ember.Mixin.create({
  tagName: 'li',
  classNameBindings: ['isActive:active'],

  isActive: function() {
    return this.get('controller.selectedItem') === this.get('content');
  }.property('controller.selectedItem')
});
