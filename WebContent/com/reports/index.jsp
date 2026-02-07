<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>GatewayERP(i)</title>
<jsp:include page="temp.jsp"></jsp:include>

<style>
.redClass
{
   color: #FF0000;            
}
</style>
    <style type="text/css">
        .chart-inner-text
        {
            fill: #00BAFF;
            color: #00BAFF;
            font-size: 30px;
            font-family: Verdana;
        }    
    </style>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
 
        $(document).ready(function () {
        	$('#db').hide();$("#btnPrevious").hide();$("#btnRemove").hide();$('#hidbrandgarage').val('Veh. in Garage - Brand Wise');
            /* Partial Pie Chart Starts*/
            
            
           var trigger = $('.hamburger'),
      overlay = $('.overlay'),
     isClosed = false;

    trigger.click(function () {
      hamburger_cross();      
    });

    function hamburger_cross() {

      if (isClosed == true) {          
        overlay.hide();
        trigger.removeClass('is-open');
        trigger.addClass('is-closed');
        isClosed = false;
      } else {   
        overlay.show();
        trigger.removeClass('is-closed');
        trigger.addClass('is-open');
        isClosed = true;
      }
  }
  
  $('[data-toggle="offcanvas"]').click(function () {
        $('#wrapper').toggleClass('toggled');
  });     
            
            function displayClusterMetrics() {
                var metrics =
                [
                    {
                        name: 'Avg Sale',
                        value: 55,
                        max: 64
                    },
                    {
                        name: 'Avg. Purchase',
                        value: 37,
                        max: 100
                    },
                    {
                        name: 'Profit %',
                        value: 89.3,
                        max: 256
                    },
                    {
                        name: ' Other ',
                        value: 47,
                        max: 100
                    }
                ];

                for (var i = 0; i < metrics.length; i++) {

                    var data = [];

                    data.push({ text: 'Used', value: metrics[i].value }); // current
                    data.push({ text: 'Available', value: metrics[i].max - metrics[i].value }); // remaining

                    var settings = {
                        title: metrics[i].name,
                        description: '',
                        enableAnimations: true,
                        showLegend: false,
                        showBorderLine: true,
                        backgroundColor: '#FFFF',
                        padding: { left: 5, top: 5, right: 5, bottom: 5 },
                        titlePadding: { left: 5, top: 5, right: 5, bottom: 5 },
                        source: data,
                        showToolTips: true,
                        seriesGroups:
                        [
                            {
                                type: 'donut',
                                useGradientColors: false,
                                series:
                                    [
                                        {
                                            showLabels: false,
                                            enableSelection: true,
                                            displayText: 'text',
                                            dataField: 'value',
                                            labelRadius: 120,
                                            initialAngle: 90,
                                            radius: 60,
                                            innerRadius: 50,
                                            centerOffset: 0
                                        }
                                    ]
                            }
                        ]
                    };

                    var selector = '#chartContainer' + (i + 1).toString();

                    var valueText = metrics[i].value.toString();

                    settings.drawBefore = function (renderer, rect) {
                        sz = renderer.measureText(valueText, 0, { 'class': 'chart-inner-text' });

                        renderer.text(
                        valueText,
                        rect.x + (rect.width - sz.width) / 2,
                        rect.y + rect.height / 2,
                        0,
                        0,
                        0,
                        { 'class': 'chart-inner-text' }
                        );
                    }

                    $(selector).jqxChart(settings);
                    $(selector).jqxChart('addColorScheme', 'customColorScheme', ['#00BAFF', '#EDE6E7']);
                    $(selector).jqxChart({ colorScheme: 'customColorScheme' });
                }
            }

            function displayServerResponseMetrics() {
                var data =
                    [
                        { hour: 0, latency: 235, requests: 3500 },
                        { hour: 1, latency: 231, requests: 3400 },
                        { hour: 2, latency: 217, requests: 3350 },
                        { hour: 3, latency: 215, requests: 3260 },
                        { hour: 4, latency: 225, requests: 3320 },
                        { hour: 5, latency: 235, requests: 3400 },
                        { hour: 6, latency: 239, requests: 3550 },
                        { hour: 7, latency: 255, requests: 4100 },
                        { hour: 8, latency: 251, requests: 4200 },
                        { hour: 9, latency: 259, requests: 4500 },
                        { hour: 10, latency: 265, requests: 4560 },
                        { hour: 11, latency: 257, requests: 4500 },
                        { hour: 12, latency: 265, requests: 4490 },
                        { hour: 13, latency: 261, requests: 4400 },
                        { hour: 14, latency: 258, requests: 4350 },
                        { hour: 15, latency: 257, requests: 4340 },
                        { hour: 16, latency: 255, requests: 4200 },
                        { hour: 17, latency: 245, requests: 4050 },
                        { hour: 18, latency: 241, requests: 4020 },
                        { hour: 19, latency: 239, requests: 3900 },
                        { hour: 20, latency: 237, requests: 3810 },
                        { hour: 21, latency: 236, requests: 3720 },
                        { hour: 22, latency: 235, requests: 3610 },
                        { hour: 23, latency: 239, requests: 3550 },
                    ];

                var latencyThreshold = 260;

                var settings = {
                    title: 'Avg Report',
                    description: '',
                    enableAnimations: true,
                    showLegend: false,
                    showBorderLine: true,
                    backgroundColor: '#FFFF',
                    padding: { left: 5, top: 5, right: 5, bottom: 5 },
                    titlePadding: { left: 5, top: 5, right: 5, bottom: 5 },
                    source: data,
                    xAxis:
                    {
                        dataField: 'hour',
                        displayText: 'Hour',
                    },
                    seriesGroups:
                        [
                            {
                                type: 'column',
                                valueAxis:
                                {
                                    title: { text: ' <br>' },
                                    position: 'left'
                                },
                                toolTipFormatSettings: { sufix: ' ms'},
                                series:
                                    [
                                        {
                                            dataField: 'latency',
                                            displayText: 'Request latency',
                                            colorFunction: function (value, itemIndex, serie, group) {
                                                return (value > latencyThreshold) ? '#CC1133' : '#55CC55';
                                            }
                                        }
                                    ],
                                bands:
                                [
                                    {
                                        minValue: latencyThreshold,
                                        maxValue: latencyThreshold,
                                        lineWidth: 1,
                                        color: 'red'
                                    }
                                ]
                            },
                            {
                                type: 'spline',
                                valueAxis:
                                {
                                    title: { text: ' ' },
                                    position: 'right'
                                },
                                toolTipFormatSettings: { sufix: ' req/s'},
                                series:
                                    [
                                        {
                                            dataField: 'requests',
                                            displayText: 'Get requests',
                                            lineColor: '#343F9B',
                                            lineWidth: 2
                                        }
                                    ]
                            },

                        ]
                };

                $(chartContainer5).jqxChart(settings);
            }

            displayClusterMetrics();
            displayServerResponseMetrics();
            
            
            
                        var data =
                [
                    { category: 'Exterior', per: 45.6 },
                    { category: 'General', per: 24.6 },
                    { category: 'Interior', per: 20.4 },
                    { category: 'Performance', per: 6.1 },
                    { category: 'Suspension', per: 3.3 },
                ];
            
            var dataStatCounter = data;
        
            var charts = [
                { title: '', label: 'Stat', dataSource: dataStatCounter }
            ];
            for (var i = 0; i < charts.length; i++) {
                var chartSettings = {
                    source: charts[i].dataSource,
                    title: 'Inventory',
                    description: charts[i].title,
                    enableAnimations: true,
                    showLegend: true,
                    showBorderLine: true,
                    padding: { left: 5, top: 5, right: 5, bottom: 5 },
                    titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
                    colorScheme: 'scheme01',
                    seriesGroups: [
                        {
                            type: 'pie',
                            showLegend: true,
                            enableSeriesToggle: true,
                            series:
                                [
                                    {
                                        dataField: 'per',
                                        displayText: 'category',
                                        showLabels: true,
                                        labelRadius: 140,
                                        labelLinesEnabled: true,
                                        labelLinesAngles: true,
                                        labelsAutoRotate: false,
                                        initialAngle: 0,
                                        radius: 110,
                                        minAngle: 0,
                                        maxAngle: 360,
                                        centerOffset: 0,
                                        offsetY: 110,
                                        formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                            if (isNaN(value))
                                                return value;
                                            return value + '%';
                                        }
                                    }
                                ]
                        }
                    ]
                };
                // select container and apply settings
                var selector = '#inventory' + (i + 1);
                $(selector).jqxChart(chartSettings);
            }
            
            
         
            
            

            var data3= [{"amount":"100","month":"Jan"},
                        {"amount":"500","month":"Feb"},
                        {"amount":"200","month":"Mar"},
                        {"amount":"98","month":"Apr"},
                        {"amount":"100","month":"May"},
                        {"amount":"150","month":"Jun"},
                        {"amount":"200","month":"Jul"},
                        {"amount":"310","month":"Aug"},
                        {"amount":"505","month":"Sep"},
                        {"amount":"108","month":"Oct"},
                        {"amount":"94","month":"Nov"},
                        {"amount":"100","month":"Dec"}];

            $(document).ready(function () {
	            // prepare chart data as an array            
	            var source =
	            {
	                datatype: "json",
	                datafields: [
	                    { name: 'amount' },
	                    { name: 'month' }
	                ],
	                localdata: data3
	            };
	            
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    alert(error);    
		                    }
				            
			            } );
	            
	            // prepare jqxChart settings
	            var settings = {
	                title: "Sales",
	                description: "",
	                showLegend: true,
	                enableAnimations: true,
	                padding: { left: 5, top: 5, right: 5, bottom: 5 },
	                titlePadding: { left: 30, top: 0, right: 0, bottom: 5 },
	                source: dataAdapter,
	                xAxis:
	                    {
	                        dataField: 'month',
	                        //textRotationAngle: -75,
	                        gridLines: { visible: false },
	                        showGridLines: false,
	                        valuesOnTicks: false,
	                    },
	                colorScheme: 'scheme01',
	                columnSeriesOverlap: false,
	                seriesGroups:
	                    [
	                        {
	                            type: 'column',
	                            columnsGapPercent: 15,
	                            seriesGapPercent: 10,
	                            columnsMaxWidth: 20,
	                            columnsMinWidth: 1,
	                            skipOverlappingPoints: false,
	                            valueAxis:
	                            {
	                                visible: true,
	                                minValue: 0,
	                                description: 'Amount',
	                                title: { text: 'Month' },
	                            },
	                            series: [
	                                    { dataField: 'amount', displayText: 'Month' }
	                                ]
	                        }
	                    ]
	            };
	            // setup the chart
	            $('#sales').jqxChart(settings);
	        });
            
            var sampleData = [
                              { City: 'Jan', SalesQ1: 310500, SalesQ2: 210500, YoYGrowthQ1: 1.05, YoYGrowthQ2: 1.25 },
                              { City: 'Fen', SalesQ1: 120000, SalesQ2: 169000, YoYGrowthQ1: 1.15, YoYGrowthQ2: 0.95 },
                              { City: 'Mar', SalesQ1: 205000, SalesQ2: 275500, YoYGrowthQ1: 1.45, YoYGrowthQ2: 1.15 },
                              { City: 'Apr', SalesQ1: 187000, SalesQ2: 130100, YoYGrowthQ1: 0.45, YoYGrowthQ2: 0.55 },
                              { City: 'May', SalesQ1: 187000, SalesQ2: 113000, YoYGrowthQ1: 1.65, YoYGrowthQ2: 1.05 } 
                          ];

                      // prepare jqxChart settings
                      var settings = {
                    		   title: "Sales/Purchase",
                          enableAnimations: true,
                          showLegend: true,
                          padding: { left: 5, top: 5, right: 5, bottom: 5 },
                          titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
                          source: sampleData,
                          colorScheme: 'scheme01',
                          xAxis:
                          {
                              dataField: 'City',
                              valuesOnTicks: false
                          },
                          valueAxis:
                          {
                              unitInterval: 50000,
                              minValue: 50000,
                              maxValue: 350000,
                              title: { text: ' ' },
                              labels: {
                                  formatSettings: { prefix: 'RS-', thousandsSeparator: ',' },
                                  horizontalAlignment: 'right'
                              }
                          },
                          seriesGroups:
                              [
                                  {
                                      type: 'bubble',
                                      series: [
                                              { dataField: 'SalesQ1', radiusDataField: 'YoYGrowthQ1', minRadius: 10, maxRadius: 30, displayText: 'Sales' },
                                              { dataField: 'SalesQ2', radiusDataField: 'YoYGrowthQ2', minRadius: 10, maxRadius: 30, displayText: 'Purchase' }
                                          ]
                                  }
                              ]
                      };

                      // setup the chart
                      $('#chartContainer').jqxChart(settings);

                      var chart = $('#chartContainer').jqxChart('getInstance');

   /*                    // symbol selection drop down
                      var symbolsList = ["circle", "diamond", "square", "triangle_up", "triangle_down", "triangle_left", "triangle_right"];
                      $("#dropDownSerie1Symbol").jqxDropDownList({ source: symbolsList, selectedIndex: 0, width: '200', height: '25', dropDownHeight: 100 });

                      $('#dropDownSerie1Symbol').on('change', function (event) {
                          var value = event.args.item.value;
                          chart.seriesGroups[0].series[0].symbolType = value;
                          chart.update();
                      });

                      $("#dropDownSerie2Symbol").jqxDropDownList({ source: symbolsList, selectedIndex: 0, width: '200', height: '25', dropDownHeight: 100 });

                      $('#dropDownSerie2Symbol').on('change', function (event) {
                          var value = event.args.item.value;
                          chart.seriesGroups[0].series[1].symbolType = value;
                          chart.update();
                      });
        }); */
        
        
        
        var data = [];

        var max = 800;
        var timestamp = new Date();
        for (var i = 0; i < 60; i++) {
            timestamp.setMilliseconds(0);
            timestamp.setSeconds(timestamp.getSeconds() - 1);

            data.push({ timestamp: new Date(timestamp.valueOf()), value: Math.max(100, (Math.random() * 1000) % max) });
        }

        data = data.reverse();


        // prepare jqxChart settings
        var settings = {
            title: "Live  Update",
            description: " ",
            enableAnimations: false,
            animationDuration: 1000,
            enableAxisTextAnimation: true,
            showLegend: true,
            padding: { left: 5, top: 5, right: 5, bottom: 5 },
            titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
            source: data,
            xAxis:
            {
                dataField: 'timestamp',
                type: 'date',
                baseUnit: 'second',
                unitInterval: 5,
                formatFunction: function (value) {
                    return $.jqx.dataFormat.formatdate(value, "hh:mm:ss", 'en-us');
                },
                gridLines: { step: 2 },
                valuesOnTicks: true,
                labels: { angle: -45, offset: { x: -17, y: 0} }
            },
            colorScheme: 'scheme01',
            seriesGroups:
                [
                    {
                        type: 'line',
                        columnsGapPercent: 50,
                        alignEndPointsWithIntervals: true,
                        valueAxis:
                        {
                            minValue: 0,
                            maxValue: 1000,
                            title: { text: 'Index Value' }
                        },
                        series: [
                                { dataField: 'value', displayText: 'value', opacity: 1, lineWidth: 2, symbolType: 'circle', fillColorSymbolSelected: 'white', symbolSize: 4 }
                            ]
                    }
                ]
        };


        // create the chart
        $('#chartContainer111').jqxChart(settings);

        // get the chart's instance
        var chart = $('#chartContainer111').jqxChart('getInstance');

        // color scheme drop down
