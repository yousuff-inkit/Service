<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="s" uri="/struts-tags" %>   
  <% String contextPath=request.getContextPath();%>   

<!DOCTYPE html>
<html lang="en">
<head>
<title>Presales Management</title> 
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
<link href="<%=contextPath%>/css/css/cardstyle.css" rel="stylesheet"  type="text/css" />  
  <style type="text/css">
    
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
      width:213px;
     overflow: auto;
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
        margin-top: 5px; 
    }
     .card-outer-container{
    	 display:inline-block;
		 width: calc(97%/6);
	 }
	 .card-container {
        margin-bottom: 3px;           
	  }
   .custompanel2{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 15px;
      padding-bottom: 15px;
      border-radius: 8px; 
    }
    .custompanel3{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 15px;
      padding-bottom: 15px;
    }
  </style>
</head>
<body>
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>  
            </div>
        </div>
    </div>
  <div class="container-fluid">
      	<div class="row padtop">
      	<div class="card-outer-container" id="enqdiv"> 
                <div class="card-container" id="enqid">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <div id="enq"></div>
                            <span><img src="../icons/icons-collaboration.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Enquired</span><br/>        
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-outer-container" id="quotdiv"> 
                <div class="card-container" id="quotid">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="quot"></div>
                            <span><img src="../icons/icons-paycheque.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Quoted</span><br/>
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>	
            <div class="card-outer-container" id="unmgapdiv"> 
                <div class="card-container" id="unmgapid">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">  
                            <div id="unmgap"></div>
                            <span><img src="../icons/icons-paycheque.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Under Mngt. Appr.</span><br/>  
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>	 
            <div class="card-outer-container" id="newcrmdiv"> 
                <div class="card-container" id="newcrmid">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="newcrm"></div>
                            <span><img src="../icons/icons-survey.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>New Client</span><br/>
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>	
            <div class="card-outer-container" id="amcdiv"> 
                <div class="card-container" id="amcid">
                    <div class="card-body  text-center">
                        <div class="card-chart-container"> 
                            <div id="amc"></div>
                            <span><img src="../icons/icons-ledger.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Contracted</span><br/>
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <form class="form-inline"> 
        <div class="primarypanel custompanel2">
	                       <div class="form-group col-auto">
				           <label class="form-group" for="cmbpriority">Branch:</label>
    						<div class="form-group">
      							<select id="cmbbranch" name="cmbbranch" onchange="getInitChartData();funload();"></select>
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
        	<!-- <button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button> -->
        </div>
         <div class="otherpanel custompanel">         
          <button type="button" class="btn btn-default" id="btnenqview"><i class="fa fa-etsy" aria-hidden="true" data-toggle="tooltip"  title="View Enquiry" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnenquiryfollowup" ><i class="fa fa-th-list" aria-hidden="true" data-toggle="tooltip" title="Enquiry Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnclientupdate" ><i class="fa fa-pencil-square-o" aria-hidden="true" data-toggle="tooltip" title="Client Update" data-placement="bottom"></i></button>  
          <button type="button" class="btn btn-default" id="btnsurveyupdate"><i class="fa fa-pencil" aria-hidden="true" data-toggle="tooltip"  title="Survey Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteprepare"  ><i class="fa fa-cogs" aria-hidden="true" data-toggle="tooltip" title="Quote Preparation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteview"><i class="fa fa-quora" aria-hidden="true" data-toggle="tooltip"  title="View Quotation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquotefollowup" ><i class="fa fa-exchange" aria-hidden="true" data-toggle="tooltip" title="Quote Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnmail" ><i class="fa fa-envelope" aria-hidden="true" data-toggle="tooltip" title="Send Mail" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncreateclient"><i class="fa fa-user-o" aria-hidden="true" data-toggle="tooltip" title="Create Client" data-placement="bottom"></i></button>
          <!-- <button type="button" class="btn btn-default" id="btnquoteapproval"><i class="fa fa-thumbs-o-up" aria-hidden="true" data-toggle="tooltip"  title="Quote Approval" data-placement="bottom"></i></button> -->
          <button type="button" class="btn btn-default" id="btnchecklist"><i class="fa fa-check-circle" aria-hidden="true" data-toggle="tooltip"  title="Checklist" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncontractprepare"  ><i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Service Contract Creation" data-placement="bottom"></i></button>  
          <button type="button" class="btn btn-default" id="btncontractview"><i class="fa fa-scribd" aria-hidden="true" data-toggle="tooltip"  title="View Service Contract" data-placement="bottom"></i></button>
         <!--  <button type="button" class="btn btn-default" id="btnconfirm"  ><i class="fa fa-check-square-o" aria-hidden="true" data-toggle="tooltip" title="Confirm" data-placement="bottom"></i></button>
          --> <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
         </div>   
         
          <div class="textpanel custompanel">       
           <table>  
		      <tr> 
			      <td align="left" width="20%" id="selectedid"> <label for="divid" id="selecteddiv" style="font-size:75%;padding-right:10px"></label> </td>                        
			      <td align="left" width="80%"> <label for="divid" id="lblselectedrowdetail" style="font-size:75%;"></label>      </td>  
			  </tr>                                          
		  </table>
	   </div>
				</form>        
			</div> 
		</div>	 
      </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="presalesdiv"><jsp:include page="presalesmanagementGrid.jsp"></jsp:include></div>
      </div>
    </div>
	 <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
      </div>
    </div>
	
	<div id="modalsurveyupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Survey Update<span></span></h4>
          		</div>
          		<div class="modal-body">
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        <div id="siteDiv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
					      </div>  
	          		</div>  
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        	<label for="siteselected" id="selectedsite"></label>
					      </div>  
	          		</div>  
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="route">Route :</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtroute" name="txtroute" style="width:85%;"  > 
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="gps">GPS X :</label>
    						<div class="col-sm-3 input-container">
      							<input type="text" id="txtgpsx" name="txtgpsx" style="width:90%;"> 
    						</div>
    						<label class="control-label col-sm-2" for="gps">GPS Y :</label>     
    						<div class="col-sm-3 input-container">  
      							<input type="text" id="txtgpsy" name="txtgpsy" style="width:90%;">     
    						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="desc">GPS URL :</label>    
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtdesc" name="txtdesc" style="width:85%;"  >     
    						</div>
  						</div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnsurvey">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalclient" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Client Creation<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="txtclientnw">Client:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtclientnw" name="txtclientnw" style="width:70%;"  >
    						</div>
  						</div>
  						
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtaddressnw">Address:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtaddressnw" name="txtaddressnw" style="width:70%;"  >
    						</div>   						     
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtmobnw">Mobile:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtmobnw" name="txtmobnw" style="width:70%;"  >
    						</div>   						     
  						</div>
  							<div class="form-group">
    						<label class="control-label col-sm-3" for="txtemailnw">Email:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtemailnw" name="txtemailnw" style="width:70%;"  >
    						</div>   						     
  						</div>
  						<%-- <div class="form-group">
    						<label class="control-label col-sm-3" for="cmbsalesman">Salesman:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="cmbsalesman" name="cmbsalesman"  style="width:70%;"  >
    						</div>
    						<input type="hidden" id="hidsalid" name="hidsalid" value='<s:property value="hidsalid"/>'/>     
  						</div> --%>
  						
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtsource">Source:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtsource" name="txtsource" readonly placeholder="Press F3 To Search" onKeyDown="getSource(event);" style="width:70%;"  >
    						</div>
    						<input type="hidden" id="sourceid" name="sourceid" value='<s:property value="sourceid"/>'/>     
  						</div>
  						
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtarea">Area:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txtarea" name="txtarea" readonly placeholder="press F3 to search"  onKeyDown=" getareas(event);"  >
      							<input type="text" id="txtareadet" name="txtareadet" readonly style="width:68%;" />
    						</div>
    						<input type="hidden" id="txtareaid" name="txtareaid"/> 
    						   
  						</div>
  						<div class="form-group">
	  						<label class="control-label col-sm-3" for="cmbcategory">Category:</label>
	  						<div class="col-sm-9 input-container">
	  						  <select id="cmbcategory" name="cmbcategory" style="width:70%;" onchange="getCategoryAccountGroup(this.value);">
	  						  <option value="">--Select--</option></select>  
	  						</div>
  						</div>
  						<div class="form-group">
	  						<label class="control-label col-sm-3" for="cmbacgroup">Account Group:</label>
	  						<div class="col-sm-9 input-container">
	  						  <select id="cmbacgroup" name="cmbacgroup" style="width:70%;">
	  						  <option value="">--Select--</option></select>  
	  						</div>
  						</div>
  						<div class="form-group">
    						<label class="control-label col-sm-3" for="txtaddressnw">TRN No:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="txttinno" name="txttinno" style="width:70%;"  >
    						</div>   						     
  						</div>
  						<%-- <div class="form-group">
    						<label class="control-label col-sm-3" for="cmbcperson">Contact Person:</label>
    						<div class="col-sm-9 input-container">
      							<input type="text" id="cmbcperson" name="cmbcperson" style="width:70%;"  >
    						</div>
    						<input type="hidden" id="hidcmbcpersonid" name="hidcmbcpersonid" value='<s:property value="hidcmbcpersonid"/>'/>     
  						</div> --%>
  						
  	
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclientcreation">Create</button>
            		
          		</div>
        </div>
      </div>
    </div>
    <div id="modalquotefollowup" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Quotation Follow-Up<span></span></h4>    
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						
    						 <label class="control-label col-sm-3" for="cmbprocess">Process</label>
							 <div class="col-sm-9 input-container">
							 <select name="cmbprocess" id="cmbprocess" style="width:52%;" name="cmbprocess" onChange="funtxtenable();"  value='<s:property value="cmbprocess"/>'></select>
  						</div> 
  						</div>
  						
                         <div class="form-group">   
                          <label class="control-label col-sm-3" for="cmbdecline">Decline status</label>
							<div class="col-sm-9 input-container">
							<select name="cmbdecline" id="cmbdecline" style="width:90%;" name="cmbdecline" onChange=""  value='<s:property value="cmbdecline"/>'></select>
							</div></div>
							<div class="form-group">
							 <label class="control-label col-sm-3" for="cmbfollowup">Follow-Up status</label>
							 <div class="col-sm-9 input-container">
							 <select name="cmbfollowup" id="cmbfollowup" style="width:52%;" name="cmbfollowup" onChange=""  value='<s:property value="cmbfollowup"/>'></select>
							 </div>
							 </div>
							 <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Date</label></td>
						      <div class="col-sm-9 input-container">
						     <div id="date" name="date" value='<s:property value="date"/>'></div>
						     </div>
						     </div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Remarks</label>
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="txtremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="txtremarks" ></textarea>
  						</div>
  						</div>  
  						</div>
  						
  						
            		</div>
          		
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnqotflwp">Save Changes</button>
            		
          		</div>
          		</div>
        </div>
      </div>
      <div id="modalenquiryfollowup" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Enquiry Follow-Up<span></span></h4>      
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
						 <div class="form-group">
							 <label class="control-label col-sm-3" for="cmbenqprocess">Process</label>  
							 <div class="col-sm-9 input-container">  
							 <select name="cmbenqprocess" id="cmbenqprocess" style="width:52%;" onChange="funenqdisable();" class="form-control input-sm">  
							 <option value="1">Follow-Up</option><option value="2">Drop</option></select>  
							 </div>  
						 </div>  
						 <div class="form-group">   
                            <label class="control-label col-sm-3" for="cmbreason">Reason</label>  
							<div class="col-sm-9 input-container">
							<select name="cmbreason" id="cmbreason" style="width:90%;" name="cmbreason"  class="form-control input-sm"  value='<s:property value="cmbreason"/>'></select>  
							</div>
						</div>  
						 <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Date</label>   
						      <div class="col-sm-9 input-container">
						     <div id="enqflwupdate"></div>
						     </div>
						  </div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="Remarks">Remarks</label>    
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="enqflwupremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="enqflwupremarks"  class="form-control input-sm"></textarea>
  						</div>
  						</div>  
  						</div>  
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnenqflwp">Save Changes</button>
          		</div>
          		</div>
        </div>
      </div>
      <div id="modalchecklist" class="modal fade" role="dialog">  
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>  
            		<h4 class="modal-title">Checklist<span></span></h4>
          		</div>
          		<div class="modal-body">
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        <div id="chklistDiv"><jsp:include page="checklistGrid.jsp"></jsp:include></div>
					      </div>  
	          		</div>  
	          		<div class="form-horizontal">   
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        	<label for="returnedselected" id="returnedstatus"></label>       
					      </div>  
	          		</div>  
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnchecklistsave">Save Changes</button>  
            		
          		</div>
        </div>
      </div>
    </div>
    <!-- Comments Modal-->
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Comments</h4>
          </div>
          <div class="modal-body">
            <div class="comments-outer-container container-fluid">
              <div class="comments-container">
                
              </div>
              <div class="create-msg-container">
                <!-- <div class="container-fluid"> -->
                  <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      <div class="input-group">
                        <input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                        <div class="input-group-btn">
                          <button type="button" id="btncommentsend" class="btn btn-default">
                            <i class="fa fa-paper-plane"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                <!-- </div> -->
              </div>
            </div>
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>
    <div id="modalpresaleslog" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Presales Log</h4>  
           <!--  <h6 class="modal-title" style="text-align:center"><label class="status" id="lblclientstatus9" name="lblclientstatus9"></label></h6>   -->
          </div>
          <div class="modal-body">
          <div id="wrkdiv"><jsp:include page="preSalesLogGrid.jsp"></jsp:include></div>
          </div>
          <<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          		</div> 
        </div>  
      </div>
       <div id="sidesearchwndow">
	   <div ></div>
	</div>
    </div>
     <div id="modalclientupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Client Update<span></span></h4>         
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
						 <div class="form-group">
							 <label class="control-label col-sm-1" for="clientSearch">Client</label>  
							 <div class="col-sm-11 input-container">  
							    <div id="cldiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearch.jsp"></jsp:include></div>
                                <input type="hidden" id="hidcldocno" name="hidcldocno"/> 
                                <input type="hidden" id="hidclient" name="hidclient"/>    
							 </div>  
						 </div>  
  						</div>  
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnclientsave">Save Changes</button>
          		</div>
          		</div>
        </div>
      </div>
       <input type="hidden" name="hidreturned" id="hidreturned">        
       <input type="hidden" name="divname" id="divname"> 
       <input type="hidden" id="reportdocno" name="reportdocno">
       <input type="hidden" id="surveydocno" name="surveydocno">
       <input type="hidden" id="enqdocno" name="enqdocno">
       <input type="hidden" id="sitedocno" name="sitedocno" >  
       <input type="hidden" id="reftrno" name="reftrno" >
       <input type="hidden" id="salmanid" name="salmanid" >
       <input type="hidden" id="qottrno" name="qottrno" >
       <input type="hidden" id="qotchkno" name="qotchkno" >
       <input type="hidden" id="brhid1" name="brhid1">  
       <input type="hidden" id="refdtype" name="refdtype">
       <input type="hidden" id="client" name="client">
       <input type="hidden" id="cldocno" name="cldocno">
       <input type="hidden" id="address" name="address">
       <input type="hidden" id="pertel" name="pertel">
       <input type="hidden" id="per_mob" name="per_mob">
       <input type="hidden" id="mail1" name="mail1">
       <input type="hidden" id="salname" name="salname">
       <input type="hidden" id="salid" name="salid" >  
       <input type="hidden" id="hidchecklist" name="hidchecklist">  
       <input type="hidden" id="hidcheckrowno" name="hidcheckrowno"> 
       <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup">   
       <input type="hidden" id="hidcontrno" name="hidcontrno"> 
       <input type="hidden" id="hidpayterms" name="hidpayterms"> 
       <input type="hidden" id="hidgroupcompanies" name="hidgroupcompanies"> 
       <input type="hidden" id="hidbillingmethod" name="hidbillingmethod">   
       <input type="hidden" id="hidcperson" name="hidcperson"> 
       <input type="hidden" id="hidcpersonid" name="hidcpersonid"> 
       <input type="hidden" id="hiddesignation" name="hiddesignation"> 
       <input type="hidden" id="qotstatus" name="qotstatus">         
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
    	<%-- <%String name2=request.getParameter("name")==null?"":request.getParameter("name");%>
    	var formname='<%=name2%>';      
    	if(formname=="Pre Sales Management"){ --%>
    		$("#btncreateclient").hide();
    		$("#btncontractprepare").hide();
    		$("#selectedid").hide()  
    	/* }else{
    		$("#btncreateclient").show();
    		$("#btncontractprepare").show();  
    	}  */   
    	
    	$('[data-toggle="tooltip"]').tooltip();
		$('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	    $('#areainfowindow').jqxWindow('close');
   	    $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#sourcesearchwndow').jqxWindow('close');
		$("#enqflwupdate").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#date").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
		$("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		$('#btncreateclient').attr("disabled",true);
		$('#btnconfirm').attr("disabled",true);
		$('#cmbfollowup').attr("disabled",true);
		$('#cmbdecline').attr("disabled",true);
		funenqdisable();getBranch();getProcess();getPriority();getFollowupstatus();getDecline();getCategory();getGroup();getReason();
    	
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(fromdates.getFullYear(), fromdates.getMonth(), 1);   
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		$('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			   if(todates<fromdates){      
				   Swal.fire({  
	        			icon: 'warning',
						title: 'Warning',
						text: 'To Date Less Than From Date'
					});
			        return false;  
			  }else{
				  getInitChartData()
			  }     
		 });
		$('#fromdate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			   if(fromdates>todates){  
				   Swal.fire({  
	        			icon: 'warning',
						title: 'Warning',
						text: 'From Date Greater Than To Date' 
					});
			        return false;  
			   }else{
				   getInitChartData()
			   }   
		 });
		document.getElementById('selecteddiv').innerHTML=" - Enquired"; 
    	document.getElementById("divname").value="enq";  
    	$('.card-container').removeClass('cardactive');      
        $("#enqid").addClass('cardactive');  
    	
    	$('#btnattachs').click(function(){   
         	funAttachs(event);      
         });
    	 $('#btnmail').click(function(){   
         	var enqdocno=$('#hidrowno').val();  
          	if(enqdocno==""){
          		Swal.fire({
          			icon: 'warning',
  					title: 'Warning',
  					text: 'Please select a document'
  				});
          		return false;
          	} 
          	 var qottrno=$('#qottrno').val();  
	         if(qottrno=="" || qottrno=="0"){   
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Quotation is not created'
					});
	        		return false;
	         }
          	funSendmail();    
 	      });
    	 $('#btnenqview').click(function(){  
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
			viewEnquiry();    
		});
    	$('#btnquoteview').click(function(){    
			 var enqdocno=$('#reftrno').val();
	         if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         var qottrno=$('#qottrno').val();
	         if(qottrno=="" || qottrno=="0"){   
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Quotation is not created'
					});
	        		return false;
	         }
			 viewQuotation();                  
		});
    	$('#btncontractview').click(function(){    
			 var enqdocno=$('#reftrno').val();
	         if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         var contrno=$('#hidcontrno').val();  
	         if(contrno=="" || contrno=="0"){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Contract is not created'    
					});
	        		return false;
	         }
	         viewContract();                  
		});
    	$('#btnclientupdate').click(function(){    
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         $('#cldiv').load('clientSearch.jsp?id=1');       
			$('#modalclientupdate').modal('show');    
		});
		$('#btncreateclient').click(function(){  
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
			$('#modalclient').modal('show');  
		});
		$('#btnconfirm').click(function(){  
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         funUpdate(4);	
		});
		$('#btnsurveyupdate').click(function(){
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
			$('.load-wrapp').show();  
			$('#modalsurveyupdate').modal('show');
			$('#siteDiv').load('siteGrid.jsp?id=1&docno='+enqdocno);    
		});
		$('#btnchecklist').click(function(){  
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	        var qotno=$('#qottrno').val();    
		         if(qotno=="" || qotno=="0"){   
		    	      Swal.fire({
		    	    	    icon: 'warning',
		    				 title: 'Warning',
		    				 text: 'Quotation not created'  
		    		  });
		    	       return false;
		    } 
			$('.load-wrapp').show();  
			$('#modalchecklist').modal('show'); 
			funChecklistupdate();
			$('#chklistDiv').load('checklistGrid.jsp?id=1&docno='+qotno);        
		});
		$('#btnsubmit').click(function(){   
			 $('.load-wrapp').show();
			 getInitChartData();   
			 funload();
			 $('#reftrno').val('');
			 document.getElementById('lblselectedrowdetail').innerHTML='';      
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
		$('#btncomment').click(function(){
			getComments();
        });
		$('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var reftrno=$('#reftrno').val();
        	if(txtcomment==""){
        		swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(reftrno==""){
        		swal({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
		
		 $('#btnclientcreation').click(function(){
				funCreateClient();
	        });
		
        $('#btnqotflwp').click(function(){
			  $('#modalquotefollowup').modal('hide');
			  funQotflwp();  
	      });
        $('#btnenqflwp').click(function(){
			  funEnqflwp();       
	      });
        $('#btnsurvey').click(function(){
        	 funUpdate(1);     
        });
        $('#btnclientsave').click(function(){
       	     funUpdate(6);     
       });
		$('#btnquoteprepare').click(function(){
			    var enqdocno=$('#reftrno').val();  
	        	if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}else{
	        		 var qotno=$('#qotchkno').val();  
	        		 if(parseInt(qotno)>0){
	    	        		Swal.fire({
	    	        			icon: 'warning',
	    						title: 'Warning',
	    						text: 'Quotation Already Created'
	    					});
	    	        		return false;
	    	         }else{
	    	        	 lookforchanges(1);
	    	     }  
	        		
	        	}
			
	        });
		$('#btncontractprepare').click(function(){ 
		    var enqdocno=$('#reftrno').val(); 
		    var cldocno=$('#cldocno').val(); 
		    var qottrno=$('#qottrno').val(); 
        	if(enqdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	if(cldocno=="" || cldocno=="0"){      
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please convert to client first'  
				});
        		return false;
        	} 
        	validatechecklist(qottrno);  
            /* if(parseInt(checklist)>0){     
    	        		Swal.fire({
    	        			icon: 'warning',
    						title: 'Warning',
    						text: 'Check List is not fully updated'       
    					});
    	        		return false;
    	      }  */
    	      //lookforchanges(2);   
        });
        $('#btnenquiryfollowup').click(function(){
		    var enqdocno=$('#reftrno').val();  
        	if(enqdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
    	    }  
           $('#modalenquiryfollowup').modal('show');
        });
		$('#btnquotefollowup').click(function(){
		    var enqdocno=$('#reftrno').val();  
        	if(enqdocno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}else{
        		 var qotno=$('#qotchkno').val(); 
        		 if(qotno=="0" || qotno==""){   
    	        		Swal.fire({
    	        			icon: 'warning',
    						title: 'Warning',
    						text: 'Quotation not created yet'   
    					});
    	        		return false;
    	         }else{
    	        	  $('#modalquotefollowup').modal('show');       	
    	         }  
        	}
		
        });
		 $('#btnchecklistsave').click(function(){
        	 funUpdate(5);             
        });
        $('#txtarea').dblclick(function(){
  		  $('#areainfowindow').jqxWindow('open');
			  areaSearchContent('area.jsp?getarea=0');
			  });
        $('#txtsource').dblclick(function(){
	    	$('#sourcesearchwndow').jqxWindow('open');
			 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));  
	   });
        
	});
    function getSource(event){
  	  var x= event.keyCode;
  	  if(x==114){
   		 $('#sourcesearchwndow').jqxWindow('open');
   		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));   
   	 }
   	 else{
   	 }
    }
    function sourceinfoSearchContent(url) {
  	  $.get(url).done(function (data) {
  		  $('#sourcesearchwndow').jqxWindow('open');
  		  $('#sourcesearchwndow').jqxWindow('setContent', data);
  	  }); 
    }
	function SearchContent(url,id) {
    	$.get(url).done(function (data) {
  			$('#'+id).jqxWindow('setContent', data);
		}); 
	}
	function getComments(){
    	var reftrno=$('#reftrno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				$('.comments-container').html('');
				if(x.responseText.trim()!=""){
					var items=x.responseText.trim().split(",");
					var str='';
					for(var i=0;i<items.length;i++){
						str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
					}
					$('.comments-container').html($.parseHTML(str));		
				}
			
			}
			else
			{
			}
		}
		x.open("GET","getComments.jsp?reftrno="+reftrno,true);
		x.send();
    }
	function saveComment(){
    	var comment=$('#txtcomment').val();
    	var reftrno=$('#reftrno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				$('#txtcomment').val('');
				getComments();		
			}
			else
			{
			}  
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&reftrno="+reftrno,true);
		x.send();
    }
	
	function funCreate(id){    
		var client=document.getElementById("client").value;
		var cldocno=document.getElementById("cldocno").value;
		var refdocno=document.getElementById("enqdocno").value;
		var reftrno=document.getElementById("reftrno").value;
		var address=document.getElementById("address").value;
		var pertel=document.getElementById("pertel").value;
		var per_mob=document.getElementById("per_mob").value;
		var mail1=document.getElementById("mail1").value;
		var salname=document.getElementById("salname").value;
		var salid=document.getElementById("salid").value;
		var brch=document.getElementById("brhid1").value;
		var source=document.getElementById("txtsource").value;
		var sourceid=document.getElementById("sourceid").value;
		var qottrno=document.getElementById("qottrno").value;  
		
		var payterms=document.getElementById("hidpayterms").value; 
		var groupcompanies=document.getElementById("hidgroupcompanies").value; 
		var billingmethod=document.getElementById("hidbillingmethod").value;   
		var cperson=document.getElementById("hidcperson").value; 
		var cpersonid=document.getElementById("hidcpersonid").value; 
		var designation=document.getElementById("hiddesignation").value;   
		
		if(parseInt(id)==1){  
			var path1="com/skips/quotation/quotation.jsp";  
			 var name="Quotation";
			 var url=document.URL;
			var reurl=url.split("com/");  

		  window.parent.formName.value="Quotation";
		  window.parent.formCode.value="QOT";
		  window.parent.branchid.value=brch;
		  var detName="Quotation";  
		  var mode="A";
		   
		  
		  var path= path1+"?mod="+mode+"&brhid="+brch+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cldocno="+cldocno
				  +"&vocno="+refdocno+"&enqdocno="+reftrno+"&address="+address.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&telno="+pertel+"&mob="+per_mob
				  +"&mail="+mail1.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&salesman="+salname.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
				  +"&salid="+salid+"&sourceid="+sourceid+"&source="+source.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&grpname="+groupcompanies.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
                  +"&cpersonid="+cpersonid+"&cperson="+cperson.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&designation="+designation.replace("/\s/g","%20").replace('#','%23').replace('&','%26');     
		 
		   top.addTab( detName,reurl[0]+""+path);
		}
		
		if(parseInt(id)==2){    
			var path1="com/skips/servicecontract/servicecontract.jsp";    
			 var name="Service Contract";
			 var url=document.URL;
			var reurl=url.split("com/");  

		  window.parent.formName.value="Service Contract";
		  window.parent.formCode.value="AMC";   
		  window.parent.branchid.value=brch;
		  var detName="Service Contract";
		  var mode="A";  
		  var frompresales="1";     
		  var reftype="ENQ";
		  
		  var path= path1+"?mod="+mode+"&qottrno="+qottrno+"&brhid="+brch+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cldocno="+cldocno
				  +"&vocno="+refdocno+"&enqdocno="+reftrno+"&address="+address.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&telno="+pertel+"&mob="+per_mob
				  +"&mail="+mail1.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&salesman="+salname.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
				  +"&frompresales="+frompresales+"&salid="+salid+"&payterms="+payterms+"&billingmethod="+billingmethod+"&grpname="+groupcompanies.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&reftype="+reftype
				  +"&cpersonid="+cpersonid+"&cperson="+cperson.replace("/\s/g","%20").replace('#','%23').replace('&','%26');         
		 
		   top.addTab( detName,reurl[0]+""+path);      
		}
		
	}
	
	function getPriority() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				
	  			$('#cmbpriority').html($.parseHTML(optionsbranch));
	  			$('#cmbpriority').select2({
	  				placeholder:"Select Status",
	  				allowClear:true
	  			});
				
				
				
				
			} else {}
		}
		x.open("GET","getPriority.jsp", true);
		x.send();
	}
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbprocess').html($.parseHTML(optionsbranch));
	  			$('#cmbprocess').select2({
	  				placeholder:"Select Process",
	  				allowClear:true
	  			});
				
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	function funUpdate(chkevent){  
		var proname="",prname="",prdocno="",saldocno="",salname="",processid="";
		var docno = $('#reftrno').val();
		var brhid=$("#brhid1").val();
		if(parseInt(chkevent)==1){	
			var siteid = $('#sitedocno').val();
			var route= $('#txtroute').val(); 
			var gpsx= $('#txtgpsx').val();
			var gpsy= $('#txtgpsy').val();
			var desc= $('#txtdesc').val();  
			processid="Survery Update";     
			if(siteid==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a site!!!' 
					});
	  		      return false;
			 }
			if(route==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter route!!!'
					});
	  		      return false;
			 }
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$('.load-wrapp').show(); 
						console.log("====="+processid);
						saveSurvery(processid,siteid,route,gpsx,gpsy,desc,docno);
					}
			});
		}else if(parseInt(chkevent)==2){    	
			processid="Quotation";     
			funchanges(processid,docno,brhid);
		}else if(parseInt(chkevent)==3){    	
			processid="Contract";     
			funchanges(processid,docno,brhid);        
		}else if(parseInt(chkevent)==4){    	
			processid="Confirm";       
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Confirm?",  
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						funchanges(processid,docno,brhid); 
					}
			});
		}else if(parseInt(chkevent)==5){  
				 var gridarray=new Array();
				 var rows=$('#jqxChecklistGrid').jqxGrid('getrows');
				 var val=0,checksrno=0;
				 for(var i=0;i<rows.length;i++){
				    var chk=$('#jqxChecklistGrid').jqxGrid('getcellvalue',i,'chk');
				    var mandatory=$('#jqxChecklistGrid').jqxGrid('getcellvalue',i,'mandatory');  
					if(chk){  
						 gridarray.push(rows[i].checksrno+" :: "+rows[i].remarks+" :: "+rows[i].path+" :: "+rows[i].upload+" :: ");            
						 val++;
					}else{
						if(mandatory=="1"){      
							checksrno=1;  
						}
					}
				}
				if(val==0){
					swal.fire({  
						icon: 'warning',
						title: 'Warning',
						text:  'Please select a checklist'  
					});
	  		        return false;
				}
				
			
			processid="Checklist";       
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want save changes?",    
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						var qottrno = $('#qottrno').val();
						funchecklistchanges(processid,qottrno,brhid,gridarray,checksrno,docno);   
					}
			});
		}else if(parseInt(chkevent)==6){  	
			var client = $('#hidclient').val();
			var cldocno = $('#hidcldocno').val();
			processid="Client Update";       
			if(cldocno==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a client'  
					});
	  		      return false;
			 }
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$('.load-wrapp').show(); 
						saveClientChange(processid,client,cldocno,docno,brhid);   
					}
			});
		}else{}   
	}
	function saveClientChange(processid,client,cldocno,docno,brhid){      
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						         funload();  
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $('#modalclientupdate').modal('hide');   
								 $('#hidclient').val('');
								 $('#hidcldocno').val('');
								 $('#jqxclient').val('');  
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&proname="+encodeURIComponent(client)+"&prdocno="+cldocno+"&docno="+docno+"&brhid="+brhid,true);      
	x.send();      
	}
	function funchanges(processid,docno,brhid){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						    funload();
							if(processid=="Confirm"){
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Confirmed'  
									});
								 document.getElementById('lblselectedrowdetail').innerHTML="";    
								 $("#amcfollowupGrid").jqxGrid('clear');  
							}
						}else{
							if(processid=="Confirm"){
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Confirmed'  
									});
							}
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&docno="+docno+"&brhid="+brhid,true);      
	x.send();
	}
	 
	 function getFollowupstatus() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var srno  = items[0].split(",");
					var process = items[1].split(",");
					var optionsbranch = '<option value="" selected>-- Select -- </option>';
					for (var i = 0; i < process.length; i++) {
						optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
						+ process[i] + '</option>';
						
					}
					$('#cmbfollowup').html($.parseHTML(optionsbranch));
		  			$('#cmbfollowup').select2({
		  				placeholder:"Select Followup-Status",
		  				allowClear:true
		  			});
					
					
				} else {}
			}
			x.open("GET","getFollowup.jsp", true);
			x.send();
		}
		
		function getDecline() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var srno  = items[0].split(",");
					var process = items[1].split(",");
					var optionsbranch = '<option value="" selected>-- Select -- </option>';
					for (var i = 0; i < process.length; i++) {
						optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
						+ process[i] + '</option>';
						
					}
					$('#cmbdecline').html($.parseHTML(optionsbranch));
		  			$('#cmbdecline').select2({
		  				placeholder:"Select Decline-Status",
		  				allowClear:true
		  			});
					
					
				} else {}
			}
			x.open("GET","getDecline.jsp", true);
			x.send();
		}
		
		function funtxtenable()
		{
			var def=$('#cmbprocess option:selected').text().trim();
		
			if(def=='Follow-Up')
			{
				 $('#cmbfollowup').attr("disabled",false);
				 $('#cmbdecline').attr("disabled",true);
					 
			}
			else if(def=='Declined')
			{
				 $('#cmbdecline').attr("disabled",false);
				 $('#cmbfollowup').attr("disabled",true);
					 
			}
			
		}
		
		function funQotflwp(){
			var pro= $('#cmbprocess').val().split(":");
			var bibid=pro[0];
			var proname=pro[1];
			var fdocno="0";
            var fstatus="0";
			var ddocno="0";
			var dstatus="0";
			var def=$('#cmbprocess option:selected').text().trim();
			
			if(def=='Follow-Up')
			{
				var prio= $('#cmbfollowup').val().split(":");
				 fdocno=prio[0];
				 fstatus=prio[1];
					 
			}
			else if(def=='Declined')
			{
				var dec= $('#cmbdecline').val().split(":");
				 ddocno=dec[0];
				 dstatus=dec[1];
					 
			}else if(def=='Approve'){
				var qotstatus=$('#qotstatus').val();
				if(parseInt(qotstatus)==0){
					swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Quotation approval is pending .'
					});
	  		      return false;
				}
			}
			var date =  $('#date').val();
			var branchid = $('#brhid1').val();  
			var remarks = $('#txtremarks').val().replace(/\n/g, '');
			var docno = $('#qottrno').val();
			var enqdocno = $('#reftrno').val();
			var rdtype = "QOT";      
			var client = $('#client').val();
			//var userid = $('#txtuserid').val();
			var qdate = $('#date').val(); 
			if(bibid==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Choose a Process.'
					});
	  		return false;
			 }
	//alert(bibid);                                                                                                             
			if(def=='Follow-Up' && fdocno==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Choose a Followup status.'
					});
	  		return false;
			 }
			 
			 if(remarks==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Please Enter Remarks.'
					});
	  		return false;
			 }
			 
			 Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to save changes?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$('.load-wrapp').show();
						saveQotflwp(bibid,proname,date,branchid,docno,rdtype,remarks,fdocno,fstatus,ddocno,dstatus,enqdocno,qdate,client);
					}
			});
		}
		    
		function saveQotflwp(bibid,proname,date,branchid,docno,rdtype,remarks,fdocno,fstatus,ddocno,dstatus,enqdocno,qdate,client){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
					var items=x.responseText;
					if(parseInt(items)=="1")
					{	
					$('#cmbprocess').val('');
					$('#cmbdecline').val('');
					$('#date').val(new Date());
					$('#txtremarks').val('');
				
					$('.load-wrapp').hide();
					Swal.fire({
						icon: 'success',
						title: 'Success',  
						text: ' Successfully Updated'
					});
					
					funload();
					$("#detailDiv").load("detailGrid.jsp?doc="+docno+"&enqdocno="+enqdocno);        
					}
					else
					{
						$('.load-wrapp').hide();
						Swal.fire({
							icon: 'warning',
							title: 'Warning',
							text: 'Not Updated'
						});
						return false;
					}
					}
			}
			
		x.open("GET","saveQotFlwp.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks+"&fdocno="+fdocno+"&fstatus="+fstatus+"&ddocno="+ddocno+"&dstatus="+dstatus+"&enqdocno="+enqdocno+"&qdate="+qdate+"&client="+client,true)
		x.send();
				
		}
		function getareas(event){
	      	 var x= event.keyCode;
	      	 if(x==114){
	      	  		$('#areainfowindow').jqxWindow('open');
	                areaSearchContent('area.jsp?getarea=0');  	 
	                
	      	 } else{}
	      }
	             	 
		 function areaSearchContent(url) {
		      	 $.get(url).done(function (data) {
		 		 $('#areainfowindow').jqxWindow('setContent', data);
		      	 }); 
		 }
		 
		 function funCreateClient(){
			    var txtaddressnw =  $('#txtaddressnw').val();
				var txtmobnw = $('#txtmobnw').val();
				var remarks = $('#txtremarks').val();
				var txtemailnw = $('#txtemailnw').val();
				var hidsourceid = $('#sourceid').val();
				var txtareaid = $('#txtareaid').val();
				var client = $('#txtclientnw').val();
				var cpersonid = $('#txtcperson').val();
				var salid =  $('#salmanid').val();
				var reftrno = $('#reftrno').val();
				var category = $('#cmbcategory').val();
				var acgroup = $('#cmbacgroup').val();
				var tinno = $('#txttinno').val();
				//alert("salid=="+salmanid);
				if(client==""){    
					Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please enter client name!!!'
					});
					return false;
				}
				if(category==""){    
					Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please select a category!!!'  
					});
					return false;
				}
				 Swal.fire({
						title: 'Are you sure?',
						text: "Do you want to save changes?",
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33',
						confirmButtonText: 'Yes'
				}).then((result) => {
						if (result.isConfirmed) {
							$('.load-wrapp').show();
							saveClient(txtaddressnw,txtmobnw,txtemailnw,hidsourceid,txtareaid,client,cpersonid,salid,reftrno,category,tinno,acgroup);
						}
				});
		 }
		 
		 function saveClient(txtaddressnw,txtmobnw,txtemailnw,hidsourceid,txtareaid,client,cpersonid,salid,reftrno,category,tinno,acgroup){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
			     			
						var items=x.responseText;
						if(parseInt(items)>0) {	
							$('.load-wrapp').hide();
							Swal.fire({
								icon: 'success',
								title: 'Success',  
								text: ' Successfully Client '+items+' Created'
							});
							$('#modalclient').modal('hide');
							funload();
						}
						else
						{
							$('.load-wrapp').hide();
							Swal.fire({
								icon: 'warning',
								title: 'Warning',
								text: 'Not Created'
							});
							return false;
						}
						}
				}
				
			x.open("GET","saveClient.jsp?address="+txtaddressnw+"&mobile="+txtmobnw+"&email="+txtemailnw+"&sourceid="+hidsourceid+"&areaid="+txtareaid+"&client="+client+"&cpersonid="+cpersonid+"&salid="+salid+"&enqdocno="+reftrno+"&category="+category+"&tinno="+tinno+"&acgroup="+acgroup,true)
			x.send();
		 }
		 
		 function getCategory() {
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('####');
						var categoryItems = items[0].split(",");
						var categoryIdItems = items[1].split(",");
						var optionscategory = '<option value="">--Select--</option>';
						for (var i = 0; i < categoryItems.length; i++) {
							optionscategory += '<option value="' + categoryIdItems[i] + '">'
									+ categoryItems[i] + '</option>';
						}
						//$("#cmbcategory").html(optionscategory);
						$('#cmbcategory').html($.parseHTML(optionscategory));
			  			$('#cmbcategory').select2({
			  				placeholder:"Select Category",
			  				allowClear:true
			  			});
						
					} else {
					}
				}
				x.open("GET", "getCategory.jsp", true);  
				x.send();
			}
		 function getGroup() {
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('####');
						var groupItems = items[0].split(",");
						var groupIdItems = items[1].split(",");
						var optionsgroup = '<option value="">--Select--</option>';
						for (var i = 0; i < groupItems.length; i++) {
							optionsgroup += '<option value="' + groupIdItems[i] + '">'
									+ groupItems[i] + '</option>';
						}
						$("select#cmbacgroup").html(optionsgroup);
						$('#cmbacgroup').select2({
			  				placeholder:"Select Account Group",  
			  				allowClear:true
			  			});
					} else {
					}
				}
				x.open("GET", "getGroup.jsp", true);
				x.send();
			}
		 
		 function getCategoryAccountGroup(a) { 
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
					    $('#hidcmbacgroup').val(items);
						
						if ($('#hidcmbacgroup').val() != "") {  
							$('#cmbacgroup').val($('#hidcmbacgroup').val()).trigger('change');
							console.log("Ac group="+$('#hidcmbacgroup').val());  
						}
					} else {
					}
				}
				x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
				x.send();
			}
			function saveSurvery(processid,siteid,route,gpsx,gpsy,desc,docno){
				var brhid=$("#brhid1").val();
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
						var items=x.responseText;
					    if(parseInt(items)=="1") {	
								$('.load-wrapp').hide();
								$('#txtroute').val(''); 
								$('#txtgpsx').val('');
								$('#txtgpsy').val('');
								$('#txtdesc').val('');  
								$('#siteDiv').load('siteGrid.jsp?id=1&docno='+docno);   
								Swal.fire({
									icon: 'success',
									title: 'Success',    
									text: ' Successfully Updated'
								});
					    } else {
								 $('.load-wrapp').hide();
								 Swal.fire({
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'
								 });
								 return false;
					   } 
				   }
				}
			x.open("GET","saveData.jsp?docno="+docno+"&processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&siteid="+siteid+"&route="+encodeURIComponent(route)+"&gpsx="+encodeURIComponent(gpsx)+"&gpsy="+encodeURIComponent(gpsy)+"&desc="+encodeURIComponent(desc),true);   
			x.send();
		 }
		 function lookforchanges(id){
			    var processid="Look Changes";   
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){  
						var items=x.responseText.split('####');
						if(parseInt(items[0])>0 && parseInt(id)==1){         	  
							 //$('#btnsubmit').trigger('click');
							 $('#qotchkno').val(items[0]);  
	    	        		 $('#qottrno').val(items[0]);  
							 Swal.fire({
								    icon: 'warning',
		    						title: 'Warning',
		    						text: 'Quotation Already Created'  
		    					});
		    	        		return false;
						}else if(parseInt(items[1])>0 && parseInt(id)==2){      
							 //$('#btnsubmit').trigger('click');
							 Swal.fire({
								    icon: 'warning',
		    						title: 'Warning',
		    						text: 'Service Contract Already Created'  
		    					});
		    	        		return false;
						}else{
							if(parseInt(id)==1){
								 //funUpdate(2);  
		    	        		 funCreate(1); 
							}
							if(parseInt(id)==2){    
								 funUpdate(3);
		    	        	     funCreate(2);  
							}
						} 
						}
				}
					
			x.open("GET","lookforchangesDone.jsp?docno="+$('#reftrno').val()+"&processid="+encodeURIComponent(processid),true);       
			x.send();
		}
		function getInitChartData(){
			  var brhid=$('#cmbbranch').val();
			  var fromdate= $("#fromdate").val();
			  var todate= $("#todate").val();
			  var x=new XMLHttpRequest();
			  x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim();
					var guagedata=JSON.parse(items);           
			        
		          	$("#enq").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.enqcount);
		        	$("#quot").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.quotcount);  
		          	$("#newcrm").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.newcrmcount);	
		          	$("#amc").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.amccount);
		        	$("#unmgap").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.unmgapcount);
					
				}
				else{  
				}
			}
			x.open("GET","getInitChartData.jsp?brhid="+brhid+'&froms='+fromdate+'&tos='+todate,true);                              
			x.send();    
		 }
		$('div').click(function() {
			  var divid=$(this).attr('id');  
			  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
				  var realid=divid.replace(/div/g, "");
				  if(realid=="enq" || realid=="newcrm" || realid=="amc" || realid=="quot" || realid=="unmgap"){  
					  $("#amcfollowupGrid").jqxGrid('clear');
					  $('#btnconfirm').attr("disabled",true);
					  document.getElementById("divname").value=realid;
					  $('.card-container').removeClass('cardactive');      
			          $("#"+realid+"id").addClass('cardactive'); 
					  document.getElementById('lblselectedrowdetail').innerHTML="";   
					  funload();             
				  }
				  if(realid=="enq"){ 
					  document.getElementById('selecteddiv').innerHTML=" - Enquired";
				  }else if(realid=="newcrm"){
					  document.getElementById('selecteddiv').innerHTML=" - New Client";  
				  }else if(realid=="amc"){
					  document.getElementById('selecteddiv').innerHTML=" - Contracted";
				  }else if(realid=="quot"){
					  document.getElementById('selecteddiv').innerHTML=" - Quoted";  
				  }else if(realid=="unmgap"){
					  document.getElementById('selecteddiv').innerHTML=" - Under Mngt. Approval";    
				  }else{}   
			  }
		  });
		function funload(){
			 $('.load-wrapp').show();  
			 $("#amcfollowupGrid").jqxGrid('clear');
			 var divname=$('#divname').val();  
			 var brhid=$('#cmbbranch').val();
			 var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			 $('#presalesdiv').load('presalesmanagementGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname);  
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
		function funAttachs(event){                         
			var brchid=document.getElementById("brhid1").value;  
	   		var docno=document.getElementById("enqdocno").value;  
	   		var url=document.URL;
			var reurl=url.split("com/");
	 		if(docno!="" && docno!="0"){                
	   			var frmdet="ENQ"; 
	   			var fname="Enquiry";
	   		    var  myWindow= window.open(reurl[0]+"com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
	   		}else{   
				swal({
					icon: 'warning',
					title: 'Warning',
					text: 'Select a Document....!'                                   
				});
				return;
			    }               
		   }
		function funchecklistchanges(processid,qottrno,brhid,checklist,checksrno,docno){      
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText;
						 if(parseInt(items)=="1"){  	  
							    funload();
								if(processid=="Checklist"){
									 swal.fire({  
										    icon: 'success',
											title: 'Success',
											text: 'Successfully Updated'  
										});
									 //$('#modalchecklist').modal('hide');     
									 $('#chklistDiv').load('checklistGrid.jsp?id=1&docno='+qottrno);        
								}  
							}else{
								if(processid=="Checklist"){
									 swal.fire({  
										    icon: 'warning',
											title: 'Warning',
											text: 'Not Updated'  
										});
								}
							} 
					}
			}    
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&qottrno="+qottrno+"&docno="+docno+"&brhid="+brhid+"&checklist="+encodeURIComponent(checklist),true);      
		x.send();
		}
		function viewEnquiry(){        
			var refdocno=document.getElementById("enqdocno").value;
			var reftrno=document.getElementById("reftrno").value;
			var address=document.getElementById("address").value;
			var brch=document.getElementById("brhid1").value;
			
			var path1="com/skips/enquiry/enquiry.jsp";  
			var name="Enquiry";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Enquiry";
			window.parent.formCode.value="ENQ";
			window.parent.branchid.value=brch;
			var detName="Enquiry";  
			var mode="view";  
			  
			var path= path1+"?modes="+mode+"&brhid="+brch+"&docno="+reftrno+"&enqdocno="+refdocno;         
			top.addTab( detName,reurl[0]+""+path);
		}
		function viewQuotation(){           
			var qottrno=document.getElementById("qottrno").value;  
			var brch=document.getElementById("brhid1").value; 
			
			var path1="com/skips/quotation/quotation.jsp";      
			var name="Quotation";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Quotation";   
			window.parent.formCode.value="QOT";
			window.parent.branchid.value=brch;             
			var detName="Quotation";  
			var mode="view";  
			  
			var path= path1+"?modes="+mode+"&brhid="+brch+"&qottrno="+qottrno;             
			top.addTab( detName,reurl[0]+""+path);
		}
		function viewContract(){                             
			var contracttrno=document.getElementById("hidcontrno").value;         
			var brch=document.getElementById("brhid1").value; 
			
			var path1="com/skips/servicecontract/servicecontract.jsp";        
			var name="Service Contract";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Service Contract";            
			window.parent.formCode.value="AMC";
			window.parent.branchid.value=brch;             
			var detName="Service Contract";  
			var mode="view";  
			  
			var path= path1+"?modes="+mode+"&brhid="+brch+"&contrno="+contracttrno;              
			top.addTab( detName,reurl[0]+""+path);
		}
		function funEnqflwp(){
			var brhid=document.getElementById("brhid1").value;
			var date =  $('#enqflwupdate').val();
			var remarks = $('#enqflwupremarks').val().replace(/\n/g, '');
			var docno = $('#reftrno').val();  
			var qottrno = $('#qottrno').val();  
			var reason= $('#cmbreason').val().split(":")[0]; 
			var enqprocess = $('#cmbenqprocess').val(); 
			var rdtype = "ENQ"; 
			var process="Enquiry Followup";
			if(remarks==''){
				
				 swal.fire({
					    icon: 'warning',
						title: 'Warning',
						text: 'Please Enter Remarks.'
					});
	  		      return false;
			 }
			 
			 Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to save changes?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						$('.load-wrapp').show();
						saveEnqflwp(date,docno,rdtype,remarks,brhid,process,qottrno,reason,enqprocess);       
					}
			});
		}
		function saveEnqflwp(date,docno,rdtype,remarks,brhid,processid,qottrno,reason,enqprocess){          
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText;
						 if(parseInt(items)=="1"){  	  
							         funload(); 
									 swal.fire({  
										    icon: 'success',
											title: 'Success',
											text: 'Successfully Updated'  
										});
									 $('#modalenquiryfollowup').modal('hide');  
                                     if(enqprocess=="2"){
										 $('#amcfollowupGrid').jqxGrid('clear');  
									 }else{
										 $("#detailDiv").load("detailGrid.jsp?doc="+qottrno+"&enqdocno="+docno);  
									 } 
							}else{
									 swal.fire({  
										    icon: 'warning',
											title: 'Warning',
											text: 'Not Updated'    
										});
							} 
					}
			}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&enqprocess="+enqprocess+"&date="+date+"&rdtype="+rdtype+"&docno="+docno+"&brhid="+brhid+"&remarks="+encodeURIComponent(remarks)+"&reason="+reason,true);       
		x.send();
		}
		function validatechecklist(qottrno){           
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText;
						 if(parseInt(items)>0){    	  
									 Swal.fire({
				    	        			icon: 'warning',
				    						title: 'Warning',
				    						text: 'Check List is not fully updated'       
				    					});
							}else{
								lookforchanges(2); 
							} 
					}
			}  
		x.open("GET","validatechecklist.jsp?qottrno="+qottrno,true);          
		x.send();
		}
		function funSendmail(){ 
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim().split("####");
					var email="";
					var cldocno="";
					var msg="";      
					var client="";
					var subject="Quotation";    
					//console.log(items[0]+"="+items[1]+"="+items[2]);  
					if(items!=""){
						 msg=items[0];
					     email=items[1];
					     cldocno=items[2];
					     //client=items[3];    
					}
					var brchid=document.getElementById("brhid1").value;
					var userid="<%= session.getAttribute("USERID").toString() %>";     
			   		var contrctno=document.getElementById("qotchkno").value;       
			   		console.log(items[0]+"="+items[1]+"="+items[2]);   
			   		var frmdet="QOT";        
			   		var dtype="QOT";        
			   		var fname="Quotation";
			   		var reftype="PSM";    
			   		console.log(contrctno+"===="+brchid);     
			   		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+document.getElementById("brhid1").value+"&frmname="+fname+"&reftype="+reftype+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet+"&subject="+encodeURIComponent(subject)+"&msg="+encodeURIComponent(msg),"E-Mail","menubar=0,resizable=1,width=900,height=950"); 
				}
			}      
			x.open("GET","sendMail.jsp?trno="+$('#qottrno').val(),true);                
			x.send();        
		}
		function getReason() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var srno  = items[0].split(",");
					var process = items[1].split(",");
					var optionsbranch = '<option value="" selected>-- Select -- </option>';
					for (var i = 0; i < process.length; i++) {
						optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
						+ process[i] + '</option>';
						
					}
					$('#cmbreason').html($.parseHTML(optionsbranch));
		  			$('#cmbreason').select2({
		  				placeholder:"Select a Reason",   
		  				allowClear:true
		  			});
					
					
				} else {}
			}
			x.open("GET","getDecline.jsp", true);
			x.send();
		}
		function funenqdisable(){  
			var process=$("#cmbenqprocess").val();
			if(process=="1"){
				$('#cmbreason').attr("disabled",true);
			}else{
				$('#cmbreason').attr("disabled",false);
			}
		}
		
		function funChecklistupdate(){
			var brhid=document.getElementById("brhid1").value;
			var docno = $('#cldocno').val();  
			var qottrno = $('#qottrno').val();  
			var rdtype = "CRM"; 
			var process="CHECKLIST AUTOSAVE";    
			saveChecklist(brhid,docno,qottrno,rdtype,process);       
		}
		function saveChecklist(brhid,docno,qottrno,rdtype,process){          
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText;
					$('#chklistDiv').load('checklistGrid.jsp?id=1&docno='+qottrno);    
					}
			}  
		x.open("GET","saveData.jsp?&brhid="+brhid+"&docno="+docno+"&qottrno="+qottrno+"&rdtype="+rdtype+"&processid="+encodeURIComponent(process),true);
		x.send();
		}
		
		
		
</script>
</body>
</html>
