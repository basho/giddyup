
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

GiddyUp.prettyDate = function(date){
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
};

GiddyUp.ApplicationView = Ember.View.extend({
  templateName: 'application'
});

GiddyUp.ProjectsView = Ember.View.extend({
  templateName: 'projects',
  isLoadedBinding: 'controller.@each.isLoaded'
});

GiddyUp.ScorecardsView = Ember.View.extend({
  templateName: 'scorecards',
  isLoadedBinding: 'controller.content.isLoaded'
});

GiddyUp.TestInstancesView = Ember.View.extend({
  templateName: 'test_instances',
  progressTotalBinding: 'controller.content.length',
  progressComplete: function(){
    return this.get('controller.content').filterProperty('isLoaded').length;
  }.property('controller.content.@each.isLoaded'),
  progressPercent: function(){
    var length = this.get('progressTotal'),
        loadedLength = this.get('progressComplete'),
        percent;
    if(length === 0){
      percent = 0.0;
    } else {
      percent = (loadedLength / length) * 100.0;
    }
    return "" + Math.round(percent) + "%";
  }.property('progressTotal', 'progressComplete'),
  progressStyle: function(){
    return "width: " + this.get('progressPercent');
  }.property('progressPercent'),
  progressMessages: function(){
    var messages = [
      'Reticulating splines',
      'Reversing Parfitt notation',
      'Amortizing merge penalties',
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
      'Negotiating capabilities',
      'Attaching consoles',
      'Hot code-loading',
      'It\'s a lot of math',
      'Hacking the Charles Gibson',
      'Participating in the frantic',
      'That tip is the fix',
      'Better than a saber saw',
      'Cloning Fonzies',
      'Exploring the Deep Amazon',
      'Having a Taste',
      'Breaking eye contact'
    ];
    return GiddyUp.shuffle(messages).slice(0,6);
  }.property(),
  progressMessage: function(){
    var total = this.get('progressTotal'),
        complete = this.get('progressComplete'),
        messages = this.get('progressMessages'),
        index;
    if(total === 0)
      return '';
    else {
      index = Math.floor((complete / total) * messages.length);
      return messages[index];
    }
  }.property('progressTotal', 'progressComplete', 'progressMessages')
});

GiddyUp.TestInstanceView = Ember.View.extend({
  templateName: 'test_instance',
  descriptor: function(){
    var name = this.get('controller.content.name'),
        platform = this.get('controller.content.platform'),
        backend = this.get('controller.content.backend'),
        version = this.get('controller.content.upgradeVersion'),
        desc = '';

    if(name) desc += name;
    if(platform) desc += " / " + platform;
    if(backend) desc += " / " + backend;
    if(version) desc += " / " + version;
    return desc;
  }.property('controller.content.name', 'controller.content.platform',
             'controller.content.backend', 'controller.content.upgradeVersion')
});

GiddyUp.TestResultsView = Ember.View.extend({
  templateName: 'test_results'
});

GiddyUp.TestResultView = Ember.View.extend({
  templateName: 'test_result'
});

GiddyUp.TestInstanceBubbleView = Ember.View.extend({
  tagName: 'span',
  labelClass: 'badge',
  classNameBindings: ['labelClass', 'statusClass'],
  attributeBindings: ['title'],
  statusClass: function(){
    var total = this.get('content.status.total'),
        latest = this.get('content.status.latest');
    if(total === 0 || total === null || total === undefined)
      return '';
    else if(latest)
      return 'badge-success';
    else
      return 'badge-important';
  }.property('content.status.total', 'content.status.latest'),
  title: function(){
    var percent = this.get('content.status.percent');
    if(percent !== null && percent !== undefined)
      return percent.toFixed(1).toString() + "%";
    else
      return "0%";
  }.property('content.status.percent'),
  abbr: function(){
    var backend = this.get('content.backend');
    var upgrade_version = this.get('content.upgradeVersion');
    var abbr = '';
    switch(upgrade_version){
    case 'previous':
      abbr = '-1'; break;
    case 'legacy':
      abbr = '-2'; break;
    default:
      break;
    }
    switch(backend){
    case 'bitcask':
      abbr = 'B' + abbr;
      break;
    case 'eleveldb':
      abbr = 'L' + abbr;
      break;
    case 'memory':
      abbr = 'M'+abbr;
      break;
    default:
      break;
    }
    if(abbr.length === 0)
      return 'U';
    else
      return abbr;
  }.property('content.backend', 'content.upgradeVersion')
});

GiddyUp.CollectionView = Ember.CollectionView.extend({
  tagName: 'ul',
  classNames: ['nav']
});

GiddyUp.Selectable = Ember.Mixin.create({
  tagName: 'li',
  classNameBindings: ['isActive:active'],

  isActive: function() {
    return this.get('controller.selectedItem') === this.get('content');
  }.property('controller.selectedItem')
});

GiddyUp.ProjectsCollectionView = GiddyUp.CollectionView.extend({
  itemViewClass: Ember.View.extend(GiddyUp.Selectable, {
    templateName: 'projects_collection_item_view'
  })
});

GiddyUp.ScorecardsCollectionView = GiddyUp.CollectionView.extend({
  itemViewClass: Ember.View.extend(GiddyUp.Selectable, {
    templateName: 'scorecards_collection_item_view'
  })
});

GiddyUp.TestResultsCollectionView = GiddyUp.CollectionView.extend({
  classNames: ['nav', 'nav-list'],
  itemViewClass: Ember.View.extend(GiddyUp.Selectable, {
    templateName: 'test_results_collection_item_view',
    versionStringBinding: 'content.long_version',
    successBinding: 'content.success',
    isLoadedBinding: 'content.isLoaded',
    labelClass: function(){
      var s = this.get('success');
      if(s){
        return 'label label-success';
      } else {
        return 'label label-important';
      }
    }.property('success'),
    labelText: function(){
      var s = this.get('success');
      if(s){
        return 'Success';
      } else {
        return 'Failure';
      }
    }.property('success'),
    timeAgo: function(){
      return GiddyUp.prettyDate(this.get('content.created_at'));
    }.property('content.created_at')
  })
});

GiddyUp.LogView = Ember.View.extend({
  templateName: 'log'
});
