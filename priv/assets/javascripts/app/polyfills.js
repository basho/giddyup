// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find
if (!Array.prototype.find) {
  Object.defineProperty(Array.prototype, 'find', {
    enumerable: false,
    configurable: false,
    writable: false,
    value: function(predicate) {
      for (var i=0; i < this.length; i++) {
        if (predicate(this[i], i, this)) {
          return this[i];
        }
      }
      return void 0;
    }
  });
}
