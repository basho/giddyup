// Based on http://stackoverflow.com/questions/1985260/javascript-array-rotate
GiddyUp.rotate = function(array, n){
  var len = array.length >>> 0,
      count = n >> 0;

  count = ((count % len) + len) % len;
  return array.slice(count, len).concat(array.slice(0, count));
};
