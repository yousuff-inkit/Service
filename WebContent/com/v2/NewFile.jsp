<%@ taglib prefix="s" uri="/struts-tags"%>
<% String contextPath=request.getContextPath();%>     
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title> 
</head>   
<body>  
<div><canvas id="myChart" width="400" height="400"></canvas></div>
</body>
    <script src="../../js/Chart.min.js"></script>  
	<script type="text/javascript" src="../../js/dashboard/chartjs-plugin-colorschemes.min.js"></script>
	<script src="../../js/dashboard/d3.min.js" charset="utf-8"></script>   
	<script type="text/javascript">
	window.chartColorsOrg = {
			red: 'rgb(255, 99, 132)',
			orange: 'rgb(255, 159, 64)',
			yellow: 'rgb(255, 205, 86)',
			green: 'rgb(75, 192, 192)',
			blue: 'rgb(54, 162, 235)',
			purple: 'rgb(153, 102, 255)',
			grey: 'rgb(201, 203, 207)',
		};

	var labels = ['January', 'February', 'March', 'April', 'May'];
	const data = {
			  labels: [
			    'January',
			    'February',
			    'March',
			    'April'
			  ],
			  datasets: [{
			    type: 'bar',
			    label: 'Bar Dataset',
			    data: [10, 20, 30, 40],
			    borderColor: 'rgb(255, 99, 132)',
			    backgroundColor: 'rgba(255, 99, 132, 0.2)'
			  }, {
			    type: 'line',
			    label: 'Line Dataset',
			    data: [50, 10, 20, 50],
			    fill: false,
			    borderColor: 'rgb(54, 162, 235)'
			  }, {
				    type: 'line',
				    label: 'Line Dataset',
				    data: [5, 10, 20, 30],
				    fill: false,
				    borderColor: 'rgb(54, 160, 200)'
				  }
			  ]
			};  

	const config = {
			  type: 'scatter',
			  data: data,
			  options: {
			    scales: {
			      y: {
			        beginAtZero: true
			      }
			    }
			  }
			};
	var ctx = document.getElementById('myChart').getContext('2d');
	var mixedChart = new Chart(ctx, {
		   type: 'bar',
		   data: data,
		   options: {
			    scales: {
				      y: {
				        beginAtZero: true
				      }
				    }
				  }
		});
	/* window.onload = function() {  
	    var ctx = document.getElementById('myChart').getContext('2d');
    	 var ctxchartfleetsales = document.getElementById('chartfleetsales').getContext('2d');
		window.chartfleetsales = new Chart(ctxchartfleetsales, fleetsalesconfig); 
		//getInitChartData(window.chartfleetsales,fleetsalesconfig);
    	//getInitChartData();
	}; */
	</script>
</body>
</html>