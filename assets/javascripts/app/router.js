GiddyUp.Router.map(function(){
  //  /
  //      Redirects to /projects
  //  /projects
  //      The "root"
  this.resource('projects', function(){
  //  /projects/:project_id
  //      Display scorecards, highlight selected project
    this.resource('project', { path: ':project_id' }, function(){
  //  /projects/:project_id/scorecards/:scorecard_id
  //      Load tests in matrix, display matrix, lazy-load results
      this.resource('scorecard', { path: 'scorecards/:scorecard_id' }, function(){
  //  /projects/:project_id/scorecards/:scorecard_id/:test_instance_id
  //      Display results for a bubble
        this.resource('test_instance', { path: ':test_instance_id' }, function(){
  //  /projects/:project_id/scorecards/:scorecard_id/:test_instance_id/:test_result_id
  //      Display an individual test result
          this.resource('test_result', { path: ':test_result_id' });
        });
      });
   });
  });
  //  /logs/:test_result_id
  //      Display the log of a test result in the full window
  this.resource('log', {path: '/logs/:test_result_id' });
});

GiddyUp.IndexRoute = Ember.Route.extend({
  redirect: function(){
    this.transitionTo('projects');
  }
});

GiddyUp.ProjectsRoute = Ember.Route.extend({
  model: function(){
    return GiddyUp.Project.find();
  }
});

GiddyUp.ProjectsIndexRoute = Ember.Route.extend({
  setupController: function(){
    this.controllerFor('projects').set('selectedItem', null);
  }
});

GiddyUp.ProjectRoute = Ember.Route.extend({
  model: function(params){
    return GiddyUp.Project.find(params.project_id);
  },
  setupController: function(controller, model){
    var scorecards = this.controllerFor('scorecards'),
        projects = this.controllerFor('projects');

    this._super(controller, model);

    projects.set('selectedItem', model);
    scorecards.set('model', model.get('scorecards'));
    scorecards.set('selectedItem', null);
  }
});

GiddyUp.ScorecardRoute = Ember.Route.extend({
  model: function(params){
    return GiddyUp.Scorecard.find(params.scorecard_id);
  },
  setupController: function(controller, model){
    var testInstances = this.controllerFor('test_instances'),
        scorecards = this.controllerFor('scorecards');
    this._super(controller, model);

    scorecards.set('selectedItem', model);
    testInstances.set('model', model.get('test_instances'));
  }
});
