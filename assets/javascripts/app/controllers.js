GiddyUp.ApplicationController = Ember.Controller.extend();

GiddyUp.ProjectsController = Ember.ArrayController.extend({
  sortProperties: ['id']
});

GiddyUp.ScorecardsController = Ember.ArrayController.extend({
  sortProperties: ['name'],
  sortAscending: false
});

GiddyUp.ProjectController = Ember.ObjectController.extend();

GiddyUp.ScorecardController = Ember.ObjectController.extend();

// Do the matrix manually, sigh
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

var createIndex = function(props, values, obp) {
  if (props.length === 0) {
    return [];
  } else {
    var prop = props.get('firstObject');
    var range = values.get('firstObject');
    return range.map(function(key) {
      var subtree = createIndex(props.slice(1), values.slice(1), obp);
      return Vector.create({
        key: key,
        indexProperty: prop,
        orderByProperties: obp,
        content: subtree
      });
    });
  }
};

GiddyUp.TestInstancesController = Ember.ArrayController.extend({
  dimensions: ['name', 'platform'],
  orderByProperties: ['backend', 'upgradeVersion'],
  isLoaded: function() {
    var content = Ember.A(this.get('content'));
    if(Ember.isEmpty(content))
      return false;

    return content.everyProperty('isLoaded', true);
  }.property('content', 'content.@each.isLoaded'),

  dimensionValues: function() {
    var dimensions = this.get('dimensions'),
    content = Ember.A(this.get('content'));

    return Ember.A(dimensions).map(function(dimension) {
      return content.getEach(dimension).uniq().sort();
    });
  }.property('dimensions', 'content').volatile(),

  matrix: function() {
    var content = this.get('content'),
    dimensions = this.get('dimensions'),
    dimensionValues = this.get('dimensionValues'),
    obp = this.get('orderByProperties'),
    index;

    // Recursively build the index buckets
    index = Vector.create({
      content: createIndex(dimensions, dimensionValues, obp)
    });

    // Now insert the items
    content.forEach(function(item) {
      var keys = dimensions.map(function(d) { return item.get(d); });
      var leaf = index.findByKeys(keys);
      leaf.addObject(item);
    }, this);

    return index;
  }.property('content', 'dimensions', 'dimensionValues')
});

GiddyUp.TestInstanceController = Ember.ObjectController.extend({});

GiddyUp.TestResultsController = Ember.ArrayController.extend({
  sortProperties: ['created_at'],
  sortAscending: false
});

GiddyUp.TestResultController = Ember.ObjectController.extend();

GiddyUp.LogController = Ember.ObjectController.extend();
