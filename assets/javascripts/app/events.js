GiddyUp.EventProcessor = Ember.Object.extend({
  init: function() {
    this.source = new EventSource('live');

    /** When generic messages are received, generate notifications for
      * them directly. */
    this.source.addEventListener('message', function(e) {
      var parsedEvent   = JSON.parse(e.data);
      var notification  = parsedEvent.notification;

      GiddyUp.Notification.create({
        title: notification.title, message: notification.message
      }).send();
    });

    /** When test results are received, force loading of the object by
      * id, and trigger a notification for the new object */
    this.source.addEventListener('test_result', function(e) {
      var parsedEvent   = JSON.parse(e.data);
      var notification  = parsedEvent.notification;
      var testResultId  = parsedEvent.id;
      var testResult    = GiddyUp.TestResult.find(testResultId);

      GiddyUp.Notification.create({
        title: notification.title, message: notification.message
      }).send();
    });
  }
});

GiddyUp.Notification = Ember.Object.extend({
  send: function() {
    if (window.webkitNotifications &&
      window.webkitNotifications.checkPermission() === 0) {
      window.webkitNotifications.createNotification(
        "icon.png",
        this.get('title'),
        this.get('message')).show();
    }
  }
});

/* Enable live event streams if available. */
if(!!window.EventSource) {
  GiddyUp.eventProcessor = GiddyUp.EventProcessor.create();
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