/*         var colorsSchemesList = ["scheme01", "scheme02", "scheme03", "scheme04", "scheme05", "scheme06", "scheme07", "scheme08"];
        $("#dropDownColors").jqxDropDownList({ source: colorsSchemesList, selectedIndex: 2, width: '200', height: '25', dropDownHeight: 100 });

        $('#dropDownColors').on('change', function (event) {
            var value = event.args.item.value;
            chart.colorScheme = value;
            chart.update();
        });

        // series type drop down
        var seriesList = ["line", "area", "stepline", "steparea", "splinearea", "spline", "column", "scatter", "stackedcolumn", "stackedsplinearea", "stackedspline"];
        $("#dropDownSeries").jqxDropDownList({ source: seriesList, selectedIndex: 0, width: '200', height: '25', dropDownHeight: 100 });

        $('#dropDownSeries').on('select', function (event) {
            var args = event.args;
            if (args) {
                var value = event.args.item.value;
                var group = chart.seriesGroups[0];
                chart.seriesGroups[0].type = value;
                chart.update();
            }
        }); */

        // auto update timer
        var ttimer = setInterval(function () {
            var max = 800;
            if (data.length >= 60)
                data.splice(0, 1);
            var timestamp = new Date();
            timestamp.setSeconds(timestamp.getSeconds());
            timestamp.setMilliseconds(0);

            data.push({ timestamp: timestamp, value: Math.max(100, (Math.random() * 1000) % max) });

            $('#chartContainer111').jqxChart('update');
        }, 1000);
        
        
        
        
        
        
        var sampleData = [
                          { Day: 'Monday', Keith: 30, Erica: 15, George: 25 },
                          { Day: 'Tuesday', Keith: 25, Erica: 25, George: 30 },
                          { Day: 'Wednesday', Keith: 30, Erica: 20, George: 25 },
                          { Day: 'Thursday', Keith: 35, Erica: 25, George: 45 },
                          { Day: 'Friday', Keith: 20, Erica: 20, George: 25 },
                          { Day: 'Saturday', Keith: 30, Erica: 20, George: 30 },
                          { Day: 'Sunday', Keith: 60, Erica: 45, George: 90 }
                  ];

                  // prepare jqxChart settings
                  var settings = {
                      title: " ",
                      description: " ",
                      enableAnimations: true,
                      showLegend: true,
                      padding: { left: 5, top: 5, right: 5, bottom: 5 },
                      titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
                      source: sampleData,
                      xAxis:
                          {
                              dataField: 'Day',
                              gridLines: { visible: true }
                          },
                      colorScheme: 'scheme01',
                      seriesGroups:
                          [
                              {
                                  type: 'column',
                                  columnsGapPercent: 50,
                                  seriesGapPercent: 0,
                                  valueAxis:
                                  {
                                      visible: true,
                                      unitInterval: 10,
                                      minValue: 0,
                                      maxValue: 100,
                                      title: { text: 'Time in minutes' }
                                  },
                                  series: [
                                          { dataField: 'Keith', displayText: 'Prd1' },
                                          { dataField: 'Erica', displayText: 'prd2' },
                                          { dataField: 'George', displayText: 'Prd3' }
                                  ]
                              }
                          ]
                  };

                  // setup the chart
                  $('#jqxChart').jqxChart(settings);

                  var adapter = new $.jqx.dataAdapter({
                      datafields: [
                          { name: "Day", type: "string" },
                          { name: "Keith", type: "number" },
                          { name: "Erica", type: "number" },
                          { name: "George", type: "number" }
                      ],
                      localdata: sampleData,
                      datatype: 'array'
                  });

                  $("#jqxGrid").jqxGrid({
                      width: 500,
                      height: 293,
                      filterable: true,
                      showfilterrow: true,
                      source: adapter,
                      columns:
                      [
                          { text: "Day", width: '40%', datafield: "Day", filteritems: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], filtertype: "checkedlist" },
                          { text: "Prd1", width: '20%', datafield: "Keith" },
                          { text: "prd2", width: '20%', datafield: "Erica" },
                          { text: "prd3", width: '20%', datafield: "George" }
                      ]
                  });
                  $("#jqxGrid").on('filter', function () {
                      var rows = $("#jqxGrid").jqxGrid('getrows');
                      var chart = $('#jqxChart').jqxChart('getInstance');
                      chart.source = rows;
                      chart.update();
                  });
    }); 
    
    
 
    </script>
    
    
    
    
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 662px;
}



 
 
