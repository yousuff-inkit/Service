<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Property Management</title>         
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
  </style>
</head>       
<body onload="getPayType();getCardTypes();getYear();">  
<form autocomplete="off">                         
  <div class="container-fluid">    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
         <div class="primarypanel custompanel" style="margin-left:15px;padding-top:17px;">     
		          <select class="form-control" name="cmbyear" id="cmbyear"></select>
		           <span class="help-block"></span>
		           <input type="hidden" id="hidcmbyear" name="hidcmbyear"/>       
	  	 </div> 
	  	 <div class="primarypanel custompanel" style="margin-left:5px;padding-top:17px;">          
		          <select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
			       <option value="01">January</option><option value="02">February</option><option value="03">March</option>
			       <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
			       <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
			       <option value="12">December</option></select>
			       <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/>    
	  	 </div> 
         <div class="primarypanel custompanel" style="margin-left:5px;">  
             <div id="border1">
                <button type="button" class="btn btn-default btnStyle" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
	          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
            </div>                               
	  	 </div> 
        <div class="actionpanel custompanel" style="margin-left:5px;">                              
	  	    <div id="border1">
	  			<button type="button" class="btn btn-default btnStyle" id="btnsplitpropty" data-toggle="tooltip" title="Split Property" data-placement="bottom"><i class="fa fa-columns " aria-hidden="true"></i></button>
	        	<button type="button" class="btn btn-default btnStyle" id="btnrental" data-toggle="tooltip" title="Rental" data-placement="bottom"><i class="fa fa-key" aria-hidden="true"></i></button>   
	        	<button type="button" class="btn btn-default btnStyle" id="btnreceipt" data-toggle="tooltip" title="Receipt" data-placement="bottom"><i class="fa fa-file-text-o" aria-hidden="true"></i></button>
	        	<button type="button" class="btn btn-default btnStyle" id="btnrtlcancel" data-toggle="tooltip" title="Cancel Rental" data-placement="bottom"><i class="fa fa-times-circle" aria-hidden="true"></i></button>
	        	<button type="button" class="btn btn-default btnStyle" id="btnrtlextent" data-toggle="tooltip" title="Extent Rental" data-placement="bottom"><i class="fa fa-expand" aria-hidden="true"></i></button>
            </div>
        </div>                       
        <div class="otherpanel custompanel"  style="margin-left:5px;"> 
           <div id="border1">         
	           <button type="button" class="btn btn-default btnStyle" id="btnaccountstmt" onclick="funAccountStatement();" data-toggle="tooltip" title="Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
	           <button type="button" class="btn btn-default btnStyle" id="btnrtlhistory" data-toggle="tooltip" title="Rental History" data-placement="bottom"><i class="fa fa-history" aria-hidden="true"></i></button>      
	           <button type="button" class="btn btn-default btnStyle" id="btncontract" onclick="funcontracts();" data-toggle="tooltip" title="Contract" data-placement="bottom"><i class="fa fa-handshake-o" aria-hidden="true"></i></button>
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
        <div id="ppdiv" class="borderStyle"><jsp:include page="propertyGrid.jsp"></jsp:include></div>               
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
       
    <!-- splitpropty modal-->        
    <div id="modalsplitpropty" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-md">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Split Property</h4> 
             <p id="lblname1" style="text-align:center;"></p>       
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap">   
            	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                       
		             <div id="splitdiv"><jsp:include page="splitGrid.jsp"></jsp:include></div>                  
		        </div>                          
              </div>    
            	</div>   
            </div> 
            <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funsavesplitdata();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div> 
          </div>  
        </div>  
      </div>                
    <!-- Rental modal-->            
    <div id="modalrental" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Rental</h4>           
             <p id="lblname2" style="text-align:center;"></p>             
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap"> 
	             <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
	                <div class="form-group">
						<label>Client</label>
						<div id="client" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearch.jsp"></jsp:include></div>  
					    <input type="hidden" name="hidcldocno" id="hidcldocno">        
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
	                <div class="form-group">
						<label>From Date</label>
						<div id="fromdate" onchange="funtodate();"></div>  
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>Type</label>
						<select id="cmbtypes" class="form-control input-sm"  onchange="funtodate();"><option value="">--Select--</option><option value="D">Days</option><option value="M">Months</option></select>    
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>No of Days</label>
						<input id="noofdays" class="form-control input-sm" onchange="funtodate();">    
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>Todate</label>     
						<div id="todate"></div>    
					</div>       
				 </div>          
              </div>       
              <div class="row rowgap"> 
                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>Total</label>        
						<input id="txttotal" class="form-control input-sm text-right" onblur="funRoundAmt(value,id);">                
					</div>       
				 </div>  
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">       
	                <div class="form-group">
						<label>Remarks</label>               
						<input id="txtremarks" class="form-control input-sm">        
					</div>       
				 </div>  
              </div>           
            	</div>   
            </div>  
            <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnupdaterental" title="Update" data-placement="bottom" onclick="funrentalsave();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
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
             <p id="lblname3" style="text-align:center;"></p>                 
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
    <!-- Rental History modal-->                            
    <div id="modalrentalhistory" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>     
            <h4 class="modal-title" style="text-align:center">Rental History</h4>           
             <p id="lblname5" style="text-align:center;"></p>             
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap">   
            	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                          
		             <div id="rntlhisdiv"><jsp:include page="rentalHistoryGrid.jsp"></jsp:include></div>                    
		        </div>                          
              </div>      
            	</div>   
            </div>
            <div class="modal-footer"> 
               <div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnrntlhistoryexcel" title="Excel" data-placement="bottom" onclick="funrntlhistoryexcel();"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>  
          </div>  
        </div>  
      </div> 
    <!-- Cancel Rental modal-->                             
    <div id="modalcancelrental" class="modal fade" role="dialog">               
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>     
            <h4 class="modal-title" style="text-align:center">Cancel Rental</h4>               
             <p id="lblname6" style="text-align:center;"></p>                 
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap">   
            	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                          
		             <div id="rntldiv"><jsp:include page="rentalGrid.jsp"></jsp:include></div>                            
		        </div>                          
              </div>      
            	<!-- <div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnrntlhistoryexcel" title="Excel" data-placement="bottom" onclick="funrntlhistoryexcel();"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
					</div>    
				</div>  -->                      
            	</div>   
            </div>  
          </div>  
        </div>  
      </div>
   <!-- Extent Rental modal-->                                  
    <div id="modalextentrental" class="modal fade" role="dialog">               
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>     
            <h4 class="modal-title" style="text-align:center">Extent Rental</h4>                  
             <p id="lblname7" style="text-align:center;"></p>                    
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap">             
            	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                          
		             <div id="rntlextentdiv"><jsp:include page="rentalExtentGrid.jsp"></jsp:include></div>                            
		        </div> 
		     </div>  
		     <div class="row rowgap">    
	             <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
	                <div class="form-group">
						<label>Extent Date</label>
						<div id="extdate" onchange="validateExtentDate();"></div>           
					</div>       
				 </div> 
			    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">           
	                <div class="form-group">
						<label>Value</label>           
						<input type="text" id="txtvalue" class="form-control input-sm text-right"  onblur="funRoundAmt(value,id);">       
						<input type="hidden" id="hidrntldocno" name="hidrntldocno" class="form-control input-sm text-right">       
					</div>       
				 </div>  
              </div>
             </div>   
            </div>
           <div class="modal-footer">     
                <div class="row rowgap" >
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnrntlextent" title="Save" data-placement="bottom" onclick="funrentalextent();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>         
				</div>                   
          </div>  
          </div>   
        </div>  
      </div>  
 </div> 
  <input type="hidden" name="hiddatechk" id="hiddatechk"> 
  <input type="hidden" name="hidlblname" id="hidlblname">     
  <input type="hidden" name="hidcomments" id="hidcomments">        
  <input type="hidden" name="hiddocno" id="hiddocno"> 
  <input type="hidden" name="hidsrno" id="hidsrno">  
  <input type="hidden" name="hidvocno" id="hidvocno">    
  <input type="hidden" name="hidbrhid" id="hidbrhid"> 
  <input type="hidden" name="splname" id="splname"> 
  <input type="hidden" name="splremarks" id="splremarks">       
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>         
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){        
    	 $('[data-toggle="tooltip"]').tooltip();      
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    	 $("#fromdate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});
    	 $("#todate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy",value:null});
    	 $("#rcptdate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});
    	 $("#jqxReferenceDate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});
    	 $("#extdate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"});
    	 //$("#vtime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
         $("#todate").jqxDateTimeInput("disabled",true); 
         setDefaultMonth();
         $("#cmbyear").select2({
			    /* placeholder: "Select Cost Type",    */              
			    allowClear: true,
			    width: '100%'        
			});
         $("#cmbmonth").select2({
			    /* placeholder: "Select Cost Type",    */              
			    allowClear: true,
			    width: '100%'        
			});
         $('#btnsplitpropty').click(function() {          
               	    var docno = $('#hiddocno').val();
                    if (docno == "") {
                       swal({
                           type: 'warning',
                           title: 'Warning',
                           text: 'Please select a document'   
                       });
                       return false;       
                   }  
                    $('#splitdiv').jqxGrid('clear');   
                    $('#splitdiv').load("splitGrid.jsp?docno="+$('#hiddocno').val()+"&id="+1);  
                    document.getElementById("lblname1").innerHTML=$("#hidlblname").val();    
                    $('#modalsplitpropty').modal('toggle');           
        });
         $('#btnrental').click(function() {            
        	    var docno = $('#hiddocno').val();
                if (docno == "") {
                swal({
                    type: 'warning',
                    title: 'Warning',
                    text: 'Please select a document'   
                });
                return false;
               }  
             $("#hiddatechk").val("0");
             $('#txtremarks').val("");      
			 $('#fromdate').val(new Date());   
			 $('#todate').jqxDateTimeInput('setDate',null);
			 $('#cmbtypes').val("");               
			 $('#txttotal').val("");
			 $('#hidcldocno').val("");  
			 $('#noofdays').val("");         
			 $('#jqxClient').val("");          
             document.getElementById("lblname2").innerHTML=$("#hidlblname").val();       
             $('#modalrental').modal('toggle');       
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
            document.getElementById("lblname3").innerHTML=$("#hidlblname").val();       
            $('#modalreceipt').modal('toggle');       
         });
        $('#btnsubmit').click(function(){
        	$("#overlay, #PleaseWait").show();
        	funinsertdays();       
            $('.textpanel p').text("");
            $('#hiddocno').val('');    
            $('#hidbrhid').val('');  
            $('#hidvocno').val('');
            $('#hidlblname').val(''); 
            $('#hidsrno').val(''); 
            $("#hiddatechk").val("0");  
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
        $('#btnrtlhistory').click(function(){    
	        var docno=$('#hiddocno').val();
	        var srno=$('#hidsrno').val();
	    	if(docno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	    	$('#jqxrntlHistoryGrid').jqxGrid('clear');   
	    	$('#rntlhisdiv').load("rentalHistoryGrid.jsp?docno="+docno+"&srno="+srno+"&id="+1);         
	    	document.getElementById("lblname5").innerHTML=$("#hidlblname").val();          
	      	$('#modalrentalhistory').modal('toggle');          
        }); 
        $('#btnrtlcancel').click(function(){    
	        var docno=$('#hiddocno').val();
	        var srno=$('#hidsrno').val();
	    	if(docno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	    	$('#jqxRentalGrid').jqxGrid('clear');   
	    	$('#rntldiv').load("rentalGrid.jsp?docno="+docno+"&srno="+srno+"&id="+1);            
	    	document.getElementById("lblname6").innerHTML=$("#hidlblname").val();          
	      	$('#modalcancelrental').modal('toggle');          
        }); 
        $('#btnrtlextent').click(function(){    
	        var docno=$('#hiddocno').val();
	        var srno=$('#hidsrno').val();
	    	if(docno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	    	$("#hiddatechk").val("0");   
	    	$("#txtvalue").val("");   
	    	$("#extdate").val(new Date());     
	    	validateExtentDate();        
	    	$("#hidrntldocno").val("");         
	    	$('#jqxRentalExtentGrid').jqxGrid('clear');            
	    	$('#rntlextentdiv').load("rentalExtentGrid.jsp?docno="+docno+"&srno="+srno+"&id="+1);            
	    	document.getElementById("lblname7").innerHTML=$("#hidlblname").val();          
	      	$('#modalextentrental').modal('toggle');             
        }); 
        $('#btnaccountstmt').click(function(){       
	        var docno=$('#hiddocno').val();
	        var srno=$('#hidsrno').val();
	    	if(docno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	    	getstmtprint(docno,srno);               
        }); 
        $('#btnexcel').click(function(){            
        	 $("#ppdiv").excelexportjs({
 				containerid: "ppdiv",   
 				datatype: 'json',
 				dataset: null,
 				gridId: "pagrid",
 				columns: getColumns("pagrid") ,   
 				worksheetName:"Property Management"  
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
        	var gridrows=$('#pagrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');  
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{
        		$('#pagrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
   function funRoundAmt(value,id){
	  var res=parseFloat(value).toFixed("2");                    
	  var res1=(res=='NaN'?"0":res);
	  document.getElementById(id).value=res1;  
	 }
   function setDefaultMonth() {
	   var d = new Date(new Date());
	   var n = d.getMonth()+1;
	   n="0"+n;
	   if(n.length==3){
	   n=n.slice(1);
	   }
	   document.getElementById("cmbmonth").value = n;
	 }
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(","); 
					var optionsyear;
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if($('#hidcmbyear').val()){
						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
					  }
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){   
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	//var filtercondition = 'contains';
	    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
	
	    	filtergroup.addfilter(filter_or_operator, filter1);
	    	//filtergroup.addfilter(filter_or_operator, filter2);
	    	// add the filters.
	    	$("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
	    	// apply the filters.
	    	$("#pagrid").jqxGrid('applyfilters');
    	
 	}
   
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var docno=$('#hiddocno').val();
    	var srno=$('#hidsrno').val();
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&docno="+docno+"&srno="+srno,true);  
		x.send();
    }
    function getComments(){
    	var docno=$('#hiddocno').val();
    	var srno=$('#hidsrno').val();
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
		x.open("GET","getComments.jsp?docno="+docno+"&srno="+srno,true);         
		x.send();      
    }
    
   function funload(){    
	   var year=$("#cmbyear").val();
	   var month=$("#cmbmonth").val();      
       $('#ppdiv').load("propertyGrid.jsp?year="+year+"&month="+month+"&id="+1);                                         
   }
    function funsavesplitdata(){ 
    	$.messager.confirm('Message', 'Do you want to split property?', function(r){            
	     	if(r==false)
	     	  {
	     		return false;   
	     	  }  
	     	else {
	     		$("#overlay, #PleaseWait").show();
	     		savesplitdata();               
	     	}  
        });        
    }  
	function savesplitdata(){              
	          var x=new XMLHttpRequest();       
	          var gridarray=new Array();
	          var rows=$('#jqxsplitGrid').jqxGrid('getrows');
	          var val=0;
	          var docno=$('#hiddocno').val();  
	          var vocno=$('#hidvocno').val();  
	          var brhid=$('#hidbrhid').val();     
	      	  for(var i=0;i<rows.length;i++){
	                var chk=$('#jqxsplitGrid').jqxGrid('getcellvalue',i,'name');     
	      		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		      		  	
	      		    	$('#splname').val(rows[i].name);
	      				if (($(splname).val()).includes('$')) { $(splname).val($(splname).val().replace(/$/g, ''));};if (($(splname).val()).includes('%')) { $(splname).val($(splname).val().replace(/%/g, ''));};
	      		    	if (($(splname).val()).includes('!')) { $(splname).val($(splname).val().replace(/!/g, ''));};if (($(splname).val()).includes('@')) { $(splname).val($(splname).val().replace(/@/g, ''));};
	      		    	if (($(splname).val()).includes('#')) { $(splname).val($(splname).val().replace(/#/g, ''));};if (($(splname).val()).includes('&')) { $(splname).val($(splname).val().replace(/&/g, ''));};
	      		    	if (($(splname).val()).includes('^')) { $(splname).val($(splname).val().replace(/^/g, ''));};if (($(splname).val()).includes('`')) { $(splname).val($(splname).val().replace(/`/g, ''));};
	      		    	if (($(splname).val()).includes('~')) { $(splname).val($(splname).val().replace(/~/g, ''));};if ($(splname).val().indexOf('\'')  >= 0 ) { $(splname).val($(splname).val().replace(/'/g, ''));};
	      		    	if (($(splname).val()).includes(',')) { $(splname).val($(splname).val().replace(/,/g, ''));}
	      		    	
	      		    	$('#splremarks').val(rows[i].remarks);       
	      				if (($(splremarks).val()).includes('$')) { $(splremarks).val($(splremarks).val().replace(/$/g, ''));};if (($(splremarks).val()).includes('%')) { $(splremarks).val($(splremarks).val().replace(/%/g, ''));};
	      		    	if (($(splremarks).val()).includes('!')) { $(splremarks).val($(splremarks).val().replace(/!/g, ''));};if (($(splremarks).val()).includes('@')) { $(splremarks).val($(splremarks).val().replace(/@/g, ''));};
	      		    	if (($(splremarks).val()).includes('#')) { $(splremarks).val($(splremarks).val().replace(/#/g, ''));};if (($(splremarks).val()).includes('&')) { $(splremarks).val($(splremarks).val().replace(/&/g, ''));};
	      		    	if (($(splremarks).val()).includes('^')) { $(splremarks).val($(splremarks).val().replace(/^/g, ''));};if (($(splremarks).val()).includes('`')) { $(splremarks).val($(splremarks).val().replace(/`/g, ''));};
	      		    	if (($(splremarks).val()).includes('~')) { $(splremarks).val($(splremarks).val().replace(/~/g, ''));};if ($(splremarks).val().indexOf('\'')  >= 0 ) { $(splremarks).val($(splremarks).val().replace(/'/g, ''));};
	      		    	if (($(splremarks).val()).includes(',')) { $(splremarks).val($(splremarks).val().replace(/,/g, ''));}
		      		    
	      		    	gridarray.push($('#splname').val()+"::"+$('#splremarks').val()+"::"+rows[i].rowno+"::"+rows[i].srno);          
		      		    $('#splname').val("");
		      		    $('#splremarks').val("");             
		      		    val=1;      
	               }         
	      	  }
	      	  if(val==0){                     
	      		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please enter data...!'                                                  
				});   
	      		$("#overlay, #PleaseWait").hide();    
	      		return false;
	      	  }
		      x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){     
		      		var items=x.responseText.trim();          
		      		if(parseInt(items)>0){  
						swal({   
								type: 'success',
								title: 'Message',
								text: 'Successfully Saved'                    
							});    
						 $("#overlay, #PleaseWait").hide();
						 funinsertdays();     
						 $('#modalsplitpropty').modal('toggle');     
						}else{ 
							swal({
								type: 'error',
								title: 'Error',    
								text: 'Not Saved'                                             
							}); 
						 $("#overlay, #PleaseWait").hide();
						 $('#modalsplitpropty').modal('toggle'); 
						} 
		      	 }
		      }     
		      x.open("GET","saveSplitData.jsp?docno="+docno+'&gridarray='+gridarray+'&vocno='+vocno+'&brhid='+brhid,true);                                                                                  
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
		 function funrentalsave(){       
			    var remarks=$('#txtremarks').val();      
			    var fromdate=$('#fromdate').jqxDateTimeInput('val');   
			    var todate=$('#todate').jqxDateTimeInput('val');
				var types=$('#cmbtypes').val();               
				var total=$('#txttotal').val();
				var cldocno=$('#hidcldocno').val();  
				var noofdays=$('#noofdays').val(); 
				var docno=$('#hiddocno').val();   
				var datechk=$("#hiddatechk").val(); 
				if(docno==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select a document '
					});
					 return 0;
				 } 
				if(datechk>0){     
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Already rented '        
					});
					 return 0;
				 } 
				if(cldocno==""){       
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please enter client '          
					});
					 return 0;
				 } 
				if(types==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select type '       
					});
					 return 0;
				 }
				if(noofdays==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please enter no of days '                 
					});                    
					 return 0;
				 }
				if(total==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please enter total '       
					});
					 return 0;
				 } 
			   $.messager.confirm('Message', 'Do you want to create rental?', function(r){       
					     	if(r==false)   
					     	  {
					     		return false; 
					     	  }  
					     	else {
					     		$("#overlay, #PleaseWait").show();    
					     		saveRentalData(cldocno,fromdate,todate,noofdays,types,total,remarks);                 
					     	}  
					 });              
			}
	     function saveRentalData(cldocno,fromdate,todate,noofdays,types,total,remarks){           
	          var x=new XMLHttpRequest();       
	          var docno=$('#hiddocno').val();  
	          var vocno=$('#hidvocno').val(); 
	          var srno=$('#hidsrno').val();        
	          var brhid=$('#hidbrhid').val();     
		      x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){     
		      		var items=x.responseText.trim();          
		      		if(parseInt(items)>0){  
						swal({   
								type: 'success',
								title: 'Message',
								text: 'Successfully Saved'                    
							});    
						 $("#overlay, #PleaseWait").hide();
						 $('#txtremarks').val("");      
						 $('#fromdate').val(new Date());   
						 $('#todate').jqxDateTimeInput('setDate',null);
						 $('#cmbtypes').val("");               
						 $('#txttotal').val("");
						 $('#hidcldocno').val("");  
						 $('#noofdays').val("");         
						 $('#jqxClient').val("");     
						 funload(); 
						 $('#modalrental').modal('toggle');         
						}else{ 
							swal({
								type: 'error',
								title: 'Error',    
								text: 'Not Saved'                                             
							}); 
						$("#overlay, #PleaseWait").hide();        
						} 
		      	 }
		      }     
		      x.open("GET","saveRentalData.jsp?docno="+docno+'&srno='+srno+'&vocno='+vocno+'&brhid='+brhid+'&cldocno='+cldocno+'&fromdate='+fromdate+'&todate='+todate+'&noofdays='+noofdays+'&types='+types+'&total='+total+'&remarks='+remarks,true);                                                                                  
		      x.send();      
	     }
	function funtodate(){
		var types=$('#cmbtypes').val();               
		var fromdate=$('#fromdate').val();
		var noofdays=$('#noofdays').val();
		if(types==""){
			return false;
		}
		if(noofdays==""){
			return false;
		}
		getTodate(types,fromdate,noofdays);       
	}              
	function getTodate(types,fromdate,noofdays){ 
		 var docno=$('#hiddocno').val();  
         var srno=$('#hidsrno').val(); 
	     var x=new XMLHttpRequest();  
	     x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){       
		      		var items=x.responseText.trim().split("####");               
		      		$("#todate").val(new Date(items[0]));  
		      		$("#hiddatechk").val(items[1]);      
		      	 }
		      }     
		      x.open("GET",'getTodate.jsp?docno='+docno+'&srno='+srno+'&types='+types+'&fromdate='+fromdate+'&noofdays='+noofdays,true);                                                                                                       
		      x.send();    
	     } 
	function funinsertdays(){                          
		 var x=new XMLHttpRequest();  
     	 x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){     
		      		var items=x.responseText.trim();          
		      		if(parseInt(items)>0){  
		      			  funload();  
						}else{ 
					      funload();       
						} 
		      	 }
		      }     
		      x.open("GET",'insertPropertyDetails.jsp',true);                                                                                                            
		      x.send(); 
	}
	function funreceiptcreate(){             
	    var date=$('#rcptdate').jqxDateTimeInput('val');              
		var docno=$('#hiddocno').val();
		var vocno=$('#hidvocno').val();       
		var srno=$('#hidsrno').val();
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
			     		saveReceiptData(cmbpaytype,ReferenceDate,txtdocno,cmbcardtype,txtrefno,txtdesc,txtamount,brhid,date,docno,srno,cldocno,clacno,vocno);          
			     	}  
		});                
	}
	
	function saveReceiptData(cmbpaytype,ReferenceDate,txtdocno,cmbcardtype,txtrefno,txtdesc,txtamount,brhid,date,docno,srno,cldocno,clacno,vocno){                     
		console.log(brhid+"-"+txtdocno+"-"+docno+"-"+srno+"-"+cldocno+"-"+clacno+"-"+vocno);
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
			}
		}                 
		}   
		x.open("GET","createCR.jsp?paytype="+cmbpaytype+"&date="+date+"&refdate="+ReferenceDate+"&acdocno="+txtdocno+"&cardtype="+cmbcardtype+"&refno="+txtrefno+"&desc="+txtdesc+"&netamt="+txtamount+"&docno="+docno+"&srno="+srno+"&brhid="+brhid+"&clacno="+clacno+"&cldocno="+cldocno+"&vocno="+vocno,true);                                                 
		x.send();           
	} 
	function funrntlhistoryexcel(){
		 $("#rntlhisdiv").excelexportjs({  
				containerid: "rntlhisdiv",   
				datatype: 'json',
				dataset: null,
				gridId: "jqxrntlHistoryGrid",
				columns: getColumns("jqxrntlHistoryGrid") ,   
				worksheetName:"Rental History"         
			}); 
	}
	function funcontracts(){      
		$('#ppdiv').load("propertyGrid.jsp?id="+2);                   
	}
	function funcancelrental(rntldocno){       
		 $.messager.confirm('Message', 'Do you want to cancel rental?', function(r){           
		     	if(r==false)
		     	  {
		     		return false;   
		     	  }  
		     	else {
		     		$("#overlay, #PleaseWait").show();        
		     		savecancelData(rntldocno);               
		     	}  
	     });
	}
	 function savecancelData(rntldocno){               
         var x=new XMLHttpRequest();       
         var vocno=$('#hidvocno').val(); 
         var brhid=$('#hidbrhid').val();     
	      x.onreadystatechange=function(){
	      if (x.readyState==4 && x.status==200){     
	      		var items=x.responseText.trim();          
	      		if(parseInt(items)>0){  
					swal({   
							type: 'success',
							title: 'Message',
							text: 'Successfully cancelled'                        
						});    
					 $("#overlay, #PleaseWait").hide();
					 funload(); 
					 $('#modalcancelrental').modal('toggle');                              
					}else{ 
						swal({
							type: 'error',
							title: 'Error',    
							text: 'Not cancelled'                                             
						}); 
					$("#overlay, #PleaseWait").hide();        
					} 
	      	 }
	      }     
	      x.open("GET","saveCancelData.jsp?docno="+rntldocno+'&vocno='+vocno+'&brhid='+brhid,true);                                                                                  
	      x.send();                 
    }
	function validateExtentDate(){  
		     var date=$('#extdate').jqxDateTimeInput('val');  
			 var docno=$('#hiddocno').val();  
	         var srno=$('#hidsrno').val(); 
		     var x=new XMLHttpRequest();  
		     x.onreadystatechange=function(){
			      if (x.readyState==4 && x.status==200){       
			      		var items=x.responseText.trim();               
			      		$("#hiddatechk").val(items);  
			      		console.log($("#hiddatechk").val());      
			      	 }
			      }     
			  x.open("GET",'validateExtentDate.jsp?docno='+docno+'&srno='+srno+'&date='+date,true);                                                                                                          
			  x.send();           
	 }  
    function funrentalextent(){  
    	var docno=$('#hidrntldocno').val();
    	var amount=$('#txtvalue').val();
    	var date=$('#extdate').jqxDateTimeInput('val');  
    	validateExtentDate(date);
    	var datechk=$("#hiddatechk").val();        
		if(docno==""){  
			swal({
				type: 'warning',   
				title: 'Warning',       
				text: ' Please select a document '
			});
			 return 0;
		 } 
		if(datechk>0){     
			swal({
				type: 'warning',   
				title: 'Warning',       
				text: ' Already rented '        
			});
			 return 0;
		 } 
    	if(amount==''){  
			swal({
				type: 'warning',   
				title: 'Warning',       
				text: ' Please enter amount '    
			});
			 return 0;
		 }  
    	 $.messager.confirm('Message', 'Do you want to extent rental?', function(r){                
		     	if(r==false)
		     	  {
		     		return false;   
		     	  }  
		     	else {
		     		$("#overlay, #PleaseWait").show();        
		     		saveextentData(docno,amount,date);                        
		     	}  
	     });        
	}
	function saveextentData(rntldocno,amount,date){    
		var vocno=$('#hidvocno').val(); 
        var brhid=$('#hidbrhid').val(); 
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
					text: ' Successfully Extented '       
				});
			   $("#overlay, #PleaseWait").hide();
			   funload();  
			   $('#modalextentrental').modal('toggle');           
			}
			else
			{      
				swal({
					type: 'error',
					title: 'Error',  
					text: ' Not Extented '   
				}); 
				$("#overlay, #PleaseWait").hide();       
			}
		}                 
		}   
		x.open("GET","saveExtentData.jsp?date="+date+"&amount="+amount+"&docno="+rntldocno+"&brhid="+brhid+"&vocno="+vocno,true);                                                       
		x.send();             
	} 
	  function getstmtprint(docno,srno){
		    var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split('####');     
			    if(parseInt(items[2])>0){
				    var acno=items[2];    
				    var type="AR";   
					var brnach="a";    
					var url=document.URL;     
			        var reurl=url.split("realestate");     
			        var netamt=0.00;   
			        var fdate=items[0];    
		            var tdate=items[1];     
			        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();          
				}else{      
					swal({
						type: 'warning',           
						title: 'Warning',    
						text: 'Account Satatement is not created'              
					    });          
				}
			}                 
			}   
			x.open("GET","getAcno.jsp?docno="+docno+"&srno="+srno,true);                                                                     
			x.send();   
	    }
	  function funDelete(rowno){            
		    var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{  
						var items=x.responseText.trim(); 
						if(items==0){         
							swal({
								type: 'warning',           
								title: 'Warning',    
								text: 'Rental is active you cannot delete this property'                        
							    }); 
							return false;     
						}
						$('#splitdiv').load("splitGrid.jsp?docno="+$('#hiddocno').val()+"&id="+1);    
					}
					else    
					{       
					}                     
				}
				x.open("GET","deleterows.jsp?rowno="+rowno,true);                                          
				x.send();      
		}
  </script>
</form>  
</body>
</html>
