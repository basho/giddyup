GiddyUp.EventProcessor = Ember.Object.extend({
  init: function() {
    this.source = new EventSource('live');

    this.source.addEventListener('test_result', function(e) {
      var parsedResponse = JSON.parse(e.data);
      var testResult = parsedResponse.test_result;

      // Load the new test result into the store.
      GiddyUp.store.load(GiddyUp.TestResult, testResult);

      // Trigger a notification.
      if (window.webkitNotifications &&
        window.webkitNotifications.checkPermission() === 0) {
        window.webkitNotifications.createNotification(
          'icon.png',
          'GiddyUp: Test Result Posted!',
          'Build: ' + testResult.long_version).
        show();
      }
    });
  }
});

/* Enable live event streams if available. */
if(!!window.EventSource) {
  GiddyUp.eventProcessor = GiddyUp.EventProcessor.create({});
}

/* Prompt the user once to accept nofications. */
if (window.webkitNotifications &&
    window.webkitNotifications.checkPermission() !== 0) {
  GiddyUp.desktopNotifierBinding = $('a').live('click', function() {
    window.webkitNotifications.requestPermission(function() {
      GiddyUp.desktopNotifierBinding.die();
    });
  });
}
