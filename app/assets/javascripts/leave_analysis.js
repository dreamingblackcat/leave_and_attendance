$(function(){
	var totalUrl = "api/leave_dates.json?year=2014;";
	var draw_chart = function(url){
		$("#leave-count-chart").html("");
		$.getJSON(url,function(response){
			var full_leave_data = new Array();
			var half_leave_data = new Array();
			console.log(response);
			$.each(response,function(month,dateHash){
				full_leave_data.push({month: month,leave_taken: value});
			})
			var lineChart = new Morris.Line({
			  lineWIdth: '10px',
			  // ID of the element in which to draw the chart.
			  element: 'leave-count-chart',
			  // Chart data records -- each entry in this array corresponds to a point on
			  // the chart.
			  data: leave_data,
			  // The name of the data record attribute that contains x-values.
			  xkey: 'month',
			  // A list of names of data record attributes that contain y-values.
			  ykeys: ['leave_taken'],['half_leave']
			  // Labels for the ykeys -- will be displayed when you hover over the
			  // chart.
			  labels: ['Leaves Taken']
			});
		});
	};
	draw_chart(totalUrl);
	
	$('.user-for-leave').on("click",function(event){
		var userId = $(this).data('id');
		var url = "api/leave_dates.json"+"?user_id="+userId;+";year=2014";
		draw_chart(url);
		event.preventDefault();
	});
	$("#total-leave").on("click",function(event){
		draw_chart(totalUrl);
		event.preventDefault();
	});
	
});