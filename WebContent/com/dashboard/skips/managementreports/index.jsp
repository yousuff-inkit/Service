<%@include file = "enquiryStatus.jsp" %>

<%ClsStatusDAO sd= new ClsStatusDAO(); %>

<!DOCTYPE html>
<jsp:include page="temp.jsp"></jsp:include>   
<% String contextPath=request.getContextPath();%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>GatewayERP(i)</title>
 


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
        #psearch {
background:#FAEBD7;
 
}  

.button3:hover {background-color: #3e8e41}

.button3:active {
  background-color: #3e8e41;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
        .button {
    background-color: #3498db;
    border: thin;
    color: white;
    padding: 7px 20px;
    text-align: justify;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    margin: 4px 2px;
    border-radius: 28px;
    cursor: pointer;
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
}
.button2:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
     background-color: graytext;
}
.textbox {
    border: 0;
    height: 25px;    
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
} 
.no-js #loader { display: none;  }
.js #loader { display: block; position: absolute; left: 100px; top: 0; }
.se-pre-con {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url(https://smallenvelop.com/wp-content/uploads/2014/08/Preloader_3.gif) center no-repeat #fff;
}
    </style>
  <link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
  <script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.js"></script>  
<script type="text/javascript">  
function reload(){
	$('#pnames').load('client.jsp');
}
       $(document).ready(function () {
    	   $(".jqx-chart-legend-text:contains('www.jqwidgets.com')").css('opacity','0');	
    	   $("#fromdate").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
  		 $("#todate").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
  		 $("#fromdate2").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
  		 $("#todate2").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
  		$("#fromdate3").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
 		 $("#todate3").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
		 $("#fromdate6").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
		 $("#todate6").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
		 $("#fromdate8").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
		$("#todate8").jqxDateTimeInput({ width: '110px', height: '30px',formatString:"dd.MM.yyyy"});
    		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-6)); 
    		    
    	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
    		 $('#todate').on('change', function (event) {
    				
    			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    			 
    			  // out date
    			 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
    			 	 
    			   if(fromdates>todates){
    				   
    				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
    				 
    			   return false;
    			  }   
    			 
    		 }); 
    		 var fromdates2=new Date($('#fromdate2').jqxDateTimeInput('getDate'));
    		 var onemounth2=new Date(new Date(fromdates2).setMonth(fromdates2.getMonth()-6)); 
    		    
    	     $('#fromdate2').jqxDateTimeInput('setDate', new Date(onemounth2));
    		 $('#todate2').on('change', function (event) {
    				
    			   var fromdates2=new Date($('#fromdate2').jqxDateTimeInput('getDate'));
    			 
    			  // out date
    			 	 var todates2=new Date($('#todate2').jqxDateTimeInput('getDate')); //del date
    			 	 
    			   if(fromdates2>todates2){
    				   
    				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
    				 
    			   return false;
    			  }   
    			 
    		 }); 
    		 var fromdates3=new Date($('#fromdate3').jqxDateTimeInput('getDate'));
    		 var onemounth3=new Date(new Date(fromdates3).setMonth(fromdates3.getMonth()-6)); 
    		    
    	     $('#fromdate3').jqxDateTimeInput('setDate', new Date(onemounth3));
    		 $('#todate3').on('change', function (event) {
    				
    			   var fromdates3=new Date($('#fromdate3').jqxDateTimeInput('getDate'));
    			 
    			  // out date
    			 	 var todates3=new Date($('#todate3').jqxDateTimeInput('getDate')); //del date
    			 	 
    			   if(fromdates3>todates3){
    				   
    				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
    				 
    			   return false;
    			  }   
    			 
    		 });
    		 
    		  var fromdates8=new Date($('#fromdate8').jqxDateTimeInput('getDate'));
    		 var onemounth8=new Date(new Date(fromdates8).setMonth(fromdates8.getMonth()-1)); 
    		    
    	     $('#fromdate8').jqxDateTimeInput('setDate', new Date(onemounth8));
    		 $('#todate8').on('change', function (event) {
    				
    			   var fromdates8=new Date($('#fromdate8').jqxDateTimeInput('getDate'));
    			 
    			  // out date
    			 	 var todates8=new Date($('#todate8').jqxDateTimeInput('getDate')); //del date
    			 	 
    			   if(fromdates8>todates8){
    				   
    				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
    				 
    			   return false;
    			  }   
    			 
    		 });  
    		 var fromdates9=new Date($('#fromdate6').jqxDateTimeInput('getDate'));
    		 var onemounth9=new Date(new Date(fromdates9).setMonth(fromdates9.getMonth()-6)); 
    		    
    	     $('#fromdate6').jqxDateTimeInput('setDate', new Date(onemounth9));
    		 $('#todate6').on('change', function (event) {
    				
    			   var fromdates9=new Date($('#fromdate6').jqxDateTimeInput('getDate'));
    			 
    			  // out date
    			 	 var todates9=new Date($('#todate6').jqxDateTimeInput('getDate')); //del date
    			 	 
    			   if(fromdates9>todates9){
    				   
    				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
    				 
    			   return false;
    			  }   
    			 
    		 }); 
    		  $('[data-toggle="tooltip"]').tooltip(); 
          	// Add smooth scrolling to all links in navbar + footer link
          	  $(".wrapper, footer a[href='index.jsp']").on('click', function(event) {
          	    // Make sure this.hash has a value before overriding default behavior
          	    if (this.hash !== "") {
          	      // Prevent default anchor click behavior
          	      event.preventDefault();

          	      // Store hash
          	      var hash = this.hash;

          	      // Using jQuery's animate() method to add smooth page scroll
          	      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
          	      $('html, body').animate({
          	        scrollTop: $(hash).offset().top
          	      }, 900, function(){
          	   
          	        // Add hash (#) to URL when done scrolling (default click behavior)
          	        window.location.hash = hash;
          	      });
          	    } // End if
          	  });
          	  
          	  $(window).scroll(function() {
          	    $(".slideanim").each(function(){
          	      var pos = $(this).offset().top;

          	      var winTop = $(window).scrollTop();
          	        if (pos < winTop + 600) {
          	          $(this).addClass("slide");
          	        }
          	    });
          	  });
          	  $(".heading2").animate({ left: "320" }, 500, function () {
          	        $("#heading2").animate({ 'marginLeft': "-=50" }, 200);

          	    });


          	    setTimeout(function () {
          	        $("#heading2").animate({ left: "320" }, 500, function () {
          	            $("#heading2").animate({ left: "30" }, 500, function () {
          	                $("#heading2").animate({ left: "10" }, 200);
          	            });
          	            $("#heading2").animate({ 'marginLeft': "-=50" }, 200);
          	        });
          	    }, 1000);
          	
          	  
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
 				$(".jqx-chart-legend-text:contains('www.jqwidgets.com')").css('opacity','0');	
 				//$( "div:contains('John')" ).css( "text-decoration", "underline" );
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
 	                title: "",
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
//  	            $('#sales').jqxChart(settings);
 	        });
             
             var sampleData = [
                               { City: 'Jan', SalesQ1: 310500, SalesQ2: 210500, YoYGrowthQ1: 1.05, YoYGrowthQ2: 1.25 },
                               { City: 'Fen', SalesQ1: 120000, SalesQ2: 169000, YoYGrowthQ1: 1.15, YoYGrowthQ2: 0.95 },
                               { City: 'Mar', SalesQ1: 205000, SalesQ2: 275500, YoYGrowthQ1: 1.45, YoYGrowthQ2: 1.15 },
                               { City: 'Apr', SalesQ1: 187000, SalesQ2: 130100, YoYGrowthQ1: 0.45, YoYGrowthQ2: 0.55 },
                               { City: 'May', SalesQ1: 187000, SalesQ2: 113000, YoYGrowthQ1: 1.65, YoYGrowthQ2: 1.05 } 
                           ];

  
         
         var data = [];

         var max = 800;
         var timestamp = new Date();
         for (var i = 0; i < 60; i++) {
             timestamp.setMilliseconds(0);
             timestamp.setSeconds(timestamp.getSeconds() - 1);

             data.push({ timestamp: new Date(timestamp.valueOf()), value: Math.max(100, (Math.random() * 1000) % max) });
         }

         data = data.reverse();
       });
         function clearval(){
        	 var fromdates=new Date();
    		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    		    
    	     $('#fromdate9').jqxDateTimeInput('setDate', new Date(onemounth));
    		 $('#todate9').on('change', function (event) {
    				
    			   var fromdates=new Date($('#fromdate9').jqxDateTimeInput('getDate'));
    			 
    			  // out date
    			 	 var todates=new Date($('#todate9').jqxDateTimeInput('getDate')); //del date
    			 	 
    			   if(fromdates>todates){
    				   
    				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
    				 
    			   return false;
    			  }   
    			 
    		 })
    		$("#listdiv1").load(location.href + " #listdiv1");
        	$("#jqxloaddataGrid").jqxGrid('clear');
        	$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	document.getElementById("jqxInputServType").value="";
        	document.getElementById("jqxInputCode").value="";
        	document.getElementById("jqxInputName").value="";
        	document.getElementById("enqno").value="";
        	document.getElementById("jobno").value="";
        	document.getElementById("cldocno").value="";
        	$("#pnames").load("client.jsp");
        	$("#jobno1").load("jobno.jsp");
        	$("#enq1").load("enq.jsp");
        } 
        
    function checkvalue(){
    	var check=1;
    	var cldocno=document.getElementById("cldocno").value;
    	var enqno=document.getElementById("enqno").value;
    	var jobno=document.getElementById("jobno").value;
    	var fromdate = $('#fromdate9').val();
		 var todate = $('#todate9').val();
//      	alert(enqno);
     //alert(jobno);
     if(cldocno==""){
    	 $.messager.alert('Message','Please Select a Client','Warning');
    	 
    	 return false;
     }
    	$("#listdiv1").load("gridDetails.jsp?cldocno="+cldocno+'&enqno='+enqno+'&jobno='+jobno+'&check='+check+'&from='+fromdate+'&to='+todate);
    		
    }
   
