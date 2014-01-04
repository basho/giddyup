GiddyUp.ApplicationSerializer = DS.RESTSerializer.extend({
  keyForRelationship: function(name, type){
    if(type == 'hasMany'){
      return name.singularize().underscore() + "_ids";
    } else {
      return name.underscore() + "_id";
    }
  }
});
