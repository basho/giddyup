GiddyUp.EventProcessor = Ember.Object.extend({
  init: function() {
    this.source = new EventSource('live');

    this.source.addEventListener('test_result', function(e) {
      var parsedResponse = JSON.parse(e.data);
      var testResult = parsedResponse.test_result;

      GiddyUp.store.load(GiddyUp.TestResult, testResult);
    });
  }
});

if(!!window.EventSource) {
  GiddyUp.eventProcessor = GiddyUp.EventProcessor.create({});
}
