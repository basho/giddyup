GiddyUp.prettyDate = function(date){
  // Based on John Resig's prettyDate function for JavaScript &
  // JQuery.
  // http://ejohn.org/files/pretty.js
  var diff = (((new Date()).getTime() - date.getTime()) / 1000),
      day_diff = Math.floor(diff / 86400);

  if ( isNaN(day_diff) || day_diff < 0 )
    return;

  return day_diff == 0 && (
    diff < 60 && "just now" ||
      diff < 120 && "1 minute ago" ||
      diff < 3600 && Math.floor( diff / 60 ) + " minutes ago" ||
      diff < 7200 && "1 hour ago" ||
      diff < 86400 && Math.floor( diff / 3600 ) + " hours ago") ||
    day_diff == 1 && "Yesterday" ||
    day_diff < 7 && day_diff + " days ago" ||
    day_diff < 42 && Math.ceil( day_diff / 7 ) + " weeks ago" ||
    day_diff >= 42 && Math.ceil( day_diff / 30 ) + " months ago";
}

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
  templateName: 'scorecard',
  isLoaded: function(){
    var result = this.get('controller.content.isLoaded') &&
      this.get('controller.content.test_results').getEach('isLoaded').
      every(function(l){ return l; });
    return result;
  }.property('controller.content.isLoaded',
             'controller.content.test_results.@each.isLoaded')
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

GiddyUp.ScorecardSubcellView = Ember.View.extend({
  tagName: 'span',
  labelClass: 'badge',
  classNameBindings: ['labelClass', 'statusClass'],
  attributeBindings: ['title'],
  statusClass: function(){
    var status = this.get('content.status');
    if(status.get('total') === 0)
      return '';
    else if(status.get('latest'))
      return 'badge-success';
    else
      return 'badge-important';
  }.property('content.status'),
  title: function(){
    var percent = this.get('content.status.percent');
    if(percent !== null || percent !== undefined)
      return percent.toFixed(1).toString() + "%";
    else
      return "0%";
  }.property('content.status'),
  abbr: function(){
    var backend = this.get('content.test.backend');
    var upgrade_version = this.get('content.test.upgrade_version');
    var abbr = ''
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
  }.property('content.test.backend', 'content.test.upgrade_version')
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
