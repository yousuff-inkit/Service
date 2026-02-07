<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- <link rel="shortcut icon" href="/Manufacturing/gatelogo.ico" > -->
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
	.no-border{
		border:none;
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
	@media screen and (max-width: 800px) {

    #prdset {
    border : 1px; double color-name;
    }

    #prdset thead {
      display: none;
    }

    #prdset tr {
      
      display: block;
      width:auto;
    }
    #prdset tr td.nchngelmnt {
      display: inline;
      
     
    }
    #prdset tr td.chngelmnt {
      display: inline-block;
     width:32%;
     
    }

 #prdset tr td.dchngelmnt {
      display: inline-block;
     width:32%;
     
    }
  
    
    #prdset td:last-child {
      border-bottom: 0;
    }

 fieldset.scheduler-border {
    border: 1px groove #ddd !important;
    padding: 0 1.4em 1.4em 1.4em !important;
    margin: 0 0 1.5em 0 !important;
    -webkit-box-shadow:  0px 0px 0px 0px #000;
            box-shadow:  0px 0px 0px 0px #000;
}

    legend.scheduler-border {
        font-size: 1.2em !important;
        font-weight: bold !important;
        text-align: left !important;
        width:auto;
        padding:0 10px;
        border-bottom:none;
    }
  }
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
    		<li class="active" ><a data-toggle="pill" href="#menudelnote"><i class="fa fa-mail-reply p-r-5" data-toggle="tooltip" title="Delivery Note" data-placement="bottom"></i><span class="hidden-xs">Delivery Note</span></a></li> 
    		<li ><a data-toggle="pill" href="#menudelnoteret"><i class="fa fa-mail-forward p-r-5" data-toggle="tooltip" title="Delivery Note Return" data-placement="bottom"></i><span class="hidden-xs">Delivery Note Return</span></a></li>
    		<li ><a data-toggle="pill" href="#menugrn"><i class="fa fa-sticky-note p-r-5" data-toggle="tooltip" title="GRN" data-placement="bottom"></i><span class="hidden-xs">GRN</span></a></li>  
    		<li ><a data-toggle="pill" href="#menugrnret"><i class="fa fa-sticky-note-o p-r-5" data-toggle="tooltip" title="GRN Return" data-placement="bottom"></i><span class="hidden-xs">GRN Return</span></a></li>
    		<li ><a data-toggle="pill" href="#menustocklist"><i class="fa fa-th-list p-r-5" data-toggle="tooltip" title="Stock List" data-placement="bottom"></i><span class="hidden-xs">Stock List</span></a></li>                                   
  		</ul>  
  	   <div class="tab-content">	   
    		<div id="menudelnote" class="tab-pane fade in active">
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-body" style="border:none;">	
  								<div id="enqform" class="form-horizontal" role="form">
  							    	<div id="row">
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotebranch">Branch</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotebranch" id="cmbdelnotebranch" class="form-control" data-type="branch">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotelocation">Location</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotelocation" id="cmbdelnotelocation" class="form-control" data-type="location">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							     		<div class="form-group">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotecustomer">Customer</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input  id ="customerchk" list="cmbcustomer" class="form-control" type="text">
		                                   		<datalist id="cmbcustomer" style="visibility:none;"></datalist>
		                                        <span class="help-block"></span>
		                                        <input type="hidden" name="hidcmbcatid" id="hidcmbcatid" data-type="customercatid">
		                                        <input type="hidden" id="hidcmbcustomer" name="hidcmbcustomer" value='<s:property value="hidcmbcustomer"/>' data-type="customerdocno"/>
		                                        <input type="hidden" id="hidcmbcur" name="hidcmbcur" value='<s:property value="hidcmbcur"/>'/>
		                                        <input type="hidden" id="hidcmbrate" name="hidcmbrate" value='<s:property value="hidcmbrate"/>'/>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="servdesc" placeholder="Details" id="servdesc" data-max="250">
		                                        <span class="help-block"></span>
		                                </div>
		                            </div>
    						   	</div>
    						</div>
    						<h4><strong>Item Details</strong></h4>
  							<div class="table-responsive">
  								<table class="table table-hover" id="tbldelnote" width="100% "  >   
							   		<tr>
							  			<td width="15% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductID</label>
							   				<input type="text" class="form-control" id="delprdid" list="delproductid"  style="text-align: left;width:96%">
							   				<datalist id="delproductid"></datalist>
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductName</label>
							   				<input type="text" class="form-control" id="delprdname" list="delprdts" style="text-align: left;width:96%"><datalist id="delprdts" style="visibility:none;"></datalist>
							  			</td>
							   			<td width="30% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">Barcode</label>
							   				<input type="text" class="form-control" name="delbrand" id="delbrand" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="5% " class="chngelmnt">
							   				<label class="col-md-2 control-label">Unit</label>
							   				<input type="text" class="form-control" name="delunit" id="delunit" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="10% "class="chngelmnt">
							   				<label class="col-md-2 control-label">Quantity</label>
							   				<input type="text" class="form-control" name="delqty" id="delqty" style="text-align: right;width:96%" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
							  			</td>
							   			<td class="dchngelmnt"><br>
							   				<button id="btnDelAdd" type="button" class="btn btn-default btn-success" >ADD</button>
							   			</td>
							   		</tr>
							    </table>
  							</div>
  							
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
								<div class="panel-body no-border">
									<table class="table table-hover" id="tbldel">
	  									<thead>       
	  										<tr>
	  											<th>Product</th>
	  											<th>Product Name</th>
	  											<th>Barcode</th>
	  											<th>Unit</th>
	  											<th>Quantity</th>
	  										</tr>
	  									</thead>
	  									<tbody>
	  										
	  									</tbody>
	  								</table>
								</div>
								<div class="panel-footer text-right">
									<div class="form-horizontal">
										<div class="form-group m-b-0">     
			                            	<div class="col-xs-12 text-right">           
	    						      			<button class="btn btn-default btn-outline-primary btncreatedel"><i class="fa fa-floppy-o m-r-5"></i>Create Delivery Note</button>
	    						     			<button id="btnsorclear" type="button" class="btn btn-default m-r-5">Clear</button>
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
	<div id="menudelnoteret" class="tab-pane fade">
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-body" style="border:none;">	
  								<div id="enqform" class="form-horizontal" role="form">
  							    	<div id="row">
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotebranch">Branch</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotebranch" id="cmbdelnotebranch" class="form-control" data-type="branch">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotelocation">Location</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotelocation" id="cmbdelnotelocation" class="form-control" data-type="location">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotelocation">Delivery Note</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotelocation" id="cmbdelnotelocation" class="form-control" data-type="delnote">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							     		<div class="form-group">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotecustomer">Customer</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input  id ="customerchk" list="cmbcustomer" class="form-control" type="text">
		                                   		<datalist id="cmbcustomer" style="visibility:none;"></datalist>
		                                        <span class="help-block"></span>
		                                        <input type="hidden" id="hidcmbcustomer" name="hidcmbcustomer" value='<s:property value="hidcmbcustomer"/>'/>
		                                        <input type="hidden" id="hidcmbcur" name="hidcmbcur" value='<s:property value="hidcmbcur"/>'/>
		                                        <input type="hidden" id="hidcmbrate" name="hidcmbrate" value='<s:property value="hidcmbrate"/>'/>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="servdesc" placeholder="Details" id="servdesc" data-max="250">
		                                        <span class="help-block"></span>
		                                </div>
		                            </div>
    						   	</div>
    						</div>
    						<h4><strong>Item Details</strong></h4>
  							<div class="table-responsive">
  								<table class="table table-hover" id="tbldelnote" width="100% "  >   
							   		<tr>
							  			<td width="15% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductID</label>
							   				<input type="text" class="form-control" id="delprdid" list="delproductid"  style="text-align: left;width:96%"><datalist id="delproductid" style="visibility:none;"></datalist>
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductName</label>
							   				<input type="text" class="form-control" id="delprdname" list="delprdts" style="text-align: left;width:96%"><datalist id="delprdts" style="visibility:none;"></datalist>
							  			</td>
							   			<td width="30% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">Barcode</label>
							   				<input type="text" class="form-control" name="delbrand" id="delbrand" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="5% " class="chngelmnt">
							   				<label class="col-md-2 control-label">Unit</label>
							   				<input type="text" class="form-control" name="delunit" id="delunit" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="10% "class="chngelmnt">
							   				<label class="col-md-2 control-label">Quantity</label>
							   				<input type="text" class="form-control" name="delqty" id="delqty" style="text-align: right;width:96%" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
							  			</td>
							   			<td class="dchngelmnt"><br>
							   				<button id="btnDelAdd" type="button" class="btn btn-default btn-success" >ADD</button>
							   			</td>
							   		</tr>
							    </table>
  							</div>
  							
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
								<div class="panel-body no-border">
									<table class="table table-hover" id="tblsor">
	  									<thead>       
	  										<tr>
	  											<th>Product</th>
	  											<th>Product Name</th>
	  											<th>Barcode</th>
	  											<th>Unit</th>
	  											<th>Quantity</th>
	  										</tr>
	  									</thead>
	  									<tbody>
	  										
	  									</tbody>
	  								</table>
								</div>
								<div class="panel-footer text-right">
									<div class="form-horizontal">
										<div class="form-group m-b-0">     
			                            	<div class="col-xs-12 text-right">           
	    						      			<button class="btn btn-default btn-outline-primary btncreatesor"><i class="fa fa-floppy-o m-r-5"></i>Create Delivery Note Return</button>
	    						     			<button id="btnsorclear" type="button" class="btn btn-default m-r-5">Clear</button>
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
	<div id="menugrn" class="tab-pane fade">
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-body" style="border:none;">	
  								<div id="enqform" class="form-horizontal" role="form">
  							    	<div id="row">
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotebranch">Branch</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotebranch" id="cmbdelnotebranch" class="form-control">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotelocation">Location</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotelocation" id="cmbdelnotelocation" class="form-control">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							     		<div class="form-group">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotecustomer">Vendor</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input  id ="customerchk" list="cmbcustomer" class="form-control" type="text">
		                                   		<datalist id="cmbcustomer" style="visibility:none;"></datalist>
		                                        <span class="help-block"></span>
		                                        <input type="hidden" id="hidcmbcustomer" name="hidcmbcustomer" value='<s:property value="hidcmbcustomer"/>'/>
		                                        <input type="hidden" id="hidcmbcur" name="hidcmbcur" value='<s:property value="hidcmbcur"/>'/>
		                                        <input type="hidden" id="hidcmbrate" name="hidcmbrate" value='<s:property value="hidcmbrate"/>'/>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="servdesc" placeholder="Details" id="servdesc" data-max="250">
		                                        <span class="help-block"></span>
		                                </div>
		                            </div>
    						   	</div>
    						</div>
    						<h4><strong>Item Details</strong></h4>
  							<div class="table-responsive">
  								<table class="table table-hover" id="tbldelnote" width="100% "  >   
							   		<tr>
							  			<td width="15% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductID</label>
							   				<input type="text" class="form-control" id="delprdid" list="delproductid"  style="text-align: left;width:96%"><datalist id="delproductid" style="visibility:none;"></datalist>
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductName</label>
							   				<input type="text" class="form-control" id="delprdname" list="delprdts" style="text-align: left;width:96%"><datalist id="delprdts" style="visibility:none;"></datalist>
							  			</td>
							   			<td width="30% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">Barcode</label>
							   				<input type="text" class="form-control" name="delbrand" id="delbrand" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="5% " class="chngelmnt">
							   				<label class="col-md-2 control-label">Unit</label>
							   				<input type="text" class="form-control" name="delunit" id="delunit" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="10% "class="chngelmnt">
							   				<label class="col-md-2 control-label">Quantity</label>
							   				<input type="text" class="form-control" name="delqty" id="delqty" style="text-align: right;width:96%" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
							  			</td>
							   			<td class="dchngelmnt"><br>
							   				<button id="btnDelAdd" type="button" class="btn btn-default btn-success" >ADD</button>
							   			</td>
							   		</tr>
							    </table>
  							</div>
  							
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
								<div class="panel-body no-border">
									<table class="table table-hover" id="tblsor">
	  									<thead>       
	  										<tr>
	  											<th>Product</th>
	  											<th>Product Name</th>
	  											<th>Barcode</th>
	  											<th>Unit</th>
	  											<th>Quantity</th>
	  										</tr>
	  									</thead>
	  									<tbody>
	  										
	  									</tbody>
	  								</table>
								</div>
								<div class="panel-footer text-right">
									<div class="form-horizontal">
										<div class="form-group m-b-0">     
			                            	<div class="col-xs-12 text-right">           
	    						      			<button class="btn btn-default btn-outline-primary btncreatesor"><i class="fa fa-floppy-o m-r-5"></i>Create GRN</button>
	    						     			<button id="btnsorclear" type="button" class="btn btn-default m-r-5">Clear</button>
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
  	
  	<div id="menugrnret" class="tab-pane fade">
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-body" style="border:none;">	
  								<div id="enqform" class="form-horizontal" role="form">
  							    	<div id="row">
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotebranch">Branch</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotebranch" id="cmbdelnotebranch" class="form-control">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotelocation">Location</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotelocation" id="cmbdelnotelocation" class="form-control">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotelocation">GRN</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnotelocation" id="cmbdelnotelocation" class="form-control">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							     		<div class="form-group">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotecustomer">Vendor</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input  id ="customerchk" list="cmbcustomer" class="form-control" type="text">
		                                   		<datalist id="cmbcustomer" style="visibility:none;"></datalist>
		                                        <span class="help-block"></span>
		                                        <input type="hidden" id="hidcmbcustomer" name="hidcmbcustomer" value='<s:property value="hidcmbcustomer"/>'/>
		                                        <input type="hidden" id="hidcmbcur" name="hidcmbcur" value='<s:property value="hidcmbcur"/>'/>
		                                        <input type="hidden" id="hidcmbrate" name="hidcmbrate" value='<s:property value="hidcmbrate"/>'/>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="servdesc" placeholder="Details" id="servdesc" data-max="250">
		                                        <span class="help-block"></span>
		                                </div>
		                            </div>
    						   	</div>
    						</div>
    						<h4><strong>Item Details</strong></h4>
  							<div class="table-responsive">
  								<table class="table table-hover" id="tbldelnote" width="100% "  >   
							   		<tr>
							  			<td width="15% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductID</label>
							   				<input type="text" class="form-control" id="delprdid" list="delproductid"  style="text-align: left;width:96%"><datalist id="delproductid" style="visibility:none;"></datalist>
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">ProductName</label>
							   				<input type="text" class="form-control" id="delprdname" list="delprdts" style="text-align: left;width:96%"><datalist id="delprdts" style="visibility:none;"></datalist>
							  			</td>
							   			<td width="30% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">Barcode</label>
							   				<input type="text" class="form-control" name="delbrand" id="delbrand" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="5% " class="chngelmnt">
							   				<label class="col-md-2 control-label">Unit</label>
							   				<input type="text" class="form-control" name="delunit" id="delunit" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="10% "class="chngelmnt">
							   				<label class="col-md-2 control-label">Quantity</label>
							   				<input type="text" class="form-control" name="delqty" id="delqty" style="text-align: right;width:96%" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
							  			</td>
							   			<td class="dchngelmnt"><br>
							   				<button id="btnDelAdd" type="button" class="btn btn-default btn-success" >ADD</button>
							   			</td>
							   		</tr>
							    </table>
  							</div>
  							
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
								<div class="panel-body no-border">
									<table class="table table-hover" id="tblsor">
	  									<thead>       
	  										<tr>
	  											<th>Product</th>
	  											<th>Product Name</th>
	  											<th>Barcode</th>
	  											<th>Unit</th>
	  											<th>Quantity</th>
	  										</tr>
	  									</thead>
	  									<tbody>
	  										
	  									</tbody>
	  								</table>
								</div>
								<div class="panel-footer text-right">
									<div class="form-horizontal">
										<div class="form-group m-b-0">     
			                            	<div class="col-xs-12 text-right">           
	    						      			<button class="btn btn-default btn-outline-primary btncreatesor"><i class="fa fa-floppy-o m-r-5"></i>Create GRN Return</button>
	    						     			<button id="btnsorclear" type="button" class="btn btn-default m-r-5">Clear</button>
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
  			<div id="menustocklist" class="tab-pane fade">     
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">	
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:470px;overflow:auto;">
  								<table class="table table-hover" id="tblstocklist">       
  									<thead>       
  										<tr>
  											<th>Sr.No</th>
  											<th>Product ID</th>
  											<th>Product Name</th>     
  											<th>Brand Name</th>
  											<th>Batch No</th>
  											<!-- <th>Client Detail</th> -->
  											<th>Expiry Date</th>
  											<th>Department</th>
  											
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
  		
  	<input type="hidden" name="psrno" id="psrno">
  	<input type="hidden" name="specid" id="specid">
  	<input type="hidden" name="taxdoc" id="taxdoc">
  	<input type="hidden" name="unitdoc" id="unitdoc">
  	<input type="hidden" name="hidunitprice" id="hidunitprice">
  	
  	<input type="hidden" name="hidcmbdelcatid" id="hidcmbdelcatid">	
  	<input type="hidden" name="hidcmbinvcatid" id="hidcmbinvcatid">		
    <input type="hidden" name="address" id="address">
    <input type="hidden" name="exval" id="exval">
	<input type="hidden" name="tsrowno" id="tsrowno">
	<input type="hidden" name="latittude" id="latittude">
	<input type="hidden" name="longitude" id="longitude">                     
	<input type="hidden" name="clientacno" id="clientacno">
	<input type="hidden" name="hidvatype" id="hidvatype">
	<input type="hidden" name="hidinvacno" id="hidinvacno">
	<input type="hidden" id="hiduserid" name="hiduserid"  >
	<input type="hidden" id="hidbrhid" name="hidbrhid"  >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script>     
    	window.addEventListener('resize', function(event) {
    		checkWindowWidth();
		}, true);
		function checkWindowWidth(){
			var windowwidth=$(window).width();
    		if(windowwidth<768){
    			$('.custom-tabs').removeClass('nav-justified');
    		}
    		else{
    			if($('.custom-tabs').hasClass('nav-justified')){
    				
    			}
    			else{
    				$('.custom-tabs').addClass('nav-justified');
    			}
    		}
		}
    	$(document).ready(function(){                    
 			checkWindowWidth();
 			$('[data-toggle="tooltip"]').tooltip(); 
 			$('#btnAdd').click(function(){
 				setGrid(1);
 			});
 			$('#btnDelAdd').click(function(){
 				setGrid(2);
 			});
 			$('#btnInvAdd').click(function(){
 				setGrid(3);
 			});
    		$('#btnsorclear').click(function(){
 				clearForm(1);
 			});
    		$('#btndelclear').click(function(){
 				clearForm(2);
 			});
    		$('#btninvclear').click(function(){
 				clearForm(3);
 			});
    		$('.btncreatesor').click(function(){
    			var activerow=document.getElementById("tblsor").rows.length;
				if(activerow==1){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				saveGrid(); 
    		});
    		$('.btncreatedel').click(function(){
    			var activerow=document.getElementById("tbldel").rows.length;
    			//alert("activerow=="+activerow);
				if(activerow==1){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				saveDelGrid(); 
    		});
    		$('.btncreateinv').click(function(){
    			var activerow=document.getElementById("tblinv").rows.length;
    			//alert("activerow=="+activerow);
				if(activerow==1){
					Swal.fire({
						type: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				saveInvGrid(); 
    		});
    	
    		
    	});     
    		
    	     
    	$(window).ready(function(){    
    		getInitData();
    		getCustomer();
    		//getvaType();    		
    		refChange();
    		getDetails();
    		//getProduct();
    		//getProductID();
    		//getCostCode();  
    		//curLocation();    
		});
    	$("#cmbvatype").change(function(){
    		vatChange(1);
    	});
    	$("#cmbvatypeinv").change(function(){
    		vatChange(2);
    	});
    	$("#customerchk").change(function(){
    		var dl=$("#cmbcustomer")[0];
    		 var el=$("#customerchk")[0];
    		//alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		var opSelected=el.value.trim();
    		var id = $("#cmbcustomer option[value='" + $('#customerchk').val() + "']").attr('data-id');
    		var cur = $("#cmbcustomer option[value='" + $('#customerchk').val() + "']").attr('data-cur');
    		var rate = $("#cmbcustomer option[value='" + $('#customerchk').val() + "']").attr('data-rate');
    		var catid = $("#cmbcustomer option[value='" + $('#customerchk').val() + "']").attr('data-catid');
    		//alert("cur==="+cur+"===rate==="+rate);
    		document.getElementById("hidcmbcustomer").value=id;
    		document.getElementById("hidcmbcur").value=cur;
    		document.getElementById("hidcmbrate").value=rate;
    		document.getElementById("hidcmbcatid").value=catid;
    		document.getElementById("hidcmbcustomerdel").value=id;
    		document.getElementById("hidcmbcurdel").value=cur;
    		document.getElementById("hidcmbratedel").value=rate;
    		document.getElementById("hidcmbdelcatid").value=catid;
    		getProduct(2);
    		getProductID(2);
    		 }
			 
			});
    	
    	$("#delcustomerchk").change(function(){
    		var dl=$("#delcmbcustomer")[0];
    		 var el=$("#delcustomerchk")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		var opSelected=el.value.trim();
    		var id = $("#delcmbcustomer option[value='" + $('#delcustomerchk').val() + "']").attr('data-id');
    		var cur = $("#delcmbcustomer option[value='" + $('#delcustomerchk').val() + "']").attr('data-cur');
    		var rate = $("#delcmbcustomer option[value='" + $('#delcustomerchk').val() + "']").attr('data-rate');
    		var catid = $("#delcmbcustomer option[value='" + $('#delcustomerchk').val() + "']").attr('data-catid');
    		//alert("cur==="+cur+"===rate==="+rate);
    		
    		document.getElementById("hidcmbcustomerdel").value=id;
    		document.getElementById("hidcmbcurdel").value=cur;
    		document.getElementById("hidcmbratedel").value=rate;
    		document.getElementById("hidcmbdelcatid").value=catid;
    		getProduct(2);
    		getProductID(2);
    		 }
			 
			});
    	
    	$("#invcustomerchk").change(function(){
    		var dl=$("#invcmbcustomer")[0];
    		 var el=$("#invcustomerchk")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		var opSelected=el.value.trim();
    		var id = $("#invcmbcustomer option[value='" + $('#invcustomerchk').val() + "']").attr('data-id');
    		var cur = $("#invcmbcustomer option[value='" + $('#invcustomerchk').val() + "']").attr('data-cur');
    		var rate = $("#invcmbcustomer option[value='" + $('#invcustomerchk').val() + "']").attr('data-rate');
    		var catid = $("#invcmbcustomer option[value='" + $('#invcustomerchk').val() + "']").attr('data-catid');
    		var acno = $("#invcmbcustomer option[value='" + $('#invcustomerchk').val() + "']").attr('data-acno');
    		//alert("cur==="+cur+"===rate==="+rate);
    		
    		document.getElementById("hidcmbcustomerinv").value=id;
    		document.getElementById("hidcmbcurinv").value=cur;
    		document.getElementById("hidcmbrateinv").value=rate;
    		document.getElementById("hidcmbinvcatid").value=catid;
    		document.getElementById("hidinvacno").value=catid;
    		getProduct(3);
    		getProductID(3);
    		 }
			 
			});
    	
    	$("#rrefno").change(function(){
    		var sordoc=$('#rrefno').val();
    		var brhid=$('#hidbrhid').val();
    		//alert("sordoc=="+sordoc);
    		if(parseInt(sordoc)>0){
    			var chk="SOR";
    			var x = new XMLHttpRequest();
    	  		x.onreadystatechange = function() {
    	  			if (x.readyState == 4 && x.status == 200) {
    	  				var items = x.responseText.trim();
    	  				
    	  				var sordatas=JSON.parse(items.trim());          
    	  				var contracttablehtml='';    
    	  				$.each(sordatas.sordata, function( index, value ) {   
    	  					document.getElementById("hidvatype").value=value.vatype;
    	  					contracttablehtml+='<tr>';
    	  					
    	  					contracttablehtml+='<td>'+value.productid+'</td>';
    	  					contracttablehtml+='<td>'+value.productname+'</td>';
    	  					contracttablehtml+='<td>'+value.brandname+'</td>';
    	  					contracttablehtml+='<td>'+value.unit+'</td>';
    	  					contracttablehtml+='<td>'+value.qty+'</td>';  
    	  					contracttablehtml+='<td style="visibility:hidden;">'+value.uprice+'</td>';
    	  					contracttablehtml+='<td style="visibility:hidden;">'+value.disper+'</td>';
    	  					contracttablehtml+='<td style="visibility:hidden;">'+value.dis+'</td>';
    	  					contracttablehtml+='<td style="visibility:hidden;">'+value.psrno+'</td>';
    						contracttablehtml+='<td style="visibility:hidden;">'+value.unitdoc+'</td>';
    						contracttablehtml+='<td style="visibility:hidden;">'+value.specid+'</td>';
    						contracttablehtml+='<td style="visibility:hidden;">'+value.amount+'</td>';
    	  					contracttablehtml+='<td style="visibility:hidden;">'+value.netamount+'</td>';
    	  					contracttablehtml+='<td style="visibility:hidden;">'+value.grantamt+'</td>';
    	  					contracttablehtml+='</tr>';     
    	  				});
    	  				$('#tbldel tbody').html($.parseHTML(contracttablehtml));  
    	  				contracttablehtml="";
    	  				
    	  				
    	  				   
    	  				
    	  			}
    	  		}
    	  		x.open("GET", "getSOR.jsp?chk="+chk+"&sordoc="+sordoc+"&brhid="+brhid, true);
    	  		x.send();
    		}
    		
    	});
    	
    	$("#rrefnoinv").change(function(){
    		var sordoc=$('#rrefnoinv').val();
    		var brhid=$('#hidbrhid').val();
    		//alert("sordoc=="+sordoc);
    		if(parseInt(sordoc)>0){
    			var chk=$('#cmbreftypeinv').val();
    			var x = new XMLHttpRequest();
    	  		x.onreadystatechange = function() {
    	  			if (x.readyState == 4 && x.status == 200) {
    	  				var items = x.responseText.trim();
    	  				
    	  				var sordatas=JSON.parse(items.trim());          
    	  				var contracttablehtml='';    
    	  				if(chk=="SOR"){
    	  					$.each(sordatas.sordata, function( index, value ) {   
        	  					document.getElementById("cmbvatypeinv").value=value.vatype;
        	  					contracttablehtml+='<tr>';
        	  					
        	  					contracttablehtml+='<td>'+value.productid+'</td>';
        	  					contracttablehtml+='<td>'+value.productname+'</td>';
        	  					contracttablehtml+='<td>'+value.brandname+'</td>';
        	  					contracttablehtml+='<td>'+value.unit+'</td>';
        	  					contracttablehtml+='<td>'+value.qty+'</td>'; 
        	  					contracttablehtml+='<td>'+value.uprice+'</td>';
        						contracttablehtml+='<td>'+value.total+'</td>';  
        						contracttablehtml+='<td>'+value.disper+'</td>'; 
        						contracttablehtml+='<td>'+value.dis+'</td>';
        						contracttablehtml+='<td>'+value.netotal+'</td>';
        						contracttablehtml+='<td>'+value.taxper+'</td>';  
        						contracttablehtml+='<td>'+value.taxamount+'</td>';
        						contracttablehtml+='<td>'+value.nettaxamount+'</td>';  
        	  					contracttablehtml+='<td style="visibility:hidden;">'+value.psrno+'</td>';
        						contracttablehtml+='<td style="visibility:hidden;">'+value.unitdoc+'</td>';
        						contracttablehtml+='<td style="visibility:hidden;">'+value.specid+'</td>';
        						
        	  					contracttablehtml+='</tr>';     
        	  				});
    	  				}
    	  				if(chk=="DEL"){
    	  					$.each(sordatas.deldata, function( index, value ) {   
        	  					document.getElementById("cmbvatypeinv").value=value.vatype;
        	  					contracttablehtml+='<tr>';
        	  					
        	  					contracttablehtml+='<td>'+value.productid+'</td>';
        	  					contracttablehtml+='<td>'+value.productname+'</td>';
        	  					contracttablehtml+='<td>'+value.brandname+'</td>';
        	  					contracttablehtml+='<td>'+value.unit+'</td>';
        	  					contracttablehtml+='<td>'+value.qty+'</td>'; 
        	  					contracttablehtml+='<td>'+value.uprice+'</td>';
        						contracttablehtml+='<td>'+value.total+'</td>';  
        						contracttablehtml+='<td>'+value.disper+'</td>'; 
        						contracttablehtml+='<td>'+value.dis+'</td>';
        						contracttablehtml+='<td>'+value.netotal+'</td>';
        						contracttablehtml+='<td>'+value.taxper+'</td>';  
        						contracttablehtml+='<td>'+value.taxamount+'</td>';
        						contracttablehtml+='<td>'+value.nettaxamount+'</td>';  
        	  					contracttablehtml+='<td style="visibility:hidden;">'+value.psrno+'</td>';
        						contracttablehtml+='<td style="visibility:hidden;">'+value.unitdoc+'</td>';
        						contracttablehtml+='<td style="visibility:hidden;">'+value.specid+'</td>';
        						
        	  					contracttablehtml+='</tr>';     
        	  				});
    	  				}
    	  				$('#tblinv tbody').html($.parseHTML(contracttablehtml));  
    	  				contracttablehtml="";
    	  				
    	  				
    	  				   
    	  				
    	  			}
    	  		}
    	  		x.open("GET", "getSOR.jsp?chk="+chk+"&sordoc="+sordoc+"&brhid="+brhid, true);
    	  		x.send();
    		}
    		
    	});
    	
    	
    	
    	
    	function clearForm(chk){
    		if(parseInt(chk)==1){
    			$("#tblsor tr").each(function(){
        	        var currentRow=$(this);
        	    
        	        var part=currentRow.find("td:eq(0)").text();
        	        if(!part==""){
        	        	currentRow.remove();
        	        }
        		});
                document.getElementById("hidcmbcustomer").value="";
                document.getElementById("servdesc").value="";
                document.getElementById("hidcmbcur").value="";
                document.getElementById("hidcmbrate").value="";
                document.getElementById("customerchk").value="";
                document.getElementById("qty").value=0;
        		document.getElementById("unitprice").value=0;
        		document.getElementById("disper").value=0;
        		document.getElementById("discount").value=0;
        		document.getElementById("total").value=0;
        		document.getElementById("netamount").value=0;
        		document.getElementById("taxamount").value=0;        		
        		document.getElementById("nettotal").value=0;
        		
        		document.getElementById("prdname").value="";
        		document.getElementById("prdid").value="";
        		document.getElementById("brand").value="";
        		document.getElementById("unit").value="";
        		document.getElementById("descptn").value="";
        		getvaType();
    		}
    		if(parseInt(chk)==2){
    			$("#tbldel tr").each(function(){
        	        var currentRow=$(this);
        	    
        	        var part=currentRow.find("td:eq(0)").text();
        	        if(!part==""){
        	        	currentRow.remove();
        	        }
        		});
                document.getElementById("hidcmbcustomerdel").value="";
                document.getElementById("deldesc").value="";
                document.getElementById("hidcmbcurdel").value="";
                document.getElementById("hidcmbratedel").value="";
                document.getElementById("delcustomerchk").value="";
                
                document.getElementById("delqty").value=0;
        		document.getElementById("delprdname").value="";
        		document.getElementById("delprdid").value="";
        		document.getElementById("delbrand").value="";
        		document.getElementById("delunit").value="";
                
                var select = document.getElementById("rrefno");
                var length = select.options.length;
                for (i = length-1; i >= 0; i--) {
                  select.options[i] = null;
                }
                $('#rrefno').attr('disabled', true);
                document.getElementById("cmbreftype").value="DIR";
    		}
           
    		if(parseInt(chk)==3){
    			$("#tblinv tr").each(function(){
        	        var currentRow=$(this);
        	    
        	        var part=currentRow.find("td:eq(0)").text();
        	        if(!part==""){
        	        	currentRow.remove();
        	        }
        		});
                document.getElementById("hidcmbcustomerinv").value="";
                document.getElementById("invdesc").value="";
                document.getElementById("hidcmbcurinv").value="";
                document.getElementById("hidcmbrateinv").value="";
                document.getElementById("invcustomerchk").value="";
                document.getElementById("hidcmbcustomerinv").value="";
                document.getElementById("invdesc").value="";
                document.getElementById("hidcmbcurinv").value="";
                document.getElementById("hidcmbrateinv").value="";
                document.getElementById("invcustomerchk").value="";
                document.getElementById("invqty").value=0;
        		document.getElementById("invunitprice").value=0;
        		document.getElementById("invdisper").value=0;
        		document.getElementById("invdiscount").value=0;
        		document.getElementById("invtotal").value=0;
        		document.getElementById("invnetamount").value=0;
        		document.getElementById("invtaxamount").value=0;        		
        		document.getElementById("invnettotal").value=0;
        		
        		document.getElementById("invprdname").value="";
        		document.getElementById("invprdid").value="";
        		document.getElementById("invbrand").value="";
        		document.getElementById("invunit").value="";
        		getvaType();
                var select = document.getElementById("rrefnoinv");
                var length = select.options.length;
                for (i = length-1; i >= 0; i--) {
                  select.options[i] = null;
                }
                $('#invrrefno').attr('disabled', true);
                document.getElementById("cmbreftypeinv").value="DIR";
    		}
    		
    	}
    	
    	function prosrch(){
    		var prodsearchtype=$("#prodsearchtype").val();
        	var refmasterdocno=$("#refmasterdocno").val();
        	var reftype=$("#cmbreftype").val();
        	var clientid=document.getElementById("clientid").value;
    		var cmbprice=document.getElementById("cmbprice").value;
      		var cmbreftype=document.getElementById("cmbreftype").value;
       		 var clientcaid=document.getElementById("clientcaid").value; 
       		 var dates=document.getElementById("date").value;
       		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
       		//var prddata=document.getElementById("prddata2").value;
       		//alert(prddata);
       			 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype+"&id=1");
       			// $('#sidesearchwndow').jqxWindow('setContent', 'productSearch.jsp');
       			 //window.open('productSearch.jsp');
       			/*  var url='productSearch.jsp?id=1';
       			 $.get(url).done(function (data) {
       	 			$('#sidesearchwndow').jqxWindow('open');
    				$('#sidesearchwndow').jqxWindow('setContent', data);
       			 }); */
    		
    	}
    	function vatChange(chk){
    		//alert("in vat change");
    		var total=0,rows=0;
    		if(parseInt(chk)==1){
    			 total=document.getElementById("total").value;
        		 rows=document.getElementById("tblsor").rows.length;
    		}
            if(parseInt(chk)==2){
            	 total=document.getElementById("invtotal").value;
        		 rows=document.getElementById("tblinv").rows.length;
    		}
    		if(parseFloat(total)>0 || parseFloat(rows)>1){
    			//alert("total=="+total+"==rows=="+rows);
    		Swal.fire({   
  	 		  title: 'This Action Will Affect Already Selected Items.?',
  	 		  type: 'warning',
  	 		  showCancelButton: true,
  	 		  confirmButtonColor: '#3085d6',
  	 		  cancelButtonColor: '#d33',
  	 		  confirmButtonText: 'Confirm'   
  	 		   }).then((result) => {
  	 		  if (result.value) {
  	 			if(parseInt(chk)==1){
  	    			document.getElementById("qty").value=0;
  	        		document.getElementById("unitprice").value=0;
  	        		document.getElementById("disper").value=0;
  	        		document.getElementById("discount").value=0;
  	        		document.getElementById("total").value=0;
  	        		document.getElementById("netamount").value=0;
  	        		document.getElementById("taxamount").value=0;        		
  	        		document.getElementById("nettotal").value=0;
  	        		$("#tblsor tr").each(function(){
  	        	        var currentRow=$(this);
  	        	    
  	        	        var part=currentRow.find("td:eq(0)").text();
  	        	        if(!part==""){
  	        	        	currentRow.remove();
  	        	        }
  	        		});
  	        		
  	    		}
  	    		
  	    		if(parseInt(chk)==2){
  	    			document.getElementById("invqty").value=0;
  	        		document.getElementById("invunitprice").value=0;
  	        		document.getElementById("invdisper").value=0;
  	        		document.getElementById("invdiscount").value=0;
  	        		document.getElementById("invtotal").value=0;
  	        		document.getElementById("invnetamount").value=0;
  	        		document.getElementById("invtaxamount").value=0;        		
  	        		document.getElementById("invnettotal").value=0;
  	        		$("#tblinv tr").each(function(){
  	        	        var currentRow=$(this);
  	        	    
  	        	        var part=currentRow.find("td:eq(0)").text();
  	        	        if(!part==""){
  	        	        	currentRow.remove();
  	        	        }
  	        		});
  	        		
  	    		}                  
  	 		  }
  		   });     
    		}	
    		
    	}
    	
    	function refChange(){
  		  var reftype=$('#cmbreftype').val();
  		  var invreftype=$('#cmbreftypeinv').val();
  		  if(reftype=='DIR'){
  			var select = document.getElementById("rrefno");
            var length = select.options.length;
            for (i = length-1; i >= 0; i--) {
              select.options[i] = null;
            }
           
           
  			  $('#rrefno').attr('disabled', true);
  		  }
  		 if(reftype=='SOR'){
  			var select = document.getElementById("rrefno");
            var length = select.options.length;
            for (i = length-1; i >= 0; i--) {
              select.options[i] = null;
            }
            getSOR(1);
  			  $('#rrefno').attr('disabled', false);
  			
  		  }
  		 if(invreftype=='DIR'){
  			var select = document.getElementById("rrefnoinv");
            var length = select.options.length;
            for (i = length-1; i >= 0; i--) {
              select.options[i] = null;
            }
           
 			  $('#rrefnoinv').attr('disabled', true);
 		  }
 		 if(invreftype=='SOR'){
 			var select = document.getElementById("rrefnoinv");
            var length = select.options.length;
            for (i = length-1; i >= 0; i--) {
              select.options[i] = null;
            }
            getSOR(2);
 			  $('#rrefnoinv').attr('disabled', false);
 			 
 		  }
 		 if(invreftype=='DEL'){
 			// alert("in del refchange");
 			var select = document.getElementById("rrefnoinv");
            var length = select.options.length;
            for (i = length-1; i >= 0; i--) {
              select.options[i] = null;
            }
            getSOR(3);
			  $('#rrefnoinv').attr('disabled', false);
			
		  }
  	  }
    	
    	function getSOR(chk){
    		//alert("in deldet=="+chk);
    		var brhid=$('#hidbrhid').val();
    		var clientid="",catid="",tstchk="";
    		if(parseInt(chk)==1){
    			 clientid=$('#hidcmbcustomerdel').val();
        		 catid=$('#hidcmbdelcatid').val();
        		if(clientid==""){
        			 document.getElementById("cmbreftype").value="DIR";
    				Swal.fire({
    					type: 'warning',
    				  	title: 'Warning',
    				  	text: 'Please select customer first!!!'                         
    				});
    				return false;
    				
    			}
        		tstchk="SORDET";
    		}
    		if(parseInt(chk)==2){
    			//alert("in sordet==="+chk);
	   			 clientid=$('#hidcmbcustomerinv').val();
	       		 catid=$('#hidcmbinvcatid').val();
	       		if(clientid==""){
	       			 document.getElementById("cmbreftypeinv").value="DIR";
	   				Swal.fire({
	   					type: 'warning',
	   				  	title: 'Warning',
	   				  	text: 'Please select customer first!!!'                         
	   				});
	   				return false;
	   				
	   			}
	       		tstchk="SORDET";
   		    }
    		if(parseInt(chk)==3){
    			 clientid=$('#hidcmbcustomerinv').val();
	       		 catid=$('#hidcmbinvcatid').val();
	       		if(clientid==""){
	       			 document.getElementById("cmbreftypeinv").value="DIR";
	   				Swal.fire({
	   					type: 'warning',
	   				  	title: 'Warning',
	   				  	text: 'Please select customer first!!!'                         
	   				});
	   				return false;
	   				
	   			}
    			tstchk="DELDET";
    		}
    		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var sordetails = items[0].split(",");
					var sordoc = items[1].split(","); 
					
					var optionsyear;
					for (var i = 0; i < sordoc.length; i++) {
						optionsyear += '<option value=' + sordoc[i] + ' >' + sordetails[i] + '</option>';
					}
					if(parseInt(chk)==1){
						$("select#rrefno").html(optionsyear);
						
					}
					if(parseInt(chk)==2){
						$("select#rrefnoinv").html(optionsyear);
						
					}
					if(parseInt(chk)==3){
						
						$("select#rrefnoinv").html(optionsyear);
						
					}	 
					
					
				} else {
				}
			}
			x.open("GET", "getSOR.jsp?clientid="+clientid+"&clientcatid="+catid+"&chk="+tstchk+"&brhid="+brhid, true);
			x.send();
    	}
    	function setGrid(chk){
    		//alert("chk=="+chk);
    		
    		
    		var contracttablehtml='';    
				if(parseInt(chk)==1){
					var part=document.getElementById("prdid").value;
		    		var name=document.getElementById("prdname").value;
		    		var brand=document.getElementById("brand").value;
		    		var unit=document.getElementById("unit").value;
		    		var qty=document.getElementById("qty").value;
		    		var price=document.getElementById("unitprice").value;
		    		var total=document.getElementById("total").value;
		    		var dis=document.getElementById("disper").value;
		    		var discnt=document.getElementById("discount").value;
		    		var netamt=document.getElementById("netamount").value;
		    		var tax=document.getElementById("taxper").value;
		    		var taxamnt=document.getElementById("taxamount").value;
		    		var net=document.getElementById("nettotal").value;
		    		var desc=document.getElementById("descptn").value;
		    		var psrno=document.getElementById("psrno").value;
		    		var unitdoc=document.getElementById("unitdoc").value;
		    		var specid=document.getElementById("specid").value;
					contracttablehtml+='<tr>';					   
					contracttablehtml+='<td>'+part+'</td>';
					contracttablehtml+='<td>'+name+'</td>';
					contracttablehtml+='<td>'+brand+'</td>';
					contracttablehtml+='<td>'+unit+'</td>';
					contracttablehtml+='<td>'+qty+'</td>';  
					contracttablehtml+='<td>'+price+'</td>';
					contracttablehtml+='<td>'+total+'</td>';  
					contracttablehtml+='<td>'+dis+'</td>'; 
					contracttablehtml+='<td>'+discnt+'</td>';
					contracttablehtml+='<td>'+netamt+'</td>';
					contracttablehtml+='<td>'+tax+'</td>';  
					contracttablehtml+='<td>'+taxamnt+'</td>';
					contracttablehtml+='<td>'+net+'</td>';  
					contracttablehtml+='<td>'+desc+'</td>'; 
					contracttablehtml+='<td style="visibility:hidden;">'+psrno+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+unitdoc+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+specid+'</td>';
					contracttablehtml+='</tr>';     
			
				
				$($.parseHTML(contracttablehtml)).appendTo('#tblsor tbody');
				}   
				if(parseInt(chk)==2){
					var part=document.getElementById("delprdid").value;
		    		var name=document.getElementById("delprdname").value;
		    		var brand=document.getElementById("delbrand").value;
		    		var unit=document.getElementById("delunit").value;
		    		var qty=document.getElementById("delqty").value;
		    		var psrno=document.getElementById("psrno").value;
		    		var unitdoc=document.getElementById("unitdoc").value;
		    		var specid=document.getElementById("specid").value;
		    		var amount=0;
		    		var netamount=0;
		    		var grantamt=0,uprice=0,disper=0,dis=0;
					contracttablehtml+='<tr>';					   
					contracttablehtml+='<td>'+part+'</td>';
					contracttablehtml+='<td>'+name+'</td>';
					contracttablehtml+='<td>'+brand+'</td>';
					contracttablehtml+='<td>'+unit+'</td>';
					contracttablehtml+='<td>'+qty+'</td>';  
					contracttablehtml+='<td style="visibility:hidden;">'+uprice+'</td>';
  					contracttablehtml+='<td style="visibility:hidden;">'+disper+'</td>';
  					contracttablehtml+='<td style="visibility:hidden;">'+dis+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+psrno+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+unitdoc+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+specid+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+amount+'</td>';
  					contracttablehtml+='<td style="visibility:hidden;">'+netamount+'</td>';
  					contracttablehtml+='<td style="visibility:hidden;">'+grantamt+'</td>';
					contracttablehtml+='</tr>';     
			
				
				$($.parseHTML(contracttablehtml)).appendTo('#tbldel tbody');
					
				}
				
				if(parseInt(chk)==3){
					var part=document.getElementById("invprdid").value;
		    		var name=document.getElementById("invprdname").value;
		    		var brand=document.getElementById("invbrand").value;
		    		var unit=document.getElementById("invunit").value;
		    		var qty=document.getElementById("invqty").value;
		    		var price=document.getElementById("invunitprice").value;
		    		var total=document.getElementById("invtotal").value;
		    		var dis=document.getElementById("invdisper").value;
		    		var discnt=document.getElementById("invdiscount").value;
		    		var netamt=document.getElementById("invnetamount").value;
		    		var tax=document.getElementById("invtaxper").value;
		    		var taxamnt=document.getElementById("invtaxamount").value;
		    		var net=document.getElementById("invnettotal").value;
		    		var psrno=document.getElementById("psrno").value;
		    		var unitdoc=document.getElementById("unitdoc").value;
		    		var specid=document.getElementById("specid").value;
					contracttablehtml+='<tr>';					   
					contracttablehtml+='<td>'+part+'</td>';
					contracttablehtml+='<td>'+name+'</td>';
					contracttablehtml+='<td>'+brand+'</td>';
					contracttablehtml+='<td>'+unit+'</td>';
					contracttablehtml+='<td>'+qty+'</td>';  
					contracttablehtml+='<td>'+price+'</td>';
					contracttablehtml+='<td>'+total+'</td>';  
					contracttablehtml+='<td>'+dis+'</td>'; 
					contracttablehtml+='<td>'+discnt+'</td>';
					contracttablehtml+='<td>'+netamt+'</td>';
					contracttablehtml+='<td>'+tax+'</td>';  
					contracttablehtml+='<td>'+taxamnt+'</td>';
					contracttablehtml+='<td>'+net+'</td>';  
					contracttablehtml+='<td style="visibility:hidden;">'+psrno+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+unitdoc+'</td>';
					contracttablehtml+='<td style="visibility:hidden;">'+specid+'</td>';
					contracttablehtml+='</tr>';     
			
				
				$($.parseHTML(contracttablehtml)).appendTo('#tblinv tbody');
				}   
				
				
				document.getElementById("prdid").value="";
	    		document.getElementById("prdname").value="";
	    		document.getElementById("brand").value="";
	    		document.getElementById("unit").value="";
	    		document.getElementById("qty").value="";
	    		document.getElementById("delprdid").value="";
	    		document.getElementById("delprdname").value="";
	    		document.getElementById("delbrand").value="";
	    		document.getElementById("delunit").value="";
	    		document.getElementById("delqty").value="";
	    		document.getElementById("unitprice").value="";
	    		document.getElementById("total").value="";
	    	    document.getElementById("disper").value="";
	    		document.getElementById("discount").value="";
	    		document.getElementById("netamount").value="";
	    		document.getElementById("taxper").value="";
	    		document.getElementById("taxamount").value="";
	    		document.getElementById("nettotal").value="";
	    		
	    		document.getElementById("invprdid").value="";
	    		document.getElementById("invprdname").value="";
	    		document.getElementById("invbrand").value="";
	    		document.getElementById("invunit").value="";
	    		document.getElementById("invqty").value="";
	    		document.getElementById("invunitprice").value="";
	    		document.getElementById("invtotal").value="";
	    	    document.getElementById("invdisper").value="";
	    		document.getElementById("invdiscount").value="";
	    		document.getElementById("invnetamount").value="";
	    		document.getElementById("invtaxper").value="";
	    		document.getElementById("invtaxamount").value="";
	    		document.getElementById("invnettotal").value="";
	    		
	    		document.getElementById("descptn").value="";
	    		document.getElementById("psrno").value="";
	    		document.getElementById("unitdoc").value="";
	    		document.getElementById("specid").value="";
	    		
	    		
			
    	}
    	
    	function saveGrid(){
    		 var table = document.getElementById("tblsor"); 
    		var totalRows = document.getElementById("tblsor").rows.length;
    		var totalCol = 14; 
    	
    		var prodArray= new Array();
    		var totalsum=0,ntamtsum=0,taxamtsum=0,netotalsum=0;
    		$("#tblsor tr").each(function(){
    	        var currentRow=$(this);
    	    
    	        var part=currentRow.find("td:eq(0)").text();
    	        if(!part==""){
    	        var name=currentRow.find("td:eq(1)").text();
    	        var brand=currentRow.find("td:eq(2)").text();
    	        var unit=currentRow.find("td:eq(3)").text();
    	        var qty=currentRow.find("td:eq(4)").text();
    	        var price=currentRow.find("td:eq(5)").text();
    	        var total=currentRow.find("td:eq(6)").text();
    	        var dis=currentRow.find("td:eq(7)").text();
    	        var discnt=currentRow.find("td:eq(8)").text();
    	        var netamnt=currentRow.find("td:eq(9)").text();
    	        var tax=currentRow.find("td:eq(10)").text();
    	        var taxamt=currentRow.find("td:eq(11)").text();
    	        var nettotal=currentRow.find("td:eq(12)").text();
    	        var desc=currentRow.find("td:eq(13)").text();
    	        var psrno=currentRow.find("td:eq(14)").text();
    	       
    	        var unitdoc=currentRow.find("td:eq(15)").text();
      		    var specid=currentRow.find("td:eq(16)").text();
      		    
      		  totalsum=parseFloat(totalsum)+parseFloat(total);
      		  ntamtsum=parseFloat(ntamtsum)+parseFloat(netamnt);
      		  taxamtsum=parseFloat(taxamtsum)+parseFloat(taxamt);
      		  netotalsum=parseFloat(netotalsum)+parseFloat(nettotal);
      		    
      		  prodArray.push(psrno+" :: "+unitdoc+" :: "+qty+" :: 0 :: 0 :: "+price+" :: "+total+" :: "+dis+" :: "+discnt+" :: "+netamnt+" :: "+specid+" :: 0 :: 0 :: 0 :: 0 :: 0 :: 0 :: "+tax+" :: "+taxamt+" :: "+nettotal+" :: 0 :: "+000+" :: 0 :: "+desc+" :: ");
    	        }
    	   });
    		
    		
  		//alert(prodArray);
    		 createSOR(prodArray,totalsum,ntamtsum,taxamtsum,netotalsum);
    	}
    	
    	function  createSOR(prodArray,totalsum,ntamtsum,taxamtsum,netotalsum){
    		var frmtype="SOR";
    		var clinetid=$("#hidcmbcustomer").val();
            var vatype=$("#cmbvatype").val();
            var desc=$("#servdesc").val();
            var cur=$("#hidcmbcur").val();
            var rate=$("#hidcmbrate").val();
            var brhid=$("#hidbrhid").val();
            var userid=$("#hiduserid").val();
        	var x=new XMLHttpRequest();
        		x.onreadystatechange=function(){
        		if (x.readyState==4 && x.status==200){
        			var items=x.responseText;
     				 var item = items.split('::');
     				 var method=item[0];
     			      
     			      var aa=item[1];
        				if(parseInt(method)>0){
        				
     	   				Swal.fire({
     	   					type: 'success',
     	   				  	title: 'Success',  
     	   				  	text: 'Sales Order '+aa+' Successfully Created'
     	   				});
        				
        				}else{
     	   				Swal.fire({
     	   					type: 'error',
     	   				  	title: 'Error',     
     	   				  	text: 'Not Created'
     	   				});    
        				}       
        				}       
        		}
              x.open("GET","saveData.jsp?prodArray="+encodeURIComponent(prodArray)+"&clinetid="+clinetid+"&vatype="+vatype+"&desc="+desc+"&cur="+cur+"&rate="+rate+"&totalsum="+totalsum+"&ntamtsum="+ntamtsum+"&taxamtsum="+taxamtsum+"&netotalsum="+netotalsum+"&frmtype="+frmtype+"&locid=1"+"&brhid="+brhid+"&userid="+userid,true);		
        	  x.send();   
    	}
    	
    	function saveDelGrid(){
    		//alert("savedelgrid==");
   	
   		var prodArray= new Array();
   		var price=0,total=0,dis=0,discnt=0,netamnt=0;
   		$("#tbldel tr").each(function(){
   	        var currentRow=$(this);
   	    
   	        var part=currentRow.find("td:eq(0)").text();
   	        if(!part==""){
   	        var name=currentRow.find("td:eq(1)").text();
   	        var brand=currentRow.find("td:eq(2)").text();
   	        var unit=currentRow.find("td:eq(3)").text();
   	        var qty=currentRow.find("td:eq(4)").text();
   	        var price=currentRow.find("td:eq(5)").text();   	       
   	        var dis=currentRow.find("td:eq(6)").text();
     		var discnt=currentRow.find("td:eq(7)").text();
     		var psrno=currentRow.find("td:eq(8)").text();   	       
    	    var unitdoc=currentRow.find("td:eq(9)").text();
      		var specid=currentRow.find("td:eq(10)").text(); 
      		var amount=currentRow.find("td:eq(11)").text();
      		var netamount=currentRow.find("td:eq(12)").text();
      		var grantamt=currentRow.find("td:eq(13)").text();
     		  prodArray.push(psrno+" :: "+unitdoc+" :: "+qty+" :: 0 :: 0 :: "+price+" :: "+netamount+" :: "+dis+" :: "+discnt+" :: "+grantamt+" :: "+specid+" :: 0 :: 0 :: 0 :: 0 :: 0");
   	        }
   	   });
   		
   		
 		//alert(prodArray);
   		 createDEL(prodArray);
   	}
    	
    	function createDEL(prodArray){
    		//alert("createDEL==");
    		var clinetid=$('.tab-pane.in.active').find('input[data-type="customerdocno"]').val();
    		//$("#hidcmbcustomerdel").val();
    		var frmtype="DEL";
            var vatype=$("#hidvatype").val();
            var desc=$("#deldesc").val();
            var cur=$("#hidcmbcur").val();
            var rate=$("#hidcmbrate").val();
            var locid=$("#cmbdelnotelocation").val();
            var sordoc=0;
            //$("#rrefno").val();
            var reftype='';
            //$("#cmbreftype").val();
            var brhid=$("#cmbdelnotebranch").val();
            var userid=$("#hiduserid").val();
            alert(clinetid);
        	var x=new XMLHttpRequest();
        		x.onreadystatechange=function(){
        		if (x.readyState==4 && x.status==200){
        			var items=x.responseText;
     				 var item = items.split('::');
     				 var method=item[0];
     			      
     			      var aa=item[1];
        				if(parseInt(method)>0){
        				
     	   				Swal.fire({
     	   					type: 'success',
     	   				  	title: 'Success',  
     	   				  	text: 'Delivery Note '+aa+' Successfully Created'
     	   				});
        				
        				}else{
     	   				Swal.fire({
     	   					type: 'error',
     	   				  	title: 'Error',     
     	   				  	text: 'Not Created'
     	   				});    
        				}       
        				}       
        		}
              x.open("GET","saveData.jsp?prodArray="+encodeURIComponent(prodArray)+"&clinetid="+clinetid+"&vatype="+vatype+"&desc="+desc+"&cur="+cur+"&rate="+rate+"&frmtype="+frmtype+"&locid="+locid+"&sordoc="+sordoc+"&reftype="+reftype+"&brhid="+brhid+"&userid="+userid,true);		
        	  x.send();   
    	}
    	
    	function saveInvGrid(){
   		 var table = document.getElementById("tblinv"); 
   		var totalRows = document.getElementById("tblinv").rows.length;
   		var totalCol = 14; 
   	    var locid=$("#cmblocationinv").val();
   	    //var locid=$("#cmblocationinv").val();
   		var prodArray= new Array();
   		var totalsum=0,ntamtsum=0,taxamtsum=0,netotalsum=0;
   		$("#tblinv tr").each(function(){
   	        var currentRow=$(this);
   	    
   	        var part=currentRow.find("td:eq(0)").text();
   	        if(!part==""){
   	        var name=currentRow.find("td:eq(1)").text();
   	        var brand=currentRow.find("td:eq(2)").text();
   	        var unit=currentRow.find("td:eq(3)").text();
   	        var qty=currentRow.find("td:eq(4)").text();
   	        var price=currentRow.find("td:eq(5)").text();
   	        var total=currentRow.find("td:eq(6)").text();
   	        var dis=currentRow.find("td:eq(7)").text();
   	        var discnt=currentRow.find("td:eq(8)").text();
   	        var netamnt=currentRow.find("td:eq(9)").text();
   	        var tax=currentRow.find("td:eq(10)").text();
   	        var taxamt=currentRow.find("td:eq(11)").text();
   	        var nettotal=currentRow.find("td:eq(12)").text();
   	        var psrno=currentRow.find("td:eq(13)").text();
   	       
   	        var unitdoc=currentRow.find("td:eq(14)").text();
     		    var specid=currentRow.find("td:eq(15)").text();
     		    
     		  totalsum=parseFloat(totalsum)+parseFloat(total);
     		  ntamtsum=parseFloat(ntamtsum)+parseFloat(netamnt);
     		  taxamtsum=parseFloat(taxamtsum)+parseFloat(taxamt);
     		  netotalsum=parseFloat(netotalsum)+parseFloat(nettotal);
     		 
     		 
     		  prodArray.push(psrno+" :: "+unitdoc+" :: "+qty+" :: 0 :: 0 :: "+price+" :: "+total+" :: "+dis+" :: "+discnt+" :: "+netamnt+" :: "+specid+" :: 0 :: 0 :: 0 :: 0 :: "+locid+" :: "+tax+" :: "+nettotal+" :: 0 :: 0 :: "+000+" :: 0 :: "+taxamt+" :: 0 :: ");
   	        }
   	   });
   		
   		
 		//alert(prodArray);
   		 createINV(prodArray,totalsum,ntamtsum,taxamtsum,netotalsum);
   	}
    
    	function  createINV(prodArray,totalsum,ntamtsum,taxamtsum,netotalsum){
    		var frmtype="INV";
    		var clinetid=$("#hidcmbcustomerinv").val();
            var vatype=$("#cmbvatypeinv").val();
            var desc=$("#invdesc").val();
            var cur=$("#hidcmbcurinv").val();
            var rate=$("#hidcmbrateinv").val();
            var acno=$("#hidinvacno").val();
            var loc=$("#cmblocationinv").val();
            var sordoc=$("#rrefnoinv").val();
            var reftype=$("#cmbreftypeinv").val();
            var brhid=$("#hidbrhid").val();
            var userid=$("#hiduserid").val();
        	var x=new XMLHttpRequest();
        		x.onreadystatechange=function(){
        		if (x.readyState==4 && x.status==200){
        			var items=x.responseText;
     				 var item = items.split('::');
     				 var method=item[0];
     			      
     			      var aa=item[1];
        				if(parseInt(method)>0){
        				
     	   				Swal.fire({
     	   					type: 'success',
     	   				  	title: 'Success',  
     	   				  	text: 'Credit Invoice '+aa+' Successfully Created'
     	   				});
        				
        				}else{
     	   				Swal.fire({
     	   					type: 'error',
     	   				  	title: 'Error',     
     	   				  	text: 'Not Created'
     	   				});    
        				}       
        				}       
        		}
              x.open("GET","saveData.jsp?prodArray="+encodeURIComponent(prodArray)+"&clinetid="+clinetid+"&vatype="+vatype+"&desc="+desc+"&cur="+cur+"&rate="+rate+"&totalsum="+totalsum+"&ntamtsum="+ntamtsum+"&taxamtsum="+taxamtsum+"&netotalsum="+netotalsum+"&frmtype="+frmtype+"&clntacno="+acno+"&locid="+loc+"&sordoc="+sordoc+"&reftype="+reftype+"&brhid="+brhid+"&userid="+userid,true);		
        	  x.send();   
    	}
    	
    	function getProduct(chk) {
    		var clientid="",catid="";
    		var brhid=$('#hidbrhid').val();
    		if(parseInt(chk)==1){
    		 clientid=$('#hidcmbcustomer').val();
    		 catid=$('#hidcmbcatid').val();
    		if(clientid==""){      
				Swal.fire({
					type: 'warning',
				  	title: 'Warning',
				  	text: 'Please select customer first!!!'                         
				});
				return false;
			}
    		}
    		if(parseInt(chk)==2){
       		 clientid=$('#hidcmbcustomerdel').val();
       		 catid=$('#hidcmbdelcatid').val();
       		if(clientid==""){      
   				Swal.fire({
   					type: 'warning',
   				  	title: 'Warning',
   				  	text: 'Please select customer first!!!'                         
   				});
   				return false;
   			}
       		}
    		if(parseInt(chk)==3){
          		 clientid=$('#hidcmbcustomerinv').val();
          		 catid=$('#hidcmbinvcatid').val();
          		if(clientid==""){      
      				Swal.fire({
      					type: 'warning',
      				  	title: 'Warning',
      				  	text: 'Please select customer first!!!'                         
      				});
      				return false;
      			}
          		}
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var prdid = items[0].split(",");
					var prdname = items[1].split(","); 
					var tax = items[2].split(",");  
					var unit = items[3].split(",");
					var brand = items[4].split(",");
					var psrno = items[5].split(",");
					var specid = items[6].split(",");
					var unitdoc = items[7].split(",");
					var uprice = items[8].split(",");
					var taxdoc = items[9].split(",");
					var optionsyear = "";
					for (var i = 0; i < prdid.length; i++) {
						optionsyear += '<option value="' + prdname[i] + '" data-prdid="'+prdid[i]+'" data-tax="'+tax[i]+'" data-unit="'+unit[i]+'"data-brand="'+brand[i]+'"data-psrno="'+psrno[i]+'"data-specid="'+specid[i]+'"data-unitdoc="'+unitdoc[i]+'"data-uprice="'+uprice[i]+'"data-taxdoc="'+taxdoc[i]+'"></option>';
					}
					if(parseInt(chk)==1){
						$("datalist#prdts").html(optionsyear);    
					}
					if(parseInt(chk)==2){
						$("datalist#delprdts").html(optionsyear);    
					} 
					if(parseInt(chk)==3){
						$("datalist#invprdts").html(optionsyear);    
					}
				} else {
				}
			}
			x.open("GET", "getProduct.jsp?clientid="+clientid+"&clientcatid="+catid+"&brhid="+brhid, true);
			x.send();
		} 
    	
    	function funRoundAmt(value,id){
			  var res=parseFloat(value).toFixed(2);
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
			 } 
    	function isNumber(evt) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	        	{
	     	  // document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	           
	            return false;
	        	}
	        //document.getElementById("errormsg").innerText="";  
	        return true;
	    }
    	
    	 function vatSwitch(chk){
    		 var type="";
				if(parseInt(chk)==1){
					 type=document.getElementById("cmbvatype").value;
				}
				if(parseInt(chk)==2){
					 type=document.getElementById("cmbvatypeinv").value;
				}
				//alert("type======"+type);
				if(type=="exclusive"){
					calculatedatas(this.id,chk);
				}
				if(type=="inclusive"){
					calcincl(chk);
				}
		        if(type=="export"){
					calcexp(chk);
				}
			}
			
			function calcincl(chk){
				//alert("in inclusive");
				if(parseInt(chk)==1){
					var qty=document.getElementById("qty").value;
					var unitprce=document.getElementById("unitprice").value;
					var tsk=document.getElementById("taxper").value;
					
					var calfix="100";
					if(parseFloat(unitprce)>0){
						var cal=parseFloat(calfix)+parseFloat(tsk);
					var total=parseFloat(qty)*parseFloat(unitprce);
					funRoundAmt(total,"total");
					var dis=document.getElementById("disper").value;
					if(parseFloat(dis)>0){
					var disamt=(parseFloat(total)/100)*parseFloat(dis);
					//document.getElementById("dict").value=disamt;
					 funRoundAmt(disamt,"discount");
					var net=parseFloat(total)-parseFloat(disamt);
					//document.getElementById("taxamountstotal").value=net;
					 funRoundAmt(net,"nettotal");
					var net1=(parseFloat(net)/cal)*100;
					//document.getElementById("amounts").value=net1;
					 funRoundAmt(net1,"netamount");
					var taxamt=parseFloat(net)-parseFloat(net1);
					//document.getElementById("taxamounts").value=taxamt;
					 funRoundAmt(taxamt,"taxamount");
					}else{
						funRoundAmt(total,"nettotal");
						var net1=(parseFloat(total)/cal)*100;
						funRoundAmt(net1,"netamount");
						var taxamt=parseFloat(total)-parseFloat(net1);
						//document.getElementById("taxamounts").value=taxamt;
						 funRoundAmt(taxamt,"taxamount");
					}
					}
				}
				if(parseInt(chk)==2){
					var qty=document.getElementById("invqty").value;
					var unitprce=document.getElementById("invunitprice").value;
					var tsk=document.getElementById("invtaxper").value;
					
					var calfix="100";
					if(parseFloat(unitprce)>0){
						var cal=parseFloat(calfix)+parseFloat(tsk);
					var total=parseFloat(qty)*parseFloat(unitprce);
					funRoundAmt(total,"invtotal");
					var dis=document.getElementById("invdisper").value;
					if(parseFloat(dis)>0){
					var disamt=(parseFloat(total)/100)*parseFloat(dis);
					//document.getElementById("dict").value=disamt;
					 funRoundAmt(disamt,"invdiscount");
					var net=parseFloat(total)-parseFloat(disamt);
					//document.getElementById("taxamountstotal").value=net;
					 funRoundAmt(net,"invnettotal");
					var net1=(parseFloat(net)/cal)*100;
					//document.getElementById("amounts").value=net1;
					 funRoundAmt(net1,"invnetamount");
					var taxamt=parseFloat(net)-parseFloat(net1);
					//document.getElementById("taxamounts").value=taxamt;
					 funRoundAmt(taxamt,"invtaxamount");
					}else{
						funRoundAmt(total,"invnettotal");
						var net1=(parseFloat(total)/cal)*100;
						funRoundAmt(net1,"invnetamount");
						var taxamt=parseFloat(total)-parseFloat(net1);
						//document.getElementById("taxamounts").value=taxamt;
						 funRoundAmt(taxamt,"invtaxamount");
					}
					}
				}
			}
			
		    function calcexp(chk){
		    	//alert("in export");
		    	if(parseInt(chk)==1){
		    		document.getElementById("taxamount").value=0;
			    	document.getElementById("taxper").value=0;
		    	}
		    	if(parseInt(chk)==2){
		    		document.getElementById("invtaxamount").value=0;
			    	document.getElementById("invtaxper").value=0;
		    	}
		    	
		    	calculatedatas(this.id,chk);
			}
		    
		    
		    function calculatedatas(val,chk)
			 {
		    	var quantity=0,uprice=0,taxpers=0,disper=0,discount=0;
		    	if(parseInt(chk)==1){
		    		 quantity=document.getElementById("qty").value;				
					 uprice=document.getElementById("unitprice").value;
					 taxpers=document.getElementById("taxper").value;				
					 disper=document.getElementById("disper").value;
					 discount=document.getElementById("discount").value;
					
					if(val=="disper"){discount=0; }
					 if(val=="discount"){disper=0; }
		    	}
		    	if(parseInt(chk)==2){
		    		 quantity=document.getElementById("invqty").value;				
					 uprice=document.getElementById("invunitprice").value;
					 taxpers=document.getElementById("invtaxper").value;				
					 disper=document.getElementById("invdisper").value;
					 discount=document.getElementById("invdiscount").value;
					
					if(val=="invdisper"){discount=0; }
					 if(val=="invdiscount"){disper=0; }
		    	}
				 
				var focs=0;
				var totamt=0;
				var taxamounts=0;
				var taxamountstotal=0;
				
				if(quantity=="" || quantity==null || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
				{
					quantity=0;
				}
				
				if(focs=="" || focs==null || focs==0 ||typeof(focs)=="undefined"|| typeof(focs)=="NaN")
				{
					focs=0;
					
					
				}
				
				
				
				if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN")
				{
					disper=0;
				}
				
				
				if(discount=="" || discount==null || discount==0 || typeof(discount)=="undefined"|| typeof(discount)=="NaN")
				{
					discount=0;
				}
				
				
				
				
				
				 
	 
				
				
				
				if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
				{
					uprice=0;
				}
				 
					 
				if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
				{
					taxpers=0;
				}
				
				
				
				var netamount=0; 
				 if(parseFloat(quantity)>0 && parseFloat(uprice)>0)
					 {
					 
					 totamt=parseFloat(quantity)*parseFloat(uprice);
					/*  taxamountstotal=parseFloat(totamt)+parseFloat(taxamounts); */
					 
					 
					 
					 }
				 
					if(parseFloat(disper)>0 || parseFloat(discount)>0)
						
					{
					
					if(parseFloat(disper)>0)
						{
							discount=(parseFloat(totamt)*parseFloat(disper))/100;
						
						}
					
					else if(parseFloat(discount)>0)
						{
						
						disper=(100/parseFloat(totamt))*parseFloat(discount);
						
						}
					 
					netamount=parseFloat(totamt)-parseFloat(discount);
					
					}
				else
					{
					disper=0;
					discount=0;
					netamount=totamt;
					
					
					
					}
				
			 
				 
				 
				 if(parseFloat(taxpers))
				 {
					 
					 taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
					 taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
				 }
				 else
					 {
					 taxamountstotal=netamount;
					 }
				 if(parseInt(chk)==1){
					 document.getElementById("total").value=(totamt).toFixed(2);
					 document.getElementById("netamount").value=(totamt).toFixed(2);
					 document.getElementById("disper").value=parseFloat(disper).toFixed(2);
					 document.getElementById("discount").value=parseFloat(discount).toFixed(2);
					 document.getElementById("netamount").value=(netamount).toFixed(2);
					 document.getElementById("taxamount").value=(taxamounts).toFixed(2);
					 document.getElementById("nettotal").value=(taxamountstotal).toFixed(2);
				 }
				 if(parseInt(chk)==2){
					 document.getElementById("invtotal").value=(totamt).toFixed(2);
					 document.getElementById("invnetamount").value=(totamt).toFixed(2);
					 document.getElementById("invdisper").value=parseFloat(disper).toFixed(2);
					 document.getElementById("invdiscount").value=parseFloat(discount).toFixed(2);
					 document.getElementById("invnetamount").value=(netamount).toFixed(2);
					 document.getElementById("invtaxamount").value=(taxamounts).toFixed(2);
					 document.getElementById("invnettotal").value=(taxamountstotal).toFixed(2); 
				 }
				
				
				 
				 if(val==1)
					 {
					// document.getElementById("focs").focus();
					 }
				 else{
					// document.getElementById("setbtn").focus();
				 }
					 
					 
				 
					 
				 
				 
			 }
    	function getProductID(chk) {
    		var clientid="",catid="";
    		//var brhid=$('#hidbrhid').val();
            var brhid=$('.tab-pane.in.active').find('select[data-type="branch"]').val();
           	clientid=$('.tab-pane.in.active').find('input[data-type="customerdocno"]').val();
           	catid=$('.tab-pane.in.active').find('input[data-type="customercatid"]').val();
           	//alert(clientid);
           	if(clientid==""){
           		return false;
           	}
           	
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var prdid = items[0].split(",");
					var prdname = items[1].split(","); 
					var tax = items[2].split(",");  
					var unit = items[3].split(",");
					var brand = items[4].split(",");
					var psrno = items[5].split(",");
					var specid = items[6].split(",");
					var unitdoc = items[7].split(",");
					var uprice = items[8].split(",");
					var taxdoc = items[9].split(",");
					var optionsyear = "";
					for (var i = 0; i < prdid.length; i++) {
						optionsyear += '<option value="' + prdid[i] + '" data-prdname="'+prdname[i]+'" data-tax="'+tax[i]+'" data-unit="'+unit[i]+'"data-brand="'+brand[i]+'"data-psrno="'+psrno[i]+'"data-specid="'+specid[i]+'"data-unitdoc="'+unitdoc[i]+'"data-uprice="'+uprice[i]+'"data-taxdoc="'+taxdoc[i]+'"></option>';
					}
					
					if(parseInt(chk)==1){
						$("datalist#productid").html(optionsyear);    
					}
					if(parseInt(chk)==2){
						$("datalist#delproductid").html(optionsyear);    
					} 
					if(parseInt(chk)==3){
						$("datalist#invproductid").html(optionsyear);    
					} 
				} else {
				}
			}
			x.open("GET", "getProduct.jsp?clientid="+clientid+"&clientcatid="+catid+"&brhid="+brhid, true);
			x.send();
		} 
    	$("#prdname").click(function(){
    		getProduct(1);
    		getProductID(1);
    	});
    	
        $("#prdid").click(function(){
        	getProduct(1);
    		getProductID(1);
    	});
    	
        $("#delprdname").click(function(){
    		getProduct(2);
    		getProductID(2);
    	});
    	
        $("#delprdid").click(function(){
        	getProduct(2);
    		getProductID(2);
    	});
        
        $("#invprdname").click(function(){
    		getProduct(3);
    		getProductID(3);
    	});
    	
        $("#invprdid").click(function(){
        	getProduct(3);
    		getProductID(3);
    	});
        
        $("#cmblocation").change(function(){
        	var loc = $("#cmblocation").val();
        //	alert("loc==="+loc)
        });
        
    	$("#prdname").change(function(){
    		var dl=$("#prdts")[0];
    		 var el=$("#prdname")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		
    		var prdid = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-prdid');
    		var tax = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-tax')
    		var unit = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-unit');
    		var brand = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-brand');
    		var psrno = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-psrno')
    		var specid = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-specid');
    		var unitdoc = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-unitdoc');
    		var uprice = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-uprice')
    		var taxdoc = $("#prdts option[value='" + $('#prdname').val() + "']").attr('data-taxdoc');
    		
    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
    		document.getElementById("prdid").value=prdid;
    		document.getElementById("taxper").value=tax;
    		document.getElementById("unit").value=unit;
    		document.getElementById("brand").value=brand;
    		document.getElementById("unit").value=unit;
    		
    		document.getElementById("psrno").value=psrno;
    		document.getElementById("unitdoc").value=unitdoc;
    		document.getElementById("specid").value=specid;
    		document.getElementById("taxdoc").value=taxdoc;
    		document.getElementById("hidunitprice").value=uprice;
    		 }
			 
			});
    	
    	$("#delprdname").change(function(){
    		var dl=$("#delprdts")[0];
    		 var el=$("#delprdname")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		
    		var prdid = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-prdid');
    		var tax = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-tax')
    		var unit = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-unit');
    		var brand = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-brand');
    		var psrno = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-psrno')
    		var specid = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-specid');
    		var unitdoc = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-unitdoc');
    		var uprice = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-uprice');
    		var taxdoc = $("#delprdts option[value='" + $('#delprdname').val() + "']").attr('data-taxdoc');
    		
    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
    		document.getElementById("delprdid").value=prdid;
    		document.getElementById("delunit").value=unit;
    		document.getElementById("delbrand").value=brand;
    		document.getElementById("delunit").value=unit;
    		
    		document.getElementById("psrno").value=psrno;
    		document.getElementById("unitdoc").value=unitdoc;
    		document.getElementById("specid").value=specid;
    		document.getElementById("taxdoc").value=taxdoc;
    		document.getElementById("hidunitprice").value=uprice;
    		 }
			 
			});
    	
    	$("#invprdname").change(function(){
    		var dl=$("#invprdts")[0];
    		 var el=$("#invprdname")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		
    		var prdid = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-prdid');
    		var tax = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-tax')
    		var unit = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-unit');
    		var brand = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-brand');
    		var psrno = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-psrno')
    		var specid = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-specid');
    		var unitdoc = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-unitdoc');
    		var uprice = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-uprice');
    		var taxdoc = $("#invprdts option[value='" + $('#invprdname').val() + "']").attr('data-taxdoc');
    		
    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
    		document.getElementById("invprdid").value=prdid;
    		document.getElementById("invunit").value=unit;
    		document.getElementById("invtaxper").value=tax;
    		document.getElementById("invbrand").value=brand;
    		document.getElementById("invunit").value=unit;
    		
    		document.getElementById("psrno").value=psrno;
    		document.getElementById("unitdoc").value=unitdoc;
    		document.getElementById("specid").value=specid;
    		document.getElementById("taxdoc").value=taxdoc;
    		document.getElementById("hidunitprice").value=uprice;
    		 }
			 
			});
    	
    	$("#prdid").change(function(){
    		var dl=$("#productid")[0];
    		 var el=$("#prdid")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		
    		var prdname = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-prdname');
    		var tax = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-tax')
    		var unit = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-unit');
    		var brand = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-brand');
    		var psrno = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-psrno')
    		var specid = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-specid');
    		var unitdoc = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-unitdoc');
    		var uprice = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-uprice')
    		var taxdoc = $("#productid option[value='" + $('#prdid').val() + "']").attr('data-taxdoc');
    		
    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
    		document.getElementById("prdname").value=prdname;
    		document.getElementById("taxper").value=tax;
    		document.getElementById("unit").value=unit;
    		document.getElementById("brand").value=brand;
    		document.getElementById("unit").value=unit;
    		
    		document.getElementById("psrno").value=psrno;
    		document.getElementById("unitdoc").value=unitdoc;
    		document.getElementById("specid").value=specid;
    		document.getElementById("taxdoc").value=taxdoc;
    		document.getElementById("hidunitprice").value=uprice;
    		 }
			 
			});
    	
    	$("#delprdid").change(function(){
    		var dl=$("#delproductid")[0];
    		 var el=$("#delprdid")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		
    		var prdname = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-prdname');
    		var tax = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-tax')
    		var unit = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-unit');
    		var brand = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-brand');
    		var psrno = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-psrno')
    		var specid = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-specid');
    		var unitdoc = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-unitdoc');
    		var uprice = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-uprice')
    		var taxdoc = $("#delproductid option[value='" + $('#delprdid').val() + "']").attr('data-taxdoc');
    		
    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
    		document.getElementById("delprdname").value=prdname;
    		document.getElementById("delunit").value=unit;
    		document.getElementById("delbrand").value=brand;
    		document.getElementById("delunit").value=unit;
    		
    		document.getElementById("psrno").value=psrno;
    		document.getElementById("unitdoc").value=unitdoc;
    		document.getElementById("specid").value=specid;
    		document.getElementById("taxdoc").value=taxdoc;
    		document.getElementById("hidunitprice").value=uprice;
    		 }
			 
			});
    	
    	$("#invprdid").change(function(){
    		var dl=$("#invproductid")[0];
    		 var el=$("#invprdid")[0];
    		// alert(el.value.trim());
    		 if(el.value.trim() != ''){
    		
    		var prdname = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-prdname');
    		var tax = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-tax')
    		var unit = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-unit');
    		var brand = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-brand');
    		var psrno = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-psrno')
    		var specid = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-specid');
    		var unitdoc = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-unitdoc');
    		var uprice = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-uprice')
    		var taxdoc = $("#invproductid option[value='" + $('#invprdid').val() + "']").attr('data-taxdoc');
    		
    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
    		document.getElementById("invprdname").value=prdname;
    		document.getElementById("invtaxper").value=tax;
    		document.getElementById("invunit").value=unit;
    		document.getElementById("invbrand").value=brand;
    		document.getElementById("invunit").value=unit;
    		
    		document.getElementById("psrno").value=psrno;
    		document.getElementById("unitdoc").value=unitdoc;
    		document.getElementById("specid").value=specid;
    		document.getElementById("taxdoc").value=taxdoc;
    		document.getElementById("hidunitprice").value=uprice;
    		 }
			 
			});
    	
    	function getvaType() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('###');
					var brandItems = items[0].split(",");
					var brandidItems = items[1].split(",");
					//var optionsbrand = '<option value="">--Select--</option>';
					var optionsbrand="";
					for (var i = 0; i < brandItems.length; i++) {
						 optionsbrand+= '<option value="' + brandidItems[i] + '">'
								+ brandItems[i] + '</option>';
						/* document.getElementById("brandid").value=brandidItems[i]; */
					}
					$("select#cmbvatype").html(optionsbrand);
					$("select#cmbvatypeinv").html(optionsbrand);
					//alert("in cmb vat");
						if($('#hidcmbvatype').val()){
							//alert("in cmb vat set");
							 var hidvat=$('#hidcmbvatype').val().trim();
								
								if(hidvat=="exclusive"){
									document.getElementById("cmbvatype").value="";
									document.getElementById("cmbvatype").value="exclusive";
								}
								if(hidvat=="inclusive"){
									document.getElementById("cmbvatype").value="";
									document.getElementById("cmbvatype").value="inclusive";
								}
								if(hidvat=="export"){
									//alert("in cmb vat set export");
									document.getElementById("cmbvatype").value="";
									document.getElementById("cmbvatype").value="export";
								}
							//$('#cmbvatype').val($('#hidcmbvatype').val());
						}
						else{
							//alert("in cmb vat normal");
							
						}
				
					
				} else {
					
				}
			}
			x.open("GET", "getvaType.jsp", true);
			x.send();
		}
    	
    	function getDetails() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('###');
					var userid = items[0].split(",");
					var brhid = items[1].split(",");
					var name = items[2].split(",");
					$('#hiduserid').val(userid);
					$('#hidbrhid').val(brhid);
					$('.admin-cover .panel-body strong').text("Hi "+name);
	  				$('.user-dropdown .user-dropdown-text').text(name);	
	  				getLocation(userid,brhid);
					
				} else {
					
				}
			}
			x.open("GET", "getDetail.jsp", true);
			x.send();
		}
    	
    	
    	 function getLocation(userid,brhid) {
    		//var costtype=$('#cmbcosttype').val();               
   			var x = new XMLHttpRequest();
   			x.onreadystatechange = function() {
   				if (x.readyState == 4 && x.status == 200) {
   					var items = x.responseText;
   					//console.log(items);
   					items = items.split('###');
   					var yearItems = items[0].split(",");           
   					var yearIdItems = items[1].split(",");
   					//alert(yearIdItems);
   					var optionsyear = "";
   					for (var i = 0; i < yearItems.length; i++) {
   						optionsyear += '<option value="' + yearItems[i] + '">'
							+ yearIdItems[i] + '</option>';
   					}
   					//alert(optionsyear);
   					$("select#cmblocation").html(optionsyear);
   					$("select#cmblocationinv").html(optionsyear);
   					/* if($('#hidcmbcostcode').val()){             
   						document.getElementById("cmbcostcode").value=document.getElementById("hidcmbcostcode").value;
   						//funreload(event);       
   					  } */
   				} else {
   				}
   			}
   			x.open("GET", "locationset.jsp?brhid="+brhid, true);                   
   			x.send();
   		} 
    	
    	
    	 
    	 function getCustomer() {
   			var x = new XMLHttpRequest();
   			x.onreadystatechange = function() {
   				if (x.readyState == 4 && x.status == 200) {
   					var items = x.responseText;
   					items = items.split('####');
   					var yearItems = items[0].split(",");
   					var yearIdItems = items[1].split(","); 
   					var curid = items[2].split(",");  
   					var rate = items[3].split(",");  
   					var catid = items[4].split(",");
   					var acno = items[5].split(","); 
   					var optionsyear = "";
   					for (var i = 0; i < yearItems.length; i++) {
   						optionsyear += '<option value="' + yearItems[i] + '" data-id="'+yearIdItems[i]+'" data-cur="'+curid[i]+'" data-rate="'+rate[i]+'"data-catid="'+catid[i]+'"data-acno="'+acno[i]+'"></option>';
   					}
   					$("datalist#cmbcustomer").html(optionsyear); 
   					$("datalist#delcmbcustomer").html(optionsyear);
   					$("datalist#invcmbcustomer").html(optionsyear);
   					if($('#hidcmbcustomer').val()){
   						document.getElementById("cmbcustomer").value=document.getElementById("hidcmbcustomer").value;
   						//funreload(event);       
   					}
   				} else {
   				}
   			}
   			x.open("GET", "getCustomer.jsp", true);
   			x.send();
   		} 
    	
    	 
    	
    	 
    	
		
   		function getInitData(){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				
	  				var stkdata=JSON.parse(items.split("::")[1].trim());          
	  				var contracttablehtml='';   
	  				var branchhtml='';
	  				$.each(stkdata.branchdata,function(index,value){
	  					branchhtml+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  				});
	  				var delnotehtml='';
	  				$.each(stkdata.delnotedata,function(index,value){
	  					delnotehtml+='<option value="'+value.docno+'">'+value.docno+'</option>';
	  				});
	  				$('select[data-type="delnote"]').html($.parseHTML(delnotehtml));
	  				
	  				$('select[data-type="branch"]').html($.parseHTML(branchhtml));
	  				$('select[data-type="branch"]').each(function(){
	  					$(this).change(function(){
	  						var branchdocno=$(this).val();
	  						var elmLoc=$(this).closest('.row').find('select[data-type="location"]');
	  						$.get('locationset.jsp',{'brhid':branchdocno},function(data){
	  							data=JSON.parse(data.split("###")[2]);
	  							var htmldata='';
	  							$.each(data.locdata,function(index,value){
	  								htmldata+='<option value="'+value.docno+'">'+value.location+'</option>';
	  							});
	  							$(elmLoc).html($.parseHTML(htmldata));
	  						});
	  					});
	  				});
	  				$.each(stkdata.stockdata, function( index, value ) {   
	  				
	  					contracttablehtml+='<tr>';
	  					contracttablehtml+='<td align="center">'+value.srno+'</td>';   
	  					contracttablehtml+='<td>'+value.productid+'</td>';
	  					contracttablehtml+='<td>'+value.productname+'</td>';
	  					contracttablehtml+='<td>'+value.brandname+'</td>';
	  					contracttablehtml+='<td>'+value.batch+'</td>';
	  					contracttablehtml+='<td>'+value.expiry+'</td>';  
	  					contracttablehtml+='<td>'+value.department+'</td>'; 
	  					contracttablehtml+='</tr>';     
	  				});
	  				$('#tblstocklist tbody').html($.parseHTML(contracttablehtml));  
	  			   
	  				$('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getClientInitData.jsp", true);
	  		x.send();
		} 
   	
    </script>           
</body>     
</html>