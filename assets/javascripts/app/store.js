GiddyUp.serializer = DS.JSONSerializer.create();

GiddyUp.serializer.registerTransform('hash', {
  deserialize: function(serialized) {
    return Ember.none(serialized) ? null : serialized;
  },

  serialize: function(deserialized) {
    return Ember.none(deserialized) ? null : deserialized;
  }
});

GiddyUp.adapter = GiddyUp.Adapter.create();

GiddyUp.Store = DS.Store.extend({
  revision: 10,
  adapter: GiddyUp.adapter,
  serializer: GiddyUp.serializer
});

GiddyUp.store = GiddyUp.Store.create();
