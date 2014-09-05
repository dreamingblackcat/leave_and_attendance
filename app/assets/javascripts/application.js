// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery_nested_form
//= require_tree .

$(function(){ 
	$(document).foundation();
	var total_dates = $('.leave_dates').find('.fields').length;
	$('.fields_count').text(total_dates+" days");
	$('.dpk').Zebra_DatePicker();
	$(document).on('nested:fieldAdded', function(event){
	  // this field was just inserted into your form
	  var field = event.field; 
	  // it's a jQuery object already! Now you can find date input
	  var dateField = field.find('input.dpk');
	  $('.fields_count').text(field.parent().parent().find('.fields').length+" days");
	  console.log(field.parent().parent().find('.fields').length);
	  // and activate datepicker on it
	  dateField.Zebra_DatePicker();
	})

	$(document).on('nested:fieldRemoved',function(event){
		var field = event.field;
		var total_dates = field.parent().parent().find('.fields').length-1;
		$('.fields_count').text(total_dates+" days"); 
		console.log(field.parent().parent().find('.fields').length-1);
		field.remove();
	});

});

