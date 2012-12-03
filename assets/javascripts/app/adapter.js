// var indexedDB = null;
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
      var ids = manager.get('missed'),
          findManyRemote = manager.get('findManyRemote');

      findRemote(ids);
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
    this.missing = Ember.A([]);
  },

  missed: function(record) {
    this.counter -= 1;
    this.missing.push(record);
    if(counter === 0){
      this.send('becameMissed');
    }
  },

  found: function(record) {
    this.counter -= 1;

    if(counter === 0){
      if(this.missing.length === 0) {
        this.send('becameLoaded');
      } else {
        this.send('becameMissed');
      }
    }
  }
});


// Implements an adapter that caches immutable records locally in the
// Indexed DB API.
GiddyUp.CachingAdapter = DS.RESTAdapter.extend({
  name: null,

  init: function(){
    console.log("Create dat db");
    var self = this,
        name = this.get('name');

    var request = indexedDB.open(name, 1);

    request.addEventListener('upgradeneeded', function(event){
      console.log("Setting dat object store");
      request.result.createObjectStore(name, {keyPath: 'id'});
    });

    request.addEventListener('error', function(event){
      throw new Error("The " + name +
                      " database could not be opened for some reason.");
    });

    request.addEventListener('success', function(event){
      console.log("Got dat db");
      self.set('db', request.result);
    })

    return this._super();
  },

  find: function(store, type, id, callback, success) {
    var foundLocal = success || Ember.K;
    var findRemote = callback || this._super;
    if(type.immutable !== true){
      console.log("Not immutable, find with REST: " + type.toString() + ":" + id);
      // Non-immutable record types get sent directly.
      findRemote(store, type, id);
    } else {
      // Immutable record types check locally first.
      var db = this.get('db'),
          dbId = [type.toString(), id],
          self = this,
          name = this.get('name');

      var dbTransaction = db.transaction([name]);
      var dbStore = dbTransaction.objectStore(name);
      var request = dbStore.get(id);

      request.addEventListener('error', function(event){
        throw new Error("An attempt to retrieve " + type + " with id " + id + " failed");
      });

      request.addEventListener('success', function(event){
        var hash = request.result;

        if(hash){
          // Fire the success callback
          console.log("Found: " + type.toString() + ":" + id);
          foundLocal.call(self, id);
          store.load(type, hash);
        } else {
          // Fire the missing callback (try to find using the remote
          // method)
          console.log("Miss, fallback to REST: " + type.toString() + ":" + id);
          findRemote.call(self, store, type, id);
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
      console.log("Not immutable, findMany with REST: " + type.toString());
      findManyRemote.call(this, store, type, ids);
      return;
    }

    // Since IndexedDB doesn't let you do a bulk fetch in the same way
    // as REST, we set up a state manager so we can track the loading
    // state of each record, and when all have reported back, then do
    // a bulk fetch from REST for the ones that are not in the cache.
    _findMany = function(idlist) {
      console.log("findManyRemote:" + type.toString() + ":" + idlist.toString());
      findManyRemote.call(self, store, type, idlist);
    };

    stateManager = GiddyUp.CachedRecordFetchingManager.create({
      expected: ids,
      findManyRemote: _findMany
    });

    ids.forEach(function(id){
      self.find(store, type, id, function(s, t, mid){
        console.log("missed:" + type + ":" + id);
        stateManager.send('missedRecord', mid);
      }, function(fid) {
        console.log("found:" + type + ":" + id);
        stateManager.send('foundRecord', fid);
      })
    }, this);
  },

  loadValue: function(store, type, value){
    console.log("loadValue: " + type.toString() + " : " + value.toString());
    if(type.immutable === true){
      this.cacheValue(type, value);
    }
    this._super(store, type, value);
  },

  cacheValue: function(type, value){
    console.log("Caching! " + type.toString() + " : " + value.toString());
    var name = this.get('name'),
        db = this.get('db'),
        self = this,
        typeName = type.toString();

    var dbTransaction = db.transaction([name], 'readwrite'),
        dbStore = dbTransaction.objectStore(name);

    var storeOp = function(record){
      var json = record.toJSON();
      dbStore.put(json, [typeName, record.get('id')]);
    };

    if(value instanceof Array){
      value.forEach(storeOp);
    } else {
      storeOp.call(null, value);
    }
  }
});

if(indexedDB){
  console.log("USING INDEXED DB");
  GiddyUp.Adapter = GiddyUp.CachingAdapter.extend({name: 'giddyup'});
} else {
  console.log("USING PLAIN REST");
  GiddyUp.Adapter = DS.RESTAdapter.extend();
}
