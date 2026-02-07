<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Management Dashboard</title>          
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<%-- <jsp:include page="../../floorMgmtIncludes.jsp"></jsp:include> --%>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>

<link href="css/util.css" rel="stylesheet" />
<style>
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	
	.txt2 {
	  	font-family: Poppins-Regular;
	  	font-size: 14px;
	  	color: #999999;
	  	line-height: 1.5;
	}
	.rowgap{
    	margin-bottom:6px;
    }
	.page-loader{
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.5);
		position:relative;
		z-index:9999999;
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: #5867dd;
    	border-color: #5867dd;
		color:#fff;
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		
	}
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:rgba(88,103,221,1);
	}
	.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-bottom: 5px;
	}
	.card-container .card-header{
		width: 100%;
		text-align: center;
		padding-top: 10px;
		padding-bottom: 5px;
	}
	.card-container .card-body{
		width: 100%;
		padding-left: 10px;
		padding-right: 10px;
	}
	.card-container .card-body .list-group .list-group-item{
		margin-bottom: 10px;
		border-radius: 25px;
	}
	.card-container .card-body .list-group .list-group-item .badge{
		background-color: rgba(0,0,0,.05);
		color: #000;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	.card-body h1.txt1{
		font-size: 26px;
		margin-top: 5px;
	}
	.primary{
		color:#5867dd;
	}
	
	.custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .datepanel div{
    	display:inline-block;
    }
    .datepanel{
    	height:54px;
    	padding-top:20px;
    }
    .stmtpanel{
    	height:54px;
    	padding-top:15px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
	
.admin-cover .panel-body{
	border:none;
}

.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-top: 10px;
	}
	.card-container .card-icon-wrapper{
		width: 30%;
		display: inline-block;
		clear: both;
		float: left;
		padding-left: 10px;
		padding-right: 10px;
		
	}
	.card-container .card-detail-wrapper{
		width: 70%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-detail-wrapper{
		width: 50%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-expand-wrapper{
		width: 18%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container .card-detail-wrapper p:nth-child(1){
		margin-top: 5px;
		margin-bottom: 2px;
	}
	.centered{
	    margin: 0 auto;
	}
	.custom-tabs li.active a, .custom-tabs li.active, .custom-tabs li.focus a, .custom-tabs li.focus {
    	color: #fff;
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: rgba(88,103,221,1);
	}
	.contact-container{
		width:100%;
		background-color:#fff;
	}
	.contact-header{
		background-image:url("images/bg-02.jpg");
		background-size:cover;
		background-repeat:no-repeat;
		background-position:center top;
	}
	.boxshadow1{
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
	}
	#tblsurvey tbody tr.active td,#tblservice tbody tr.active td{
		color: #fff;
	    background-color: rgba(88,103,221,1);
	}
	#tblservice tbody tr.active td span.badge,#tblsurvey tbody tr.active td span.badge{   
		background-color:#fff;
		color:rgba(88,103,221,1);
	}
	/* #tblexenq tbody tr{
		cursor:pointer;
	} */  
	.btn-outline-primary{
	    color: rgba(88,103,221,1);
	    background-color: transparent;
	    background-image: none;
	    border-color: rgba(88,103,221,1);
	}
	.btn-outline-primary:hover,.btn-outline-primary:focus,.btn-outline-primary:active{
	    color: #fff;
	    background-color: rgba(88,103,221,1);
	    background-image: none;
	    border-color: rgba(88,103,221,1);
	}
	
	#tblservice .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
	
	#tblservice .table-responsive {
	  overflow-y: visible !important;
	}
	.panel.panel-default .panel-heading p{
		margin-bottom:0px;
	}
	.custom-tabs{
		margin-bottom:10px;
	}
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body onload="getDbnames();">
	<div class="page-loader hidden">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<nav class="navbar navbar-default navbar-fixed-top custom-navbar">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span> 
      			</button>
      			<a class="navbar-brand" href="#" style="padding-top: 2px;padding-bottom: 2px;padding-left: 15px;padding-right: 15px;">
      				<span style="margin-right:10px;"><img alt="" src="images/epic.jpg" style="width:auto; height: 100%;"></span>
      				Management Dashboard     
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> <span class="user-dropdown-text">John Doe</span>
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu">
          					<li><a href="#" onclick="location.replace('index.jsp');">Sign Out</a></li>
        				</ul>
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav> 
	
	<div class="container-fluid">
		<ul class="nav nav-pills custom-tabs nav-justified m-t-60">               
    		<li class="active"><a data-toggle="pill" href="#menu1"><i class="fa fa-building-o p-r-5"></i>Company Wise</a></li> 
    		<li ><a data-toggle="pill" href="#menu2"><i class="fa fa-clipboard p-r-5"></i>Consolidated</a></li>
  		</ul>
  		<div class="tab-content">
  			<div class="tab-pane fade  in active" id="menu1">
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						 <select class="form-control" name="cmbdbnames" id="cmbdbnames" onchange="funChangeData();"><option value=""></option></select>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p class="panel-title"><strong>Collections</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="table1"></table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p class="panel-title"><strong>Cash &amp; Bank Summary</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="table2"></table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p class="panel-title"><strong>PDC Summary</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="table3"></table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p class="panel-title"><strong>Receivable Own (Category wise)</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="table4"></table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row hidden">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p class="panel-title"><strong>Receivable Own (Previllege wise)</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="table5"></table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row hidden">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p class="panel-title"><strong>Receivable DIRECT  (Previllege wise)</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="table6"></table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row hidden">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p class="panel-title"><strong>Receivable DIRECT  (Category wise)</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="table7"></table>
  							</div>
  						</div>
  					</div>
  				</div>
  			</div>
  			<div class="tab-pane fade" id="menu2">
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="pull-right p-b-5">
		        				<select id="cmbmonth" name="cmbmonth" class="form-control" onchange="funGetInitData();">
		        					<option value="">--Select--</option>
		        					<option value="01">January</option>
		        					<option value="02">February</option>
		        					<option value="03">March</option>
		        					<option value="04">April</option>
		        					<option value="05">May</option>
		        					<option value="06">June</option>
		        					<option value="07">July</option>
		        					<option value="08">August</option>
		        					<option value="09">September</option>
		        					<option value="10">October</option>
		        					<option value="11">November</option>
		        					<option value="12">December</option>
		        					
		        				</select>
		        				<select id="cmbyear" name="cmbyear" class="form-control" onchange="funGetInitData();">
		        					<option value="">--Select--</option>
		        					<option value="2021">2021</option>
		        					<option value="2020">2020</option>
		        					<option value="2019">2019</option>
		        					<option value="2018">2018</option>
		        				</select>
		        		</div>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
  						<div class="panel panel-default">
		  					<div class="panel-heading">
		  						<p><strong>Profit/Loss</strong></p>
		  					</div>
		  					<div class="panel-body table-responsive" style="max-height:340px;overflow-y:auto;">
		  						<table class="table" id="tblprofitlossanalysis">
		  							<thead>
		  								<tr>
		  									<th>Company Name</th>
		  									<th align="right" class="text-right">Profit Loss Current Month</th>
		  									<th align="right" class="text-right">Year to month</th>
		  								</tr>
		  							</thead>
									<tbody >
										<tr>
											<td>AL SAQR EMGINEERING</td>
											<td align="right">23,234.49</td>
											<td align="right">9578.98</td>
										</tr>
									</tbody>
		  						</table>
		  					</div>
		  				</div>
  					</div>
  					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p><strong>Profit/Loss</strong></p>
  							</div>
  							<div class="panel-body">
  								<canvas id="profitlosschart"></canvas>
  							</div>
  						</div>
  						
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p><strong>MIS Report</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="tblmis">
  									<thead>
  										<tr>
  											<th>Company Name</th>
  											<th class="text-right">Recievables</th>
  											<th class="text-right">Cash/Petty Cash</th>
  											<th class="text-right">Bank Balances</th>
  											<th class="text-right">Fixed Assets</th>
  											<th class="text-right">Current Assets</th>
  											<th class="text-right">Current Liabilities</th>
  											<th class="text-right">Creditors</th>
  											<th class="text-right">Inter Company</th>
  										</tr>
  									</thead>
  									<tbody>
  										<tr>
  											<td>Al Saqr Engineering</td>
  											<td class="text-right">0.00</td>
  											<td class="text-right">0.00</td>
  											<td class="text-right">0.00</td>
  											<td class="text-right">0.00</td>
  											<td class="text-right">0.00</td>
  											<td class="text-right">0.00</td>
  											<td class="text-right">0.00</td>
  											<td class="text-right">0.00</td>  											
  										</tr>
  									</tbody>
  								</table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p><strong>Profit/Loss Analysis</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="tblrecievable">
  									<thead>
  										<tr>
  											<th>Company Name</th>
  											<th class="text-right">Revenue</th>
  											<th class="text-right">Cost</th>
  											<th class="text-right">Other Income</th>
  										</tr>
  									</thead>
  									<tbody>
  									</tbody>
  								</table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p><strong>Expenses</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="tblexpense">
  									<thead>
  										<tr>
  											<th>Account</th>
  											<th class="text-right">Revenue</th>
  											<th class="text-right">Cost</th>
  											<th class="text-right">Other Income</th>
  										</tr>
  									</thead>
  									<tbody>
  									</tbody>
  								</table>
  							</div>
  						</div>
  					</div>
  				</div>
  				<div class="row">
  					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-heading">
  								<p><strong>Income</strong></p>
  							</div>
  							<div class="panel-body table-responsive">
  								<table class="table" id="tblincome">
  									<thead>
  										<tr>
  											<th>Account</th>
  											<th class="text-right">Revenue</th>
  											<th class="text-right">Cost</th>
  											<th class="text-right">Other Income</th>
  										</tr>
  									</thead>
  									<tbody>
  									</tbody>
  								</table>
  							</div>
  						</div>
  					</div>
  				</div>
  			</div>
  		</div>  
  	</div>  
  	<input type="hidden" id="hidbrandgarage" name="hidbrandgarage" value='<s:property value="hidbrandgarage"/>'/>
	<input type="hidden" id="hidbname"/>  
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script>     
    	window.chartColors=["#cee5f2","#accbe1","#7c98b3","#637081","#536b78","#4b3b47","#f9a620","#ffd449","#548c2f","#104911","#9a2144","#065143","#c1292e","#f1d302","#161925"];
    	var profitlosschartdata ;
    	var username='<%=session.getAttribute("USERNAME").toString()%>';
    	$('.user-dropdown-text').text(username);
    	$(document).ready(function(){
    		var curdate=new Date();
    		var baseyear=curdate.getFullYear()-5;
    		var yearhtmldata='';
    		while(baseyear<=curdate.getFullYear()){
    			yearhtmldata+='<option value="'+baseyear+'">'+baseyear+'</option>';
    			baseyear++;
    		}
    		$('#cmbyear').html($.parseHTML(yearhtmldata));
    		
    		$('#cmbmonth').select2({
				placeholder:'Select Month',
				allowClear:true
			});
			$('#cmbyear').select2({
				placeholder:'Select Year',
				allowClear:true
			});
			
			
			$('#cmbmonth').val(((curdate.getMonth())+'').length==1?'0'+(curdate.getMonth()+1):(curdate.getMonth()+1)).trigger('change');
    		$('#cmbyear').val(curdate.getFullYear()).trigger('change');
    		profitlosschartdata = {
				labels: ['Al Saqr Engineering', 'Aviation', 'RAAD Express', '3D Complex', 'OilField','Dolphin Air','Farm','Al Hamar','Abz Group'],
			  	datasets: [
			    {
			    	label: '',
			      	data: [50,12,58,68,45,75,5,25,69],
			      	backgroundColor: ["#eeeeff","#7f7caf","#9fb4c7","#28587b","#9fb798","#663F46","#f1d302","#c1292e","#065143"],
			    }
			  ]
			};
			const profitlosschartconfig = {
				type: 'pie',
			  	data: profitlosschartdata,
			  	options: {
			    	responsive: true,
					legend:{
						display:false
					}
			  	},
			};
    		var profitlossctx = document.getElementById('profitlosschart').getContext('2d');
    		window.profitlosschart=new Chart(profitlossctx,profitlosschartconfig);
    		funGetInitData();
			
			var dbname="abzgroup";    
	   	    getPaytype(dbname);getBank(dbname);getPdcsummary(dbname);getOwncategory(dbname);
	    	getDirectprivillege(dbname);getDirectcategory(dbname);getOwnreceivable(dbname);
    	});
    	function getPaytype(dbname) {
   		  var optionsbranch5 = '';  	
			optionsbranch5 += '<tr class="">'+     
		                 '<th width="30%">&nbsp;</th>'+
		                 '<th width="10%">Cash</th>'+   
					     '<th width="10%">Card</th>'+
					     '<th width="15%">Cheque PDC</th>'+  
					     '<th width="15%">Cheque CD</th></tr>';   
		  $("#table1").append($.parseHTML(optionsbranch5));  
   		  var x = new XMLHttpRequest();
  		  x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				//console.log(1);
  				var pay  = items[0].split("#");
  				var cash = items[1].split("#");
  				var card  = items[2].split("#");
  				var chpdc = items[3].split("#");
  				var chcdc  = items[4].split("#");
				var optionsbranch = '';
  				for (var i = 0; i < pay.length; i++) {
  					optionsbranch += '<tr class="primary"><td>' + pay[i].trim() + '</td>'+ 
  									 '<td>' + cash[i].trim() + '</td>'+ 
  									 '<td>' + card[i].trim() + '</td>'+ 
  									 '<td>' + chpdc[i].trim() + '</td>'+ 
  									 '<td>' + chcdc[i].trim() + '</td></tr>'; 
  					//alert(optionsbranch);
  					}
  				$("#table1").append($.parseHTML(optionsbranch));
  				
  			} else {}
  		}
  		x.open("GET","getPaytype.jsp?dbname="+dbname, true);  
  		x.send();
  	}
   
  	function getBank(dbname) { 
  		var optionsbranch5 = '';
  		optionsbranch5 +=   '<tr>'+  
						    '<th>&nbsp;</th>'+
						    '<th>&nbsp;</th> '+
						    '<th>&nbsp;</th></tr>';
		$("#table2").append(optionsbranch5);	   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				//alert(items);
				items = items.split('####');
				
				var den  = items[0].split(",,");
				var descr = items[1].split(",,");
				var amt  = items[2].split(",,");
				var optionsbranch1 = '';			    
				for (var i = 0; i < den.length; i++) {
					optionsbranch1 += '<tr><td>' + den[i].trim() + '</td>'+ 
									 '<td>' + descr[i].trim() + '</td>'+ 
									 '<td>' + amt[i].trim() + '</td></tr>'; 
					//alert(optionsbranch2);
					}
				$("#table2").append(optionsbranch1);
				
			} else {}
		}
		x.open("GET","getBank.jsp?dbname="+dbname, true);
		x.send();
	}
  	
   	function getPdcsummary(dbname) {
   		var optionsbranch5 = '';
   		optionsbranch5 += '<tr>'+ 
				   		 '<th width="35%">&nbsp;</th>'+ 
					     '<th align="right">Received</th>'+  
					     '<th align="right">Paid</th></tr>';        
	    $("#table3").append(optionsbranch5);  
	    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				//alert(items);
				items = items.split('####');
				
				var type  = items[0].split("#");
				var received = items[1].split("#");
				var paid  = items[2].split("#");
					
				var optionsbranch2 = '';
				for (var i = 0; i < type.length; i++) {
					optionsbranch2 += '<tr><td>' + type[i].trim() + '</td>'+ 
									 '<td>' + received[i].trim() + '</td>'+ 
									 '<td>' + paid[i].trim() + '</td></tr>'; 
					//alert(optionsbranch2);
					}
				$("#table3").append(optionsbranch2);
				
			} else {}
		}
		x.open("GET","getPdcsummary.jsp?dbname="+dbname, true);       
		x.send();
	}
   	
   	function getOwncategory(dbname) {
   		var optionsbranch5 = '';
   		optionsbranch5 += '<tr>'+ 
						    '<th width="35%">&nbsp;</th>'+ 
						    '<th>Outstanding</th>'+  
						    '<th>Advance</th>'+ 
						    '<th>Overdue</th></tr>';   
	    $("#table4").append(optionsbranch5);    
	    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				//alert(items);
				items = items.split('####');
				
				var cat  = items[0].split("#");
				var outstanding = items[1].split("#");
				var advance  = items[2].split("#");
				var overdue  = items[3].split("#");
					
				var optionsbranch2 = '';
				for (var i = 0; i < cat.length; i++) {
					optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>'+ 
									 '<td>' + outstanding[i].trim() + '</td>'+ 
									 '<td>' + advance[i].trim() + '</td>'+ 
									 '<td>' + overdue[i].trim() + '</td></tr>'; 
					//alert(optionsbranch2);
					}
				$("#table4").append(optionsbranch2);
				
			} else {}
		}
		x.open("GET","getOwncategory.jsp?dbname="+dbname, true);
		x.send();
	}
   	
   	function getOwnreceivable(dbname) {
   		var optionsbranch5 = '';
   		optionsbranch5 += '<tr>'+ 
					    '<th width="35%">&nbsp;</th>'+ 
					    '<th>Outstanding</th>'+  
					    '<th>Advance</th>'+ 
					    '<th>Overdue</th></tr>';       
	    $("#table5").append(optionsbranch5);    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				//alert(items);
				items = items.split('####');
				
				var cat  = items[0].split("#");
				var outstanding = items[1].split("#");
				var advance  = items[2].split("#");
				var overdue  = items[3].split("#");
					
				var optionsbranch2 = '';
				for (var i = 0; i < cat.length; i++) {
					optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>'+ 
									 '<td>' + outstanding[i].trim() + '</td>'+ 
									 '<td>' + advance[i].trim() + '</td>'+ 
									 '<td>' + overdue[i].trim() + '</td></tr>'; 
					//alert(optionsbranch2);
					}
				$("#table5").append(optionsbranch2);
				
			} else {}
		}
		x.open("GET","getOwnreceivable.jsp?dbname="+dbname, true);
		x.send();
	}
   	
   	function getDirectprivillege(dbname) {
   		var optionsbranch5 = '';
   		optionsbranch5 += '<tr>'+
						    '<th width="35%">&nbsp;</th>'+
						    '<th>Outstanding</th>'+ 
						    '<th>Advance</th>'+
						    '<th>Overdue</th></tr>';       
	    $("#table6").append(optionsbranch5); 
	    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				//alert(items);
				items = items.split('####');
				
				var cat  = items[0].split("#");
				var outstanding = items[1].split("#");
				var advance  = items[2].split("#");
				var overdue  = items[3].split("#");
					
				var optionsbranch2 = '';
				for (var i = 0; i < cat.length; i++) {
					optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>'+ 
									 '<td>' + outstanding[i].trim() + '</td>'+ 
									 '<td>' + advance[i].trim() + '</td>'+ 
									 '<td>' + overdue[i].trim() + '</td></tr>'; 
					//alert(optionsbranch2);
					}
				$("#table6").append(optionsbranch2);
				
			} else {}
		}
		x.open("GET","getDirectprivillege.jsp?dbname="+dbname, true);
		x.send();
	}
   	
	function getDirectcategory(dbname) {
		var optionsbranch5 = '';
   		optionsbranch5 += '<tr>'+ 
					    '<th width="35%">&nbsp;</th>'+ 
					    '<th>Outstanding</th>'+  
					    '<th>Advance</th>'+ 
					    '<th>Overdue</th></tr>';           
	    $("#table7").append(optionsbranch5); 
	    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				//alert(items);
				items = items.split('####');
				
				var cat  = items[0].split("#");
				var outstanding = items[1].split("#");
				var advance  = items[2].split("#");
				var overdue  = items[3].split("#");
					
				var optionsbranch2 = '';
				for (var i = 0; i < cat.length; i++) {
					optionsbranch2 += '<tr><td>' + cat[i].trim() + '</td>'+ 
									 '<td>' + outstanding[i].trim() + '</td>'+ 
									 '<td>' + advance[i].trim() + '</td>'+ 
									 '<td>' + overdue[i].trim() + '</td></tr>'; 
					//alert(optionsbranch2);
					}
				$("#table7").append(optionsbranch2);
				
			} else {}
		}
		x.open("GET","getDirectcategory.jsp?dbname="+dbname, true);
		x.send();
	}
	
    	function getDbnames() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					//var optionsyear = '<option value=""></option>';  
					var optionsyear='';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbdbnames").html(optionsyear);
					$('#cmbdbnames').select2({
						placeholder:'Select Company',
						allowClear:true
					});
					        
				} else {
				}   
			}
			x.open("GET", "getDbnames.jsp", true);
			x.send();
		}
		
		function getCompanies(){                                  
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {                      
	  				var items=x.responseText.trim();
	  				var enqdata=JSON.parse(items.trim());
	  				var enqhtml='';
	  				$.each(enqdata.exenqarray, function( index, value ) {                                                                                  
	  					var data1=""+value.split("::")[1];                          
	  					enqhtml+='<li><a href="#" name="tab" onClick="funChangeData()" data-dbname="'+value.split("::")[1]+'">'+value.split("::")[0]+'</a></li>';                 
	  				     /* enqhtml+="<li><a href='#' data-value="+value.split("::")[1]+">"+value.split("::")[0]+"</a> </li>"; */              
	  				});                  
	  				console.log(enqhtml);                        
					$('#addComp').html($.parseHTML(enqhtml));                                    
				}
	  		}        
	  		x.open("GET", "getCompanies.jsp", true);
	  		x.send();
		}
		
		function funChangeData(){  
    	  $("#table1").html('');$("#table2").html('');$("#table3").html('');$("#table4").html('');$("#table5").html('');$("#table6").html('');$("#table7").html('');   
    	  var dbname=$("#cmbdbnames").val();       
    	  getPaytype(dbname);getBank(dbname);getPdcsummary(dbname);getOwncategory(dbname);
    	  getDirectprivillege(dbname);getDirectcategory(dbname);getOwnreceivable(dbname);              
      }
    	function funGetInitData(){
    		
    		$.get('getClientInitData.jsp', { month:$('#cmbmonth').val(),year:$('#cmbyear').val() }, function(data) {
    			data=data.split("::")[3].trim();
    			data=JSON.parse(data);
				console.log(data);
    			/*var profitlossdata='[{"cmpname":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","total":"-1,46,034.9700","ytotal":"-1077423.6200"},{"cmpname":"AL SAQR ENGINEERING ","total":"-1,59,960.0700","ytotal":"-264324.3400"},{"cmpname":"OILFIELD PETROLEUM FZE","total":"-130698.8300","ytotal":"-316190.6100"},{"cmpname":"3D COMPLEX BUILDING CONTRACTING LLC","total":"-119683.2400","ytotal":"-456958.1000"},{"cmpname":"AL HAMRA REAL ESTATE","total":"-207638.8000","ytotal":"591879.0200"},{"cmpname":"DOLPHIN AIR","total":"10113.9900","ytotal":"-191541.2350"},{"cmpname":"AVIATION SOLUTIONS FZC","total":"38937.5100","ytotal":"-161737.3883"},{"cmpname":"RAAD EXPRESS DELIVERY SERVICES ","total":"-81816.4800","ytotal":"-606025.0425"},{"cmpname":"FARM INVESTMENTS","total":"-104439.1800","ytotal":"-747252.4238"},{"cmpname":"MAHA B","total":"0.0000","ytotal":"-21610.5500"},{"cmpname":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","total":"-24958.1100","ytotal":"1214823.1200"},{"cmpname":"ABZ STORE"}]';
				profitlossdata=JSON.parse(profitlossdata);*/
				var htmldata='';
				profitlosschartdata.labels=[];
				profitlosschartdata.datasets[0].data=[];
				profitlosschartdata.datasets[0].backgroundColor=[];
				$.each(data.profitlossdata, function( index, value ) {
					value.total=value.total=='undefined' || typeof(value.total)=='undefined'?0.00:value.total;
					value.ytotal=value.ytotal=='undefined' || typeof(value.ytotal)=='undefined'?0.00:value.ytotal;
	  				htmldata+='<tr>';
	  				htmldata+='<td>'+value.cmpname+'</td>';
	  				htmldata+='<td class="text-right">'+value.total+'</td>';
	  				htmldata+='<td class="text-right">'+value.ytotal+'</td>';
					htmldata+='</tr>';
					profitlosschartdata.labels.push(value.cmpname);
					var chartvalue=0;
					chartvalue=value.total;
					profitlosschartdata.datasets[0].data.push(chartvalue);
					profitlosschartdata.datasets[0].backgroundColor.push(window.chartColors[index]);
				});
				window.profitlosschart.update();
				$('#tblprofitlossanalysis tbody').html($.parseHTML(htmldata));
	    		/*var misdata='[{"cmpname":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","receivable":"0.00","cash":"7912.10","bank":"52182.00","FixedAssets":"-23777.90","CurrentAssets":"-60672.36","CurrentLiabilities":"-184769.28","Creditors":"-23969.54","Intercompany":"-512815.44"},{"cmpname":"AL SAQR ENGINEERING ","receivable":"-207989.66","cash":"24525.00","bank":"-148495.30","FixedAssets":"-45730.50","CurrentAssets":"-311786.62","CurrentLiabilities":"51665.74","Creditors":"111084.24","Intercompany":"14370.00"},{"cmpname":"OILFIELD PETROLEUM FZE","receivable":"0.00","cash":"0.00","bank":"0.00","FixedAssets":"-46462.36","CurrentAssets":"-36996.30","CurrentLiabilities":"-175789.00","Creditors":"-68758.00","Intercompany":"0.00"},{"cmpname":"3D COMPLEX BUILDING CONTRACTING LLC","receivable":"82152.21","cash":"-54097.88","bank":"-79654.00","FixedAssets":"-5152.10","CurrentAssets":"-26917.79","CurrentLiabilities":"-191274.01","Creditors":"-15052.50","Intercompany":"34105.34"},{"cmpname":"AL HAMRA REAL ESTATE","receivable":"-209222.20","cash":"74.00","bank":"11250.00","FixedAssets":"-774718.88","CurrentAssets":"474004.00","CurrentLiabilities":"-107928.68","Creditors":"-11707.50","Intercompany":"372639.56"},{"cmpname":"DOLPHIN AIR","receivable":"-387277.94","cash":"-2446.92","bank":"203982.78","FixedAssets":"-784.96","CurrentAssets":"-392300.30","CurrentLiabilities":"-111517.80","Creditors":"-9992.80","Intercompany":"-205940.00"},{"cmpname":"AVIATION SOLUTIONS FZC","receivable":"2580435.40","cash":"0.00","bank":"0.00","FixedAssets":"-2162.96","CurrentAssets":"2571476.68","CurrentLiabilities":"-2634636.76","Creditors":"-2525236.76","Intercompany":"-2220.00"},{"cmpname":"RAAD EXPRESS DELIVERY SERVICES ","receivable":"-306209.48","cash":"13.30","bank":"156119.26","FixedAssets":"-2676.50","CurrentAssets":"-249961.22","CurrentLiabilities":"95166.12","Creditors":"36736.12","Intercompany":"-97829.24"},{"cmpname":"FARM INVESTMENTS","receivable":"-51060.00","cash":"0.00","bank":"0.00","FixedAssets":"-4264.66","CurrentAssets":"-165336.70","CurrentLiabilities":"-36569.00","Creditors":"-30240.00","Intercompany":"-57050.74"},{"cmpname":"MAHA B"},{"cmpname":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","receivable":"0.00","cash":"0.00","bank":"-466000.00","FixedAssets":"0.00","CurrentAssets":"-17121.74","CurrentLiabilities":"-26588.00","Creditors":"0.00","Intercompany":"454740.52"},{"cmpname":"ABZ STORE"}]'
	    		misdata=JSON.parse(misdata);*/
	    		htmldata='';
	    		$.each(data.misdata, function( index, value ) {
	  				value.receivable=value.receivable=='undefined' || typeof(value.receivable)=='undefined'?0.00:value.receivable;
					value.cash=value.cash=='undefined' || typeof(value.cash)=='undefined'?0.00:value.cash;
					value.bank=value.bank=='undefined' || typeof(value.bank)=='undefined'?0.00:value.bank;
					value.FixedAssets=value.FixedAssets=='undefined' || typeof(value.FixedAssets)=='undefined'?0.00:value.FixedAssets;
					value.CurrentAssets=value.CurrentAssets=='undefined' || typeof(value.CurrentAssets)=='undefined'?0.00:value.CurrentAssets;
					value.CurrentLiabilities=value.CurrentLiabilities=='undefined' || typeof(value.CurrentLiabilities)=='undefined'?0.00:value.CurrentLiabilities;
					value.Creditors=value.Creditors=='undefined' || typeof(value.Creditors)=='undefined'?0.00:value.Creditors;
					value.Intercompany=value.Intercompany=='undefined' || typeof(value.Intercompany)=='undefined'?0.00:value.Intercompany;
					htmldata+='<tr>';
	  				htmldata+='<td>'+value.cmpname+'</td>';
	  				htmldata+='<td class="text-right">'+value.receivable+'</td>';
	  				htmldata+='<td class="text-right">'+value.cash+'</td>';
	  				htmldata+='<td class="text-right">'+value.bank+'</td>';
	  				htmldata+='<td class="text-right">'+value.FixedAssets+'</td>';
	  				htmldata+='<td class="text-right">'+value.CurrentAssets+'</td>';
	  				htmldata+='<td class="text-right">'+value.CurrentLiabilities+'</td>';
	  				htmldata+='<td class="text-right">'+value.Creditors+'</td>';
	  				htmldata+='<td class="text-right">'+value.Intercompany+'</td>';
					htmldata+='</tr>';
				});
				$('#tblmis tbody').html($.parseHTML(htmldata));
	    		/*var recievabledata='[{"cmpname":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","revenue":"-1120.00","cost":"293653.94","OtherIncome":"-620.00"},{"cmpname":"AL SAQR ENGINEERING ","revenue":"10894.50","cost":"316692.24","OtherIncome":"0.00"},{"cmpname":"OILFIELD PETROLEUM FZE","revenue":"0.00","cost":"261397.66","OtherIncome":"0.00"},{"cmpname":"3D COMPLEX BUILDING CONTRACTING LLC","revenue":"-78240.20","cost":"317606.68","OtherIncome":"0.00"},{"cmpname":"AL HAMRA REAL ESTATE","revenue":"-540491.64","cost":"955769.24","OtherIncome":"0.00"},{"cmpname":"DOLPHIN AIR","revenue":"-139650.30","cost":"119422.32","OtherIncome":"0.00"},{"cmpname":"AVIATION SOLUTIONS FZC","revenue":"-9483100.08","cost":"9405225.06","OtherIncome":"0.00"},{"cmpname":"RAAD EXPRESS DELIVERY SERVICES ","revenue":"-415619.20","cost":"574270.56","OtherIncome":"4981.60"},{"cmpname":"FARM INVESTMENTS","revenue":"0.00","cost":"208878.36","OtherIncome":"0.00"},{"cmpname":"MAHA B"},{"cmpname":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","revenue":"0.00","cost":"49916.22","OtherIncome":"0.00"},{"cmpname":"ABZ STORE"}]';
				recievabledata=JSON.parse(recievabledata);*/
	    		htmldata='';
	    		$.each(data.recievabledata, function( index, value ) {
					value.revenue=value.revenue=='undefined' || typeof(value.revenue)=='undefined'?0.00:value.revenue;
					value.cost=value.cost=='undefined' || typeof(value.cost)=='undefined'?0.00:value.cost;
					value.OtherIncome=value.OtherIncome=='undefined' || typeof(value.OtherIncome)=='undefined'?0.00:value.OtherIncome;
	  				htmldata+='<tr>';
	  				htmldata+='<td>'+value.cmpname+'</td>';
	  				htmldata+='<td class="text-right">'+value.revenue+'</td>';
	  				htmldata+='<td class="text-right">'+value.cost+'</td>';
	  				htmldata+='<td class="text-right">'+value.OtherIncome+'</td>';
					htmldata+='</tr>';
				});
				$('#tblrecievable tbody').html($.parseHTML(htmldata));	
    			
    			/*var expensedata='[{"description":"LEGAL & LICENSE FEE","total":"7114.20","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"123.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"1228.08"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"846.03"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"1685.42"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"3179.17"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"52.50"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"STAFF BASIC SALARY","total":"-2.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"-1.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"-1.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"LEAVE SALARY","total":"30887.81","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"7190.30"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"4845.83"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"575.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"5025.33"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"1198.21"},{"cmpname5":"DOLPHIN AIR","tot5":"283.61"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"1666.67"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"1253.66"},{"cmpname8":"FARM INVESTMENTS","tot8":"8082.37"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"766.83"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"GRATUITY","total":"13358.94","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"2594.40"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"2791.85"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"2300.46"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"993.81"},{"cmpname5":"DOLPHIN AIR","tot5":"764.99"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"500.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"1827.02"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"1586.41"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"PETROL","total":"9424.26","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"150.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"8335.26"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"939.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"VEHICLE MAINTENANCE","total":"3374.75","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"1497.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"362.75"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"1515.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"TELEPHONE CHARGES","total":"15239.76","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"5566.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"2074.96"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"-27.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"2025.24"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"5600.56"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"AUDIT FEE","total":"12075.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"437.50"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"350.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"8137.50"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"700.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"787.50"},{"cmpname5":"DOLPHIN AIR","tot5":"262.50"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"700.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"437.50"},{"cmpname8":"FARM INVESTMENTS","tot8":"262.50"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"DEPRECIATION EXP ON FURNITURE & FIXTURE","total":"5490.21","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"85.16"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"83.33"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"530.21"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"4791.51"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"DEPRECIATION EXP ON VEHICLE","total":"16972.80","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"5213.77"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"5648.17"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"1859.53"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"1016.50"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"1102.50"},{"cmpname8":"FARM INVESTMENTS","tot8":"2132.33"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"DEPRECIATION EXP ON OFFICE EQUIPMENT","total":"22608.47","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"6590.02"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"8989.04"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"2045.84"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"4290.36"},{"cmpname5":"DOLPHIN AIR","tot5":"392.48"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"64.98"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"235.75"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"STAFF WELFARE","total":"18888.05","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"4268.84"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"521.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"13813.75"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"284.46"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"AIR TICKETS","total":"10941.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"1562.50"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"3230.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"500.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"685.50"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"1722.50"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"62.50"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"2428.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"750.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"PARKING","total":"147.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"147.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"VEHICLE INSURANCE","total":"552.50","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"552.50"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"MEDICAL INSURANCE","total":"9993.36","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"1269.51"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"1588.17"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"855.83"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"1526.31"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"1364.60"},{"cmpname5":"DOLPHIN AIR","tot5":"309.11"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"190.19"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"1507.53"},{"cmpname8":"FARM INVESTMENTS","tot8":"1023.98"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"358.13"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"VISA EXPENSES","total":"37913.82","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"7525.88"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"1246.29"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"18209.33"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"1211.33"},{"cmpname5":"DOLPHIN AIR","tot5":"970.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"1110.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"6488.99"},{"cmpname8":"FARM INVESTMENTS","tot8":"226.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"926.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"STAFF TRAVELLING ALLOWANCES","total":"2371.50","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"2000.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"371.50"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"SALARY AND ALLOWANCE ","total":"617613.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"87335.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"95207.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"53950.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"91311.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"39886.00"},{"cmpname5":"DOLPHIN AIR","tot5":"50500.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"54000.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"81417.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"48840.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"15167.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"OFFICE EXPENSES","total":"4135.59","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"4135.59"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"PRINTING AND STATIONERY","total":"450.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"450.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"IT EXPENSES","total":"332.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"332.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]},{"description":"OFFICE TELEPHONE AND INTERNET EXP","total":"7880.00","comparray":[{"cmpname0":"ABDULLA BIN ZAYED INVESTMENT GROUP LLC","tot0":"7880.00"},{"cmpname1":"AL SAQR ENGINEERING ","tot1":"0.00"},{"cmpname2":"OILFIELD PETROLEUM FZE","tot2":"0.00"},{"cmpname3":"3D COMPLEX BUILDING CONTRACTING LLC","tot3":"0.00"},{"cmpname4":"AL HAMRA REAL ESTATE","tot4":"0.00"},{"cmpname5":"DOLPHIN AIR","tot5":"0.00"},{"cmpname6":"AVIATION SOLUTIONS FZC","tot6":"0.00"},{"cmpname7":"RAAD EXPRESS DELIVERY SERVICES ","tot7":"0.00"},{"cmpname8":"FARM INVESTMENTS","tot8":"0.00"},{"cmpname9":"MAHA B","tot9":"0.00"},{"cmpname10":"ABDULLA BIN ZAYED INVESTMENT PERSONAL","tot10":"0.00"},{"cmpname11":"ABZ STORE","tot11":"0.00"}]}]'
				expensedata=JSON.parse(expensedata);*/
				var headdata='';
				htmldata='';
				$.each(data.expensedata, function( index, value ) {
					value.total=value.total=='undefined' || typeof(value.total)=='undefined'?0.00:value.total;
					htmldata+='<tr>';
					htmldata+='<td>'+value.description+'</td>';
					if(index==0){
						headdata+='<tr>';
						headdata+='<th>Account</th>';	
					}
					$.each(value.comparray, function( subindex, subvalue ) {
						var compname=subvalue['cmpname'+subindex];
						var compvalue=subvalue['tot'+subindex];
						compvalue=compvalue=='undefined' || typeof(compvalue)=='undefined'?0.00:compvalue;
						if(index==0){
							headdata+='<th class="text-right">'+compname+'</th>';	
						}
						htmldata+='<td class="text-right">'+compvalue+'</td>';
					});	
					if(index==0){
						headdata+='<th class="text-right">Total</th>';
						headdata+='</tr>';	
					}
					htmldata+='<td class="text-right">'+value.total+'</td>';
					htmldata+='</tr>';
				});
    			$('#tblexpense thead').html($.parseHTML(headdata));
    			$('#tblexpense tbody').html($.parseHTML(htmldata));
    			htmldata='';
    			headdata='';
    			$.each(data.incomedata, function( index, value ) {
    				value.total=value.total=='undefined' || typeof(value.total)=='undefined'?0.00:value.total;
					htmldata+='<tr>';
					htmldata+='<td>'+value.description+'</td>';
					if(index==0){
						headdata+='<tr>';
						headdata+='<th>Account</th>';	
					}
					$.each(value.comparray, function( subindex, subvalue ) {
						var compname=subvalue['cmpname'+subindex];
						var compvalue=subvalue['tot'+subindex];
						compvalue=compvalue=='undefined' || typeof(compvalue)=='undefined'?0.00:compvalue;
						if(index==0){
							headdata+='<th class="text-right">'+compname+'</th>';	
						}
						htmldata+='<td class="text-right">'+compvalue+'</td>';
					});	
					if(index==0){
						headdata+='<th class="text-right">Total</th>';
						headdata+='</tr>';	
					}
					htmldata+='<td class="text-right">'+value.total+'</td>';
					htmldata+='</tr>';
				});
    			$('#tblincome thead').html($.parseHTML(headdata));
    			$('#tblincome tbody').html($.parseHTML(htmldata));
    			
    		});
			  		
    	}
    </script>           
</body>     
</html>