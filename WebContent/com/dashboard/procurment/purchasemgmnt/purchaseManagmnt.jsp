<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
  <% String contextPath=request.getContextPath();%> 
<!DOCTYPE html>
<html lang="en">
<head>
<title>Purchase Management</title> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
<script type="text/javascript" src="../../../../js/ajaxfileupload.js"></script> 
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">
   .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 10px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: center;
        vertical-align: middle;
    }
    .card-container .card-body .card-detail-container{
        width: 68%;
        vertical-align: middle;
    }
    .card-container .card-body>div{
        display: inline-block;
    }
    .card-container .card-body .card-detail-container>div{
        display: inline-block;
        width:24%;
        text-align:center;
    }
    .card-container .card-body .card-detail-container>div:not(:last-child){
    	border-right: 1px solid #efefef;
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
    .custompanel2{
      float: left;
      display: inline-block;
      /* margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px; */  
      border-radius: 8px;  
    }
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel{
      color: blue;
    } 
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.datepanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
    }
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	
/* 	.modal-dialog,
.modal-content {
    /* 80% of window height */
    height: 80%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}		 */
  .padtop{
        padding-top: 5px; 
    }
    #txtinfo1{
        background-color: #7ffaa6; 
        height:20px;
        width:10px;
        border:none;
    }
    #txtinfo2{
        background-color: #B0E2FF;   
        height:20px;
        width:10px;
        border:none;
    }
    .gridselection{
    	display:none;
    }
    .active {
    background-color: #5390d9;
    color: #fff;
}
  </style>
</head>
<!-- <body onload="getBranch();getProcess();getPriority();getFollowupstatus();getDecline();getCategory();getGroup();"> -->
<body onload="getBranch();getBill();getVendor();InitLoad();">
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
      	<div class="row padtop" style="margin-top: 5px;">
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" >      
                <div class="card-container card-purchasereq" data-gridid="purchasereqsdiv">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <span><img src="../../../../icons/purchaserequest.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">  
                             <span>Purchase Request</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" >      
                <div class="card-container card-purchaseorder" data-gridid="purchaseordddiv">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <span><img src="../../../../icons/purchaseorder.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">  
                             <span>Purchase Order</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" >      
                <div class="card-container card-grn" data-gridid="grendiv">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <span><img src="../../../../icons/goodsreceipt.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">  
                             <span>Goods Receipt Note</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">      
                <div class="card-container card-purchaseinv" data-gridid="pivdiv">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <span><img src="../../../../icons/purchaseinvoice.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">  
                             <span>Purchase Invoice</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">      
                <div class="card-container card-purchaseinvreturn" data-gridid="pirdiv">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <span><img src="../../../../icons/purchaseinvoicereturn.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">  
                             <span>Purchase Invoice Return</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">      
                <div class="card-container card-grnreturn" data-gridid="grrdiv">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <span><img src="../../../../icons/goodsreturn.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">  
                             <span>Goods receipt Return</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
             </div> 
        </div>
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <form class="form-inline"> 
        <div class="primarypanel custompanel">
	                       <div class="form-group col-auto">
				           <label class="form-group" for="cmbpriority">Branch:</label>
    						<div class="form-group">
      							<select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' onchange="getInitChartData();funMclose(this.value);"></select>
    						</div>  
    						</div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">From:</label>
    						<div class="form-group mb-2">
      							<div id='fromdate' name='fromdate'></div>
    						</div> </div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">To:</label>
    						<div class="form-group mb-2">
      							<div id='todate' name='todate'></div>      
			               </div> 	</div>
			                </div>		  
					  <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        </div>
        <div class="otherpanel custompanel">    
        <div class="dropdown" style="display:inline-block;" id="dropdown-createdocs">
  				<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-plus" aria-hidden="true" data-toggle="tooltip" title="Create" data-placement="bottom"></i>
  					<!-- <span class="caret"></span> -->
  				</button>
  				<ul class="dropdown-menu">
    				<li><a>Purchase Order</a></li>
    				<li><a>Goods Receipt Note</a></li>
    				<li><a>Purchase Invoice</a></li>
    				<li><a>Purchase Invoice Return</a></li>
    				<li><a>Goods Receipt Note Return</a></li>
  				</ul>
			</div>     
        <div class="dropdown" style="display:inline-block;" id="dropdown-viewdocs">
  				<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-eye" aria-hidden="true" data-toggle="tooltip" title="Create" data-placement="bottom"></i>
  					<!-- <span class="caret"></span> -->
  				</button>
  				<ul class="dropdown-menu">
    				<li><a>Purchase Request</a></li>
    				<li><a>Purchase Order</a></li>
    				<li><a>Goods Receipt Note</a></li>
    				<li><a>Purchase Invoice</a></li>
    				<li><a>Purchase Invoice Return</a></li>
    				<li><a>Goods Receipt Note Return</a></li>
  				</ul>
			</div>     
         <!--  <button type="button" class="btn btn-default" id="btnenqview"><i class="fa fa-etsy" aria-hidden="true" data-toggle="tooltip"  title="View Enquiry" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnenquiryfollowup" ><i class="fa fa-th-list" aria-hidden="true" data-toggle="tooltip" title="Enquiry Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnsurveyupdate"><i class="fa fa-pencil" aria-hidden="true" data-toggle="tooltip"  title="Survey Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteprepare"  ><i class="fa fa-cogs" aria-hidden="true" data-toggle="tooltip" title="Quote Preparation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteview"><i class="fa fa-quora" aria-hidden="true" data-toggle="tooltip"  title="View Quotation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquotefollowup" ><i class="fa fa-exchange" aria-hidden="true" data-toggle="tooltip" title="Quote Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnmail" ><i class="fa fa-envelope" aria-hidden="true" data-toggle="tooltip" title="Send Mail" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncreateclient"><i class="fa fa-user-o" aria-hidden="true" data-toggle="tooltip" title="Create Client" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteapproval"><i class="fa fa-thumbs-o-up" aria-hidden="true" data-toggle="tooltip"  title="Quote Approval" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnchecklist"><i class="fa fa-check-circle" aria-hidden="true" data-toggle="tooltip"  title="" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnreturn"  ><i class="fa fa-retweet" aria-hidden="true" data-toggle="tooltip" title="Return to presales" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncontractprepare"  ><i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Service Contract Creation" data-placement="bottom"></i></button>  
          <button type="button" class="btn btn-default" id="btncontractview"><i class="fa fa-scribd" aria-hidden="true" data-toggle="tooltip"  title="View Service Contract" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnconfirm"  ><i class="fa fa-check-square-o" aria-hidden="true" data-toggle="tooltip" title="Confirm" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
 -->         </div>
				</form>        
			</div> 
		</div>	 
		<div class="row">
           <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	           <div class="textpanel custompanel2" >
				   <label for="divid" id="selecteddiv" style="font-size:75%;padding-right:10px"></label>          
	           </div>  
	           <div class="textpanel custompanel2" >
				    <label for="divid" id="lblselectedrowdetail" style="font-size:75%;"></label>        
	           </div> 
           </div>   
        </div>    
      
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
         <div id="purchasereqsdiv" class="gridselection"><jsp:include page="puchseMgmtGrid.jsp"></jsp:include></div>
         <div id="purchaseordddiv" class="gridselection"><jsp:include page="purchaseOrderGrid.jsp"></jsp:include></div> 
         <div id="grendiv" class="gridselection"><jsp:include page="grnGrid.jsp"></jsp:include></div> 
         <div id="pivdiv" class="gridselection"><jsp:include page="purchaseinvGrid.jsp"></jsp:include></div> 
         <div id="pirdiv" class="gridselection"><jsp:include page="purchaseinvreturnGrid.jsp"></jsp:include></div> 
         <div id="grrdiv" class="gridselection"><jsp:include page="grnreturnGrid.jsp"></jsp:include></div> 
      </div>
    </div>
	 
     <div id="modalpurchaseorder" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Purchase Order For #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<form class="form-horizontal container-fluid">
    					<div class="row">
	    					<div class="col-sm-4">
	    						<div class="form-group">
	    							<label>Date</label>
	    							<div id='orddate' name='orddate'></div>
	    						</div>
	    					</div>
	    					<div class="col-sm-4">
	    						<div class="form-group">
	    							<label id="billname">Bill Type</label>
	    								<select class="form-control" id="cmbbilltype" name="cmbbilltype"  value='<s:property value="cmbbilltype"/>' >
	    									
	    								</select>
	    						</div>
	    					</div>
	    					<div class="col-sm-4" >
	    						<div class="form-group" style="margin-left: 5px;">
	    							<label>Vendor</label>
	    							<select class="form-control" style="width:100%; margin-left:5px;" id="cmbvendor" name="cmbvendor" onchange="funVendorLoad();"  value='<s:property value="cmbvendor"/>' >
	    								</select>
