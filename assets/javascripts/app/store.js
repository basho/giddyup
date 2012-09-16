GiddyUp.Adapter = DS.RESTAdapter.extend({
  findAll: function() { },
  find: function() { }
});

GiddyUp.Store = DS.Store.extend({
  revision: 4,
  adapter: GiddyUp.Adapter.create()
});

GiddyUp.store = GiddyUp.Store.create();
