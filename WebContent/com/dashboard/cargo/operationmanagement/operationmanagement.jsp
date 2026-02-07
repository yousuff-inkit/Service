<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Operation Management</title>                 
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
<body>                                            
  <div class="container-fluid">    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
         <div class="primarypanel custompanel" style="margin-left:5px;">  
             <div id="border1">
                <button type="button" class="btn btn-default btnStyle" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
	          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
                <button type="button" class="btn btn-default btnStyle" id="btnjobsettlement" data-toggle="tooltip" title="Job Settlement" data-placement="bottom"><i class="fa fa-openid" aria-hidden="true"></i></button>
                <button type="button" class="btn btn-default btnStyle" id="btnconfirm" data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle" aria-hidden="true"></i></button>
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
					     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-11" style="text-align:center;">&nbsp;</div>
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
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-5"></div>   
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
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>         
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){        
    	 $('[data-toggle="tooltip"]').tooltip();      
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     funGetCountData();   
    	 $("#hidevendor").hide();      
		 $("#hidestaff").hide(); 
		 $("#hideuser").hide();   
		
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
              loadRevenueGrid();
              funRoundAmt(advance,"expadvance"); 
              funRoundAmt(0,"expexpense");
              funRoundAmt(0,"expbalance");              
              $('#modaljobsettlement').modal('toggle');  
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
	      var reurl=url.split("operationmanagement.jsp");                                            
	      var win= window.open(reurl[0]+"printoperationmanagement?trno="+trno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();             
		}
  </script>  
</body>
</html>
