<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>User Dashboard</title>          
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../floorMgmtIncludes.jsp"></jsp:include>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>

<link href="css/util.css" rel="stylesheet" />
<style>
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../vendors/fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../vendors/fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('../vendors/fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('../vendors/fonts/montserrat/Montserrat-SemiBold.ttf'); 
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
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<div class="page-loader">
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
      				User Dashboard     
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
    		<li class="active"><a data-toggle="pill" href="#menu1"><i class="fa fa-edit p-r-5"></i>Service Update</a></li> 
    		<li><a data-toggle="pill" href="#menu2"><i class="fa fa-edit p-r-5"></i>Time Sheet</a></li>
    		<li><a data-toggle="pill" href="#menu3"><i class="fa fa-edit p-r-5"></i>Survey Details</a></li>                                     
  		</ul>  
  	   <div class="tab-content">	   
    		<div id="menu1" class="tab-pane fade in active">
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">	
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
  								<table class="table table-hover" id="tblservice">
  									<thead>       
  										<tr>
  											<th>Sr.No</th>
  											<th>Doc No</th>
  											<th>Doc Type</th>
  											<th>Plan Date</th>
  											<th>Client</th>
  											<th>Site</th>
  										</tr>
  									</thead>
  									<tbody>
  										<tr>
  											<td>1</td>
  											<td>1011163</td>
  											<td>ENQ</td>
											<td>01-01-2019</td>
  											<td>&nbsp;</td>  
  											<td>&nbsp;</td>    
  										</tr>    
  									</tbody>
  								</table>
  							</div>
  							<div class="panel-footer text-right">    
  							    <div id="row">    
  							       <div class="form-group">
		                                    <label for="enddesc" class="col-md-1 control-label">Percentage</label>
		                                    <div class="col-md-2">
		                                        <input type="text" class="form-control validate" name="enddesc" placeholder="Percentage" id="servper" data-max="250">
		                                        <span class="help-block"></span>
		                                    </div>
		                            </div>
		                            <div class="form-group">
		                                    <label for="enddesc" class="col-md-1 control-label">Rectification</label>
		                                    <div class="col-md-1">
		                                   <select id="rect" name="rect" onChange="funselect();">
									      <option value="" selected>--SELECT--</option>
									      <option value="1">YES</option>
									      <option value="0">NO</option>
									      </select>
		                                        <span class="help-block"></span>
		                                    </div>
		                            </div>
		                             <div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-md-5">
		                                        <input type="text" class="form-control validate" name="servdesc" placeholder="Details" id="servdesc" data-max="250">
		                                        <span class="help-block"></span>
		                                    </div>
		                            </div>
    						   </div>
    						   <div id="row">   
    						      <button class="btn btn-default btn-outline-primary btnserviceupdate"><i class="fa fa-floppy-o m-r-5"></i>Update</button>
    						      <button class="btn btn-default btn-outline-primary btnserviceattach"><i class="fa fa-paperclip m-r-5"></i>Attach</button>
    						      <!-- <button class="btn btn-default btn-outline-primary btnserviceconfirm" hidden="true"><i class="fa fa-check-circle m-r-5"></i>Confirm</button> -->
    						   </div>
    						</div>
    					  </div>
  						</div>
  					</div>
  				</div>
  			</div> 
  			<div id="menu2" class="tab-pane fade">
    			<div class="container-fluid">
    				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    					<div id="enqbox" class="mainbox animated fadeIn">
		                    <div class="panel panel-default">
		                        <div class="panel-heading">
		                            <div class="panel-title"><h5 class="m-t-5 m-b-5">Create Time Sheet</h5></div>    
		                        </div>
		                        <div class="panel-body" style="border:none;">
		                            <div id="enqform" class="form-horizontal" role="form">
		                                <div class="form-group">
		                                    <label for="cmbcosttype" class="col-md-3 control-label">Cost Type</label>
		                                    <div class="col-md-9">
		                                        <select class="form-control" name="cmbcosttype" id="cmbcosttype" onchange="getCostCode();getTimeSheetDefaults();"><option value="">--Select--</option></select>
		                                        <span class="help-block"></span>
		                                        <input type="hidden" id="hidcmbcosttype" name="hidcmbcosttype" value='<s:property value="hidcmbcosttype"/>'/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label for="cmbcostcode" class="col-md-3 control-label">Cost Code</label>
		                                    <div class="col-md-9">    
		                                        <select class="form-control" name="cmbcostcode" id="cmbcostcode" onchange="getTimeSheetDefaults();"><option value="">--Select--</option></select>
		                                        <span class="help-block"></span>
		                                        <input type="hidden" id="hidcmbcostcode" name="hidcmbcostcode" value='<s:property value="hidcmbcostcode"/>'/>     
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label for="cmbemployee" class="col-md-3 control-label">Employee</label>
		                                    <div class="col-md-9">
		                                        <select class="form-control" name="cmbemployee" id="cmbemployee"  multiple="multiple" onchange="getTimeSheetDefaults();"><option value="">--Select--</option></select>
		                                        <span class="help-block"></span>
		                                        <input type="hidden" id="hidcmbemployee" name="hidcmbemployee" value='<s:property value="hidcmbemployee"/>'/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label for="enqinsurtype" class="col-md-3 control-label">Date</label>
		                                    <div class="col-md-9">
		                                        <div id="timeSheetDate" name="timeSheetDate"></div>
		                                        <span class="help-block"></span>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label for="enqinsuredname" class="col-md-3 control-label">In Time</label>
		                                    <div class="col-md-9">
		                                        <div id="timeSheetInTime" name="timeSheetInTime"></div>
		                                        <span class="help-block"></span>
		                                    </div>
		                                </div>   
		                                 <div class="form-group">
		                                    <label for="enqinsuredname" class="col-md-3 control-label">Out Time</label>
		                                    <div class="col-md-9">
		                                       <div id="timeSheetOutTime" name="timeSheetOutTime"></div>
		                                        <span class="help-block"></span>
		                                    </div>
		                                </div> 
		                                <div class="form-group" id="hidenormalhrs">    
		                                    <label for="timeSheetNormalHrs" class="col-md-3 control-label">Normal Hrs</label>
		                                    <div class="col-md-9">
		                                       <div id="timeSheetNormalHrs" name="timeSheetNormalHrs"></div>
		                                        <span class="help-block"></span>
		                                    </div>
		                                </div> 
		                                 <div class="form-group">
		                                    <label id="emptext" for="emptext" class="col-md-12 control-label"></label>
		                                </div>
		                                <div class="form-group">     
		                                    <div class="col-md-12 text-right">        
		                                    		<button id="btntimestcancel" type="button" class="btn btn-default m-r-5">Cancel</button>
		                                    		<button id="btntimestsave" type="button" class="btn btn-default btn-success">Save</button>
		                                    </div>
		                                </div>
		                            </div>
		                         </div>
		                    </div>
						</div>
    				</div>
    			</div>
    		</div>
    		<div id="menu3" class="tab-pane fade">     
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">	
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
  								<table class="table table-hover" id="tblsurvey">       
  									<thead>       
  										<tr>
  											<th>Sr.No</th>
  											<th>Doc#</th>
  											<th>Date</th>     
  											<th>Client</th>
  											<th>Site</th>
  											<!-- <th>Client Detail</th> -->
  											<th>Contact Person</th>
  											<th>Contact No</th>
  											<th>Remarks</th>
  										</tr>
  									</thead>
  									<tbody>
  										<tr>
  											<td>&nbsp;</td>
  											<td>&nbsp;</td>
  											<td>&nbsp;</td>   
											<td>&nbsp;</td>
  											<td>&nbsp;</td>  
  											<td>&nbsp;</td>
  											<td>&nbsp;</td>
  											<td>&nbsp;</td>    
  										</tr>    
  									</tbody>
  								</table>
  							</div>
  							<div class="panel-footer text-right">    
  							    <div id="row">    
		                             <div class="form-group">
		                                    <label for="survdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-md-6">    
		                                        <input type="text" class="form-control validate" name="survdesc" placeholder="Details" id="survdesc" data-max="250">
		                                        <span class="help-block"></span>
		                                    </div>
		                            </div>
    						   </div>
    						   <div id="row">            
    						      <button class="btn btn-default btn-outline-primary btnsurveyupdate"><i class="fa fa-floppy-o m-r-5"></i>Create</button>
    						      <button class="btn btn-default btn-outline-primary btnsurveyattach"><i class="fa fa-paperclip m-r-5"></i>Attach</button>
    						      <!-- <button class="btn btn-default btn-outline-primary btnsurveyconfirm"  hidden="true"><i class="fa fa-check-circle m-r-5"></i>Confirm</button> -->
    						   </div>
    						</div>
    					  </div>
  						</div>
  					</div>
  				</div>
  			</div>         
  		  </div>   
  		</div>
    <input type="hidden" name="address" id="address">
    <input type="hidden" name="exval" id="exval">
	<input type="hidden" name="tsrowno" id="tsrowno">
	<input type="hidden" name="latittude" id="latittude">
	<input type="hidden" name="longitude" id="longitude">                     
	<input type="hidden" name="clientacno" id="clientacno">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script>     
    	
    	$(document).ready(function(){     
    		funselect();
    		$("#timeSheetDate").jqxDateTimeInput({ width : '100px', height : '22px', formatString : "dd.MM.yyyy" });
    		$("#timeSheetInTime").jqxDateTimeInput({ width : '50px', height : '22px', formatString : "HH:mm",showCalendarButton: false });
    		$("#timeSheetOutTime").jqxDateTimeInput({ width : '50px', height : '22px', formatString : "HH:mm",showCalendarButton: false });
    		$("#timeSheetNormalHrs").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
    		$("#timeSheetInTime").val("");    
    		$("#timeSheetOutTime").val("");
    		$("#timeSheetInTime").jqxDateTimeInput("disabled",true);    
    		$("#timeSheetOutTime").jqxDateTimeInput("disabled",true);  
			$("#timeSheetDate").jqxDateTimeInput("disabled",true);   
    		$("#hidenormalhrs").hide();
    		$("#cmbcostcode").select2({
    			    placeholder: "Select Cost Code",              
    			    allowClear: true,   
    			    width: '50%'
    			});
    		 $("#cmbemployee").select2({
 			    placeholder: "Select Employee",                 
 			    allowClear: true,
 			    width: '50%'
 			});
    		 $("#cmbcosttype").select2({
 			    placeholder: "Select Cost Type",              
 			    allowClear: true,
 			    width: '50%'     
 			});
    		$('#btntimestsave').click(function(){
    			var d=$('#timeSheetDate').jqxDateTimeInput('getDate');                 
				var year=d.getFullYear();     
				var month=d.getMonth();       
				var costtype=$('#cmbcosttype').val();
				var employee=$('#cmbemployee').val();
				var date=$('#timeSheetDate').val();          
				var costcode=$('#cmbcostcode').val();
				var intime=$('#timeSheetInTime').jqxDateTimeInput('val');
		  		var outtime=$('#timeSheetOutTime').jqxDateTimeInput('val');    
				funSave(year,month,costtype,employee,outtime,date,intime,costcode);       
    		});    
    		
    		$('.btnserviceupdate').click(function(){
    			var activerow=$('#tblservice tbody tr.active');
				if(activerow.length==0){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				var txtsrtrno=$('#tblservice tbody tr.active').attr('data-srtrno'); 
				var cmbcontracttype=$('#tblservice tbody tr.active').attr('data-contracttype');
				var txtcontracttrno=$('#tblservice tbody tr.active').attr('data-contracttrno'); 
				var txtcustomerdocno=$('#tblservice tbody tr.active').attr('data-docno2');
				var txtcustomeracno=$('#tblservice tbody tr.active').attr('data-acno');
				var txtsiteid=$('#tblservice tbody tr.active').attr('data-siteid');
				var txtscheduleno=$('#tblservice tbody tr.active').attr('data-tr_no');
				var servicetype=$('#tblservice tbody tr.active').attr('data-serdocno'); 
				var txtsrdocno=$('#tblservice tbody tr.active').attr('data-srdocno');
				var txtdesc=$('#servdesc').val();
				var txtxper=$('#servper').val();        
				funUpdate(txtsrtrno,cmbcontracttype,txtcontracttrno,txtdesc,txtxper,txtcustomerdocno,txtcustomeracno,txtsiteid,txtscheduleno,servicetype,txtsrdocno);
    		}); 
    		$('.btnsurveyupdate').click(function(){
    			var activerow=$('#tblsurvey tbody tr.active');
				if(activerow.length==0){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				var empid=$('#tblsurvey tbody tr.active').attr('data-empid'); 
				var brhid=$('#tblsurvey tbody tr.active').attr('data-brhid');
				var docno=$('#tblsurvey tbody tr.active').attr('data-docno'); 
				var cpersonid=$('#tblsurvey tbody tr.active').attr('data-cpersonid');
				var cldocno=$('#tblsurvey tbody tr.active').attr('data-cldocno');
				var vocno=$('#tblsurvey tbody tr.active').attr('data-vocno');
				var surdocno=$('#tblsurvey tbody tr.active').attr('data-surdocno');
				var txtdesc=$('#survdesc').val();       
				if(surdocno!=0){      
					Swal.fire({
						type: 'warning',
					  	title: 'Warning',
					  	text: 'Survey details already created!!!'              
					});
					return false;
				}
				funSurveyCreate(empid,brhid,docno,cpersonid,cldocno,vocno,txtdesc);    
    		});
    		$('.btnsurveyconfirm').click(function(){        
    			var activerow=$('#tblsurvey tbody tr.active');
				if(activerow.length==0){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				var surdocno=$('#tblsurvey tbody tr.active').attr('data-surdocno'); 
				var docno=$('#tblsurvey tbody tr.active').attr('data-docno');     
				if(surdocno==0){      
					Swal.fire({
						type: 'warning',
					  	title: 'Warning',
					  	text: 'Please create survey details first!!!'                 
					});
					return false;
				}
				funSurveyConfirm(docno);           
    		});
    		$('.btnserviceconfirm').click(function(){           
    			var activerow=$('#tblservice tbody tr.active');
				if(activerow.length==0){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;    
				}
				var docno=$('#tblservice tbody tr.active').attr('data-srtrno');        
				funServiceConfirm(docno);                 
    		});
    		$('.btnserviceattach').click(function(){   
				var activerow=$('#tblservice tbody tr.active');
				if(activerow.length==0){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				var docno=$('#tblservice tbody tr.active').attr('data-srdocno');  
				var frmdet="SRVE";
				var frmname="Sevice Report";             
				var brhid=$('#tblservice tbody tr.active').attr('data-branch');               
				//alert("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank");
				var myWindow=window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
				
			});
    		$('.btnsurveyattach').click(function(){      
				var activerow=$('#tblsurvey tbody tr.active');       
				if(activerow.length==0){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				var surdocno=$('#tblsurvey tbody tr.active').attr('data-surdocno');
				if(surdocno==0){      
					Swal.fire({
						type: 'warning',
					  	title: 'Warning',
					  	text: 'Please create survey details first!!!'                         
					});
					return false;
				}
				var docno=$('#tblsurvey tbody tr.active').attr('data-survocno');                       
				var frmdet="SUR";          
				var frmname="Survey Details";                 
				var brhid=$('#tblsurvey tbody tr.active').attr('data-brhid');               
				//alert("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank");
				var myWindow=window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
				
			});
    	});     
    	$(window).ready(function(){    
    		getInitData();
    		getCostType();
    		getEmployee();
    		getCostCode();  
    		curLocation();    
		});
    	
    	 function getCostCode() {
    		var costtype=$('#cmbcosttype').val();               
   			var x = new XMLHttpRequest();
   			x.onreadystatechange = function() {
   				if (x.readyState == 4 && x.status == 200) {
   					var items = x.responseText;
   					//console.log(items);
   					items = items.split('####');
   					var yearItems = items[0].split("$$$$");           
   					var yearIdItems = items[1].split(",");
   					var optionsyear = '<option value="">--Select--</option>';
   					for (var i = 0; i < yearItems.length; i++) {
   						optionsyear += '<option value="' + yearIdItems[i] + '">'
   								+ yearItems[i] + '</option>';
   					}
   					$("select#cmbcostcode").html(optionsyear);
   					if($('#hidcmbcostcode').val()){             
   						document.getElementById("cmbcostcode").value=document.getElementById("hidcmbcostcode").value;
   						//funreload(event);       
   					  }
   				} else {
   				}
   			}
   			x.open("GET", "getCostCode.jsp?costtype="+costtype, true);                   
   			x.send();
   		} 
    	function getEmployee() {
  			var x = new XMLHttpRequest();
  			x.onreadystatechange = function() {
  				if (x.readyState == 4 && x.status == 200) {
  					var items = x.responseText;
  					items = items.split('####');
  					var yearItems = items[0].split(",");
  					var yearIdItems = items[1].split(",");       
  					var optionsyear = '<option value="">--Select--</option>';
  					for (var i = 0; i < yearItems.length; i++) {
  						optionsyear += '<option value="' + yearIdItems[i] + '">'
  								+ yearItems[i] + '</option>';
  					}
  					$("select#cmbemployee").html(optionsyear);      
  					if($('#hidcmbemployee').val()){
  						document.getElementById("cmbemployee").value=document.getElementById("hidcmbemployee").value;
  						//funreload(event);       
  					  }
  				} else {
  				}
  			}
  			x.open("GET", "getEmployee.jsp", true);
  			x.send();
  		} 
    	 function getCostType() {
  			var x = new XMLHttpRequest();
  			x.onreadystatechange = function() {
  				if (x.readyState == 4 && x.status == 200) {
  					var items = x.responseText;
  					items = items.split('####');
  					var yearItems = items[0].split(",");
  					var yearIdItems = items[1].split(",");
  					var optionsyear = '<option value="">--Select--</option>';
  					for (var i = 0; i < yearItems.length; i++) {
  						optionsyear += '<option value="' + yearIdItems[i] + '">'
  								+ yearItems[i] + '</option>';
  					}
  					$("select#cmbcosttype").html(optionsyear);
  					if($('#hidcmbcosttype').val()){
  						document.getElementById("cmbcosttype").value=document.getElementById("hidcmbcosttype").value;
  						//funreload(event);       
  					  }
  				} else {
  				}
  			}
  			x.open("GET", "getCostType.jsp", true);
  			x.send();
  		} 
    	 function getYear() {
 			var x = new XMLHttpRequest();
 			x.onreadystatechange = function() {
 				if (x.readyState == 4 && x.status == 200) {
 					var items = x.responseText;
 					items = items.split('####');
 					var yearItems = items[0].split(",");
 					var yearIdItems = items[1].split(",");
 					var optionsyear = '<option value="">--Select--</option>';
 					for (var i = 0; i < yearItems.length; i++) {
 						optionsyear += '<option value="' + yearIdItems[i] + '">'
 								+ yearItems[i] + '</option>';
 					}
 					$("select#cmbyear").html(optionsyear);
 					if($('#hidcmbyear').val()){
 						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
 						//funreload(event);
 					  }
 				} else {
 				}
 			}
 			x.open("GET", "getYear.jsp", true);
 			x.send();
 		}   
		function clickExEnqHandler() {
		    // Here, `this` refers to the element the event was hooked on
		    $(this).closest('tbody').find('tr').removeClass('active');
			$(this).closest('tr').addClass('active');
		}
		function validateFields(input){
			if($(input).attr('required')=='required'){
				if($(input).val()==''){
					$(input).closest('.form-group').addClass('has-error');
					$(input).closest('.form-group').find('.help-block').text($(input).attr("data-name")+' is Mandatory');
					$(input).closest('.form-group').find('.help-block').css('display','block');
					return false;
				}
				else{
					$(input).closest('.form-group').removeClass('has-error');
					$(input).closest('.form-group').find('.help-block').text('');
					$(input).closest('.form-group').find('.help-block').css('display','none');
				}
			}
			if($(input).attr('data-max')!='' && $(input).attr('data-max')!="undefined" && $(input).attr('data-max')!=null){
				var maxlength=parseInt($(input).attr('data-max'));
				if($(input).val().length>maxlength){
					$(input).closest('.form-group').addClass('has-error');
					$(input).closest('.form-group').find('.help-block').text('Max '+maxlength+' characters are allowed');
					$(input).closest('.form-group').find('.help-block').css('display','block');
					return false;
				}
				else{
					$(input).closest('.form-group').removeClass('has-error');
					$(input).closest('.form-group').find('.help-block').text('');
					$(input).closest('.form-group').find('.help-block').css('display','none');
				}
			}
		}
		
		function clickViewEndorsmentHandler(){
			var policyno=$(this).closest('td').prev('td').text();
			$('.nav-pills > .active').prev('li').find('a').trigger('click');
			var filter=policyno.toUpperCase();
			var table=document.getElementById("tblservice");    
			var tr=table.getElementsByTagName("tr");
			var txtValue;
			for (i = 0; i < tr.length; i++) {
    			td = tr[i].getElementsByTagName("td")[3];
    			if(td){
      				txtValue = td.textContent || td.innerText;
      				if(txtValue.toUpperCase().indexOf(filter) > -1) {
        				tr[i].style.display = "";
      				}
      				else{
        				tr[i].style.display = "none";
      				}
    			}
  			}			
		}
		
		function clickContractAttachHandler(){
			var filename=$(this).attr('data-filename');
			var filepath=$(this).attr('data-filepath');
			SaveToDisk(filepath,filename);
			return false;
		}
		
		function SaveToDisk(fileURL, fileName) {
	   		var host = window.location.origin;
	   		var splt = fileURL.split("webapps"); 
	   		var repl = splt[1].replace( /;/g, "/");
	   		fileURL=host+repl;
	    	
	    	if (!window.ActiveXObject) {
	        	var save = document.createElement('a');
	        	save.href = fileURL;
	        	save.target = '_blank';
	        	save.download = fileName || 'unknown';
	        	window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	    	}

	    	// for IE
	    	else if ( !! window.ActiveXObject && document.execCommand){
	        	var _window = window.open(fileURL, '_blank');
	        	_window.document.close();
	        	_window.document.execCommand('SaveAs', true, fileName || fileURL)
	       	 	_window.close();
	    	}
		}
    	function funRoundAmt(value,id){
    		var res=parseFloat(value).toFixed(2);
    		var res1=(res=='NaN'?"0":res);
    		document.getElementById(id).value=res1;  
   		}
   		function funChooseStmt(){
   			if(document.getElementById("optacstmt").checked==true){
   				$('#accountsStatementDiv').show();
   				$('#directStatementDiv').hide();
   			}
   			else{
   				$('#accountsStatementDiv').hide();
   				$('#directStatementDiv').show();
   			}
   		}
   		function getInitData(){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				$('.admin-cover .panel-body strong').text("Hi "+items.split("::")[0].trim());
	  				$('.user-dropdown .user-dropdown-text').text(items.split("::")[0].trim());
	  				var servicedata=JSON.parse(items.split("::")[1].trim());          
	  				var contracttablehtml='';    
	  				$.each(servicedata.contractdata, function( index, value ) {   
	  					var workper=value.workper;
	  					if(workper!=0){                
	  						styles="background-color:#99ffd6";     
	  					}else{
	  						styles="background-color:white";       
	  					}
	  					contracttablehtml+='<tr style="'+styles+'" data-workper="'+value.workper+'" data-srdocno="'+value.srdocno+'" data-branch="'+value.branch+'" data-contracttrno="'+value.doctrno+'" data-srtrno="'+value.srtrno+'" data-contracttype="'+value.dtype+'" data-serdocno="'+value.serdocno+'" data-tr_no="'+value.tr_no+'" data-siteid="'+value.siteid+'" data-acno="'+value.acno+'" data-docno2="'+value.docno2+'">';
	  					contracttablehtml+='<td align="center">'+value.srno+'</td>';   
	  					contracttablehtml+='<td>'+value.docno+'</td>';
	  					contracttablehtml+='<td>'+value.dtype+'</td>';
	  					contracttablehtml+='<td>'+value.pldate+'</td>';
	  					contracttablehtml+='<td>'+value.refname+'</td>';
	  					contracttablehtml+='<td>'+value.site+'</td>';          
	  					contracttablehtml+='</tr>';     
	  				});
	  				$('#tblservice tbody').html($.parseHTML(contracttablehtml));  
	  				document.querySelectorAll('#tblservice td')   
					.forEach(e => e.addEventListener("click", clickExEnqHandler));   
	  				
	  				var surveysdata=JSON.parse(items.split("::")[3].trim());          
	  				var surveytablehtml='';    
	  				$.each(surveysdata.surveydata, function( index, value ) {    
	  					var surdocno=value.surdocno;
	  					if(surdocno!=0){           
	  						styles="background-color:#99ffd6";     
	  					}else{
	  						styles="background-color:white";             
	  					}
	  					surveytablehtml+='<tr style="'+styles+'" data-survocno="'+value.survocno+'" data-surdocno="'+value.surdocno+'" data-vocno="'+value.vocno+'" data-brhid="'+value.brhid+'" data-docno="'+value.docno+'" data-cpersonid="'+value.cpersonid+'" data-cldocno="'+value.cldocno+'" data-empid="'+value.empid+'">';
	  					surveytablehtml+='<td align="center">'+value.srno+'</td>';              
	  					surveytablehtml+='<td>'+value.docno+'</td>'; 
	  					surveytablehtml+='<td>'+value.date+'</td>';
	  					surveytablehtml+='<td>'+value.refname+'</td>';
	  					surveytablehtml+='<td>'+value.site+'</td>';
	  					/* surveytablehtml+='<td>'+value.compaddress+'</td>'; */
	  					surveytablehtml+='<td>'+value.cperson+'</td>';
	  					surveytablehtml+='<td>'+value.conmob+'</td>';  
	  					surveytablehtml+='<td>'+value.remarks+'</td>';    
	  					surveytablehtml+='</tr>';             
	  				});
	  				$('#tblsurvey tbody').html($.parseHTML(surveytablehtml));  
	  				document.querySelectorAll('#tblsurvey td')           
					.forEach(e => e.addEventListener("click", clickExEnqHandler));      
	  				   
	  				$('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getClientInitData.jsp", true);
	  		x.send();
		} 
   	 function funUpdate(txtsrtrno,cmbcontracttype,txtcontracttrno,txtdesc,txtxper,txtcustomerdocno,txtcustomeracno,txtsiteid,txtscheduleno,servicetype,txtsrdocno){                   
    		 var rect =  $('#rect').val();
    		 //var rect =0;   
    		 var rectval=0;
    		 if(typeof(txtxper) == "undefined" || typeof(txtxper) == "NaN" || txtxper == ""){
    			Swal.fire({
 				type: 'warning',
 			  	title: 'Not Valid',
 			  	text: 'Please Enter Percentage'   
 			});
    			 return false;
    		 }
    		
    		 if(rect>0){
    			if(typeof(txtdesc) == "undefined" || typeof(txtdesc) == "NaN" || txtdesc == ""){               
    				Swal.fire({
    					type: 'warning',
    				  	title: 'Not Valid',
    				  	text: 'Please Enter Description'   
    				});
    				 return false;
    			 }
    			 rectval=1; 
    		 }
    		Swal.fire({   
	 		  title: 'Are you sure?',
	 		  type: 'warning',
	 		  showCancelButton: true,
	 		  confirmButtonColor: '#3085d6',
	 		  cancelButtonColor: '#d33',
	 		  confirmButtonText: 'Update'
	 		   }).then((result) => {
	 		  if (result.value) {
	 			  saveGridData(cmbcontracttype,txtcontracttrno,txtxper,txtdesc,rectval,txtsrtrno,txtcustomerdocno,txtcustomeracno,txtsiteid,txtscheduleno,servicetype,txtsrdocno);  
	 		  }
 		   });
    	}
    		
    function saveGridData(cmbcontracttype,txtcontracttrno,txtxper,txtdesc,rectval,txtsrtrno,txtcustomerdocno,txtcustomeracno,txtsiteid,txtscheduleno,servicetype,txtsrdocno){
        var latittude=$("#latittude").val();
        var longitude=$("#longitude").val();              
    	var x=new XMLHttpRequest();
    		x.onreadystatechange=function(){
    		if (x.readyState==4 && x.status==200){
    				var items=x.responseText;
    				if(parseInt(items)==1){
    				$('#servdesc').val("");
    				$('#servper').val(""); 
 	   				Swal.fire({
 	   					type: 'success',
 	   				  	title: 'Success',  
 	   				  	text: 'Saved Successfully'
 	   				});
    				getInitData();
    				}else{
 	   				Swal.fire({
 	   					type: 'error',
 	   				  	title: 'Error',     
 	   				  	text: 'Not Saved'
 	   				});    
    				}       
    				}       
    		}
          x.open("GET","saveData.jsp?address="+encodeURIComponent($("#address").val())+"&latittude="+latittude+"&longitude="+longitude+"&cmbcontracttype="+cmbcontracttype+"&txtcontracttrno="+txtcontracttrno+"&txtxper="+txtxper+"&txtdesc="+txtdesc+"&rectval="+rectval+"&txtsrtrno="+txtsrtrno+"&txtcustomerdocno="+txtcustomerdocno+"&txtcustomeracno="+txtcustomeracno+"&txtsiteid="+txtsiteid+"&txtscheduleno="+txtscheduleno+"&servicetype="+servicetype+"&txtsrdocno="+txtsrdocno,true);		
    	  x.send();         
    	}
      function funSave(year,month,costtype,employee,outtime,date,intime,costcode){
    	  if(employee==""){
				Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'Please select employee!'            
				});
				return false;
			}
    	  if(costtype==""){
				Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'Please select cost type!'        
				});
				return false;
			}
			if(costcode==""){
				Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'Please select cost code!'          
				});
				return false;
			}
			if($("#exval").val()=="2"){    
				Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'Please close the existing ticket first!'                
				});
				return false;
			}
			if($("#exval").val()=="3"){    
				Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'Ticket already closed!'                         
				});
				return false;
			}
			/* if((typeof(intime) == "undefined" || typeof(intime) == "NaN" || intime == "" || intime == "00:00") && (typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != "" && outtime != "00:00")){    
  				Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'In Time is required for Normal Hours!'        
				});
				return false;
  			}
			if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "" && intime != "00:00") && (typeof(outtime) == "undefined" || typeof(outtime) == "NaN" || outtime == "" || outtime == "00:00")){
  				Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'Out Time is required for Normal Hours!'        
				});
				return false;
  			}       
  			var startDate = new Date($('#timeSheetInTime').jqxDateTimeInput('val', 'date'));
  			var endDate = new Date($('#timeSheetOutTime').jqxDateTimeInput('val', 'date'));   
            if(Date.parse(endDate) < Date.parse(startDate)){
            	Swal.fire({
					type: 'warning',
				  	title: 'Not Valid',
				  	text: 'Out time should be greater than in time!'           
				});
				return false;
            } */ 
			
			var normalHours =new Date("01/01/2017 00:00:00");     
	  		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "" && intime != "00:00") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != "" && outtime != "00:00"){
	  			
				var startDate = new Date($('#timeSheetInTime').jqxDateTimeInput('val', 'date'));
				var endDate = new Date($('#timeSheetOutTime').jqxDateTimeInput('val', 'date'));   
		        var hours1 = (endDate.getTime() - startDate.getTime()) / (1000 * 60);   
		        var newhours = Math.floor(hours1/60);
		        var newhours1 = ('0' + newhours).slice(-2);
		        var newminutes1 = hours1-(newhours*60);
		        
		        normalHours = new Date("01/01/2017 " + (newhours1+":"+newminutes1+":00"));
	  		}
	  		 $('#timeSheetNormalHrs').jqxDateTimeInput('val', normalHours);
	  		var normalhrs=$('#timeSheetNormalHrs').jqxDateTimeInput('val');
    	  Swal.fire({   
	 		  title: 'Are you sure?',
	 		  type: 'warning',
	 		  showCancelButton: true,
	 		  confirmButtonColor: '#3085d6',
	 		  cancelButtonColor: '#d33',
	 		  confirmButtonText: 'Save'
	 		   }).then((result) => {
	 		  if (result.value) {
	 			  saveTimeSheetData(year,month,costtype,employee,outtime,date,intime,costcode,normalhrs);      
	 		  }
 		   });   
      }
      function saveTimeSheetData(year,month,costtype,employee,outtime,date,intime,costcode,normalhrs){     
    	  var latittude=$("#latittude").val();
          var longitude=$("#longitude").val();           
    	  var x=new XMLHttpRequest();
     		x.onreadystatechange=function(){
     		if (x.readyState==4 && x.status==200){
     				var items=x.responseText;
     				if(parseInt(items)==1){
     				$('#timeSheetInTime').val("");
     				$('#timeSheetOutTime').val("");  
     				$('#timeSheetNormalHrs').val("");
     				$('#cmbcostcode').val(""); 
     				$('#cmbemployee').val(""); 
     				$('#cmbcosttype').val(""); 
     				$('#cmbcostcode').text(""); 
     				$('#cmbemployee').text(""); 
     				$('#cmbcosttype').text(""); 
     				$('#tsrowno').val(""); 
     				$('#exval').val(""); 
     				getCostType();
     	    		getEmployee();
     	    		getCostCode();     
  	   				Swal.fire({
  	   					type: 'success',	
  	   				  	title: 'Success',  
  	   				  	text: 'Saved Successfully'      
  	   				});
  	   				getInitData();
     				}else{
  	   				Swal.fire({
  	   					type: 'error',
  	   				  	title: 'Error',     
  	   				  	text: 'Not Saved'   
  	   				});    
     				}
     				}       
     		}              
           x.open("GET","createTimeSheet.jsp?latittude="+latittude+"&longitude="+longitude+"&empid="+encodeURIComponent(employee)+"&normalhrs="+normalhrs+"&costcode="+costcode+"&costid="+costtype+"&year="+year+"&month="+month+"&outtime="+outtime+"&intime="+intime+"&date="+date+"&tsrowno="+$("#tsrowno").val(),true);	    	
     	  x.send();   
     	}
      function funSurveyCreate(empid,brhid,docno,cpersonid,cldocno,vocno,txtdesc){
		Swal.fire({   
	 		  title: 'Are you sure?',
	 		  type: 'warning',
	 		  showCancelButton: true,
	 		  confirmButtonColor: '#3085d6',
	 		  cancelButtonColor: '#d33',
	 		  confirmButtonText: 'Save'
	 		   }).then((result) => {
	 		  if (result.value) {
	 			 surveyCreate(empid,brhid,docno,cpersonid,cldocno,vocno,txtdesc);              
	 		  }
		   });     
      }   
      function surveyCreate(empid,brhid,docno,cpersonid,cldocno,vocno,txtdesc){    
    	  var latittude=$("#latittude").val();
          var longitude=$("#longitude").val();                             
    	  var date=new Date();      
          var x=new XMLHttpRequest();
     		x.onreadystatechange=function(){
     		if (x.readyState==4 && x.status==200){
     				var items=x.responseText;
     				if(parseInt(items)==1){   
	  	   				Swal.fire({
	  	   					type: 'success',      
	  	   				  	title: 'Success',  
	  	   				  	text: 'Saved Successfully'      
	  	   				});
	  	   				$("#survdesc").val("");
	  	   			getInitData();
     				}else{
	  	   				Swal.fire({
	  	   					type: 'error',
	  	   				  	title: 'Error',     
	  	   				  	text: 'Not Saved'   
	  	   				});            
     				}
     				}       
     		}
           x.open("GET","createSurveyDetails.jsp?address="+encodeURIComponent($("#address").val())+"&latittude="+latittude+"&longitude="+longitude+"&empid="+empid+"&brhid="+brhid+"&enqid="+docno+"&enqno="+vocno+"&clientid="+cldocno+"&cpersonid="+cpersonid+"&txtdesc="+encodeURIComponent(txtdesc)+"&date="+date,true);		
     	  x.send();   
     	}
      function funSurveyConfirm(docno){
  		Swal.fire({   
  	 		  title: 'Are you sure?',
  	 		  type: 'warning',
  	 		  showCancelButton: true,
  	 		  confirmButtonColor: '#3085d6',
  	 		  cancelButtonColor: '#d33',
  	 		  confirmButtonText: 'Confirm'   
  	 		   }).then((result) => {
  	 		  if (result.value) {
  	 			surveyConfirm(docno);                      
  	 		  }
  		   });     
        }   
        function surveyConfirm(docno){    
            var x=new XMLHttpRequest();
       		x.onreadystatechange=function(){
       		if (x.readyState==4 && x.status==200){
       				var items=x.responseText;
       				if(parseInt(items)==1){   
  	  	   				Swal.fire({
  	  	   					type: 'success',      
  	  	   				  	title: 'Success',  
  	  	   				  	text: 'Confirmed Successfully'               
  	  	   				});
  	  	   			getInitData();
       				}else{
  	  	   				Swal.fire({
  	  	   					type: 'error',
  	  	   				  	title: 'Error',     
  	  	   				  	text: 'Not Confirmed'         
  	  	   				});            
       				}
       				}       
       		}
             x.open("GET","confirmSurveyDetails.jsp?docno="+docno,true);		
       	  x.send();             
       	}
        function funServiceConfirm(docno){
      		Swal.fire({   
      	 		  title: 'Are you sure?',
      	 		  type: 'warning',
      	 		  showCancelButton: true,
      	 		  confirmButtonColor: '#3085d6',
      	 		  cancelButtonColor: '#d33',
      	 		  confirmButtonText: 'Confirm'   
      	 		   }).then((result) => {
      	 		  if (result.value) {
      	 			serviceConfirm(docno);                         
      	 		  }
      		   });     
            }   
            function serviceConfirm(docno){           
                var x=new XMLHttpRequest();
           		x.onreadystatechange=function(){
           		if (x.readyState==4 && x.status==200){
           				var items=x.responseText;
           				if(parseInt(items)==1){   
      	  	   				Swal.fire({
      	  	   					type: 'success',      
      	  	   				  	title: 'Success',  
      	  	   				  	text: 'Confirmed Successfully'               
      	  	   				});
      	  	   			getInitData();
           				}else{
      	  	   				Swal.fire({
      	  	   					type: 'error',
      	  	   				  	title: 'Error',     
      	  	   				  	text: 'Not Confirmed'         
      	  	   				});            
           				}
           				}               
           		}
                 x.open("GET","confirmServiceUpdate.jsp?docno="+docno,true);              		
           	  x.send();             
           	}
            function curLocation(){
            	if (navigator.geolocation){
            		  navigator.geolocation.getCurrentPosition(showPosition);
            	}else{
            		  alert("Geolocation is not supported by this browser.");          
            	}     
            }
            function showPosition(position){ 
            	var latitude,longitude;         
                latitude=position.coords.latitude;
                longitude=position.coords.longitude;
                console.log("Latitude: " + position.coords.latitude +"<br>Longitude: " + position.coords.longitude); 
                $("#latittude").val(position.coords.latitude);
                $("#longitude").val(position.coords.longitude);                                     
                var geocoder = new google.maps.Geocoder();
                var latLng = new google.maps.LatLng(latitude, longitude);

                if (geocoder) {      
                    geocoder.geocode({ 'latLng': latLng}, function (results, status) {
                   if (status == google.maps.GeocoderStatus.OK) {
                     console.log(results[0].formatted_address);  
                     $("#address").val(results[0].formatted_address);   
                   }
                   else {
                    console.log("Geocoding failed: " + status);      
                   }
                  }); //geocoder.geocode()
                 }      
             }
          function getTimeSheetDefaults(){ 
        	    var costtype=$('#cmbcosttype').val();
				var employee=$('#cmbemployee').val();
				var costcode=$('#cmbcostcode').val(); 
				var intime=$('#timeSheetInTime').val(); 
				var date=$('#timeSheetDate').val();             
     			var x = new XMLHttpRequest();
     			x.onreadystatechange = function() {
     				if (x.readyState == 4 && x.status == 200) {
     					var items = x.responseText.trim().split("###");	
     					if(parseInt(items[0])==1){
     						 $('#timeSheetOutTime').val(new Date());   
     						 var intime = new Date(items[3]+" "+ (items[2]+":00"));        
     			  		     $('#timeSheetInTime').jqxDateTimeInput('val', intime);            
     						 $('#tsrowno').val(items[1]); 
     						 $('#exval').val(items[0]);       
     					}else if(parseInt(items[0])==2){
     						 $('#exval').val(items[0]); 
     						 $('#tsrowno').val(items[1]); 
     						 $('#timeSheetOutTime').val("");           
     					}else if(parseInt(items[0])==3){
     						 $('#exval').val(items[0]);    
     						 $('#tsrowno').val(items[1]); 
     						 $('#timeSheetOutTime').val("");               
     					}else{
     						 $('#exval').val(items[0]); 
     						 $('#tsrowno').val(items[1]); 
     						 $('#timeSheetOutTime').val("");            
    						 $('#timeSheetInTime').val(new Date());       
     					}
     				} else {  
     				}  
     			}
     			x.open("GET", "getTimeSheetDefaults.jsp?employee="+employee+"&costtype="+costtype+"&costcode="+costcode+"&intime="+intime+"&date="+date, true); 
     			x.send();
     		}    
          function funselect(){
      		var rect =  $('#rect').val();
      		if(rect=="1")
      			{
      			$('#servdesc').attr("disabled",false);
      			}
      		else{
      			document.getElementById("servdesc").value ="";
      			$('#servdesc').attr("disabled",true);
      		}
      	}
          
    </script>           
</body>     
</html>