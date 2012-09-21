GiddyUp.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'projects.index'
    }),

    showProject: Ember.Router.transitionTo('projects.show'),
    showScorecard: Ember.Router.transitionTo('projects.show.scorecard'),

    projects: Ember.Route.extend({
      route: '/projects',

      connectOutlets: function(router) {
        router.get('applicationController').connectOutlet({name:'projects',
                                                           outletName:'projects',
                                                           context: GiddyUp.Project.find()});
      },

      index: Ember.Route.extend({
        route: '/'
      }),

      show: Ember.Route.extend({
        route: '/:project_id',

        connectOutlets: function(router, context) {
          context.set('isActive', true);
          router.get('applicationController').connectOutlet({outletName:'scorecards',
                                                             name:'scorecards',
                                                             context: context.get('scorecards')});
        },
        exit: function(router) {
          GiddyUp.Project.find().setEach('isActive', false);
          router.get('applicationController').set('scorecards', null);
        },

        scorecard: Ember.Route.extend({
          route: '/scorecards/:scorecard_id',
          connectOutlets: function(router, context) {
            context.set('isActive', true);
            router.get('applicationController').connectOutlet({outletName:'testResults',
                                                               name:'testResults',
                                                               context: context.get('test_results')})
          },
          exit: function(router) {
            router.get('applicationController').set('testResults', null);
            GiddyUp.Scorecard.find().setEach('isActive', false);
          }
        })
      })
    })
  })
});
