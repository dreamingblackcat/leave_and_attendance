$(function(){
	var totalUrl = "/leave_analysis.json";
	var draw_chart = function(url){
		$("#leave-count-chart").html("");
		$.getJSON(url,function(response){
			var leave_data = new Array();
			console.log(response);
			$.each(response,function(key,value){
				leave_data.push({month: key,leave_taken: value});
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
			  ykeys: ['leave_taken'],
			  // Labels for the ykeys -- will be displayed when you hover over the
			  // chart.
			  labels: ['Leaves Taken']
			});
		});
	};
	draw_chart(totalUrl);
	
	$('.user-for-leave').on("click",function(event){
		var userId = $(this).data('id');
		var url = "/leave_analysis.json"+"?user_id="+userId;
		draw_chart(url);
		event.preventDefault();
	});
	$("#total-leave").on("click",function(event){
		draw_chart(totalUrl);
		event.preventDefault();
	});
	
});