<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title> Schedule Report</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<link href="<%=contextPath%>/css/css/cardstyle.css" rel="stylesheet"  type="text/css" /> 
  <style type="text/css"> 
	  .branch {
		color: black;
		background-color: #ECF8E0;
		width: 100%;
		font-family: Tahoma;
		font-size: 12px;
	}  
       
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
    .textpanel{
        color: blue;    
  		width:150px;       
  }    
  .textpanel1{
        color: #00008B;    
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;  
    }
    
    .custompanel1{  
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
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
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
    .actionpanel{
        padding-right: 5px; 
    }
    .otherpanel{
        padding-right: 5px; 
    }
    .primarypanel{
        padding-right: 5px; 
    }
    .padtop{
        padding-top: 5px; 
    }
    .class-pad5{
     padding-top: 5px; 
    }
         .card-outer-container{
    	 display:inline-block;
		 width: calc(97%/8);
	 }
	 .card-container {
        margin-bottom: 3px;           
	  }
  </style>  
</head>       
<body>               
<form id="frmScheduleReport" action="saveScheduleReport" method="post" autocomplete="off">         
  <div class="container-fluid">
  	<div class="row padtop" style="font-size:1rem;">
  	 <div class="card-outer-container" id="compdiv">
        	<div class="card-container" id="compid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="comp"></div>
                        <span><img src="icons/icons8-complete-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>Completed</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
         <div class="card-outer-container" id="dropdiv">
        	<div class="card-container" id="dropid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="drop"></div>
                        <span><img src="icons/icons8-delete-notes-from-personal-records-logotype-layout-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>Dropped</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
      <div class="card-outer-container" id="noshodiv">
        	<div class="card-container" id="noshoid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="nosho"></div>
                        <span><img src="icons/icons8-id-not-verified-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>No Show</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
         <div class="card-outer-container" id="delivdiv">
        	<div class="card-container" id="delivid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="deliv"></div>
                        <span><img src="icons/icons8-delivery-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>Delivery</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
       <div class="card-outer-container" id="visitfreediv">
        	<div class="card-container" id="visitfreeid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="visitfree"></div>
                        <span><img src="icons/icons8-free-shipping-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>Visit Free</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
         <div class="card-outer-container" id="canceldiv">
        	<div class="card-container" id="cancelid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="cancel"></div>
                        <span><img src="icons/icons8-cancel-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>Cancelled</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
       <div class="card-outer-container" id="chargediv">
        	<div class="card-container" id="chargeid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="charge"></div>
                        <span><img src="icons/icons8-cheque-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>Visit Chargeable</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
         <div class="card-outer-container" id="repreqdiv">
        	<div class="card-container" id="repreqid">
            	<div class="card-body text-center">
                	<div class="card-chart-container">  
                    	<div id="repreq"></div>
                        <span><img src="icons/icons8-reminder-30.png" alt="" width="30" height="30"></span>  
                    </div>
                    <div class="card-detail-container">
                    	<span>Pending</span><br/>        
                        <span class="counter">0</span>  
                    </div>
                </div>
            </div>
        </div>
  	 
  	</div>
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
        <div class="todatepanel custompanel1">
	      <table>
		      <tr> 
			      <td align="right"><label  style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
			      <td align="left"><div id='fromdate' name='fromdate'></div></td>
			      <td align="right"><label  style="font-size: 13px">&nbsp;To Date &nbsp;&nbsp;</label></td>  
			      <td align="left"><div id='todate' name='todate'></div></td>  
			      <td align="right"><label  style="font-size: 13px">&nbsp;Route&nbsp;&nbsp;</label></td>       
		          <td align="left"><select class="form-control select2" name="cmbroute" id="cmbroute" style="width:100%;" onchange="loads();"></select></td>   
		          <td align="right"><label  style="font-size: 13px">&nbsp;Client&nbsp;&nbsp;</label></td>       
		          <td align="left"><select class="form-control select2" name="cmbclient" id="cmbclient" style="width:100%;" onchange="loads();"></select></td>   
		          <td align="right"><label style="font-size: 13px">&nbsp;Contract&nbsp;&nbsp;</label></td>       
		          <td align="left"><select class="form-control select2" name="cmbcontract" id="cmbcontract" style="width:100%;" onchange="loads();"></select></td>   
		     
		      </tr>                                            
		 </table>          
       </div>  
       <div class="primarypanel custompanel1">      
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
        <div class="textpanel custompanel" id="selectedid">     
           <table>  
		      <tr> 
			      <td align="left" width="80%" ><label for="divid" id="selecteddiv" style="font-size:75%;padding-right:5px"></label></td>                        
			      <td align="left" width="20%"><p style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p></td>  
			  </tr>                                          
		  </table>
	   </div> 
       <!--  <div class="actionpanel custompanel1">                                     
	          <button type="button" class="btn btn-default" id="btnstatusupdate" data-toggle="tooltip" title="Status Update" data-placement="bottom"><i class="fa fa-file-text "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btntippingdetails" data-toggle="tooltip" title="Service Info Data Entry" data-placement="bottom"><i class="fa fa-pencil-square "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnroutedetails" data-toggle="tooltip" title="Route Details Update" data-placement="bottom"><i class="fa fa-pencil-square-o "  aria-hidden="true"></i></button>        
              <button type="button" class="btn btn-default" id="btnschedule" data-toggle="tooltip" title="Schedule on call basis" data-placement="bottom"><i class="fa fa-calendar-check-o "  aria-hidden="true"></i></button>        
              <button type="button" class="btn btn-default" id="btnchangeschedule" data-toggle="tooltip" title="Change Schedule" data-placement="bottom"><i class="fa fa-calendar "  aria-hidden="true"></i></button>        
              <button type="button" class="btn btn-default" id="btnreplacement" data-toggle="tooltip" title="Replacement" data-placement="bottom"><i class="fa fa-exchange "  aria-hidden="true"></i></button>        
              <button type="button" class="btn btn-default" id="btnpullout" data-toggle="tooltip" title="Pull Out" data-placement="bottom"><i class="fa fa-share "  aria-hidden="true"></i></button>            
              <button type="button" class="btn btn-default" id="btnprint" data-toggle="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div> -->                 
        <!-- <div class="textpanel custompanel">     
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>                            
        </div> -->   
        
      </div>
    </div>
    <div class="row">               
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
        <div id="serschdiv"><jsp:include page="serviceScheduleGrid.jsp"></jsp:include></div>          
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
       <div id="modalstatusupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-sm">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Status Update<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row">  
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="cmbstatus">Status:</label>     
		        					<select class="form-control select2" name="cmbstatus" id="cmbstatus" style="width:100%;">    
		        					<option value="">--Select--</option><option value="1">Completed</option><option value="2">Dropped</option><option value="3">No Show</option>
		        					<option value="4">Visit Chargeable</option><option value="5">Visit Free</option><option value="6">Cancelled</option></select>     
	                     	    </div>         
		                   </div> 
		               </div>
          		</div>
          		<div class="modal-footer"> 
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnstatussave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
     </div> 
     <div id="modaltippingdetailsupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">  
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Service Info Data Entry<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>       
          		</div>
          		<div class="modal-body">  
  					<div class="row">  
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="dno Date">DNO Date:</label>      
		        					<div id='dodate'></div>      
	                     	    </div>  
		                   </div>   
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Waste Type">Waste Type:</label>            
		        					<div id="wastetype" onkeydown="return (event.keyCode!=13);"><jsp:include page="wastetypeSearch.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="wasteid" name="wasteid">               
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">             
		        				<div class="form-group">
		        					<label for="Skip Size">Skip Size:</label>            
		        					<div id="skipsize" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipsizeSearch.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="skipsizeid" name="skipsizeid">             
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="Tipping">Tipping:</label>      
		        					<select class="form-control select2" name="cmbtipping" id="cmbtipping" style="width:100%;">
		        					<option value="YES">YES</option><option value="NO">NO</option></select>   
	                     	    </div>  
		                   </div> 
		             </div> 
		             <div class="row">         
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Qty">Qty:</label>       
		        					<input type="text" id="txtqty" name="txtqty" class="form-control input-sm" style="height:27px" placeHolder="Enter Qty" onkeypress="return isNumberKey(event)">         
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="dno">DNO:</label>        
		        					<input type="text" id="txttipdno" name="txttipdno" class="form-control input-sm" style="height:27px" placeHolder="Enter DNO">         
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Weight">Weight:</label>       
		        					<input type="text" id="txtweight" name="txtweight" class="form-control input-sm" style="height:27px" placeHolder="Enter Weight" onkeypress="return isNumberKey(event)">         
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Price">Price:</label>        
		        					<input type="text" id="txtprice" name="txtprice" class="form-control input-sm" style="height:27px;text-align:right" placeHolder="Enter Price"  onblur="funRoundAmt(this.value,this.id);">    <!-- onkeypress="return isNumberKey(event)" -->            
	                     	    </div>      
		                   </div> 
            		</div>
            		<div class="row">  
            		    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="cmbstatustp">Status:</label>        
		        					<select class="form-control select2" name="cmbstatustp" id="cmbstatustp" style="width:100%;">    
		        					<option value="">--Select--</option><option value="1">Completed</option><option value="2">Dropped</option><option value="3">No Show</option>
		        					<option value="4">Visit Chargeable</option><option value="5">Visit Free</option><option value="6">Cancelled</option></select>     
	                     	    </div>         
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
  					         <div class="form-inline">
  					            <label for="AlternateDays" class="col-sm-11 col-form-label">Exchange</label>     
							    <div class="col-sm-1"> <input type="checkbox" id="exchangechk" name="exchangechk" onchange="funExchangeCheck();"></div>
							  </div>  
		                 </div> 
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-7" id="exchangediv">   
			                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">          
			        				<div class="form-group">
			        					<label for="tpskipno">Skip No:</label>     
			        					<div id="tpskipnodiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipnoSearchTp.jsp"></jsp:include></div>
	                                    <input type="hidden" id="tpskipno" name="tpskipno"/>             
		                     	    </div>  
			                 </div>
			                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" id="exchangediv1">       
			        				<div class="form-group">
			        					<label for="tpdate">Date:</label>        
			        					<div id="tpdate"></div>       
		                     	    </div>  
			                 </div>
			                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" id="exchangediv2">                
			        				<div class="form-group">
			        					<label for="tptime">Time:</label>           
			        					<div id="tptime"></div>         
		                     	    </div>  
			                 </div>  
		                 </div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>      
          			<button type="button" class="btn btn-default btn-primary" id="btntipdetsave">Save Changes</button>      
            		
          		</div>
        </div>
      </div>
    </div> 
    <div id="modalrouteupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Route Details Update<span></span></h4>  <label for="otherdetails3" id="lblotherdetails3"></label>   
          		</div>
          		<div class="modal-body">  
          			<div class="row">
          				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">    
		        				<div class="form-group">
		        					<label for="Route">Route:</label>   
		        					<input type="text" id="txtroute" name="txtroute" class="form-control input-sm" placeholder="press F3 to search" readonly  onKeyDown="getRoute();">  
		        					<input type="hidden" name="hidrouteid" id="hidrouteid">      
	                     	    </div>  
		                   </div> 
          		          <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Driver">Driver:</label>   
		        					<select class="form-control select2" name="cmbdriver" id="cmbdriver" style="width:100%;"></select> 
	                     	    </div>  
		                   </div>    
		          </div>
		          <div class="row">           
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Helper">Helper:</label>     
		        					<select class="form-control select2" name="cmbhelper" id="cmbhelper" style="width:100%;"></select>  
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Helper2">Helper2:</label>     
		        					<select class="form-control select2" name="cmbhelper2" id="cmbhelper2" style="width:100%;"></select>  
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="Vehicle">Vehicle:</label>     
		        					<select class="form-control select2" name="cmbvehicle" id="cmbvehicle" style="width:100%;"></select>   
	                     	    </div>  
		                   </div> 
          			</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnroutesave">Save Changes</button>  
            		
          		</div>
        </div>
      </div>
    </div>
    <div id="modalschedule" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-md">  
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Schedule on call basis<span></span></h4>  <label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>
          		<div class="modal-body">  
          			<div class="row">
          				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-7">      
		        				<div class="form-group">
		        					<label for="Route">Contract:</label>   
		        					<input type="text" id="txtcontract" name="txtcontract" class="form-control input-sm" placeholder="press F3 to search" readonly  onKeyDown="getContract();">  
		        					<input type="hidden" name="hidcnttrno" id="hidcnttrno"> 
		        					<input type="hidden" name="hidcntsrno" id="hidcntsrno">        
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">      
		        				<div class="form-group">
		        					<label for="Date">Date:</label>      
		        					<div id='scdate'></div>      
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="Time">Time:</label>      
		        					<div id='sctime'></div>         
	                     	    </div>  
		                   </div>
		          </div>
		          <div class="row">           
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Waste Type2">Waste Type:</label>            
		        					<div id="wastetypesc" onkeydown="return (event.keyCode!=13);"><jsp:include page="wastetypeSearchSC.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="scwasteid" name="scwasteid">                   
	                     	    </div>  
		                   </div>
          			</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnschedulesave">Save Changes</button>  
          		</div>
        </div>
      </div>
    </div>
    <div id="modalpullout" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Pull out<span></span></h4>  <label for="otherdetails5" id="lblotherdetails5"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
		        				<div class="form-group">
		        					<label for="podate">Date:</label>        
		        					<div id="podate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
		        				<div class="form-group">
		        					<label for="rptime">Time:</label>          
		        					<div id="potime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="pocontract">Contract:</label>      
		        					<input type="text" id="pocontract" name="pocontract" readonly class="form-control input-sm">   
	                     	    </div>  
		                 </div>  
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">        
		        				<div class="form-group">
		        					<label for="poskipno">Skip No:</label>     
		        					<div id="skipnodiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipnoSearch.jsp"></jsp:include></div>
                                    <input type="hidden" id="poskipno" name="poskipno"/>             
	                     	    </div>  
		                 </div>   
		            </div>  
		            <div class="row">  
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">      
		        				<div class="form-group">
		        					<label for="poremarks">Remarks:</label>          
		        					<input type="text" id="poremarks" name="poremarks" class="form-control input-sm">   
	                     	    </div>  
		                 </div>
		            </div>  
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>     
          			<button type="button" class="btn btn-default btn-primary" id="btnpulloutsave">Save Changes</button>
          		</div>
        </div>
      </div>
    </div> 
    <div id="modalreplacement" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-md">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Replacement<span></span></h4>  <label for="otherdetails6" id="lblotherdetails6"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		        				<div class="form-group">
		        					<label for="rpdate">Date:</label>        
		        					<div id="rpdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
		        				<div class="form-group">
		        					<label for="rptime">Time:</label>        
		        					<div id="rptime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        				<div class="form-group">
		        					<label for="rpskipno">Skip No:</label>       
		        					<div id="rpskipnodiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipnoSearchRp.jsp"></jsp:include></div>
                                    <input type="hidden" id="rpskipno" name="rpskipno"/>                 
	                     	    </div>  
		                 </div> 
		             </div> 
		             <div class="row">    
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">    
		        				<div class="form-group">
		        					<label for="rpremarks">Remarks:</label>          
                                    <input type="text" id="rpremarks" name="rpremarks" class="form-control input-sm">                
	                     	    </div>  
		                 </div>   
		              </div>  
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>     
          			<button type="button" class="btn btn-default btn-primary" id="btnreplacementsave">Save Changes</button>
          		</div>
        </div>
      </div>
    </div> 
    <div id="modalchangeschedule" class="modal fade" role="dialog">     
    	<div class="modal-dialog modal-md">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>         
            		<h4 class="modal-title">Change Schedule<span></span></h4>  <label for="otherdetails7" id="lblotherdetails7"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">       
		        				<div class="form-group">
		        					<label for="csdate">Date:</label>        
		        					<div id="csdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">       
		        				<div class="form-group">
		        					<label for="cstime">Time:</label>        
		        					<div id="cstime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		             </div> 
		             <div class="row">    
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">    
		        				<div class="form-group">
		        					<label for="csremarks">Remarks:</label>            
                                    <input type="text" id="csremarks" name="csremarks" class="form-control input-sm">                
	                     	    </div>  
		                 </div>   
		              </div>  
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>       
          			<button type="button" class="btn btn-default btn-primary" id="btnchangeschedulesave">Save Changes</button>
          		</div>
        </div>
      </div>
    </div> 
      <input type="hidden" name="hidcomments" id="hidcomments">   
      <input type="hidden" name="divname" id="divname">
      <input type="hidden" name="lblname" id="lblname">
      <input type="hidden" name="hiddocno" id="hiddocno">   
	  <input type="hidden" name="hidcontrno" id="hidcontrno">      
	  <input type="hidden" name="hidbrhid" id="hidbrhid">
	  <input type="hidden" name="hidroute" id="hidroute"> 
      <input type="hidden" name="hidsrno" id="hidsrno"> 
      <input type="hidden" name="hiddelid" id="hiddelid">     
      <input type="hidden" name="hidskipid" id="hidskipid">      
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){  
    	$("#selectedid").hide() 
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();
    	$('#contractWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#contractWindow').jqxWindow('close');   
	    $('#skipinfowindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '60%' , title: 'Skip Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#skipinfowindow').jqxWindow('close');
	    $('#routeinfoWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Route Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#routeinfoWindow').jqxWindow('close');
	    $("#dodate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    $("#scdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	    $("#sctime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false}); 
	    $("#csdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	    $("#cstime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false}); 
	    $("#podate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    $("#potime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false});  
	    $("#rpdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    $("#rptime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false});  
	    $("#tpdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	    $("#tptime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false}); 
	    $("#fromdate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"});          
	    $("#todate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"});  
	    $('#exchangediv1').hide();
	    $('#exchangediv2').hide();
	    
	    
	    $('#btnchangeschedulesave').attr('disabled',true); 
		$('#btnreplacementsave').attr('disabled',true);
		$('#btnpulloutsave').attr('disabled',true);
		
    	/* var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	    var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	    $('#todate').on('change', function (event) {
			var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				  // out date
			var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		    if(fromdates>todates){  
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
				   return false;
		    }
	    }); */   
	    getDriver();getHelper();getVehicle();getRoutes();getClients();getContracts();getCountData();  
	    document.getElementById('divname').value="comp";  
	    document.getElementById('selecteddiv').innerHTML=" - COMPLETED";
	    $('.card-container').removeClass('cardactive');      
	    $("#compid").addClass('cardactive'); 

    	$('#txtroute').dblclick(function(){  
	    	$('#routeinfoWindow').jqxWindow('open');
	    	routeSearchContent('routesearch.jsp?', $('#routeinfoWindow'));    
	    });
    	$('#txtcontract').dblclick(function(){  
	    	$('#contractWindow').jqxWindow('open');
	    	contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp", $('#contractWindow'));         
	    });
	    
	    $('#btnstatusupdate').click(function(){
	    	clearfields();
	    	document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val();
	    	checkForDocs("modalstatusupdate");
        });
	    $('#btnstatussave').click(function(){
	    	var processid="Status Update";  
	    	funUpdate(processid);        
        });
	    
	    $('#btntippingdetails').click(function(){     
	    	clearfields();
	    	$('#tpskipnodiv').load("skipnoSearchTp.jsp?id="+1);    
	    	funExchangeCheck();   
	    	checkForDocs("modaltippingdetailsupdate");  
        });
	    $('#btntipdetsave').click(function(){     
	    	var processid="Tipping Details Update";    
	    	funUpdate(processid);          
        });
	    
	    $('#btnroutedetails').click(function(){     
	    	clearfields();
	    	document.getElementById("lblotherdetails3").innerHTML=$("#lblname").val();   
	    	checkForDocs("modalrouteupdate");    
        });
	    $('#btnroutesave').click(function(){        
	    	var processid="Route Details Update";       
	    	funUpdate(processid);            
        });
	    
	    $('#btnschedule').click(function(){     
	    	clearfields();
	    	$("#modalschedule").modal('toggle');
        });
	    $('#btnschedulesave').click(function(){     
	    	var processid="Schedule on call basis";            
	    	funUpdate(processid);            
        });
	    
	    $('#btnpullout').click(function(){                
	    	clearfields();  
	        var docno=$('#hiddocno').val();
	    	if(docno=="" || docno=="0"){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	$("#modalpullout").modal('toggle');    
        });
	    $('#btnpulloutsave').click(function(){        
	    	var processid="Pull Out";       
	    	funUpdate(processid);              
        });
	    
	    $('#btnreplacement').click(function(){                
	    	clearfields();  
	        var docno=$('#hiddocno').val();
	    	if(docno=="" || docno=="0"){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	$("#modalreplacement").modal('toggle');      
        });
	    $('#btnreplacementsave').click(function(){        
	    	var processid="Replacement";         
	    	funUpdate(processid);                
        });
	    
	    $('#btnchangeschedule').click(function(){                
	    	clearfields();  
	        var docno=$('#hiddocno').val();
	    	if(docno=="" || docno=="0"){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	document.getElementById("lblotherdetails7").innerHTML=$("#lblname").val();  
	    	$("#modalchangeschedule").modal('toggle');      
        });
	    $('#btnchangeschedulesave').click(function(){        
	    	var processid="Change Schedule";             
	    	funUpdate(processid);                
        });
	    
        $('#btnsubmit').click(function(){    
        	clearfields(); 
        	getCountData()
            loads(); 
            //$('.textpanel p').text(''); 
        	document.getElementById("hiddocno").value=""; 
         	document.getElementById("hidbrhid").value="";
         	document.getElementById("hidcontrno").value="";
         	document.getElementById("lblname").value="";   
        });
        $('#btncomment').click(function(){    
	        var docno=$('#hiddocno').val();
	    	if(docno==""){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	 getComments(); 
        }); 
        $('#btnexcel').click(function(){  
        	$("#serschdiv").excelexportjs({ 
        		containerid: "serschdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxServiceScheduleGrid",     
        		columns: getColumns("jqxServiceScheduleGrid") ,   
        		worksheetName:" Schedule Report"     
         	});  
        });
        $('#btnprint').click(function(){     
	    	 funPrint(); 
        });  
        $('#btncommentsend').click(function(){
        	var enqno=$('#hidrowno').val();
        	var txtcomment=$('#txtcomment').val();
        	if(enqno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		Swal.fire({
        			icon: 'warning',
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
        		$('#jqxServiceScheduleGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
   function checkForDocs(modalid){
	    var v1=0,v2=0,val=0;
	    $('#jqxServiceScheduleGrid').jqxGrid('clearfilters', true);    
		var selectedrows=$('#jqxServiceScheduleGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){  
			Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Please select a document'   
			});
    		return false;  
		}else{
			for(var i=0;i<selectedrows.length;i++){
				if(i==0){    
					v1=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');   
					if(modalid=="modaltippingdetailsupdate"){
						$('#jqxwastetype').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'wastetype'));
						$('#wasteid').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'wastetypeid'));
						$('#jqxskipesize').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skipsize'));
						$('#skipsizeid').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skiptypeid'));
						document.getElementById("lblotherdetails2").innerHTML=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'contrno')+", Skip No - "+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skipno') 
					}   
				}else{
					v2=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
					if(v1!=v2){
						val=1;
						break;  
					}
				}
	        }
			
		}  
		if(val>0){  
			Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'You cannot select multiple contracts!!!'          
			});
    		return false;  
		}else{
			$("#"+modalid).modal('toggle');    
		}
   }  
   function funExchangeCheck(){       
		if(document.getElementById("exchangechk").checked){  
			$('#exchangediv').show(); 
			$('#tpskipno').val('');
			$('#jqxskipnoTp').val('');
			$('#tptime').val(new Date());
			$('#tpdate').val(new Date());   
		}else{
			$('#exchangediv').hide(); 
			$('#tpskipno').val('');
			$('#jqxskipnoTp').val('');
			$('#tptime').val(new Date());
			$('#tpdate').val(new Date());     
		}
	}
    function isNumberKey(evt){  
	    var charCode = (evt.which) ? evt.which : event.keyCode
	    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
	        return false;
	    return true;
	}
    function funRoundAmt(value,id){
        var res=parseFloat(value).toFixed(window.parent.amtdec.value);
        var res1=(res=='NaN'?"0":res);
        document.getElementById(id).value=res1;  
     }   
	function getAreas(){  
	   	 var x= event.keyCode;
	   	 if(x==114){
		    	  $('#areainfowindow').jqxWindow('open');
		    	  areaSearchContent('areaSearch.jsp?', $('#areainfowindow'));    
	   	  }else{       
	   	  } 
	}   
	function areaSearchContent(url) { 
	         $.get(url).done(function (data) {
		           $('#areainfowindow').jqxWindow('setContent', data);
	     	  }); 
	}
	function getContact(){    
		    	 var x= event.keyCode;
		    	 if(x==114){
		    		 var cldocno=document.getElementById("hidcntcldocno").value;
			    	  $('#contractWindow').jqxWindow('open');
			    	  contactSearchContent('Searchcontact.jsp?cldocno='+cldocno, $('#contractWindow'));          
		    	  }else{       
		    	  }     
		      
	}   
	function contactSearchContent(url) { 
		          $.get(url).done(function (data) {
			           $('#contractWindow').jqxWindow('setContent', data);
	          	  }); 
	}
	function getClient(){  
	   	 var x= event.keyCode;
	   	 if(x==114){
		    	  $('#clientsearch').jqxWindow('open');
		    	  clientSearchContent('clientsearch.jsp?', $('#clientsearch'));    
	   	  }else{       
	   	  } 
     
	}   
	function clientSearchContent(url) { 
	         $.get(url).done(function (data) {
		           $('#clientsearch').jqxWindow('setContent', data);
	     	  }); 
	}  
    function getskip(rowBoundIndex,skiptype){
   	  $('#skipinfowindow').jqxWindow('open');    
             skipSearchContent('getskip.jsp?rowBoundIndex='+rowBoundIndex+"&skiptype="+skiptype);    
    }
   function skipSearchContent(url) {
  	  	 $.get(url).done(function (data) {
  	     $('#skipinfowindow').jqxWindow('setContent', data);
         }); 
    }
   function getRoute(){  
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#routeinfoWindow').jqxWindow('open');
  	  routeSearchContent('routesearch.jsp?', $('#routeinfoWindow'));    }    
  	 else{
  		 }
     } 
    function routeSearchContent(url) {
		$('#routeinfoWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#routeinfoWindow').jqxWindow('setContent', data);
		$('#routeinfoWindow').jqxWindow('bringToFront');
	}); 
	}
    function getContract(){  
     	 var x= event.keyCode;
     	 if(x==114){
	     	  $('#contractWindow').jqxWindow('open');  
	     	  contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp", $('#contractWindow'));      
	     }else{  
     	 }
        } 
       function contractSearchContent(url) {
   		$('#contractWindow').jqxWindow('open');
   		$.get(url).done(function (data) {
   		$('#contractWindow').jqxWindow('setContent', data);
   		$('#contractWindow').jqxWindow('bringToFront');
   	}); 
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
    	$("#jqxServiceScheduleGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxServiceScheduleGrid").jqxGrid('applyfilters');    
 	}  
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#hidrowno').val();  
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&reftrno="+enqno,true);
		x.send();
    }
    function getComments(){  
    	var enqno=$('#hidrowno').val();
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
		x.open("GET","getComments.jsp?reftrno="+enqno,true);    
		x.send();
    }
    function getDriver() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbdriver').html($.parseHTML(optionsbranch));
	  			$('#cmbdriver').select2({
	  				placeholder:"Please select a Driver",  
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getDriver.jsp", true);  
		x.send();
	}
	function getHelper() { 
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbhelper').html($.parseHTML(optionsbranch));
	  			$('#cmbhelper').select2({
	  				placeholder:"Please select a Helper",   
	  				allowClear:true 
	  			});
	  			$('#cmbhelper2').html($.parseHTML(optionsbranch));
	  			$('#cmbhelper2').select2({
	  				placeholder:"Please select a Helper2",        
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getHelper.jsp", true);  
		x.send();
	}
	function getVehicle() {   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbvehicle').html($.parseHTML(optionsbranch));
	  			$('#cmbvehicle').select2({
	  				placeholder:"Please select a Vehicle",     
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getVehicle.jsp", true);    
		x.send();
	}
	function getRoutes() {   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbroute').html($.parseHTML(optionsbranch));
	  			$('#cmbroute').select2({
	  				placeholder:"Please select a Route",        
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getRoutes.jsp", true);    
		x.send();
	}
	function getClients() {   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' +process[i] +'">'
					+ srno[i].trim()  + '</option>';
					
				}
				$('#cmbclient').html($.parseHTML(optionsbranch));
	  			$('#cmbclient').select2({
	  				placeholder:"Please select a Client",        
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getClient.jsp", true);    
		x.send();
	}
	
	function getContracts() {   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbcontract').html($.parseHTML(optionsbranch));
	  			$('#cmbcontract').select2({
	  				placeholder:"Please select a Contract",        
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getContract.jsp", true);    
		x.send();
	}
    function loads(){  
	    $("#overlay, #PleaseWait").show();
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');         
	    var todate=$('#todate').jqxDateTimeInput('val');  
	    var routeid = $("#cmbroute").val();   
	    var cldocno = $("#cmbclient").val();    
	    var contrno = $("#cmbcontract").val();  
		var divname = $("#divname").val();
		$('#serschdiv').load('serviceScheduleGrid.jsp?fromdate='+fromdate+"&todate="+todate+"&divname="+divname+"&routeid="+routeid+"&cldocno="+cldocno+"&contrno="+contrno+'&id=1');             
    	getCountData();
    }   
	function clearfields(){  
		$("#cmbstatus").val('').trigger('change');
		$("#cmbtipping").val('YES').trigger('change');
		$("#cmbdriver").val('').trigger('change');
		$("#cmbhelper").val('').trigger('change');
		$("#cmbhelper2").val('').trigger('change');
		$("#cmbvehicle").val('').trigger('change');  
		$('#dodate').val(new Date());
		$('#wasteid').val('');     
		$('#jqxwastetype').val(''); 
		$('#skipsizeid').val('');   
		$('#jqxskipesize').val('');
		$('#txtqty').val(''); 
		$('#txttipdno').val('');  
		$('#txtweight').val('');   
		$('#txtprice').val('');
		$('#hidrouteid').val(''); 
		$('#txtroute').val(''); 
		$('#hidcnttrno').val('');     
		$('#hidcntsrno').val(''); 
		$('#scdate').val(new Date());   
		$('#sctime').val(new Date());
		$('#scwasteid').val(''); 
		$('#txtcontract').val('');
		$('#jqxwastetypeSC').val(''); 
		$('#podate').val(new Date());
		$('#potime').val(new Date());
		$('#jqxskipnoPO').val(''); 
		$('#poskipno').val('');
		$('#rpdate').val(new Date());
		$('#rptime').val(new Date());
		$('#jqxskipnoRp').val('');
		$('#rpskipno').val(''); 
		$('#poremarks').val('');   
		$('#rpremarks').val('');
		//$('#divname').val('');
		document.getElementById('selecteddiv').innerHTML="";
		document.getElementById('exchangechk').checked=false;
    }
	function funUpdate(processid){   
		var docno = $('#hiddocno').val();    
		var brhid= $("#hidbrhid").val();
		var cnttrno = $('#hidcontrno').val();
		var srno = $('#hidsrno').val();   
		var delid = $('#hiddelid').val();     
		
		if(processid=="Status Update"){      	
			var statusid= $('#cmbstatus').val();
			$('#jqxServiceScheduleGrid').jqxGrid('clearfilters', true);   
			var selectedrows=$('#jqxServiceScheduleGrid').jqxGrid('selectedrowindexes');
			var docsarray="";
			for(var i=0;i<selectedrows.length;i++){
						if(i==0){
							docsarray+=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
						}else{
							docsarray+=":"+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
						}
			}  
			if(statusid==''){
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please select a status!!!'       
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
						saveStatus(processid,statusid,docsarray);                 
					}else{
					}
			});
		}else if(processid=="Tipping Details Update"){          	
	    	var dodate =  $('#dodate').val();
	    	var wasteid = $('#wasteid').val();     
	    	var wastetype = $('#jqxwastetype').val(); 
	    	var skipsizeid = $('#skipsizeid').val();   
	    	var skipesize = $('#jqxskipesize').val();
	    	var qty = $('#txtqty').val(); 
	    	var dno = $('#txttipdno').val();  
	    	var weight = $('#txtweight').val();   
	    	var price = $('#txtprice').val(); 
	    	var tipping = $('#cmbtipping').val(); 
	    	var statusid = $('#cmbstatustp').val(); 
	    	var tpskipno = $('#tpskipno').val(); 
	    	var tptime = $('#tptime').val(); 
	    	var tpdate = $('#tpdate').val();   
	    	if(dno==''){      
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter DNO'             
				});	
	    		    return false;  
	    	 }
	    	if(wastetype==''){  
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter waste type'        
				});	
	    		    return false;  
	    	 }
	    	if(skipesize==''){
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter skip size'        
				});	
	    		    return false;    
	    	 }
	    	if(qty=='' || qty=='0'){ 
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please enter qty'        
				});	
	    		    return false;  
	    	 } 
	    	var exchange=0;  
	    	if(document.getElementById('exchangechk').checked){
	    		if(tpskipno=='' || tpskipno=='0'){    
		    		swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter skip no'          
					});	
		    		    return false;  
		    	 }
	    		exchange=1;   
	    	}
	    	var x=new XMLHttpRequest();
	    	x.onreadystatechange=function(){
	    	if (x.readyState==4 && x.status==200)  
	    		{
	    		var items=x.responseText.trim();
	    		if(parseInt(items)>0){       
	    	 		swal.fire({  
	    			    icon: 'warning',
	    				title: 'Warning',
	    				text: 'DO No already exists. Please use a different number.'        
	    			});	  
	    	 		 return false;
	    	 	}else{
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
	    						$("#overlay, #PleaseWait").show();   
	    						$('#jqxServiceScheduleGrid').jqxGrid('clearfilters', true);   
	    						var selectedrows=$('#jqxServiceScheduleGrid').jqxGrid('selectedrowindexes');
	    						var docsarray="",ctrno="";  
	    						for(var i=0;i<selectedrows.length;i++){
	    									if(i==0){
	    										docsarray+=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
	    										ctrno=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');   
	    									}else{
	    										docsarray+=":"+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');     
	    									}
	    						}  
	    						saveTippingDetails(processid, docsarray, dodate, wasteid, wastetype, skipsizeid, skipesize, qty, dno, weight, price, tipping, statusid, tpskipno, tpdate, tptime, ctrno, exchange);             
	    					}else{}  
	    			});
	    	 	}
	    	  }
	    	}
	      x.open("GET","validateTipping.jsp?dno="+encodeURIComponent(dno),true);                          
	      x.send();	  
		}else if(processid=="Route Details Update"){          	
			var routeid = $('#hidrouteid').val();     
	    	var driver = $('#cmbdriver').val(); 
	    	var helper = $('#cmbhelper').val();   
	    	var helper2 = $('#cmbhelper2').val();
	    	var vehicle = $('#cmbvehicle').val();
	    	if(routeid==''){      
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a route'             
				});	
	    		    return false;  
	    	 }
	    	if(driver==''){  
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a driver'        
				});	
	    		    return false;  
	    	 }
	    	$('#jqxServiceScheduleGrid').jqxGrid('clearfilters', true);   
			var selectedrows=$('#jqxServiceScheduleGrid').jqxGrid('selectedrowindexes');
			var docsarray="";
			for(var i=0;i<selectedrows.length;i++){
						if(i==0){
							docsarray+=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
						}else{
							docsarray+=":"+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
						}
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
						saveRoute(processid, docsarray, routeid, driver, helper, helper2, vehicle);                     
					}else{
					}
			});
		}else if(processid=="Schedule on call basis"){               	
			var sccnttrno = $('#hidcnttrno').val();     
	    	var sccntsrno = $('#hidcntsrno').val(); 
	    	var scdate = $('#scdate').val();   
	    	var sctime = $('#sctime').val();
	    	var scwasteid = $('#scwasteid').val();
	    	if(sccnttrno==''){        
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a contract'             
				});	
	    		    return false;  
	    	 }
	    	if(scwasteid==''){  
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a waste type'        
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
						saveScheduleCall(processid, sccnttrno, sccntsrno, scdate, sctime, scwasteid);                         
					}else{
					}
			});
		}else if(processid=="Pull Out"){               	
			var poskipno= $('#poskipno').val();
			var podate= $('#podate').val();
			var potime= $('#potime').val(); 
			var poremarks= $('#poremarks').val();
			if(poskipno==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter a skip no!!!'               
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
						savePullout(processid, poskipno, podate, docno, cnttrno, brhid, srno, delid, potime, poremarks);                              
					}else{
					}
			});
		}else if(processid=="Replacement"){               	
			var rpskipno= $('#rpskipno').val();
			var rpdate= $('#rpdate').val();
			var rptime= $('#rptime').val();
			var oldskipid= $('#hidskipid').val();
			var rpremarks= $('#rpremarks').val();     
			if(rpskipno==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter a skip no!!!'               
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
						saveReplacement(processid, rpskipno, rpdate, rptime, docno, cnttrno, brhid, srno, delid, oldskipid, rpremarks);                           
					}else{
					}
			});
		}else{}       
	}  
	function saveReplacement(processid, rpskipno, rpdate, rptime, docno, cnttrno, brhid, srno, delid, oldskipid, rpremarks){                          
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						         loads();
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalreplacement").modal('toggle');       
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});  
						}   
				}
		}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&poremarks="+encodeURIComponent(rpremarks)+"&oldskipid="+oldskipid+"&delid="+delid+"&cnttrno="+cnttrno+"&brhid="+brhid+"&srno="+srno+"&poskipno="+rpskipno+"&podate="+rpdate+"&potime="+rptime+"&docno="+docno,true);                 
		x.send();                
	}
	function savePullout(processid, poskipno, podate, docno, cnttrno, brhid, srno, delid, potime, poremarks){                   
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						         loads();
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalpullout").modal('toggle');       
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'     
									});
						} 
				}
		}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&potime="+potime+"&poremarks="+encodeURIComponent(poremarks)+"&delid="+delid+"&cnttrno="+cnttrno+"&brhid="+brhid+"&srno="+srno+"&poskipno="+poskipno+"&podate="+podate+"&docno="+docno,true);            
		x.send();                
	}
	function saveScheduleCall(processid, sccnttrno, sccntsrno, scdate, sctime, scwasteid){             
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						         loads();
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalschedule").modal('toggle');      
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&sccnttrno="+sccnttrno+"&sccntsrno="+sccntsrno+"&scdate="+scdate+"&sctime="+sctime+"&scwasteid="+scwasteid,true);          
		x.send();              
	}
	function saveRoute(processid, docsarray, routeid, driver, helper, helper2, vehicle){           
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						         loads();
						         clearfields();  
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalrouteupdate").modal('toggle');      
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&docsarray="+encodeURIComponent(docsarray)+"&routeid="+routeid+"&driver="+driver+"&helper="+helper+"&helper2="+helper2+"&vehicle="+vehicle,true);       
		x.send();            
	}
	function saveTippingDetails(processid, docsarray, dodate, wasteid, wastetype, skipsizeid, skipesize, qty, dno, weight, price, tipping, statusid, tpskipno, tpdate, tptime, ctrno, exchange){                    
    	var x=new XMLHttpRequest();  
    	x.onreadystatechange=function(){
    	if (x.readyState==4 && x.status==200){     
    			var items=x.responseText;
    				 if(parseInt(items)>0){ 
	    					 $("#overlay, #PleaseWait").hide();
	    					 $("#modaltippingdetailsupdate").modal('toggle');
	    					 loads();  
	    					 swal.fire({  
	    		    			    icon: 'success',
	    		    				title: 'Success',
	    		    				text: 'Successfully Updated'          
	    		    			});	
    					}else{
    						$("#overlay, #PleaseWait").hide();
    						$("#modaltippingdetailsupdate").modal('toggle');     
    						swal.fire({  
    		    			    icon: 'error',
    		    				title: 'Error',
    		    				text: 'Not Updated'             
    		    			});	
    					} 
    			}    
    	}  
    x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&wastetype="+encodeURIComponent(wastetype)+"&docsarray="+encodeURIComponent(docsarray)+"&dodate="+dodate+"&wasteid="+wasteid+"&skipesizeid="+skipsizeid+"&qty="+qty+"&skipesize="+encodeURIComponent(skipesize)+"&dno="+encodeURIComponent(dno)+"&weight="+weight+"&price="+price+"&tipping="+tipping+"&statusid="+statusid+"&poskipno="+tpskipno+"&podate="+tpdate+"&potime="+tptime+"&cnttrno="+ctrno+"&exchange="+exchange,true);                  
    x.send();     
    }   
	function saveStatus(processid,statusid,docsarray){        
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						         loads(); 
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalstatusupdate").modal('toggle');    
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&docsarray="+encodeURIComponent(docsarray)+"&statusid="+statusid,true);  
		x.send();          
	}
	function funPrint(){          
	  	    var routeid = $("#cmbroute").val();       
	        if(routeid=="" || routeid=="0") {    
	        	swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a Route'  
				});
	  			return 0;   
	       }else{
	      	     var url=document.URL;  
	      	     var reurl=url.split("com/");        
	      	     var win= window.open(reurl[0]+"printServiceSchedule?routeid="+routeid+"&branch="+document.getElementById("hidbrhid").value+"&date="+$('#todate').val()+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      		 win.focus();    
	       }
	}	
	function getCountData(){  
		var loadtype = $("#hidloadtype").val();
		var fromdate=$('#fromdate').jqxDateTimeInput('val');         
	    var todate=$('#todate').jqxDateTimeInput('val');  
	    var routeid = $("#cmbroute").val();   
	    var cldocno = $("#cmbclient").val();    
	    var contrno = $("#cmbcontract").val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("####");
				
				var guagedata=JSON.parse(items[1]);   
	          	$("#comp").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.completed==null?"0":guagedata.completed);
	        	$("#drop").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.dropped==null?"0":guagedata.dropped);  
	          	$("#nosho").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.noshow==null?"0":guagedata.noshow);	
	          	$("#deliv").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.delivery==null?"0":guagedata.delivery);
	        	$("#visitfree").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.visitfree==null?"0":guagedata.visitfree);
	        	$("#cancel").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.cancelled==null?"0":guagedata.cancelled);
	        	$("#charge").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.visitchargeable==null?"0":guagedata.visitchargeable);
	        	$("#repreq").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.pending==null?"0":guagedata.pending);
			}        
			else   
			{
			}  
		}
		x.open("GET","getCountData.jsp?fdate="+fromdate+"&tdate="+todate+"&routeid="+routeid+"&cldocno="+cldocno+"&contrno="+contrno,true);       
		x.send();
    }
	$('div').click(function() {
		  var divid=$(this).attr('id');  
		  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
			  var realid=divid.replace(/div/g, "");
			  if(realid=="comp" || realid=="drop" || realid=="nosho" || realid=="deliv" || realid=="visitfree" || realid=="cancel" || realid=="charge" || realid=="repreq"){     
				  $("#jqxServiceScheduleGrid").jqxGrid('clear');  
				  $('.textpanel p').text(''); 
				  document.getElementById('divname').value=realid;  
				  $('.card-container').removeClass('cardactive');      
		          $("#"+realid+"id").addClass('cardactive');
				  loads();               
			  }
			  if(realid=="comp"){   
				  document.getElementById('selecteddiv').innerHTML=" - COMPLETED";
			  }else if(realid=="drop"){
				  document.getElementById('selecteddiv').innerHTML=" - DROPPED";  
			  }else if(realid=="nosho"){
				  document.getElementById('selecteddiv').innerHTML=" - NO SHOW";
			  }else if(realid=="deliv"){
				  document.getElementById('selecteddiv').innerHTML=" - DELIVERY";  
			  }else if(realid=="visitfree"){
				  document.getElementById('selecteddiv').innerHTML=" - VISIT FREE";    
			  }else if(realid=="cancel"){
				  document.getElementById('selecteddiv').innerHTML=" - CANCELLED";    
			  }else if(realid=="charge"){
				  document.getElementById('selecteddiv').innerHTML=" - VISIT CHARGED";    
			  }else if(realid=="repreq"){
				  document.getElementById('selecteddiv').innerHTML=" - PENDING";    
			  }
			  else{}  
		  }
	  });
  </script> 
<div id="contractWindow">
	<div></div><div></div>
</div>  
<div id="routeinfoWindow">
	<div></div><div></div>
</div> 
<div id="skipinfowindow">
	<div></div><div></div>
</div>   
  </div>
  </form>   
</body>
</html>
