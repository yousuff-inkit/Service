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
<body onload="getProcess();getPriority();getSalesman();getFollowupstatus();getDecline();getCategory();">
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
          <button type="button" class="btn btn-default" id="btnviewenq" ><i class="fa fa-eye" aria-hidden="true" data-toggle="tooltip"  title="View Enquiry" data-placement="bottom" onclick="funENQ();"></i></button>
          <button type="button" class="btn btn-default" id="btnenquiryfollowup"  data-target="#modalenquiryfollowup" ><i class="fa fa-th-list" aria-hidden="true" data-toggle="tooltip" title="Enquiry Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnpriorityupdate" data-target="#modalpriorityupdate"><i class="fa fa-pencil" aria-hidden="true" data-toggle="tooltip"  title="Status Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnsalesmanassign" data-target="#modalassignsalesman" ><i class="fa fa-address-card" aria-hidden="true" data-toggle="tooltip" title="Salesman Assignment" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteprepare"  ><i class="fa fa-cogs" aria-hidden="true" data-toggle="tooltip" title="Quote Preparation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquotefollowup"  data-target="#modalquotefollowup" ><i class="fa fa-exchange" aria-hidden="true" data-toggle="tooltip" title="Quote Followup" data-placement="bottom"></i></button>           
           <button type="button" class="btn btn-default" id="btncreateclient" data-target="#modalclient" ><i class="fa fa-user-o" aria-hidden="true" data-toggle="tooltip" title="Know Your Client" data-placement="bottom"></i></button>
           
          <button type="button" class="btn btn-default" id="btnjobstatus"   data-target="#modaltaskcreation" ><i class="fa fa-plus-square " aria-hidden="true" data-toggle="tooltip" title="Task Creation" data-placement="bottom"></i></button>  
	       
	        <div class="btn-group" role="group">
	        <button type="button" class="btn btn-default" id="btnteamselection"   data-target="#modalpendingtask"><i class="fa fa-newspaper-o " aria-hidden="true" data-toggle="tooltip" title="Pending Task" data-placement="bottom"></i></button>
        <span class="badge badge-notify badge-pendingtask"></span> 
	        </div>
	        <button type="button" class="btn btn-default" id="btnjobcreate"  ><i class="fa fa-binoculars" aria-hidden="true" data-toggle="tooltip" title="Job Creation" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnprocdtocreate"  ><i class="fa fa-creative-commons" aria-hidden="true" data-toggle="tooltip" title="Proceed to Sourcing" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnconfirm"  ><i class="fa fa-check-square-o" aria-hidden="true" data-toggle="tooltip" title="Confirm" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default " id="btnpresales" data-target="#modalpresaleslog" ><i class="fa fa-building" data-toggle="tooltip" title="Presales Log" data-placement="bottom" aria-hidden="true"></i></button>
        </div> 
        <div class="textpanel custompanel" style="position:fixed;">
			<p class="h6">&nbsp;</p>
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
        <div id="partsplangriddiv"><jsp:include page="presalesmanagementGrid.jsp"></jsp:include></div>
      </div>
    </div>
	 <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
      </div>
    </div>
    
    <!-- Pending Modal-->        
      <div id="modalpendingtask" class="modal fade" role="dialog">     
      <div class="modal-dialog modal-lg">    
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Pending Task</h4>      
          </div>
          <div class="modal-body">
           <div class="modal-body"> 
    	<div class="container-fluid">
				<table width="100%">  
 				 <tr> 
   				 <td colspan="6"><div id="pnddiv"><jsp:include page="pendingtaskGrid.jsp"></jsp:include></div></td>
  				</tr> 
  				<tr> 
   				 <td colspan="6"><div id="flwupdiv"><jsp:include page="taskfollowupGrid.jsp"></jsp:include></div></td>
  				</tr>   
  				<tr><td>&nbsp;</td></tr>                       
  			<tr>  
    <td width="10%" align="right">Select Status</td>      
    <td width="9%"><select id="assgntask" style="width:100%;height: 20px;position: static;"></select></td>
    <td width="7%" align="right">Assign To</td>            
	<td width="4%"><div id="part" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch.jsp"></jsp:include></div>
	<input type="hidden" name="hiduser2" id="hiduser2">         
	                </td>     
	<td width="5%" align="right">Remarks</td>                  
	<td width="25%"><input type="text" style="width:100%;height:20px;" id="remarks"/></td>                            
  </tr>       
 </table> 
 </div>   
   <div class="clear"></div>                                   
     </div>
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">
          <button type="button" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="btn btn-default">Update</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div>
        </div>
      </div>
    </div>
    
    <!-- task creation Modal-->
    <div id="modaltaskcreation" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Task Creation</h4>                
          </div>  