/* width */
::-webkit-scrollbar {
    width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
    box-shadow: inset 0 0 5px grey; 
    border-radius: 10px;
}
 
/* Handle */
::-webkit-scrollbar-thumb {
    background: #7163e8; 
    border-radius: 10px;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
    background: #5d4cef; 
}


/* body{
  background: #215A6D;
  font: 12pt Georgia;
  color: #f2f2f2;
  margin: 0;
  padding: 0;
}

a{
  color: #f2f2f2;
  text-decoration: none;
}

#footer{
  margin-bottom: -150px;
  clear: both;
}

.tomottoWrap{
  position: relative;
  background: #3CA2A2;
}

#tomotto{
  text-align: center;
  width: 960px;
  letter-spacing: 2px;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
  line-height: 36px;
  margin: auto;
}

.lookWrap{
  position: relative; 
  background-color: #215A6D;
  float: left;
  width: 100%;
}

#look{
  margin: auto;
  width: 700px;
}

.section{
  overflow: hidden;
  float: left;
  display: inline;
  width: 160px;
  margin: 0 15px 15px 0;
  font: 10pt verdana;
  line-height: 1.6em;
}

.section h3{
  font-weight: normal;
  font: 12pt Georgia;
  text-transform: uppercase;
  color: #f2f2f2;
}

.section a{
  display: block;
}

.legality{
  margin: auto;
  width: 700px;
  text-align: center;
  clear: both;
  font: 10pt verdana;
  line-height: 2em;
  padding: 40px 0 0 0;
} */