<%-- 	    							<input style="margin-left: 5px;" class="form-control" type="text" id="vendor"  name="vendor" placeholder="Press F3 to Search" readonly="readonly" value='<s:property value="vendor"/>' />
 --%>	    						</div>
	    					</div>
	    				</div>
    					<div class="row">
	    					<div class="col-sm-6">
	    						<div class="form-group">
	    							<label>Pay Details</label>
	    							<input type="text" class="form-control" id="paydet" name="paydet" value='<s:property value="paydet"/>' />
	    						</div>
	    					</div>
	    					<div class="col-sm-6">
	    						<div class="form-group">
	    							<label>Del Details</label>
	    							<input type="text" class="form-control" id="deldet" value='<s:property value="deldet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					
	    				</div>
    					<div class="row">
	    					<div class="col-sm-12">
	    						<div class="form-group">
	    							<label>Service Grid</label>
	    							<div id="purchseOrdModGrid"><jsp:include page="poModelGrid.jsp"></jsp:include></div>
	    						</div>
	    					</div>
	    				</div>
    				</form>
    			</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclientcreation" onclick="funcreatepo();">Create</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalgrn" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">GRN Order For #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<form class="form-horizontal container-fluid">
    					<div class="row">
	    					<div class="col-sm-4">
	    						<div class="form-group">
	    							<label>Date</label>
	    							<div id='grndate' name='grndate'></div>
	    						</div>
	    					</div>
	    					<div class="col-sm-4">
	    						<div class="form-group">
	    							<label id="billname">Location</label>
	    								<select class="form-control" style="width:100%; margin-left:5px;" id="cmblocation" name="cmblocation"  value='<s:property value="cmblocation"/>' >
	    									
	    								</select>
	    						</div>
	    					</div>
	    					<div class="col-sm-4" >
	    						<div class="form-group" style="margin-left: 5px;">
	    							<label>Vendor</label>
	    							
	    							<input type="text" readonly="readonly" class="form-control" id="txtvendor" name="txtvendor" value='<s:property value="txtvendor"/>' />
	    								
<%-- 	    							<input style="margin-left: 5px;" class="form-control" type="text" id="vendor"  name="vendor" placeholder="Press F3 to Search" readonly="readonly" value='<s:property value="vendor"/>' />
 --%>	    						</div>
	    					</div>
	    				</div>
    					<div class="row">
	    					<div class="col-sm-2">
	    						<div class="form-group">
	    							<label>Inv No.</label>
	    							<input type="text" class="form-control" id="txtinvno" name="txtinvno" value='<s:property value="txtinvno"/>' />
	    						</div>
	    					</div>
	    					<div class="col-sm-5">
	    						<div class="form-group">
	    							<label>Delivery  Terms</label>
	    							<input type="text" class="form-control" style="margin-left: 3px;" id="txtgrndeldet" name="txtgrndeldet" value='<s:property value="txtgrndeldet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					<div class="col-sm-5">
	    						<div class="form-group">
	    							<label>Payment  Terms</label>
	    							<input type="text" class="form-control" id="txtgrnpaydet" name="txtgrnpaydet" value='<s:property value="txtgrnpaydet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					
	    				</div>
    					<div class="row">
	    					<div class="col-sm-12">
	    						<div class="form-group">
	    							<label>Description</label>
	    							<input type="text" class="form-control" id="txtgrndesc" name="txtgrndesc" value='<s:property value="txtgrndesc"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    				</div>
    				</form>
    			</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclientcreation" onclick="funCreateGRN();">Create</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalgrr" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">GRR Order For #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<form class="form-horizontal container-fluid">
    					<div class="row">
	    					<div class="col-sm-4">
	    						<div class="form-group">
	    							<label>Date</label>
	    							<div id='grrdate' name='grrdate'></div>
	    						</div>
	    					</div>
	    					<div class="col-sm-4">
	    						<div class="form-group">
	    							<label id="billname">Location</label>
	    								<select class="form-control" style="width:100%; margin-left:5px;" id="cmbgrrlocation" name="cmbgrrlocation"  value='<s:property value="cmbgrrlocation"/>' >
	    									
	    								</select>
	    						</div>
	    					</div>
	    					<div class="col-sm-4" >
	    						<div class="form-group" style="margin-left: 5px;">
	    							<label>Vendor</label>
	    							
	    							<input type="text" readonly="readonly" class="form-control" id="txtgrrvendor" name="txtgrrvendor" value='<s:property value="txtgrrvendor"/>' />
	    								
<%-- 	    							<input style="margin-left: 5px;" class="form-control" type="text" id="vendor"  name="vendor" placeholder="Press F3 to Search" readonly="readonly" value='<s:property value="vendor"/>' />
 --%>	    						</div>
	    					</div>
	    				</div>
    					<div class="row">
	    					<div class="col-sm-2">
	    						<div class="form-group">
	    							<label>Inv No.</label>
	    							<input type="text" class="form-control" id="txtgrrinvno" name="txtgrrinvno" value='<s:property value="txtgrrinvno"/>' />
	    						</div>
	    					</div>
	    					<div class="col-sm-5">
	    						<div class="form-group">
	    							<label>Delivery  Terms</label>
	    							<input type="text" class="form-control" style="margin-left: 3px;" id="txtgrrdeldet" name="txtgrrdeldet" value='<s:property value="txtgrrdeldet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					<div class="col-sm-5">
	    						<div class="form-group">
	    							<label>Payment  Terms</label>
	    							<input type="text" class="form-control" id="txtgrrpaydet" name="txtgrrpaydet" value='<s:property value="txtgrrpaydet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					
	    				</div>
    					<div class="row">
	    					<div class="col-sm-12">
	    						<div class="form-group">
	    							<label>Description</label>
	    							<input type="text" class="form-control" id="txtgrrdesc" name="txtgrrdesc" value='<s:property value="txtgrrdesc"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    				</div>
    				</form>
    			</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclientcreation" onclick="funCreateGRR();">Create</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalpiv" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Purchase Invoice For #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<form class="form-horizontal container-fluid">
    					<div class="row">
	    					<div class="col-sm-3">
	    						<div class="form-group">
	    							<label>Date</label>
	    							<div id='pivdate' name='pivdate'></div>
	    						</div>
	    					</div>
	    					<div class="col-sm-3">
	    						<div class="form-group">
	    							<label id="pivbillname">Bill Type</label>
	    								<select class="form-control" style="width:100%;" id="cmbpivbilltype" name="cmbpivbilltype"  value='<s:property value="cmbbilltype"/>' >
	    									
	    								</select>
	    						</div>
	    					</div>
	    					<div class="col-sm-3">
	    						<div class="form-group">
	    							<label id="pivlocname">Location</label>
											<select class="form-control" style="width:100%; margin-left:5px;" id="cmbpivlocation" name="cmbpivlocation"  value='<s:property value="cmbpivlocation"/>' >
	    									</select>	    								    								
	    						</div>
	    					</div>
	    					<div class="col-sm-3" >
	    						<div class="form-group" style="margin-left: 5px;">
	    							<label>Vendor</label>
	    							
	    							<input type="text" readonly="readonly" class="form-control" id="txtpivvendor" name="txtpivvendor" value='<s:property value="txtpivvendor"/>' />
	    								
