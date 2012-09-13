GiddyUp = Ember.Application.create({
  ready: Ember.alias('initialize')
});

require('router');
require('store');

require('models');
require('controllers');
require('templates');
require('views');

// TODO: Not required by ember-latest.
$(document).ready(function() {
  GiddyUp.initialize(GiddyUp.Router.create());
});
