<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Operation</title>                 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>     
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">     
  <style type="text/css">   
     
  .btn-group>.btn:first-child:not(:last-child):not(.dropdown-toggle) {     
    border-radius: 30px !important;       
} 
  .btn:focus,.btn:active {
   outline: none !important;
   box-shadow: none;
   }
   .modalStyle {      
    background-color:#33b5e5; `
    padding: 10px; 
   }
   .borderStyle{  
    margin-bottom: 0;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    border: none;
    line-height: 1.42857143;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
   box-shadow: 1px 2px 7px 3px #d4cece;                          
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }   
  .iconStyle{
	color: #000000 !important;  
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;   
  }
  .btnStyle{  
  	display: inline-block;   
    margin-bottom: 0;
    font-weight: 400;
    margin-right:5px;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    background-image: none;
    border: none;
    padding: 3px 8px;  
    font-size: 14px;
    line-height: 1.42857143;
    border-radius: 30px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);                     
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }
   @media (min-width: 900px) {               
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
} 
   .textpanel{
    color: blue;
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 0px; 
      padding-top: 10px;
      padding-bottom: 0px;
      border-radius: 8px;
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      /* background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%); */
      background-color:#FEFE56;   
      color: black;
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
    #border1 {
	  border-radius: 25px;
	  padding: 8px;
	  -moz-box-shadow:    inset 0 0 3px #000000;
      -webkit-box-shadow: inset 0 0 3px #000000;
      box-shadow:         inset 0 0 3px #000000;   
}
   .btnbgcolor1{
       background-color:#ACF6CB;
   }
   .btnbgcolor2{
       background-color:white;     
   }
#modalbillsettlement {
  height: 600px;
  overflow: auto;
}
#modaljobsettlement {
  height: 600px;
  overflow: auto;
}
  </style>
