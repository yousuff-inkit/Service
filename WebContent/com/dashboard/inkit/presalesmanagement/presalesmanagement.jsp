<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Presales Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

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
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
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
  </style>
</head>
<body>
 <!-- onload="getProcess();getPriority();getSalesman();getFollowupstatus();getDecline();getCategory();" -->
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <form class="form-inline"> 
      <div class="primarypanel custompanel">
          
       
	                       <div class="form-group col-auto">
				           <label class="form-group" for="cmbpriority">Branch:</label>
    						<div class="form-group">
      							<select id="cmbbranch" name="cmbbranch" ></select>
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
        	<button type="button" class="btn btn-default" id="btnattachs" data-toggle="tooltip" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
              
	       
			
				 
			       
		  
        </div>
         <div class="otherpanel custompanel">
        <!--  onclick="funENQ();" -->
        
          <button type="button" class="btn btn-default" id="btntypeupdate" data-target="#modalpriorityupdate"><i class="fa fa-pencil" aria-hidden="true" data-toggle="tooltip"  title="Type Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnstsupdate" data-target="#modalstatusupdate"><i class="fa fa-retweet" aria-hidden="true" data-toggle="tooltip"  title="Status Update" data-placement="bottom"></i></button>
	
		  <button type="button" class="btn btn-default" id="btnemployeeassign"><i class="fa fa-address-card" aria-hidden="true" data-toggle="tooltip" title="Update Employee" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncontractcreate"><i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Create Staffing Contract" data-placement="bottom"></i></button>
		  
        <!--  <button type="button" class="btn btn-default" id="btnsalesmanassign" data-target="#modalassignsalesman" ><i class="fa fa-address-card" aria-hidden="true" data-toggle="tooltip" title="Salesman Assignment" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteprepare"  ><i class="fa fa-cogs" aria-hidden="true" data-toggle="tooltip" title="Quote Preparation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquotefollowup"  data-target="#modalquotefollowup" ><i class="fa fa-exchange" aria-hidden="true" data-toggle="tooltip" title="Quote Followup" data-placement="bottom"></i></button>
           <button type="button" class="btn btn-default" id="btncreateclient" data-target="#modalclient" ><i class="fa fa-user-o" aria-hidden="true" data-toggle="tooltip" title="Know Your Client" data-placement="bottom"></i></button>
           <button type="button" class="btn btn-default" id="btnconfirm"  ><i class="fa fa-check-square-o" aria-hidden="true" data-toggle="tooltip" title="Confirm" data-placement="bottom"></i></button>
           <button type="button" class="btn btn-default " id="btnpresales" data-target="#modalpresaleslog" ><i class="fa fa-building" data-toggle="tooltip" title="Presales Log" data-placement="bottom" aria-hidden="true"></i></button> -->
       
        </div> 
        <div class="textpanel custompanel">
			<p class="h4">&nbsp;</p>
        </div> 
				</form>
						
						    <!-- <table style="padding-top: 10px" >        
				      <tr> 
				      <td  width="3%" align="left"><label class="branch" style="font-size: 11px">Branch</label></td> 
				      <td align="right" width="8%"><select name="cmbbranch" id="cmbbranch" style="min-width:100px;"><option value="">--Select--</option></select></td>                     
					       <td align="right" width="3%"><label class="branch" style="font-size: 11px">From </label></td>  
					       <td align="left" width="8%"><div id='fromdate' name='fromdate'></div></td>
					       <td  align="right" width="3%"><label class="branch" style="font-size: 11px">To</label></td>  
					       <td align="left"width="8%"><div id='todate' name='todate'></div></td>
				      </tr>                                      
				  </table>    -->
				 
			</div> 
		</div>	     
		 
      
       <!--  
        <div class="otherpanel custompanel">
          
        </div>  -->
        
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="partsplangriddiv"><jsp:include page="jobDetailsGrid.jsp"></jsp:include></div>
      </div>
    </div>
	 <%-- <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
      </div>
    </div> --%>
	
	<div id="modalpriorityupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Type Update<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbpriority">Type:</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbpriority" name="cmbpriority" style="width:70%;">
      							<option value="1">Internal</option><option value="2">External</option>
      							</select>
    						</div>
  						</div>
  						
  						
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnpriority">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
    <div id="modalstatusupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Status Update<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbstatus">Status:</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbstatus" name="cmbstatus" style="width:70%;">
      							<option value="1">Requested</option><option value="2">CV Submited</option><option value="3">Approved</option><option value="4">LPO Received</option>
      							</select>
    						</div>
  						</div>
  						
  						
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnstatus">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalclient" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Know Your Client<span></span></h4>
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
      							<!-- <input type="text" id="txtsource" name="txtsource"  placeholder="Press F3 To Search" onKeyDown="getSource(event);" style="width:70%;"  readonly> -->
    						<input type="text" id="txtsource" name="txtsource"  style="width:70%;"  readonly>
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
  						<select id="cmbcategory" name="cmbcategory" style="width:70%;">
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
    <div id="modalassignsalesman" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Salesman Assignment<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbsalman">Salesman:</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbsalman" name="cmbsalman" style="width:70%;"  value='<s:property value="cmbsalman"/>'></select>
    						</div>
  						</div>
  						
  						
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnassignsalman">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
    <div id="modalquotefollowup" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Quotation Followup<span></span></h4>
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
	 <label class="control-label col-sm-3" for="cmbfollowup">Followup status</label>
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
  </div>
 <input type="hidden" id="reportdocno" name="reportdocno" value='<s:property value="reportdocno"/>'>
       <input type="hidden" id="surveydocno" name="surveydocno" value='<s:property value="surveydocno"/>'>
  <input type="hidden" id="enqdocno" name="enqdocno" value='<s:property value="enqdocno"/>'>
   <input type="hidden" id="hidjobdetno" name="hidjobdetno" >
   <input type="hidden" id="reftrno" name="reftrno" >
    <input type="hidden" id="salmanid" name="salmanid" >
    <input type="hidden" id="qottrno" name="qottrno" >
    <input type="hidden" id="qotchkno" name="qotchkno" >
      <input type="hidden" id="brhid1" name="brhid1" value='<s:property value="brhid1"/>'>
      <input type="hidden" id="refdtype" name="refdtype" value='<s:property value="refdtype"/>'>
    
     <input type="hidden" id="client" name="client" value='<s:property value="client"/>'>
      <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'>
      <input type="hidden" id="address" name="address" value='<s:property value="address"/>'>
      
       <input type="hidden" id="pertel" name="pertel" value='<s:property value="pertel"/>'>
      <input type="hidden" id="per_mob" name="per_mob" value='<s:property value="per_mob"/>'>
    
     <input type="hidden" id="mail1" name="mail1" value='<s:property value="mail1"/>'>
      <input type="hidden" id="salname" name="salname" value='<s:property value="salname"/>'>
      <input type="hidden" id="salid" name="salid" >
      <input type="hidden" id="surtrno" name="surtrno" value='<s:property value="surtrno"/>'>
      <input type="hidden" id="esttrno" name="esttrno" value='<s:property value="esttrno"/>'>
       <input type="hidden" id="conttype" name="conttype" value='<s:property value="conttype"/>'> 
      <input type="hidden" id="contrtype" name="contrtype" value='<s:property value="contrtype"/>'>
      <input type="hidden" id="txtcpersonid" name="txtcpersonid" value='<s:property value="txtcpersonid"/>'>
      <input type="hidden" id="txtcperson" name="txtcperson" >
      <input type="hidden" id="txtcpersondet" name="txtcpersondet" value='<s:property value="txtcpersondet"/>'>
      <input type="hidden" id="txtsjobtype" name="txtsjobtype" value='<s:property value="txtsjobtype"/>'>  
      <input type="hidden" id="txtclienttaxper" name="txtclienttaxper" value='<s:property value="txtclienttaxper"/>'> 
  <div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="areainfowindow">
   <div ></div>
