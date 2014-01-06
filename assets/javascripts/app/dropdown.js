/* global $ */
GiddyUp.DropdownMixin = Ember.Mixin.create({
  actions: {
    toggleDropdown: function(view){
      var $dropdown = $(view.get('element'));
      $('li.dropdown.open').not($dropdown).removeClass('open');
      $dropdown.toggleClass('open');
    }
  }
});

// Can't put this on GiddyUp.ApplicationView because that doesn't
// always fill the whole screen.
(function($){
  $('html').click(function(evt){
    // Close dropdowns
    if($(evt.target).is('a.dropdown-toggle'))
      return false;
    $('li.dropdown.open').removeClass('open');
  });
})(Ember.$);
