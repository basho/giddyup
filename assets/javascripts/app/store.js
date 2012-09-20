GiddyUp.Adapter = DS.RESTAdapter.extend();

GiddyUp.Store = DS.Store.extend({
  revision: 4,
  adapter: GiddyUp.Adapter.create()
});

GiddyUp.store = GiddyUp.Store.create();
