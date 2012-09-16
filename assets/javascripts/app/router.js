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
        router.get('applicationController').connectOutlet('sidebar', 'projects', GiddyUp.Project.find());
      },

      index: Ember.Route.extend({
        route: '/'
      }),

      show: Ember.Route.extend({
        route: '/:project_id',

        connectOutlets: function(router, context) {
          router.get('applicationController').connectOutlet('project', context);
        }
      }),
    })
  })
});
