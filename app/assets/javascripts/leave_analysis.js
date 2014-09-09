$(function(){
	$.getJSON('/leave_analysis.json',function(response){
		var leave_data = new Array();
		console.log(response);
		$.each(response,function(key,value){
			leave_data.push({month: key,leave_taken: value});
		})
		var lineChart = new Morris.Line({
		  // ID of the element in which to draw the chart.
		  element: 'leave-count-chart',
		  // Chart data records -- each entry in this array corresponds to a point on
		  // the chart.
		  data: leave_data,
		  // The name of the data record attribute that contains x-values.
		  xkey: 'month',
		  // A list of names of data record attributes that contain y-values.
		  ykeys: ['leave_taken'],
		  // Labels for the ykeys -- will be displayed when you hover over the
		  // chart.
		  labels: ['Leaves Taken']
		});
	});
	
});