GiddyUp.Store = DS.Store.extend({
  revision: 12,
  adapter: 'GiddyUp.Adapter'
});

GiddyUp.Adapter.configure('GiddyUp.Project', {
  primaryKey: 'name'
});

GiddyUp.Adapter.configure('GiddyUp.Scorecard', {
  project: { key: 'project' }
});
