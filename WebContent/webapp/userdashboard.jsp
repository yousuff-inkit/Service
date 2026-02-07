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
.border{
	border:1px solid #000;
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
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> <span class="user-dropdown-text"><%=session.getAttribute("USERNAME")==null?"User":session.getAttribute("USERNAME").toString()%></span>
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
	<form autocomplete="off">
	<div class="container-fluid">
		<ul class="nav nav-pills custom-tabs nav-justified m-t-60">               
    		<li class="active" ><a data-toggle="pill" href="#menudelnote"><i class="fa fa-mail-reply p-r-5" data-toggle="tooltip" title="Delivery Note" data-placement="bottom"></i><span class="hidden-xs">Delivery Note</span></a></li> 
    		<li ><a data-toggle="pill" href="#menudelnoteret"><i class="fa fa-mail-forward p-r-5" data-toggle="tooltip" title="Delivery Note Return" data-placement="bottom"></i><span class="hidden-xs">Delivery Note Return</span></a></li>
    		<li ><a data-toggle="pill" href="#menugrn"><i class="fa fa-sticky-note p-r-5" data-toggle="tooltip" title="GRN" data-placement="bottom"></i><span class="hidden-xs">GRN</span></a></li>  
    		<li ><a data-toggle="pill" href="#menugrnret"><i class="fa fa-sticky-note-o p-r-5" data-toggle="tooltip" title="GRN Return" data-placement="bottom"></i><span class="hidden-xs">GRN Return</span></a></li>
    		<li ><a data-toggle="pill" href="#menustocklist"><i class="fa fa-th-list p-r-5" data-toggle="tooltip" title="Product List" data-placement="bottom"></i><span class="hidden-xs">Product List</span></a></li>                                   
  		</ul>  
  		<div id="modalscan" class="modal fade" role="dialog">
	    	<div class="modal-dialog">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Barcode Scanning</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div class="row rowgap">
	            				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	            					<div id="qr-reader" style="width:500px"></div>
    								<div id="qr-reader-results"></div>
	            				</div>
	            			</div>            	
	            		</div>
	            	</div>
	          	</div>
	        </div>
	    </div>
  		<div class="tab-content">	   
    		<div id="menudelnote" class="tab-pane fade in active">
  				<div class="container-fluid">
  					<div class="row">
  						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  						<div class="panel panel-default">
  							<div class="panel-body" style="border:none;">	
  								<div class="form-horizontal" role="form">
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
  							     		<div class="form-group form-group-w">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnotecustomer">Customer</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input type="text" name="delnotecustomer" id="delnotecustomer" class="form-control" onkeyup="funFilterList(this);" data-type="customer">
		                                   		<span class="help-block" style="color:red;"></span>
		                                   		<ul class="searchlist list-group" data-type="customer">	  										
												</ul>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="deldesc" placeholder="Details" id="deldesc" data-max="250" data-type="desc">
		                                        <span class="help-block" style="color:red;"></span>
		                                </div>
		                            </div>
    						   	</div>
    						</div>
    						<h4><strong>Item Details</strong></h4>
  							<div class="table-responsive">
  								<table class="table table-hover" id="tbldelnote" width="100% "  >   
							   		<tr>
							  			<td width="25% " class="nchngelmnt">
							  				
							  				<div class="form-group form-group-w">							  					
						  						<label class="control-label">ProductID</label>
						  							<div class="input-group">
						  								<input type="text" class="form-control" id="delprdid" list="delproductid"  style="text-align: left;width:100%;" onkeyup="funFilterList(this);">
								  						<div class="input-group-btn">
								  							<button type="button" class="btn btn-default" data-type="btnmodalscan" data-target="#modalscan"><i class="fa fa-barcode"></i></button>
								  						</div>		
						  							</div>						  						
								   					<span class="help-block" style="color:red;"></span>
								   					<ul class="searchlist list-group" data-type="productid" style="max-height:300px;overflow-y:auto;">	  										
													</ul>
							  				</div>
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<div class="form-group form-group-w">
							   					<label class="col-md-2 control-label">ProductName</label>
								   				<input type="text" class="form-control" id="delprdname" list="delprdts" style="text-align: left;width:96%" onkeyup="funFilterList(this);">
								   				<span class="help-block" style="color:red;"></span>
								   				<ul class="searchlist list-group" data-type="productname" style="max-height:300px;overflow-y:auto;">		
												</ul>
							   				</div>
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
									<table class="table table-hover" id="tbldel" data-type="detail">
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
	    						      			<button type="button" class="btn btn-default btn-outline-primary btncreatedel"><i class="fa fa-floppy-o m-r-5"></i>Create Delivery Note</button>
	    						     			<button id="btnsorclear" type="button" class="btn btn-default m-r-5" data-type="clear">Clear</button>
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
  								<div class="form-horizontal" role="form">
  							    	<div id="row">
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnoteretbranch">Branch</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnoteretbranch" id="cmbdelnoteretbranch" class="form-control" data-type="branch">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnoteretlocation">Location</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbdelnoteretlocation" id="cmbdelnoteretlocation" class="form-control" data-type="location">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							     		<div class="form-group form-group-w">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnoteretcustomer">Customer</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input type="text" name="delnoteretcustomer" id="delnoteretcustomer" class="form-control" onkeyup="funFilterList(this);" data-type="customer">
		                                   		<span class="help-block" style="color:red;"></span>
		                                   		<ul class="searchlist list-group" data-type="customer">	  										
												</ul>
		                                    </div>
		                                </div>
		                                <div class="form-group form-group-w">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbdelnote">Delivery Note</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input type="text" name="delnote" id="delnote" class="form-control" onkeyup="funFilterList(this);" data-type="delnote">
		                                   		<span class="help-block" style="color:red;"></span>
		                                   		<ul class="searchlist list-group" data-type="delnote">	  										
												</ul>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="deldesc" placeholder="Details" id="deldesc" data-max="250" data-type="desc">
		                                        <span class="help-block" style="color:red;"></span>
		                                </div>
		                            </div>
    						   	</div>
    						</div>
    						<%-- <h4><strong>Item Details</strong></h4>
  							<div class="table-responsive">
  								<table class="table table-hover" id="tbldelnoteret" width="100% "  >   
							   		<tr>
							  			<td width="15% " class="nchngelmnt">
							  				<div class="form-group form-group-w">
							  					<label class="col-md-2 control-label">ProductID</label>
								   				<input type="text" class="form-control" id="delretprdid" list="delretproductid"  style="text-align: left;width:96%" onkeyup="funFilterList(this);">
								   				<span class="help-block" style="color:red;"></span>
								   				<ul class="searchlist list-group" data-type="productid" style="max-height:300px;overflow-y:auto;">	  										
												</ul>
							  				</div>
							   				
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<div class="form-group form-group-w">
							   					<label class="col-md-2 control-label">ProductName</label>
								   				<input type="text" class="form-control" id="delretprdname" list="delretprdts" style="text-align: left;width:96%" onkeyup="funFilterList(this);">
								   				<span class="help-block" style="color:red;"></span>
								   				<ul class="searchlist list-group" data-type="productname" style="max-height:300px;overflow-y:auto;">		
												</ul>
							   				</div>
							  			</td>
							   			<td width="30% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">Barcode</label>
							   				<input type="text" class="form-control" name="delretbrand" id="delretbrand" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="5% " class="chngelmnt">
							   				<label class="col-md-2 control-label">Unit</label>
							   				<input type="text" class="form-control" name="delretunit" id="delretunit" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="10% "class="chngelmnt">
							   				<label class="col-md-2 control-label">Quantity</label>
							   				<input type="text" class="form-control" name="delretqty" id="delretqty" style="text-align: right;width:96%" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
							  			</td>
							   			<td class="dchngelmnt"><br>
							   				<button id="btnDelRetAdd" type="button" class="btn btn-default btn-success" >ADD</button>
							   			</td>
							   		</tr>
							    </table>
  							</div>
  							 --%>
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
								<div class="panel-body no-border">
									<table class="table table-hover" id="tbldelret" data-type="detail">
	  									<thead>       
	  										<tr>
	  											<th>&nbsp;</th>
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
	    						      			<button  type="button" class="btn btn-default btn-outline-primary btncreatedelret"><i class="fa fa-floppy-o m-r-5"></i>Create Delivery Note Return</button>
	    						     			<button id="btndelretclear" type="button" class="btn btn-default m-r-5" data-type="clear">Clear</button>
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
  								<div class="form-horizontal" role="form">
  							    	<div id="row">
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbgrnbranch">Branch</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbgrnbranch" id="cmbgrnbranch" class="form-control" data-type="branch">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbgrnlocation">Location</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbgrnlocation" id="cmbgrnlocation" class="form-control" data-type="location">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							     		<div class="form-group form-group-w">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="grnvendor">Vendor</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input type="text" name="grnvendor" id="grnvendor" class="form-control" onkeyup="funFilterList(this);" data-type="vendor">
		                                   		<span class="help-block" style="color:red;"></span>
		                                   		<ul class="searchlist list-group" data-type="vendor">	  										
												</ul>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="grndesc" placeholder="Details" id="grndesc" data-max="250" data-type="desc">
		                                        <span class="help-block" style="color:red;"></span>
		                                </div>
		                            </div>
    						   	</div>
    						</div>
    						<h4><strong>Item Details</strong></h4>
  							<div class="table-responsive">
  								<table class="table table-hover" width="100% "  >   
							   		<tr>
							  			<td width="15% " class="nchngelmnt">
							  				<div class="form-group form-group-w">
							  					<label class="control-label">ProductID</label>
							  					<div class="input-group">
								   					<input type="text" class="form-control" id="grnprdid" list="grnproductid"  style="text-align: left;width:100%" onkeyup="funFilterList(this);">
								   					<div class="input-group-btn">
								  						<button type="button" class="btn btn-default" data-type="btnmodalscan" ><i class="fa fa-barcode"></i></button>
								  					</div>
								  				</div>
								   				<span class="help-block" style="color:red;"></span>
								   				<ul class="searchlist list-group" data-type="productid" style="max-height:300px;overflow-y:auto;">	  										
												</ul>
							  				</div>
							   				
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<div class="form-group form-group-w">
							   					<label class="col-md-2 control-label">ProductName</label>
								   				<input type="text" class="form-control" id="grnprdname" list="grnprdts" style="text-align: left;width:96%" onkeyup="funFilterList(this);">
								   				<span class="help-block" style="color:red;"></span>
								   				<ul class="searchlist list-group" data-type="productname" style="max-height:300px;overflow-y:auto;">		
												</ul>
							   				</div>
							  			</td>
							   			<td width="30% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">Barcode</label>
							   				<input type="text" class="form-control" name="grnbrand" id="grnbrand" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="5% " class="chngelmnt">
							   				<label class="col-md-2 control-label">Unit</label>
							   				<input type="text" class="form-control" name="grnunit" id="grnunit" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="10% "class="chngelmnt">
							   				<label class="col-md-2 control-label">Quantity</label>
							   				<input type="text" class="form-control" name="grnqty" id="grnqty" style="text-align: right;width:96%" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
							  			</td>
							   			<td class="dchngelmnt"><br>
							   				<button id="btnGRNAdd" type="button" class="btn btn-default btn-success" >ADD</button>
							   			</td>
							   		</tr>
							    </table>
  							</div>
  							
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
								<div class="panel-body no-border">
									<table class="table table-hover" id="tblgrn" data-type="detail">
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
	    						      			<button type="button" class="btn btn-default btn-outline-primary btncreategrn"><i class="fa fa-floppy-o m-r-5"></i>Create Goods Reciept Note</button>
	    						     			<button id="btnsorclear" type="button" class="btn btn-default m-r-5"  data-type="clear">Clear</button>
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
  								<div class="form-horizontal" role="form">
  							    	<div id="row">
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbgrnretbranch">Branch</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbgrnretbranch" id="cmbgrnretbranch" class="form-control" data-type="branch">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							    		<div class="form-group">
  							    			<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="cmbgrnretlocation">Location</label>
  							    			<div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
  							    				<select name="cmbgrnretlocation" id="cmbgrnretlocation" class="form-control" data-type="location">
  							    					<option value="">--Select--</option>
  							    				</select>
  							    			</div>
  							    		</div>
  							     		<div class="form-group form-group-w">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="grnretvendor">Vendor</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input type="text" name="grnretvendor" id="grnretvendor" class="form-control" onkeyup="funFilterList(this);" data-type="vendor">
		                                   		<span class="help-block" style="color:red;"></span>
		                                   		<ul class="searchlist list-group" data-type="vendor">	  										
												</ul>
		                                    </div>
		                                </div> 
		                                <div class="form-group form-group-w">
		                                	<label class="col-xs-12 col-sm-2 col-md-2 col-lg-2 control-label" for="grnretgrn">GRN #</label>
		                                    <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
		                                   		<input type="text" name="grnretgrn" id="grnretgrn" class="form-control" onkeyup="funFilterList(this);" data-type="grn">
		                                   		<span class="help-block" style="color:red;"></span>
		                                   		<ul class="searchlist list-group" data-type="grn">	  										
												</ul>
		                                    </div>
		                                </div> 
		                             	<div class="form-group">
		                                    <label for="servdesc" class="col-md-2 control-label">Description</label>
		                                    <div class="col-xs-10">
		                                        <input type="text" class="form-control validate" name="grnretdesc" placeholder="Details" id="grnretdesc" data-max="250" data-type="desc">
		                                        <span class="help-block" style="color:red;"></span>
		                                	</div>
		                            	</div>
    						   		</div>
    						</div>
    						<%-- <h4><strong>Item Details</strong></h4> --%>
  							<div class="table-responsive hidden">
  								<table class="table table-hover" width="100% "  >   
							   		<tr>
							  			<td width="15% " class="nchngelmnt">
							  				<div class="form-group form-group-w">
							  					<label class="col-md-2 control-label">ProductID</label>
								   				<input type="text" class="form-control" id="grnretprdid" list="grnretproductid"  style="text-align: left;width:96%" onkeyup="funFilterList(this);">
								   				<span class="help-block" style="color:red;"></span>
								   				<ul class="searchlist list-group" data-type="productid" style="max-height:300px;overflow-y:auto;">	  										
												</ul>
							  				</div>
							  			</td>
							   			<td width="40% " class="nchngelmnt">
							   				<div class="form-group form-group-w">
							   					<label class="col-md-2 control-label">ProductName</label>
								   				<input type="text" class="form-control" id="grnretprdname" list="grnretprdts" style="text-align: left;width:96%" onkeyup="funFilterList(this);">
								   				<span class="help-block" style="color:red;"></span>
								   				<ul class="searchlist list-group" data-type="productname" style="max-height:300px;overflow-y:auto;">		
												</ul>
							   				</div>
							  			</td>
							   			<td width="30% " class="nchngelmnt">
							   				<label class="col-md-2 control-label">Barcode</label>
							   				<input type="text" class="form-control" name="grnretbrand" id="grnretbrand" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="5% " class="chngelmnt">
							   				<label class="col-md-2 control-label">Unit</label>
							   				<input type="text" class="form-control" name="grnretunit" id="grnretunit" style="text-align: left;width:96%" readonly>
							  			</td>
							   			<td width="10% "class="chngelmnt">
							   				<label class="col-md-2 control-label">Quantity</label>
							   				<input type="text" class="form-control" name="grnretqty" id="grnretqty" style="text-align: right;width:96%" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);" >
							  			</td>
							   			<td class="dchngelmnt"><br>
							   				<button id="btnGRNRETAdd" type="button" class="btn btn-default btn-success" >ADD</button>
							   			</td>
							   		</tr>
							    </table>
  							</div>
  							
  							<div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
								<div class="panel-body no-border">
									<table class="table table-hover" id="tblgrnret" data-type="detail">
	  									<thead>       
	  										<tr>
	  											<th>&nbsp;</th>
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
	    						      			<button type="button" class="btn btn-default btn-outline-primary btncreategrnret"><i class="fa fa-floppy-o m-r-5"></i>Create Goods Reciept Note Return</button>
	    						     			<button id="btnsorclear" type="button" class="btn btn-default m-r-5"  data-type="clear">Clear</button>
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
										<th>Barcode</th>
										<th>JDE No</th>
										<!-- <th>Client Detail</th> -->
										<th>BH No</th>
										<th>Qty</th>
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
	
  	</form>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="../vendors/sweetalert/sweetalert2.all.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script src="js/qrcode-scanner.js"></script>
    <script type="text/javascript">     
    	
    	function docReady(fn) {
    // see if DOM is already available
    if (document.readyState === "complete" || document.readyState === "interactive") {
        // call on next available tick
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
} 

docReady(function() {
    var resultContainer = document.getElementById('qr-reader-results');
    var lastResult, countResults = 0;
    
    /*var html5QrcodeScanner = new Html5QrcodeScanner(
        "qr-reader", { fps: 10, qrbox: 250 },
        experimentalFeatures: {
			useBarCodeDetectorIfSupported: true
        },
        rememberLastUsedCamera: true);*/
    let html5QrcodeScanner = new Html5QrcodeScanner(
        "qr-reader", 
        { 
            fps: 10, qrbox: 250,
            experimentalFeatures: {
                useBarCodeDetectorIfSupported: true
            },
            rememberLastUsedCamera: true
        });
    function onScanSuccess(decodedText, decodedResult) {
        if (decodedText !== lastResult) {
            ++countResults;
            lastResult = decodedText;
            //console.log(`Scan result = ${decodedText}`, decodedResult);
 			$('.tab-pane.fade.in.active').find('button[data-type="btnmodalscan"]').parent().parent().closest('.input-group').find('input.form-control').val(decodedText);
 			$('.tab-pane.fade.in.active').find('button[data-type="btnmodalscan"]').parent().parent().closest('.input-group').find('input.form-control').click();
 			
            //resultContainer.innerHTML += `<div>[${countResults}] - ${decodedText}</div>`;
            
            // Optional: To close the QR code scannign after the result is found
            html5QrcodeScanner.clear();
            $('#modalscan').modal('hide');
        }
    }
    
    // Optional callback for error, can be ignored.
    function onScanError(qrCodeError) {
        // This callback would be called in case of qr code scan error or setup error.
        // You can avoid this callback completely, as it can be very verbose in nature.
    }
    
    html5QrcodeScanner.render(onScanSuccess, onScanError);
});
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
		
		function funClearData(){
			$('.tab-pane.fade.in.active').find('select').val('');
			$('.tab-pane.fade.in.active').find('input').val('');
			$('.tab-pane.fade.in.active').find('table[data-type="detail"] tbody').html('');
			funInitData();
			return false;
		}
		$(document).ready(function(){
 			checkWindowWidth();
 			$('[data-toggle="tooltip"]').tooltip(); 
 			funInitData();
 			$('.searchlist').hide();
 			$('.page-loader').hide();
 			$('.tab-pane.fade.in.active').find('input[data-type="desc"]').change(function(){
 				var maxchars=$(this).attr('data-max');
 				if(parseInt($(this).val().length)>parseInt(maxchars)){
 					$(this).closest('div').find('span.help-block').text('Max '+maxchars+' chars');
 					return false;
 				}
 				else{
 					$(this).closest('div').find('span.help-block').text('');
 				}
 			});
 			$('button[data-type="btnmodalscan"]').click(function(){
 				$(this).parent().parent().find('input.form-control').click();
 				$('#modalscan').modal('show');
 			});
 			$('.tab-pane.fade.in.active').find('button[data-type="clear"]').click(function(){
 				funClearData();
 			});
 			$('.form-group-w').find('input.form-control').click(function(){
 				$('.searchlist').hide();
 				var searchtype=$(this).parent().find('.searchlist').attr('data-type');
				var customer=$('.tab-pane.in.active').find('input[data-type="customer"]').val();
				var vendor=$('.tab-pane.in.active').find('input[data-type="vendor"]').val();
				var location=$('.tab-pane.in.active').find('select[data-type="location"]').val();
				if((searchtype=='productid' || searchtype=='productname') && customer==''){
					$('.tab-pane.in.active').find('input[data-type="customer"]').closest('.form-group').find('span.help-block').text('Mandatory');
					return false;
				}
				else if((searchtype=='delnote') && customer==''){
					$('.tab-pane.in.active').find('input[data-type="customer"]').closest('.form-group').find('span.help-block').text('Mandatory');
					return false;
				}
				else if((searchtype=='delnote') && location==''){
					$('.tab-pane.in.active').find('select[data-type="location"]').closest('.form-group').find('span.help-block').text('Mandatory');
					return false;
				}
				else{
					$('.tab-pane.in.active').find('input[data-type="customer"]').closest('.form-group').find('span.help-block').text('');
					if($(this).parent().find('.searchlist').length==0){
						$(this).parent().parent().find('.searchlist').show();
					}
					else{
						$(this).parent().find('.searchlist').show();
					}
				}
 				/*if($(this).parent().find('.searchlist').is(':visible')){
 					
 				}
 				else{
 					
 				}*/
 				return false;
 			});
 			
 			//Adding Items to Table
 			$('#btnGRNAdd').click(function(){
 				if($('#grnprdid').val()==''){
					$('#grnprdid').closest('.form-group').find('span.help-block').text('Mandatory');
					return false;
				}
				else{
					$('#grnprdid').closest('.form-group').find('span.help-block').text('');
					
				}
				var htmldata='';
				var partno=$('#grnprdid').val();
				var productname=$('#grnprdname').val();
				var brandname=$('#grnbrand').val();
				var unit=$('#grnunit').val();
				var doc_no=$('#grnprdid').attr('data-doc_no');
				var psrno=$('#grnprdid').attr('data-psrno');
				var munit=$('#grnprdid').attr('data-munit');
				var qty=$('#grnqty').val();
				var specid=$('#grnprdid').attr('data-specid');
				
				htmldata+='<tr>';
				htmldata+='<td data-name="partno">'+partno+'</td>';
				htmldata+='<td data-name="productname">'+productname+'</td>';
				htmldata+='<td data-name="brandname">'+brandname+'</td>';
				htmldata+='<td data-name="unit">'+unit+'</td>';
				htmldata+='<td data-name="qty">'+qty+'</td>';
				htmldata+='<td class="hidden" data-name="psrno">'+psrno+'</td>';
				htmldata+='<td class="hidden" data-name="doc_no">'+doc_no+'</td>';
				htmldata+='<td class="hidden" data-name="munit">'+munit+'</td>';
				htmldata+='<td class="hidden" data-name="specid">'+specid+'</td>';
				htmldata+='</tr>';
				$('#tblgrn tbody').append($.parseHTML(htmldata));
				$('#grnprdid,#grnprdname,#grnbrand,#grnunit,#grnqty,#psrno,#unitdoc,#specid').val('');
				$('#grnprdid').focus();
 			});
 			$('.btncreategrn').click(function(){
 				var activerow=$('#tblgrn tbody tr').length;
				if(activerow==0){
					Swal.fire({
						icon: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				else{
					var desc=$('#grndesc').val();
					if(parseInt(desc.length)>=parseInt($('#grndesc').attr('data-max'))){
						var maxchars=$('#grndesc').attr('data-max');
						$('#grndesc').closest('div').find('span.help-block').text('Max '+maxchars+' Chars');
						return false;
					}
					else{
						$('#grndesc').closest('div').find('span.help-block').text('');
					}
					if($('#grnvendor').val()==''){
						$('#grnvendor').closest('div').find('span.help-block').text('Mandatory');
						return false;
					}
					else{
						$('#grnvendor').closest('div').find('span.help-block').text('');
					}
					Swal.fire({
						title: 'Are you sure?',
					  	text: "Do you want to create GRN!",
					  	icon: 'warning',
					  	showCancelButton: true,
					  	confirmButtonColor: '#3085d6',
					  	cancelButtonColor: '#d33',
					  	confirmButtonText: 'Yes'
					}).then((result) => {
						if (result.isConfirmed) {
					   		var branchdocno=$('.tab-pane.fade.in.active').find('select[data-type="branch"]').val();
							var locationdocno=$('.tab-pane.fade.in.active').find('select[data-type="location"]').val();
							var vendordocno=$('.tab-pane.fade.in.active').find('input[data-type="vendor"]').attr('data-docno');
							
							var grnarray=new Array();
							/*newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
								   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+rows[i].unitprice+" ::"+rows[i].discount+" ::"+rows[i].disper+" :: ");*/
							$('#tblgrn tbody tr').each(function(){
								var psrno=$(this).find('td[data-name="psrno"]').html();
								var prodoc=$(this).find('td[data-name="doc_no"]').html();
								var unitdocno=$(this).find('td[data-name="munit"]').html();
								var qty=$(this).find('td[data-name="qty"]').html();
								var saveqty=$(this).find('td[data-name="qty"]').html();
								var checktype=0;//$(this).find('td[data-name="psrno"]').html();
								var specid=$(this).find('td[data-name="specid"]').html();
								var foc=0;//$(this).find('td[data-name="psrno"]').html();
								var unitprice=0;//$(this).find('td[data-name="psrno"]').html();
								var discount=0;//$(this).find('td[data-name="psrno"]').html();
								var disper=0;//$(this).find('td[data-name="psrno"]').html();
								grnarray.push(psrno+"::"+prodoc+" :: "+unitdocno+" :: "+qty+" :: "  
								   +saveqty+" :: "+checktype+" :: "+specid+" :: "+foc+" ::"+unitprice+" ::"+discount+" ::"+disper+" :: ");
							});
							$.post('createGRN.jsp',{'grnarray[]':grnarray,'desc':desc,'branch':branchdocno,'location':locationdocno,'vendor':vendordocno},function(data,status){
								data=JSON.parse(data);
								if(data.errorstatus=="0"){
									Swal.fire({
										icon: 'success',
									  	title: 'Success',
									  	text: 'Successfully created GRN '+data.grndocno        
									});
									funClearData();
								}
								else{
									Swal.fire({
										icon: 'warning',
									  	title: 'Warning',
									  	text: 'Not Saved'
									});
									return false;
								}
							}); 
					  	}
					});
				}
 			});
 			$('#btnDelAdd').click(function(){
				if($('#delprdid').val()==''){
					$('#delprdid').closest('.form-group').find('span.help-block').text('Mandatory');
					return false;
				}
				else{
					$('#delprdid').closest('.form-group').find('span.help-block').text('');
					
				}
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
				var contracttablehtml='<tr>';					   
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
				$('#delprdid,#delprdname,#delbrand,#delunit,#delqty,#psrno,#unitdoc,#specid').val('');
				$('#delprdid').focus();
				
 			});
 			$('.btncreategrnret').click(function(){
 				var activerow=$('#tblgrnret tbody tr td input[type="checkbox"]:checked').closest('tr').length;
				if(activerow==0){
					Swal.fire({
						icon: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				else{
					var grnretarray=new Array();
					$("#tblgrnret tbody tr").each(function(){
						if($(this).find('td:first input[type="checkbox"]').is(':checked')){
							grnretarray.push($(this).find('td[data-name="psrno"]').html()+"::"+$(this).find('td[data-name="prodoc"]').html()+" :: "+$(this).find('td[data-name="unitdocno"]').html()+" :: "+$(this).find('td[data-name="qty"]').html()+" :: "+$(this).find('td[data-name="saveqty"]').html()+" :: "+$(this).find('td[data-name="checktype"]').html()+" :: "+
			  				$(this).find('td[data-name="specid"]').html()+" :: "+$(this).find('td[data-name="foc"]').html()+" :: "+$(this).find('td[data-name="stockid"]').html()+" :: "+$(this).find('td[data-name="oldqty"]').html()+" :: "+$(this).find('td[data-name="oldfoc"]').html()+" :: ");
						}
						
					});
					var cldocno=$('.tab-pane.in.active').find('input[data-type="vendor"]').attr('data-docno');
					var grndocno=$('.tab-pane.in.active').find('input[data-type="grn"]').attr('data-docno');
					var branch=$('.tab-pane.in.active').find('select[data-type="branch"]').val();
					var location=$('.tab-pane.in.active').find('select[data-type="location"]').val();
					$.post('createGRNReturn.jsp',{'grnarray[]':grnretarray,'branch':branch,'location':location,'vendor':cldocno,'grndocno':grndocno},function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=="0"){
							Swal.fire({
								icon: 'Success',
							  	title: 'Success',
							  	text: 'Successfully created GRN Return '+data.grnretdocno        
							});	
							funClearData();
						}
						else{
							Swal.fire({
								icon: 'warning',
							  	title: 'warning',
							  	text: 'Not Saved'        
							});
							return false;
						}
					});
				}
 			});
 			$('.btncreatedelret').click(function(){
 				var activerow=$('#tbldelret tbody tr td input[type="checkbox"]:checked').closest('tr').length;
				if(activerow==0){
					Swal.fire({
						icon: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				if($('.tab-pane.fade.in.active').find('input[data-type="customer"]').val()==''){
					$('.tab-pane.fade.in.active').find('input[data-type="customer"]').closest('div').find('span.help-block').text('Mandatory');
					return false;
				}
				else{
					$('.tab-pane.fade.in.active').find('input[data-type="customer"]').closest('div').find('span.help-block').text('');
				}
				if($('.tab-pane.fade.in.active').find('input[data-type="delnote"]').val()==''){
					$('.tab-pane.fade.in.active').find('input[data-type="delnote"]').closest('div').find('span.help-block').text('Mandatory');
					return false;
				}
				else{
					$('.tab-pane.fade.in.active').find('input[data-type="delnote"]').closest('div').find('span.help-block').text('');
				}
				if(parseInt($('.tab-pane.fade.in.active').find('input[data-type="desc"]').val().length)>parseInt($('.tab-pane.fade.in.active').find('input[data-type="desc"]').attr('data-max'))){
					var maxchars=$('.tab-pane.fade.in.active').find('input[data-type="desc"]').attr('data-max');
					$('.tab-pane.fade.in.active').find('input[data-type="desc"]').closest('div').find('span.help-block').text('Max '+maxchars+' Chars Only');
					return false;
				}
				else{
					$('.tab-pane.fade.in.active').find('input[data-type="desc"]').closest('div').find('span.help-block').text('');
				}
				
				
					var deldocno=$('.tab-pane.in.active').find('input[data-type="delnote"]').attr('data-docno');
					Swal.fire({
						title: 'Are you sure?',
						text: "Do you want to create Del.Note Return "+deldocno,
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33',
						confirmButtonText: 'Yes'
					}).then((result) => {
						if (result.isConfirmed) {
							var delretarray=new Array();
							$("#tbldelret tbody tr").each(function(){
								if($(this).find('td:first input[type="checkbox"]').is(':checked')){
									delretarray.push($(this).find('td[data-name="prodoc"]').html()+"::"+$(this).find('td[data-name="unitdocno"]').html()+"::"+$(this).find('td[data-name="qty"]').html()+"::"+$(this).find('td[data-name="totwtkg"]').html()+"::"+$(this).find('td[data-name="kgprice"]').html()+"::"+$(this).find('td[data-name="unitprice"]').html()+"::"+
					  				$(this).find('td[data-name="total"]').html()+"::"+$(this).find('td[data-name="discper"]').html()+"::"+$(this).find('td[data-name="dis"]').html()+"::"+$(this).find('td[data-name="netotal"]').html()+"::"+$(this).find('td[data-name="specid"]').html()+"::"+$(this).find('td[data-name="outqty"]').html()+"::"+$(this).find('td[data-name="stkid"]').html()+"::"+$(this).find('td[data-name="oldqty"]').html()+"::"+$(this).find('td[data-name="rdocno"]').html()+"::"+0);	
								}
								
							});
							console.log(delretarray);
							var cldocno=$('.tab-pane.in.active').find('input[data-type="customer"]').attr('data-docno');
							
							var branch=$('.tab-pane.in.active').find('select[data-type="branch"]').val();
							var location=$('.tab-pane.in.active').find('select[data-type="location"]').val();
							$.post('saveDelNoteReturn.jsp',{'retarray[]':delretarray,'branch':branch,'location':location,'cldocno':cldocno,'deldocno':deldocno},function(data,status){
								data=JSON.parse(data);
								if(data.errorstatus=="0"){
									Swal.fire({
										icon: 'Success',
									  	title: 'Success',
									  	text: 'Successfully created Del.Note Return '+data.retdoc        
									});	
									funClearData();
								}
								else{
									Swal.fire({
										icon: 'warning',
									  	title: 'warning',
									  	text: 'Not Saved'        
									});
									return false;
								}
							});							
						}
					});
 			});
 			$('.btncreatedel').click(function(){
    			
    			var activerow=$('#tbldel tbody tr').length;
				if(activerow==0){
					Swal.fire({
						icon: 'warning',
					  	title: 'Not Valid',
					  	text: 'Please select a document!'        
					});
					return false;
				}
				if(parseInt($('#deldesc').val().length)>parseInt($('#deldesc').attr('data-max'))){
					var maxchars=$('#deldesc').attr('data-max');
					$('#deldesc').closest('div').find('span.help-block').text('Max '+maxchars);
					return false;
				}
				else{
					$('#deldesc').closest('div').find('span.help-block').text('');
				}
				Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to create Delivery Note!",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
				}).then((result) => {
					if (result.isConfirmed) {
						var prodArray= new Array();
	   					var price=0,total=0,dis=0,discnt=0,netamnt=0;
	   					$("#tbldel tbody tr").each(function(){
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
	   	   				
	   	   				var clinetid=$('.tab-pane.in.active').find('input[data-type="customer"]').attr('data-docno');
	    				var locid=$('.tab-pane.fade.in.active').find('select[data-type="location"]').val();
	    				var frmtype="DEL";
	            		var vatype=$("#hidvatype").val();
	            		var desc=$("#deldesc").val();
	            		var cur=$('.tab-pane.in.active').find('input[data-type="customer"]').attr('data-curid');
	            		var rate=$('.tab-pane.in.active').find('input[data-type="customer"]').attr('data-rate');
	            		//$("#cmbdelnotelocation").val();
	            		var sordoc=0;
	            		//$("#rrefno").val();
	            		var reftype='DIR';
	            		//$("#cmbreftype").val();
	            		var brhid=$('.tab-pane.fade.in.active').find('select[data-type="branch"]').val();
	            		//$("#cmbdelnotebranch").val();
	            		var userid='';
	            		//$("#hiduserid").val();
	        			var x=new XMLHttpRequest();
	        			x.onreadystatechange=function(){
	        				if (x.readyState==4 && x.status==200){
	        					var items=x.responseText.trim();
	     				 		var item = items.split('::');
	     				 		var method=item[0];
	     			      		var aa=item[1];
	        					if(parseInt(method)>0){
		        					Swal.fire({
			     	   					icon: 'success',
			     	   				  	title: 'Success',  
			     	   				  	text: 'Delivery Note '+aa+' Successfully Created'
			     	   				});
			     	   				funClearData();
	        					}else{
	     	   						Swal.fire({
	     	   							icon: 'error',
	     	   				  			title: 'Error',     
	     	   				  			text: 'Not Created'
	     	   						});    
	        					}       
	        				}       
	        			}
	              		x.open("GET","saveData.jsp?prodArray="+encodeURIComponent(prodArray)+"&clinetid="+clinetid+"&vatype="+vatype+"&desc="+desc+"&cur="+cur+"&rate="+rate+"&frmtype="+frmtype+"&locid="+locid+"&sordoc="+sordoc+"&reftype="+reftype+"&brhid="+brhid+"&userid="+userid,true);		
	        	  		x.send();		
					}
				});
    		});
 		});
 		
 		function funInitData(){
 			$.get('getInitData.jsp',function(data){
 				data=JSON.parse(data);
 				var htmldata='';
 				$.each(data.stockdata, function( index, value ) {   
  					htmldata+='<tr>';
  					htmldata+='<td align="center">'+value.srno+'</td>';   
  					htmldata+='<td>'+value.productid+'</td>';
  					htmldata+='<td>'+value.productname+'</td>';
  					htmldata+='<td>'+value.brandname+'</td>';
  					htmldata+='<td>'+value.jdeno+'</td>';
  					htmldata+='<td>'+value.bhno+'</td>';  
  					htmldata+='<td>'+value.qty+'</td>'; 
  					htmldata+='</tr>';     
  				});
  				$('#tblstocklist tbody').html($.parseHTML(htmldata));  
  			   	htmldata='';
 				$.each(data.customerdata,function(index,value){
 					htmldata+='<li class="list-group-item" ><a href="#" data-docno="'+value.docno+'" data-curid="'+value.curid+'" data-rate="'+value.rate+'">'+value.refname+'</a></li>';
 				});
 				$('.searchlist[data-type="customer"]').html($.parseHTML(htmldata));
 				htmldata='';
 				$.each(data.vendordata,function(index,value){
 					htmldata+='<li class="list-group-item" ><a href="#" data-docno="'+value.docno+'" data-curid="'+value.curid+'" data-rate="'+value.rate+'">'+value.refname+'</a></li>';
 				});
 				$('.searchlist[data-type="vendor"]').html($.parseHTML(htmldata));
 				
 				$('.searchlist li a').on('click',function(){
 					const mainparent=$(this).parent().parent().parent();
			    	var searchtype=$(mainparent).find('.searchlist').attr('data-type');
			    	var valuetext=$(this).text();
			    	var value=$(this).attr('data-docno');
			    	if(searchtype=='customer'){
			    		$(mainparent).find('input.form-control').val(valuetext);
			    		$(mainparent).find('input.form-control').attr('data-docno',value);
			    		$(mainparent).find('input.form-control').attr('data-curid',$(this).attr('data-curid'));
			    		$(mainparent).find('input.form-control').attr('data-rate',$(this).attr('data-rate'));
			    		getProduct($('#delprdname').closest('.form-group').find('.searchlist'));
			    		getProductID($('#delprdid').closest('.input-group').parent().find('.searchlist'));
			    		if($('.tab-pane.fade.in.active').attr('id')=='menudelnoteret'){
			    			getDeliveryNotes($('.tab-pane.fade.in.active').find('.searchlist[data-type="delnote"]'));
			    		}
			    	}
			    	if(searchtype=='vendor'){
			    		$(mainparent).find('input.form-control').val(valuetext);
			    		$(mainparent).find('input.form-control').attr('data-docno',value);
			    		$(mainparent).find('input.form-control').attr('data-curid',$(this).attr('data-curid'));
			    		$(mainparent).find('input.form-control').attr('data-rate',$(this).attr('data-rate'));
			    		
			    		if($('.tab-pane.fade.in.active').attr('id')=='menugrnret'){
			    			getGRN($('.tab-pane.fade.in.active').find('.searchlist[data-type="grn"]'));
			    		}
			    		
			    	}
			    	$(this).closest('.searchlist').hide();
			    	return false;
			    });	
 				htmldata='';
 				$.each(data.branchdata,function(index,value){
  					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
  				});
  				$('select[data-type="branch"]').html($.parseHTML(htmldata));
  				htmldata='';
  				var tempbranchdocno=$('select[data-type="branch"]').val();
  				getGRNProduct();
				var tempElmLoc=$('select[data-type="location"]');
				$.get('locationset.jsp',{'brhid':tempbranchdocno},function(data){
					data=JSON.parse(data.split("###")[2]);
					htmldata='';
					$.each(data.locdata,function(index,value){
						htmldata+='<option value="'+value.docno+'">'+value.location+'</option>';
					});
					$(tempElmLoc).html($.parseHTML(htmldata));
				});
  				$('select[data-type="branch"]').each(function(){
  					$(this).change(function(){
  						var branchdocno=$(this).val();
  						getGRNProduct();
  						var elmLoc=$(this).closest('.row').find('select[data-type="location"]');
  						$.get('locationset.jsp',{'brhid':branchdocno},function(data){
  							data=JSON.parse(data.split("###")[2]);
  							htmldata='';
  							$.each(data.locdata,function(index,value){
  								htmldata+='<option value="'+value.docno+'">'+value.location+'</option>';
  							});
  							$(elmLoc).html($.parseHTML(htmldata));
  						});
  					});
  				});
 			});
 		}
 		function getGRNProduct(){
 			var branchdocno=$('.tab-pane.fade.in.active').find('select[data-type="branch"]').val();
 			$.get('getGRNProduct.jsp',{'branch':branchdocno},function(data){
 				data=JSON.parse(data);
 				var htmldata1='',htmldata2='';
 				$.each(data.grnproduct,function(index,value){
 					htmldata1+='<li class="list-group-item"><a href="#" data-specid="'+value.specid+'" data-method="'+value.method+'" data-brandname="'+value.brandname+'" data-part_no="'+value.part_no+'" data-productname="'+value.productname+'" data-doc_no="'+value.doc_no+'" data-unit="'+value.unit+'" data-munit="'+value.munit+'" data-psrno="'+value.psrno+'">'+value.part_no+'</a></li>';
 					htmldata2+='<li class="list-group-item"><a href="#" data-specid="'+value.specid+'" data-method="'+value.method+'" data-brandname="'+value.brandname+'" data-part_no="'+value.part_no+'" data-productname="'+value.productname+'" data-doc_no="'+value.doc_no+'" data-unit="'+value.unit+'" data-munit="'+value.munit+'" data-psrno="'+value.psrno+'">'+value.productname+'</a></li>';
 				});
 				$('#grnprdname').closest('.form-group').find('.searchlist').html($.parseHTML(htmldata2));
 				$('#grnprdid').closest('.form-group').find('.searchlist').html($.parseHTML(htmldata1));
 				
 				$('#grnprdname,#grnprdid').closest('.form-group').find('.searchlist').find('li a').on('click',function(){
 					$('#grnprdid').val($(this).attr('data-part_no'));
 					$('#grnprdname').val($(this).attr('data-productname'));
 					$('#grnbrand').val($(this).attr('data-brandname'));
 					$('#grnunit').val($(this).attr('data-unit'));
 					var method=$(this).attr('data-method');
 					var munit=$(this).attr('data-munit');
 					var doc_no=$(this).attr('data-doc_no');
 					var psrno=$(this).attr('data-psrno');
 					var specid=$(this).attr('data-specid');
 					var brandname=$(this).attr('data-brandname');
 					$('#grnprdid').attr('data-method',method);
 					$('#grnprdid').attr('data-munit',munit);
 					$('#grnprdid').attr('data-doc_no',doc_no);
 					$('#grnprdid').attr('data-psrno',psrno);
 					$('#grnprdid').attr('data-brandname',brandname);
 					$('#grnprdid').attr('data-specid',specid);
 					
 					$(this).closest('.searchlist').hide();
			    	return false;
 				});
 			});
 		}
 		function getGRN(elm){
 			var branchdocno=$('.tab-pane.fade.in.active').find('select[data-type="branch"]').val();
 			var locationdocno=$('.tab-pane.fade.in.active').find('select[data-type="location"]').val();
 			var vendordocno=$('.tab-pane.fade.in.active').find('input[data-type="vendor"]').attr('data-docno');
 			$.get('getInitData.jsp',{'filtertype':'grn','branch':branchdocno,'location':locationdocno,'cldocno':vendordocno},function(data){
 				data=JSON.parse(data);
 				var htmldata='';
 				$.each(data.grndata,function(index,value){
 					htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'">'+value.docno+' '+value.date+'</a></li>';
 				});
 				$(elm).html($.parseHTML(htmldata));
 				$('.searchlist li a').on('click',function(){
 					const mainparent=$(this).parent().parent().parent();
			    	var searchtype=$(mainparent).find('.searchlist').attr('data-type');
			    	var valuetext=$(this).text();
			    	var value=$(this).attr('data-docno');
			    	if(searchtype=='grn'){
			    		$(mainparent).find('input.form-control').val(value);
			    		$(mainparent).find('input.form-control').attr('data-docno',value);
			    		loadGRN(value);
			    	}
			    	$(this).closest('.searchlist').hide();
			    	return false;
			    });	
 			});
 		}
 		function getDeliveryNotes(elm){
 			var branchdocno=$('.tab-pane.fade.in.active').find('select[data-type="branch"]').val();
 			var locationdocno=$('.tab-pane.fade.in.active').find('select[data-type="location"]').val();
 			var customerdocno=$('.tab-pane.fade.in.active').find('input[data-type="customer"]').attr('data-docno');
 			$.get('getInitData.jsp',{'filtertype':'delnote','branch':branchdocno,'location':locationdocno,'cldocno':customerdocno},function(data){
 				data=JSON.parse(data);
 				var htmldata='';
 				$.each(data.delnotedata,function(index,value){
 					htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'">'+value.docno+' '+value.date+'</a></li>';
 				});
 				$(elm).html($.parseHTML(htmldata));
 				$('.searchlist li a').on('click',function(){
 					const mainparent=$(this).parent().parent().parent();
			    	var searchtype=$(mainparent).find('.searchlist').attr('data-type');
			    	var valuetext=$(this).text();
			    	var value=$(this).attr('data-docno');
			    	if(searchtype=='delnote'){
			    		$(mainparent).find('input.form-control').val(value);
			    		$(mainparent).find('input.form-control').attr('data-docno',value);
			    		loadDelNote(value);
			    	}
			    	$(this).closest('.searchlist').hide();
			    	return false;
			    });	
 			});
 		}
 		function loadGRN(value){
 			var branchdocno=$('.tab-pane.fade.in.active').find('select[data-type="branch"]').val();
 			var locationdocno=$('.tab-pane.fade.in.active').find('select[data-type="location"]').val();
 			$.get('getGRNRows.jsp',{'grndocno':value,'branch':branchdocno,'location':locationdocno},function(data){
 				data=JSON.parse(data);
 				var htmldata='';
 				$.each(data.grnrowdata,function(index,value){
 					htmldata+='<tr>';
 					htmldata+='<td><div class="checkbox-inline"><label><input type="checkbox" value="" checked></label></div></td>';
 					htmldata+='<td data-name="productid" >'+value.productid+'</td>';
 					htmldata+='<td data-name="productname" >'+value.productname+'</td>';
 					htmldata+='<td data-name="brandname">'+value.brandname+'</td>';
 					htmldata+='<td data-name="unit" >'+value.unit+'</td>';
 					htmldata+='<td data-name="qty">'+value.qty+'</td>'; 	
 					htmldata+='<td data-name="checktype" class="hidden">'+value.checktype+'</td>';
 					htmldata+='<td data-name="stockid" class="hidden">'+value.stockid+'</td>';
 					htmldata+='<td data-name="specid" class="hidden">'+value.specid+'</td>';
 					
 					
 					htmldata+='<td data-name="proid" class="hidden">'+value.proid+'</td>';
 					htmldata+='<td data-name="mainqty" class="hidden">'+value.mainqty+'</td>';
 					htmldata+='<td data-name="maxfoc" class="hidden">'+value.maxfoc+'</td>';
 					htmldata+='<td data-name="foc" class="hidden">'+value.foc+'</td>';
 					htmldata+='<td data-name="pqty" class="hidden">'+value.pqty+'</td>';
 					htmldata+='<td data-name="proname" class="hidden">'+value.proname+'</td>';
 					htmldata+='<td data-name="sr_no" class="hidden">'+value.sr_no+'</td>';
 					htmldata+='<td data-name="psrno" class="hidden">'+value.psrno+'</td>';
 					htmldata+='<td data-name="prodoc" class="hidden">'+value.prodoc+'</td>'; 					
 					
 					htmldata+='<td data-name="unitdocno" class="hidden">'+value.unitdocno+'</td>';
 									
 					htmldata+='<td data-name="qutval" class="hidden">'+value.qutval+'</td>';
 					htmldata+='<td data-name="saveqty" class="hidden">'+value.saveqty+'</td>';
 					htmldata+='</tr>';
 				});
 				$('#tblgrnret tbody').html($.parseHTML(htmldata));
 				
 			});
 		}
 		function loadDelNote(value){
 			var branchdocno=$('.tab-pane.fade.in.active').find('select[data-type="branch"]').val();
 			var locationdocno=$('.tab-pane.fade.in.active').find('select[data-type="location"]').val();
 			$.get('getDelNoteRows.jsp',{'delnotedocno':value,'branch':branchdocno,'location':locationdocno},function(data){
 				data=JSON.parse(data);
 				var htmldata='';
 				$.each(data.delnoterowdata,function(index,value){
 					htmldata+='<tr>';
 					htmldata+='<td><div class="checkbox-inline"><label><input type="checkbox" value="" checked></label></div></td>';
 					htmldata+='<td data-name="part_no">'+value.part_no+'</td>';
 					htmldata+='<td data-name="productname">'+value.productname+'</td>';
 					htmldata+='<td data-name="brandname">'+value.brandname+'</td>';
 					htmldata+='<td data-name="unit">'+value.unit+'</td>';
 					htmldata+='<td data-name="stkid" class="hidden">'+value.stkid+'</td>';
 					htmldata+='<td data-name="specid" class="hidden">'+value.specid+'</td>';
 					htmldata+='<td data-name="doc_no" class="hidden">'+value.doc_no+'</td>';
 					htmldata+='<td data-name="rdocno" class="hidden">'+value.rdocno+'</td>';
 					htmldata+='<td data-name="psrno" class="hidden">'+value.psrno+'</td>';
 					htmldata+='<td data-name="prodoc" class="hidden">'+value.prodoc+'</td>';
 					htmldata+='<td data-name="totqty" class="hidden">'+value.totqty+'</td>';
 					htmldata+='<td data-name="oldqty" class="hidden">'+value.oldqty+'</td>';
 					htmldata+='<td data-name="qty" >'+value.qty+'</td>';
 					htmldata+='<td data-name="outqty" class="hidden">'+value.outqty+'</td>';
 					htmldata+='<td data-name="balqty" class="hidden">'+value.balqty+'</td>';
 					
 					htmldata+='<td data-name="productid" class="hidden">'+value.productid+'</td>';
 					htmldata+='<td data-name="proid" class="hidden">'+value.proid+'</td>';
 					
 					htmldata+='<td data-name="proname" class="hidden">'+value.proname+'</td>';
 					
 					htmldata+='<td data-name="unitdocno" class="hidden">'+value.unitdocno+'</td>';
 					htmldata+='<td data-name="totwtkg" class="hidden">'+value.totwtkg+'</td>';
 					htmldata+='<td data-name="kgprice" class="hidden">'+value.kgprice+'</td>';
 					htmldata+='<td data-name="unitprice" class="hidden">'+value.unitprice+'</td>';
 					htmldata+='<td data-name="total" class="hidden">'+value.total+'</td>';
 					htmldata+='<td data-name="discper" class="hidden">'+value.discper+'</td>';
 					htmldata+='<td data-name="dis" class="hidden">'+value.dis+'</td>';
 					htmldata+='<td data-name="netotal" class="hidden">'+value.netotal+'</td>';
 					htmldata+='</tr>';
 				});
 				$('#tbldelret tbody').html($.parseHTML(htmldata));
 				
 			});
 		}
 		function getProductID(elm) {
    		var clientid="",catid="";
            var brhid=$('.tab-pane.in.active').find('select[data-type="branch"]').val();
            var locid=$('.tab-pane.in.active').find('select[data-type="location"]').val();
           	clientid=$('.tab-pane.in.active').find('input[data-type="customer"]').attr('data-docno');
           	
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
						optionsyear += '<li class="list-group-item"><a href="#" data-prdname="'+prdname[i]+'" data-tax="'+tax[i]+'" data-unit="'+unit[i]+'"data-brand="'+brand[i]+'"data-psrno="'+psrno[i]+'"data-specid="'+specid[i]+'"data-unitdoc="'+unitdoc[i]+'"data-uprice="'+uprice[i]+'"data-taxdoc="'+taxdoc[i]+'">' + prdid[i] + '</a></li>';
					}
					
					$(elm).html($.parseHTML(optionsyear));
					$(elm).find('li a').on('click',function(){
						var prdname = $(this).attr('data-prdname');
			    		var tax = $(this).attr('data-tax')
			    		var unit = $(this).attr('data-unit');
			    		var brand = $(this).attr('data-brand');
			    		var psrno = $(this).attr('data-psrno')
			    		var specid = $(this).attr('data-specid');
			    		var unitdoc = $(this).attr('data-unitdoc');
			    		var uprice = $(this).attr('data-uprice')
			    		var taxdoc = $(this).attr('data-taxdoc');
			    		
			    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
			    		document.getElementById("delprdid").value=$(this).text();
			    		document.getElementById("delprdname").value=prdname;
			    		document.getElementById("delunit").value=unit;
			    		document.getElementById("delbrand").value=brand;
			    		document.getElementById("delunit").value=unit;
			    		
			    		document.getElementById("psrno").value=psrno;
			    		document.getElementById("unitdoc").value=unitdoc;
			    		document.getElementById("specid").value=specid;
			    		document.getElementById("taxdoc").value=taxdoc;
			    		document.getElementById("hidunitprice").value=uprice;
				    	$(this).closest('.searchlist').hide();
				    	return false;	
					});
					/*if(parseInt(chk)==1){
						$("datalist#productid").html(optionsyear);    
					}
					if(parseInt(chk)==2){
						$("datalist#delproductid").html(optionsyear);    
					} 
					if(parseInt(chk)==3){
						$("datalist#invproductid").html(optionsyear);    
					} */
				} else {
				}
			}
			x.open("GET", "getProduct.jsp?clientid="+clientid+"&clientcatid="+catid+"&brhid="+brhid+"&locid="+locid, true);
			x.send();
		}
		
		function getProduct(elm) {
			var brhid=$('.tab-pane.in.active').find('select[data-type="branch"]').val();
           	var clientid=$('.tab-pane.in.active').find('input[data-type="customer"]').attr('data-docno');
           	var locid=$('.tab-pane.in.active').find('select[data-type="location"]').val();
           	var catid="";
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
						optionsyear += '<li class="list-group-item" ><a href="#" data-prdid="'+prdid[i]+'" data-tax="'+tax[i]+'" data-unit="'+unit[i]+'"data-brand="'+brand[i]+'"data-psrno="'+psrno[i]+'"data-specid="'+specid[i]+'"data-unitdoc="'+unitdoc[i]+'"data-uprice="'+uprice[i]+'"data-taxdoc="'+taxdoc[i]+'">' + prdname[i] + '</a></li>';
					}
					/*if(parseInt(chk)==1){
						$("datalist#prdts").html(optionsyear);    
					}
					if(parseInt(chk)==2){
						$("datalist#delprdts").html(optionsyear);    
					} 
					if(parseInt(chk)==3){
						$("datalist#invprdts").html(optionsyear);    
					}*/
					
					$(elm).html($.parseHTML(optionsyear));
					$(elm).find('li a').on('click',function(){
						var prdname = $(this).text();
			    		var tax = $(this).attr('data-tax');
			    		var unit = $(this).attr('data-unit');
			    		var brand = $(this).attr('data-brand');
			    		var psrno = $(this).attr('data-psrno')
			    		var specid = $(this).attr('data-specid');
			    		var unitdoc = $(this).attr('data-unitdoc');
			    		var uprice = $(this).attr('data-uprice')
			    		var taxdoc = $(this).attr('data-taxdoc');
			    		
			    		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
			    		document.getElementById("delprdid").value=$(this).attr('data-prdid');
			    		document.getElementById("delprdname").value=prdname;
			    		document.getElementById("delunit").value=unit;
			    		document.getElementById("delbrand").value=brand;
			    		document.getElementById("delunit").value=unit;
			    		
			    		document.getElementById("psrno").value=psrno;
			    		document.getElementById("unitdoc").value=unitdoc;
			    		document.getElementById("specid").value=specid;
			    		document.getElementById("taxdoc").value=taxdoc;
			    		document.getElementById("hidunitprice").value=uprice;
				    	$(this).closest('.searchlist').hide();
				    	return false;	
					});
				} else {
				}
			}
			x.open("GET", "getProduct.jsp?clientid="+clientid+"&clientcatid="+catid+"&brhid="+brhid+"&locid="+locid, true);
			x.send();
		}
 		function funFilterList(el){
			var input=$(el).val();
			input = input.toUpperCase();
			var li=$(el).closest('.form-group').find('.searchlist li');
			for (i = 0; i < li.length; i++) {
    			var a = li[i].getElementsByTagName("a")[0];
    			var txtValue = a.textContent || a.innerText;
    			if (txtValue.toUpperCase().indexOf(input) > -1) {
      				li[i].style.display = "";
    			} else {
      				li[i].style.display = "none";
    			}
  			}
			
		}
		
		function funRoundAmt(value,id){
			var res=parseFloat(value).toFixed(2);
			var res1=(res=='NaN'?"0":res);
			document.getElementById(id).value=res1;  
		} 
    	function isNumber(evt) {
	    	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
	     		// document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	            return false;
			}
	        //document.getElementById("errormsg").innerText="";  
	        return true;
	    }
 		
	</script>  	
	</body>
  	</html>