/* REMOVE THIS, USE YOUR OWN  */
 
.dummy_page {
  height: 200px;
  width: 100%;
  background-color: #f0f0f0;
  text-align: center;
  box-sizing: border-box;
  padding: 60px 0px;
}
/* STYLES SPECIFIC TO FOOTER  */
.footer {
  width: 100%;
  position: relative;
  height: auto;
  background-color: 	#000000;/* #070617; */
}
.footer .col {
  width: 190px;
  height: auto;
  float: left;
  box-sizing: border-box;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  padding: 0px 20px 20px 20px;
}
.footer .col h1 {
  margin: 0;
  padding: 0;
  font-family: inherit;
  font-size: 12px;
  line-height: 17px;
  padding: 20px 0px 5px 0px;
  color: rgba(255,255,255,0.2);
  font-weight: normal;
  text-transform: uppercase;
  letter-spacing: 0.250em;
}
.footer .col ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}
.footer .col ul li {
  color: #999999;
  font-size: 14px;
  font-family: inherit;
  font-weight: bold;
  padding: 5px 0px 5px 0px;
  cursor: pointer;
  transition: .2s;
  -webkit-transition: .2s;
  -moz-transition: .2s;
}
.social ul li {
  display: inline-block;
  padding-right: 5px !important;
}

