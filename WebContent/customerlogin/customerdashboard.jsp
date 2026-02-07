<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Customer Dashboard</title>            
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<script src="../vendors/jquery/jquery-3.2.1.min.js"></script>
<script src="js/table2excel.js"></script>        
<script src="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/js/tableexport.min.js"></script>
<link rel="stylesheet" type="text/css" href="../vendors/daterangepicker/daterangepicker.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
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
	#tbl_workdetailslist tbody tr.active td,#tbl_invoicelist tbody tr.active td,#tbl_contractlist tbody tr.active td,#tbl_schedulelist tbody tr.active td{ 
		color: #fff;
	    background-color: rgba(88,103,221,1);  
	}
	#tbl_workdetailslist tbody tr.active td span.badge,#tbl_schedulelist tbody tr.active td span.badge,#tbl_contractlist tbody tr.active td span.badge,#tbl_invoicelist tbody tr.active td span.badge{   
		background-color:#fff;
		color:rgba(88,103,221,1);
	}
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
	
	#tbl_workdetailslist .btn-group .btn,#tbl_schedulelist .btn-group .btn,#tbl_invoicelist .btn-group .btn,#tbl_contractlist .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
	
	#tbl_workdetailslist .table-responsive,#tbl_schedulelist .table-responsive,#tbl_invoicelist .table-responsive,#tbl_contractlist .table-responsive {
	  overflow-y: visible !important;    
	}
	
	/* .tblheadfix {
	    position: sticky;
	    width: 100%;
	    z-index: 99999;
	    top: 0;
	    background-color:#FFFAFA;  
    } */  
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i>Loading</button>
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
      				<span style="margin-right:10px;"><img alt="" src="images/aits-logo.png" style="width:auto; height: 100%;"></span>
      				Customer Dashboard     
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> <span class="user-dropdown-text">Super</span>
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
    		<li class="active"><a data-toggle="pill" href="#menu_contractlist"><i class="fa fa-file-text-o p-r-5"></i>Contract List</a></li> 
    		<li><a data-toggle="pill" href="#menu_invoicelist"><i class="fa fa-usd p-r-5"></i>Invoice List</a></li>
    		<li><a data-toggle="pill" href="#menu_schedulelist"><i class="fa fa-calendar-check-o p-r-5"></i>Schedule List</a></li> 
    		<li><a data-toggle="pill" href="#menu_acstmtlist"><i class="fa fa-credit-card p-r-5"></i>Account Statement</a></li>                                      
  		</ul>  
  	   <div class="tab-content"> 
  	       <div id="menu_contractlist" class="tab-pane fade in active">          
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						 <div class="panel panel-default">	
  						    <div class="panel-body">       
  							    <div id="row">   
  							       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2"> 
		                              <div class="form-group">
		                                    <label for="type" class="col-md-3 control-label pt-20">Type</label>  
		                                    <div class="col-md-9">       
		                                        <select id="cmbtype" name="cmbtype" class="form-control select2">
								  					<option value="">--Select--</option>
								  					<option value="AMC">AMC</option>
								  					<option value="SJOB">SJOB</option>  
								  				</select>
		                                        <span class="help-block"></span> 
		                                    </div>
		                              </div>
		                            </div>  
		                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
			                            <div class="form-group">
			                                    <label for="cldaterage" class="col-md-5 control-label">Date Range</label>  
			                                    <div class="col-md-7">      
			                                    	 <input type="text" name="cldaterage" value="" id="cldaterage" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
			                                    </div>
			                            </div>  
		                            </div>
		                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		                               <button type="button" class="btn btn-default" id="btnsubmitcl"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	                           <button type="button" class="btn btn-default" id="btnexcelcl" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
		                            </div>     
    						   </div>
    					      <div id="row">     
  							     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12"> 	
  						           <div class="table-responsive m-t-15" style="max-height:370px;overflow:auto;">
  								     <table class="table table-hover" id="tbl_contractlist">            
  									     <thead>       
  										     <tr>
		  											<th>Sr.No</th>
		  											<th>Doc No</th>
		  											<th>Doc Type</th>
		  											<th>Date</th>     
		  											<th>Contact Person</th>
		  											<th>Site</th>
		  											<th>Start Date</th>   
		  											<th>End Date</th>
		  											<th align="right">Contract Value</th>  
		  											<th align="right">Legal Fees</th>  
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
		  											<td>&nbsp;</td>    
		  											<td>&nbsp;</td>       
		  									 </tr>  
  									   </tbody>
  								    </table>
  							     </div>
  							   </div>
  						       </div>
  						     </div>    	
    					  </div>
  						</div>
  					</div>
  				</div>
  			</div> 
  			<div id="menu_invoicelist" class="tab-pane fade">        
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						 <div class="panel panel-default">	
  						    <div class="panel-body">       
  							    <div id="row">   
		                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
			                            <div class="form-group">
			                                    <label for="invdaterage" class="col-md-5 control-label">Date Range</label>   
			                                    <div class="col-md-7">      
			                                    	 <input type="text" name="invdaterage" value="" id="invdaterage" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
			                                    </div>
			                            </div>  
		                            </div>
		                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">      
		                               <button type="button" class="btn btn-default" id="btnsubmitinv"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>      
          	                           <button type="button" class="btn btn-default" id="btnexcelinv" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
		                               <button type="button" class="btn btn-default" id="btninvprint" data-toggle="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
		                            </div>     
    						   </div>
    					      <div id="row">     
  							     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12"> 	
  						           <div class="table-responsive m-t-15" style="max-height:370px;overflow:auto;">
  								     <table class="table table-hover" id="tbl_invoicelist">              
  									     <thead>       
  										    <tr>
	  											<th>Sr.No</th>
	  											<th>Inv No</th>
	  											<th>Date</th>  
	  											<th>Contract Type</th>
	  											<th>Contract No</th>   
	  											<th>Site</th>
	  											<th>Description</th> 
	  											<th align="right">Tax Amount</th> 
	  											<th align="right">Amount</th> 
	  											<th align="right">Legal Amount</th> 
	  											<th align="right">Total Amount</th>     
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
	  											<td>&nbsp;</td> 
	  											<td>&nbsp;</td> 
	  											<td>&nbsp;</td>    
  										    </tr>     
  									   </tbody>
  								    </table>
  							     </div>
  							   </div>
  						       </div>
  						     </div>    	
    					  </div>
  						</div>
  					</div>
  				</div>
  			</div> 
  			<div id="menu_schedulelist" class="tab-pane fade">        
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						 <div class="panel panel-default">	
  						    <div class="panel-body">       
  							    <div id="row">   
  							       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2"> 
		                              <div class="form-group">
		                                    <label for="type" class="col-md-3 control-label">Status</label>  
		                                    <div class="col-md-9">       
		                                        <select id="cmbstatus" name="cmbstatus" class="form-control select2">  
								  					<option value="3">Entered</option>
								  					<option value="4">Assign</option> 
								  					<option value="5">Completed</option>     
								  				</select> 
		                                        <span class="help-block"></span> 
		                                    </div>
		                              </div>
		                            </div>  
		                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
			                            <div class="form-group">
			                                    <label for="schdaterage" class="col-md-5 control-label">Date Range</label>  
			                                    <div class="col-md-7">      
			                                    	 <input type="text" name="schdaterage" value="" id="schdaterage" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
			                                    </div>   
			                            </div>  
		                            </div>
		                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">      
		                               <button type="button" class="btn btn-default" id="btnsubmitsch"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	                           <button type="button" class="btn btn-default" id="btnexcelsch" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
		                            </div>     
    						   </div>
    					      <div class="row">     
  							     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12"> 	
  						           <div class="table-responsive m-t-15" style="max-height:370px;overflow:auto;">
  								     <table class="table table-hover" id="tbl_schedulelist">              
  									     <thead class="tblheadfix">       
  										    <tr>
	  											<th>Sr.No</th>
	  											<th>Doc Type</th>
	  											<th>Doc No</th>
	  											<th>Sch. No</th>     
	  											<th>Site</th>
	  											<th>Area</th>
	  											<th>Salesman</th>
	  											<th>Assign Group</th>
	  											<th>Plan Date</th>
	  											<th>Description</th> 
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
	  											<td>&nbsp;</td>  
	  											<td>&nbsp;</td>      
  										    </tr>   
  									   </tbody>
  								    </table>
  							     </div>
  							    </div>
  						       </div>
  						      <div class="row" id="workdetails">       
  							     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12"> 	
  						           <div class="table-responsive m-t-15" style="max-height:370px;overflow:auto;">
  								     <table class="table table-hover" id="tbl_workdetailslist">                
  									     <thead>       
  										    <tr>
	  											<th>Sr.No</th>
	  											<th>User Name</th>
	  											<th>Date</th>
	  											<th>Completion %</th>     
  										    </tr> 
  									    </thead>
  									    <tbody>
  										    <tr>
	  											<td>&nbsp;</td>
	  											<td>&nbsp;</td>   
												<td>&nbsp;</td>  
												<td>&nbsp;</td>
  										    </tr>   
  									   </tbody>
  								    </table>
  							     </div>
  							    </div>
  						       </div>
  						     </div>    	
    					  </div>
  						</div>
  					</div>
  				</div>  
  			</div> 
  			<div id="menu_acstmtlist" class="tab-pane fade">            
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						 <div class="panel panel-default">	
  						    <div class="panel-body">       
  							    <div id="row"> 
  							        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
			                            <div class="form-group">
			                                    <label for="acstmtdaterage" class="col-md-5 control-label">Date Range</label>  
			                                    <div class="col-md-7">       
			                                    	 <input type="text" name="acstmtdaterage" value="" id="acstmtdaterage" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
			                                    </div>   
			                            </div>  
		                            </div>  
		                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">      
		                               <button type="button" class="btn btn-default" id="btnsubmitac"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	                           <button type="button" class="btn btn-default" id="btnexcelac" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
		                               <button type="button" class="btn btn-default" id="btnstmtprint" data-toggle="tooltip" title="Statement Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
		                               <button type="button" class="btn btn-default" id="btnoutstandingprint" data-toggle="tooltip" title="Outstanding Statement" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
		                            </div>      
    						   </div>
    					      <div id="row">     
  							     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12"> 	
  						           <div class="table-responsive m-t-15" style="max-height:370px;overflow:auto;">  
  								     <table class="table table-hover" id="tbl_acstmtlist">              
  									     <thead>       
  										     <tr>
		  											<th>Sr.No</th>
		  											<th>Date</th>
		  											<th>Type</th>
		  											<th>Doc No</th>     
		  											<th>Branch</th>
		  											<th>Description</th>
		  											<th>Dr</th>   
		  											<th>Cr</th>  
		  											<th>Balance</th>    
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
		  											<td>&nbsp;</td>       
		  									 </tr>  
  									   </tbody>
  								    </table>
  							     </div>
  							   </div>
  						       </div>
  						     </div>    	
    					  </div>
  						</div>
  					</div>
  				</div>
  			</div> 
  		  </div>   
  		</div>
                       
	<input type="hidden" name="clientacno" id="clientacno">
	<input type="hidden" name="hidsertrno" id="hidsertrno">     
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script src="../vendors/daterangepicker/moment.min.js"></script>
	<script src="../vendors/daterangepicker/daterangepicker.js"></script>
    <script>     
    $(document).on("dblclick","#tbl_schedulelist tr",function() {    
	    var activerow = $('#tbl_schedulelist tbody tr.active');
		var sertrno = $('#tbl_schedulelist tbody tr.active').attr('data-sertrno');
		$("#hidsertrno").val(sertrno);   
		$("#tbl_workdetailslist").show(); 
		getInitData("workdetails");    
	}); 

    $(document).ready(function(){   
    	    $("#tbl_workdetailslist").hide();    
    		$('[data-toggle="tooltip"]').tooltip();
    		
    		$('#cmbtype').select2({
  				placeholder:"Please select a type",      
  				allowClear:true, 
  			});
    		$('#cmbstatus').select2({
  				placeholder:"Please select a status",        
  				allowClear:true, 
  			});
    		
    		$('#cldaterage,#invdaterage,#schdaterage,#acstmtdaterage').daterangepicker({ 
                showCalendars:true,
                locale: {
            		format: 'DD/MM/YYYY'
        		}
            });
    		$('#cldaterage').data('daterangepicker').setStartDate(moment().subtract(1, 'month'));
			$('#cldaterage').data('daterangepicker').setEndDate(moment());  
			$('#invdaterage').data('daterangepicker').setStartDate(moment().subtract(1, 'month'));
			$('#invdaterage').data('daterangepicker').setEndDate(moment());    
			$('#schdaterage').data('daterangepicker').setStartDate(moment().subtract(1, 'month'));
			$('#schdaterage').data('daterangepicker').setEndDate(moment()); 
			$('#acstmtdaterage').data('daterangepicker').setStartDate(moment().subtract(1, 'month'));
			$('#acstmtdaterage').data('daterangepicker').setEndDate(moment());     
			
    		$('#btnsubmitcl').click(function(){
    			$('.page-loader').show();
    			getInitData("Contract List");  
    		}); 
    		$('#btnsubmitinv').click(function(){
    			$('.page-loader').show();
    			getInitData("Invoice List");   
    		});
    		$('#btnsubmitsch').click(function(){
    			$('.page-loader').show();
    			getInitData("Schedule List");      
    		});
    		$('#btnsubmitac').click(function(){  
    			$('.page-loader').show();
    			getInitData("Account Statement");        
    		});
    		
    		$('#btnexcelcl').click(function(){
    			funExport("Contract List");  
    		}); 
    		$('#btnexcelinv').click(function(){
    			funExport("Invoice List");   
    		});
    		$('#btnexcelsch').click(function(){
    			funExport("Schedule List");         
    		});
    		$('#btnexcelac').click(function(){
    			funExport("Account Statement");         
    		});
    		
    		$('#btnstmtprint').click(function(){  
    			fromdate = $('#acstmtdaterage').data('daterangepicker').startDate.format('DD.MM.YYYY');   
				todate = $('#acstmtdaterage').data('daterangepicker').endDate.format('DD.MM.YYYY');  
				var clientacno=document.getElementById("clientacno").value;
				var netamount=0.00;   
		        var win= window.open("<%=contextPath%>/com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+clientacno+"&netamount="+netamount+"&branch=a&fromDate="+fromdate+"&toDate="+todate+"&chckopn=1&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus();        
    		});
    		$('#btnoutstandingprint').click(function(){
    			fromdate = $('#acstmtdaterage').data('daterangepicker').startDate.format('DD.MM.YYYY');   
				todate = $('#acstmtdaterage').data('daterangepicker').endDate.format('DD.MM.YYYY'); 
				var clientacno=document.getElementById("clientacno").value;
				var netamount=0.00;   
				var win= window.open("<%=contextPath%>/com/dashboard/accounts/ageingstatement/printAgeingOutstandingsStatement?&acno="+clientacno+"&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch=a&uptoDate="+todate+"&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus(); 
    		});
    		$('#btninvprint').click(function(){  
    			var activerow = $('#tbl_invoicelist tbody tr.active');
    			var docno = $('#tbl_invoicelist tbody tr.active').attr('data-docno');
    			var brhid = $('#tbl_invoicelist tbody tr.active').attr('data-brhid');
    			var trno = $('#tbl_invoicelist tbody tr.active').attr('data-tr_no');
    			var dtype = $('#tbl_invoicelist tbody tr.active').attr('data-dtype');   
		        var win= window.open("<%=contextPath%>/com/project/execution/projectinvoice/printInvoice?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&bankdocno=0&header=1&freq=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		        win.focus();        
    		});
    		
    	});     
    	$(window).ready(function(){ 
    		getInitData("")
    		$('.page-loader').hide();    
		});
    
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
    	
   		function getInitData(type){
   			var conttype = $("#cmbtype").val();
   			var status = $("#cmbstatus").val();
   			var sertrno = $("#hidsertrno").val();  
   			var fromdate,todate;
   			if(type=="Contract List"){       
   				fromdate = $('#cldaterage').data('daterangepicker').startDate.format('DD.MM.YYYY');
				todate = $('#cldaterage').data('daterangepicker').endDate.format('DD.MM.YYYY');
   			}else if(type=="Invoice List"){
   				fromdate = $('#invdaterage').data('daterangepicker').startDate.format('DD.MM.YYYY');   
				todate = $('#invdaterage').data('daterangepicker').endDate.format('DD.MM.YYYY');
   			}else if(type=="Schedule List"){  
   				fromdate = $('#schdaterage').data('daterangepicker').startDate.format('DD.MM.YYYY');   
				todate = $('#schdaterage').data('daterangepicker').endDate.format('DD.MM.YYYY');
   			}else if(type=="Account Statement"){    
   				fromdate = $('#acstmtdaterage').data('daterangepicker').startDate.format('DD.MM.YYYY');   
				todate = $('#acstmtdaterage').data('daterangepicker').endDate.format('DD.MM.YYYY');
   			}else{}
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();  
	  				//$('.admin-cover .panel-body strong').text("Hi "+items.split("::")[0].trim());
	  				$('.user-dropdown .user-dropdown-text').text(items.split("::")[0].trim());
	  				$("#clientacno").val(items.split("::")[6].trim());   
	  				if(type=="Contract List"){
	  					var cntlistdata=JSON.parse(items.split("::")[1].trim());          
		  				var contracttablehtml='';    
		  				$.each(cntlistdata.contractdata, function( index, value ) {     
		  					contracttablehtml+='<tr data-brhid="'+value.brhid+'" data-refname="'+value.refname+'" data-docno="'+value.docno+'" data-dtype="'+value.dtype+'" data-tr_no="'+value.tr_no+'">';
		  					contracttablehtml+='<td align="center">'+value.srno+'</td>';     
		  					contracttablehtml+='<td>'+value.docno+'</td>';
		  					contracttablehtml+='<td>'+value.dtype+'</td>';
		  					contracttablehtml+='<td>'+value.date+'</td>';
		  					contracttablehtml+='<td>'+value.cperson+'</td>';
		  					contracttablehtml+='<td>'+value.site+'</td>';  
		  					contracttablehtml+='<td>'+value.stdate+'</td>'; 
		  					contracttablehtml+='<td>'+value.enddate+'</td>'; 
		  					contracttablehtml+='<td align="right">'+value.cvalue+'</td>'; 
		  					contracttablehtml+='<td align="right">'+value.lfee+'</td>';   
		  					contracttablehtml+='</tr>';         
		  				});
		  				$('#tbl_contractlist tbody').html($.parseHTML(contracttablehtml));    
		  				 document.querySelectorAll('#tbl_contractlist td')   
						.forEach(e => e.addEventListener("click", clickExEnqHandler)); 
	  				}else if(type=="Invoice List"){  
	  					var invlistdata=JSON.parse(items.split("::")[3].trim());          
		  				var invoicetablehtml='';    
		  				$.each(invlistdata.invoicedata, function( index, value ) {       
		  					invoicetablehtml+='<tr data-brhid="'+value.brhid+'" data-refname="'+value.refname+'" data-docno="'+value.doc_no+'" data-dtype="'+value.dtype+'" data-tr_no="'+value.tr_no+'">';
		  					invoicetablehtml+='<td align="center">'+value.srno+'</td>';     
		  					invoicetablehtml+='<td>'+value.doc_no+'</td>';
							invoicetablehtml+='<td>'+value.date+'</td>';
		  					invoicetablehtml+='<td>'+value.contrtype+'</td>';
		  					invoicetablehtml+='<td>'+value.contrno+'</td>';
							invoicetablehtml+='<td>'+value.site+'</td>'; 
		  					invoicetablehtml+='<td>'+value.desc1+'</td>';
		  			        invoicetablehtml+='<td align="right">'+value.taxamt+'</td>';  
		  					invoicetablehtml+='<td align="right">'+value.invamt+'</td>'; 
		  					invoicetablehtml+='<td align="right">'+value.lfee+'</td>'; 
		  					invoicetablehtml+='<td align="right">'+value.total+'</td>';           
		  				});
		  				$('#tbl_invoicelist tbody').html($.parseHTML(invoicetablehtml));      
		  				 document.querySelectorAll('#tbl_invoicelist td')   
						.forEach(e => e.addEventListener("click", clickExEnqHandler)); 
	  				}else if(type=="Schedule List"){   
	  					var schlistdata=JSON.parse(items.split("::")[2].trim());          
		  				var scheduletablehtml='';        
		  				$.each(schlistdata.scheduledata, function( index, value ) {       
		  					scheduletablehtml+='<tr data-sertrno="'+value.sertrno+'">';      
		  					scheduletablehtml+='<td align="center">'+value.srno+'</td>';  
                            scheduletablehtml+='<td>'+value.contrtype+'</td>';
		  					scheduletablehtml+='<td>'+value.contrno+'</td>';							
		  					scheduletablehtml+='<td>'+value.schno+'</td>';
							scheduletablehtml+='<td>'+value.site+'</td>'; 
		  					scheduletablehtml+='<td>'+value.area+'</td>';
							scheduletablehtml+='<td>'+value.salesman+'</td>';
							scheduletablehtml+='<td>'+value.assigngrp+'</td>';
							scheduletablehtml+='<td>'+value.pldate+'</td>';
							scheduletablehtml+='<td>'+value.desc1+'</td>';         
		  				});
		  				$('#tbl_schedulelist tbody').html($.parseHTML(scheduletablehtml));        
		  				 document.querySelectorAll('#tbl_schedulelist td')     
						.forEach(e => e.addEventListener("click", clickExEnqHandler));     
	  				}else if(type=="workdetails"){   
	  					var wrklistdata=JSON.parse(items.split("::")[4].trim());            
		  				var worktablehtml='';           
		  				$.each(wrklistdata.workdetailsdata, function( index, value ) {            
		  					worktablehtml+='<tr>';      
		  					worktablehtml+='<td align="center">'+value.srno+'</td>';     
		  					worktablehtml+='<td>'+value.user_name+'</td>';   
		  					worktablehtml+='<td>'+value.date+'</td>';							
		  					worktablehtml+='<td>'+value.wrkper+'</td>';      
		  				});
		  				$('#tbl_workdetailslist tbody').html($.parseHTML(worktablehtml));           
		  				 document.querySelectorAll('#tbl_workdetailslist td')     
						.forEach(e => e.addEventListener("click", clickExEnqHandler));       
	  				}else if(type=="Account Statement"){                              
	  					var acstmtlistdata=JSON.parse(items.split("::")[5].trim());               
		  				var acstmttablehtml='';                
		  				$.each(acstmtlistdata.acstmtdata, function( index, value ) {            
		  					acstmttablehtml+='<tr>';      
		  					acstmttablehtml+='<td align="center">'+value.srno+'</td>';     
		  					acstmttablehtml+='<td>'+value.trdate+'</td>';     
		  					acstmttablehtml+='<td>'+value.transtype+'</td>';							
		  					acstmttablehtml+='<td>'+value.transno+'</td>'; 
		  					acstmttablehtml+='<td>'+value.branchname+'</td>'; 
		  					acstmttablehtml+='<td>'+value.description+'</td>'; 
		  					acstmttablehtml+='<td>'+value.dr+'</td>'; 
		  					acstmttablehtml+='<td>'+value.cr+'</td>'; 
		  					acstmttablehtml+='<td>'+value.Balance+'</td>';        
		  				});
		  				$('#tbl_acstmtlist tbody').html($.parseHTML(acstmttablehtml));                
		  				 document.querySelectorAll('#tbl_acstmtlist td')       
						.forEach(e => e.addEventListener("click", clickExEnqHandler));       
	  				}else{}
	  				$('.page-loader').hide();   
	  			}
	  		}
	  		x.open("GET", "getClientInitData.jsp?type="+encodeURIComponent(type)+"&sertrno="+sertrno+"&status="+status+"&conttype="+conttype+"&fromdate="+fromdate+"&todate="+todate, true);      
	  		x.send();
		} 
   		function funExport(type){  
	  				if(type=="Contract List"){
	  					  $("#tbl_contractlist").table2excel({    
	  				      		filename: "ContractList.xls"     
	  					  });  
	  				}else if(type=="Invoice List"){  
	  					 $("#tbl_invoicelist").table2excel({  
	  				      		filename: "InvoiceList.xls"     
	  					  }); 
	  				}else if(type=="Schedule List"){   
	  					 $("#tbl_schedulelist").table2excel({    
	  				      		filename: "ScheduleList.xls"     
	  					  }); 
	  				}else if(type=="Account Statement"){     
	  					 $("#tbl_acstmtlist").table2excel({      
	  				      		filename: "AccountStatement.xls"     
	  					  }); 
	  				}else{}  
   		 }
    </script>           
</body>     
</html>