GiddyUp.ApplicationSerializer = DS.RESTSerializer.extend({
  keyForRelationship: function(name, type){
    if(type == 'hasMany'){
      return name.singularize().underscore() + "_ids";
    } else {
      return name.underscore() + "_id";
    }
  }
});

DS.RESTAdapter.reopen({
  fetchBatchSize: 25,
  findMany: function(store, type, ids, owner){
    var root = type.typeKey,
        batchSize = this.get('fetchBatchSize') || ids.length,
        batch,
        rest = ids,
        promises = [],
        key = this.pathForType(root);

    while(rest.length > 0){
      batch = rest.slice(0, batchSize);
      rest = rest.slice(batchSize);
      promises.push(this.ajax(this.buildURL(root), "GET", {
        data: { ids: batch }
      }));
    }

    return Ember.RSVP.all(promises).then(function(results){
      return results.reduce(function(acc, item){
        acc[key] = acc[key].concat(item[key]);
        return acc;
      });
    });
  },
  pathForType: function(type){
    return type.pluralize().underscore();
  }
});