<%-- 	    							<input style="margin-left: 5px;" class="form-control" type="text" id="vendor"  name="vendor" placeholder="Press F3 to Search" readonly="readonly" value='<s:property value="vendor"/>' />
 --%>	    						</div>
	    					</div>
	    				</div>
    					<div class="row">
	    					<div class="col-sm-2">
	    						<div class="form-group">
	    							<label>Inv No.</label>
	    							<input type="text" class="form-control" id="txtpivinvno" name="txtpivinvno" value='<s:property value="txtpivinvno"/>' />
	    						</div>
	    					</div>
	    					<div class="col-sm-5">
	    						<div class="form-group">
	    							<label>Delivery  Terms</label>
	    							<input type="text" class="form-control" style="margin-left: 3px;" id="txtpivdeldet" name="txtpivdeldet" value='<s:property value="txtpivdeldet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					<div class="col-sm-5">
	    						<div class="form-group">
	    							<label>Payment  Terms</label>
	    							<input type="text" class="form-control" id="txtpivpaydet" name="txtpivpaydet" value='<s:property value="txtpivpaydet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					
	    				</div>
    					<div class="row">
	    					<div class="col-sm-12">
	    						<div class="form-group">
	    							<label>Description</label>
	    							<input type="text" class="form-control" id="txtpivdesc" name="txtpivdesc" value='<s:property value="txtpivdesc"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    				</div>
	    				<div class="row">
	    					<div class="col-sm-12">
	    						<div class="form-group">
	    							<label>Service Grid</label>
	    							<div id="pivModGrid"><jsp:include page="pivModelGrid.jsp"></jsp:include></div>
	    						</div>
	    					</div>
	    				</div>
    				</form>
    			</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclientcreation" onclick="funCreatePIV();">Create</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalpir" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Purchase Invoice Return For #<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<form class="form-horizontal container-fluid">
    					<div class="row">
	    					<div class="col-sm-3">
	    						<div class="form-group">
	    							<label>Date</label>
	    							<div id='pirdate' name='pirdate'></div>
	    						</div>
	    					</div>
	    					<div class="col-sm-3">
	    						<div class="form-group">
	    							<label id="pivbillname">Bill Type</label>
	    								<select class="form-control" style="width:100%;" id="cmbpirbilltype" name="cmbpirbilltype"  value='<s:property value="cmbpirbilltype"/>' >
	    									
	    								</select>
	    						</div>
	    					</div>
	    					<div class="col-sm-3">
	    						<div class="form-group">
	    							<label id="pivlocname">Location</label>
											<select class="form-control" style="width:100%; margin-left:5px;" id="cmbpirlocation" name="cmbpirlocation"  value='<s:property value="cmbpirlocation"/>' >
	    									</select>	    								    								
	    						</div>
	    					</div>
	    					<div class="col-sm-3" >
	    						<div class="form-group" style="margin-left: 5px;">
	    							<label>Vendor</label>
	    							
	    							<input type="text" readonly="readonly" class="form-control" id="txtpirvendor" name="txtpirvendor" value='<s:property value="txtpirvendor"/>' />
	    								
<%-- 	    							<input style="margin-left: 5px;" class="form-control" type="text" id="vendor"  name="vendor" placeholder="Press F3 to Search" readonly="readonly" value='<s:property value="vendor"/>' />
 --%>	    						</div>
	    					</div>
	    				</div>
    					<div class="row">
	    					
	    					<div class="col-sm-6">
	    						<div class="form-group">
	    							<label>Delivery  Terms</label>
	    							<input type="text" class="form-control" style="margin-left: 3px;" id="txtpirdeldet" name="txtpirdeldet" value='<s:property value="txtpirdeldet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					<div class="col-sm-6">
	    						<div class="form-group">
	    							<label>Payment  Terms</label>
	    							<input type="text" class="form-control" id="txtpirpaydet" name="txtpirpaydet" value='<s:property value="txtpirpaydet"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    					
	    				</div>
    					<div class="row">
	    					<div class="col-sm-12">
	    						<div class="form-group">
	    							<label>Description</label>
	    							<input type="text" class="form-control" id="txtpirdesc" name="txtpirdesc" value='<s:property value="txtpirdesc"/>' style="margin-left: 5px;" />
	    						</div>
	    					</div>
	    				</div>
	    				
    				</form>
    			</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclientcreation" onclick="funCreatePIR();">Create</button>
            		
          		</div>
        </div>
      </div>
    </div>
  


   

       <input type="hidden" name="divname" id="divname"> 
       
       <input type="hidden" id="hipreqprodid" name="hipreqprodid"> 
       <input type="hidden" id="hidpreqdocno" name="hidpreqdocno"> 
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>                                        
        <input type="hidden" id="vndtax" name="vndtax"  value='<s:property value="vndtax"/>'/>                                        
        <input type="hidden" id="acno" name="acno"  value='<s:property value="acno"/>'/>                                        
        <input type="hidden" id="hidacno" name="hidacno"  value='<s:property value="hidacno"/>'/>                                        
        <input type="hidden" id="hidpivloc" name="hidpivloc"  value='<s:property value="hidpivloc"/>'/>                                        
        <input type="hidden" id="hidmenuname" name="hidmenuname"  value='<s:property value="hidmenuname"/>'/>                                        
        <input type="hidden" id="hidviewmenuname" name="hidviewmenuname"  value='<s:property value="hidviewmenuname"/>'/>                                        
        <input type="hidden" id="hidcurid" name="hidcurid"  value='<s:property value="hidcurid"/>'/>                                        
        <input type="hidden" id="hidrate" name="hidrate"  value='<s:property value="hidrate"/>'/>                                        
	<div id="areainfowindow">
   <div ></div>
</div>
<div id="sourcesearchwndow">
   <div ></div>
