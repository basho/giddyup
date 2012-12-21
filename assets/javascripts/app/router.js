GiddyUp.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'projects.index'
    }),

    showProject: Ember.Router.transitionTo('projects.show.index'),
    showLog: Ember.Router.transitionTo('logs.show'),

    logs: Ember.Route.extend({
      route: '/logs',

      connectOutlets: function(router) {
        router.get('applicationController').set('chromeless', true);
      },

      exit: function(router) {
        router.get('applicationController').set('chromeless', false);
      },

      show: Ember.Route.extend({
        route: '/:log_id',

        connectOutlets: function(router, context) {
          router.get('applicationController').connectOutlet('log', 'log', context);
        }
      })
    }),

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
            router.get('projectsController').set('selectedItem', undefined);
            router.get('applicationController').disconnectOutlet('scorecards');
          }
        },

        index: Ember.Route.extend({ route: '/' }),

        scorecard: Ember.Route.extend({
          route: '/scorecards',

          index: Ember.Route.extend({ route: '/' }),

          show: Ember.Route.extend({
            route: '/:scorecard_id',

            showTestInstance: Ember.Router.transitionTo('projects.show.scorecard.show.testInstance.show'),

            connectOutlets: function(router, context) {
              router.get('scorecardsController').set('selectedItem', context);
              router.get('applicationController').
                connectOutlet('testInstances', 'testInstances', context.get('test_instances'));
            },

            exit: function(router) {
              router.get('scorecardsController').set('selectedItem', undefined);
              router.get('applicationController').disconnectOutlet('testInstances');
            },

            index: Ember.Route.extend({
              route: '/'
            }),

            testInstance: Ember.Route.extend({
              route: '/:test_instance_id',

              serialize: function(router, context) {
                var components = [context.get('id')],
                    tag = context.get('tagString');

                if(tag) components.push(tag);

                return { test_instance_id: components.join('-') };
              },

              deserialize: function(router, params){
                var tagString = params.test_instance_id,
                    id;
                id = tagString.split('-').slice(0,2).join('-');
                return GiddyUp.TestInstance.find(id);
              },

              showTestResult: Ember.Router.transitionTo('projects.show.scorecard.show.testInstance.result'),

              connectOutlets: function(router, context){
                router.get('applicationController').
                  connectOutlet('testInstance', 'testInstance', context);
                router.get('testInstanceController').
                  connectOutlet('testResults', 'testResults', context.get('test_results'));
              },

              exit: function(router){
                router.get('testInstanceController').disconnectOutlet('testResults');
                router.get('applicationController').disconnectOutlet('testInstance');
              },

              show: Ember.Route.extend({ route: '/' }),

              result: Ember.Route.extend({
                route: '/:test_result_id',

                connectOutlets: function(router, context){
                  router.get('testResultsController').set('selectedItem', context);
                  router.get('testInstanceController').
                    connectOutlet('testResult', 'testResult', context.get('log'));
                },

                exit: function(router) {
                  router.get('testResultsController').set('selectedItem', undefined);
                  router.get('testInstanceController').disconnectOutlet('testResult');
                },
              })
            })
          })
        })
      })
    })
  })
});
