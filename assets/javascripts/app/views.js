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
  templateName: 'test_results'
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
  backendAbbr: function(){
    var backend = this.get('content.test.backend');
    switch(backend){
    case 'bitcask':
      return 'B';
      break;
    case 'eleveldb':
      return 'L';
      break;
    case 'memory':
      return 'M';
      break;
    default:
      return 'U';
    }

    return true;
  }.property('content.test.backend')
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
    templateName: 'test_results_collection_item_view'
  })
});

GiddyUp.LogView = Ember.View.extend({
  templateName: 'log'
});
