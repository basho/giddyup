GiddyUp.serializer = DS.RESTSerializer.create({
  keyForHasMany: function(type, name){
    return name.match(/^(.*)s$/)[1]+'_ids';
  }
});

GiddyUp.serializer.registerTransform('hash', {
  deserialize: function(serialized) {
    return Ember.isNone(serialized) ? null : serialized;
  },

  serialize: function(deserialized) {
    return Ember.isNone(deserialized) ? null : deserialized;
  }
});

GiddyUp.Adapter = DS.RESTAdapter.extend({
  serializer: GiddyUp.serializer,
  fetchBatchSize: 50,

  didFindMany: function(store, type, json) {
    var root = this.pluralize(this.rootForType(type));

    this.sideload(store, type, json, root);
    store.loadMany(type, json[root]);
  },

  findMany: function(store, type, ids) {
    var root = this.rootForType(type),
    batchSize = Ember.get(this, 'fetchBatchSize', ids.length),
    batch, rest = ids, success;

    success = function(json) {
      Ember.run(this, function(){
        this.didFindMany(store, type, json);
      });
    };

    while(rest.length > 0) {
      batch = rest.slice(0, batchSize);
      rest = rest.slice(batchSize);
      ids = batch;

      this.ajax(this.buildURL(root), "GET", {
        data: {ids: ids},
        success: success
      });
    }
  }
});


GiddyUp.Adapter.map('GiddyUp.Project', {
  primaryKey: 'name'
});

GiddyUp.Adapter.map('GiddyUp.Scorecard', {
  project: { key: 'project' }
});
