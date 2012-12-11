GiddyUp.prettyDate = function(date){
  // Based roughly on distance_of_time_in_words from Ruby on Rails,
  // with ideas from John Resig's "prettyDate" function.
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

GiddyUp.ScorecardView = Ember.View.extend({
  templateName: 'scorecard'
});


GiddyUp.TestResultsView = Ember.View.extend({
  templateName: 'test_results',
  nameBinding: 'controller.test.name',
  platformBinding: 'controller.test.platform',
  backend: function(){
    var backend = this.get('controller.test.backend');
    if(backend === undefined)
      return 'undefined';
    else
      return backend.toString();
  }.property('controller.test.backend')
});

GiddyUp.TestResultView = Ember.View.extend({
  templateName: 'test_result'
});

GiddyUp.TestView = Ember.View.extend({
  tagName: 'span',
  labelClass: 'badge',
  classNameBindings: ['labelClass', 'statusClass'],
  attributeBindings: ['title'],
  statusClass: function(){
    // var status = this.get('content.status');
    // if(status.get('total') === 0)
      return '';
    // else if(status.get('latest'))
    //   return 'badge-success';
    // else
    //   return 'badge-important';
  }.property(),
  title: function(){
    // var percent = this.get('content.status.percent');
    // if(percent !== null || percent !== undefined)
    //   return percent.toFixed(1).toString() + "%";
    // else
      return "0%";
  }.property(),
  abbr: function(){
    if(!this.get('content.isLoaded')){
      return 'loading';
    }
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
    timeAgo: function(){
      return GiddyUp.prettyDate(this.get('content.created_at'));
    }.property('content.created_at')
  })
});

GiddyUp.LogView = Ember.View.extend({
  templateName: 'log'
});
