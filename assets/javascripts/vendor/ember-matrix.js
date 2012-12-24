(function() {
Ember.Matrix = Ember.Namespace.create();

})();



(function() {
var isNone = Ember.isNone || Ember.none,
    isEmpty = Ember.isEmpty || Ember.empty;

Ember.Matrix.Vector = Ember.ArrayProxy.extend(Ember.SortableMixin, {
  key: null,
  indexProperty: null,
  isLeaf: false,
  sortProperties: ['key'],
  findByKeys: function(keys) {
    if(isNone(keys) || isEmpty(keys)) {
      return this;
    }

    var key = keys.get('firstObject');
    var subtree = this.findProperty('key', key);
    if(isNone(subtree)) {
      return null;
    } else {
      return subtree.findByKeys(keys.slice(1));
    }
  },
  toString: function() {
    return "<Ember.Matrix.Vector:" +
      Ember.guidFor(this) + ":" +
      this.get('key') + " [\n" + this.invoke('toString').join(",\n").replace(/\n/g, "\n    ") + " ]>";
  }
});

})();



(function() {
var Vector = Ember.Matrix.Vector;

var createIndex = function(props, values) {
  if (props.length === 0) {
    return [];
  } else {
    var prop = props.get('firstObject');
    var range = values.get('firstObject');
    var leaf = (props.length === 1);
    return range.map(function(key) {
      var subtree = createIndex(props.slice(1), values.slice(1));
      return Vector.create({
        key: key,
        indexProperty: prop,
        content: subtree,
        isLeaf: leaf
      });
    });
  }
};

Ember.Matrix.Controller = Ember.ArrayController.extend({
  _keyCache: {},
  dimensions: [],
  dimensionValues: function() {
    var dimensions = this.get('dimensions'),
    content = Ember.A(this.get('content'));

    return Ember.A(dimensions).map(function(dimension) {
      return content.getEach(dimension).uniq().sort();
    });
  }.property('dimensions'),

  sortPropertiesBinding: 'dimensions',

  matrix: function() {
    var content = this.get('content'),
    dimensions = this.get('dimensions'),
    dimensionValues = this.get('dimensionValues'),
    index;

    // Recursively build in the index buckets
    index = Vector.create({
      content: createIndex(dimensions, dimensionValues)
    });

    // Now insert the items
    content.forEach(function(item) {
      this.index(item, index);
      this.addItemObservers(item);
    }, this);

    return index;
  }.property('content', 'dimensions'),

  // Adds an item to the index
  index: function(item) {
    var index = arguments[1] || this.get('matrix'),
    dimensions = this.get('dimensions'),
    keyCache = this.get('_keyCache');

    var keys = dimensions.map(function(d) {
      return item.get(d);
    });
    Ember.beginPropertyChanges();
    var leaf = index.findByKeys(keys);
    keyCache[Ember.guidFor(item)] = keys;
    if (!leaf) {
      this.addIndexes(keys);
      leaf = index.findByKeys(keys);
    }
    leaf.pushObject(item);
    Ember.endPropertyChanges();
  },

  // Removes an item from the index (e.g. when it was removed or needs
  // reindexing)
  deindex: function(item) {
    var index = this.get('matrix'),
    keyCache = this.get('_keyCache'),
    dimensions = this.get('dimensions'),
    dValues = this.get('dimensionValues'),
    id = Ember.guidFor(item);

    var keys = keyCache[id];
    var leaf = index.findByKeys(keys);

    Ember.beginPropertyChanges();
    if (leaf) {
      leaf.removeObject(item);
    }
    this.cleanupIndexes(item);
    delete keyCache[id];
    Ember.endPropertyChanges();
  },

  // Adds observers to the item so you can detect changes to the
  // dimensions properties
  addItemObservers: function(item) {
    var dimensions = this.get('dimensions');
    dimensions.forEach(function(d) {
      Ember.addBeforeObserver(item, d, this, 'dimensionPropertyWillChange');
      Ember.addObserver(item, d, this, 'dimensionPropertyDidChange');
    }, this);
  },

  // Removes observes from the item's dimension properties
  removeItemObservers: function(item) {
    var dimensions = this.get('dimensions');
    dimensions.forEach(function(d) {
      Ember.removeBeforeObserver(item, d, this, 'dimensionPropertyWillChange');
      Ember.removeObserver(item, d, this, 'dimensionPropertyDidChange');
    }, this);
  },

  // Triggered when a dimension property of an item is about to
  // change, and so removes the item from the matrix/index.
  dimensionPropertyWillChange: function(item) {
    this.deindex(item);
  },

  // Triggered when a dimension property of an item has finished
  // changing and so readds the item to the index.
  dimensionPropertyDidChange: function(item) {
    this.index(item);
  },

  // Called when items are added to the collection. Causes them to be
  // added to the index and observed according to the dimension
  // properties.
  contentArrayDidChange: function(array, idx, removedCount, addedCount) {
    var addedObjects = array.slice(idx, idx+addedCount);
    addedObjects.forEach(function(item) {
      this.addItemObservers(item);
      this.index(item);
    }, this);
    this._super(array, idx, removedCount, addedCount);
  },

  // Called when items are removed from the collection. Causes them to
  // be removed from the index and remove their observers.
  contentArrayWillChange: function(array, idx, removedCount, addedCount) {
    var removedObjects = array.slice(idx, idx+removedCount);
    removedObjects.forEach(function(item) {
      this.removeItemObservers(item);
      this.deindex(item);
    }, this);
    this._super(array, idx, removedCount, addedCount);
  },

  // Adjusts the index and dimension values by adding the necessary entries.
  addIndexes: function(newKeys, index, values) {
    if(Ember.isEmpty(newKeys)) {
      return;
    }

    values = values || this.get('dimensionValues');
    index = index || this.get('matrix');

    var currentKey = newKeys.get('firstObject');
    var dValues = values.get('firstObject');

    // If the dimension value isn't in there, add it and sort the
    // array again
    if(!dValues.contains(currentKey)) {
      this.propertyWillChange('dimensionValues');
      dValues.push(currentKey);
      dValues.sort();
      this.propertyDidChange('dimensionValues');
    }

    // Add the subtree for new and existing dimension values if they
    // don't exist
    dValues.forEach(function(dkey) {
      if(!index.findProperty('key', dkey)) {
        index.pushObject(Vector.create({key: dkey, content: []}));
      }
    }, this);

    // Add all the appropriate buckets to the subtrees of this index
    index.forEach(function(subtree) {
      this.addIndexes(newKeys.slice(1), subtree, values.slice(1));
    }, this);
  },

  // Removes indexes and dimension values that are no longer valid
  cleanupIndexes: function(item) {
    var dimensions = this.get('dimensions'),
        index = this.get('matrix'),
        values = this.cacheFor('dimensionValues'),
        content = this.get('content').without(item),
        newValues;

    newValues = Ember.A(dimensions).map(function(d) {
      return content.getEach(d).uniq().sort();
    });

    // Now remove the invalid dimension values
    this.propertyWillChange('dimensionValues');
    values.replace(newValues);
    this.propertyDidChange('dimensionValues');

    function pruneBuckets(tree, keepValues) {
      if(Ember.isEmpty(keepValues)) {
        return;
      }

      var toKeep = Ember.A([]);
      keepValues.forEach(function(key) {
        var branch = tree.findProperty('key', key);
        if(branch) {
          pruneBuckets(branch, keepValues.slice(1));
          toKeep.pushObject(branch);
        }
      });
      tree.replace(toKeep);
    }

    pruneBuckets(index, newValues);
  }
});

})();



(function() {

})();