.footer .col ul li:hover {
  color: #ffffff;
  transition: .1s;
  -webkit-transition: .1s;
  -moz-transition: .1s;
}
.clearfix {
  clear: both;
    color: #ffffff;
  transition: .1s;
  -webkit-transition: .1s;
  -moz-transition: .1s;
}
@media only screen and (min-width: 1280px) {
  .contain {
    width: 1200px;
    margin: 0 auto;
  }
}
@media only screen and (max-width: 1139px) {
  .contain .social {
    width: 1000px;
    display: block;
  }
  .social h1 {
    margin: 0px;
  }
}
@media only screen and (max-width: 950px) {
  .footer .col {
    width: 33%;
  }
  .footer .col h1 {
    font-size: 14px;
  }
  .footer .col ul li {
    font-size: 13px;
  }
}
@media only screen and (max-width: 500px) {
    .footer .col {
      width: 50%;
    }
    .footer .col h1 {
      font-size: 14px;
    }
    .footer .col ul li {
      font-size: 13px;
    }
}
@media only screen and (max-width: 340px) {
  .footer .col {
    width: 100%;
  }
}
/* 
\\\\\\\ */


ody {
    position: relative;
    overflow-x: hidden;
}
body,
html { height: 100%;}
.nav .open > a, 
.nav .open > a:hover, 
.nav .open > a:focus {background-color: transparent;}

/*-------------------------------*/
/*           Wrappers            */
/*-------------------------------*/

#wrapper {
    padding-left: 0;
    -webkit-transition: all 0.5s ease;
    -moz-transition: all 0.5s ease;
    -o-transition: all 0.5s ease;
    transition: all 0.5s ease;
}

#wrapper.toggled {
    padding-left: 220px;
}

#sidebar-wrapper {
    z-index: 1000;
    left: 220px;
    width: 0;
    height: 100%;
    margin-left: -220px;
    overflow-y: auto;
    overflow-x: hidden;
    background: #1a1a1a;
    -webkit-transition: all 0.5s ease;
    -moz-transition: all 0.5s ease;
    -o-transition: all 0.5s ease;
    transition: all 0.5s ease;
}

#sidebar-wrapper::-webkit-scrollbar {
  display: none;
}

#wrapper.toggled #sidebar-wrapper {
    width: 220px;
}

#page-content-wrapper {
    width: 100%;
    padding-top: 0px;
}

#wrapper.toggled #page-content-wrapper {
    position: absolute;
    margin-right: -220px;
}

/*-------------------------------*/
/*     Sidebar nav styles        */
/*-------------------------------*/