function loadgrid(chkload){
	     var check=1;
    	 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var fromdate1 = $('#fromdate2').val();
		 var todate1 = $('#todate2').val();
		 var fromdate2 = $('#fromdate3').val();
		 var todate2 = $('#todate3').val();
		 var fromdate5 = $('#fromdate6').val();
		 var todate5 = $('#todate6').val();
		 var fromdate6 = $('#fromdate7').val();
		 var todate6 = $('#todate7').val();
		 var fromdate7 = $('#fromdate8').val();
		 var todate7 = $('#todate8').val();
		 var branch=$('#bhdocno').val();
		 var smdoc=$('#smdocno').val();
		 var stsdoc=$('#stsdocno').val();
		 var amount1=$('#amount1').val();
		 var amount2=$('#amount2').val();
		 var areadoc=$('#ardocno').val();
		 if(chkload==1){
			 $("#enqjob").load("enquirywithjobstatus.jsp?from="+fromdate+'&to='+todate+'&check='+check+'&branch='+branch+'&salesman='+smdoc);
			 $('#jqxInputBranchType').jqxInput('val', '');
			 $('#jqxInputSalesmanType').jqxInput('val', '');
			 $('#bhdocno').val('');
			 $('#smdocno').val('');
		 }
		 if(chkload==2){
			 $("#enqcount").load("enqsts.jsp?from="+fromdate1+'&to='+todate1+'&check='+check+'&branch='+branch+'&salesman='+smdoc+'&status='+stsdoc);
			 $('#jqxInputBranch2Type').jqxInput('val', '');
			 $('#jqxInputSalesman2Type').jqxInput('val', '');
			 //$('#jqxInputStatusType').jqxInput('val', '');
			 $('#bhdocno').val('');
			 $('#smdocno').val('');
			 //$('#stsdocno').val('');
		 }
		 if(chkload==3){
			 $("#jobcount").load("jobsts.jsp?from="+fromdate2+'&to='+todate2+'&check='+check+'&branch='+branch+'&salesman='+smdoc+'&status='+stsdoc);
			 $('#jqxInputBranch3Type').jqxInput('val', '');
			 $('#jqxInputSalesman3Type').jqxInput('val', '');
			 //$('#jqxInputStatus2Type').jqxInput('val', '');
			 $('#bhdocno').val('');
			 $('#smdocno').val('');
			 //$('#stsdocno').val('');
		 }
		 if(chkload==5){
			 $("#cshflw").load("cshflw.jsp?from="+fromdate5+'&to='+todate5+'&check='+check+'&branch='+branch+'&salesman='+smdoc);
			 $('#jqxInputBranch5Type').jqxInput('val', '');
			 $('#bhdocno').val('');
		 }
		 if(chkload==6){
			 $("#zone").load("zone.jsp?from="+fromdate7+'&to='+todate7+'&check='+check+'&branch='+branch+'&amount1='+amount1+'&amount2='+amount2);
			 $('#jqxInputBranch6Type').jqxInput('val', '');
			 $('#bhdocno').val('');
			
		 }
		 if(chkload==7){
			 $("#area").load("area.jsp?from="+fromdate6+'&check='+check+'&branch='+branch+'&areadoc='+areadoc);
			 $('#jqxInputBranch7Type').jqxInput('val', '');
			 $('#jqxInputAreaType').jqxInput('val', '');
			 $('#bhdocno').val('');
			 $('#ardocno').val('');
		 }
		 if(chkload==9){
			 $("#cntrenewdiv").load("cntrenewal.jsp?check=check");   
		 }
    }
 
    </script>
    
    
    
    
