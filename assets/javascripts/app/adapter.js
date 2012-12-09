var indexedDB = window.indexedDB || window.webkitIndexedDB || window.mozIndexedDB || window.msIndexedDB;

var states = {
  loadingCache: Ember.State.create({
    isLoaded: false,
    isCacheChecked: false,

    foundRecord: function(manager, record){
      manager.found(record);
    },

    missedRecord: function(manager, record){
      manager.missed(record);
    },

    becameMissed: function(manager){
      manager.transitionTo('loadingRemote');
    },

    becameLoaded: function(manager){
      manager.transitionTo('clean');
    }
  }),

  loadingRemote: Ember.State.create({
    isLoaded: false,
    isCacheChecked: true,

    enter: function(manager){
      var ids = manager.get('missing'),
          findManyRemote = manager.get('findManyRemote');

      findManyRemote.call(null, ids);
      manager.transitionTo('clean');
    }
  }),

  clean: Ember.State.create({
    isLoaded: true,
    isCacheChecked: true
  })
};

GiddyUp.CachedRecordFetchingManager = Ember.StateManager.extend({
  missing: null,
  expected: null,
  findManyRemote: null,
  initialState: 'loadingCache',
  states: states,
  counter: 0,

  init: function(){
    this._super();
    this.counter = this.get('expected.length');
    this.missing = [];
  },

  missed: function(record) {
    this.counter -= 1;
    this.missing.push(record);
    if(this.counter === 0){
      this.send('becameMissed');
    }
  },

  found: function(record) {
    this.counter -= 1;

    if(this.counter === 0){
      if(this.missing.length === 0) {
        this.send('becameLoaded');
      } else {
        this.send('becameMissed');
      }
    }
  }
});

GiddyUp.ProxyStore = Ember.Object.extend({
  store: null,
  adapter: null,
  load: function(type, object){
    var store = this.get('store'),
        adapter = this.get('adapter');
    adapter.loadValue(store, type, object);
  },
  loadMany: function(type, objects){
    var store = this.get('store'),
        adapter = this.get('adapter');
    adapter.loadValue(store, type, objects);
  }
});

GiddyUp.serializer = DS.JSONSerializer.create();

GiddyUp.serializer.registerTransform('hash', {
  deserialize: function(serialized) {
    return Ember.none(serialized) ? null : serialized;
  },

  serialize: function(deserialized) {
    return Ember.none(deserialized) ? null : deserialized;
  }
});

// Implements an adapter that caches immutable records locally in the
// Indexed DB API.
GiddyUp.CachingAdapter = DS.RESTAdapter.extend({
  name: null,

  init: function(){
    var self = this,
        name = this.get('name');

    var request = indexedDB.open(name, 2);

    request.addEventListener('upgradeneeded', function(event){
      request.result.createObjectStore(name, {autoIncrement: false});
    });

    request.addEventListener('error', function(event){
      throw new Error("The " + name +
                      " database could not be opened for some reason.");
    });

    request.addEventListener('success', function(event){
      self.set('db', request.result);
    });

    return this._super();
  },

  find: function(store, type, id, callback, success) {
    var foundLocal = success || Ember.K;
    var findRemote = callback || this._super;
    if(type.immutable !== true){
      // Non-immutable record types get sent directly.
      findRemote.call(this, store, type, id);
    } else {
      // Immutable record types check locally first.
      var db = this.get('db'),
          dbId = [type.toString(), id],
          self = this,
          name = this.get('name'),
          typeName = type.toString();

      var dbTransaction = db.transaction([name]);
      var dbStore = dbTransaction.objectStore(name);
      var request = dbStore.get([typeName, id]);

      request.addEventListener('error', function(event){
        throw new Error("An attempt to retrieve " + type + " with id " + id + " failed");
      });

      request.addEventListener('success', function(event){
        var hash = request.result;

        if(hash){
          // Fire the success callback
          foundLocal.call(self, id);
          store.load(type, hash);
        } else {
          // Fire the missing callback (try to find using the remote
          // method)
          findRemote.call(self, GiddyUp.ProxyStore.create({store: store, adapter: self}), type, id);
        }
      });
    }
  },

  findMany: function(store, type, ids){
    var findManyRemote = this._super,
        self = this, _findMany, stateManager;

    // If the type is not immutable (i.e. not cached indefinitely),
    // jump out early by calling the REST version instead.
    if(type.immutable !== true) {
      findManyRemote.call(this, store, type, ids);
      return;
    }

    // Since IndexedDB doesn't let you do a bulk fetch in the same way
    // as REST, we set up a state manager so we can track the loading
    // state of each record, and when all have reported back, then do
    // a bulk fetch from REST for the ones that are not in the cache.
    _findMany = function(idlist) {
      var head = idlist.slice(0, 50),
          tail = idlist.slice(50, idlist.length),
          proxyStore = GiddyUp.ProxyStore.create({store: store, adapter:self});

      while(head.length > 0){
        findManyRemote.call(self, proxyStore, type, head);
        head = tail.slice(0, 50);
        tail = tail.slice(50, tail.length);
      }
    };

    stateManager = GiddyUp.CachedRecordFetchingManager.create({
      expected: ids,
      findManyRemote: _findMany
    });

    ids.forEach(function(id) {
      self.find(store, type, id, function(s, t, mid){
        stateManager.send('missedRecord', mid);
      }, function(fid) {
        stateManager.send('foundRecord', fid);
      });
    });
  },

  loadValue: function(store, type, value){
    this._super(store, type, value);
    if(type.immutable === true){
      this.cacheValue(type, value);
    }
  },

  cacheValue: function(type, value){
    var name = this.get('name'),
        db = this.get('db'),
        self = this,
        typeName = type.toString();

    var dbTransaction = db.transaction([name], 'readwrite'),
        dbStore = dbTransaction.objectStore(name);

    var storeOp = function(record){
      dbStore.put(record, [typeName, record.id]);
    };

    if(value instanceof Array){
      value.forEach(storeOp);
    } else {
      storeOp.call(null, value);
    }
  }
});

if(indexedDB){
  GiddyUp.Adapter = GiddyUp.CachingAdapter.extend({
    name: 'giddyup',
    serializer: GiddyUp.serializer
  });
} else {
  GiddyUp.Adapter = DS.RESTAdapter.extend({
    serializer: GiddyUp.serializer
  });
}