<div class="modal-body"> 
    <div class="container-fluid">
    <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Select a Reference Type</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select id="reftype" style="width:69%;">
							<option value="Enquiry">Enquiry</option>
							<option value="Quotation">Quotation</option>
							<option value="Others">Others</option>
						</select>
					</div>  
            	</div>

      <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Reference No</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<input type="number" placeholder="Ref.No" id="refno" style="width:69%;">
					</div>  
            	</div>

        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Start Date</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="tdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>  
            	</div>  
            	
      <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Start Time</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="vtime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>        
            	</div>
            	
       <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assigned User</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="partss" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch2.jsp"></jsp:include></div>
                     	<input type="hidden" name="hiduser" id="hiduser">  	</div>  
            	</div>
            	   
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="desc"></textarea>
					</div>    
            	</div>
</div>
<div class="clear"></div>
</div>
          <div class="modal-footer" style="background-color:#CDFDFA">
             <button type="button" class="btn btn-default" onclick="funSave();">SAVE</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div>                 
        </div>
      </div>
    </div>	
	<div id="modalpriorityupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Status Update<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="cmbpriority">Status:</label>
    						<div class="col-sm-9 input-container">
      							<select id="cmbpriority" name="cmbpriority" style="width:70%;"></select>
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
                          <label class="control-label col-sm-3" for="cmbdecline">Drop status</label>
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
      <input type="hidden" name="txtcrtuser" id="txtcrtuser">                           
  <input type="hidden" name="txtasgnuser" id="txtasgnuser">   
   <input type="hidden" name="txtpendocno" id="txtpendocno">  
   <input type="hidden" name="txtoldstatus" id="txtoldstatus">     
  <input type="hidden" name="statusid" id="statusid">
  <input type="hidden" name="jobchkno" id="jobchkno">
  <input type="hidden" name="jobchktrno" id="jobchktrno">
  <input type="hidden" name="enqtypechk" id="enqtypechk">     
  <input type="hidden" name="qotchkval" id="qotchkval">           
  <div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
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
    	funGetCountData();
    	setTimeout(funload, 1000);
    	$('#cmbreason').attr("disabled",true);
        $('[data-toggle="tooltip"]').tooltip();
        $('#partssearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#partssearchwindow').jqxWindow('close'); 
		 $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	  $('#areainfowindow').jqxWindow('close');
   	 $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	  $('#sourcesearchwndow').jqxWindow('close');
	  $("#enqflwupdate").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
	  $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	  
		$("#tdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#vtime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
	  
		 $("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1));
		 $('#btnprocdtocreate').attr("disabled",true);
		 $('#btnconfirm').attr("disabled",true);
		 $('#btncreateclient').attr("disabled",true);
		 $('#cmbfollowup').attr("disabled",true);
		  $('#cmbdecline').attr("disabled",true);
		  $('#btnjobcreate').attr("disabled",true);
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
			 reload();
			$('.load-wrapp').show();
			$('#partsplangriddiv').load('presalesmanagementGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate);
			
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
		  $('#btnprocdtocreate').click(function(){
		        
				funUpdate(5);
	        });	
        $('#btnassignsalman').click(function(){
        
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
		  
		  $('#btnenqflwp').click(function(){
			  funEnqflwp();       
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
	    	        		 btnqotation();
	    	        	}
	        		
	        	}
			
	        });
		 
		 $('#btnjobcreate').click(function(){
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
	        		
	        		 btnjobcreation();
	        		
	        		/*  var qotno=$('#qotchkno').val();
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
	    	        		 btnqotation();
	    	        	} */
	        		
	        	}
			
	        });
		 
         $('.otherpanel button').click(function(){
        	var jobcarddocno=$('#reftrno').val();
        	//alert("jobcarddocno=="+jobcarddocno);
        	var modaltarget=$(this).attr('data-target');
        	//alert("modaltarget=="+modaltarget);
        	if((jobcarddocno=="") && (modaltarget!="#modaltaskcreation") && (modaltarget!="#modalpendingtask")){
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
    
 
    
    function funstatusval(crtuserid){     
    	// var crtuserid=document.getElementById("txtcrtuser").value;  
    	 var sesuserid= "<%= session.getAttribute("USERID").toString() %>";
    	var optionref="";  
    	//alert("in status set");
    	 if(crtuserid==sesuserid){   
    		  optionref += '<option value="Assigned">Assign</option>';
    		  optionref += '<option value="Accepted">Accepted</option>';
    		  optionref += '<option value="Completed">Completed</option>';
    		  optionref += '<option value="Close">Close</option>';          
    	      $("select#assgntask").html(optionref); 
    	 }else{
    		 optionref += '<option value="Assigned">Assign</option>';
   		     optionref += '<option value="Accepted">Accepted</option>';
   		     optionref += '<option value="Completed">Completed</option>';
   	         $("select#assgntask").html(optionref);  
    	 }
    }
    
    function funpendingUpdate(){    
    	var enqdocno=$('#reftrno').val();
    	var docno=$('#txtpendocno').val();    
    	var crtuser=$('#txtcrtuser').val(); 
     	var status=$('#assgntask').val(); 
    	var oldstat= document.getElementById("txtoldstatus").value;  
      	var asgnuser=$('#hiduser2').val();    
      	var oldassuser=document.getElementById("txtasgnuser").value;   
    	var userid=$('#hiduser2').val();              
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{ 
				var items=x.responseText.trim();
				if(items>0){
					document.getElementById("txtcrtuser").value="";  
					document.getElementById("hiduser2").value="";
					document.getElementById("txtpendocno").value="";  
					document.getElementById("jqxInputUser").value=""; 
					 $('#remarks').val('');
					swal.fire({
						type: 'success',
						title: 'Message',
						text: 'Status Updated'
					});
					funGetCountData();
					reload();         
				}else if(items==-888){  
					swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Task is not completed'  
					});
				}else{ 
					swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Not Updated'                               
					});
				}    
			}else
			{
			}    
		}
		x.open("GET","penStatUpdate.jsp?userid="+userid+"&docno="+docno+"&status="+status+"&asgnuser="+asgnuser+"&oldassuser="+oldassuser+"&oldstatus="+oldstat+"&crtuser="+crtuser+"&remarks="+$('#remarks').val()+"&enqno="+enqdocno,true);           
		x.send();
    }
    
    function funSave()   
    {
    	var enqdocno=$('#reftrno').val();
    	var reftype=document.getElementById("reftype").value;
    	var refno=document.getElementById("refno").value;
    	var sdate=$('#date').jqxDateTimeInput('val');
    	var stime=document.getElementById("vtime").value;
    	var user=document.getElementById("jqxInputUsers").value;
    	var hiduser=document.getElementById("hiduser").value;
    	var desc=document.getElementById("desc").value;
    	var userid="<%= session.getAttribute("USERID").toString() %>";     
    	if(refno=="")
    	{
    		$.messager.alert('Message','Enter Ref. No.','warning');   
    		 document.getElementById('refno').focus();
			 return 0;
    	}
    	if(stime=="")   
    	{
    		$.messager.alert('Message','Enter time','warning');   
   		    document.getElementById('stime').focus();
			 return 0;
    	}
    	if(user=="")
    	{
    		$.messager.alert('Message','Enter Assigned User','warning');   
   		    document.getElementById('user').focus();
			 return 0;
    	}
    	if(desc=="")
    	{
    		$.messager.alert('Message','Enter Description','warning');   
   		    document.getElementById('desc').focus();
			 return 0;
    	}
    	Swal.fire({
			title: 'Are you sure?',
			text: "Do you want Create Task?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: 'Yes'
	}).then((result) => {
			if (result.isConfirmed) {
				$('.load-wrapp').show();
				 saveDatasss(reftype,refno,sdate,stime,user,desc,userid,hiduser,enqdocno);  
			}
	});
    	  
    	
    }    
    function saveDatasss(reftype,refno,sdate,stime,user,desc,userid,hiduser,enqdocno){
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function()
    			{
    				if(x.readyState==4 && x.status==200)
    				{
    					var msg=x.responseText.trim();
    					$('.load-wrapp').hide();
    					if(msg=="1"){ 
    			              	document.getElementById("refno").value="";
    			              	document.getElementById("vtime").value="";
    			              	document.getElementById("jqxInputUsers").value=""; 
    			              	document.getElementById("hiduser").value="";
    			              	document.getElementById("desc").value="";   
    			              	Swal.fire({   
    									type: 'success',
    									title: 'Message',
    									text: 'Successfully Created'      
    								});
    			               
    			              } else{
    			            	  Swal.fire({
    							type: 'error',
    							title: 'Message',  
    							text: 'Not Created'              
    						});    
    		            }
    				}         
    			}
    			x.open("GET","taskCreate.jsp?reftype="+reftype+"&refno="+refno+"&sdate="+sdate+"&stime="+stime+"&user="+user+"&desc="+desc+"&userid="+userid+"&hiduser="+hiduser+"&enqno="+enqdocno,true);
    			x.send();
    }
    
    
    
    function funload(){
    	var brhid=$('#cmbbranch').val();
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		// var draftsmanname=$("#cldocno").val();
		 var areaid=$("#areaid").val();
		 var salesmanid=$("#cmbsalesman").val();
		 reload();
		$('.load-wrapp').show();
		$('#partsplangriddiv').load('presalesmanagementGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate);
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
	
	function btnjobcreation()
	{
		var qotchknew=document.getElementById("qotchkval").value;
		var typechknew=document.getElementById("enqtypechk").value;
	//	alert("qotchknew=="+qotchknew+"==typechknew=="+typechknew);
		
		
		var client=document.getElementById("client").value;
		var cldocno=document.getElementById("cldocno").value;
		var ref_type=document.getElementById("refdtype").value;
		var refdocno=document.getElementById("enqdocno").value;
		var reftrno=document.getElementById("reftrno").value;
		var address=document.getElementById("address").value;
		var chkreftype=document.getElementById("reftype").value;
		var chkrefno=document.getElementById("refno").value;
		var chkjobno=document.getElementById("jobchkno").value;
		var chkqotno=document.getElementById("qotchkno").value;
		var chkqottrno=document.getElementById("qottrno").value;
		//alert("dtype=="+chkreftype);
		if(chkreftype=="Enquiry"){
			Swal.fire({
				type: 'error',
				title: 'Warning',
				text: 'Quotation Not Created'
			});
			return false;
		}
		else if(chkreftype=="Quotation"){
			ref_type="SQOT";
			refdocno=chkqotno;
			if(parseInt(chkjobno)>0){
				Swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Job Already Created'
				});
				return false;
			}
		}
		else{
			
		}
		var pertel=document.getElementById("pertel").value;
		var per_mob=document.getElementById("per_mob").value;
		var mail1=document.getElementById("mail1").value;
		var salname=document.getElementById("salname").value;
		var salid=document.getElementById("salid").value;
		var contrtype=document.getElementById("contrtype").value;
		var brch=document.getElementById("brhid1").value;
		
		var surtrno=document.getElementById("surtrno").value;
		var esttrno=document.getElementById("esttrno").value;
		var cpersonid=document.getElementById("txtcpersonid").value;
		var cperson=document.getElementById("txtcperson").value;
		var cpersondet=document.getElementById("txtcpersondet").value;
		var sjobtype=document.getElementById("txtsjobtype").value;
		var clienttaxper=document.getElementById("txtclienttaxper").value;
			
		var path1="com/it/jobcontractit/jobcontract.jsp";
		var name="Job Contract";
		var url=document.URL;
		var reurl=url.split("com/");

	  window.parent.formName.value="Job Contract";
	  window.parent.formCode.value="SJOB";
	  window.parent.branchid.value=brch;
	  var detName="Job Contract";
	  var mode="A";
		   
		  
		  var path= path1+"?mod="+mode+"&brhid="+brch+"&client="+encodeURIComponent(client)+"&cldocno="+cldocno+"&ref_type="+ref_type
				  +"&refdocno="+refdocno+"&reftrno="+reftrno+"&address="+encodeURIComponent(address)+"&pertel="+pertel+"&per_mob="+per_mob
				  +"&mail1="+encodeURIComponent(mail1)+"&salname="+encodeURIComponent(salname)
				  +"&salid="+salid+"&contrtype="+contrtype+"&surtrno="+surtrno+"&esttrno="+esttrno+"&cpersonid="+cpersonid+"&cperson="+encodeURIComponent(cperson)
				  +"&cpersondet="+encodeURIComponent(cpersondet)+"&sjobtype="+sjobtype+"&clienttaxper="+clienttaxper+"&qottrno="+chkqottrno+"&qotchkval="+qotchknew+"&typechknew="+typechknew;
		 
		   top.addTab( detName,reurl[0]+""+path);
	}
	
	function btnqotation()
	{

		var client=document.getElementById("client").value;
		var cldocno=document.getElementById("cldocno").value;
		var ref_type=document.getElementById("refdtype").value;
		var refdocno=document.getElementById("enqdocno").value;
		var reftrno=document.getElementById("reftrno").value;
		var address=document.getElementById("address").value;
		
		var pertel=document.getElementById("pertel").value;
		var per_mob=document.getElementById("per_mob").value;
		var mail1=document.getElementById("mail1").value;
		var salname=document.getElementById("salname").value;
		var salid=document.getElementById("salid").value;
		var contrtype=document.getElementById("contrtype").value;
		var brch=document.getElementById("brhid1").value;
		
		var surtrno=document.getElementById("surtrno").value;
		var esttrno=document.getElementById("esttrno").value;
		var cpersonid=document.getElementById("txtcpersonid").value;
		var cperson=document.getElementById("txtcperson").value;
		var cpersondet=document.getElementById("txtcpersondet").value;
		var sjobtype=document.getElementById("txtsjobtype").value;
		var clienttaxper=document.getElementById("txtclienttaxper").value;
			
		var path1="com/it/quotationit/quotation.jsp";
		var name="Quotation";
		var url=document.URL;
		var reurl=url.split("com/");

	  window.parent.formName.value="Quotation";
	  window.parent.formCode.value="SQOT";
	  window.parent.branchid.value=brch;
	  var detName="Quotation";
	  var mode="A";
		   
		  
		  var path= path1+"?mod="+mode+"&brhid="+brch+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cldocno="+cldocno+"&ref_type="+ref_type
				  +"&refdocno="+refdocno+"&reftrno="+reftrno+"&address="+address.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&pertel="+pertel+"&per_mob="+per_mob
				  +"&mail1="+mail1.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&salname="+salname.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
				  +"&salid="+salid+"&contrtype="+contrtype+"&surtrno="+surtrno+"&esttrno="+esttrno+"&cpersonid="+cpersonid+"&cperson="+cperson.replace("/\s/g","%20").replace('#','%23').replace('&','%26')
				  +"&cpersondet="+cpersondet.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&sjobtype="+sjobtype+"&clienttaxper="+clienttaxper;
		 
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
			
		 var path1="com/it/enquiryit/enquiry.jsp";
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
					text: 'Choose a Priority'
				});
  		return false;
		 }
	}
	if(parseInt(chkevent)==2){	
		var salio= $('#cmbsalman').val().split(":");
 		 saldocno=salio[0];
		 salname=salio[1];
		$('#modalassignsalesman').modal('hide');
		proname="assignsalman";
		if(saldocno==''){
			
			 swal.fire({
					type: 'error',
					title: 'Warning',
					text: 'Choose a Salesman'
				});
  		return false;
		 }
	}	
	if(parseInt(chkevent)==3){	
		
		proname="confirm";
	
	}	
   if(parseInt(chkevent)==5){	
		
		proname="proceed";
	
	}
    if(parseInt(chkevent)==4){	
		
		proname="Quotation";
		saveGridData(proname,prdocno,prname,docno,saldocno,salname,chkevent);
	}
    else{
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
				saveGridData(proname,prdocno,prname,docno,saldocno,salname,chkevent);
			}
	});
    }
	
		
		
	
	}
	
	function saveGridData(proname,prdocno,prname,docno,saldocno,salname,chkevent){
//alert("enqdocno=="+docno);
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
						$('#cmbsalman').val('');
						Swal.fire({
							type: 'Success',
							title: 'Message',
							text: ' Successfully Updated'
						});
						 $("#detailDiv").load("detailGrid.jsp?doc=0&enqdocno="+docno);
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
			
	x.open("GET","saveData.jsp?proname="+proname+"&prdocno="+prdocno+"&prname="+prname+"&docno="+docno+"&saldocno="+saldocno+"&salname="+salname,true);
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
		
	 function reload(){            
	  	    var userid= "<%= session.getAttribute("USERID").toString() %>";
	  		$('#pnddiv').load('pendingtaskGrid.jsp?userid='+userid);    
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
		  				placeholder:"Select Dropped-Status",
		  				allowClear:true
		  			});
		  			$('#cmbreason').html($.parseHTML(optionsbranch));
		  			$('#cmbreason').select2({
		  				placeholder:"Select Drop-Status",
		  				allowClear:true
		  			});
					
				} else {
					
				}
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
			else if(def=='Dropped')
			{
				 $('#cmbdecline').attr("disabled",false);
				 $('#cmbfollowup').attr("disabled",true);
					 
			}
			
		}
		
		 function funGetCountData(){
		    	var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();
						
						$('.badge-pendingtask').text(items);                  
					}      
					else
					{
					}  
				}
				x.open("GET","getCountData.jsp",true);
				x.send();
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
			else if(def=='Dropped')
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
			var rdtype = "SQOT"; 
			var process="Quotation Followup";
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
						saveQotflwp(bibid,proname,date,branchid,docno,rdtype,remarks,fdocno,fstatus,ddocno,dstatus,enqdocno,qdate,client,process);
					}
			});
			
		}
		
		
			
	   
		    
		function saveQotflwp(bibid,proname,date,branchid,docno,rdtype,remarks,fdocno,fstatus,ddocno,dstatus,enqdocno,qdate,client,process){

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
					 $("#detailDiv").load("detailGrid.jsp?doc="+docno+"&enqdocno=0");
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
			
		x.open("GET","saveQotFlwp.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks+"&fdocno="+fdocno+"&fstatus="+fstatus+"&ddocno="+ddocno+"&dstatus="+dstatus+"&enqdocno="+enqdocno+"&qdate="+qdate+"&client="+client+"&processid="+encodeURIComponent(process),true)
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
				 var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("enqdocno").value+"&brchid="+document.getElementById("brhid1").value+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
						  myWindow.focus();
				
			}  
		 	
			function funenqdisable(){  
				var process=$("#cmbenqprocess").val();
				if(process=="1"){
					$('#cmbreason').attr("disabled",true);
				}else{
					$('#cmbreason').attr("disabled",false);
				}
			}
		 	
			function funEnqflwp(){
				var brhid="0";
				var date =  $('#enqflwupdate').val();
				var remarks = $('#enqflwupremarks').val().replace(/\n/g, '');
 				var docno = $('#reftrno').val();  
				var qottrno = $('#qottrno').val();  
			/* 	var docno = $('#qottrno').val();
				var enqdocno = $('#reftrno').val(); */
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
							saveEnqflwp(date,docno,rdtype,remarks,brhid,process,qottrno,reason,enqprocess,process);       
						}
				});
			}
			function saveEnqflwp(date,docno,rdtype,remarks,brhid,processid,qottrno,reason,enqprocess,process){          
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){  
						var items=x.responseText;
						$('.load-wrapp').hide();
							 if(parseInt(items)=="1"){  	  
									$('#btnsubmit').trigger('click');  
										 swal.fire({  
											    icon: 'success',
												title: 'Success',
												text: 'Successfully Updated'  
											});
										 $('#modalenquiryfollowup').modal('hide');  
	                                    
											 $("#detailDiv").load("detailGrid.jsp?doc="+qottrno+"&enqdocno="+docno);  
										 
								}else{
										 swal.fire({  
											    icon: 'warning',
												title: 'Warning',
												text: 'Not Updated'    
											});
								} 
						}
				}  
			x.open("GET","saveQotFlwp.jsp?processid="+encodeURIComponent(process)+"&enqprocess="+enqprocess+"&date="+date+"&rdtype="+rdtype+"&docno="+docno+"&brhid="+brhid+"&remarks="+encodeURIComponent(remarks)+"&reason="+reason,true);       
			x.send();
			}
		 
</script>
</body>
</html>