</div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){      
    	$('[data-toggle="tooltip"]').tooltip();
		$('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	    $('#areainfowindow').jqxWindow('close');
   	    $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#sourcesearchwndow').jqxWindow('close');
		//$("#returndate").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#orddate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#grndate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#grrdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#pivdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#pirdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(fromdates.getFullYear(), fromdates.getMonth(), 1);   
		enableCreateDocs("Purchase Order");
		enableViewDocs("Purchase Request");
		$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	    
		$('.gridselection').eq(0).css('display','block');
		$('#dropdown-createdocs .dropdown-menu li').addClass('disabled');
		$('#dropdown-viewdocs .dropdown-menu li').addClass('disabled');
		
		$('#cmbvendor').change(function(){
			//alert($(this).find(':selected').data('tax'));
			var menuname=$('#hidmenuname').val();

			var divname=$('#divname').val();
			 var brhid=$('#cmbbranch').val();
			 $('#vndtax').val($(this).find(':selected').data('tax'));
			 //var vndtax=$(this).find(':selected').data('tax');
			if(menuname=='Purchase Order'){
				poModelGridLoad();
			}
		})
		
		/* $('#cmbbilltype').change(function (){
			var billtypeval=$(this).find(':selected').val();
			if(billtypeval==2){
				$('#vndtax').val(0);
			}
			poModelGridLoad();
		}) */
		
		$('#dropdown-createdocs .dropdown-menu li').click(function(e){
			if($(this).hasClass('disabled')){
				return false;
			}
			var menuname=$(this).find('a').text();
			 $('#hidmenuname').val(menuname);
			if(menuname=='Purchase Order'){
				poModelGridLoad();
			}
			
			if(menuname=='Goods Receipt Note'){
				e.preventDefault();
				var brch;
				var selectedrows=$("#purchaseordgrid").jqxGrid('selectedrowindexes');
				for(var i=0;i<selectedrows.length;i++){
					$('#txtvendor').val($('#purchaseordgrid').jqxGrid('getcellvalue', selectedrows[i], "acname"));
					$('#acno').val($('#purchaseordgrid').jqxGrid('getcellvalue', selectedrows[i], "account"));
					brch=$('#purchaseordgrid').jqxGrid('getcellvalue', selectedrows[i], "brhid")
				}
				getLocation(brch);

			$('#modalgrn').modal('show');
			}
			if(menuname=='Goods Receipt Note Return'){
				e.preventDefault();
				var brch;
				var selectedrows=$("#grngrid").jqxGrid('selectedrowindexes');
				for(var i=0;i<selectedrows.length;i++){
					$('#txtgrrvendor').val($('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "acname"));
					$('#acno').val($('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "account"));
					brch=$('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "brhid")

				}
				getLocation(brch);
			$('#modalgrr').modal('show');
			}
			if(menuname=='Purchase Invoice'){
				pivModelGridLoad();
			}
			if(menuname=='Purchase Invoice Return'){
				getLocation();
				pirModelGridLoad();
			}
		});
		var cards=document.querySelectorAll('.card-container');
		$(cards).each(function(index){
			$(this).on('click',function(){
				$('.card-container').removeClass('active');
				$(this).addClass('active');
				$('.gridselection').css('display','none');
				$('.gridselection').eq(index).css('display','block');
				var gridid=$(this).attr('data-gridid');
				$('#dropdown-createdocs .dropdown-menu li').addClass('disabled');
				$('#dropdown-viewdocs .dropdown-menu li').addClass('disabled');
				
				
				if(gridid=='purchasereqsdiv'){
					enableCreateDocs("Purchase Order");
					enableViewDocs("Purchase Request");
				}
				if(gridid=='purchaseordddiv'){
					enableCreateDocs("Goods Receipt Note");
					enableViewDocs("Purchase Order");

				}
				if(gridid=='grendiv'){
					enableCreateDocs("Purchase Invoice");
					enableCreateDocs("Goods Receipt Note Return");
					enableViewDocs("Goods Receipt Note");

					/* $('#dropdown-createdocs .dropdown-menu li:contains("Purchase Invoice")').removeClass('disabled');
					$('#dropdown-createdocs .dropdown-menu li:contains("Goods Receipt Note Return")').removeClass('disabled'); */
				}
				if(gridid=='pivdiv'){
					enableCreateDocs("Purchase Invoice Return");
					enableViewDocs("Purchase Invoice");
				}
				document.getElementById("divname").value=gridid;         
				funload();
			});
		});
		
		//View Section 
		$('#dropdown-viewdocs .dropdown-menu li').click(function(e){
			if($(this).hasClass('disabled')){
				return false;
			}
			var menuname=$(this).find('a').text();
			 $('#hidviewmenuname').val(menuname);
			 if(menuname=='Purchase Request'){
					$('#hidviewmenuname').val(menuname);
						viewPurchaseRequest();
					}
			if(menuname=='Purchase Order'){
				viewPurchaseOrder();
			}
			
			if(menuname=='Goods Receipt Note'){
				$('#hidviewmenuname').val(menuname);
					viewGRN();
				}
			
			if(menuname=='Goods Receipt Note Return'){
				
			}
			if(menuname=='Purchase Invoice'){
				$('#hidviewmenuname').val(menuname);
				viewPIV();
			}
			if(menuname=='Purchase Invoice Return'){
			}
		});
	
	    $('#btninfo').click(function(){
           	$('#modalinfo').modal('show');  
  	      });
		$('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   if(fromdates<todates){
				   Swal.fire({  
	        			icon: 'warning',
						title: 'Warning',
						text: 'To Date Less Than From Date'
					});
			        return false;  
			  }   
		 });
		 document.getElementById('selecteddiv').innerHTML=" - ";  
    	document.getElementById("divname").value="purchaserequest";       
    	
 
		$('#btnsubmit').click(function(){     
			 getInitChartData();   
			 funload();
		});
		$('#btnexcel').click(function(){
			$("#presalesdiv").excelexportjs({  
				containerid: "presalesdiv",
				datatype: 'json',
				dataset: null,
				gridId: "enqlistgrid",
				columns: getColumns("enqlistgrid"),
				worksheetName: "Presales Management"
			});
		});
		
       
	});
    
//View Section of Master Forms

    //View Purchase Request Master Form   
	function viewPurchaseRequest(){  
		var selectedrows=$("#enqlistgrid").jqxGrid('selectedrowindexes');
		if(selectedrows.length<=0){
	   		 $.messager.alert('Message','Select The Document  ','warning');  
	return false;
			}
		var brch=$('#enqlistgrid').jqxGrid('getcellvalue',selectedrows[0], "brhid");
		var reftrno=$('#enqlistgrid').jqxGrid('getcellvalue',selectedrows[0], "voc_no");
		//alert("reftrno ===="+reftrno);
		//var refdocno=$('#enqlistgrid').jqxGrid('getcellvalue',selectedrows[0], "rrefno");
		var path1="com/Procurement/Purchase/purchaserequest/PurchaseRequest.jsp";  
 		//var path1="com/Procurement/Purchase/PurchaseOrder/saveActionpurOrders.action";  
		var name="Purchase Request";
		var url=document.URL;  
		var reurl=url.split("com/");
		window.parent.formName.value="Purchase Request";
		window.parent.formCode.value="PR";
		window.parent.branchid.value=brch;
		var detName="Purchase Request";  
		var mode="viewBI"; 
		//var mode="view"; 
		var chk1="1";
		window.parent.branchid.value=brch;
		var path= path1+"?mod="+mode+"&docno="+reftrno+"&brch="+brch+"&chk1="+chk1; 
		//var path= path1+"?mode="+mode+"&docno="+reftrno; 
		//$.session.set('BRANCHID', brch);
		//sessionStorage.setItem("BRANCHID", brch);
		top.addTab(detName,reurl[0]+""+path);
	}


    //View Purchase Order Master Form   
	function viewPurchaseOrder(){  
		var selectedrows=$("#purchaseordgrid").jqxGrid('selectedrowindexes');
		if(selectedrows.length<=0){
   		 $.messager.alert('Message','Select The Document  ','warning');  
return false;
		}
		var brch=$('#purchaseordgrid').jqxGrid('getcellvalue',selectedrows[0], "brhid");
		//alert(brch)
		var reftrno=$('#purchaseordgrid').jqxGrid('getcellvalue',selectedrows[0], "voc_no");
		//alert("reftrno ===="+reftrno);
		var refdocno=$('#purchaseordgrid').jqxGrid('getcellvalue',selectedrows[0], "rrefno");
		var path1="com/Procurement/Purchase/PurchaseOrder/PurchaseOrder.jsp";  
 		//var path1="com/Procurement/Purchase/PurchaseOrder/saveActionpurOrders.action";  
		var name="Purchase Order";
		var url=document.URL;  
		var reurl=url.split("com/");
		window.parent.formName.value="Purchase Order";
		window.parent.formCode.value="PO";
		window.parent.branchid.value=brch;
		var detName="Purchase Order";  
		var mode="viewBI"; 
		//var mode="view"; 
		var chk1="1";
		window.parent.branchid.value=brch;
		var path= path1+"?mod="+mode+"&docno="+reftrno+"&brch="+brch+"&chk1="+chk1; 
		//var path= path1+"?mode="+mode+"&docno="+reftrno; 
		//$.session.set('BRANCHID', brch);
		//sessionStorage.setItem("BRANCHID", brch);
		top.addTab(detName,reurl[0]+""+path);
	}
	
	//View Goods Receipt Note Master Form 
	
	function viewGRN(){
		
		var selectedrows=$("#grngrid").jqxGrid('selectedrowindexes');
		if(selectedrows.length<=0){
	   		 $.messager.alert('Message','Select The Document  ','warning');  
	return false;
			}
		var branch=$('#grngrid').jqxGrid('getcellvalue',selectedrows[0],"brhid");
		var docno=$('#grngrid').jqxGrid('getcellvalue',selectedrows[0],"doc_no");
		//alert(docno)
		//var mode="view";
		var mode="viewBI";
		var chk1="1";
		var detName="Goods Receipt Note";
		//var path="com/Procurement/Purchase/goodsreceiptnote/saveActionGdsrnote.action?mode="+mode+"&Masterdoc_no="+docno;
		var path="com/Procurement/Purchase/goodsreceiptnote/goodsrecieptmaster.jsp?mod="+mode+"&Masterdoc_no="+docno+"&chl1="+chk1+"&brch="+branch;
		var url=document.URL;
		var reurl=url.split("com/");
		window.parent.formName.value="Goods Receipt Note";
		window.parent.formCode.value="GRN";
		window.parent.branchid.value=branch;
		top.addTab(detName,reurl[0]+""+path);

	}
	//View Purchase Invoice Master Form 
	
	function viewPIV(){
		var selectedrows=$("#purchaseinvgrid").jqxGrid('selectedrowindexes');
		if(selectedrows.length<=0){
	   		 $.messager.alert('Message','Select The Document  ','warning');  
	return false;
			}
		var branch=$('#purchaseinvgrid').jqxGrid('getcellvalue',selectedrows[0],"brhid");
		var docno=$('#purchaseinvgrid').jqxGrid('getcellvalue',selectedrows[0],"doc_no");
		var mode="viewBI";
		var detName="Purchase Invoice";
		var chk1=1;
		//var path="com/Procurement/Purchase/purchaseinvoice/saveActionpurInv.action?mode="+mode+"&Masterdoc_no="+docno;
		var path="com/Procurement/Purchase/purchaseinvoice/purchseinvoicemaster.jsp?mod="+mode+"&Masterdoc_no="+docno+"&brch="+branch+"&chk1="+chk1;
		var url=document.URL;
		var reurl=url.split("com/");
		window.parent.formName.value="Purchase Invoice";
		window.parent.formCode.value="PIV";
		window.parent.branchid.value=branch;
		top.addTab(detName,reurl[0]+""+path);

	}
    
	/************************/
	
	
    function poModelGridLoad(){
    	var vndtax=$('#vndtax').val();
		var divname=$('#divname').val();
		 var brhid=$('#cmbbranch').val();
		//e.preventDefault();
		var selectedrows=$("#enqlistgrid").jqxGrid('selectedrowindexes');
		var docno='';
		var prid='';
		for(var i=0;i<selectedrows.length; i++){
			if(i==0){
				docno=$('#enqlistgrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
				prid+=$('#enqlistgrid').jqxGrid('getcellvalue', selectedrows[i], "productid");
			}else{
				docno+=','+$('#enqlistgrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
				prid+=','+$('#enqlistgrid').jqxGrid('getcellvalue', selectedrows[i], "productid");
			}
			
		}
		$('#hipreqprodid').val(prid);
	       $('#hidpreqdocno').val(docno);
	       $('#purchseOrdModGrid').load('poModelGrid.jsp?id=1&docno='+docno+'&prdid='+prid+'&fdate='+$('#fromdate').val()+'&todate='+$('#todate').val()+'&divname='+divname+'&brhid='+brhid+'&vndtax='+vndtax);
		$('#modalpurchaseorder').modal('show');
    }
    function pivModelGridLoad(){
    	var brch;
		 var billtype=$('#cmbpivbilltype').val();
		var selectedrows=$("#grngrid").jqxGrid('selectedrowindexes');
		var docno='';
		for(var i=0;i<selectedrows.length; i++){
			$('#txtpivvendor').val($('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "acname"));
			$('#acno').val($('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "account"));
			
			if(i==0){
				docno=$('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
			}else{
				docno+=','+$('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
			}
			brch=$('#grngrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");

		}
	       $('#hidpreqdocno').val(docno);
			getLocation(brch);

	       $('#pivModGrid').load('pivModelGrid.jsp?id=1&docno='+docno+'&fdate='+$('#fromdate').val()+'&billtype='+billtype+'&acno='+$('#acno').val());
		$('#modalpiv').modal('show');
    }
    function pirModelGridLoad(){
    	var brch;
		 var billtype=$('#cmbpirbilltype').val();
		var selectedrows=$("#purchaseinvgrid").jqxGrid('selectedrowindexes');
		var docno='';
		for(var i=0;i<selectedrows.length; i++){
			$('#txtpirvendor').val($('#purchaseinvgrid').jqxGrid('getcellvalue', selectedrows[i], "description"));
			$('#acno').val($('#purchaseinvgrid').jqxGrid('getcellvalue', selectedrows[i], "account"));
			
			if(i==0){
				docno=$('#purchaseinvgrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
			}else{
				docno+=','+$('#purchaseinvgrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
			}
			brch=$('#purchaseinvgrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
		}
	       $('#hidpreqdocno').val(docno);
			getLocation(brch);

	       //$('#pivModGrid').load('pivModelGrid.jsp?id=1&docno='+docno+'&fdate='+$('#fromdate').val()+'&billtype='+billtype+'&acno='+$('#acno').val());
		$('#modalpir').modal('show');
    }
    
    
    function enableCreateDocs(value){
    	$('#dropdown-createdocs .dropdown-menu li').each(function(){
    		if($(this).find('a').text()==value){
    			$(this).removeClass('disabled');
    			return;
    		}
    	});
    }
    function enableViewDocs(value){
    	$('#dropdown-viewdocs .dropdown-menu li').each(function(){
    		if($(this).find('a').text()==value){
    			$(this).removeClass('disabled');
    			return;
    		}
    	});
    }
function InitLoad(){
	$('.card-container').eq(0).trigger('click');
}
   	
		function getInitChartData(){
			  var brhid=$('#cmbbranch').val();
			  //alert(brhid);
			  var fromdate= $("#fromdate").val();
			  var todate= $("#todate").val();
			  var x=new XMLHttpRequest();
			  x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim();
					var guagedata=JSON.parse(items);           
			        
		          	$('.card-container.card-purchasereq').find('.card-detail-container').find('.counter').text(guagedata.enqcount);  
		          	$('.card-container.card-purchaseorder').find('.card-detail-container').find('.counter').text(guagedata.ordcount);  
		          	$('.card-container.card-grn').find('.card-detail-container').find('.counter').text(guagedata.grncount);  
		          	$('.card-container.card-purchaseinv').find('.card-detail-container').find('.counter').text(guagedata.pivcount);  
		          	$('.card-container.card-purchaseinvreturn').find('.card-detail-container').find('.counter').text(guagedata.pircount);  
		          	$('.card-container.card-grnreturn').find('.card-detail-container').find('.counter').text(guagedata.grrcount);  
		        						

		    		//$('.card-container').eq(0).trigger('click');
				}
				else{  
				}
			}
			x.open("GET","getInitChartData.jsp?brhid="+brhid+'&froms='+fromdate+'&tos='+todate,true);                              
			x.send();    
		 }

		function funload(){
			
			 var divname=$('#divname').val();  
			 var brhid=$('#cmbbranch').val();
			 var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			 $('.load-wrapp').show();
			 if(divname=="purchasereqsdiv"){
				 $('#purchasereqsdiv').load('puchseMgmtGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
 
			 }
			 if(divname=="purchaseordddiv"){
				 $('#purchaseordddiv').load('purchaseOrderGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
 
			 }
			 if(divname=="grendiv"){
				 $('#grendiv').load('grnGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
 
			 }
			 if(divname=="pivdiv"){
				 $('#pivdiv').load('purchaseinvGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
 
			 }
			 if(divname=="pirdiv"){
				 $('#pirdiv').load('purchaseinvreturnGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
 
			 }
			 if(divname=="grrdiv"){
				 $('#grrdiv').load('grnreturnGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
 
			 }
		}
		function getBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
				//alert(items);
					items = items.split('####');
					
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
					var perm = items[2]; 
					 mcloseItems=items[3].split(",");
					 console.log("taxdade : "+items[4]);
				     taxdate=items[4].split(",");
					var optionsbranch;
					 if(perm==0){
					 optionsbranch = '<option value="a" selected>All</option>';
					}
					else{    
						
					}
					for (var i = 0; i < branchItems.length; i++) {
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
					}
					$("select#cmbbranch").html(optionsbranch);
					window.parent.monthclosed.value=mcloseItems[0];
					
			        	window.parent.taxdateval.value=taxdate[0];
					
					getInitChartData();
					
					/* if ($('#hidcmbbranch').val() != null) {
						$('#cmbbranch').val($('#hidcmbbranch').val());
					} */
				} else {
					//alert("Error");
				}  
			}
			x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);  
			x.send();
		} 
		function getBill(){ 
			  var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    	{
			      		items= x.responseText;
			      		items=items.split('####');
			           	var pgid=items[0].split(",");
			           	var pgcode=items[1].split(",");
			           //	var optionspg = '';
			           					var htmldata='<option value="">--Select--</option>';
			           					var pivhtmldata='';
			           					var pirhtmldata='';

			            for ( var i = 0; i < pgcode.length; i++) {
			            								//optionspg += '<option value="' + pgid[i] + '">' + pgcode[i] + '</option>';
							htmldata+='<option value="'+pgid[i]+'">'+pgcode[i]+'</option>';
							pivhtmldata+='<option value="'+pgid[i]+'">'+pgcode[i]+'</option>';
							pirhtmldata+='<option value="'+pgid[i]+'">'+pgcode[i]+'</option>';

			           							}
			            $("select#cmbbilltype").html(htmldata);
			            $("select#cmbpivbilltype").html(pivhtmldata);
			            $("select#cmbpirbilltype").html(pirhtmldata);
			            $("#cmbbilltype").select2({
							 placeholder:"Select Billtype",
							 allowClear:true
						 });
			            $("#cmbpivbilltype").select2({
							// placeholder:"Select Billtype",
							 allowClear:true
						 });
			            $("#cmbpirbilltype").select2({
							// placeholder:"Select Billtype",
							 allowClear:true
						 });
			    	}
			    }
			   x.open("GET","getBillType.jsp",true);
				x.send();
	    }
		function getVendor(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if(x.readyState==4 && x.status==200){
					var items= x.responseText.trim();
					items=JSON.parse(items);
					var htmldata='<option value="">--Select--</option>';
					$.each(items.vendordata,function(index,value){
						htmldata+='<option value="'+value.cldocno+'" data-acno="'+value.acno+'" data-tax="'+value.tax+'">'+value.desc+'</option>';
						$('#vndtax').val(value.tax);
						$('#hidacno').val(value.acno);
					});
					 $("select#cmbvendor").html(htmldata);
					$("#cmbvendor").select2({
						 placeholder:"Select vendor",
						 allowClear:true
					 });
				}
			}
			x.open("GET","getAccountDetails.jsp",true);
			x.send();
		}
		
		function getLocation(brch){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if(x.readyState==4 && x.status==200){
					var items= x.responseText.trim();
					items=JSON.parse(items);
					var htmldata='<option value="">--Select--</option>';
					$.each(items.location,function(index,value){

						htmldata+='<option value="'+value.doc_no+'">'+value.loc_name+'</option>';
											});
					 $("select#cmblocation").html(htmldata);
					 $("select#cmbgrrlocation").html(htmldata);
					 $("select#cmbpivlocation").html(htmldata);
					 $("select#cmbpirlocation").html(htmldata);
					$("#cmblocation").select2({
						 placeholder:"Select location",
						 allowClear:true
					 });
					$("#cmbgrrlocation").select2({
						 placeholder:"Select location",
						 allowClear:true
					 });
					$("#cmbpivlocation").select2({
						 placeholder:"Select location",
						 allowClear:true
					 });
					$("#cmbpirlocation").select2({
						 placeholder:"Select location",
						 allowClear:true
					 });
				}
			}
			x.open("GET","getLocation.jsp?brch="+brch,true);
			x.send();
		}
		
		function funcreatepo(){
			 var branchval = document.getElementById("cmbbranch").value;

			var chk=1;
			var divname=$("#divname").val();
			var vndtax=$("#vndtax").val();
			var podate=$("#fromdate").val();
			var acno=$("#acno").val();
			var pay=$("#paydet").val();
			var del=$("#deldet").val();
			var loc=$("#")
			var prdtotal=0,nettotaldown=0,ordervalue=0,nettax=0;
			  var temp1="";
			var rows=$('#PurOrdGrid').jqxGrid('getrows');
			//var selectedrows=$('#PurOrdGrid').jqxGrid('getrows');
			if(rows.length==0){
				$.messager.alert('Warning','Please select any document');
				return false;
			}
			$.messager.confirm('Confirm', 'Do you want to create purhchase order?', function(r){
				if (r){
					$("#overlay, #PleaseWait").show();
					var invoicearray=new Array();
					for(var i=0;i<rows.length;i++){
						//var chk=rows[i];
						temp1=temp1+rows[i].doc_no+",";
						var uprice=rows[i].amount;
						//alert("uprice=="+uprice);
						if((typeof(uprice)==="undefined") || (uprice=="")){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Warning','Enter Unit Price for Selected Documents');
							return false;
							break;
						}
						//alert(rowno+"::"+insurstatus+"::"+billtoacno+"::"+claimno+"::"+description+"::"+amount+"::"+discount+"::"+net+"::"+vat+"::"+total+"::"+excess+"::"+roundoff+"::"+netbill);
						/*  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
							   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
							   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].unitprice1+"::"+rows[i].disper1
							   +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].taxdocno+"::"+"0000"+"::");  */
						invoicearray.push(rows[i].psrno+" :: "+rows[i].psrno+" :: "+rows[i].unitdoc+" :: "+rows[i].qty+" :: "
								   +rows[i].amount+" :: "+rows[i].total+" :: "+"0000"+" :: "+rows[i].nettotal+" :: "+rows[i].qty
								   +" :: "+"0000"+" :: "+rows[i].specid+" :: "+"0000"+" :: "+"0000"+" :: "+"0000"
								   +" :: "+rows[i].taxper+" :: "+rows[i].taxamount+" :: "+rows[i].nettaxamount+" :: "+rows[i].taxdocno+" :: "+"0000"+" :: ");
						prdtotal=parseFloat(prdtotal)+parseFloat(rows[i].total);
						nettotaldown=parseFloat(nettotaldown)+parseFloat(rows[i].nettotal);
						ordervalue=parseFloat(ordervalue)+parseFloat(rows[i].nettaxamount);
						nettax=parseFloat(nettax)+parseFloat(rows[i].taxamount);
					}
					temp1=temp1.replace(/,\s*$/, "");
					//alert("temp1=="+temp1);
					var x = new XMLHttpRequest();
					x.onreadystatechange = function() {
						if (x.readyState == 4 && x.status == 200) {
							var items = x.responseText.trim();
							if(parseInt(items.split("::")[0])>0){
								$("#overlay, #PleaseWait").hide();
								$.messager.alert('Message','Purchase Order '+items.split("::")[1]+' Created');
								// $("#listdiv").load('puchseMgmtGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);
								$('#modalpurchaseorder').modal('hide');
						$('#modalpurchaseorder').find("input,select").val('').end();
						getInitChartData();
								 funload();
							}
							else{
								$("#overlay, #PleaseWait").hide();
								$.messager.alert('Message',' Not Created');
								$('#modalpurchaseorder').modal('hide');
								$('#modalpurchaseorder').find("input,select").val('').end();
								return false;
							}
						} else {
						}
					}
					x.open("GET", "createPo.jsp?podate="+podate+"&poarray="+invoicearray+"&vndacno="+acno+"&paydetails="+pay+"&deldetails="+del+"&rrefno="+temp1+"&prdtotal="+prdtotal+"&nettotaldown="+nettotaldown+"&ordervalue="+ordervalue+"&nettax="+nettax+'&vndtax='+$('#vndtax').val(), true);
					x.send();
				}
			});
		}
		
		
		function funCreateGRN(){

			
			var grnarray=new Array();
				
				var rowss = $("#purchaseordgrid").jqxGrid('getrows');

				var rows=$("#purchaseordgrid").jqxGrid('selectedrowindexes');
				rows = rows.sort(function(a,b){return a - b});
			 
				if(rows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select documents.');
				return false;
				}  
				
				var docnos="";
				var accdocno="";
				var multiAcc=false;
				var i=0;var podocnos="";            
				var j=0;
				var vacno=0;
				var a1=0,a2=0,a3=0;
				var brchid;
				for (i = 0; i < rows.length; i++) {  
					
					if(accdocno!="" && accdocno!=$('#purchaseordgrid').jqxGrid('getcellvalue',rows[i],'account')){
						multiAcc=true;
					}
					accdocno=$('#purchaseordgrid').jqxGrid('getcellvalue',rows[i],'account');
					
					if(i==0){
						docnos+=$('#purchaseordgrid').jqxGrid('getcellvalue',rows[i],'doc_no');
					}else{
						docnos+=","+$('#purchaseordgrid').jqxGrid('getcellvalue',rows[i],'doc_no');
					}
					
					if(multiAcc){
					 	Swal.fire({
			            type: 'error',
			            title: 'Warning',
			            text: 'Please select documents of Same Account'
			        });
			        return false;
					}
				
				 if(i==0){
						 vacno =  $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "account");
					 }
					 a1 = $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "doc_no");
					 if(a1!=a2){
						 podocnos+=a1+",";
					 }
					 var psrno= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "psrno");
					 var prodoc= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "prodoc");
					 var unitdocno= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "unitdocno");
					 var qty= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "qty");
					 var saveqty= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "saveqty");
					 var checktype= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "checktype");
					 var specid= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "specid");
					 var foc= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "foc");
					 var unitprice= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "unitprice");
					 var discount= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "discount");
					 var disper= $('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "disper");
					 brchid=$('#purchaseordgrid').jqxGrid('getcellvalue', rows[i], "brhid");
					 
			        grnarray.push(psrno+":: "+prodoc+" :: "+unitdocno+" :: "+qty+" :: " +saveqty+" :: "+checktype+" :: "+specid+" :: "+foc+" ::"+unitprice+" ::"+discount+" ::"+disper+" ::");
			        a2=a1;
				}
				//alert(grnarray);
				//alert(podocnos);
				$.messager.confirm('Confirm', 'Do you want to Create GRN?', function(r){
					if (r){
						//alert("GRN"+$('#cmblocation').val());
						createGRN(grnarray,vacno,podocnos,brchid);	
					}
				});
			}
				
			function createGRN(grnarray,vacno,podocnos,brchid){
				var x=new XMLHttpRequest();
				var delterms=$('txtgrndeldet').val();
				var paymentterms=$('txtgrnpaydet').val();
				var desc=$('txtgrndesc').val();
				var loc=$('#cmblocation').val();
				var invno=$('#txtinvno').val();
				
				if(loc==''){
					$.messager.alert('Message','Please Select Location');
					return 0;
				}
				if(invno==''){
					$.messager.alert('Message','Fillup Invoice Number');
					return 0;
				}
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items= x.responseText.trim().split('####');
					if(parseInt(items[0])>0){
						$.messager.alert('message','GRN - '+items[1]+' Successfully Generated');
						$('#modalgrn').modal('hide');
						$('#modalgrn').find("input,select").val('').end();
							//$('#purchaseordgrid').jqxGrid('clear');
							getInitChartData();
							funload();
					}
					else{
						$.messager.alert('message','Not Generated');
						$('#modalgrn').modal('hide');
						$('#modalgrn').find("input,select").val('').end();
					}
					
				}
				else
				{
				}
				}
				x.open("GET", "createGRN.jsp?grnarray="+encodeURIComponent(grnarray)+"&vacno="+vacno+"&podocnos="+podocnos+'&date='+$("#fromdate").val()+'&desc='+desc+'&delterms='+delterms+'&paymentterms='+paymentterms+'&loc='+loc+'&invno='+invno+'&brhid='+brchid, true);   
				x.send();
			}
			
			
		//PIR Insert Function	
		function funCreatePIR(){

			
			var pirarray=new Array();
				
				var rowss = $("#purchaseinvgrid").jqxGrid('getrows');

				var rows1=$("#purchaseinvgrid").jqxGrid('getselectedrowindexes');
				rows1 = rows1.sort(function(a,b){return a - b});
				var brchid;
				if(rows1.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select documents.');
				return false;
				}  
				
				var docnos="";
				var accdocno="";
				var multiAcc=false;
				var i=0;var podocnos="";            
				var j=0;
				var vacno=0;
				var a1=0,a2=0,a3=0;
				var Nettotal=0.0;
				var producttotal=0.0;
				var finaltotal=0.0;
				var vacno=0;
				var podocnos=0;
				for (i = 0; i < rows1.length; i++) {  
					
					if(accdocno!="" && accdocno!=$('#purchaseinvgrid').jqxGrid('getcellvalue',rows1[i],'acno')){
						multiAcc=true;
					}
					accdocno=$('#purchaseinvgrid').jqxGrid('getcellvalue',rows1[i],'acno');
					
					if(i==0){
						docnos+=$('#purchaseinvgrid').jqxGrid('getcellvalue',rows1[i],'doc_no');
					}else{
						docnos+=","+$('#purchaseinvgrid').jqxGrid('getcellvalue',rows1[i],'doc_no');
					}
					
					if(multiAcc){
					 	Swal.fire({
			            type: 'error',
			            title: 'Warning',
			            text: 'Please select documents of Same Account'
			        });
			        return false;
					}
				
				 if(i==0){
						 vacno =  $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "acno");
					 }
					 a1 = $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "doc_no");
					 if(a1!=a2){
						 podocnos+=a1+",";
					 }
					 var psrno= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "psrno");
					 var productname= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "productname");
					 var unit= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "unit");
					 var qty= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "qty");
					 var unitprice= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "unitprice");
					 var total= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "total");
					 var discount= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "discount");
					 var nettotal= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "nettotal");
					 var prodoc= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "prodoc");
					 var unitdocno= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "unitdocno");
					 var qutval= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "qutval");
					 var saveqty= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "saveqty");
					 var discper= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "discper");
					 var pqty= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "pqty");
					 var proid= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "proid");
					 var proname= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "proname");
					 var specid= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "specid");
					 var foc= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "foc");
					 var stockid= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "stockid");
					 var oldqty= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "oldqty");
					 var oldfoc= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "oldfoc");
					 var orderdiscper= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "orderdiscper");
					 var orderamount= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "orderamount");
					 var brandname= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "brandname");
					 var taxper= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "taxper");
					 var taxamount= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "taxamount");
					 var taxperamt= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "taxperamt");
					 var taxdocno= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "taxdocno");
					 var checktype= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "checktype");
					 var batch_no= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "batch_no");
					  brchid= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "brhid");
					 
					 //var description= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "description");
					 //var acno= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "acno");
					 //var doc_no= $('#purchaseinvgrid').jqxGrid('getcellvalue', rows1[i], "doc_no");
						 
					  pirarray.push(psrno+":: "+prodoc+" :: "+unitdocno+" :: "+qty+" :: " +unitprice+" :: "+total+" :: "+discount+" :: "
							 +nettotal+" ::"+qty+"::"+checktype+"::"+specid+"::"+discper+"::"
							 +stockid+"::"+oldqty+"::"+foc+"::"+oldfoc+"::"+taxper+"::"+ taxperamt+"::"+taxamount+"::"); 
					/*  pirarray.push(rows1[i].psrno+"::"+rows1[i].prodoc+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "
							   +rows1[i].unitprice+" :: "+rows1[i].total+" :: "+rows1[i].discount+" :: "+rows1[i].nettotal+" :: "+rows1[i].saveqty
							   +" :: "+rows1[i].checktype+" :: "+rows1[i].specid+" :: "+rows1[i].discper+" :: "+rows1[i].stockid+" :: "+rows1[i].oldqty+" :: "+rows1[i].foc
							   +" :: "+rows1[i].orderdiscper+" :: "+rows1[i].orderamount+"::"+rows1[i].taxper+"::"+rows1[i].taxperamt+"::"+rows1[i].taxamount+"::"+rows1[i].batch_no+"::"
							   +$('#purchaseinvgrid').jqxGrid('getcelltext', i, "exp_date")+"::"+rows1[i].taxdocno+"::"+"0000"+"::"); */
					 
							   

					 Nettotal=Nettotal+total;
					 producttotal=producttotal+total;
					 finaltotal=finaltotal+taxamount;
						a2=a1;
				}
				//alert(grnarray);
				//alert(podocnos);
				$.messager.confirm('Confirm', 'Do you want to Create PIR?', function(r){
					if (r){
						//alert("GRN"+$('#cmblocation').val());
						createPIR(pirarray,Nettotal,producttotal,finaltotal,vacno,podocnos,brchid);	
					}
				});
			}
				
			function createPIR(pirarray,Nettotal,producttotal,finaltotal,vacno,podocnos,brchid){
				var maindate = $('#pirdate').jqxDateTimeInput('getDate');
				
				   var validdate=funDateInPeriod(maindate);
				   if(validdate==0){
				   return 0; 
				   }				
				var x=new XMLHttpRequest();
				var delterms=$('#txtpirdeldet').val();
				var paymentterms=$('#txtpirpaydet').val();
				var desc=$('#txtpirdesc').val();
				var loc=$('#cmbpirlocation').val();
				var billtype=$('#cmbpirbilltype').val();
				if(loc==''){
					$.messager.alert('Message','Please Select Location');
					return 0;
				}
				
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items= x.responseText.trim().split('####');
					if(parseInt(items[0])>0){
						$.messager.alert('message','PIR - '+items[1]+' Successfully Generated');
						$('#modalpir').modal('hide');
						$('#modalpir').find("input,select").val('').end();
						getBill();

							//$('#purchasepivgrid').jqxGrid('clear');
							getInitChartData();
							funload();
					}
					else{
						$.messager.alert('message','Not Generated');
						$('#modalpir').modal('hide');
						$('#modalpir').find("input,select").val('').end();
						getBill();
					}
					
				}
				}
				x.open("GET", "createPIR.jsp?pivarray="+encodeURIComponent(pirarray)+"&vacno="+vacno+"&podocnos="+podocnos+'&date='+$("#fromdate").val()+'&desc='+desc+'&delterms='+delterms+'&paymentterms='+paymentterms+'&loc='+loc+'&nettotal='+Nettotal+'&producttotal='+producttotal+'&finaltotal='+finaltotal+'&billtype='+billtype+'&brchid='+brchid, true);   
				x.send();
			

			
			}	
			
			
		function funVendorLoad(){
			
			var acno=$('#hidacno').val();
			$('#acno').val(acno);

		}
		
		
		function funCreateGRR(){

			
			var grrarray=new Array();
				
				var rowss = $("#grngrid").jqxGrid('getrows');

				var rows1=$("#grngrid").jqxGrid('selectedrowindexes');
				rows1 = rows1.sort(function(a,b){return a - b});
			 
				if(rows1.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select documents.');
				return false;
				} 
				
				var docnos="";
				var accdocno="";
				var multiAcc=false;
				var i=0;var podocnos="";            
				var j=0;
				var vacno=0;
				var a1=0,a2=0,a3=0;
				var brchid;
				
				for (i = 0; i < rows1.length; i++) {  
					
					if(accdocno!="" && accdocno!=$('#grngrid').jqxGrid('getcellvalue',rows1[i],'account')){
						multiAcc=true;
					}
					accdocno=$('#grngrid').jqxGrid('getcellvalue',rows1[i],'account');
					
					if(i==0){
						docnos+=$('#grngrid').jqxGrid('getcellvalue',rows1[i],'doc_no');
					}else{
						docnos+=","+$('#grngrid').jqxGrid('getcellvalue',rows1[i],'doc_no');
					}
					
					if(multiAcc){
					 	Swal.fire({
			            type: 'error',
			            title: 'Warning',
			            text: 'Please select documents of Same Account'
			        });
			        return false;
					}
				
					
					
					 if(i==0){
						 vacno =  $('#grngrid').jqxGrid('getcellvalue', rows1[i], "acno");
					 }
					 a1 = $('#grngrid').jqxGrid('getcellvalue', rows1[i], "doc_no");
					 if(a1!=a2){
						 podocnos+=a1+",";
					 }
					
					 var psrno= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "psrno");
					 var prodoc= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "prodoc");
					 var unitdocno= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "unitdocno");
					 var qty= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "qty");
					 var saveqty= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "saveqty");
					 var checktype= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "checktype");
					 var specid= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "specid");
					 var foc= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "foc");
					 var stockid= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "stockid");
					 var oldqty= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "oldqty");
					 var oldfoc= $('#grngrid').jqxGrid('getcellvalue', rows1[i], "oldfoc");
					 brchid=$('#grngrid').jqxGrid('getcellvalue', rows1[i], "brhid");	
						 
			        grrarray.push(psrno+"::"+prodoc+" :: "+unitdocno+" :: "+qty+" :: "+saveqty+" :: "+checktype+" :: "+specid+" :: "+foc+" ::"+stockid+" :: "+oldqty+" :: "+oldfoc+" :: ");
					   a2=a1;
				}
				//alert(grrarray);
				//alert(podocnos);
				
				$.messager.confirm('Confirm', 'Do you want to Create GRR?', function(r){
					if (r){
						createGRR(grrarray,vacno,podocnos,brchid);	
					}
				});
			}
				
			function createGRR(grrarray,vacno,podocnos,brchid){
				var x=new XMLHttpRequest();
				var delterms=$('txtgrrdeldet').val();
				var paymentterms=$('txtgrrpaydet').val();
				var desc=$('txtgrrdesc').val();
				var loc=$('#cmbgrrlocation').val();
				var invno=$('#txtgrrinvno').val();
				if(loc==''){
					$.messager.alert('Message','Please Select Location');
					return 0;
				}
				//alert()
				if(invno==''){
					$.messager.alert('Message','Fillup Invoice Number');
					return 0;
				}
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items= x.responseText.trim().split('####');
					if(parseInt(items[0])>0){
						$.messager.alert('message','GRR - '+items[1]+' Successfully Generated');
						$('#modalgrr').modal('hide');
						$('#modalgrr').find("input,select").val('').end();
						$('#grrgrid').jqxGrid('clear');
						getInitChartData();
						funload();
					}
					else{
						$.messager.alert('message','Not Generated');
						$('#modalgrr').modal('hide');
						$('#modalgrr').find("input,select").val('').end();
					}
					
				}
				else
				{
				}
				}
				x.open("GET", "CreateGRR.jsp?grrarray="+encodeURIComponent(grrarray)+"&vacno="+vacno+"&podocnos="+podocnos+'&date='+$("#grrdate").val()+'&desc='+desc+'&delterms='+delterms+'&paymentterms='+paymentterms+'&loc='+loc+'&invno='+invno+'&brchid='+brchid, true);   
				x.send();
			}
		function funCreatePIV(){

			var pivarray=new Array();
			
	
				var rows = $("#pivGrid").jqxGrid('getrows');

				/* var rows1=$("#pivGrid").jqxGrid('selectedrowindexes');
				rows1 = rows1.sort(function(a,b){return a - b});
			 
				if(rows1.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select documents.');
				return false;
				}  */
							   
				/* psrno unitdocno prodoc qty unitprice discount nettotal */
				var rows = $("#pivGrid").jqxGrid('getrows');
				   $('#pivGrid').val(rows.length);
				   var producttotal=0;
				   var nettotaldown=0;
				   var ordervalue=0;
				   var brchid;
				  //alert($('#gridlength').val());
				  for(var i=0 ; i < rows.length ; i++){
									  newTextBox = $(document.createElement("input")) 
								      .attr("type", "dil")
								      .attr("id", "sertest"+i)
								      .attr("name", "sertest"+i) 
								      .attr("hidden", "true");           
								  
								 /*  newTextBox.val(rows[i].pivpsrno+"::"+rows[i].pivprodoc+" :: "+rows[i].pivunitdocno+" :: "+rows[i].pivqty+" :: "
										   +rows[i].pivunitprice+" :: "+rows[i].pivtotal+" :: "+rows[i].pivdiscount+" :: "+rows[i].pivnettotal+" :: "+rows[i].pivsaveqty
										   +" :: "+rows[i].pivchecktype+" :: "+rows[i].pivspecid+" :: "+rows[i].pivdiscper+" :: "+rows[i].pivstockid+" :: "+rows[i].pivoldqty+" :: "+rows[i].pivfoc
										   +" :: "+rows[i].pivorderdiscper+" :: "+rows[i].pivorderamount+"::"+rows[i].pivtaxper+"::"+rows[i].pivtaxperamt+"::"+rows[i].pivtaxamount+"::"+rows[i].pivbatch_no+"::"
										   +$('#pivGrid').jqxGrid('getcelltext', i, "pivexp_date")+"::"+rows[i].pivtaxdocno+"::"+"0000"+"::");  */
								  //newTextBox.appendTo('form');
										   
										   $('#hidcurid').val(rows[i].pivcurid);
										   $('#hidrate').val(rows[i].pivrate);
								  pivarray.push(rows[i].pivsrno+"::"+rows[i].pivprodoc+" :: "+rows[i].pivunitdocno+" :: "+rows[i].pivqty+" :: "
										   +rows[i].pivunitprice+" :: "+rows[i].pivtotal+" :: "+rows[i].pivdiscount+" :: "+rows[i].pivnettotal+" :: "+rows[i].pivsaveqty
										   +" :: "+rows[i].pivchecktype+" :: "+rows[i].pivspecid+" :: "+rows[i].pivdiscper+" :: "+rows[i].pivstockid+" :: "+rows[i].pivoldqty+" :: "+rows[i].pivfoc
										   +" :: "+rows[i].pivorderdiscper+" :: "+rows[i].pivorderamount+"::"+rows[i].pivtaxper+"::"+rows[i].pivtaxperamt+"::"+rows[i].pivtaxamount+"::"+rows[i].pivbatch_no+"::"
										   +$('#pivGrid').jqxGrid('getcelltext', i, "pivexp_date")+"::"+rows[i].pivtaxdocno+"::"+"0000"+"::");
				 
								  producttotal=producttotal+rows[i].pivnettotal;
								  nettotaldown=nettotaldown+rows[i].pivtaxamount;
								  ordervalue=ordervalue+rows[i].pivtaxamount;
								  brchid=rows[i].brhid;
				  }   
				
				  $.messager.confirm('Confirm', 'Do you want to Create PIV?', function(r){
						if (r){
							createPIV(pivarray,producttotal,nettotaldown,ordervalue,brchid);	
						}
					});
			}
				
			function createPIV(pivarray,producttotal,nettotaldown,ordervalue,brchid){
				var maindate = $('#pivdate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(maindate);
				   if(validdate==0){
				   return 0; 
				   }
				var pivcurid=$('#hidcurid').val();
				var pivrate=$('#hidrate').val();
				//var brchid = $('#cmbbranch').val();
				//alert("Brid : "+brchid);
				var cmbpivbilltype=$('#cmbpivbilltype').val();
				var cmbpivlocation=$('#cmbpivlocation').val();
				var txtpivinvno=$('#txtpivinvno').val();
				var txtpivdeldet=$('#txtpivdeldet').val();
				var txtpivpaydet=$('#txtpivpaydet').val();
				var txtpivdesc=$('#txtpivdesc').val();
				var acno=$('#acno').val();
				if(cmbpivbilltype==''){
					$.messager.alert('Message','Please Select Bill type');
					return 0;
				}
				if(cmbpivlocation==''){
					$.messager.alert('Message','Please Select Location');
					return 0;
				}
				//alert(cmbpivlocation)
				if(txtpivinvno==''){
					$.messager.alert('Message','Fillup Invoice Number');
					return 0;
				}
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items= x.responseText.trim().split('####');
					if(parseInt(items[0])>0){
						$.messager.alert('message','PIV - '+items[1]+' Successfully Generated');
						$('#modalpiv').modal('hide');
						$('#modalpiv').find("input,select").val('').end();
						getBill();

						getInitChartData();
						funload();
						//$('#modalgrr').modal('hide');
						//$('#grrgrid').jqxGrid('clear');
						
					}
					else{
						$.messager.alert('message','Not Generated');
						$('#modalpiv').modal('hide');
						$('#modalpiv').find("input,select").val('').end();
						getBill();

					}
					
				}
				else
				{
				}
				}
				x.open("GET", "CreatePiv.jsp?pivarray="+encodeURIComponent(pivarray)+"&vacno="+acno+'&date='+$("#pivdate").val()+'&desc='+txtpivdesc+'&delterms='+txtpivdeldet+'&paymentterms='+txtpivpaydet+'&loc='+cmbpivlocation+'&invno='+txtpivinvno+'&cmbpivbilltype='+cmbpivbilltype+'&pivrate='+pivrate+'&pivcurid='+pivcurid+'&producttotal='+producttotal+'&nettotaldown='+nettotaldown+'&ordervalue='+ordervalue+'&brchid='+brchid, true);   
				x.send();
			}
			
		
		
</script>
</body>
</html>
