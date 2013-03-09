// Based on http://stackoverflow.com/a/2450976/18315
GiddyUp.shuffle = function (myArray) {
  var i = myArray.length, j, tempi, tempj;
  if ( i === 0 ) return myArray;
  while ( --i ) {
     j = Math.floor( Math.random() * ( i + 1 ) );
     tempi = myArray[i];
     tempj = myArray[j];
     myArray[i] = tempj;
     myArray[j] = tempi;
   }
  return myArray;
};
