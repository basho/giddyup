GiddyUp.Store = DS.Store.extend({
  revision: 4,
  adapter: DS.RESTAdapter.create()
});

GiddyUp.store = GiddyUp.Store.create();