.sidebar-nav {
    position: absolute;
    top: 0;
    width: 220px;
    margin: 0;
    padding: 0;
    list-style: none;
}

.sidebar-nav li {
    position: relative; 
    line-height: 20px;
    display: inline-block;
    width: 100%;
}

.sidebar-nav li:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    z-index: -1;
    height: 100%;
    width: 3px;
    background-color: #1c1c1c;
    -webkit-transition: width .2s ease-in;
      -moz-transition:  width .2s ease-in;
       -ms-transition:  width .2s ease-in;
            transition: width .2s ease-in;

}
.sidebar-nav li:first-child a {
    color: #fff;
    background-color: #1a1a1a;
}
.sidebar-nav li:nth-child(2):before {
    background-color: #ec1b5a;   
}
.sidebar-nav li:nth-child(3):before {
    background-color: #79aefe;   
}
.sidebar-nav li:nth-child(4):before {
    background-color: #314190;   
}
.sidebar-nav li:nth-child(5):before {
    background-color: #279636;   
}
.sidebar-nav li:nth-child(6):before {
    background-color: #7d5d81;   
}
.sidebar-nav li:nth-child(7):before {
    background-color: #ead24c;   
}
.sidebar-nav li:nth-child(8):before {
    background-color: #2d2366;   
}
.sidebar-nav li:nth-child(9):before {
    background-color: #35acdf;   
}
.sidebar-nav li:hover:before,
.sidebar-nav li.open:hover:before {
    width: 100%;
    -webkit-transition: width .2s ease-in;
      -moz-transition:  width .2s ease-in;
       -ms-transition:  width .2s ease-in;
            transition: width .2s ease-in;

}

.sidebar-nav li a {
    display: block;
    color: #ddd;
    text-decoration: none;
    padding: 10px 15px 10px 30px;    
}

.sidebar-nav li a:hover,
.sidebar-nav li a:active,
.sidebar-nav li a:focus,
.sidebar-nav li.open a:hover,
.sidebar-nav li.open a:active,
.sidebar-nav li.open a:focus{
    color: #fff;
    text-decoration: none;
    background-color: transparent;
}

.sidebar-nav > .sidebar-brand {
    height: 65px;
    font-size: 20px;
    line-height: 44px;
}
.sidebar-nav .dropdown-menu {
    position: relative;
    width: 100%;
    padding: 0;
    margin: 0;
    border-radius: 0;
    border: none;
    background-color: #222;
    box-shadow: none;
}

/*-------------------------------*/
/*       Hamburger-Cross         */
/*-------------------------------*/

.hamburger {
  position: fixed;
  top: 20px;  
  z-index: 999;
  display: block;
  width: 32px;
  height: 32px;
  margin-left: 15px;
  background: transparent;
  border: none;
}
.hamburger:hover,
.hamburger:focus,
.hamburger:active {
  outline: none;
}
.hamburger.is-closed:before {
  content: '';
  display: block;
  width: 100px;
  font-size: 14px;
  color: #fff;
  line-height: 32px;
  text-align: center;
  opacity: 0;
  -webkit-transform: translate3d(0,0,0);
  -webkit-transition: all .35s ease-in-out;
}
.hamburger.is-closed:hover:before {
  opacity: 1;
  display: block;
  -webkit-transform: translate3d(-100px,0,0);
  -webkit-transition: all .35s ease-in-out;
}

.hamburger.is-closed .hamb-top,
.hamburger.is-closed .hamb-middle,
.hamburger.is-closed .hamb-bottom,
.hamburger.is-open .hamb-top,
.hamburger.is-open .hamb-middle,
.hamburger.is-open .hamb-bottom {
  position: absolute;
  left: 0;
  height: 4px;
  width: 100%;
}
.hamburger.is-closed .hamb-top,
.hamburger.is-closed .hamb-middle,
.hamburger.is-closed .hamb-bottom {
  background-color: #1a1a1a;
}
.hamburger.is-closed .hamb-top { 
  top: 5px; 
  -webkit-transition: all .35s ease-in-out;
}
.hamburger.is-closed .hamb-middle {
  top: 50%;
  margin-top: -2px;
}
.hamburger.is-closed .hamb-bottom {
  bottom: 5px;  
  -webkit-transition: all .35s ease-in-out;
}

.hamburger.is-closed:hover .hamb-top {
 top: 0;
  -webkit-transition: all .35s ease-in-out;
}
.hamburger.is-closed:hover .hamb-bottom {
  bottom: 0;
  -webkit-transition: all .35s ease-in-out;
}
.hamburger.is-open .hamb-top,
.hamburger.is-open .hamb-middle,
.hamburger.is-open .hamb-bottom {
  background-color: #1a1a1a;
}
.hamburger.is-open .hamb-top,
.hamburger.is-open .hamb-bottom {
  top: 50%;
  margin-top: -2px;  
}
.hamburger.is-open .hamb-top { 
  -webkit-transform: rotate(45deg);
  -webkit-transition: -webkit-transform .2s cubic-bezier(.73,1,.28,.08);
}
.hamburger.is-open .hamb-middle { display: none; }
.hamburger.is-open .hamb-bottom {
  -webkit-transform: rotate(-45deg);
  -webkit-transition: -webkit-transform .2s cubic-bezier(.73,1,.28,.08);
}
.hamburger.is-open:before {
  content: '';
  display: block;
  width: 100px;
  font-size: 14px;
  color: #fff;
  line-height: 32px;
  text-align: center;
  opacity: 0;
  -webkit-transform: translate3d(0,0,0);
  -webkit-transition: all .35s ease-in-out;
}
.hamburger.is-open:hover:before {
  opacity: 1;
  display: block;
  -webkit-transform: translate3d(-100px,0,0);
  -webkit-transition: all .35s ease-in-out;
}