</head>       
<body onload="getPayType();getCardTypes();getStatus();getSubStatus();getCashAccount();getMCPCashAccount();getExpCashAccount();">                                            
  <div class="container-fluid">    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
         <div class="primarypanel custompanel" style="margin-left:5px;">  
             <div id="border1">
                <button type="button" class="btn btn-default btnStyle" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
	          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
            </div>                               
	  	 </div> 
	  	 <div class="actionpanel custompanel"  style="margin-left:5px;">            
           <div id="border1">  
               <button type="button" class="btn btn-default btnStyle" id="btnassignment" data-toggle="tooltip" title="Assignment" data-placement="bottom"><i class="fa fa-calendar-check-o " aria-hidden="true"></i></button>       
	           <button type="button" class="btn btn-default btnStyle" id="btnstatus"  data-toggle="tooltip" title="Status update" data-placement="bottom"><i class="fa fa-pencil-square" aria-hidden="true"></i></button>
	           <button type="button" class="btn btn-default btnStyle" id="btnsubstatus"  data-toggle="tooltip" title="Sub Status update" data-placement="bottom"><i class="fa fa-pencil" aria-hidden="true"></i></button>
	           <button type="button" class="btn btn-default btnStyle" id="btnreceipt" data-toggle="tooltip" title="Receipt" data-placement="bottom"><i class="fa fa-file-text-o" aria-hidden="true"></i></button>
	           <button type="button" class="btn btn-default btnStyle" id="btnjobadvance" data-toggle="tooltip" title="Job Advance" data-placement="bottom"><i class="fa fa-money" aria-hidden="true"></i></button>
	           <!-- <button type="button" hidden="true" class="btn btn-default btnStyle" id="btnbillsettlement" data-toggle="tooltip" title="Bill Settlement" data-placement="bottom"><i class="fa fa-bold" aria-hidden="true"></i></button>
	           <button type="button" hidden="true" class="btn btn-default btnStyle" id="btnposting" data-toggle="tooltip" title="Posting" data-placement="bottom"><i class="fa fa-file-powerpoint-o" aria-hidden="true"></i></button> 
	           <button type="button" class="btn btn-default btnStyle" id="btnconfirm" data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle" aria-hidden="true"></i></button>
	           -->
	           <button type="button" class="btn btn-default btnStyle" id="btnjobsettlement" data-toggle="tooltip" title="Job Settlement" data-placement="bottom"><i class="fa fa-openid" aria-hidden="true"></i></button>
               
               <button type="button" class="btn btn-default btnStyle" id="btnshipment" data-toggle="tooltip" title="Shipment Details" data-placement="bottom"><i class="fa fa-truck" aria-hidden="true"></i></button>
           </div>                                                                               
        </div> 
        <div class="warningpanel custompanel"  style="margin-left:5px;">                                          
           <div id="border1">                       
              <div class="btn-group" role="group">
          	       <button type="button" class="btn btn-default btnStyle" id="btnentered" data-toggle="tooltip" title="Entered" data-placement="bottom" data-filtervalue="" data-datafield="docstatus"><i class="fa fa-sign-in " aria-hidden="true"></i></button>
          	       <span class="badge badge-notify badge-entered"></span>             
              </div> 
              <div class="btn-group" role="group">
          	       <button type="button" class="btn btn-default btnStyle" id="btnadvancepaid" data-toggle="tooltip" title="Advance paid" data-placement="bottom" data-filtervalue="Advance paid" data-datafield="docstatus"><i class="fa fa-money " aria-hidden="true"></i></button>
          	       <span class="badge badge-notify badge-advancepaid"></span>                       
              </div>
              <div class="btn-group" role="group">           
          	       <button type="button" class="btn btn-default btnStyle" id="btnjobsettled" data-toggle="tooltip" title="Job settled" data-placement="bottom" data-filtervalue="Job settled" data-datafield="docstatus"><i class="fa fa-openid " aria-hidden="true"></i></button>
          	       <span class="badge badge-notify badge-jobsettled"></span>             
              </div> 
              <div class="btn-group" role="group">
          	       <button type="button" class="btn btn-default btnStyle" id="btnbooked" data-toggle="tooltip" title="Booked" data-placement="bottom" data-filtervalue="BOOKED" data-datafield="status"><i class="fa fa-bold " aria-hidden="true"></i></button>
          	       <span class="badge badge-notify badge-booked"></span>             
              </div> 
              <div class="btn-group" role="group">
          	       <button type="button" class="btn btn-default btnStyle" id="btndelivered" data-toggle="tooltip" title="Delivered" data-placement="bottom" data-filtervalue="DELIVERED" data-datafield="status"><i class="fa fa-american-sign-language-interpreting  " aria-hidden="true"></i></button>
          	       <span class="badge badge-notify badge-delivered"></span>                     
              </div>  
              <div class="btn-group" role="group">
          	       <button type="button" class="btn btn-default btnStyle" id="btncompleted" data-toggle="tooltip" title="Completed" data-placement="bottom" data-filtervalue="COMPLETED" data-datafield="status"><i class="fa fa-th-list " aria-hidden="true"></i></button>
          	       <span class="badge badge-notify badge-completed"></span>             
              </div>           
           </div>      
        </div>      
        <div class="otherpanel custompanel"  style="margin-left:5px;">                                          
           <div id="border1">     
              <button type="button" class="btn btn-default btnStyle" id="btnstatuslog" data-toggle="tooltip" title="Status Log" data-placement="bottom"><i class="fa fa-area-chart" aria-hidden="true"></i></button>
              <button type="button" class="btn btn-default btnStyle" id="btnstatuswise" data-toggle="tooltip" title="Status Wise Statistics" data-placement="bottom"><i class="fa fa-pie-chart" aria-hidden="true"></i></button>
              <button type="button" class="btn btn-default btnStyle" id="btnmodewise" data-toggle="tooltip" title="Mode Wise Statistics" data-placement="bottom"><i class="fa fa-pie-chart" aria-hidden="true"></i></button>
              <button type="button" class="btn btn-default btnStyle" id="btndriveravl" data-toggle="tooltip" title="Driver Availability" data-placement="bottom"><i class="fa fa-pie-chart" aria-hidden="true"></i></button>
              <button type="button" class="btn btn-default btnStyle" id="btnvehicle" data-toggle="tooltip" title="Vehicle Statistics" data-placement="bottom"><i class="fa fa-pie-chart" aria-hidden="true"></i></button>
              <button type="button" class="btn btn-default btnStyle" id="btnattach"  onclick="funAttach();" data-toggle="tooltip" title="Attachments" data-placement="bottom"><i class="fa fa-paperclip " aria-hidden="true"></i></button>
	          <button type="button" class="btn btn-default btnStyle" id="btncsprint"  onclick="funPrintCS();" data-toggle="tooltip" title="Cost Sheet Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
	          <button type="button" class="btn btn-default btnStyle" id="btncomment" data-toggle="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
           </div>      
        </div>              
        <div class="textpanel custompanel" style="margin-left:5px;padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;top:25px;position:absolute;">                                  
			<p  style="font-size:0.9em;float:left;" id="selectedrow">&nbsp;</p>&nbsp;&nbsp;&nbsp;&nbsp;   
        </div>  
      </div>
    </div>        
    <br/>  
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
        <div id="opndiv" class="borderStyle"><jsp:include page="assignmentGrid.jsp"></jsp:include></div>               
      </div>                                  
    </div>
    <!-- Comments Modal-->     
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header modalStyle">     
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Comments</h4>
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
       <!-- Comments Modal--> 
    <!-- Assignment modal-->            
    <div id="modalassignment" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Assignment</h4>              
               <p id="lblname" style="text-align:center;"></p>              
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
	                <div class="form-group">
						<label>Assignment Type</label>                
						<select id="cmbasgmnttype" class="form-control input-sm" onchange="setAssignment();"><option value="">--Select--</option><option value="3">User</option><option value="2">Driver</option><option value="1">Vendor</option></select>       
					</div>       
				 </div>         
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" id="hidestaff">              
	                <div class="form-group">
						<label>Assignment To</label>
						<div id="assignmenttostaff" onkeydown="return (event.keyCode!=13);"><jsp:include page="staffSearch.jsp"></jsp:include></div>  
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" id="hidevendor">                    
	                <div class="form-group">
						<label>Assignment To</label>  
						<div id="assignmenttovendor" onkeydown="return (event.keyCode!=13);"><jsp:include page="vendorSearch.jsp"></jsp:include></div>  
					</div>       
				 </div>
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" id="hideuser">                              
	                <div class="form-group">
						<label>Assignment To</label>  
						<div id="assignmenttouser" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch.jsp"></jsp:include></div>  
					</div>       
				 </div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">                 
	                <div class="form-group">
						<label>Reg No</label>
						<div id="equipment" onkeydown="return (event.keyCode!=13);"><jsp:include page="equipSearch.jsp"></jsp:include></div>  
					    <input type="hidden" name="hidequipmentid" id="hidequipmentid">                                
					</div>       
				 </div>  
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
	                <div class="form-group">
						<label>Completion Date</label>    
						<div id="dat" ></div>          
					</div>       
				 </div> 
              </div>       
              <div class="row rowgap"> 
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>Trailer No</label>                    
						<input id="trackid" class="form-control input-sm">        
					</div>       
				 </div>
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">       
	                <div class="form-group">
						<label>Remarks</label>                    
						<input id="remarks" class="form-control input-sm">                
					</div>       
				 </div>  
              </div>           
            	</div>   
            </div>  
            <div class="modal-footer"> 
            	<div class="row rowgap">   
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnassingment" title="Assign" data-placement="bottom" onclick="funAssignment();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div>  
  <!-- Status modal-->            
    <div id="modalstatus" class="modal fade" role="dialog">                  
      <div class="modal-dialog modal-sm">                          
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Status Update</h4>                   
              <p id="lblname1" style="text-align:center;"></p>                              
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
	            <div class="container-fluid">   
	               <div class="row rowgap"> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">       
		                <div class="form-group">    
							<label>Status</label>  
							<select id="cmbstatus" class="form-control input-sm"></select>                  
					        <input type="hidden" name="hidcmbstatus" id="hidcmbstatus">                    
						</div>       
					 </div>     
	               </div>             
	            </div>          
            </div>  
            <div class="modal-footer">       
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnstatusupdate" title="Update" data-placement="bottom" onclick="funStatusUpdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div> 
 <!-- Receipt modal-->                 
    <div id="modalreceipt" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Receipt</h4>           
             <p id="lblname2" style="text-align:center;"></p>                 
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
	                <div class="form-group">
						<label>Date</label>   
						<div id="rcptdate"></div>        
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>Pay Type</label>    
						<select id="cmbpaytype" class="form-control input-sm" onchange="funchequedate();getAccounts(this.value);"></select>        
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
	                <div class="form-group">
						<label>Card Type</label>    
						<select id="cmbcardtype" class="form-control input-sm"  onchange="funclearchequecardno();">
						<option value="">--Select--</option></select>              
					    <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" class="form-control input-sm text-right"/> 
					    <input type="hidden" id="txtaccid" name="txtaccid" class="form-control input-sm" tabindex="-1"/> 
					    <input type="hidden" id="txtaccname" name="txtaccname"class="form-control input-sm m-l-5" tabindex="-1"/>
					    <input type="hidden" id="txtdocno" name="txtdocno"/>
					    <input type="hidden" id="txttranno" name="txttranno"/>                          
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
	                <div class="form-group">   
						<label>Chq/Online/Card No</label>               
						<input type="text" id="txtrefno" name="txtrefno" class="form-control input-sm" onchange="funcardvalidation();"/>   
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">          
	                <div class="form-group">   
						<label>Date</label>                   
						<div id="jqxReferenceDate"></div>    
					</div>       
				 </div>        
              </div>      
              <div class="row rowgap"> 
                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>Amount</label>           
						<input type="text" id="txtamount" name="txtamount" class="form-control input-sm text-right"  onblur="funRoundAmt(value,id);"/>      
					</div>       
				 </div> 
				  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">
	                <div class="form-group">
						<label>Client</label>
						<div id="clientrcpt" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearchRcpt.jsp"></jsp:include></div>  
					    <input type="hidden" name="hidrcptcldocno" id="hidrcptcldocno">  
					    <input type="hidden" name="hidrcptclacno" id="hidrcptclacno">                        
					</div>       
				 </div>    
              </div>    
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">               
	                <div class="form-group">
						<label>Description</label>               
						<input id="txtrcptdesc" class="form-control input-sm">           
					</div>          
				 </div>  
              </div>        
                               
            	</div>   
            </div>  
            <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnreceiptcreate" title="Update" data-placement="bottom" onclick="funreceiptcreate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div>
            </div>
          </div>  
        </div>  
      </div>  
        <!-- Sub Status modal-->            
    <div id="modalsubstatus" class="modal fade" role="dialog">                      
      <div class="modal-dialog modal-sm">                          
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Sub Status Update</h4>                   
               <p id="lblname11" style="text-align:center;"></p>                                     
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
	            <div class="container-fluid">   
	               <div class="row rowgap"> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">       
		                <div class="form-group">    
							<label>Status</label>  
							<select id="cmbsubstatus" class="form-control input-sm"></select>                  
					        <input type="hidden" name="hidcmbsubstatus" id="hidcmbsubstatus">                    
						</div>       
					 </div>     
	               </div> 
	            <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">               
	                <div class="form-group">
						<label>Description</label>                   
						<input id="subremarks" class="form-control input-sm">                
					</div>          
				 </div>  
              </div>             
	            </div>          
            </div>  
            <div class="modal-footer">       
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnsubstatusupdate" title="Update" data-placement="bottom" onclick="funSubStatusUpdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div> 
    
    <!-- Job Advance modal-->                 
    <div id="modaljobadvance" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Job Advance</h4>                             
             <p id="lblname3" style="text-align:center;"></p>                             
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
	                <div class="form-group">
						<label>Date</label>   
						<div id="jobdate"></div>            
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-7">           
	                <div class="form-group">
						<label>Cash</label>    
						<select id="cmbcash" class="form-control input-sm"></select>
						<input type="hidden" id="hidcmbcash" class="form-control input-sm">        
					</div>       
				 </div>
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
	                <div class="form-group">
						<label>Amount</label>           
						<input type="text" id="jobamount" name="jobamount" class="form-control input-sm text-right"  onblur="funRoundAmt(value,id);"/>      
					</div>       
				 </div> 
              </div>  
              <div class="row rowgap"> 
                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">                  
	                <div class="form-group">
						<label>Vendor</label>                 
						<input type="checkbox" id="jobvndchk" onchange="jobchkchange();"/>
						<input type="hidden" id="jobvndchkval"/>             
					</div>          
				 </div>
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">                    
	                <div class="form-group">
						<label>Account</label>                 
							<div id="jobvendor" onkeydown="return (event.keyCode!=13);"><jsp:include page="jobvendorSearch.jsp"></jsp:include></div>  
					        <input type="hidden" name="hidjobvndid" id="hidjobvndid">          
					</div>          
				 </div>  
              </div>     
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">               
	                <div class="form-group">
						<label>Description</label>               
						<input id="jobdesc" class="form-control input-sm">           
					</div>          
				 </div>  
              </div>        
            </div>        
            </div>  
            <div class="modal-footer">     
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnadvancecreate" title="Create" data-placement="bottom" onclick="funCashPaymentCreate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div>
            </div>
          </div>  
        </div>  
      </div> 
    <!-- Bill Settlement modal-->                   
    <div id="modalbillsettlement" class="modal fade" role="dialog">              
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header modalStyle" style="padding: 0px;">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Bill Settlement</h4>                             
             <p id="lblname4" style="text-align:center;"></p>                                
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
	                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
						<label>Cash</label>  
					</div>    
					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">
					    <select id="cmbcashacc" class="form-control input-sm"></select>
						<input type="hidden" id="hidcmbcashacc" class="form-control input-sm">           
					</div>	  
			     </div>          
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">               
	                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
						 <label>&nbsp;</label>   
					</div>   
					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">      
					     <input type="text" id="billamount" name="billamount" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
					</div>  	            
			     </div>   
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">                  
	                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
						 <label>Advance Paid</label>   
					</div>   
					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">
					     <input type="text" id="advamount" name="advamount" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
					</div>  	            
			     </div>
			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">               
	                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-7">        
						 <label>Settlement Amount</label>   
					</div>   
					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-5">            
					     <input type="text" id="settleamount" name="settleamount" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
					</div>  	            
			     </div>  
              </div>       
             <div class="row rowgap"> 
                 <fieldset><legend  style="font-size: 12px;font-weight: bold;">CASH:</legend>     
	                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
					     <div id="mcpcashdiv" class="borderStyle"><jsp:include page="mcpCashGrid.jsp"></jsp:include></div>
					 </div>
                 </fieldset>   
             </div>
             <div class="row rowgap"> 
	             <fieldset><legend style="font-size: 12px;font-weight: bold;">CREDIT:</legend>        
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
					     <div id="mcpcreditdiv" class="borderStyle"><jsp:include page="mcpCreditGrid.jsp"></jsp:include></div>
					 </div>
				 </fieldset>      
             </div>       
            </div>        
            </div>  
           <div class="modal-footer">     
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnbill" title="Create" data-placement="bottom" onclick="funBill();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div>
            </div>     
          </div>  
        </div>  
      </div> 
  <!-- Posting modal-->            
    <div id="modalposting" class="modal fade" role="dialog">                      
      <div class="modal-dialog modal-xl">                             
        <div class="modal-content">
          <div class="modal-header modalStyle"  style="padding: 0px;">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Posting</h4>                          
               <p id="lblname5" style="text-align:center;"></p>                                                                    
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
	            <div class="container-fluid">
	            <div class="row rowgap"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-11">                   
				           <div id="postcashdiv" class="borderStyle"><jsp:include page="postCashGrid.jsp"></jsp:include></div>                  
				        </div> 
				        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-1" style="text-align:center;">      
						   <button type="button" class="btn btn-default btnStyle" data-toggle="tooltip" id="btnmcposting" title="MCP Posting" data-placement="bottom" onclick="funPost();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					    </div>         
	               </div> 
	               <div class="row rowgap">         
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-11">                 
				           <div id="postcreditdiv" class="borderStyle"><jsp:include page="postCreditGrid.jsp"></jsp:include></div>                  
				        </div>  
				        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-1" style="text-align:center;">   
							<button type="button" class="btn btn-default btnStyle"  data-toggle="tooltip" id="btnnipurchasecreate" title="Ni Purchase Create" data-placement="bottom" onclick="funnipurchasecreate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
						</div>             
	               </div>    
	               <div class="row rowgap"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-11">                     
				           <div id="jvdiv" class="borderStyle"><jsp:include page="journalVoucherGrid.jsp"></jsp:include></div>                  
				        </div>  
				        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-1" style="text-align:center;">   
							<button type="button" class="btn btn-default btnStyle"  data-toggle="tooltip" id="btnjvcreate" title="JV Create" data-placement="bottom" onclick="funjvcreate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
						</div>          
	               </div>    
	            </div>          
            </div>  
            <!-- <div class="modal-footer">       
            </div> -->   
          </div>  
        </div>    
      </div> 
    <!-- Status Log modal-->               
    <div id="modalstatuslog" class="modal fade" role="dialog">                      
      <div class="modal-dialog modal-lg">                             
        <div class="modal-content">
          <div class="modal-header modalStyle" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Status Log</h4>                            
               <p id="lblname6" style="text-align:center;"></p>                                                                    
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
	            <div class="container-fluid">
	               <div class="row rowgap"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                     
				           <div id="slogdiv" class="borderStyle"><jsp:include page="sLogGrid.jsp"></jsp:include></div>                    
				        </div>  
	               </div>    
	            </div>          
            </div>  
            <!-- <div class="modal-footer">       
            </div> -->   
          </div>  
        </div>    
      </div> 
    <!-- Status Wise modal-->               
    <div id="modalstatuswise" class="modal fade" role="dialog">                      
      <div class="modal-dialog modal-lg">                             
        <div class="modal-content">
          <div class="modal-header modalStyle" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Status Wise Statistics</h4>                               
               <p id="lblname7" style="text-align:center;"></p>                                                                    
          </div>                             
          <div class="modal-body">  
            <p><!-- Some text in the modal. --></p>  
	            <div class="container-fluid">
	               <div class="row rowgap"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                        
				           <div id="swdiv" class="borderStyle"><jsp:include page="sWiseGrid.jsp"></jsp:include></div>                    
				        </div>  
	               </div>    
	            </div>          
            </div>  
            <!-- <div class="modal-footer">       
            </div> -->   
          </div>  
        </div>    
      </div>   
    <!-- Mode Wise modal-->               
    <div id="modalmodewise" class="modal fade" role="dialog">                      
      <div class="modal-dialog modal-lg">                             
        <div class="modal-content">
          <div class="modal-header modalStyle" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Mode Wise Statistics</h4>                               
               <p id="lblname8" style="text-align:center;"></p>                                                                    
          </div>                             
          <div class="modal-body">  
            <p><!-- Some text in the modal. --></p>    
	            <div class="container-fluid">
	               <div class="row rowgap"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                        
				           <div id="mwdiv" class="borderStyle"><jsp:include page="mWiseGrid.jsp"></jsp:include></div>                    
				        </div>  
	               </div>    
	            </div>          
            </div>  
            <!-- <div class="modal-footer">       
            </div> -->   
          </div>  
        </div>    
      </div>  
   <!-- Driver Availability modal-->               
    <div id="modaldriverwise" class="modal fade" role="dialog">                      
      <div class="modal-dialog modal-xl">                             
        <div class="modal-content">
          <div class="modal-header modalStyle" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Driver Availability</h4>                                  
               <p id="lblname9" style="text-align:center;"></p>                                                                    
          </div>                             
          <div class="modal-body">  
            <p><!-- Some text in the modal. --></p>    
	            <div class="container-fluid">
	               <div class="row rowgap"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                        
				           <div id="dadiv" class="borderStyle"><jsp:include page="dAvlGrid.jsp"></jsp:include></div>                    
				        </div>  
	               </div>    
	            </div>          
            </div>  
            <!-- <div class="modal-footer">       
            </div> -->   
          </div>  
        </div>    
      </div>    
    <!-- Vehicle Wise modal-->                 
    <div id="modalvehiclewise" class="modal fade" role="dialog">                      
      <div class="modal-dialog modal-xl">                             
        <div class="modal-content">
          <div class="modal-header modalStyle" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Vehicle Statistics</h4>                               
               <p id="lblname10" style="text-align:center;"></p>                                                                    
          </div>                             
          <div class="modal-body">  
            <p><!-- Some text in the modal. --></p>    
	            <div class="container-fluid">
	               <div class="row rowgap"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                           
				           <div id="vsdiv" class="borderStyle"><jsp:include page="vWiseGrid.jsp"></jsp:include></div>                    
				        </div>  
	               </div>    
	            </div>              
            </div>  
            <!-- <div class="modal-footer">       
            </div> -->   
          </div>  
        </div>    
      </div>    
      <!-- Job Settlement modal-->                   
    <div id="modaljobsettlement" class="modal fade" role="dialog">                
      <div class="modal-dialog modal-xl">    
        <div class="modal-content">
          <div class="modal-header modalStyle" style="padding:5px">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Job Settlement</h4>                             
             <p id="lblname12" style="text-align:center;"></p>                                
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid"> 
             <div class="row rowgap">  
                         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-1" style="text-align:center;">                
								 <label  style="font-size: 12px;font-weight: bold;">REVENUE:</label>
					     </div>    
					     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-9" style="text-align:center;">&nbsp;</div>
					     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-2" style="text-align:center;"> 
							 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4" style="text-align:center;">                
									<button type="button" class="btn btn-default btnStyle" id="btnrevedit" title="Edit" data-placement="bottom" onclick="funRevEdit();" data-toggle="tooltip"><i class="fa fa-pencil-square-o " aria-hidden="true"></i></button>
						     </div>
						     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4" style="text-align:center;">             
									<button type="button" class="btn btn-default btnStyle" id="btnrevsave" title="Save" data-placement="bottom" onclick="funRevSave();" data-toggle="tooltip"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
						     </div>
						     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4" style="text-align:center;">             
									<button type="button" class="btn btn-default btnStyle" id="btnrevconfirm" title="Confirm" data-placement="bottom" onclick="funRevConfirm();" data-toggle="tooltip"><i class="fa fa-check-circle " aria-hidden="true"></i></button>
						     </div>   
					    </div>  
	         </div>  
             <div class="row rowgap">    
		             <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
						     <div id="revdiv" class="borderStyle"><jsp:include page="revenueGrid.jsp"></jsp:include></div>
					 </div>
             </div>
              <div class="row rowgap">  
                         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-1" style="text-align:center;">                
								 <label style="font-size: 12px;font-weight: bold;">EXPENSES:</label>  
					     </div> 
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
							  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">             
								    <label style="font-size: 13px;">Advance</label>           
						      </div> 
						      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">               
								    <input type="text" id="expadvance" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
						      </div> 
						 </div>  
						 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">             
								    <label style="font-size: 13px;">Expense</label>     
						      </div> 
						      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">             
								    <input type="text" id="expexpense" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
						      </div>
						 </div>  
						 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">             
								    <label style="font-size: 13px;">Balance</label>     
						      </div> 
						      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">             
								    <input type="text" id="expbalance" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
						      </div>
						 </div>     
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">             
								<select id="cmbexpcash" class="form-control input-sm"></select>
						 </div>   
						 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-2" style="text-align:center;">    
							 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4" style="text-align:center;">                 
									<button type="button" class="btn btn-default btnStyle" id="btnexpedit" title="Edit" data-placement="bottom" onclick="funExpEdit();" data-toggle="tooltip"><i class="fa fa-pencil-square-o " aria-hidden="true"></i></button>
						     </div>               
						     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4" style="text-align:center;">             
								<button type="button" class="btn btn-default btnStyle" id="btnexpsave" title="Save" data-placement="bottom" onclick="funExpSave();" data-toggle="tooltip"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					         </div>
					         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4" style="text-align:center;">             
								<button type="button" class="btn btn-default btnStyle" id="btnexpposting" title="Posting" data-placement="bottom" onclick="funExpPosting();" data-toggle="tooltip"><i class="fa fa-file-powerpoint-o " aria-hidden="true"></i></button>
					         </div>  
					    </div>     
	         </div> 
             <div class="row rowgap"> 
					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">    
						   <div id="expdiv" class="borderStyle"><jsp:include page="expensesGrid.jsp"></jsp:include></div> 
					</div>         
             </div>       
            </div>        
            </div>  
           <!-- <div class="modal-footer">     
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnjob" title="Create" data-placement="bottom" onclick="funJob();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div>
            </div>  -->        
          </div>  
        </div>  
      </div>  
     <!-- Shipment Details modal-->            
    <div id="modalshipmentdetail" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Shipment Details</h4>                 
               <p id="lblname13" style="text-align:center;"></p>                  
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
              <div class="container-fluid">   
                 <div class="row rowgap"> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>MAWB</label>                       
							<input type="text" id="txtmawb" class="form-control input-sm" />       
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>MBL</label>                       
							<input type="text" id="txtmbl" class="form-control input-sm" />       
						</div>       
					 </div>
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">           
		                <div class="form-group">
							<label>HAWB</label>                       
							<input type="text" id="txthawb" class="form-control input-sm" />       
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>HBL</label>                            
							<input type="text" id="txthbl" class="form-control input-sm" />       
						</div>       
					 </div> 
				</div>
				<div class="row rowgap"> 	 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>Shipper</label>                       
							<input type="text" id="txtshipper" class="form-control input-sm" />       
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>Consignee</label>                       
							<input type="text" id="txtconsignee" class="form-control input-sm" />       
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>Carrier</label>                                      
							<input type="text" id="txtcarrier" class="form-control input-sm" />       
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">  
							<label>FlightNo</label>                       
							<input type="text" id="txtflightno" class="form-control input-sm" />       
						</div>       
					 </div> 
				</div>
			    <div class="row rowgap"> 		 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>Vessel /Voage</label>                       
							<input type="text" id="txtvessel" class="form-control input-sm" />       
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>ETD</label>                       
							<div id="txtetd" onchange="getETA();"></div>         
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">          
		                <div class="form-group">
							<label>Transit Time</label>                            
							<input type="text" id="txttransittime" onchange="getETA();" onkeypress="return isNumberKey(event)" style="text-align: right" class="form-control input-sm" />          
						</div>       
					 </div>   
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		                <div class="form-group">
							<label>ETA</label>                       
							<div id="txteta"></div>       
						</div>       
					 </div> 
				</div>
				 <div class="row rowgap">   	 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">          
		                <div class="form-group">
							<label>BoE</label>                       
							<input type="text" id="txtboe" class="form-control input-sm" />       
						</div>       
					 </div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">         
		                <div class="form-group">
							<label>Container No</label>                       
							<input type="text" id="txtcontainerno" class="form-control input-sm" />       
						</div>       
					 </div> 
            	 </div>   
            	  <div class="row rowgap">   	 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">       
		                <div class="form-group">
							<label>TruckNo</label>                          
							<input type="text" id="txttruckno" class="form-control input-sm" />       
						</div>       
					 </div>                   
            	 </div> 
              </div> 
           </div> 
            <div class="modal-footer"> 
            	<div class="row rowgap">   
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnshipmentdetail" title="Save" data-placement="bottom" onclick="funshipmentdetails();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div>          
  <input type="hidden" name="hidassignmentid" id="hidassignmentid">   
  <input type="hidden" name="hidlblname" id="hidlblname">     
  <input type="hidden" name="hidcomments" id="hidcomments">        
  <input type="hidden" name="hiddocno" id="hiddocno"> 
  <input type="hidden" name="hidcldocno" id="hidcldocno">                                
  <input type="hidden" name="hidvocno" id="hidvocno">  
  <input type="hidden" name="hidbrhid" id="hidbrhid"> 
  <input type="hidden" name="hidadocno" id="hidadocno">  
  <input type="hidden" name="hidcpvtrno" id="hidcpvtrno"> 
  <input type="hidden" name="hidmcptrno" id="hidmcptrno">   
  <input type="hidden" name="hidmcpdocno" id="hidmcpdocno">       
  <input type="hidden" name="hidcpvamount" id="hidcpvamount">  
  <input type="hidden" name="hidmcpcashacno" id="hidmcpcashacno"> 
  <input type="hidden" name="hidjvtrno" id="hidjvtrno">     
  <input type="hidden" name="hidmcpposted" id="hidmcpposted">   
  <input type="hidden" name="hidcpudocno" id="hidcpudocno"> 
  <input type="hidden" name="hidmcpcredit" id="hidmcpcredit">
  <input type="hidden" name="hidmodeid" id="hidmodeid">
  <input type="hidden" name="hidshipid" id="hidshipid">   
  <input type="hidden" name="hidsmodeid" id="hidsmodeid">  
  <input type="hidden" name="hidenqdocno" id="hidenqdocno">  
  <input type="hidden" name="hidqotdocno" id="hidqotdocno">  
  <input type="hidden" name="hidcficonfirm" id="hidcficonfirm">    
  <input type="hidden" name="hidjobposted" id="hidjobposted"> 
  <input type="hidden" name="hidcfidocno" id="hidcfidocno">  
  <input type="hidden" name="hidjvdesc" id="hidjvdesc"> 
  <input type="hidden" name="hidcmbexpcash" id="hidcmbexpcash">  
  <input type="hidden" name="hidjobvndchk" id="hidjobvndchk">                                          
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>         
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){        
    	 $('[data-toggle="tooltip"]').tooltip();      
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    	 $("#dat").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"}); 
    	 $("#rcptdate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});     
    	 $("#jqxReferenceDate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});      
    	 $("#jobdate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});
    	 $("#txtetd").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});
    	 $("#txteta").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});
    	     
    	 $('#vendorinfowindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Vendor Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#vendorinfowindow').jqxWindow('close');  
		 
		 $('#productSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
		 $('#productSearchwindow').jqxWindow('close');
		    
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close'); 
		
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');     
		
		 $('#McpGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#McpGridWindow').jqxWindow('close');
		 
		 $('#unitsearchwindow').jqxWindow({width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%', title: 'Unit Search',position: { x: 500, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#unitsearchwindow').jqxWindow('close');
		 
		 $('#currencysearchwindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Currency Search' ,position: { x: 500, y: 120 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#currencysearchwindow').jqxWindow('close');   
	     
		 $('#sertypesearchwindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Service Type Search' ,position: { x: 500, y: 120 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#sertypesearchwindow').jqxWindow('close');             
	     funGetCountData();jobchkchange();             
    	 $("#cmbcash").select2({                                    
			    placeholder: "Select Account",                      
			    allowClear: true,
			    width: '100%'        
		 });
    	 $("#cmbexpcash").select2({                                    
			    placeholder: "Select Cash Account",                      
			    allowClear: true,
			    width: '100%'        
		 }); 
    	 $("#cmbpaymentto").select2({                                    
		    placeholder: "Select Account",                          
		    allowClear: true,
		    width: '100%'        
	     }); 
    	 $("#hidevendor").hide();      
		 $("#hidestaff").hide(); 
		 $("#hideuser").hide(); 
		 
		 $('#btnshipment').click(function() {   
    		 var docno = $('#hiddocno').val();
             if (docno == "") {
	             swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Please select a document'   
	             });
	             return false;
            }  
			 var cficonfirm = $('#hidcfidocno').val();             
			 if(cficonfirm==0){                  
				 swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Posting is not done'                                         
	             });
	             return false;  
			 }  
			 $("#txtmawb").val('');
		     $("#txtmbl").val('');
		     $("#txthawb").val('');   
			 $("#txthbl").val('');   
			 $("#txtshipper").val('');   
			 $("#txtconsignee").val('');
			 $("#txtcarrier").val(''); 
			 $("#txtflightno").val('');   
			 $("#txtvessel").val(''); 
			 $("#txtetd").val(new Date());            
			 $("#txteta").val('');   
			 $("#txttransittime").val(0);       
			 $("#txtboe").val('');   
			 $("#txtcontainerno").val('');         
			 $("#txttruckno").val('');  
			 getETA();    
			 getShipmentDetails();      
			 document.getElementById("lblname13").innerHTML=$("#hidlblname").val();   
	         $('#modalshipmentdetail').modal('toggle');                   
         });
		 $('#btnconfirm').click(function() {   
    		 var docno = $('#hiddocno').val();
             if (docno == "") {
	             swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Please select a document'   
	             });
	             return false;
            }
             var mcpposted = $('#hidmcpposted').val(); 
             var jvtrno=$("#hidjvtrno").val();
			 var cpudocno = $('#hidcpudocno').val(); 
			 var jobposted=$("#hidjobposted").val();
			 var cficonfirm = $('#hidcficonfirm').val();             
			 if(mcpposted==0 && cpudocno==0 && jvtrno==0 && jobposted==0 && cficonfirm==0){           
				 swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Posting is not done'                              
	             });
	             return false;  
			 }   
			 funconfirm();     
         });
		 $('#btnstatuslog').click(function() {     
    		 var docno = $('#hiddocno').val();
             if (docno == "") {
	             swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Please select a document'   
	             });
	             return false;
            } 
    		$("#jqxSLogGrid").jqxGrid('clear'); 
    		document.getElementById("lblname6").innerHTML=$("#hidlblname").val();   
    		loadSLog();    
            $('#modalstatuslog').modal('toggle');            
         });
		 $('#btnstatuswise').click(function() {     
    		$("#jqxSWiseGrid").jqxGrid('clear');        
    		loadSWise();      
            $('#modalstatuswise').modal('toggle');            
         });
		 $('#btnmodewise').click(function() {     
	    		$("#jqxMWiseGrid").jqxGrid('clear');   
	    		loadMWise();          
	            $('#modalmodewise').modal('toggle');            
	         });
		 $('#btndriveravl').click(function() {     
	    		$("#jqxDWiseGrid").jqxGrid('clear');   
	    		loadDWise();      
	            $('#modaldriverwise').modal('toggle');            
	         });
		 $('#btnvehicle').click(function() {     
	    		$("#jqxVWiseGrid").jqxGrid('clear');   
	    		loadVWise();          
	            $('#modalvehiclewise').modal('toggle');              
	         });
    	 $('#btnassignment').click(function() {     
    		 var docno = $('#hiddocno').val();
             if (docno == "") {
	             swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Please select a document'   
	             });
	             return false;
            } 
    		 $("#hidequipmentid").val('');    
			 $("#trackid").val('');
			 $("#remarks").val('');
			 $('#dat').val(new Date());      
			 $("#cmbasgmnttype").val('');
			 $("#hidassignmentid").val('');    
			 $("#jqxStaff").val(''); 
			 $("#jqxVendor").val(''); 
			 $("#jqxRegno").val('');  
			 document.getElementById("lblname").innerHTML=$("#hidlblname").val();                
             $('#modalassignment').modal('toggle');       
         });
    	 $('#btnstatus').click(function() { 
    		 var docno = $('#hiddocno').val();
             if (docno == "") {
	             swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Please select a document'   
	             });
	             return false;
            } 
    		$('#cmbstatus').val(''); 
    		document.getElementById("lblname1").innerHTML=$("#hidlblname").val();
            $('#modalstatus').modal('toggle');                             
         });
    	 $('#btnsubstatus').click(function() { 
    		 var docno = $('#hiddocno').val();
             if (docno == "") {
	             swal({
	                 type: 'warning',
	                 title: 'Warning',
	                 text: 'Please select a document'   
	             });
	             return false;
             } 
    		 $('#cmbsubstatus').val('');
    		 $('#subremraks').val('');  
    		 document.getElementById("lblname11").innerHTML=$("#hidlblname").val();   
             $('#modalsubstatus').modal('toggle');                                        
         });
    	 $('#btnreceipt').click(function() {       
      	    var docno = $('#hiddocno').val();
              if (docno == "") {
              swal({
                  type: 'warning',
                  title: 'Warning',
                  text: 'Please select a document'   
              });
              return false;
             }         
            $('#txtdocno').val('');      
 			$('#txtrefno').val(''); 
 			$('#txtrcptdesc').val('');            
 			$('#txtamount').val('');   
 			$('#txtaccid').val(''); 
 			$('#txtaccname').val(''); 
 			$('#cmbpaytype').val(''); 
 			$('#cmbcardtype').val(''); 
 			$('#jqxReferenceDate').val(new Date);  
 			$('#rcptdate').val(new Date); 
 			$('#hidrcptclacno').val('');               
 			$('#hidrcptcldocno').val(''); 
 			$('#jqxClientRcpt').val('');      
            document.getElementById("lblname2").innerHTML=$("#hidlblname").val();             
            $('#modalreceipt').modal('toggle');          
          });  
    	 $('#btnjobadvance').click(function() { 
    		  var cpvtrno =$('#hidcpvtrno').val();    
       	      var docno = $('#hiddocno').val();    
              if (docno == "") {
               swal({
                   type: 'warning',
                   title: 'Warning',
                   text: 'Please select a document'   
               });
               return false;
              }   
              if (cpvtrno>0) {      
                  swal({
                      type: 'warning',
                      title: 'Warning',
                      text: 'Already created'               
                  });
                  return false;
              }          
              $("#cmbcash").val(''); 
			  $("#jobamount").val(''); 
			  $("#jobdesc").val('');                  
			  $("#jobdate").val(new Date);  
			  $('#hidjobvndchk').val('');
				$('#jqxJobVendor').val('');
				$('#jobvndchkval').val('');
				$('#hidjobvndid').val('');   
				document.getElementById("jobvndchk").checked=false;   
              document.getElementById("lblname3").innerHTML=$("#hidlblname").val();                
              $('#modaljobadvance').modal('toggle');              
           });  
    	  $('#btnbillsettlement').click(function() {       
      	     var docno = $('#hiddocno').val();
      	     var mcptrno =$('#hidmcptrno').val();
      	     var mcpcredit =$('#hidmcpcredit').val();       
      	     var cpvamount = $('#hidcpvamount').val();      
             if (docno == "") {
              swal({
                  type: 'warning',
                  title: 'Warning',
                  text: 'Please select a document'   
              });
              return false;
             }   
             if (mcptrno>0 || mcpcredit>0) {                
                 swal({
                     type: 'warning',
                     title: 'Warning',
                     text: 'Already created'               
                 });
                 return false;
             }             
             funRoundAmt(cpvamount,"advamount");  
             $("#cmbcashacc").val(''); 
			 $("#jqxMCPCash").jqxGrid('clear'); 
			 $("#jqxMCPCredit").jqxGrid('clear'); 
			 $("#jqxMCPCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			 $("#jqxMCPCredit").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
             document.getElementById("lblname4").innerHTML=$("#hidlblname").val();                   
             $('#modalbillsettlement').modal('toggle');                   
           });
    	  $('#btnjobsettlement').click(function() {       
       	      var docno = $('#hiddocno').val();
       	      var advance = $('#hidcpvamount').val();       
              if (docno == "") {
               swal({
                   type: 'warning',
                   title: 'Warning',
                   text: 'Please select a document'   
               });
               return false;
              }   
              document.getElementById("lblname12").innerHTML=$("#hidlblname").val();  
              loadRevenueGrid(); getExpCashAccount(); 
              funRoundAmt(advance,"expadvance"); 
              funRoundAmt(0,"expexpense");
              funRoundAmt(0,"expbalance");        
              $('#modaljobsettlement').modal('toggle');  
            });
    	  $('#btnposting').click(function() {                   
       	     var docno = $('#hiddocno').val();
       	     var mcptrno =$('#hidmcptrno').val();
   	         var mcpcredit =$('#hidmcpcredit').val();         
             if (docno == "") {       
               swal({
                   type: 'warning',
                   title: 'Warning',
                   text: 'Please select a document'   
               });
               return false;
              }   
             if (mcptrno==0 && mcpcredit==0) {                 
                  swal({
                      type: 'warning',
                      title: 'Warning',
                      text: 'Bill settlement is not done'                    
                  });
                  return false;
              } 
              var mcpposted = $('#hidmcpposted').val(); 
			  if(mcpposted>0){
				  $("#btnmcposting").addClass('btnbgcolor1');    
			  }else{   
				  $("#btnmcposting").addClass('btnbgcolor2');       
			  }
			  var jvtrno=$("#hidjvtrno").val();
			  if(jvtrno>0){   
				   $("#btnjvcreate").addClass('btnbgcolor1');        
			   }else{
				   $("#btnjvcreate").addClass('btnbgcolor2');      
			   }
			  var cpudocno = $('#hidcpudocno').val(); 
			  if(cpudocno>0){
				  $("#btnnipurchasecreate").addClass('btnbgcolor1');        
			  }else{
				  $("#btnnipurchasecreate").addClass('btnbgcolor2');     
			  } 
			  console.log("mcpposted="+mcpposted+"=jvtrno="+jvtrno+"=cpudocno="+cpudocno);   
              funjvload();  funPostCashload(); funPostCreditload();     
              document.getElementById("lblname5").innerHTML=$("#hidlblname").val();                     
              $('#modalposting').modal('toggle');                 
            });
    	
        $('#btnsubmit').click(function(){  
        	$("#overlay, #PleaseWait").show();
        	funload();funGetCountData();
            $('.textpanel p').text("");
            $('#hiddocno').val(''); 
            $('#hidvocno').val('');    
            $('#hidlblname').val('');   
            $('#hidbrhid').val('');  
            $('#hidadocno').val('');
            $('#hidassignmentid').val(''); 
            $('#hidcomments').val(''); 
            $('#hidcldocno').val(''); 
            $('#hidcpvtrno').val(''); 
            $('#hidmcptrno').val(''); 
            $('#hidmcpdocno').val(''); 
            $('#hidcpvamount').val(''); 
            $('#hidmcpcashacno').val(''); 
            $('#hidjvtrno').val(''); 
			$('#hidmcpposted').val(''); 
			$('#hidcpudocno').val('');
			$('#rowindex').val('');
			$('#hidmcpcredit').val('');
			$('#hidmodeid').val('');
			$('#hidshipid').val('');
			$('#hidsmodeid').val('');
			$('#hidenqdocno').val('');
			$('#hidqotdocno').val('');
			$('#hidcficonfirm').val('');
			$('#hidjobposted').val('');
			$('#hidcfidocno').val('');
			$('#cmbexpcash').val('');
			$('#hidjvdesc').val('');
			$('#hidjobvndchk').val('');
			$('#jqxJobVendor').val('');
			$('#jobvndchkval').val('');
			$('#hidjobvndid').val('');   
			document.getElementById("jobvndchk").checked=false;   
        });          
        $('#btncomment').click(function(){        
	        var actdocno=$('#hiddocno').val();
	    	if(actdocno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	      	getComments(); 
	      	$('#modalcomments').modal('toggle');          
        }); 
        $('#btnexcel').click(function(){            
        	 $("#opndiv").excelexportjs({
 				containerid: "opndiv",        
 				datatype: 'json',
 				dataset: null,
 				gridId: "jqxAssignmentgrid",
 				columns: getColumns("jqxAssignmentgrid") ,     
 				worksheetName:"Operation"          
 			});   
        });
        $('#btncommentsend').click(function(){
        	 var actdocno=$('#hiddocno').val();
        	var txtcomment=$('#txtcomment').val();  
        	if(actdocno==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	saveComment();
        });
        
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#jqxAssignmentgrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });         
    });  
    function addDays(date, days) {
	  var result = new Date(date);
	  result.setDate(result.getDate() + days);
	  return result;
	}
    function isNumberKey(evt){
		var charCode = (evt.which) ? evt.which : event.keyCode
		if (charCode > 31 && ((charCode < 48) || (charCode > 57))) 
			return false;     
		return true;
	} 
   function VendorSearchContent(url) {
		$('#vendorinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vendorinfowindow').jqxWindow('setContent', data);
		$('#vendorinfowindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function McpSearchContent(url) {
		$('#McpGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#McpGridWindow').jqxWindow('setContent', data);
		$('#McpGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountSearchContent(url) {
		    $('#accountDetailsFromWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsFromWindow').jqxWindow('setContent', data);
			$('#accountDetailsFromWindow').jqxWindow('bringToFront');
		}); 
		}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	 function getproductdetails(rowindextemp,id){
		$('#productSearchwindow').jqxWindow('open');
	    productSearchContent('productSearchGrid.jsp?rowindex='+rowindextemp+'&id='+id);         
	 }
	 function productSearchContent(url) {
	        $.get(url).done(function (data) {
	        $('#productSearchwindow').jqxWindow('setContent', data);
		}); 
	 }           
   function funRoundAmt(value,id){
	  var res=parseFloat(value).toFixed("2");                    
	  var res1=(res=='NaN'?"0":res);
	  document.getElementById(id).value=res1;  
	 }
   function addGridFilters(filtervalue,datafield){
	   	var filtergroup = new $.jqx.filter();
	   	var filter_or_operator = 1;
	   	var filtercondition = 'equal';
	   	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
	   	/*filtervalue = 'Andrew';
	   	filtercondition = 'starts_with';
	   	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/
	
	   	filtergroup.addfilter(filter_or_operator, filter1);
	   	//filtergroup.addfilter(filter_or_operator, filter2);
	   	// add the filters.
	   	$("#jqxAssignmentgrid").jqxGrid('addfilter', datafield, filtergroup);
	   	// apply the filters.
	   	$("#jqxAssignmentgrid").jqxGrid('applyfilters');
	}   
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var docno=$('#hiddocno').val();
    	$('#hidcomments').val($('#txtcomment').val());
   	    if (($(hidcomments).val()).includes('$')) { $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));};if (($(hidcomments).val()).includes('%')) { $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));};
   	    if (($(hidcomments).val()).includes('^')) { $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));};if (($(hidcomments).val()).includes('`')) { $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));};
   	    if (($(hidcomments).val()).includes('~')) { $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));};if ($(hidcomments).val().indexOf('\'')  >= 0 ) { $(hidcomments).val($(hidcomments).val().replace(/'/g, ''));};
   	    if (($(hidcomments).val()).includes(',')) { $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));}
   	    if ($(hidcomments).val().indexOf('"') >= 0) { $(hidcomments).val($(hidcomments).val().replace(/["']/g, ''));};
   	    if (($(hidcomments).val()).match(/\\/g)) { $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));}; 
    
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
		x.open("POST","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&docno="+docno,true);      
		x.send();
    }
    function getComments(){  
    	var docno=$('#hiddocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='';
				if(items!=''){ 
				for(var i=0;i<items.length;i++){
					str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
				}
				$('.comments-container').html($.parseHTML(str));		
				}else{}	
			}   
			else
			{
			}
		}
		x.open("GET","getComments.jsp?docno="+docno,true);         
		x.send();      
    }
    
   function funload(){   
	   funGetCountData();         
       $('#opndiv').load("assignmentGrid.jsp?id="+1);                                                         
   }
   function getStatus() {   
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText;
 				items = items.split('####');
 				var cardIdItems  = items[0].split(",");
 				var cardItems = items[1].split(",");
 				var optionscard = '<option value="">--Select--</option>';
 				for (var i = 0; i < cardItems.length; i++) {
 					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
 							+ cardItems[i] + '</option>';
 				}
 				$("select#cmbstatus").html(optionscard);      
 				if ($('#hidcmbstatus').val() != null) {
 					$('#cmbstatus').val($('#hidcmbstatus').val());
 				}
 			} else {
 			}
 		}
 		x.open("GET", "getStatus.jsp", true);
 		x.send();
   } 
   function getSubStatus() {   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var cardIdItems  = items[0].split(",");
				var cardItems = items[1].split(",");
				var optionscard = '<option value="">--Select--</option>';
				for (var i = 0; i < cardItems.length; i++) {
					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
							+ cardItems[i] + '</option>';
				}
				$("select#cmbsubstatus").html(optionscard);      
				if ($('#hidcmbsubstatus').val() != null) {    
					$('#cmbsubstatus').val($('#hidcmbsubstatus').val());
				}
			} else {
			}
		}
		x.open("GET", "getSubStatus.jsp", true);
		x.send();
   } 
   function getCashAccount() {   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var cardIdItems  = items[0].split(",");
				var cardItems = items[1].split(",");
				var optionscard = '<option value="">--Select--</option>';
				for (var i = 0; i < cardItems.length; i++) {
					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
							+ cardItems[i] + '</option>';
				}
				$("select#cmbcash").html(optionscard);      
				if ($('#hidcmbcash').val() != null) {    
					$('#cmbcash').val($('#hidcmbcash').val());     
				}
			} else {
			}
		}
		x.open("GET", "getCashAccount.jsp", true);
		x.send();
  } 
   function getExpCashAccount() {      
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var cardIdItems  = items[0].split(",");
				var cardItems = items[1].split(",");
				var optionscard = '<option value="">--Select--</option>';
				for (var i = 0; i < cardItems.length; i++) {
					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
							+ cardItems[i] + '</option>';
				}
				$("select#cmbexpcash").html(optionscard);
				if ($('#hidcmbexpcash').val() != null) {    
					$('#cmbexpcash').val($('#hidcmbexpcash').val());                
				}
			} else {  
			}
		}
		x.open("GET", "getCashAccount.jsp", true);
		x.send();
 }
   function getMCPCashAccount() {      
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var cardIdItems  = items[0].split(",");
				var cardItems = items[1].split(",");
				var optionscard = '<option value="">--Select--</option>';
				for (var i = 0; i < cardItems.length; i++) {
					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
							+ cardItems[i] + '</option>';
				}
				$("select#cmbcashacc").html(optionscard);      
				if ($('#hidcmbcashacc').val() != null) {    
					$('#cmbcashacc').val($('#hidcmbcashacc').val());                
				}
			} else {
			}
		}
		x.open("GET", "getCashAccount.jsp", true);
		x.send();
  }
   function getPayType() {
		var optionscard  ='<option value="">--Select--</option>';
       optionscard +='<option value="1">Cash</option>';
       optionscard +='<option value="2">Card</option>';
       optionscard +='<option value="3">Cheque/Online</option>';
		$("select#cmbpaytype").html(optionscard);
    } 
    function getCardTypes() {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var cardIdItems  = items[0].split(",");
	  				var cardItems = items[1].split(",");
	  				var optionscard = '<option value="">--Select--</option>';
	  				for (var i = 0; i < cardItems.length; i++) {
	  					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
	  							+ cardItems[i] + '</option>';
	  				}
	  				$("select#cmbcardtype").html(optionscard);
	  				if ($('#hidcmbcardtype').val() != null) {
	  					$('#cmbcardtype').val($('#hidcmbcardtype').val());
	  				}
	  			} else {
	  			}
	  		}
	  		x.open("GET", "getCardTypes.jsp", true);
	  		x.send();
	  } 
	 function funclearchequecardno(){
	    	$('#txtrefno').val('');
	    }
	 function funcardvalidation(){
		 if($("#cmbpaytype").val()=='2'){
			if(window.parent.cardnumbervalidator.value==1){
	            cardnumber($("#txtrefno").val());
 	    	}
		 }
	}
	 function getAccounts(a){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {     
	  			if (x.readyState == 4 && x.status == 200) {       
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var accountIdItems  = items[0];
	  				var accountItems = items[1];
	  				var docNoItems = items[2];
	  			$('#txtaccid').val(accountIdItems) ;
	  			$('#txtaccname').val(accountItems) ;    
	  			$('#txtdocno').val(docNoItems) ;
	  		}
	  		}
	  		x.open("GET", "getAccounts.jsp?paytype="+a, true);
	  		x.send();
	 }
	 function funchequedate(){
	  	  paytype=document.getElementById("cmbpaytype").value; 
	  	  if(paytype==3){
			      var chequedate = $('#jqxReferenceDate').jqxDateTimeInput('getDate');
				  var chequeDates =new Date(chequedate).setDate(chequedate.getDate());   
				  $('#jqxReferenceDate').jqxDateTimeInput('setDate', new Date(chequeDates)); 
				  $('#cmbcardtype').attr('disabled', true);
				  $('#txtrefno').attr('readonly', false);
				  $('#txtrefno').val('');
				  getCardTypes();
				  $('#txtrcptdesc').val('');
	  	  }
	  	  else if(paytype==1){
	  		  $('#cmbcardtype').attr('disabled', true); 
	  		  $('#txtrefno').attr('readonly', true);
	  		  $('#txtrefno').val('');
	  		   getCardTypes();
	  		   $('#txtrcptdesc').val('');
	  	  }
	  	  else if(paytype==2){
	  		  $('#cmbcardtype').attr('disabled', false); 
	  		  $('#txtrefno').attr('readonly', false);
	  		  $('#txtrefno').val('');
	  		  getCardTypes();  
	  		  $('#txtrcptdesc').val('');
	  	  }else if(paytype==4){          
	  	      $('#cmbcardtype').attr('disabled', true); 
	  		  $('#txtrefno').attr('readonly', true);
	  		  $('#txtrefno').val('');
	  		  $('#txtaccid').attr('readonly', true);
	  		  $('#txtaccid').val('');
	  		  $('#txtaccname').attr('readonly', true);
	  		  $('#txtaccname').val('');   
	  		  $('#txtdocno').val('');           
	  		  $('#txtrcptdesc').val('');                                                                       
	  	  }
	  }
	 function funreceiptcreate(){             
		    var date=$('#rcptdate').jqxDateTimeInput('val');              
			var docno=$('#hiddocno').val();    
			var cmbpaytype=$('#cmbpaytype').val(); 
			var brhid=$('#hidbrhid').val();           
			var ReferenceDate=$('#jqxReferenceDate').jqxDateTimeInput('val');   
			var txtdocno=$('#txtdocno').val();  
			var cmbcardtype=$('#cmbcardtype').val();            
			var txtrefno=$('#txtrefno').val(); 
			var txtdesc=$('#txtrcptdesc').val();               
			var txtamount=$('#txtamount').val(); 
			var clacno=$('#hidrcptclacno').val();               
			var cldocno=$('#hidrcptcldocno').val();          
			if(docno==''){  
				swal({
					type: 'warning',   
					title: 'Warning',       
					text: ' Please select a document '
				});
				 return 0;
			 }  
			 if(cmbpaytype==''){    
				swal({
					type: 'warning',   
					title: 'Warning',       
					text: ' Please select a pay type '
				});
				 return 0;
			 }    
		   $.messager.confirm('Message', 'Do you want to create commercial receipt?', function(r){     
				     	if(r==false)
				     	  {
				     		return false;   
				     	  }  
				     	else {
				     		$("#overlay, #PleaseWait").show();
				     		saveReceiptData(cmbpaytype,ReferenceDate,txtdocno,cmbcardtype,txtrefno,txtdesc,txtamount,brhid,date,docno,cldocno,clacno);          
				     	}  
			});                
		}
		
		function saveReceiptData(cmbpaytype,ReferenceDate,txtdocno,cmbcardtype,txtrefno,txtdesc,txtamount,brhid,date,docno,cldocno,clacno){                     
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;     
			   if(parseInt(items)>=1)
				{   
				   swal({
						type: 'success',
						title: 'Success',  
						text: ' Successfully Created '
					});
				    $("#overlay, #PleaseWait").hide();    
					funchequedate();
					$('#modalreceipt').modal('toggle');        
				}
				else
				{      
					swal({
						type: 'error',
						title: 'Error',  
						text: ' Not Created '   
					}); 
					$("#overlay, #PleaseWait").hide(); 
					$('#modalreceipt').modal('toggle');   
				}
			}                 
			}   
			x.open("POST","createCR.jsp?paytype="+cmbpaytype+"&date="+date+"&refdate="+ReferenceDate+"&acdocno="+txtdocno+"&cardtype="+cmbcardtype+"&refno="+txtrefno+"&desc="+txtdesc+"&netamt="+txtamount+"&docno="+docno+"&brhid="+brhid+"&clacno="+clacno+"&cldocno="+cldocno,true);                                                 
			x.send();           
		}                  
		 function funCreateNiPurchase(){       
				$.messager.confirm('Message', 'Do you want to create purchase invoice?', function(r){             
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }  
			     	else {  
			     		//funCreateNiPurchase1();                          
			     	}  
			 }); 
			}
         function setAssignment(){
				var asgmnttype = $("#cmbasgmnttype").val();
				if(asgmnttype=="1"){
					$("#hidassignmentid").val('');
					$("#jqxStaff").val('');
					$("#jqxUser").val(''); 
					$("#hidevendor").show();  
					$("#hidestaff").hide();  
					$("#hideuser").hide();     
				}else if(asgmnttype=="2"){
					$("#hidassignmentid").val('');
					$("#jqxVendor").val('');   
					$("#jqxUser").val(''); 
					$("#hidevendor").hide(); 
					$("#hideuser").hide();  
					$("#hidestaff").show();      
				}else if(asgmnttype=="3"){  
					$("#hidassignmentid").val('');
					$("#jqxVendor").val('');  
					$("#jqxStaff").val('');                 
					$("#hideuser").show();  
					$("#hidevendor").hide();      
					$("#hidestaff").hide();                  
				}else{
					$("#hidevendor").hide();      
					$("#hidestaff").hide();
					$("#hideuser").hide();
					$("#hidassignmentid").val('');     
					$("#jqxVendor").val(''); 
					$("#jqxStaff").val(''); 
					$("#jqxUser").val('');       
				}    
		    }    
		   
		   function funAssignment(){ 
			    var agtype=$("#cmbasgmnttype").val();
				var agto=$("#hidassignmentid").val();
				if(agtype==''){   
					 swal({
	 						type: 'warning',
	 						title: 'Warning', 
	 						text: 'Please select assignment type'
	 					});
					 return 0;
				}
				if(agto==''){
					 swal({
	 						type: 'warning',
	 						title: 'Warning', 
	 						text: 'Please select assignment to'       
	 					});
					 return 0;
				}
				$.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
					 if (r){
						 var brhid=$("#hidbrhid").val(); 
						 var docno=$("#hiddocno").val();      
					 	 var equipment=$("#hidequipmentid").val();    
						 var trackid=$("#trackid").val();
						 var remarks=$("#remarks").val();
						 var compldate=$('#dat').jqxDateTimeInput('val');
						 saveAssignment(agtype,agto,equipment,trackid,compldate,remarks,brhid,docno);    
					 }
				});
			}
			function saveAssignment(agtype,agto,equipment,trackid,compldate,remarks,brhid,docno){  
				var x=new XMLHttpRequest();
				  x.onreadystatechange=function(){
					  if (x.readyState==4 && x.status==200){
						    var items=x.responseText.trim();
						    if(parseInt(items)>0){ 
						    	swal({
				 					type: 'success',    
				 					title: 'Success', 
				 					text: 'Record Successfully Saved'
				 				 });
						    	$('#modalassignment').modal('toggle');  
							    funload();   
						    }else{   
						    	 swal({
						 				type: 'error',    
						 				title: 'Error', 
						 				text: 'Not Saved'
						 			 });
						    	 $('#modalassignment').modal('toggle');       
						    }    
					  }          
				 }
				 x.open("POST","saveAssignment.jsp?agtype="+agtype+"&agto="+agto+"&equipment="+equipment+"&trackid="+trackid+"&expdate="+compldate+"&remarks="+remarks+"&docno="+docno+"&brhid="+brhid,true);           
				 x.send();
			}
			
		function funStatusUpdate(){
				var statusid=$("#cmbstatus").val();
				var brhid=$("#hidbrhid").val(); 
				var vocno=$("#hidvocno").val(); 
				var adocno=$("#hidadocno").val();       
				if(statusid==''){
			  		swal({
 						type: 'warning',
 						title: 'Warning', 
 						text: 'Choose a Status'
 					});
			 		 return 0;
			  	 }
				if(adocno==0){                          
					 swal({
	 						type: 'warning',
	 						title: 'Warning', 
	 						text: 'Document is not assigned'                                   
	 					});
					 return 0;
				}           
				$.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
					     if (r){
							saveStatus(statusid,brhid,vocno,adocno);          
						}
				});
			}
		 function saveStatus(statusid,brhid,vocno,adocno){
			     var x=new XMLHttpRequest();
				 x.onreadystatechange=function(){
					 if (x.readyState==4 && x.status==200){
							var items= x.responseText;
							var itemval=items.trim();
							if(parseInt(itemval)>0){ 
									swal({
					 					type: 'success',    
					 					title: 'Success', 
					 					text: 'Record Successfully Saved'
					 				 });
									 $('#modalstatus').modal('toggle'); 
									 funload();  
							}else{
								    swal({
						 				type: 'error',    
						 				title: 'Error', 
						 				text: 'Not Saved'
						 			 });
								    $('#modalstatus').modal('toggle'); 
							}
					  }
				 }  
				 x.open("POST","statusUpdate.jsp?doc_no="+statusid+"&brhid="+brhid+"&vocno="+vocno+"&adocno="+adocno,true);                  
				 x.send();        
	       }
		 function funAttach(){
				var brchid=$('#hidbrhid').val();   
				var frmname="Estimation Create";      
				var frmcode="CESM";                        
				if ($("#hiddocno").val()!="") {        	  
					var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmcode
							 +"&docno="+document.getElementById("hidvocno").value+"&brchid="+brchid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					myWindow.focus();  
				} else {
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					return false; 
				}            
		    } 
		function funSubStatusUpdate(){
				var statusid=$("#cmbsubstatus").val(); 
				var subremarks=$("#subremarks").val();  
				var brhid=$("#hidbrhid").val();        
				var vocno=$("#hidvocno").val(); 
				var adocno=$("#hidadocno").val();       
				if(statusid==''){
			  		swal({
 						type: 'warning',
 						title: 'Warning', 
 						text: 'Choose a Status'
 					});
			 		 return 0;
			  	 } 
				if(adocno==0){                    
					 swal({
	 						type: 'warning',
	 						title: 'Warning', 
	 						text: 'Document is not assigned'                                   
	 					});
					 return 0;
				}    
				$.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
					     if (r){
					    	 saveSubStatus(statusid,brhid,vocno,adocno,subremarks);           
						}
				});
			}
		 function saveSubStatus(statusid,brhid,vocno,adocno,subremarks){
			     var x=new XMLHttpRequest();
				 x.onreadystatechange=function(){
					 if (x.readyState==4 && x.status==200){
							var items= x.responseText;
							var itemval=items.trim();
							if(parseInt(itemval)>0){ 
									swal({
					 					type: 'success',    
					 					title: 'Success', 
					 					text: 'Record Successfully Saved'
					 				 });
									 $('#modalsubstatus').modal('toggle'); 
									 funload();  
							}else{
								    swal({
						 				type: 'error',    
						 				title: 'Error', 
						 				text: 'Not Saved'
						 			 });
								    $('#modalsubstatus').modal('toggle'); 
							}
					  }
				 }  
				 x.open("POST","subStatusUpdate.jsp?doc_no="+statusid+"&brhid="+brhid+"&vocno="+vocno+"&adocno="+adocno+"&subremarks="+subremarks,true);                
				 x.send();        
	       }   
		 function funCashPaymentCreate(){ 
				var vndacno=$("#hidjobvndid").val();  
				var vndchk=$("#jobvndchkval").val();
				var cashdocno=$("#cmbcash").val(); 
				var jobamount=$("#jobamount").val(); 
				var jobdesc=$("#jobdesc").val(); 
				var docno=$("#hiddocno").val(); 
				var brhid=$("#hidbrhid").val();
				var date=$("#jobdate").jqxDateTimeInput('val');
				if(date==''){
			  		swal({
						type: 'warning',
						title: 'Warning', 
						text: 'Please enter date'   
					});
			 		 return 0;
			  	 }  
				if(cashdocno==''){
			  		swal({
						type: 'warning',
						title: 'Warning', 
						text: 'Choose Cash Account'
					});
			 		 return 0;
			  	 } 
				if(jobamount==0){                    
					 swal({
	 						type: 'warning',
	 						title: 'Warning', 
	 						text: 'Please enter amount'                                           
	 					});
					 return 0;
				}
			if(vndchk==1){   
				   if(vndacno==''){
			  		swal({
						type: 'warning',
						title: 'Warning', 
						text: 'Please enter vendor account'      
					});
			 		 return 0;
			  	 }              
			}       	   
			$.messager.confirm('Confirm', 'Do you want to create cash payment?', function(r){    
					     if (r){
					    	 saveCPVData(cashdocno,jobamount,jobdesc,docno,brhid,date,vndchk,vndacno);                                      
						}
				});
			}
		 function saveCPVData(cashdocno,jobamount,jobdesc,docno,brhid,date,vndchk,vndacno){               
			     var x=new XMLHttpRequest();
				 x.onreadystatechange=function(){
					 if (x.readyState==4 && x.status==200){
							var items= x.responseText;   
							var itemval=items.trim();
							if(parseInt(itemval)>0){ 
									swal({
					 					type: 'success',    
					 					title: 'Success', 
					 					text: 'CPV -'+parseInt(itemval)+' Successfully Created'          
					 				 });
									 $('#modaljobadvance').modal('toggle');
									 $("#hidcpvtrno").val(parseInt(itemval));   
									 funRoundAmt($("#jobamount").val(),"advamount");                                          
									 funload();  
							}else{
								    swal({
						 				type: 'error',    
						 				title: 'Error', 
						 				text: 'Not Created'   
						 			 });
								    $('#modaljobadvance').modal('toggle');                
							}
					  }
				 }         
				 x.open("POST","createCPV.jsp?cashdocno="+cashdocno+"&brhid="+brhid+"&docno="+docno+"&jobamount="+jobamount+"&jobdesc="+jobdesc+"&date="+date+"&vndchk="+vndchk+"&vndacno="+vndacno,true);                             
				 x.send();                          
	     }  
		 function funBill(){     
			    var date = new Date();       
				var cashdocno=$("#cmbcashacc").val();        
				var docno=$("#hiddocno").val(); 
				var brhid=$("#hidbrhid").val();
				var mcparray=new Array();  
				var mcpcreditarray=new Array();  
				if(cashdocno==''){
			  		swal({
						type: 'warning',
						title: 'Warning', 
						text: 'Choose Cash Account'
					});
			 		 return 0;
			  	 } 
				 var val=0,val1=0,i=0,val2=0;
				 var rows=$('#jqxMCPCash').jqxGrid('getrows');   
				 var totalbase=$('#jqxMCPCash').jqxGrid('getcolumnaggregateddata', 'total', ['sum'], true);    
	             totalbase1=parseFloat(totalbase.sum.replace(',',''));       
				 for(i=0;i<rows.length;i++){            
				 	var chk=rows[i].docno;   
				 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){           
				 		   if(i==0){           
				 			  mcparray.push(cashdocno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::false::"+totalbase1+"::"+rows[i].description+"::"+totalbase1+"::0:: "+0+":: "+0+"::"+0+"::"+0+"::"+0+"::"+rows[i].hidinvdate+"::"+0+"::"+totalbase1+"::"+0+"::"+0+"::"+0+"::"+0+"::"+0);
				 		   }    
				 		   mcparray.push(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::true::"+rows[i].amount1+"::"+rows[i].description+"::"+rows[i].amount1+"::0:: "+4+":: "+docno+"::"+rows[i].vendorid+"::"+rows[i].tinno+"::"+rows[i].invno+"::"+rows[i].hidinvdate+"::"+rows[i].taxamt+"::"+rows[i].total+"::"+rows[i].rowno+"::"+rows[i].srvtaxper+"::"+rows[i].psrno+"::"+rows[i].qty+"::"+rows[i].unitprice);                                          
				 	         val=1;  
				 	    }          
				 }   
				 var rows1=$('#jqxMCPCredit').jqxGrid('getrows');          
				 for(var i=0;i<rows1.length;i++){ 
				 	var chk=rows1[i].docno;                                   
				 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){           
				 		     mcpcreditarray.push(rows1[i].docno+"::"+rows1[i].psrno+"::"+rows1[i].rate+"::"+rows1[i].currencyid+"::"+rows1[i].docno+"::"+4+"::"+docno+"::"+rows1[i].qty+"::"+rows1[i].unitprice+"::"+rows1[i].amount1+"::"+rows1[i].srvtaxper+"::"+rows1[i].taxamt+"::"+rows1[i].total+"::"+rows1[i].vendorid+"::"+rows1[i].invno+"::"+rows1[i].hidinvdate+"::"+rows1[i].tinno+"::");                                          
				 		     var chk3=rows1[i].vendorid;                                   
						 	 if(typeof(chk3) == "undefined" || typeof(chk3) == "NaN" || chk3 == ""){ 
				 		        val1=1;            
						 	 }
						 	 val2=1;
				 	    }          
				    }
				  if(val1==1){                        
			             swal({
								type: 'warning',
								title: 'Warning',
								text: 'Vendor is mandatory'                        
							});
							return false;    
			       }
				  if(val==0 && val2==0){                      
			             swal({
								type: 'warning',
								title: 'Warning',
								text: 'Please enter data'                    
							});
							return false;    
			     }
				$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){       
					     if (r){
					    	 saveBillSettlement(cashdocno,mcparray,docno,brhid,date,mcpcreditarray,totalbase1);                                                    
						}
				});
			}
		 function saveBillSettlement(cashdocno,mcparray,docno,brhid,date,mcpcreditarray,totalbase1){   
				 var advamount=$("#advamount").val();   
				 var stlamount=$("#settleamount").val();
				 var billamount=$("#billamount").val();    
			     var x=new XMLHttpRequest();          
				 x.onreadystatechange=function(){
					 if (x.readyState==4 && x.status==200){
							var items= x.responseText.split('###');             
							if(parseInt(items[0])>0){ 
								    var descpt="";
								    if(parseInt(items[1])>0){        
								    	descpt='MCP -'+parseInt(items[1]); 
								    	$("#hidmcptrno").val(parseInt(items[1]));      
								    }else{
								    	$("#hidmcpcredit").val(parseInt(items[0]));     
								    }
									swal({
					 					type: 'success',    
					 					title: 'Success', 
					 					text: descpt+' Successfully Created'                               
					 				 });
									 $("#advamount").val('');
									 $("#settleamount").val('');
									 $("#billamount").val('');    
									 $('#modalbillsettlement').modal('toggle');    
									 funload();  
							}else{
								    swal({
						 				type: 'error',    
						 				title: 'Error', 
						 				text: 'Not Created'   
						 			 });   
								    $('#modalbillsettlement').modal('toggle');                          
							}
					  }
				 }         
				 x.open("POST","saveBillSettlement.jsp?cashdocno="+cashdocno+"&stlamount="+stlamount+"&billamount="+billamount+"&advamount="+advamount+"&amount="+totalbase1+"&mcpcreditarray="+mcpcreditarray+"&brhid="+brhid+"&mcparray="+mcparray+"&docno="+docno+"&date="+date,true);                         
				 x.send();                          
	     }
		 function funjvload() {  
         	var acno=$('#hidmcpcashacno').val();       
         	var amount=$('#hidcpvamount').val();	   
            $('#jvdiv').load("journalVoucherGrid.jsp?amount="+amount+"&acno="+acno+"&id="+1);       
         }
		 function funPostCashload() {        
	         	var docno=$('#hidmcptrno').val();           
	            $('#postcashdiv').load("postCashGrid.jsp?docno="+docno+"&id="+1);               
	         }
		 function funPostCreditload(){
			 var docno=$('#hiddocno').val();                      
	         $('#postcreditdiv').load("postCreditGrid.jsp?docno="+docno+"&id="+1); 
		 }
		 function funjvcreate(){    
			    var jvtrno=$("#hidjvtrno").val();
			    if(jvtrno>0){   
			    	swal({
                        type: 'warning',
                        title: 'Warning',
                        text: 'Already created'           
                    });
			    	return 0;           
			    }
			    var val=0;
			    var rows = $("#jqxjvGrid").jqxGrid('getrows');     
				  for(var i=0;i<rows.length;i++){              
					 	var chk=rows[i].account;   
					 	if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){           
					 		  val=1;  
					 	 }                
				  }
				  if(val==0){      
					  swal({
		                  type: 'warning',
		                  title: 'Warning',   
		                  text: 'Cannot create JVT'                            
		              });
					  return 0;     
				  }
            	var desc="SJOB -"+$('#hidvocno').val();                     
            	var brhid=$("#hidbrhid").val();
            	var invdocno=$("#hiddocno").val();
            	var invdate=new Date();   
            	var gridarray=new Array();   
                var amount=0.0;
       		    for(var i=0 ; i < rows.length ; i++){  
       		    	gridarray.push(rows[i].account+" :: "+$('#hiddescription').val()+" :: "+ 1 +" :: "+ 1 +" :: "+rows[i].baseamt+" :: "+rows[i].baseamt+" ::"+ 2 +" :: "+rows[i].id+" :: "+""+" :: "+""+" :: ");   
       		        amount=amount + parseFloat(rows[i].debit);      
       		    }
	       		 var x = new XMLHttpRequest();
	             x.onreadystatechange = function() {
	                 if (x.readyState == 4 && x.status == 200) {
	                     var items = x.responseText.split('###');     
	                     if (parseInt(items[0]) > 0) {
	                         swal({
	                             type: 'success',
	                             title: 'Success',
	                             text: 'JVT - '+items[0]+' Successfully Created'    
	                         });
	                         $("#hidjvtrno").val(items[1]);                             
	                         funload();
	                     } else {
	                         swal({
	                             type: 'error',
	                             title: 'Error',
	                             text: 'Not Created'      
	                         });
	                     }
	                 } else {}
	             }
	             x.open("POST", "createjv.jsp?jvarray=" + encodeURIComponent(gridarray)+ "&brhid=" +brhid+ "&invdocno=" +invdocno+ "&amount=" +amount + "&docno=" + $('#hidvocno').val() + "&desc=" + encodeURIComponent(desc)+ "&invdate=" + invdate, true);         
	             x.send();          
            } 
		 function funPost(){   
			  var mcpposted = $('#hidmcpposted').val(); 
			  if(mcpposted>0){
				  swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Already Posted.'            
	              });
				  return 0;     
			  }
			  var val=0;
			  var rows=$('#jqxPostCash').jqxGrid('getrows');   
			  for(var i=0;i<rows.length;i++){              
				 	var chk=rows[i].docno;   
				 	if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){           
				 		  val=1;  
				 	 }                
			  }
			  if(val==0){      
				  swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Cannot Post'                         
	              });
				  return 0;     
			  }
			  $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
					if (r){
						  var docno=document.getElementById("hidmcpdocno").value;   
						  var trno=document.getElementById("hidmcptrno").value;
						  var x = new XMLHttpRequest();
						  		x.onreadystatechange = function() {
						  			if (x.readyState == 4 && x.status == 200) {
						  				var items = x.responseText.trim();
						  				if(parseInt(items)>0){              
						  					 $("#hidmcpposted").val(parseInt(items));       
						  					swal({
					                             type: 'success',
					                             title: 'Success',
					                             text: 'Account is Posted.'       
					                         });
						  				 }else{
						  					swal({
					                             type: 'error',
					                             title: 'Error',
					                             text: 'Account not Posted.'      
					                         });
						  				 }
						  		}
							}
							x.open("POST", "getPostingDone.jsp?docno="+docno+"&trno="+trno+"&srvdocno="+$("#hiddocno").val(), true);
							x.send();       
					} 
			  });
		  }
		 function funnipurchasecreate(){      
			  var cpudocno = $('#hidcpudocno').val(); 
			  var brhid = $('#hidbrhid').val(); 
			  if(cpudocno>0){
				  swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Already Created.'               
	              });
				  return 0;         
			  } 
			  var val=0;
			  var rows=$('#jqxPostCredit').jqxGrid('getrows');   
			  for(var i=0;i<rows.length;i++){              
				 	var chk=rows[i].vendorid;      
				 	if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){           
				 		  val=1;  
				 	 }                
			  }
			  if(val==0){      
				  swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Cannot create ni purchase'                         
	              });
				  return 0;     
			  }
			  $.messager.confirm('Confirm', 'Do you want to create Ni Purchase?', function(r){           
					if (r){
						  var docno=document.getElementById("hiddocno").value;       
						  var x = new XMLHttpRequest();
						  		x.onreadystatechange = function() {
						  			if (x.readyState == 4 && x.status == 200) {
						  				var items = x.responseText.trim();
						  				if(parseInt(items)>0){              
						  					 $("#hidcpudocno").val(parseInt(items));           
						  					swal({
					                             type: 'success',
					                             title: 'Success',           
					                             text: 'Successfully Created'             
					                         });
						  				 }else{
						  					swal({
					                             type: 'error',
					                             title: 'Error',
					                             text: 'Not Created'            
					                         });
						  				 }
						  		}
							}
							x.open("POST", "createCPU.jsp?docno="+docno+"&brhid="+brhid, true);   
							x.send();      
					} 
			  });
		  }
		 function loadSLog(){
			 var vocno=$('#hidvocno').val();     
			 var brhid=$('#hidbrhid').val();  
	         $('#slogdiv').load("sLogGrid.jsp?docno="+vocno+"&brhid="+brhid+"&id="+1);      
		 }
		 function funconfirm(){
		     var x=new XMLHttpRequest();
			 x.onreadystatechange=function(){
				 if (x.readyState==4 && x.status==200){
						var items= x.responseText;
						var itemval=items.trim();
						if(parseInt(itemval)>0){ 
								swal({
				 					type: 'success',    
				 					title: 'Success', 
				 					text: 'Successfully Confirmed'   
				 				 });
								 funload();  
						}else{
							    swal({
					 				type: 'error',    
					 				title: 'Error', 
					 				text: 'Not Confirmed'
					 			 });       
						}
				  }  
			 }  
			 x.open("GET","confirm.jsp?docno="+$('#hiddocno').val()+"&vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);                            
			 x.send();                  
       }
	   function loadSWise(){     
		   var docno=$('#hiddocno').val();        
	       $('#swdiv').load("sWiseGrid.jsp?docno="+docno+"&id="+1);     
	   }
	   function loadMWise(){     
		   var docno=$('#hiddocno').val();           
	       $('#mwdiv').load("mWiseGrid.jsp?docno="+docno+"&id="+1);     
	   }
	   function loadDWise(){     
		   var docno=$('#hiddocno').val();            
	       $('#dadiv').load("dAvlGrid.jsp?docno="+docno+"&id="+1);     
	   }
	   function loadVWise(){       
		   var docno=$('#hiddocno').val();        
	       $('#vsdiv').load("vWiseGrid.jsp?docno="+docno+"&id="+1);        
	   }
	   function loadRevenueGrid(){    
		   var docno=$("#hiddocno").val();   
		   var enqdocno=$('#hidenqdocno').val();    
		   var qotdocno=$('#hidqotdocno').val();  
	       $('#revdiv').load("revenueGrid.jsp?enqdocno="+enqdocno+"&qotdocno="+qotdocno+"&docno="+docno+"&id="+1);
	       $('#expdiv').load("expensesGrid.jsp?enqdocno="+enqdocno+"&qotdocno="+qotdocno+"&docno="+docno+"&id="+1);   
	   }
	   function funRevEdit(){
		    var cficonfirm=$("#hidcficonfirm").val(); 
		    if(cficonfirm>0){    
		    	 swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Cannot edit confirmed document'                                         
	              });
				  return 0; 
		    }   
		    $("#jqxRevenue").jqxGrid({disabled:false});   
		    var rows = $("#jqxRevenue").jqxGrid('getrows');     
			for(var i=0;i<rows.length;i++){              
				 	var chk=rows[i].srvdocno;
				 	var basetotal=rows[i].basetotal;
				 	var tobebilled=rows[i].tobebilled;
				 	var tax=rows[i].tax; 
				 	var vatper=rows[i].vatper;
				 	var vatamt=rows[i].vatamt;  
				 	var nettotal=rows[i].nettotal;            
				 	if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){ 
				 		if(typeof(tobebilled) == "undefined" || typeof(tobebilled) == "NaN" || tobebilled == ""){                  
					 		if(parseInt(tax)>0){
					 			vatper=5.0;   
					 		}else{
					 			vatper=0.0;           
					 		}
					 		tobebilled=parseFloat(basetotal);      
					 		vatamt=(parseFloat(vatper)*parseFloat(basetotal))/100;  
					 		nettotal=vatamt+parseFloat(basetotal);       
					 		$("#jqxRevenue").jqxGrid('setcellvalue', i, "tobebilled", tobebilled);        
					 		$("#jqxRevenue").jqxGrid('setcellvalue', i, "vatper", vatper); 
					 		$("#jqxRevenue").jqxGrid('setcellvalue', i, "vatamt", vatamt); 
					 		$("#jqxRevenue").jqxGrid('setcellvalue', i, "nettotal", nettotal);     
				 		}
				 	 }                
			 }    
	   }
	   function funRevSave(){
		   var cficonfirm=$("#hidcficonfirm").val(); 
		    if(cficonfirm>0){    
		    	 swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Cannot save confirmed document'                                                 
	              });
				  return 0; 
		    }
		    var gridarray=new Array(); 
		    var revnuearray=new Array();      
			var bb=4,aa=0,val=0;   
			var rows=$('#jqxRevenue').jqxGrid('getrows');   
			for(var i=0;i<rows.length;i++){            
					var chk=rows[i].srvdocno;   
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){           
						gridarray.push(0+"::"+rows[i].qty+" :: "+rows[i].sertype+" :: "+rows[i].price+" :: "+rows[i].tobebilled+" :: "+0+" :: "+rows[i].tobebilled+" :: "+rows[i].vatper+" :: "+rows[i].vatamt+" :: "+rows[i].nettotal+" :: "+0+" :: "+bb+" :: "+document.getElementById("hidvocno").value+" :: "+""+" :: "+rows[i].inacno+" :: "+aa+" :: "+rows[i].curid+" :: "+rows[i].rate+" :: ");                                          
							 revnuearray.push(rows[i].rowno+" :: "+rows[i].tobebilled+" :: "+rows[i].vatper+" :: "+rows[i].vatamt+" :: "+rows[i].nettotal+" :: "+rows[i].srvdocno+" :: "+rows[i].curid+" :: "+rows[i].rate+" :: "+rows[i].price+" :: "+rows[i].qty+" :: "+rows[i].unitid+" :: "+rows[i].total+" :: "+rows[i].basetotal+" :: "+rows[i].billing+" :: "+$('#hidqotdocno').val()+" :: "+$('#hidenqdocno').val()+" :: ");       
							 val=1;     
					}          
			} 
			if(val==0){      
				  swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Please enter data'                                   
	              });
				  return 0;     
			  }
			$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){       
				     if (r){
				    	 saveCFIData(gridarray,revnuearray);                                        
					}
			});
		}
	 function saveCFIData(gridarray,revnuearray){   
		     var docno=$("#hiddocno").val();
		     var vocno=$("#hidvocno").val();
		     var date=new Date();
		     var brhid=$("#hidbrhid").val();    
		     var x=new XMLHttpRequest();
			 x.onreadystatechange=function(){
				 if (x.readyState==4 && x.status==200){
						var items= x.responseText;   
						var itemval=items.trim();
						if(parseInt(itemval)>0){ 
								swal({
				 					type: 'success',    
				 					title: 'Success', 
				 					text:  'Successfully Saved'          
				 				 });
								 //$('#modaljobsettlement').modal('toggle');                
								 funload();   
								 loadRevenueGrid();               
						}else{
							    swal({
					 				type: 'error',    
					 				title: 'Error', 
					 				text: 'Not Saved'       
					 			 });
							    //$('#modaljobsettlement').modal('toggle');                         
						}
				  }
			 }         
			 x.open("POST","createCFI.jsp?docno="+docno+"&vocno="+vocno+"&revnuearray="+revnuearray+"&brhid="+brhid+"&gridarray="+encodeURIComponent(gridarray)+"&date="+date,true);                         
			 x.send();        
    }
	function funRevConfirm(){
		 var docno=$("#hiddocno").val();
	     var vocno=$("#hidvocno").val();
	     var brhid=$("#hidbrhid").val();    
	     var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			 if (x.readyState==4 && x.status==200){
					var items= x.responseText;   
					var itemval=items.trim();
					if(parseInt(itemval)>0){ 
							swal({
			 					type: 'success',    
			 					title: 'Success', 
			 					text:  'Successfully Confirmed'          
			 				 });
							 //$('#modaljobsettlement').modal('toggle');  
							 $("#hidcficonfirm").val(parseInt(itemval));                
							 funload();   
							 loadRevenueGrid();                 
					}else{
						    swal({
				 				type: 'error',    
				 				title: 'Error', 
				 				text: 'Not Confirmed'       
				 			 });
						    //$('#modaljobsettlement').modal('toggle');                      
					}
			  }
		 }         
		 x.open("POST","confirmCFI.jsp?docno="+docno+"&vocno="+vocno+"&brhid="+brhid,true);                         
		 x.send();         
	 }
	function funExpEdit(){  
			var cficonfirm=$("#hidjobposted").val(); 
		    if(cficonfirm>0){    
		    	 swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Cannot save posted document'                                                   
	              });
				  return 0; 
		    }   
		    $("#jqxExpense").jqxGrid({disabled:false});  
		    var rows = $("#jqxExpense").jqxGrid('getrows');     
			for(var i=0;i<rows.length;i++){              
				 	var chk=rows[i].srvdocno;
				 	var costprice=rows[i].costprice;
				 	var amount=rows[i].amount;      
				 	var tax=rows[i].tax; 
				 	var vatper=rows[i].vatper;
				 	var vatamt=rows[i].vatamt;  
				 	var nettotal=rows[i].nettotal;            
				 	if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){ 
				 		if(typeof(amount) == "undefined" || typeof(amount) == "NaN" || amount == ""){                  
					 		if(parseInt(tax)>0){
					 			vatper=5.0;   
					 		}else{
					 			vatper=0.0;           
					 		}
					 		amount=parseFloat(costprice);         
					 		vatamt=(parseFloat(vatper)*parseFloat(costprice))/100;  
					 		nettotal=vatamt+parseFloat(costprice);       
					 		$("#jqxExpense").jqxGrid('setcellvalue', i, "amount", amount);        
					 		$("#jqxExpense").jqxGrid('setcellvalue', i, "vatper", vatper);    
					 		$("#jqxExpense").jqxGrid('setcellvalue', i, "vatamt", vatamt); 
					 		$("#jqxExpense").jqxGrid('setcellvalue', i, "nettotal", nettotal);     
				 		}     
				 	 }                
			 }
			funCalcBalance();     
	}   
	   function funExpSave(){  
		   var cficonfirm=$("#hidjobposted").val(); 
		    if(cficonfirm>0){    
		    	 swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Cannot save posted document'                                                  
	              });
				  return 0; 
		    }
		    var gridarray=new Array();     
			var val=0,val2=0;   
			var rows=$('#jqxExpense').jqxGrid('getrows');   
			for(var i=0;i<rows.length;i++){            
					var chk=rows[i].srvdocno;  
					var typechk=rows[i].type;
					var acnochk=rows[i].acno;   
					if((typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "") && (typeof(typechk) != "undefined" && typeof(typechk) != "NaN" && typechk != "")){           
						gridarray.push(rows[i].costprice+" :: "+rows[i].srvdocno+" :: "+rows[i].amount+" :: "+rows[i].invno+" :: "+rows[i].invdate+" :: "+rows[i].billing+" :: "+rows[i].acno+" :: "+rows[i].type+" :: "+rows[i].remarks+" :: "+rows[i].vatper+" :: "+rows[i].vatamt+" :: "+rows[i].nettotal+" :: "+rows[i].rowno+" :: ");                                          
						val=1;
						if(typechk=="CREDIT" || typechk=="CASH-VAT" || typechk=="HR"){	
							if(typeof(acnochk) == "undefined" || typeof(acnochk) == "NaN" || acnochk == "" || acnochk == "0"){    
								val2=1;    
							}           
						}
					}          
			} 
			//console.log(val+"==="+val2);            
			if(val==0){      
				  swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Service Type and Type are mandatory!!!'                                   
	              });
				  return 0;     
			  }
			if(val2==1){           
				  swal({
	                  type: 'warning',
	                  title: 'Warning',   
	                  text: 'Account is mandatory!!!'                                                  
	              });
				  return 0;     
			  }
			var expcash=$("#cmbexpcash").val();  
			console.log("expcash==="+expcash);
			if(expcash=="" || expcash==null){      
				  swal({
	                type: 'warning',
	                title: 'Warning',   
	                text: 'Please select cash account'                                                     
	            });
				  return 0;     
			  }
			$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){            
				     if (r){
				    	 saveExpense(gridarray,expcash);                                        
					}
			});
		}
	  function saveExpense(gridarray,expcash){
		     var docno=$("#hiddocno").val();
		     var vocno=$("#hidvocno").val();
		     var brhid=$("#hidbrhid").val();    
		     var x=new XMLHttpRequest();
			 x.onreadystatechange=function(){
				 if (x.readyState==4 && x.status==200){
						var items= x.responseText;   
						var itemval=items.trim();
						if(parseInt(itemval)>0){ 
								swal({
				 					type: 'success',    
				 					title: 'Success', 
				 					text:  'Successfully Saved'          
				 				 });
								 //$('#modaljobsettlement').modal('toggle');                  
								 funload();   
								 loadRevenueGrid();               
						}else{
							    swal({
					 				type: 'error',    
					 				title: 'Error', 
					 				text: 'Not Saved'       
					 			 });
							    //$('#modaljobsettlement').modal('toggle');                         
						}
				  }
			 }         
			 x.open("POST","saveExpenses.jsp?docno="+docno+"&vocno="+vocno+"&expcash="+expcash+"&brhid="+brhid+"&exparray="+encodeURIComponent(gridarray),true);                         
			 x.send();        
    } 
    
  /*   function saveExpense(gridarray,expcash){
	     var docno=$("#hiddocno").val();
	     var vocno=$("#hidvocno").val();
	     var brhid=$("#hidbrhid").val();
	     var jsondata = {
	    		 docno: docno,
	    		 vocno: vocno,
	    		 expcash : expcash,
	    		 brhid : brhid ,
	    		 exparray: gridarray 
	         }
	     alert(jsondata);
	     $.ajax({
	            type: "POST",
	            url: "saveExpenses.action?docno="+docno+"&vocno="+vocno+"&expcash="+expcash+"&brhid="+brhid+"&exparray="+encodeURIComponent(gridarray),
	            //url: "/saveexpense",
	            // data: JSON.stringify(jsondata),
	            // data: '{ "docno" :"'+docno+'","vocno" : "'+vocno+'", "expcash" : "'+ expcash+'", "brhid" : "'+brhid+'", "exparray":"'+ gridarray +'" } '  ,
	            contentType: "application/json; charset=utf-8", // this
	            dataType: "json", // and this
	            success: function (msg) {
	            	if(parseInt(msg)>0){ 
	            	swal({
	 					type: 'success',    
	 					title: 'Success', 
	 					text:  'Successfully Saved'          
	 				 });
					 //$('#modaljobsettlement').modal('toggle');                  
					 funload();   
					 loadRevenueGrid();
	            	}
	            else{
	            	  swal({
			 				type: 'error',    
			 				title: 'Error', 
			 				text: 'Not Saved'       
			 			 });
	            }
	            },
	            error: function (errormessage) {
	                //do something else
	            	 swal({
			 				type: 'error',    
			 				title: 'Error', 
			 				text: 'Not Saved'       
			 			 });
	            }
	        });
	            
} */
	function funExpPosting(){    
		var cficonfirm=$("#hidjobposted").val();     
	    if(cficonfirm>0){    
	    	 swal({
                  type: 'warning',
                  title: 'Warning',     
                  text: 'Already posted'                                                         
              });
			  return 0; 
	    }
	    var val=0,val2=0;   
		var rows=$('#jqxExpense').jqxGrid('getrows');   
		for(var i=0;i<rows.length;i++){            
				var chk=rows[i].srvdocno;  
				var typechk=rows[i].type;
				var acnochk=rows[i].acno;   
				if((typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "") && (typeof(typechk) != "undefined" && typeof(typechk) != "NaN" && typechk != "")){           
					val=1;    
					if(typechk=="CREDIT" || typechk=="CASH-VAT" || typechk=="HR"){	
						if(typeof(acnochk) == "undefined" || typeof(acnochk) == "NaN" || acnochk == "" || acnochk == "0"){
							val2=1;    
						}              
					}
				}          
		}
		if(val==0){      
			  swal({
                  type: 'warning',
                  title: 'Warning',   
                  text: 'Please save before posting!!!'                                                
              });
			  return 0;     
		  }
		if(val2==1){                 
			  swal({
                type: 'warning',
                title: 'Warning',   
                text: 'Account is mandatory!!!'                                                  
            });
			  return 0;     
		  }
		$.messager.confirm('Confirm', 'Do you want to post?', function(r){            
		     if (r){
		    	 saveExpPost();                                        
			}
	     });    
	} 
	function saveExpPost(){
		     var docno=$("#hiddocno").val();
		     var vocno=$("#hidvocno").val();
		     var brhid=$("#hidbrhid").val(); 
		     var expcash=$("#cmbexpcash").val(); 
		     var jvdesc=$("#hidjvdesc").val(); 
		     var jobvndchk=$("#hidjobvndchk").val();       
		     var x=new XMLHttpRequest();
			 x.onreadystatechange=function(){
				 if (x.readyState==4 && x.status==200){
						var items= x.responseText;   
						var itemval=items.trim();
						if(parseInt(itemval)>0){ 
								swal({
				 					type: 'success',    
				 					title: 'Success', 
				 					text:  'Successfully Posted'          
				 				 });
								 $("#hidjobposted").val(parseInt(itemval));   
								 //$('#modaljobsettlement').modal('toggle');                     
								 funload();   
								 loadRevenueGrid();               
						}else{
							    swal({
					 				type: 'error',    
					 				title: 'Error', 
					 				text: 'Not Posted'         
					 			 });
							    //$('#modaljobsettlement').modal('toggle');                         
						}
				  }
			 }         
			 x.open("POST","jobPosting.jsp?docno="+docno+"&jobvndchk="+jobvndchk+"&vocno="+vocno+"&brhid="+brhid+"&expcash="+expcash+"&jvdesc="+encodeURIComponent(jvdesc),true);                                             
			 x.send();   
	}     
	function funshipmentdetails(){
		 var mawb=$("#txtmawb").val();
	     var mbl=$("#txtmbl").val();
	     var hawb=$("#txthawb").val();   
		 var hbl=$("#txthbl").val();   
		 var shipper=$("#txtshipper").val();   
		 var consignee=$("#txtconsignee").val();
		 var carrier=$("#txtcarrier").val(); 
		 var flightno=$("#txtflightno").val();   
		 var vessel=$("#txtvessel").val(); 
		 var etd=$("#txtetd").jqxDateTimeInput('val');   
		 var eta=$("#txteta").jqxDateTimeInput('val');      
		 var transittime=$("#txttransittime").val();   
		 var boe=$("#txtboe").val();     
		 var containerno=$("#txtcontainerno").val();   
		 var truckno=$("#txttruckno").val();   
		 if(mawb==''){              
		    	 swal({
	                  type: 'warning',
	                  title: 'Warning',     
	                  text: 'Please enter MAWB'                                                                          
	              });
				  return 0;     
		  }      
		$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){                
		     if (r){
		    	 saveShipmentDetails(mawb,mbl,hawb,hbl,shipper,consignee,carrier,flightno,vessel,etd,eta,transittime,boe,containerno,truckno);                                        
			}
	     });  
	}
	function saveShipmentDetails(mawb,mbl,hawb,hbl,shipper,consignee,carrier,flightno,vessel,etd,eta,transittime,boe,containerno,truckno){   
	     var docno=$("#hiddocno").val();           
	     var vocno=$("#hidvocno").val();
	     var brhid=$("#hidbrhid").val(); 
	     var cfidocno=$("#hidcfidocno").val(); 
	     var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
			 if (x.readyState==4 && x.status==200){
					var items= x.responseText;   
					var itemval=items.trim();
					if(parseInt(itemval)>0){ 
							swal({
			 					type: 'success',    
			 					title: 'Success', 
			 					text:  'Successfully Saved'          
			 				 });
							 $('#modalshipmentdetail').modal('toggle');                     
					}else{
						    swal({
				 				type: 'error',    
				 				title: 'Error', 
				 				text: 'Not Saved'         
				 			 });
						     $('#modalshipmentdetail').modal('toggle');                      
					}
			  }
		 }         
		 x.open("POST","saveShipmentDetails.jsp?docno="+docno+"&cfidocno="+cfidocno+"&vocno="+vocno+"&brhid="+brhid+"&mawb="+encodeURIComponent(mawb)+"&mbl="+encodeURIComponent(mbl)+"&hawb="+encodeURIComponent(hawb)+"&hbl="+encodeURIComponent(hbl)+"&shipper="+encodeURIComponent(shipper)+"&consignee="+encodeURIComponent(consignee)+"&carrier="+encodeURIComponent(carrier)+"&flightno="+encodeURIComponent(flightno)+"&vessel="+encodeURIComponent(vessel)+"&etd="+encodeURIComponent(etd)+"&eta="+encodeURIComponent(eta)+"&transittime="+encodeURIComponent(transittime)+"&boe="+encodeURIComponent(boe)+"&containerno="+encodeURIComponent(containerno)+"&truckno="+encodeURIComponent(truckno),true);                                        
		 x.send();      
   } 
	function getETA(){      
	     var etd=$("#txtetd").val();           
	     var transit=$("#txttransittime").val();
	     var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
			 if (x.readyState==4 && x.status==200){
					var items= x.responseText;   
					var itemval=items.trim();
					$("#txteta").val(itemval);                    
			  }
		 }         
		 x.open("GET","getETA.jsp?etd="+etd+"&transit="+transit,true);                                                 
		 x.send();      
    }	
	function funGetCountData(){
	    	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim().split("::");
					$('.badge-entered').text(items[0]);
					$('.badge-jobsettled').text(items[1]);
					$('.badge-completed').text(items[2]);  
					$('.badge-advancepaid').text(items[3]);
					$('.badge-booked').text(items[4]);       
					$('.badge-delivered').text(items[5]);                   
				}      
				else
				{
				}  
			}
			x.open("GET","getCountData.jsp",true);
			x.send();
	    }
	function funCalcBalance(){      
		var expense=0.00,balance=0.00,advance=0.00;   
		var rows=$('#jqxExpense').jqxGrid('getrows');   
		for(var i=0;i<rows.length;i++){            
				var chk=rows[i].srvdocno;  
				var typechk=rows[i].type;
				var amount=rows[i].amount;      
				if((typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "") && (typeof(typechk) != "undefined" && typeof(typechk) != "NaN" && typechk != "")){           
					if(typechk=="CASH" || typechk=="CASH-VAT"){	
						if(typeof(amount) != "undefined" && typeof(amount) != "NaN" && amount != "" && amount != "0.00"){   
							expense=expense+parseFloat(amount);         
						}              
					}
				}          
		}
		console.log(expense);
		funRoundAmt(expense,"expexpense");
		advance=$("#expadvance").val();   
		console.log(expense+"=="+advance);  
		var balance=advance-expense;    
		console.log(balance);
		funRoundAmt(balance,"expbalance");   
	}
	
	function getShipmentDetails(){       
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				 var items=x.responseText.trim().split("::");
				 if(items[0]!=""){   
					 $("#txtmawb").val(items[0]);
					 $("#txtmbl").val(items[1]);
					 $("#txthawb").val(items[2]);   
					 $("#txthbl").val(items[3]);   
					 $("#txtshipper").val(items[4]);   
					 $("#txtconsignee").val(items[5]);
					 $("#txtcarrier").val(items[6]); 
					 $("#txtflightno").val(items[7]);   
	 				 $("#txtvessel").val(items[8]); 
	 				 $("#txtetd").val(items[9]);            
	 				 $("#txteta").val(items[10]);   
	 				 $("#txttransittime").val(items[11]);       
	 				 $("#txtboe").val(items[12]);   
	 				 $("#txtcontainerno").val(items[13]);              
	 				 $("#txttruckno").val(items[14]);    
				 }
			}      
			else
			{
			}  
		}
		x.open("GET","getShipmentDetails.jsp?docno="+$("#hidcfidocno").val(),true);            
		x.send();
    }
	 function funPrintCS(){
	      var trno=$('#hiddocno').val();   
	      if(trno==""){      
			  swal({
                  type: 'warning',
                  title: 'Warning',   
                  text: 'Please select a document!!!'                                                   
              });
			  return 0;     
		  }
		  var url=document.URL;    
	      var reurl=url.split("operation.jsp");                                          
	      var win= window.open(reurl[0]+"printoperation?trno="+trno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();             
		}
	 function jobchkchange(){
		if(document.getElementById("jobvndchk").checked){          
			  $('#jqxJobVendor').attr('disabled', false);
			  $('#jobvndchkval').val(1);
		}else{
			  $('#jqxJobVendor').attr('disabled', true); 
			  $('#jobvndchkval').val(0);   
		}   
	 }
	 function funJobCardPrint(){
		 var trno=$('#hiddocno').val();   
	      if(trno==""){      
			  swal({
                 type: 'warning',
                 title: 'Warning',   
                 text: 'Please select a document!!!'                                                   
             });
			  return 0;     
		  }
		  var url=document.URL;    
	      var reurl=url.split("operation.jsp");                                          
	      var win= window.open(reurl[0]+"printjobcard?trno="+trno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus(); 
	 }
    function funTruckCNPrint(){                       
    	 var trno=$('#hiddocno').val();   
	      if(trno==""){      
			  swal({
                 type: 'warning',
                 title: 'Warning',   
                 text: 'Please select a document!!!'                                                         
             });
			  return 0;     
		  }
		  var url=document.URL;    
	      var reurl=url.split("operation.jsp");                                          
	      var win= window.open(reurl[0]+"printtruckcn?trno="+trno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus(); 
	 }
  </script>  
<div id="productSearchwindow">    
	   <div></div>
	</div>	
<div id="McpGridWindow">
	<div></div><div></div>
</div> 
<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>  
	 
<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 

<div id="vendorinfowindow">
	<div></div><div></div>
</div>  
<div id="unitsearchwindow">
   <div ></div>
</div>
<div id="currencysearchwindow">
   <div ></div>
</div>
<div id="sertypesearchwindow">
   <div ></div>
</div>	
</div>        
</body>
</html>
