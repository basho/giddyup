GiddyUp.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'projects.index'
    }),

    showProject: Ember.Router.transitionTo('projects.show'),

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
          router.get('applicationController').connectOutlet('project', context);
        },
        exit: function(router) {
          GiddyUp.Project.find().setEach('isActive', false);
        }
      }),
    })
  })
});
