GiddyUp.Adapter = DS.RESTAdapter.extend({
  // See also https://github.com/emberjs/data/pull/531
  fetchBatchSize: 25,
  findMany: function(store, type, ids){
    var root = this.rootForType(type),
        batchSize = this.get('fetchBatchSize') || ids.length,
        batch,
        rest = ids,
        success;

    success = function(json){
      Ember.run(this, function(){
        this.didFindMany(store, type, json);
      })
    };

    while(rest.length > 0){
      batch = rest.slice(0, batchSize);
      rest = rest.slice(batchSize);
      ids = this.serializeIds(batch);
      this.ajax(this.buildURL(root), "GET", {
        data: {ids: ids},
        success: success
      });
    }
  }
});
