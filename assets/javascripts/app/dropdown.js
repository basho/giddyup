/* global $ */
GiddyUp.DropdownMixin = Ember.Mixin.create({
  toggleDropdown: function(){
    var $dropdown = $(event.target).parents('li.dropdown');
    $('li.dropdown.open').not($dropdown).removeClass('open');
    $dropdown.toggleClass('open');
  }
});

// I don't really like putting this here, but I seem not to have any
// option. Thanks Ember.
$(function(){
  $('html').click(function(event){
    if($(event.target).is('a.dropdown-toggle'))
      return false;
    $('li.dropdown.open').removeClass('open');
  })
});
