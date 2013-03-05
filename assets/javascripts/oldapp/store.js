GiddyUp.adapter = GiddyUp.Adapter.create();

GiddyUp.Store = DS.Store.extend({
  revision: 10,
  adapter: GiddyUp.adapter
});

GiddyUp.store = GiddyUp.Store.create();
