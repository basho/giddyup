require('quips');

var helper = Ember.Handlebars.registerBoundHelper;

helper('testInstanceAbbr', function(){
  var backend = arguments[0],
      upgradeVersion = arguments[1],
      parts = [];

  switch(backend){
    case 'bitcask':
        parts.push('B'); break;
    case 'eleveldb':
        parts.push('L'); break;
    case 'memory':
        parts.push('M'); break;
    default:
        break;
  }

  switch(upgradeVersion){
    case 'previous':
        parts.push('-1'); break;
    case 'legacy':
        parts.push('-2'); break;
    default:
        break;
  }

  if (parts.length === 0)
     return 'U';
  else
     return parts.join('');
});

var testInstanceDescProps = ['name',
                             'backend',
                             'platform',
                             'upgradeVersion'];

helper('testInstanceDesc', function(testInstance){
  var props = testInstance.getProperties(testInstanceDescProps),
      parts = [];

  testInstanceDescProps.forEach(function(prop){
    if (props[prop] !== null && props[prop] !== undefined)
      parts.push(props[prop]);
  });

  return parts.join(' / ');
}, 'name', 'backend', 'platform', 'upgradeVersion');

helper('progressMessage', function(o){
  var quips = GiddyUp.quipsFor(o),
      percent = o.get('progressPercent'),
      index;

  index = Math.floor((percent / 100.0) * quips.length);
  return quips[index];
}, 'progressPercent');

helper('timeAgoInWords', function(date){
  // Based roughly on distance_of_time_in_words from Ruby on Rails,
  // with ideas from John Resig's "prettyDate" function.
  if(Ember.isNone(date))
    return '';

  var now = (new Date()).getTime(),
      distance_in_seconds = (now - date.getTime()) / 1000,
      distance_in_minutes = Math.round(distance_in_seconds / 60.0),
      distance_in_hours = Math.round(distance_in_minutes / 60.0),
      distance_in_days = Math.round(distance_in_minutes / 1440.0),
      distance_in_months = Math.round(distance_in_minutes / 43200.0),
      distance_in_years = Math.round(distance_in_days / 365);

  if(distance_in_minutes <= 1) {
    return (distance_in_minutes === 0) ? "just now" : "1 minute ago";
  } else if(distance_in_minutes >= 2 && distance_in_minutes <= 44) {
    return distance_in_minutes + " minutes ago";
  } else if(distance_in_minutes >= 45 && distance_in_minutes <= 89) {
    return "about 1 hour ago";
  } else if(distance_in_minutes >= 90 && distance_in_minutes <= 1439) {
    return "about " + distance_in_hours + " hours ago";
  } else if(distance_in_minutes >= 1440 && distance_in_minutes <= 2519) {
    return "1 day ago";
  } else if(distance_in_minutes >= 2520 && distance_in_minutes <= 43199) {
    return distance_in_days + " days ago";
  } else if(distance_in_minutes >= 43200 && distance_in_minutes <= 86399) {
    return "about 1 month ago";
  } else if(distance_in_minutes >= 86400 && distance_in_minutes <= 525599) {
    return distance_in_months + " months ago";
  } else if(distance_in_months < 13){
    return "about 1 year ago";
  } else if(distance_in_years < 2) {
    return "over 1 year ago";
  } else {
    return distance_in_years + " years ago";
  }
});
