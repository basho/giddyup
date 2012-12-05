GiddyUp.EventProcessor = Ember.Object.extend({
  init: function() {
    this.source = new EventSource('live');

    this.source.addEventListener('test_result', function(e) {
      GiddyUp.store.load(GiddyUp.TestResult, JSON.parse(e.data));
    });
  }
});

if(!!window.EventSource) {
  GiddyUp.eventProcessor = GiddyUp.EventProcessor.create({});
}
