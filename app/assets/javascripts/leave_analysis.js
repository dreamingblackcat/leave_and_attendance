$(function(){
	jQuery.fn.extend({
	  awLeave: {
	  	getBaseUrl: function(){
	  		return window.location.protocol + "//" + window.location.host ;
	  	},
	  	drawLineChart: function(apiUrl,chartOptions){
	  		$("#"+ chartOptions.element).html("");
	  		$.getJSON(apiUrl,function(response){
				var monthlyTotal;
				var leave_data = new Array();
				console.log(response);
				$.each(response,function(month,dateHash){
					var totalHalfLeave = 0,
					      totalFullLeave = 0;
					      yearMonth ='';
					$.each(dateHash,function(date,data){
						totalHalfLeave += data.half_leave_count;
						totalFullLeave += data.full_leave_count;
						if(!yearMonth){
							yearMonth = date.split('-').slice(0,2).join('-');
						}
					});
					leave_data.push({month: yearMonth,full_leaves: totalFullLeave,half_leaves: totalHalfLeave ,total_leaves: totalFullLeave+totalHalfLeave});
				});
				chartOptions.data = leave_data;
				console.log(chartOptions);
				var lineChart = new Morris.Line(chartOptions);
	  	});
	          }, 
	  	buildApiUrl: function(queryOptions){
	  		var self = this;
	  		var baseUrl =self.getBaseUrl();
	  		var queryString = "";
	  		$.each(queryOptions, function(key,value){
	  			if(queryOptions[key]){
	  				queryString += key +"="+value+";";
	  			}
	  		})
	  		var totalUrl = baseUrl + "/api/leave_dates?"+queryString;
	  		return totalUrl;
	  	},
	  	buildApiOptionsFromElement: function(element){
	  		var $chartElement = $("#"+ element);
	  		var options = {
	  			year: $chartElement.data('year'),
	  			month: $chartElement.data('month'),
	  			user_id: $chartElement.data('user_id'),
	  			meta: $chartElement.data('meta'),
	  			team_id: $chartElement.data('teamId')
	  		};
	  		console.log("options: ");
	  		console.log(options);
	  		return options;
	  	},
	  	getDefaultChartOptions: function(element){
	  		return {
				  lineWIdth: '10px',
				  // ID of the element in which to draw the chart.
				  element: element,
				  // Chart data records -- each entry in this array corresponds to a point on
				  // the chart.

				  xLabels: "month",

				  xLabelAngle: "60",

				  lineColors: ['red','blue','purple'],
				  // The name of the data record attribute that contains x-values.
				  xkey: 'month',
				  // A list of names of data record attributes that contain y-values.
				  ykeys: ['full_leaves','half_leaves','total_leaves'],
				  // Labels for the ykeys -- will be displayed when you hover over the
				  // chart.
				  labels: ['Full Leaves Take','Half Leaves Taken','Total Leaves Taken']
				};
	  	}
	  }
	});
	if($('body').data('chart-element')){
		console.log("Hello");
		$body = $('body');// this will  act as two roles: a dummy jq instance and actual dom for data querying
		console.log($body.awLeave.getBaseUrl());
		var element = $body.data('chart-element');
		var apiUrl =$body.awLeave.buildApiUrl($body.awLeave.buildApiOptionsFromElement(element));
		var chartOptions =$body.awLeave.getDefaultChartOptions(element);
		$body.awLeave.drawLineChart(apiUrl,chartOptions);
	};	
	
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

