require('shuffle');
require('rotate');

var quips = [
  'Reticulating splines',
  'Reversing Parfitt notation',
  'Hashing artists/REM',
  'Ensuring 100% as much as possible',
  'Holding up the codebase',
  'Normalizing whitespace',
  'Logging meetings',
  'Writing opens',
  'Reviewing all files',
  'Any of you quaids got a smint',
  'Eating around the stinger',
  'Raising mugs',
  'Painting it blue',
  'Shipping trial CDs',
  'This is how we do it',
  'It\'s a lot of math',
  'Hacking the Charles Gibson',
  'Participating in the frantic',
  'That tip is the fix',
  'Better than a saber saw',
  'Cloning Fonzies',
  'Exploring the Deep Amazon',
  'Having a taste',
  'Breaking eye contact',
  'Initializing XML co-processors',
  'Bursting from chests',
  'Removing unfunny quips'
];

var sQuips = GiddyUp.shuffle(quips);
var quipMap = Ember.Map.create();

GiddyUp.quipsFor = function(obj){
  if(quipMap.has(obj)){
    return quipMap.get(obj);
  } else {
    var oQuips = GiddyUp.rotate(sQuips, new Date().now()).slice(0,6);
    quipMap.set(obj, oQuips);
    return oQuips;
  }
};