<style>
.hidden-scrollbar {
  overflow: scroll;
  height: 640px;
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
/* SCROLL */
footer .glyphicon {
      font-size: 20px;
      margin-bottom: 20px;
      color: #f4511e;
  }
  .slideanim {visibility:hidden;}
  .slide {
      animation-name: slide;
      -webkit-animation-name: slide;
      animation-duration: 1s;
      -webkit-animation-duration: 1s;
      visibility: visible;
  }
  @keyframes slide {
    0% {
      opacity: 0;
      transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      transform: translateY(0%);
    }
  }
  @-webkit-keyframes slide {
    0% {
      opacity: 0;
      -webkit-transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      -webkit-transform: translateY(0%);
    }
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
  width: 105%;
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
  padding: 0px 0px 0px 0px;
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


body {
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
/*     opacity: 0.4; */
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

#tblprdts .table-responsive {
	  overflow-y: visible !important;
	}
#tbloffer .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
</style>
    
</head>
<body onload="reload();" id="myPage"  data-spy="scroll" data-target=".navbar" data-offset="50" style="background-color: #ffff;"   >

<div class='hidden-scrollbar'  >
 
  <div id="wrapper">
        <div class="overlay"></div>
          <div class="container-fluid"  style="margin-top:5px">
  <div class="row" align="left" >
           <img src="icons/gw.png"    style="width:500px;height: 100px;" >
           
          </div>
 <div class="row" align="center" >
 
 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
 
 <div id="myCarousel" class="carousel slide" data-ride="carousel" style="op" >
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
    <li data-target="#myCarousel" data-slide-to="3"></li>
  </ol>

  <div class="carousel-inner" role="listbox" >
    <div class="item active">
     
       <img src="icons/Reports.jpg"  class="mainimg"  style="width:1500px;height: 400px ;" >
    </div>

    <div class="item">
      <img src="icons/pexels-photo-106344.jpeg" class="mainimg"  style="width:1500px;height:400px ;" >
    </div>
    
    <div class="item">
      <img src="icons/pexels-photo-1323592.jpeg" class="mainimg"  style="width:1500px;height: 400px ;" >
    </div>
    
    <div class="item">
      <img src="icons/Reports4.jpg" class="mainimg"  style="width:1500px;height: 400px ;" >
    </div>
  </div>

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
 
 <div class="row" align="center" >
<div class="heading2"><h3 style="font-family: Times New Roman;">Enquiry Contract Conversion</h3></div>  
  </div>

  <fieldset id="psearch" >
 <table width="100% ">   
   <tr>
          <td  width="10%" align="left"><b>From</b><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td>
          <td width="10%" align="left"><b>To</b><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td>
          <td width="18%" align="left" ><b>Branch</b> <div id="brch"    onkeydown="return (event.keyCode!=13);"><jsp:include page="branch.jsp"></jsp:include></div>
         <input type="hidden" id="bhdocno" name="bhdocno"/>
                    </td>  
          <td width="10%" align="left" ><b>Salesman</b>  <div id="slm"    onkeydown="return (event.keyCode!=13);"><jsp:include page="salesman.jsp"></jsp:include></div>
         <input type="hidden" id="smdocno" name="smdocno"/>
                    </td>  
           <td align="right">     
           
           &nbsp; <button id="setbtn4"  class="button button5"   onclick="loadgrid(1);"><b>Load</b></button>
           </td>
      </tr>          
   </table><br>          
 </fieldset> 
  <br><br>
  <div class="row" align="center" >
 <div class="row" align="center" >
 </div>
 
 <div class="row" align="center" >
 <div id="enqjob" style="width: 100%;"><jsp:include page="enquirywithjobstatus.jsp"></jsp:include></div></div> 
  </div> 

   <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3 style="font-family: Times New Roman;">Monthwise Salesman Revenue Achieved</h3></div>
  </div>
  </div>
  
   <fieldset id="psearch" >
 <table width="100% ">   
   <tr>
          <td width="10%" align="left"><b>From</b><div id='fromdate2' name='fromdate2' value='<s:property value="fromdate2"/>'></div>
                    </td>
          <td width="10%" align="left"><b>To</b><div id='todate2' name='todate2' value='<s:property value="todate2"/>'></div>
                    </td>
           <td width="18%" align="left" ><b>Branch</b> <div id="brch"    onkeydown="return (event.keyCode!=13);"><jsp:include page="branch2.jsp"></jsp:include></div>
         <input type="hidden" id="bhdocno" name="bhdocno"/>
                    </td>  
          <td width="18%" align="left" ><b>Salesman</b>  <div id="slm"    onkeydown="return (event.keyCode!=13);"><jsp:include page="salesman2.jsp"></jsp:include></div>
         <input type="hidden" id="smdocno" name="smdocno"/>
                    </td>  
           <td align="right">     
           
           &nbsp; <button id="setbtn5"  class="button button6"   onclick="loadgrid(2);"><b>Load</b></button>
           </td>
      </tr>          
   </table><br>          
 </fieldset> 
 <br><br>
  <div class="row" align="center" >
 <div class="row" align="center" >
 </div>
 
 <div class="row" align="center" >
<div id="enqcount" style="width: 100%;"><jsp:include page="enqsts.jsp"></jsp:include></div></div>
  </div>  
 
<div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3 style="font-family: Times New Roman;">Salesman Revenue Comparison</h3></div>
  </div>
  </div>

  <fieldset id="psearch" >
 <table width="100% ">   
   <tr>
          <td width="10%" align="left"><b>From</b><div id='fromdate3' name='fromdate3' value='<s:property value="fromdate3"/>'></div>
                    </td>
          <td width="10%" align="left"><b>To</b><div id='todate3' name='todate3' value='<s:property value="todate3"/>'></div>
                    </td>
          <td width="18%" align="left" ><b>Branch</b> <div id="brch"    onkeydown="return (event.keyCode!=13);"><jsp:include page="branch3.jsp"></jsp:include></div>
         <input type="hidden" id="bhdocno" name="bhdocno"/>
                    </td>  
           <td align="right">     
           
           &nbsp; <button id="setbtn7"  class="button button8"   onclick="loadgrid(3);"><b>Load</b></button>
           </td>
      </tr>          
   </table><br>          
 </fieldset> 
  
 <br><br>
 <div class="row" align="center" >
 <div class="row" align="center" >
 </div>
 
 <div class="row" align="center" >
<div id="jobcount" style="width: 80%;"><jsp:include page="jobsts.jsp"></jsp:include></div></div>
  </div>  
<div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3 style="font-family: Times New Roman;">Total Quotation & Projections Report</h3></div>
  </div>
  </div>

  <fieldset id="psearch" >
 <table width="100% ">   
   <tr>
         <td width="10%" align="left"><b>From</b><div id='fromdate6' name='fromdate6' value='<s:property value="fromdate6"/>'></div>
                    </td>
           <td width="10%" align="left"><b>To</b><div id='todate6' name='todate6' value='<s:property value="todate6"/>'></div>
                    </td> 
           <td align="right">     
           &nbsp; <button id="setbtn11"  class="button button11"   onclick="loadgrid(5);"><b>Load</b></button>
           </td>
      </tr>          
   </table><br>          
 </fieldset> 
  <br><br>
 <div class="row" align="center" >
 <div class="row" align="center" >
 </div>
 
 <div class="row" align="center" >
<div id="cshflw" style="width: 100%;"><jsp:include page="cshflw.jsp"></jsp:include></div></div>
  </div>  
 <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3 style="font-family: Times New Roman;">Lead Source Revenue Closed Report</h3></div>
  </div>
  </div>

  <fieldset id="psearch">
 <table width="100% ">   
   <tr>
          <td width="10%" align="left"><b>From</b><div id='fromdate8' name='fromdate8' value='<s:property value="fromdate8"/>'></div>
                    </td>
          <td width="10%" align="left"><b>To</b><div id='todate8' name='todate8' value='<s:property value="todate8"/>'></div>
                    </td>
           <td align="right">     
           &nbsp; <button id="setbtn13"  class="button button13"   onclick="loadgrid(6);"><b>Load</b></button>
           </td>
      </tr>          
   </table><br>          
 </fieldset> 
 <br><br> 
 
 <div class="row" align="center" >
 <div class="row" align="center" >
 </div>
 
 <div class="row" align="center" >
<div id="zone" style="width: 80%;"><jsp:include page="zone.jsp"></jsp:include></div></div>
  </div>  
  
   <div class="row" align="center" >
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
<div class="heading2"><h3 style="font-family: Times New Roman;">Contract Renewal</h3></div>
  </div>
  </div>

  <fieldset id="psearch">
 <table width="100% ">   
   <tr>
          <td width="10%" align="left">&nbsp;</td>
          <td width="10%" align="left">&nbsp;</td>
           <td align="right">     
           &nbsp; <button id="setbtn14"  class="button button14"   onclick="loadgrid(9);"><b>Load</b></button>
           </td>
      </tr>          
   </table><br>          
 </fieldset> 
 <br><br> 
 
 <div class="row" align="center" >
 <div class="row" align="center" >
 </div>
 
 <div class="row" align="center" >
<div id="cntrenewdiv" style="width: 80%;"><jsp:include page="cntrenewal.jsp"></jsp:include></div></div>
  </div> 
  
  
<br><br><br>
 <div class="footer" style="margin-right: 0px">
  <div class="container-fluid">

<div class="clearfix" align="center">
<br>
<a href="index.jsp" data-toggle="tooltip" title="To Top">
    <span class="glyphicon glyphicon-circle-arrow-up" style="color: white;"></span>
  </a><br> <br> 
GW Innovations Private Limited &#169; 2018 
 </div>
 <br>
<div class="clearfix" align="center"> 
 
Powered by Gateway ERP</div>
</div>
<br>
</div>
<input type="hidden" id="hidbrandgarage" name="hidbrandgarage" value='<s:property value="hidbrandgarage"/>'/>
 
 </div>
 </div>
</body>
</html>