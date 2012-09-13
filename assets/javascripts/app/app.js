GiddyUp = Ember.Application.create({
  ready: Ember.alias('initialize')
});

require('router');
require('store');

require('models');
require('controllers');
require('templates');
require('views');
