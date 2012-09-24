GiddyUp.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'projects.index'
    }),

    showProject: Ember.Router.transitionTo('projects.show.index'),
    showScorecard: Ember.Router.transitionTo('projects.show.scorecard.show'),

    projects: Ember.Route.extend({
      route: '/projects',

      connectOutlets: function(router) {
        router.get('applicationController').connectOutlet('projects', 'projects', GiddyUp.Project.find());
      },

      index: Ember.Route.extend({
        route: '/'
      }),

      show: Ember.Route.extend({
        route: '/:project_id',

        connectOutlets: function(router, context) {
          router.get('applicationController').
            connectOutlet('scorecards', 'scorecards', context.get('scorecards'));
        },

        exit: function(router){
          if(!Ember.none(router.get('applicationController.scorecards'))){
            router.get('applicationController').disconnectOutlet('scorecards');
          }
        },

        index: Ember.Route.extend({ route: '/' }),

        scorecard: Ember.Route.extend({
          route: '/scorecards',

          index: Ember.Route.extend({ route: '/' }),

          show: Ember.Route.extend({
            route: '/:scorecard_id',

            connectOutlets: function(router, context) {
              // console.log(context);
              router.get('applicationController').connectOutlet('scorecard','scorecard', context);
            },

            exit: function(router){
              if(!Ember.none(router.get('applicationController.scorecard'))){
                router.get('applicationController').disconnectOutlet('scorecard');
              }
            }
          })
        })
      })
    })
  })
});
