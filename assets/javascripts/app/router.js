GiddyUp.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'scorecards'
    }),

    scorecards: Ember.Route.extend({
      route: '/scorecards',
      connectOutlets: function(router) {
        router.get('applicationController').connectOutlet('scorecards');
      }
    })
  })
});
