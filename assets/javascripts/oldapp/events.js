GiddyUp.EventProcessor = Ember.Object.extend({
  init: function() {
    this.source = new EventSource('live');

    this.source.addEventListener('test_result', function(e) {
      var parsedResponse = JSON.parse(e.data);
      var rawTestResult  = parsedResponse.test_result;
      var testResult     = GiddyUp.TestResult.loadRawTestResult(
                            rawTestResult);

      // Notification handling.
      //
      if (window.webkitNotifications &&
          window.webkitNotifications.checkPermission() === 0) {
          var message = testResult.get('notification');

          window.webkitNotifications.createNotification(
            "icon.png", message.title, message.message).
          show();
      }
    });
  }
});

/* Enable live event streams if available. */
if(!!window.EventSource) {
  // GiddyUp.eventProcessor = GiddyUp.EventProcessor.create({});
}

/* Prompt the user once to accept nofications. */
if (window.webkitNotifications &&
    window.webkitNotifications.checkPermission() !== 0) {
  // GiddyUp.desktopNotifierBinding = $('a').live('click', function() {
  //   window.webkitNotifications.requestPermission(function() {
  //     GiddyUp.desktopNotifierBinding.die();
  //   });
  // });
}
