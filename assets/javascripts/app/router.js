GiddyUp.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'projects.index'
    }),

    showProject: Ember.Router.transitionTo('projects.show.index'),

    projects: Ember.Route.extend({
      route: '/projects',

      showScorecard: Ember.Router.transitionTo('projects.show.scorecard.show.index'),

      connectOutlets: function(router) {
        router.get('applicationController').
          connectOutlet('projects', 'projects', GiddyUp.Project.find());
      },

      index: Ember.Route.extend({
        route: '/'
      }),

      show: Ember.Route.extend({
        route: '/:project_id',

        connectOutlets: function(router, context) {
          router.get('projectsController').set('selectedItem', context);
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

            showTestResults: Ember.Router.transitionTo('projects.show.scorecard.show.test_results.index'),
            showTestResult: Ember.Router.transitionTo('projects.show.scorecard.show.test_results.show'),

            connectOutlets: function(router, context) {
              router.get('scorecardsController').set('selectedItem', context);
              router.get('applicationController').
                connectOutlet('scorecard','scorecard', context);
            },

            exit: function(router) {
              router.get('applicationController').disconnectOutlet('scorecard');
            },

            index: Ember.Route.extend({
              route: '/'
            }),

            test_results: Ember.Route.extend({
              route: '/test_results/:platform/:test/:backend',

              connectOutlets: function(router, context) {
                router.get('applicationController').
                  connectOutlet('testResults','testResults', context);
              },

              exit: function(router) {
                router.get('applicationController').disconnectOutlet('testResults');
              },

              serialize: function(router, context) {
                if(context) {
                  return {
                    platform: context.get('test.platform'),
                    test: context.get('test.name'),
                    backend: context.get('test.backend')
                  };
                } else {
                  return {};
                }
              },

              deserialize: function(router, params) {
                var scorecardController = router.get('scorecardController');

                return GiddyUp.ScorecardSubcellRouterProxy.create({
                  test: {
                    platform: params.platform,
                    name: params.test,
                    backend: params.backend
                  },
                  scorecard: scorecardController
                });
              },

              index: Ember.Route.extend({
                route: '/'
              }),

              show: Ember.Route.extend({
                route: '/:test_result_id',

                connectOutlets: function(router, context) {
                  router.get('testResultsController').
                    connectOutlet('testResult','testResult', GiddyUp.Log.find(context.get('id')));
                },

                exit: function(router) {
                  router.get('testResultsController').disconnectOutlet('testResult');
                }
              })
            })
          })
        })
      })
    })
  })
});
