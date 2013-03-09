GiddyUp.Store = DS.Store.extend({
  revision: 12
});

DS.RESTAdapter.configure('GiddyUp.Project', {
  primaryKey: 'name'
});

DS.RESTAdapter.configure('GiddyUp.Scorecard', {
  project: { key: 'project' }
});
