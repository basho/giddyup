var Vector = Ember.ArrayController.extend({
  key: null,
  indexProperty: null,
  orderByProperties: null,
  sortProperties: function() {
    var obp = this.get('orderByProperties');
    if(Ember.isArray(obp)) {
      return ['key'].concat(obp);
    } else {
      return ['key'];
    }
  }.property('orderByProperties'),
  findByKeys: function(keys) {
    if(Ember.isNone(keys) || Ember.isEmpty(keys)) {
      return this;
    }

    var key = keys.get('firstObject');
    var subtree = this.findProperty('key', key);
    if(Ember.isNone(subtree)) {
      return null;
    } else {
      return subtree.findByKeys(keys.slice(1));
    }
  }
});

var createIndex = function(props, values, obp, container, target) {
  if (props.length === 0) {
    return [];
  } else {
    var prop = props.get('firstObject');
    var range = values.get('firstObject');
    return range.map(function(key) {
      var subtree = createIndex(props.slice(1), values.slice(1), obp, container, target);
      return Vector.create({
        key: key,
        indexProperty: prop,
        orderByProperties: obp,
        content: subtree,
        container: container,
        target: target
      });
    });
  }
};

GiddyUp.MatrixController = Ember.ArrayController.extend({
  dimensions: [],
  orderByProperties: [],
  dimensionValues: function() {
    var dimensions = this.get('dimensions'),
    content = Ember.A(this.get('content'));

    return Ember.A(dimensions).map(function(dimension) {
      return content.getEach(dimension).uniq().sort();
    });
  }.property('dimensions', 'content'),

  matrix: function() {
    var content = this.get('content'),
        container = this.get('container'),
        dimensions = this.get('dimensions'),
        dimensionValues = this.get('dimensionValues'),
        obp = this.get('orderByProperties'),
        index;

    // Recursively build the index buckets
    index = Vector.create({
      container: container,
      content: createIndex(dimensions, dimensionValues, obp, container, this)
    });

    // Now insert the items
    content.forEach(function(item, idx) {
      var keys = dimensions.map(function(d) { return item.get(d); });
      var leaf = index.findByKeys(keys);
      var wrapped = this.objectAtContent(idx);
      leaf.addObject(wrapped);
    }, this);

    return index;
  }.property('content',
             'dimensions',
             'dimensionValues'),

  columnNames: Ember.computed.alias('dimensionValues.lastObject')
});
