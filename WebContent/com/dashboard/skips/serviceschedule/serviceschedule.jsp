<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Service Schedule</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
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
  		overflow:auto; 
  		width:500px;
  		            
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
    .custompanel2{  
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 7px;
      padding-bottom: 7px;
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
    	margin-bottom:2px;
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
		 width: calc(97%/10);
	 }
	 .card-container {
        margin-bottom: 3px;           
	  }
	  table.table-borderless tr th,td { 
	  	font-size: 13px;    
	  }
  </style>  
</head>       
<body>               
<form id="frmServiceSchedule" action="saveScheduleSE" method="post" autocomplete="off">         
  <div class="container-fluid">  
  <div class="row padtop">
  
        	<div class="card-outer-container" id="delpdiv">    
                <div class="card-container" id="delpid"> 
                    <div class="card-body text-center float-container"> 
                      <div class="float-child">
                        <div class="card-chart-container">  
                            <div id="delp"></div>
                            <span><img src="../icons/icons8-delivery.png" alt="" width="30" height="30"></span>  
                        </div>
                     </div> 
                     <div class="float-child">   
                        <div class="card-detail-container">
                             <span>DEL(P)</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                     </div>     
                    </div>
                </div>
            </div>
            
        	<div class="card-outer-container" id="popdiv">    
                <div class="card-container" id="popid">
                    <div class="card-body text-center float-container">
	                    <div class="float-child">
	                        <div class="card-chart-container">  
	                            <div id="pop"></div>
	                            <span><img src="../icons/icons8-logout.png" alt="" width="30" height="30"></span>  
	                        </div>
	                    </div>
	                    <div class="float-child">
	                        <div class="card-detail-container">
	                             <span>PO(P)</span><br/>        
	                             <span class="counter">0</span>  
	                        </div>
	                    </div>
                    </div>
                </div>
            </div>
           <div class="card-outer-container" id="comschpdiv">    
                <div class="card-container" id="comschpid">
                    <div class="card-body text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">  
                            <div id="comschp"></div>
                            <span><img src="../icons/icons8-compactor.png" alt="" width="30" height="30"></span>   
                        </div>
                    </div>
	                <div class="float-child">    
                        <div class="card-detail-container">
                             <span>C.SCH(P)</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                  </div>  
                </div>
            </div>
             <div class="card-outer-container" id="ldschpdiv"> 
                <div class="card-container" id="ldschpid">
                    <div class="card-body  text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">
                            <div id="ldschp"></div>
                            <span><img src="../icons/icons8-loader.png" alt="" width="30" height="30"></span> 
                        </div>
                    </div>
	                <div class="float-child">    
                        <div class="card-detail-container">
                            <span>L.SCH(P)</span><br/>  
                             <span class="counter">0</span>
                        </div>
                    </div>
                  </div>  
                </div>
            </div>	
             <div class="card-outer-container" id="totpdiv"> 
                <div class="card-container" id="totpid">
                    <div class="card-body  text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">  
                            <div id="totp"></div>
                            <span><img src="../icons/icons8-netschedule.png" alt="" width="30" height="30"></span> 
                        </div>
                    </div>
	                <div class="float-child">    
                        <div class="card-detail-container">
                            <span>TOTAL(P)</span><br/>  
                             <span class="counter">0</span>
                        </div>
                    </div>
                  </div>  
                </div>
            </div>
            <div class="card-outer-container" id="delcdiv">    
                <div class="card-container" id="delcid">
                    <div class="card-body text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">  
                            <div id="delc"></div>
                            <span><img src="../icons/icons8-delivery.png" alt="" width="30" height="30"></span>  
                        </div>
                     </div>
	                 <div class="float-child">   
                        <div class="card-detail-container">
                             <span>DEL(C)</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                  </div>  
                </div>
            </div>
        	<div class="card-outer-container" id="pocdiv">    
                <div class="card-container" id="pocid">
                    <div class="card-body text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">  
                            <div id="poc"></div>
                            <span><img src="../icons/icons8-logout.png" alt="" width="30" height="30"></span>  
                        </div>
                     </div>
	                 <div class="float-child">    
                        <div class="card-detail-container">
                             <span>PO(C)</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                  </div>  
                </div>
            </div>
           <div class="card-outer-container" id="comschcdiv">    
                <div class="card-container" id="comschcid">
                    <div class="card-body text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">  
                            <div id="comschc"></div>
                            <span><img src="../icons/icons8-compactor.png" alt="" width="30" height="30"></span>   
                        </div>
                     </div>
	                 <div class="float-child">    
                        <div class="card-detail-container">
                             <span>C.SCH(C)</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                  </div>  
                </div>
            </div>
             <div class="card-outer-container" id="ldschcdiv"> 
                <div class="card-container" id="ldschcid">
                    <div class="card-body  text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">
                            <div id="ldschc"></div>
                            <span><img src="../icons/icons8-loader.png" alt="" width="30" height="30"></span> 
                        </div>
                     </div>
	                 <div class="float-child">    
                        <div class="card-detail-container">
                            <span>L.SCH(C)</span><br/>  
                             <span class="counter">0</span>
                        </div>
                    </div>
                  </div>  
                </div>
            </div>	
             <div class="card-outer-container" id="totcdiv"> 
                <div class="card-container" id="totcid">
                    <div class="card-body  text-center float-container">
                    <div class="float-child">
                        <div class="card-chart-container">  
                            <div id="totc"></div>
                            <span><img src="../icons/icons8-netschedule.png" alt="" width="30" height="30"></span> 
                        </div>
                    </div>
	                 <div class="float-child">     
                        <div class="card-detail-container">
                            <span>TOTAL(C)</span><br/>  
                             <span class="counter">0</span>
                        </div>
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
		        <td align="right"><label for="fromdatechk">From Dt: &nbsp;&nbsp;</label></td>
				 <td align="left"><div> <input type="checkbox" id="fromdatechk" name="fromdatechk" onchange="funchangedate();"></div></td>
			      <td align="right"><label style="font-size: 13px">&nbsp;&nbsp;From Date &nbsp;&nbsp;</label></td>  
			      <td align="left"><div id='fromdate' name='fromdate'></div></td>
			      <td align="right"><label style="font-size: 13px">&nbsp;To Date &nbsp;&nbsp;</label></td>  
			      <td align="left"><div id='todate' name='todate'></div></td>  
			      <td align="right"><label  style="font-size: 13px">&nbsp;Route&nbsp;&nbsp;</label></td>       
		          <td align="left"><select class="form-control select2" name="cmbroute" id="cmbroute" style="width:100%;" onchange="loads();"></select></td> 
		          <td align="right"><label  style="font-size: 13px">&nbsp;Client&nbsp;&nbsp;</label></td>       
		          <td align="left"><select class="form-control select2" name="cmbrefname" id="cmbrefname" style="width:100px;" onchange="loads();"></select></td> 
		      </tr>                                            
		 </table>          
       </div>  
      <div class="primarypanel custompanel2">  
           <!--   <button type="button" class="btn btn-default" id="btnfilter"  data-toggle="tooltip" title="Filter" data-placement="bottom"><i class="fa fa-filter" aria-hidden="true"></i></button>               -->
  		      <button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
          	  <button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	          <button type="button" class="btn btn-default" id="btninfo"  data-toggle="modal" data-target="#modalinfo" ><i class="fa fa-info-circle " aria-hidden="true" data-toggle="tooltip" title="Info" data-placement="bottom"></i></button>
        </div>   
        <div class="actionpanel custompanel2">                                          
	        <!--   <button type="button" class="btn btn-default" id="btnstatusupdate" data-toggle="tooltip" title="Status Update" data-placement="bottom"><i class="fa fa-file-text "  aria-hidden="true"></i></button>         -->
	          <button type="button" class="btn btn-default" id="btntippingdetails" data-toggle="tooltip" title="Service Info Data Entry" data-placement="bottom"><i class="fa fa-pencil-square "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnroutedetails" data-toggle="tooltip" title="Route Details Update" data-placement="bottom"><i class="fa fa-pencil-square-o "  aria-hidden="true"></i></button>        
              <button type="button" class="btn btn-default" id="btnschedule" data-toggle="tooltip" title="Schedule on call basis" data-placement="bottom"><i class="fa fa-calendar-check-o "  aria-hidden="true"></i></button>        
              <button type="button" class="btn btn-default" id="btnchangeschedule" data-toggle="tooltip" title="Change Schedule" data-placement="bottom"><i class="fa fa-calendar "  aria-hidden="true"></i></button>        
              <button type="button" class="btn btn-default" id="btnreplacement" data-toggle="tooltip" title="Replacement" data-placement="bottom"><i class="fa fa-exchange "  aria-hidden="true"></i></button>        
             <!--  <button type="button" class="btn btn-default" id="btnpullout" data-toggle="tooltip" title="Pull Out" data-placement="bottom"><i class="fa fa-share "  aria-hidden="true"></i></button>             -->
              <button type="button" class="btn btn-default" id="btnprint" data-toggle="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print "  aria-hidden="true"></i></button>        
         <!--  <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button> -->
        </div>                    
      </div>
    </div>
   <div class="row" id="textshow">               
        <div class="textpanel">     
           <table>  
		      <tr> 
			      <td align="left" width="40%"><label for="divid" id="selecteddiv" style="font-size:75%;padding-right:5px"></label></td>                        
			      <td align="left" width="60%"><p style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p></td>  
			  </tr>                                          
		  </table>
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
		        					<select class="form-control select2" name="cmbstatus" id="cmbstatus" style="width:100%;"></select>     
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
		        					<select class="form-control select2" name="cmbtipping" id="cmbtipping" style="width:100%;height:28px">
		        					<option value="YES">YES</option><option value="NO">NO</option></select>   
	                     	    </div>  
		                   </div> 
		             </div> 
		             <div class="row">         
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Qty">Qty:</label>       
		        					<input type="text" id="txtqty" name="txtqty" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Qty" onkeypress="return isNumberKey(event)">         
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="dno">DNO:</label>        
		        					<input type="text" id="txttipdno" name="txttipdno" class="form-control input-sm" style="height:27px" placeHolder="Please Enter DNO">         
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Weight">Weight:</label>       
		        					<input type="text" id="txtweight" name="txtweight" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Weight" onkeypress="return isNumberKey(event)">         
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" id="priceid">   
		        				<div class="form-group">
		        					<label for="Price">Price:</label>        
		        					<input type="text" id="txtprice" name="txtprice" class="form-control input-sm" style="height:27px;text-align:right" placeHolder="Please Enter Price"  onblur="funRoundAmt(this.value,this.id);">    <!-- onkeypress="return isNumberKey(event)" -->            
	                     	    </div>      
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
		        				<div class="form-group">
		        					<label for="cmbstatustp">Status:</label>        
		        					<select class="form-control select2" name="cmbstatustp" id="cmbstatustp" style="width:100%;height:31px"></select>     
	                     	    </div>         
		                  </div>
            		</div>
            		<div class="row">  
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Sub Status">Sub Status:</label>        
		        					<select class="form-control select2" name="cmbsubstatustp" id="cmbsubstatustp" style="width:100%;height:31px"></select>     
	                     	    </div>         
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">     
		        				<div class="form-group">
		        					<label for="Remarks">Remarks:</label>        
		        					<input type="text" id="txtremarks" name="txtremarks" class="form-control input-sm" style="height:27px;" placeHolder="Please Enter Remarks">              
	                     	    </div>      
		                  </div> 
		            </div>
		            <div class="row"> 
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
  					         <div class="form-inline">
  					            <label for="AlternateDays" class="col-sm-11 col-form-label">Exchange</label>     
							    <div class="col-sm-1"> <input type="checkbox" id="exchangechk" name="exchangechk" onchange="funExchangeValidate();"></div>
							  </div>  
		                 </div> 
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10" id="exchangediv">     
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
    	<div class="modal-dialog modal-lg">  
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Schedule on call basis<span></span></h4>  <label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>
          		<div class="modal-body" id="schedulecallbasis">  
          			<div class="row">
          			     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="Date">Call Date:</label>      
		        					<div id='cldate'></div>      
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="Time">Call Time:</label>      
		        					<div id='cltime'></div>           
	                     	    </div>  
		                   </div>
          				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="Route">Contract:</label>   
		        					<input type="text" id="txtcontract" name="txtcontract" class="form-control input-sm" placeholder="press F3 to search" readonly  onKeyDown="getContract();">  
		        					<input type="hidden" name="hidcnttrno" id="hidcnttrno"> 
		        					<input type="hidden" name="hidcntsrno" id="hidcntsrno">        
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
		        				<div class="form-group">
		        					<label for="Date">Sch. Date:</label>      
		        					<div id='scdate'></div>      
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="Time">Sch. Time:</label>      
		        					<div id='sctime'></div>         
	                     	    </div>  
		                   </div>
		          </div>
		          <div class="row">           
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="Waste Type2">Waste Type:</label>            
		        					<div id="wastetypesc" onkeydown="return (event.keyCode!=13);"><jsp:include page="wastetypeSearchSC.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="scwasteid" name="scwasteid">                   
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="slno">Delivery</label>                   
		        					<select class="form-control select2" id="cmbslno" style="width:100%;" name="cmbslno" onchange="getDetails();"></select>                
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="name">Name:</label>        
		        					<input type="text" id="txtname" name="txtname" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Name">         
	                     	    </div>  
		                  </div> 
          			</div>
          			<div class="row">
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="Mobile">Mobile:</label>        
		        					<input type="text" id="txtmobile" name="txtmobile" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Mobile No">         
	                     	    </div>  
		                  </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="Email">Email:</label>        
		        					<input type="text" id="txtemail" name="txtemail" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Email ID">           
	                     	    </div>  
		                  </div>
          			      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="Location">Location:</label>           
		        					<input type="text" id="txtlocation" name="txtlocation" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Location">                
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
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">     
		        				<div class="form-group">
		        					<label for="rptime">Time:</label>          
		        					<div id="potime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 	 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-5">         
		        				<div class="form-group">
		        					<label for="pocontract">Contract:</label>      
		        					<input type="text" id="pocontract" name="pocontract" class="form-control input-sm" placeholder="press F3 to search" readonly  onKeyDown="getContractPO();">  
		        					<input type="hidden" name="hidpocnttrno" id="hidpocnttrno">    
		        					<input type="hidden" name="hidpocntsrno" id="hidpocntsrno"> 
		        					<input type="hidden" name="hidpocntbrhid" id="hidpocntbrhid">  
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="slno">Delivery</label>                     
		        					<select class="form-control select2" id="cmbslnopo" style="width:100%;" name="cmbslnopo" value='<s:property value="cmbslnopo"/>' onchange="funLoadSkip(1);"></select>                
	                     	    </div>  
		                   </div>   
		            </div>  
		            <div class="row"> 
		                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">        
		        				<div class="form-group">
		        					<label for="poskipno">Skip No:</label>     
		        					<div id="skipnodiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipnoSearch.jsp"></jsp:include></div>
                                    <input type="hidden" id="poskipno" name="poskipno"/>             
	                     	    </div>  
		                 </div> 
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">        
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
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Replacement<span></span></h4>  <label for="otherdetails6" id="lblotherdetails6"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
		        				<div class="form-group">
		        					<label for="rpdate">Date:</label>        
		        					<div id="rpdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">     
		        				<div class="form-group">
		        					<label for="rptime">Time:</label>        
		        					<div id="rptime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-5">         
		        				<div class="form-group">
		        					<label for="rpcontract">Contract:</label>        
		        					<input type="text" id="rpcontract" name="rpcontract" class="form-control input-sm" placeholder="press F3 to search" readonly  onKeyDown="getContractRP();">  
		        					<input type="hidden" name="hidrpcnttrno" id="hidrpcnttrno">    
		        					<input type="hidden" name="hidrpcntsrno" id="hidrpcntsrno"> 
		        					<input type="hidden" name="hidrpcntbrhid" id="hidrpcntbrhid">  
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="slno">Current Skip</label>                     
		        					<select class="form-control select2" id="cmbslnorp" style="width:100%;" name="cmbslnorp" value='<s:property value="cmbslnorp"/>'></select>                     
	                     	    </div>  
		                   </div> 
		            </div>
		            <div class="row">         
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="rpskipno">New Skip:</label>       
		        					<div id="rpskipnodiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipnoSearchRp.jsp"></jsp:include></div>
                                    <input type="hidden" id="rpskipno" name="rpskipno"/>                 
	                     	    </div>  
		                 </div> 
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">      
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
   <div id="modalinfo" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Info<span></span></h4>     
          		</div>
          		<div class="modal-body">
  					   <table class="table table-borderless" width="100%">
						  <thead>
						    <tr>
							      <th scope="col">DEL(P)</th>
								  <th scope="col">PO(P)</th>
								  <th scope="col">C.SCH(P)</th>
								  <th scope="col">L.SCH(P)</th>
								  <th scope="col">TOTAL(P)</th>
								  <th scope="col">DEL(C)</th>
								  <th scope="col">PO(C)</th>
								  <th scope="col">C.SCH(C)</th>
								  <th scope="col">L.SCH(C)</th>
								  <th scope="col">TOTAL(C)</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
							    <td>Delivery</td>
								<td>PullOut</td>
								<td>Compactor Schedule</td>
								<td>Loader Schedule</td>
								<td>Total</td>
								<td>Delivery</td>
								<td>PullOut</td>
								<td>Compactor Schedule</td>
								<td>Loader Schedule</td>
								<td>Total</td>
						    </tr>
						     <tr>
							    <td>Pending</td>
								<td>Pending</td>
								<td>Pending</td>
								<td>Pending</td>
								<td>Pending</td>
								<td>Completed</td>
								<td>Completed</td>
								<td>Completed</td>
								<td>Completed</td>
								<td>Completed</td>
						    </tr>
						  </tbody>
					</table>
          		</div>
          		<div class="modal-footer"> 
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
          		</div>  
        </div>
      </div>
     </div>  
    <%-- <div id="modalfilter" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Filters<span></span></h4>     
          		</div>
          		<div class="modal-body">
  					   <div class="row">
  					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2"> 
  					          <div class="form-inline">
  					            <label for="fromdatechk" class="col-sm-10 col-form-label">From Dt:</label>
							    <div class="col-sm-2"> <input type="checkbox" id="fromdatechk" name="fromdatechk" onchange="funchangedate();"></div>
							  </div>       
		                 </div>
  					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
		        				<div class="form-group">
		        					<label for="fromdate">From Date:</label>        
		        					<div id="fromdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
		        				<div class="form-group">
		        					<label for="todate">To Date:</label>        
		        					<div id="todate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		        				<div class="form-group">
		        					<label for="Route">Route:</label>            
		        					<select class="form-control select2" name="cmbroute" id="cmbroute" style="width:100%;"></select>    
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		        				<div class="form-group">
		        					<label for="Client">Client:</label>              
		        					<select class="form-control select2" name="cmbrefname" id="cmbrefname" style="width:100%;"></select>    
	                     	    </div>  
		                 </div>
		             </div> 
          		</div>
          		<div class="modal-footer"> 
          			<button type="button" class="btn btn-default btn-primary" id="btnfilterok">Ok</button>
            		
          		</div>
        </div>
      </div>
     </div> --%>
      <input type="hidden" name="hidcomments" id="hidcomments">   
      <input type="hidden" name="lblname" id="lblname">
      <input type="hidden" name="hiddocno" id="hiddocno">   
	  <input type="hidden" name="hidcontrno" id="hidcontrno">      
	  <input type="hidden" name="hidbrhid" id="hidbrhid">
	  <input type="hidden" name="hidroute" id="hidroute"> 
      <input type="hidden" name="hidsrno" id="hidsrno"> 
      <input type="hidden" name="hiddelid" id="hiddelid">     
      <input type="hidden" name="hidskipid" id="hidskipid">   
      <input type="hidden" name="divname" id="divname">     
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:300px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();
    	$('#contractWindow').jqxWindow({ width: '65%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#contractWindow').jqxWindow('close');   
	    $('#skipinfowindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '60%' , title: 'Skip Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#skipinfowindow').jqxWindow('close');
	    $('#routeinfoWindow').jqxWindow({width: '65%', height: '65%',  maxHeight: '75%' ,maxWidth: '75%' , title: 'Route Search',position: { x: 120, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
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
	    $("#cldate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	    $("#cltime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false}); 
	    $('#exchangediv1').hide(); 
	    $('#exchangediv2').hide();
	    document.getElementById('selecteddiv').innerHTML=" - DELIVERY";    
    	document.getElementById("divname").value="delp"; 
    	$('.card-container').removeClass('cardactive');      
        $("#delpid").addClass('cardactive');   
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
	    document.getElementById('fromdatechk').checked=true;
	    getDriver();getHelper();getVehicle();getRoutes();getStatus();getStatusTP();getSubStatusTP("0");getRefname(); funchangedate(); 
	    $('#textshow').hide()
	    $('#priceid').hide()
	    
	   /*  $('#btnfilter').click(function(){ 
	    	funchangedate();
	    	$("#modalfilter").modal('toggle');      
        });
	    $('#btnfilterok').click(function(){
	    	$("#modalfilter").modal('toggle');
	    	loads();     
        }); */
	    
    	$('#txtroute').dblclick(function(){    
	    	$('#routeinfoWindow').jqxWindow('open');
	    	routeSearchContent('routesearch.jsp?', $('#routeinfoWindow'));    
	    });
    	$('#txtcontract').dblclick(function(){     
	    	$('#contractWindow').jqxWindow('open');
	    	contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+1, $('#contractWindow'));         
	    });
    	$('#pocontract').dblclick(function(){     
	    	$('#contractWindow').jqxWindow('open');
	    	contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+2, $('#contractWindow'));         
	    });
    	$('#rpcontract').dblclick(function(){     
	    	$('#contractWindow').jqxWindow('open');
	    	contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+3, $('#contractWindow'));         
	    });
    	$('#cmbstatustp').change(function(){  
    		var statusid = $('#cmbstatustp').val();
    		var selectedText = $("#cmbstatustp option:selected").text().trim();  
    		if(selectedText == "Dropped" || selectedText == "Visit Chargeable" || selectedText == "Visit Free"){   
    			$('#cmbsubstatustp').attr('disabled',false);
    			$("#cmbsubstatustp").val('').trigger('change');
    			getSubStatusTP(statusid); 
    		}else{
    			$("#cmbsubstatustp").val('').trigger('change');
    			$('#cmbsubstatustp').attr('disabled',true);
    		}
    	})
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
	    	$('#cmbsubstatustp').attr('disabled',true);
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
	    	$("#modalpullout").modal('toggle');    
        });
	    $('#btnpulloutsave').click(function(){        
	    	var processid="Pull Out";       
	    	funUpdate(processid);              
        });
	    
	    $('#btnreplacement').click(function(){                
	    	clearfields();    
	    	$('#rpskipnodiv').load("skipnoSearchRp.jsp?type="+2);  
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
            loads(); 
            $('.textpanel p').text(''); 
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
        		worksheetName:"Service Schedule"     
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
					v1=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'routeid');   
					if(modalid=="modaltippingdetailsupdate"){
						var schdate = $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'date').split('.');  
						$('#dodate').jqxDateTimeInput('setDate',new Date(schdate[2],schdate[1]-1,schdate[0]));      
						$('#jqxwastetype').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'wastetype'));
						$('#wasteid').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'wastetypeid'));
						$('#jqxskipesize').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skipsize'));
						$('#skipsizeid').val($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skiptypeid'));
						document.getElementById("lblotherdetails2").innerHTML=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'contrno')+", Skip No - "+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skipno') 
					}   
				}else{
					v2=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'routeid');
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
				text: 'You cannot select multiple routes!!!'          
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
   function funExchangeValidate(){            
		if(document.getElementById("exchangechk").checked){
			 var v1=0,v2=0,val=0;
			 $('#jqxServiceScheduleGrid').jqxGrid('clearfilters', true);    
			 var selectedrows=$('#jqxServiceScheduleGrid').jqxGrid('selectedrowindexes');
			 for(var i=0;i<selectedrows.length;i++){
						if(i==0){    
							v1=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skipid');   
						}else{
							v2=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'skipid');   
							if(v1!=v2){
								val=1;
								break;  
							}
					   }
			 }
			 if(val>0){  
					Swal.fire({
		    			icon: 'warning',
						title: 'Warning',
						text: 'You cannot select multiple skips!!!'             
					});
					document.getElementById("exchangechk").checked=false;  
		    		return false;  
			 }else{  
				 funExchangeCheck();
			 }
		}else{
			funExchangeCheck();
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
	     	  contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+1, $('#contractWindow'));      
	     }else{  
     	 }
        } 
    function getContractPO(){     
    	 var x= event.keyCode;
    	 if(x==114){
	     	  $('#contractWindow').jqxWindow('open');  
	     	  contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+2, $('#contractWindow'));      
	     }else{  
    	 }
       }
    function getContractRP(){         
   	 var x= event.keyCode;
   	 if(x==114){
	     	  $('#contractWindow').jqxWindow('open');  
	     	  contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+3, $('#contractWindow'));      
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
	  				placeholder:"Select Route",        
	  				allowClear:true 
	  			});
	  			getCountData();
			} else {}
		}
		x.open("GET","getRoutes.jsp", true);    
		x.send();
	}
	function getRefname() {   
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="'+ srno[i] +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbrefname').html($.parseHTML(optionsbranch));
	  			$('#cmbrefname').select2({
	  				placeholder:"Select Client",         
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getRefname.jsp", true);      
		x.send();
	}
	function getDeliveries() {    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {   
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var srno,process;
				if(items!=""){   
					 srno  = items[0].split(",");
					 process = items[1].split(",");   
				}
				var optionsbranch = '<option value="0" selected>Please select a serial no</option>';      
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="'+ srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbslno').html($.parseHTML(optionsbranch));  
	  			$('#cmbslno').select2({
	  				placeholder:"Please select a serial no",      
	  				allowClear:true, 
	  			});
			} else {}
		}
		x.open("GET","getDeliveries.jsp?srno="+$("#hidcntsrno").val()+"&contrno="+$("#hidcnttrno").val(), true);         
		x.send();
	}
	function getDeliveriesPO() {    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {   
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var srno,process;
				if(items!=""){   
					 srno  = items[0].split(",");
					 process = items[1].split(",");   
				}
				var optionsbranch = '<option value="0" selected>Please select a serial no</option>';      
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbslnopo').html($.parseHTML(optionsbranch));  
	  			$('#cmbslnopo').select2({
	  				placeholder:"Please select a serial no",        
	  				allowClear:true, 
	  			});
			} else {}  
		}
		x.open("GET","getDeliveriesPO.jsp?srno="+$("#hidpocntsrno").val()+"&contrno="+$("#hidpocnttrno").val(), true);         
		x.send();
	}
	function getDeliveriesRP() {    
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {   
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var srno,process;
				if(items!=""){   
					 srno  = items[0].split(",");
					 process = items[1].split(",");   
				}
				var optionsbranch = '<option value="0" selected>Please select a serial no</option>';      
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbslnorp').html($.parseHTML(optionsbranch));  
	  			$('#cmbslnorp').select2({
	  				placeholder:"Please select a serial no",        
	  				allowClear:true, 
	  			});
			} else {}  
		}
		x.open("GET","getDeliveriesRP.jsp?srno="+$("#hidrpcntsrno").val()+"&contrno="+$("#hidrpcnttrno").val(), true);         
		x.send();
	}
	function getStatus() {   
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
				$('#cmbstatus').html($.parseHTML(optionsbranch));
	  			$('#cmbstatus').select2({
	  				placeholder:"Please select a Status",        
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getStatus.jsp", true);    
		x.send();
	}									
 function getStatusTP() {   
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
				$('#cmbstatustp').html($.parseHTML(optionsbranch));
	  			$('#cmbstatustp').select2({
	  				placeholder:"Please select a Status",        
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getStatus.jsp", true);    
		x.send();
	}									
   function getSubStatusTP(statusid) {   
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
				$('#cmbsubstatustp').html($.parseHTML(optionsbranch));
	  			$('#cmbsubstatustp').select2({
	  				placeholder:"Please select a Sub Status",        
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getSubStatus.jsp?statusid="+statusid, true);    
		x.send();
	}
     function loads(){ 
    	getCountData();
    	var divname=$('#divname').val(); 
	    $("#overlay, #PleaseWait").show();
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');         
	    var todate=$('#todate').jqxDateTimeInput('val');  
	    var routeid = $("#cmbroute").val();   
	    var frmdtchk = 0;
	    var clientname =  $("#cmbrefname").find('option:selected').text().split("-");
	    var cldocno =clientname[0].trim()
	    if(document.getElementById('fromdatechk').checked){
	    	frmdtchk = 1;  
	    }else{
	    	frmdtchk = 0; 
	    }
	    console.log("IN LOAD");
	    $('#serschdiv').load('serviceScheduleGrid.jsp?fromdate='+fromdate+"&todate="+todate+"&routeid="+routeid+"&cldocno="+cldocno+"&frmdtchk="+frmdtchk+"&divname="+divname+'&id=1');             
    }    
	function clearfields(){  
		$("#cmbstatus").val('').trigger('change');
		$("#cmbtipping").val('YES').trigger('change');
		$("#cmbdriver").val('').trigger('change');
		$("#cmbhelper").val('').trigger('change');
		$("#cmbhelper2").val('').trigger('change');
		$("#cmbvehicle").val('').trigger('change'); 
		$("#cmbsubstatustp").val('').trigger('change');		
		$("#cmbstatustp").val('').trigger('change');  		
		$("#txtremarks").val('');	  
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
		$('#cldate').val(new Date());   
		$('#cltime').val(new Date());
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
		document.getElementById('exchangechk').checked=false;
		$('#csdate').val(new Date());
		$('#cstime').val(new Date());
		$('#csremarks').val('');  
		document.getElementById("lblotherdetails4").innerHTML="";
		document.getElementById("lblotherdetails5").innerHTML="";
		document.getElementById("lblotherdetails6").innerHTML="";   
		$('#hidpocntbrhid').val(''); 
		$('#hidpocntsrno').val(''); 
		$('#hidpocnttrno').val(''); 
		$('#pocontract').val(''); 
		$('#hidrpcntbrhid').val(''); 
		$('#hidrpcntsrno').val(''); 
		$('#hidrpcnttrno').val(''); 
		$('#rpcontract').val(''); 
		$('#txtname').val('');  
		$('#txtmobile').val(''); 
		$('#txtemail').val(''); 
		$('#txtlocation').val('');
		getDeliveries();
		getDeliveriesPO();
		getDeliveriesRP();
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
			var ctrno=0;  
			for(var i=0;i<selectedrows.length;i++){
						if(i==0){
							docsarray+=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
							ctrno=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
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
						saveStatus(processid,statusid,docsarray,ctrno);                 
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
	    	var substatusid = $("#cmbsubstatustp").val();									
	    	var remarks = $("#txtremarks").val();
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
	    						saveTippingDetails(processid, docsarray, dodate, wasteid, wastetype, skipsizeid, skipesize, qty, dno, weight, price, tipping, statusid, tpskipno, tpdate, tptime, ctrno, exchange, substatusid, remarks);             
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
	    	var delsrno = $('#cmbslno').val();
	    	var name = $('#txtname').val();  
	    	var mobno = $('#txtmobile').val(); 
	    	var email = $('#txtemail').val(); 
	    	var location = $('#txtlocation').val(); 
	    	var cldate = $('#cldate').val();   
	    	var cltime = $('#cltime').val();    
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
	    	 if(delsrno=="" || delsrno=="0"){ 
				swal.fire({  
					icon: 'warning',
					title: 'Warning',
					text:  'Please select a serial no!!!'     
				});
  		        return false;
		     } 
	    	 if(name==''){        
		    		swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter name'               
					});	
		    		    return false;  
		     }
	    	 if(mobno==''){        
		    		swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter mobile no.'               
					});	
		    		    return false;  
		     }
	    	 var mobnochk = ValidateMobileNo(mobno);
		     if(mobnochk){
		    		swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'You have entered an invalid mobile number!'                   
					});	
		    		$('#txtmobile').focus();     
		    	    return false;
		    }
	    	var emailchk = ValidateEmailAddress(email);
	    	if(email!=''){   
	    		if(emailchk){
		    		swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'You have entered an invalid email address!'                 
					});	
		    		$('#txtemail').focus(); 
		    	    return false;
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
						saveScheduleCall(processid, sccnttrno, sccntsrno, scdate, sctime, scwasteid, delsrno, name, mobno, email, location, cldate, cltime);                           
					}else{
					}
			});
		}else if(processid=="Pull Out"){     
			var pocnttrno = $('#hidpocnttrno').val();     
	    	var pocntsrno = $('#hidpocntsrno').val(); 
	    	var pocntbrhid = $('#hidpocntbrhid').val();   
			var poskipno= $('#poskipno').val();
			var podate= $('#podate').val();
			var potime= $('#potime').val(); 
			var poremarks= $('#poremarks').val();
			var delsrno = $('#cmbslnopo').val();
			if(pocnttrno==''){        
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a contract'             
				});	
	    		    return false;  
	    	 }
			if(poskipno==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter a skip no!!!'               
					});
	  		      return false;
			}    
			if(delsrno=="" || delsrno=="0"){ 
				swal.fire({  
					icon: 'warning',
					title: 'Warning',
					text:  'Please select a serial no!!!'     
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
						savePullout(processid, poskipno, podate, pocnttrno, pocntbrhid, pocntsrno, delsrno, potime, poremarks);                              
					}else{
					}
			});
		}else if(processid=="Replacement"){ 
			var rpcnttrno = $('#hidrpcnttrno').val();     
	    	var rpcntsrno = $('#hidrpcntsrno').val(); 
	    	var rpcntbrhid = $('#hidrpcntbrhid').val();  
			var rpskipno= $('#rpskipno').val();
			var rpdate= $('#rpdate').val();
			var rptime= $('#rptime').val();
			var rpremarks= $('#rpremarks').val();  
			var delsrno = $('#cmbslnorp').val(); 
			if(rpcnttrno==''){          
	    		swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a contract'             
				});	
	    		    return false;  
	    	 }
			if(rpskipno==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter a skip no!!!'               
					});
	  		      return false;
			 } 
			if(delsrno=="" || delsrno=="0"){ 
				swal.fire({  
					icon: 'warning',
					title: 'Warning',
					text:  'Please select a serial no!!!'     
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
						saveReplacement(processid, rpskipno, rpdate, rptime, rpcnttrno, rpcntbrhid, rpcntsrno, delsrno, rpremarks);                              
					}else{
					}
			});
		}else if(processid=="Change Schedule"){                      	
			var podate= $('#csdate').val();   
			var potime= $('#cstime').val(); 
			var poremarks= $('#csremarks').val();   
			if(csremarks==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter remarks!!!'                   
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
						saveChangeSchedule(processid, podate, docno, cnttrno, brhid, srno, delid, potime, poremarks);                                  
					}else{
					}
			});
		}else{}       
	} 
	function saveChangeSchedule(processid, podate, docno, cnttrno, brhid, srno, delid, potime, poremarks){                      
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
								 $("#modalchangeschedule").modal('toggle');         
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'     
									});
						} 
				}
		}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&potime="+potime+"&poremarks="+encodeURIComponent(poremarks)+"&delid="+delid+"&cnttrno="+cnttrno+"&brhid="+brhid+"&srno="+srno+"&podate="+podate+"&docno="+docno,true);            
		x.send();                
	}          
	function saveReplacement(processid, rpskipno, rpdate, rptime, cnttrno, brhid, srno, delsrno, rpremarks){                          
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
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&poremarks="+encodeURIComponent(rpremarks)+"&delsrno="+delsrno+"&cnttrno="+cnttrno+"&brhid="+brhid+"&srno="+srno+"&poskipno="+rpskipno+"&podate="+rpdate+"&potime="+rptime,true);                 
		x.send();                
	}           
	function savePullout(processid, poskipno, podate, cnttrno, brhid, srno, delsrno, potime, poremarks){                   
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
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&potime="+potime+"&poremarks="+encodeURIComponent(poremarks)+"&delsrno="+delsrno+"&cnttrno="+cnttrno+"&brhid="+brhid+"&srno="+srno+"&poskipno="+poskipno+"&podate="+podate,true);            
		x.send();                
	}
	function saveScheduleCall(processid, sccnttrno, sccntsrno, scdate, sctime, scwasteid, delsrno, name, mobno, email, location, cldate, cltime){             
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
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&delsrno="+delsrno+"&sccnttrno="+sccnttrno+"&sccntsrno="+sccntsrno+"&podate="+cldate+"&potime="+cltime+"&scdate="+scdate+"&sctime="+sctime+"&scwasteid="+scwasteid+"&name="+encodeURIComponent(name)+"&mobno="+mobno+"&email="+encodeURIComponent(email)+"&location="+encodeURIComponent(location),true);          
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
	function saveTippingDetails(processid, docsarray, dodate, wasteid, wastetype, skipsizeid, skipesize, qty, dno, weight, price, tipping, statusid, tpskipno, tpdate, tptime, ctrno, exchange, substatusid, remarks){                       
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
    x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&wastetype="+encodeURIComponent(wastetype)+"&docsarray="+encodeURIComponent(docsarray)+"&dodate="+dodate+"&wasteid="+wasteid+"&skipesizeid="+skipsizeid+"&qty="+qty+"&skipesize="+encodeURIComponent(skipesize)+"&dno="+encodeURIComponent(dno)+"&weight="+weight+"&price="+price+"&tipping="+tipping+"&statusid="+statusid+"&poskipno="+tpskipno+"&podate="+tpdate+"&potime="+tptime+"&cnttrno="+ctrno+"&exchange="+exchange+"&poremarks="+encodeURIComponent(remarks)+"&substatusid="+substatusid,true);                  
    x.send();     
    }   
	function saveStatus(processid,statusid,docsarray,ctrno){        
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
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&docsarray="+encodeURIComponent(docsarray)+"&statusid="+statusid+"&cnttrno="+ctrno,true);    
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
	function funLoadSkip(id){      
		$('#skipnodiv').load("skipnoSearch.jsp?cnttrno="+$("#hidpocnttrno").val()+"&cntsrno="+$("#hidpocntsrno").val()+"&delsrno="+$("#cmbslnopo").val()+"&type="+1);       
	}
	function getDetails(){   
		var slno = $('#cmbslno').val();
		var cnttrno = $('#hidcnttrno').val();
		var detsrno = $('#hidcntsrno').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function(){
			if(x.readyState == 4 && x.status == 200){
				var items = x.responseText.split('####');   
				$('#txtname').val(items[0]);
				$('#txtmobile').val(items[1]);
				$('#txtemail').val(items[2]); 
				$('#txtlocation').val(items[3]);
			}
		}
		x.open('GET','getDetails.jsp?slno='+slno+'&contrno='+cnttrno+'&srno='+detsrno) 
		x.send();  
	}
	function ValidateEmailAddress(email) {            
	    var atSymbol = email.indexOf("@");
	    if(atSymbol < 1) return true;
	    
	    var dot = email.indexOf(".");
	    if(dot <= atSymbol + 2) return true;
	    
	    if (dot === email.length - 1) return true;
	    
	    return false;
	}
	function ValidateMobileNo(mobno) {  
		if(isNaN(mobno)) return true; 
			
		return false;
	}
  function funchangedate(){
		if(document.getElementById('fromdatechk').checked){  
			$("#fromdate").jqxDateTimeInput('disabled',false);     
		}else{
			$("#fromdate").jqxDateTimeInput('disabled',true);
		}
	}   
	
  $('div').click(function() {
		  var divid=$(this).attr('id');  
		  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
			  var realid=divid.replace(/div/g, "");
			  if(realid=="delp" || realid=="pop" || realid=="comschp" || realid=="ldschp" || realid=="totp" || realid=="delc" || realid=="poc" || realid=="comschc" || realid=="ldschc" || realid=="totc"){     
				  $("#jqxServiceScheduleGrid").jqxGrid('clear');  
				  $('#hidrowno').val(""); 
				  $('.textpanel p').text(''); 
				  document.getElementById("divname").value=realid;   
				  $('.card-container').removeClass('cardactive');      
		          $("#"+realid+"id").addClass('cardactive');     
				  loads();
				  console.log("IN DIV");
				  $(".actionpanel").show();
			  }
		      
			  if(realid=="delp" || realid=="delc"){   
				  document.getElementById('selecteddiv').innerHTML=" - DELIVERY";
			  }else if(realid=="pop" || realid=="poc"){
				  document.getElementById('selecteddiv').innerHTML=" - PULLOUT";  
			  }else if(realid=="comschp" || realid=="comschc"){
				  document.getElementById('selecteddiv').innerHTML=" - COMP SCH";
			  }else if(realid=="ldschp" || realid=="ldschc"){
				  document.getElementById('selecteddiv').innerHTML=" - LOADER SCHEDULE";  
			  }else if(realid=="totp" || realid=="totc"){
				  document.getElementById('selecteddiv').innerHTML=" - TOTAL";       
			  }else{}  
			  
			  if(realid=="delp" || realid=="delc" || realid=="totp" || realid=="totc"){    
				  $(".actionpanel").hide();
			  }
			  
		  }
	  });
  
	function getCountData(){  
		var divname=$('#divname').val();
		var fromdate=$('#fromdate').jqxDateTimeInput('val');         
		var todate=$('#todate').jqxDateTimeInput('val');  
		var routeid = $("#cmbroute").val();   
		var frmdtchk = 0;
		var clientname =  $("#cmbrefname").find('option:selected').text().split("-");
		var cldocno =clientname[0].trim()
		if(document.getElementById('fromdatechk').checked){
		    	frmdtchk = 1;  
		}else{
		    	frmdtchk = 0; 
		}
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items = x.responseText; 
				var guagedata=JSON.parse(items);               
				$("#delp").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.delpcount);
	        	$("#pop").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.popcount);  
	          	$("#comschp").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.comschpcount);	
	          	$("#ldschp").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.ldschpcount);
	        	$("#totp").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.totpcount); 
	        	
	        	$("#delc").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.delccount);
	        	$("#poc").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.poccount);  
	          	$("#comschc").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.comschccount);	
	          	$("#ldschc").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.ldschccount);
	        	$("#totc").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.totccount); 
			}        
			else   
			{
			}  
		}
		x.open("GET","getCountData.jsp?fromdate="+fromdate+"&todate="+todate+"&routeid="+routeid+"&cldocno="+cldocno+"&frmdtchk="+frmdtchk+"&divname="+divname,true);       
		x.send(); 
    }
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