/*-------------------------------*/
/*            Overlay            */
/*-------------------------------*/

.overlay {
    position: fixed;
    display: none;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(250,250,250,.8);
    z-index: 1;
}

#myCarousel {
background: rgba(0, 0, 0, 0.9);


}


.mainimg  {
    opacity: 0.4;
    filter: alpha(opacity=50); /* For IE8 and earlier */
}



.mainmenus  {
    -webkit-transition: all .35s ease-in-out;
}

 
@import "compass/css3";
@import url(https://fonts.googleapis.com/css?family=Roboto);

body {
  font-family: 'Roboto', sans-serif;
}

.headingcontainer {
  width: 900px;
  margin: 0 auto;
}

 
/* HEADING 1 */

.heading1 h3 {
  margin: 0 auto;
  text-align: center;
}

.heading1 h3 {
  color: #5c5c5c;
  width: 75%;
  font-size: 2rem;
  letter-spacing: .2em;
  text-transform: uppercase;
  font-weight: 400;
  line-height: 0.5em;
  position: relative;
  padding: 1em 0 1em;
  border-bottom: 5px solid #ccc;
}

/* HEADING 2*/

.heading2 h3 {
    text-transform: uppercase;
    font-size: 3em;
    text-shadow: 1px 5px 0 rgba(0,0,0,0.2);
    color: #B40101;
    border-bottom: 1px dotted #333;
    padding-bottom: 0.5em;
    text-align: center;
    margin-bottom: 1em;
    letter-spacing: 1px;
}

/* HEADING 3*/

.heading3 h3 {
  overflow: hidden;
  text-align: center;
  text-transform: uppercase;
  letter-spacing: 3px;
  font-size: 3em;
}

.heading3 h3:before,
.heading3 h3:after {
  content: '';
  display: inline-block;
  height: 1px;  
  position: relative;
  top: -2px;
  vertical-align: middle;
}

.heading3 h3:before {
  background-color: #555;
  left: -.5em;
  margin-left: -100%;
  width: 100%;
}

.heading3 h3:after {
  background-color: #555;
  left: .5em;
  margin-right: -100%;
  width: 100%;
}

/* HEADING 4 */

.heading4 h3 {
  margin-top: 50px;
  display: -webkit-flex;
  display: flex;
  width: 100%;
  font-size: 2em;
  letter-spacing: 2px;
  font-weight: 100;
}

.heading4 h3:after {
  -webkit-flex: 3;
  -flex:3;
  display: inline-block;
  content: "";
  height: 1px;
  background: #999;
  margin: auto 0 auto 20px;
}

/* icons/logogatetrans.png */

hr.style-eight {
    overflow: visible; /* For IE */
    padding: 0;
    border: none;
    border-top: medium double #91a0ea;
    color: #91a0ea;
    text-align: center;
}
hr.style-eight:after {  /* § */
    content: "gatewayerp.com";
    display: inline-block;
    position: relative;
    top: -0.7em;
    font-size: 1em;
    padding: 0 0.25em;
    background: white;
}
</style>
    
</head>
<body style="background-color: #ffff;"  >
<div class='hidden-scrollbar'  >
 
  <div id="wrapper">
        <div class="overlay"></div>
    
        <!-- Sidebar -->
        <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
            <ul class="nav sidebar-nav">
                <li class="sidebar-brand">
                    <a href="#">
                        <img src="icons/gateway_logo.gif"  style="width:150px;height: 50px;" alt="#">
                    </a>
                </li>
                <li>
                    <a href="#">Product</a>
                </li>
                <li>
                    <a href="#purchasid" class="mainmenus">Purchase</a>
                </li>
                <li>
                    <a href="#">Sale</a>
                </li>
                <li>
                    <a href="#">Analysis</a>
                </li>
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Inventory <span class="caret"></span></a>
                  <ul class="dropdown-menu" role="menu">
                    <li class="dropdown-header">Stock Details</li>
                    <li><a href="#">Stock List</a></li>
                  </ul>
                </li>
                
                <li>
                    <a href="#">Reports</a>
                </li>
                 
            </ul>
        </nav>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper"> 
            <button type="button" class="hamburger is-closed" data-toggle="offcanvas">
                <span class="hamb-top"></span>
    			<span class="hamb-middle"></span>
				<span class="hamb-bottom"></span>
            </button>
          
        
       
          <div class="container"  style="margin-top: 100px">
  <div class="row" align="center" >
 
 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
    
           <img src="icons/gw.png"    style="width:500px;height: 100px;" >
           
           </div></div>
 <div class="row" align="center" >
 
 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
 
 <div id="myCarousel" class="carousel slide" data-ride="carousel" style="op" >
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner">
    <div class="item active">
     
       <img src="icons/Reports2.png"  class="mainimg"  style="width:900px;height: 600px ;" >
    </div>

    <div class="item">
      <img src="icons/Reports1.png"   class="mainimg"  style="width:900px;height: 600px ;"  >
    </div>

    <div class="item">
      <img src="icons/Reports4.jpg" class="mainimg"  style="width:900px;height: 600px ;" >
    </div>
  </div>

  <!-- Left and right controls -->
  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
 </div>
 </div>
 </div>
 
 
 
          
<div class="container"  id="purchasid" style="margin-top: 100px">

 

  <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3>Product</h3></div>
  </div>

  </div>

    <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
 <div id="listdiv6"><jsp:include page="productlistgrid.jsp"></jsp:include></div>
 </div>
 

 </div>

  <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
   <hr class="style-eight">
  </div>
  </div>

  <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3>Purchase</h3></div>
  </div>

  </div>
 

  <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
 <div id="listdiv"><jsp:include page="purchaseGrid.jsp"></jsp:include></div>
 </div></div>
 <div class="row" align="center" >
   <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><br>
   </div>
 </div>
 
 <div class="row" align="center" >
 
<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" ><div id="jqxGrid"></div></div>
<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" ><div id='jqxChart' style="margin-top: 1px; width: 500px; height: 300px; position: relative;">
    </div></div>
  
  </div>
  
    <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
   <hr class="style-eight">
  </div>
  </div>
  
 <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3>Sales</h3></div>
  </div>

  </div>
 
   <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
 <div id="listdiv1"><jsp:include page="salesGrid.jsp"></jsp:include></div>
 </div></div>
 <div class="row" align="center" >
   <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><br>
   </div>
 </div>
 
 
 
      <div class="row" >

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
 
   <div id='sales' style="width: 500px; height: 300px;"></div>
		       
</div>

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
 <div id='chartContainer' style="width:500px; height:300px">

		    </div>
</div>
</div>
 
   <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
   <hr class="style-eight">
  </div>
  </div>
 
  <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3>Analysis</h3></div>
  </div>

  </div>
 
 
      <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
 <div id="listdiv4"><jsp:include page="stockanalysisgrid.jsp"></jsp:include></div>
 </div></div>
 
      <div class="row" >
   <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
   <br></div>
   </div>
 
  <div class="row" >
 
 
<div class="container"  style="border: 1px red" >
 
 <div class="row" >
<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >

 <div class="row" >
 <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
<div id='chartContainer1' style="width: 250px; height: 180px;"></div>
</div>

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
<div id='chartContainer2' style="width: 250px; height: 180px;"></div>
</div>


 </div>
 
 

 
 
  <div class="row" >

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
<div id='chartContainer3' style="width: 250px; height: 180px;"></div>
</div>

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
<div id='chartContainer4' style="width: 250px; height: 180px;"></div>
</div>
</div>
   
   </div>
 
  
 
 <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
 
 <div id='chartContainer5' style="width:500px; height: 355px;"></div>
 
 </div>
 
 
 

</div>
 
 
 </div>
 
 </div>
 
 
   <div class="row" >
   <br><br>
   </div>
     <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
   <hr class="style-eight">
  </div>
  </div>
 
   <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3>Inventory</h3></div>
  </div>

  </div>

   
   
     <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading4"><h3>Stock List</h3></div>
  </div>

  </div>
   
   
      <div class="row" align="center" >
  
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
 <div id="listdiv3"><jsp:include page="stockGrid.jsp"></jsp:include></div>
 </div></div>
   
    <div class="row" >
   <br><br>
   </div>
   
        <div class="row" >

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
  <div id='inventory1' style="width: 500px; height: 300px;"></div>
</div>

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6" >
  <div id='chartContainer111' style="width: 500px; height: 300px;">
   </div>
</div>
</div>
 
     <div class="row" >
   <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
   <br></div>
   </div>





</div>
 
        </div>
 </div>
 
<!--  
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      
    </div>
    <ul class="nav navbar-nav">
 
          <li> <img src="icons/gateway_logo.gif"  style="width:300px;height: 50px;" alt="#">
                          </li>
          
        
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
    </ul>
  </div>
</nav>
   -->
 
<div class="footer">
  <div class="contain">


  
  <div class="col">
    <!-- <h1>Accounts</h1>
    <ul>
      <li>About</li>
      <li>Mission</li>
      <li>Services</li>
      <li>Social</li>
      <li>Get in touch</li>
    </ul> -->
  </div>
  
<div class="clearfix" align="center"> 
GW Innovations Private Limited &#169; 2018 
 </div>
 <br>
<div class="clearfix" align="center"> 
 
Powered by Gateway ERP</div>
</div>
<br><br>
</div>
<input type="hidden" id="hidbrandgarage" name="hidbrandgarage" value='<s:property value="hidbrandgarage"/>'/>
</div> 
 
</body>
</html>