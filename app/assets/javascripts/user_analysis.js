$(function(){
	var year = '2014';
	var user_id = $('#leave-count-chart').data('id');
	var base_url = "http://localhost:3000";
	var totalUrl = base_url + "api/leave_dates.json?year="+year+";meta=true;user_id="+user_id;
	var draw_chart = function(url){
		$("#leave-count-chart").html("");
		$.getJSON(url,function(response){
			var monthlyTotal;
			var leave_data = new Array();
			console.log(response);
			$.each(response,function(month,dateHash){
				var totalHalfLeave = 0,
				      totalFullLeave = 0;
				$.each(dateHash,function(date,data){
					totalHalfLeave += data.half_leave_count;
					totalFullLeave += data.full_leave_count;
				});
				leave_data.push({month: year+"-"+month,full_leaves: totalFullLeave,half_leaves: totalHalfLeave});
			})
			var lineChart = new Morris.Line({
			  lineWIdth: '10px',
			  // ID of the element in which to draw the chart.
			  element: 'leave-count-chart',
			  // Chart data records -- each entry in this array corresponds to a point on
			  // the chart.
			  data: leave_data,

			  xLabels: "month",

			  xLabelAngle: "60",

			  lineColors: ['red','blue'],
			  // The name of the data record attribute that contains x-values.
			  xkey: 'month',
			  // A list of names of data record attributes that contain y-values.
			  ykeys: ['full_leaves','half_leaves'],
			  // Labels for the ykeys -- will be displayed when you hover over the
			  // chart.
			  labels: ['Full Leaves Take','Half Leaves Taken']
			});
		});
	};
	draw_chart(totalUrl);
	
	$('.user-for-leave').on("click",function(event){
		var userId = $(this).data('id');
		var url = "api/leave_dates.json"+"?user_id="+userId;+";year=2014;meta=true";
		draw_chart(url);
		event.preventDefault();
	});
	$("#total-leave").on("click",function(event){
		draw_chart(totalUrl);
		event.preventDefault();
	});
	
});