</div>
<div id="sourcesearchwndow">
   <div ></div>
</div>

<div id="employeeowindow">
   <div></div>
</div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	
    	setTimeout(funload, 1000);
        $('[data-toggle="tooltip"]').tooltip();
        $('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#partssearchwindow').jqxWindow('close'); 
		 $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	  $('#areainfowindow').jqxWindow('close');
   	 $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	  $('#sourcesearchwndow').jqxWindow('close');
	  
	  $('#employeeowindow').jqxWindow({ width: '40%', height: '68%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Employee Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#employeeowindow').jqxWindow('close');
		
		$('#btncontractcreate').attr("disabled",true);
	   
		 $("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1));  
		 
		 
		 $('#btncreateclient').attr("disabled",true);
		 $('#cmbfollowup').attr("disabled",true);
		  $('#cmbdecline').attr("disabled",true);
		  
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		 $('#todate').on('change', function (event) {
				
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
			 	 
			   if(fromdates<todates){
				   
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				 
			   return false;
			  }   
		 }); 
		getInitData();
				
		$('#btnsubmit').click(function(){
			var brhid=$('#cmbbranch').val();
			 var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			// var draftsmanname=$("#cldocno").val();
			 var areaid=$("#areaid").val();
			 var salesmanid=$("#cmbsalesman").val();
			$('.load-wrapp').show();
			$('#partsplangriddiv').load('jobDetailsGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate);
			
		});
		$('#btnexcel').click(function(){
			$("#partsplangriddiv").excelexportjs({
				containerid: "partsplangriddiv",
				datatype: 'json',
				dataset: null,
				gridId: "enqlistgrid",
				columns: getColumns("enqlistgrid"),
				worksheetName: "Presales Management"
			});
		});
		
		
		$('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(txtcomment==""){
        		swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
		 $('#btnattachs').click(function(){ 
				var jobcarddocno=$('#reftrno').val();
				if(jobcarddocno==""){
	        		Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	attach();      
	        });
		 $('#btnclientcreation').click(function(){
		        
				funCreateClient();
	        });
		
        $('#btnstatus').click(function(){
        
			funUpdate(2);
        });
      
		$('#btnpriority').click(function(){
			
			funUpdate(1);
        });
      
		 $('#btnconfirm').click(function(){
			
				funUpdate(3);
	        });
		 
		
		  $('#btnqotflwp').click(function(){
			  $('#modalquotefollowup').modal('hide');
			 
			  funQotflwp();
			 
	        });
			
		$('#btnemployeeassign').click(function(){
			funUpdate(3);
		});

		$('#btncontractcreate').click(function(){
			var rowindex1 =$('#rowindex').val();
			var jobcarddocno=$('#reftrno').val();
	        var enq_id=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "enq_id");
	        	if(jobcarddocno==""){
	        		Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}else{
					var x=new XMLHttpRequest();
					x.onreadystatechange=function(){
						if (x.readyState==4 && x.status==200){
							$('.comments-container').html('');
							if(x.responseText.trim()!=""){
								var items=x.responseText.trim();
								
								if(parseInt(items)>0){
									Swal.fire({
										type: 'error',
										title: 'Warning',
										text: 'Staffing Contract Already Created'
									});
									return false;
								}else{
									btncontract();
								}
							}
						}
					}
					x.open("GET","checkEnq.jsp?enq_id="+enq_id,true);
					x.send();
	        	}
		});
		 $('#btnquoteprepare').click(function(){
			 var jobcarddocno=$('#reftrno').val();
	        	//alert("jobcarddocno=="+jobcarddocno);
	        
	        	if(jobcarddocno==""){
	        		Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	else{
	        		 var qotno=$('#qotchkno').val();
	        			if(parseInt(qotno)>0){
	    	        		Swal.fire({
	    						type: 'error',
	    						title: 'Warning',
	    						text: 'Quotation Already Created'
	    					});
	    	        		return false;
	    	        	}
	    	        	else{
	    	        		 funUpdate(4);
	    	        		 /*btnqotation();*/
	    	        	}
	        		
	        	}
			
	        });
       
	   $('.otherpanel button').click(function(){
        	var jobcarddocno=$('#reftrno').val();
        	//alert("jobcarddocno=="+jobcarddocno);
        	var modaltarget=$(this).attr('data-target');
        	if(jobcarddocno==""){
        		Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	
        	if(modaltarget=="#modalquotefollowup"){
        		var qotno=$('#qottrno').val();
        		//alert("qotno=="+qotno);
        		if(qotno==0){
        			$(modaltarget).modal('hide');
            		Swal.fire({
    					type: 'error',
    					title: 'Warning',
    					text: 'Qotation Not Created'
    				});
            		return false;
            	}
        	}
        	$(modaltarget).modal('show');
        });
        
        $('#txtarea').dblclick(function(){
  		  $('#areainfowindow').jqxWindow('open');
			  areaSearchContent('area.jsp?getarea=0');
			  });
       /*  $('#txtsource').dblclick(function(){
	    	$('#sourcesearchwndow').jqxWindow('open');
			 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));  
	   }); */
        
	});
  /*   function getSource(event){
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
    } */
    
    function funload(){
    	var brhid=$('#cmbbranch').val();
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		// var draftsmanname=$("#cldocno").val();
		 var areaid=$("#areaid").val();
		 var salesmanid=$("#cmbsalesman").val();
		$('.load-wrapp').show();
		$('#partsplangriddiv').load('jobDetailsGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate);
    }
    
	function SearchContent(url,id) {
    	$.get(url).done(function (data) {
  			$('#'+id).jqxWindow('setContent', data);
		}); 
	}
	
	function getInitData(){
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data.trim());
			var htmldata='';
			htmldata='<option value="">All</option>';
			$.each(data.branchdata,function(index,value){
  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
  			});
  			$('#cmbbranch').html($.parseHTML(htmldata));
  			$('#cmbbranch').select2({
  				placeholder:"Select Branch",
  				allowClear:true
  			});
  			$('.load-wrapp').hide();
  			htmldata='<option value="">--Select--</option>';
  			$.each(data.vendordata,function(index,value){
  				htmldata+='<option value="'+value.docno+'" data-taxpercent="'+value.taxpercent+'" data-gridacno="'+value.gridacno+'" data-tax="'+value.tax+'">'+value.refname+'</option>';
  			});
  			$('#cmbvendor').html($.parseHTML(htmldata));
  			$('#cmbvendor').select2({
  				placeholder:"Select Vendor",
  				allowClear:true
  			});
		});
	}
	
	function getComments(){
    	var jobcarddocno=$('#jobcarddocno').val();
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
		x.open("GET","getComments.jsp?jobcarddocno="+jobcarddocno,true);
		x.send();
    }
	
	function saveComment(){
    	var comment=$('#txtcomment').val();
    	var jobcarddocno=$('#jobcarddocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				getComments();		
			}
			else
			{
			}
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&jobcarddocno="+jobcarddocno,true);
		x.send();
    }
	
	function btncontract(){
		   
		var rowindex1 =$('#rowindex').val();
		
		var clientname=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "clientid"); 
		var clientdet=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "name");
		var clientid=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "clientid");
		var refno=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "enq_id");
		var enqdocno=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "doc_no");
		var address=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "details");
		var mobile=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "contmob"); 
		var contactperson=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "cperson");
		var cptrno=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "cpersonid");
		var telno=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "telno");
		var email=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "email");
		var salesman=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "sal_name");
		var salesmandocno=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "sal_id");
		var enqtype=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "enqtype"); 
		var curid=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "curid"); 
		var brhid=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "brhid"); 
		var cmbreftype="ENQ";
		
		var path1="com/it/staffingcontract/staffingcontract.jsp";
		var name="Staffing Contract";
		var url=document.URL;
		var reurl=url.split("com/");

		 window.parent.formName.value="Staffing Contract";
		 window.parent.formCode.value="STC";
		 window.parent.branchid.value=brhid;
		 var detName="Staffing Contract";
		 var mode="A";
		   
		 var path= path1+"?mod="+mode+"&clientname="+encodeURIComponent(clientname)
		 +"&clientdet="+clientdet+"&clientid="+clientid+"&refno="+refno+"&enqdocno="+enqdocno+"&curid="+curid
				  +"&address="+encodeURIComponent(address)
				  +"&mobile="+mobile
				  +"&contactperson="+encodeURIComponent(contactperson)
				  +"&cptrno="+cptrno+"&telno="+telno
				  +"&email="+encodeURIComponent(email)
				  +"&salesman="+encodeURIComponent(salesman)
				  +"&salesmandocno="+encodeURIComponent(salesmandocno)
		 
		top.addTab( detName,reurl[0]+""+path);
	}
	
	function funENQ(){
		var jobcarddocno=$('#reftrno').val();
    	
    	if(jobcarddocno==""){
    		Swal.fire({
				type: 'error',
				title: 'Warning',
				text: 'Please select a document'
			});
    		return false;
    	}
		var refdocno=document.getElementById("enqdocno").value;
		var brch=document.getElementById("brhid1").value;
			
		 var path1="com/operations/marketing/enquirynewfrn/enquiry.jsp";
			 var name="Enquiry";
			 var url=document.URL;
			var reurl=url.split("com/");

		  window.parent.formName.value="Enquiry";
		  window.parent.formCode.value="ENQ";
		  window.parent.branchid.value=brch;
		  var detName="Enquiry";
		  var mode="view";
		   
		  
		  var path= path1+"?modes="+mode+"&brhid="+brch+"&enqdocno="+refdocno;
		 
		   top.addTab( detName,reurl[0]+""+path);
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
		
		var proname="",prname="",prdocno="",saldocno="",salname="";
		
		var docno = $('#reftrno').val();
		var jobdet = $('#hidjobdetno').val();
		//var salmanid= $('#salmanid').val();
		//var salmanid= $('#salname').val();
		
	if(parseInt(chkevent)==1){	
		var prio= $('#cmbpriority').val().split(":");
 		 prdocno=prio[0];
		 prname=prio[1];
		$('#modalpriorityupdate').modal('hide');
		proname="priority";
		if(prdocno==''){
			
			 swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Choose a Type'
				});
  		return false;
		 }
	}
	if(parseInt(chkevent)==2){	
		var salio= $('#cmbstatus').val().split(":");
 		 saldocno=salio[0];
		 salname=salio[1];
		$('#modalstatusupdate').modal('hide');
		proname="statu";
		if(saldocno==''){
			
			 swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Choose a Status'
				});
  		return false;
		 }
	}	
	if(parseInt(chkevent)==3){	
		var rowIndex =$('#rowindex').val();
	
 		saldocno=$('#jqxJobDetails').jqxGrid('getcellvalue', rowIndex, "empid");
		if(saldocno=='' || saldocno=='0'){
			
			 swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Select Employee'
				});
  		return false;
		 }
		proname="emp";
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
				saveGridData(proname,prdocno,prname,docno,saldocno,salname,chkevent,jobdet);
			}
	});
    
	}
	
	function saveGridData(proname,prdocno,prname,docno,saldocno,salname,chkevent,jobdet){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				 if(parseInt(chkevent)==4){	
					 
				 }
				 else{
					 if(parseInt(items)=="1")
						{	
							$('.load-wrapp').hide();
						$('#cmbpriority').val('');
						$('#cmbstatus').val('');
						Swal.fire({
							type: 'Success',
							title: 'Message',
							text: ' Successfully Updated'
						});
						
						$('#btnsubmit').trigger('click');
					//	funreload(event); 
				
						//disable();
						}
						else
						{
							$('.load-wrapp').hide();
							Swal.fire({
								type: 'Warning',
								title: 'Warning',
								text: 'Not Updated'
							});
							return false;
						} 
				 }
				
				}
		}
			
	x.open("GET","saveData.jsp?proname="+proname+"&prdocno="+prdocno+"&prname="+prname+"&docno="+docno+"&saldocno="+saldocno+"&salname="+salname+"&jobdetno="+jobdet,true);
	x.send();
			
	}
	
	function getSalesman() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
				//alert(items);
					items = items.trim().split('####');
					var salIdItems  = items[0].split(",");
					var salItems = items[1].split(",");
					var salusrlink= items[2].split(",");
					var optionssal="" ;
					var userid='<%=session.getAttribute("USERID").toString()%>';
					var first=salIdItems[0].trim();
					var frstsalusrlink=salusrlink[0].trim();
					/* if(userid!=first){
						optionssal += '<option value="" selected>--Select--</option>';
					} */
					for (var i = 0; i < salItems.length; i++) {
						optionssal += '<option value="' + salIdItems[i].trim() + ':'+salItems[i] +'">'
								      + salItems[i] + '</option>';
						/* optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
						+ process[i] + '</option>'; */
					}
					if(userid!=frstsalusrlink){
					optionssal += '<option value="a">All</option>';
					}
					$('#cmbsalman').html($.parseHTML(optionssal));
		  			$('#cmbsalman').select2({
		  				placeholder:"Select Salesman",
		  				allowClear:true
		  			});
					
					 if ($('#hidcmbsalman').val() != null) {
						$('#cmbsalman').val($('#hidcmbsalman').val());
					} 
					 if(userid==frstsalusrlink){
							$('#cmbsalman').val(first);
					}
					 else{
						 $('#cmbsalman').val("a");
					 }
				} else {
					//alert("Error");
				}
			}
			x.open("GET",'salesmanonload.jsp', true);
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
		
	function funtxtenable(){
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
					 
			}
		
			
			var date =  $('#date').val();
			var branchid = $('#cmbbranch').val();
			var remarks = $('#txtremarks').val().replace(/\n/g, '');
			var docno = $('#qottrno').val();
			var enqdocno = $('#reftrno').val();
			var rdtype = $('#conttype').val();
			var client = $('#client').val();
			//var userid = $('#txtuserid').val();
			var qdate = $('#date').val(); 
			if(bibid==''){
				
				 swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Choose a Process.'
					});
	  		return false;
			 }
	//alert(bibid);                                                                                                             
			if(def=='Follow-Up' && fdocno==''){
				
				 swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Choose a Followup status.'
					});
	  		return false;
			 }
			 
			 if(remarks==''){
				
				 swal.fire({
						type: 'error',
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
						type: 'Success',
						title: 'Message',
						text: ' Successfully Updated'
					});
					 $("#detailDiv").load("detailGrid.jsp?doc="+docno);
					$('#btnsubmit').trigger('click');
					
					}
					else
					{
						$('.load-wrapp').hide();
						Swal.fire({
							type: 'Warning',
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
			 $('#modalclient').modal('hide');
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
				var tinno = $('#txttinno').val();
				//alert("salid=="+salmanid);
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
							saveClient(txtaddressnw,txtmobnw,txtemailnw,hidsourceid,txtareaid,client,cpersonid,salid,reftrno,category,tinno);
						}
				});
	}
		 
	function saveClient(txtaddressnw,txtmobnw,txtemailnw,hidsourceid,txtareaid,client,cpersonid,salid,reftrno,category,tinno){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
			     			
						var items=x.responseText;
						if(parseInt(items)>0)
						{	
		
					
						$('.load-wrapp').hide();
						Swal.fire({
							type: 'Success',
							title: 'Message',
							text: ' Successfully Client '+items+' Created'
						});
						
						$('#btnsubmit').trigger('click');
						
						}
						else
						{
							$('.load-wrapp').hide();
							Swal.fire({
								type: 'Warning',
								title: 'Warning',
								text: 'Not Created'
							});
							return false;
						}
						}
				}
				
			x.open("GET","saveClient.jsp?address="+txtaddressnw+"&mobile="+txtmobnw+"&email="+txtemailnw+"&sourceid="+hidsourceid+"&areaid="+txtareaid+"&client="+client+"&cpersonid="+cpersonid+"&salid="+salid+"&enqdocno="+reftrno+"&category="+category+"&tinno="+tinno,true)
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
					//alert("=========="+$('#hidcmbcategory').val());
					if ($('#hidcmbcategory').val() != null) {
						$('#cmbcategory').val($('#hidcmbcategory').val());
					}
				}
				x.open("GET", "getCategory.jsp", true);
				x.send();
	}
		 
	function attach(){
			   	
		var fcode="ENQ";
		var fname="Presales Management";
		
		var rowindex1 =$('#rowindex').val();
		var enqdocno=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "doc_no");
		var brchid=$('#jqxJobDetails').jqxGrid('getcellvalue', rowindex1, "brhid"); 
		
		<%-- var myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("enqdocno").value+"&brchid="+document.getElementById("brhid1").value+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no"); --%>
		var myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+enqdocno+"&brchid="+brchid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
		myWindow.focus();
				
	}  
		 
	function getEmployee(){
		 	    employeeSearchContent('employeeDetailsSearch.jsp');  
	}
		 	 		 	
	function employeeSearchContent(url) {
		 	    $('#employeeowindow').jqxWindow('open');
		 		$.get(url).done(function (data) {
		 		$('#employeeowindow').jqxWindow('setContent', data);
		 		$('#employeeowindow').jqxWindow('bringToFront');
		 	}); 
	}
	
</script>
</body>
</html>
