GiddyUp.Store = DS.Store.extend({
  revision: 4,
  adapter: DS.RESTAdapter.create({ namespace: 'api' })
});

GiddyUp.store = GiddyUp.Store.create();
