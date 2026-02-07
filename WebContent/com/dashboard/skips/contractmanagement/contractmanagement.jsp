<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Contract Management</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
  <style type="text/css"> 
	  .branch {
		color: black;
		background-color: #ECF8E0;
		width: 100%;
		font-family: Tahoma;
		font-size: 12px;
	}  
      .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 15px;
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
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
   .textpanel{
        color: blue;    
  		overflow:auto; 
  		width:360px;            
  		height:50px;                
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
  </style>
</head>       
<body onload="setValues();">         
<form id="frmContractManagement" action="saveSchedule" method="post" autocomplete="off">      
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
     <div class="todatepanel custompanel">
	      <table>
		      <tr> 
		      <td align="right"><input type="checkbox" id="datechk" name="datechk" onchange="funchangedate();">&nbsp;&nbsp;
		       <input type="hidden" name="hiddatechk" id="hiddatechk"></td>                          
		      <td align="right"><label class="branch" style="font-size: 13px">&nbsp;UpTo Date &nbsp;&nbsp;</label></td>    
		      <td align="left"><div id='todate' name='todate'></div></td></tr>                                          
		 </table>          
      </div>  
       <%--   <div class="primarypanel custompanel">    
               <label for="branch" class="branch">&nbsp;Branch</label>     
        </div>
        <div class="primarypanel custompanel">
               <select class="cmbbranch form-control input-sm" id="cmbbranch" name="cmbbranch" onchange="loads();getInitChartData();" value='<s:property value="cmbbranch"/>' style="width:140px;">
  					<option></option>     
				</select>
        </div> --%>            
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
        <div class="actionpanel custompanel1">                                  
	        <!--<button type="button" class="btn btn-default" id="btnupdate" data-toggle="tooltip"  title="Schedule Delivery" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btndelivery"  data-toggle="tooltip" title="Delivery & Location Update" data-placement="bottom"><i class="fa fa-bus "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnassignroute" data-toggle="tooltip"  title="Route Assign" data-placement="bottom"><i class="fa fa-road "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnschedule"  data-toggle="tooltip" title="Service Schedule" data-placement="bottom"><i class="fa fa-calendar-check-o "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnscheduleposting"  data-toggle="tooltip" title="Schedule Posting" data-placement="bottom"><i class="fa fa-pencil-square-o "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnservicehistory" data-toggle="tooltip"  title="Service History" data-placement="bottom"><i class="fa fa-history "  aria-hidden="true"></i></button>  -->      
	          <button type="button" class="btn btn-default" id="btncontdetailsupdate" data-toggle="tooltip"  title="Contract Details Update" data-placement="bottom"><i class="fa fa-pencil-square "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnstatusupdate" data-toggle="tooltip"  title="Status Update" data-placement="bottom"><i class="fa fa-file-text "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btncntrenewalreq" data-toggle="tooltip"  title="Contract Revise Request" data-placement="bottom"><i class="fa fa-plus-square "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnservicerequest" data-toggle="tooltip"  title="Service Request" data-placement="bottom"><i class="fa fa-pencil "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnpullout" data-toggle="tooltip" title="Pull Out" data-placement="bottom"><i class="fa fa-share "  aria-hidden="true"></i></button>
	          <button type="button" class="btn btn-default" id="btnskiphistory" data-toggle="tooltip"  title="Skip History" data-placement="bottom"><i class="fa fa-history "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnhold" data-toggle="tooltip"  title="Hold" data-placement="bottom"><i class="fa fa-sign-in "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnrelease" data-toggle="tooltip"  title="Release" data-placement="bottom"><i class="fa fa-sign-out "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnholdreleaselog" data-toggle="tooltip"  title="Hold/Release Log" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button> 
	          <button type="button" class="btn btn-default" id="btnclosejob" data-toggle="tooltip"  title="Terminated / Cancel job request" data-placement="bottom"><i class="fa fa-times-circle "  aria-hidden="true"></i></button>        
        </div>           
         <div class="warningpanel custompanel1">                   
             <button type="button" class="btn btn-default" id="btncontractview"><i class="fa fa-scribd" aria-hidden="true" data-toggle="tooltip"  title="View Service Contract" data-placement="bottom"></i></button>
	         <div class="btn-group" role="group">
	            <button type="button" class="btn btn-default" id="btnserreqcount" data-toggle="tooltip"  title="Service Requests" data-placement="bottom"><i class="fa fa-pencil " aria-hidden="true"></i></button>
	            <span class="badge badge-notify badge-serreq"></span>                                            
	          </div>       
	          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>  
        <div class="textpanel custompanel">
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>           
        </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>          
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
    <div id="modaldelivery" class="modal fade" role="dialog">   
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Delivery<span></span></h4>  <label for="otherdetails3" id="lblotherdetails3"></label>
          		</div>
          		<div class="modal-body">
          		   <div class="row">      
				      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">         
				        <div id="deliverydiv"><jsp:include page="deliveryGrid.jsp"></jsp:include></div>                     
				      </div>
				    </div>
  					<div class="row">  
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="GPS X">GPS X:</label>   
		        					<input type="text" id="txtgpsx" name="txtgpsx" class="form-control input-sm">  
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="GPS Y">GPS Y:</label>   
		        					<input type="text" id="txtgpsy" name="txtgpsy" class="form-control input-sm">    
	                     	    </div>  
		                   </div>  
  					</div>
  					<div class="row" id="delown">  
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Date">Date:</label>     
		        					<div id="deldate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Time">Time:</label>   
		        					<div id="deltime" style="border: 1px solid black" style="width:69%;"></div>      
	                     	    </div>  
		                   </div>	  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btndeliverysave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div> 
    <div id="modalroute" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Route Assign<span></span></h4>  <label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>
          		<div class="modal-body">
          		  <div class="row">      
				      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">         
				        <div id="routediv"><jsp:include page="routeGrid.jsp"></jsp:include></div>                      
				      </div>
				    </div>
            		<div class="form-horizontal class-pad5" >  
            			<div class="form-group">
    						<label class="control-label col-sm-3" for="route">Route:</label>  
    						<div class="col-sm-9 input-container">  
      							<input type="text" id="txtroute" name="txtroute" class="form-control input-sm" placeholder="press F3 to search" readonly  onKeyDown="getRoute();">       
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
    	<div class="modal-dialog modal-xl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Service Schedule<span></span></h4>  <label for="otherdetails" id="lblotherdetails"></label>   
          		</div>
          		<div class="modal-body"> 
  					<div class="row"> 
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
  					         <div class="form-inline">
  					            <label for="AlternateDays" class="col-sm-11 col-form-label">Alternate Days</label>
							    <div class="col-sm-1"> <input type="checkbox" id="alternativechk" name="alternativechk" onchange="funalternatecheck();"></div>
							  </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="Days">Days</label>   
		        					<select class="form-control select2" id="cmbdays" multiple="multiple" style="width:100%;" name="cmbdays"></select>   
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
		        				<div class="form-group">
		        					<label for="Date">Date</label>         
		        					<select class="form-control select2" id="cmbdates" multiple="multiple" style="width:100%;" name="cmbdates"></select>         
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">   
		        				<div class="form-group">
		        					<label for="Date">Start Date</label>     
		        					<div id="servdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
  					         <div class="form-inline" >
  					             <label for="preferredTime" class="col-sm-11 col-form-label">preferred Time</label> 
							    <div class="col-sm-1"> <input type="checkbox" id="preferredtimechk" name="preferredtimechk"></div>
							  </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
		        				<div class="form-group">
		        					<label for="Time">Time</label>   
		        					<div id="servtime" style="border: 1px solid black" style="width:69%;"></div>      
	                     	    </div>  
		                   </div>	
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
		                       <div style="padding-top:15px;">  
		        				 <button type="button" class="btn btn-default btn-primary" id="btnfill" onclick="funfill()">Fill</button>
		                       </div>
		                   </div>  
  					</div>
            		 <div class="row">      
				      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        <div id="schdiv"><jsp:include page="scheduleGrid.jsp"></jsp:include></div>          
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
   <div id="modalhold" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Hold<span></span></h4>  <label for="otherdetails5" id="lblotherdetails5"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">  
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Date:</label>     
		        					<div id="holddate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">  
		        				<div class="form-group">
		        					<label for="Reason">Reason:</label>   
		        					<input type="text" id="txtholdreason" name="txtholdreason" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnholdsave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
     <div id="modalrelease" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Release<span></span></h4>  <label for="otherdetails6" id="lblotherdetails6"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">  
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Date:</label>     
		        					<div id="releasedate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">  
		        				<div class="form-group">
		        					<label for="Reason">Reason:</label>   
		        					<input type="text" id="txtreleasereason" name="txtreleasereason" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnreleasesave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
<div id="modalservicerequest" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Service Request<span></span></h4>  <label for="otherdetails7" id="lblotherdetails7"></label>         
          		</div>
          		<div class="modal-body">
  					<div class="row"> 
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="type">Contract:</label>     
		        					<label for="type" id="contracttype"></label>         
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="type" id="sraction"></label>         
	                     	    </div>  
		                   </div>
		            </div>
		            <div class="row">        
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="type" id="sroldstatus"></label>         
	                     	    </div>  
		                   </div>
		           </div>
		           <div class="row">         
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="type" id="srnewstatus"></label>         
	                     	    </div>  
		                   </div>
		              </div>
		              <div class="row">      
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Date:</label>     
		        					<div id="entrydate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Time">Time:</label>     
		        					<div id="entrytime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div> 
		              </div>
		              <div class="row"> 
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Reason">Remarks:</label>     
		        					<input type="text" id="txtserreqremarks" name="txtserreqremarks" class="form-control input-sm">     
	                     	    </div>  
		                   </div>  
            		  </div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnservicerequestsave">Save Changes</button>      
          		</div>
        </div>
      </div>
    </div>       
   <div id="modalupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Schedule Delivery<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>   
          		</div>
          		<div class="modal-body">   
            		<div class="row">      
				      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">         
				        <div id="schedulediv"><jsp:include page="schdelGrid.jsp"></jsp:include></div>                   
				      </div>
				    </div>  
            		<div class="row"> 
            		       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="skip">Skip:</label>   
		        					<select class="form-control select2" name="cmbskip" id="cmbskip" style="width:100%;"></select> 
	                     	    </div>  
		                   </div> 
	            		  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Driver">Driver:</label>   
		        					<select class="form-control select2" name="cmbdriver" id="cmbdriver" style="width:100%;"></select> 
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Helper">Helper:</label>     
		        					<select class="form-control select2" name="cmbhelper" id="cmbhelper" style="width:100%;"></select>  
	                     	    </div>  
		                   </div>
  					</div>	
  					<div class="row"> 
  					   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Vehicle">Vehicle:</label>     
		        					<select class="form-control select2" name="cmbvehicle" id="cmbvehicle" style="width:100%;"></select>   
	                     	    </div>  
		                   </div> 
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="Date">Date:</label>     
		        					<div id="schdeldate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">    
		        				<div class="form-group">
		        					<label for="Time">Time:</label>   
		        					<div id="schdeltime" style="border: 1px solid black" style="width:69%;"></div>      
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Name">Name:</label>     
		        					<input type="text" id="txtname" name="txtname" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 	  
            		</div> 
            		<div class="row"> 
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Mobile">Mobile:</label>     
		        					<input type="text" id="txtmobile" name="txtmobile" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Email">Email:</label>     
		        					<input type="text" id="txtemail" name="txtemail" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="Day">Day Shift:</label>         
		        					<input type="text" id="txtdayshift" name="txtdayshift" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 	  
            		</div>
            		<div class="row"> 
            		       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Location">Location Map:</label>               
		        					<input type="text" id="txtlocmap" name="txtlocmap" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
            		</div>   
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnschdelsave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>   
    <div id="modalclosejob" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>    
            		<h4 class="modal-title">Terminated / Cancel job request<span></span></h4>  <label for="otherdetails8" id="lblotherdetails8"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">  
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Date:</label>     
		        					<div id="closedate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">  
		        				<div class="form-group">
		        					<label for="Reason">Reason:</label>   
		        					<input type="text" id="txtclosereason" name="txtclosereason" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnclosesave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
  <div id="modalcontdetailsupdate" class="modal fade" role="dialog">     
    	<div class="modal-dialog modal-xl">
        	<div class="modal-content">
          		<div class="modal-header">        
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Contract Details Update<span></span></h4>  <label for="otherdetails9" id="lblotherdetails9"></label>   
          		</div>
          		<div class="modal-body">     
  					  <div class="row"> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="cntclient">Client:</label>     
		        					<input type="text" id="cntclient" name="cntclient" class="form-control input-sm" readonly onKeyDown="getClient();" placeholder="Press F3 To Search">  
		        					<input type="hidden" name="hidcntcldocno" id="hidcntcldocno">              
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="cntcperson">Contact Person:</label>       
		        					<input type="text" id="cntcperson" name="cntcperson" class="form-control input-sm" readonly placeholder="Press F3 To Search" onKeyDown="getContact();">  
		        					<input type="hidden" name="hidcntcpersonid" id="hidcntcpersonid">                             
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="cntemail">Contact Email:</label>       
		        					<input type="text" id="cntemail" name="cntemail" class="form-control input-sm">    
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cntmobile">Mobile:</label>        
		        					<input type="text" id="cntmobile" name="cntmobile" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
            		</div> 
            		<div class="row"> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cntinvoicemail">Invoice Email:</label>     
		        					<input type="text" id="cntinvoicemail" name="cntinvoicemail" class="form-control input-sm">    
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="cntgrpcompany">Group Company:</label>           
		        					<input type="text" id="cntgrpcompany" name="cntgrpcompany" readonly class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cntrefno">Refno:</label>         
		        					<input type="text" id="cntrefno" name="cntrefno" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
            		       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cntsite">Site:</label>                  
		        					<input type="text" id="cntsite" name="cntsite" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
            		</div>
            		<div class="row"> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cntarea">Area:</label>                  
		        					<input type="text" id="cntarea" name="cntarea" class="form-control input-sm" readonly onKeyDown="getAreas();" placeholder="Press F3 To Search">
		        					<input type="hidden" name="hidcntareaid" id="hidcntareaid">        
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">    
		        				<div class="form-group">
		        					<label for="cntdesc">Description:</label>            
		        					<input type="text" id="cntdesc" name="cntdesc" class="form-control input-sm">    
	                     	    </div>  
		              </div> 
            		</div> 
            		<div class="row">
          		          <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cnttelephno">Telephone No:</label>                  
		        					<input type="text" id="cnttelephno" name="cnttelephno" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cntextn">Extension:</label>                  
		        					<input type="text" id="cntextn" name="cntextn" class="form-control input-sm">    
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">        
		        				<div class="form-group">
		        					<label for="cntdesg">Designation:</label>                        
		        					<input type="text" id="cntdesg" name="cntdesg" class="form-control input-sm" readonly onKeyDown="getDesigs();" placeholder="Press F3 To Search">
		        					<input type="hidden" name="hidcntdesgid" id="hidcntdesgid">           
	                     	    </div>  
		                   </div> 
          		    </div>  
          		</div>  
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>     
          			<button type="button" class="btn btn-default btn-primary" id="btncontdetailssave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>  
   <div id="modalcntrenewalreq" class="modal fade" role="dialog">  
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Contract Revise Request<span></span></h4>  <label for="otherdetails10" id="lblotherdetails10"></label>    
          		</div>
          		<div class="modal-body">   
  					<div class="row">  
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Date:</label>        
		        					<div id="renewalreqdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">With Effect Date:</label>           
		        					<div id="witheffectdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        				<div class="form-group">
		        					<label for="txtrequesteduser">Requested User:</label>   
		        					<input type="text" id="txtrequesteduser" name="txtrequesteduser" readonly class="form-control input-sm">   
	                     	    </div>  
		                   </div> 
		               </div>
		               <div class="row">     
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="txtrenewreqremarks">Remarks:</label>         
		        					<input type="text" id="txtrenewreqremarks" name="txtrenewreqremarks" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btncntrenewalreqsave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div> 
       <div id="modalstatusupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-sm">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Status Update<span></span></h4>  <label for="otherdetails11" id="lblotherdetails11"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row">  
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="cmbstatus">Status:</label>     
		        					<select class="form-control select2" name="cmbstatus" id="cmbstatus" style="width:100%;">
		        					<option value="1">Entered</option><option value="2">Emailed</option><option value="3">Acknowledgement done</option><option value="4">Final invoice raise</option><option value="5">Account approved</option></select>   
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
    <div id="modalpullout" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>     
            		<h4 class="modal-title">Pull out<span></span></h4>  <label for="otherdetails12" id="lblotherdetails12"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="cldate">Request Date:</label>        
		        					<div id="cldate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
		        				<div class="form-group">  
		        					<label for="cltime">Request Time:</label>             
		        					<div id="cltime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="slno">Delivery</label>                     
		        					<select class="form-control select2" id="cmbslnopo" style="width:100%;" name="cmbslnopo" value='<s:property value="cmbslnopo"/>' onchange="funLoadSkip(1);"></select>                
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="podate">Date:</label>        
		        					<div id="podate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">     
		        				<div class="form-group">
		        					<label for="potime">Time:</label>          
		        					<div id="potime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                 </div>  
		            </div>  
		            <div class="row"> 
		                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">        
		        				<div class="form-group">
		        					<label for="poskipno">Skip No:</label>     
		        					<div id="skipnodiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipnoSearch.jsp"></jsp:include></div>
                                    <input type="hidden" id="poskipno" name="poskipno"/>             
	                     	    </div>  
		                 </div> 
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">        
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
    <div id="modalskiphistory" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">  
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Skip History<span></span></h4>  <label for="otherdetails13" id="lblotherdetails13"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row">  
  					      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">         
				            <div id="skipdiv"><jsp:include page="skipHistoryGrid.jsp"></jsp:include></div>                      
				         </div>    
		               </div>
          		</div>
          		<div class="modal-footer">   
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          		</div>
        </div>
      </div>
    </div>
   <div id="modalholdreleaselog" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">  
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Hold/Release Log<span></span></h4>  <label for="otherdetails14" id="lblotherdetails14"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row">  
  					      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">           
				            <div id="hrldiv"><jsp:include page="holdreleaselogGrid.jsp"></jsp:include></div>                      
				         </div>    
		               </div>
          		</div>
          		<div class="modal-footer">   
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          		</div>
        </div>
      </div>
    </div>
  <input type="hidden" name="hidskiptype" id="hidskiptype">  
  <input type="hidden" name="hidsrdocno" id="hidsrdocno">   
  <input type="hidden" name="hidcontrno" id="hidcontrno" value='<s:property value="hidcontrno"/>'>    
  <input type="hidden" name="hidbrhid" id="hidbrhid" value='<s:property value="hidbrhid"/>'>  
  <input type="hidden" name="hidrowno" id="hidrowno"> 
  <input type="hidden" name="hiddocno" id="hiddocno">   
  <input type="hidden" name="divname" id="divname">       
  <input type="hidden" name="hidcomments" id="hidcomments">  
  <input type="hidden" name="lblname" id="lblname">
  <input type="hidden" name="hidserviceterm" id="hidserviceterm">  
  <input type="hidden" name="hidnoofvisit" id="hidnoofvisit">   
  <input type="hidden" name="hidenddt" id="hidenddt">    
  <input type="hidden" name="hidstatusid" id="hidstatusid">  
  <input type="hidden" name="hidrouteid" id="hidrouteid">    
  <input type="hidden" name="hiddelid" id="hiddelid"> 
  <input type="hidden" name="hidownership" id="hidownership"> 
  <input type="hidden" name="schgridlength" id="schgridlength" value='<s:property value="schgridlength"/>'>   
  <input type="hidden" name="hidsrno" id="hidsrno" value='<s:property value="hidsrno"/>'>     
  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>        
  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>    
  <input type="hidden" name="hidskipid" id="hidskipid">  
  <input type="hidden" name="hidstartdt" id="hidstartdt">  
  <input type="hidden" name="hidposkipno" id="hidposkipno">  
  <input type="hidden" name="hidposkipsize" id="hidposkipsize"> 
  <input type="hidden" name="hidtype" id="hidtype">  
  <input type="hidden" name="lblnamesrf" id="lblnamesrf">    
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){
    	$("#btnclosejob").hide();     
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();
    	$('#desginfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Designation Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	$('#desginfowindow').jqxWindow('close');  
    	$('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	$('#areainfowindow').jqxWindow('close');           
    	$('#cpinfowindow').jqxWindow({ width: '35%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#cpinfowindow').jqxWindow('close');   
    	$('#clientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
        $('#clientsearch').jqxWindow('close');
	    $('#skipinfowindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '60%' , title: 'Skip Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#skipinfowindow').jqxWindow('close');
	    $('#routeinfoWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Route Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#routeinfoWindow').jqxWindow('close');
	    $("#witheffectdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    $("#podate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    $("#potime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
	    $("#cldate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    $("#cltime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
	    $("#renewalreqdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    $("#deldate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
    	$("#deltime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
    	$("#schdeldate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
     	$("#schdeltime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
      	$("#servdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
      	$("#servtime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
        $("#holddate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
        $("#releasedate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
        $("#closedate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
        $("#entrydate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
        $("#entrytime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
        $('#entrydate').jqxDateTimeInput('setDate', new Date()); 
	    $('#entrytime').jqxDateTimeInput('setDate', new Date()); 
        $('#closedate').jqxDateTimeInput('setDate', new Date());    
        $('#deldate').jqxDateTimeInput('setDate', new Date()); 
        $('#deltime').jqxDateTimeInput('setDate', new Date());
        $('#schdeldate').jqxDateTimeInput('setDate', new Date()); 
        $('#schdeltime').jqxDateTimeInput('setDate', new Date());  
        $('#servdate').jqxDateTimeInput('setDate', new Date()); 
        $('#servtime').jqxDateTimeInput('setDate', new Date());  
        $('#releasedate').jqxDateTimeInput('setDate', new Date()); 
        $('#holddate').jqxDateTimeInput('setDate', new Date());
        $("#todate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy"});      
	   /*  $("#date").jqxDateTimeInput({ width: '100px', height: '21px',formatString:"dd.MM.yyyy"});  
		$("#fromdate").jqxDateTimeInput({ width: '100px', height: '21px',formatString:"dd.MM.yyyy"});     
	    $("#todate").jqxDateTimeInput({ width: '100px', height: '21px',formatString:"dd.MM.yyyy"});
    	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
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
	    });       
	    $('#fromdate').jqxDateTimeInput("disabled",true);*/
    	//inputload();
	    
	    $('#btnrelease').attr('disabled',true); 
	    
	    $('#btnserreqcount').click(function(){                  
	    	serreqloads();
        });
	    funchangedate();getDays();getDates();getDriver();getHelper();getVehicle();getDeliveriesPO();
	    $('#cntdesg').dblclick(function(){     
		      $('#desginfowindow').jqxWindow('open');        
		      desgSearchContent('desgSearch.jsp?', $('#desginfowindow'));   
	    });
	    $('#cntarea').dblclick(function(){     
		      $('#areainfowindow').jqxWindow('open');     
		      areaSearchContent('areaSearch.jsp?', $('#areainfowindow'));   
	    });  
	    $('#cntclient').dblclick(function(){  
		      $('#clientsearch').jqxWindow('open');     
		 	  clientSearchContent('clientsearch.jsp?', $('#clientsearch'));
	    });
	    $('#cntcperson').dblclick(function(){      
	    	  var cldocno=document.getElementById("hidcntcldocno").value;    
		      $('#cpinfowindow').jqxWindow('open');  
		      contactSearchContent('Searchcontact.jsp?cldocno='+cldocno, $('#cpinfowindow'));           
	    });
	    getCountData();
	    $('#btnpulloutsave').click(function(){             
	    	funUpdate(13);     
        });
	    $('#btncntrenewalreqsave').click(function(){          
	    	funUpdate(12);     
        });
	    $('#btnstatussave').click(function(){       
	    	funUpdate(11);     
        });
	    $('#btncontdetailssave').click(function(){       
	    	funUpdate(10);     
        });
	    $('#btnservicerequestsave').click(function(){    
	    	funUpdate(8);  
        });
	    $('#btnholdreleaselog').click(function(){
	    	var enqno=$('#hidrowno').val();  
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	        document.getElementById("lblotherdetails14").innerHTML=$("#lblname").val();    
	    	$('#hrldiv').load('holdreleaselogGrid.jsp?rdocno='+$('#hidcontrno').val()+'&srno='+$('#hidsrno').val()+'&id=1');    
	    	$("#modalholdreleaselog").modal('toggle');                                       
        });
	    $('#btnskiphistory').click(function(){
	    	var enqno=$('#hidrowno').val();  
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	        document.getElementById("lblotherdetails13").innerHTML=$("#lblname").val();    
	    	$('#skipdiv').load('skipHistoryGrid.jsp?rdocno='+$('#hidcontrno').val()+'&srno='+$('#hidsrno').val()+'&delid='+$('#hiddelid').val()+'&id=1');    
	    	$("#modalskiphistory").modal('toggle');                                     
        });
	    $('#btnpullout').click(function(){          
	    	clearfields();      
        	var enqno=$('#hidrowno').val();  
        	var delid=$('#hiddelid').val();  
        	var statusid=$('#hidstatusid').val(); 
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	        if(parseInt(statusid)<2){        
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Delivery is not updated!'       
				});
	    		return false;
	    	}
	    	//document.getElementById("poskipno").value=$("#hidposkipno").val(); 
	    	//document.getElementById("jqxSkipsize").value=$("#hidposkipsize").val();     
	    	document.getElementById("lblotherdetails12").innerHTML=$("#lblname").val();  
	    	$("#modalpullout").modal('toggle');                         
        });
	    $('#btnstatusupdate').click(function(){          
	    	clearfields();      
        	var enqno=$('#hidrowno').val();  
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}   
	    	document.getElementById("lblotherdetails11").innerHTML=$("#lblname").val();
	    	$("#modalstatusupdate").modal('toggle');                         
        });
	    $('#btncntrenewalreq').click(function(){          
	    	clearfields();      
        	var enqno=$('#hidrowno').val();  
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	        var user='<%= session.getAttribute("USERNAME") %>'
	        $("#txtrequesteduser").val(user);           
	    	document.getElementById("lblotherdetails10").innerHTML=$("#lblname").val();
	    	contractRevise();                          
        });
	    $('#btncontdetailsupdate').click(function(){          
	    	clearfields();      
        	var enqno=$('#hidrowno').val();  
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}   
	    	document.getElementById("lblotherdetails9").innerHTML=$("#lblname").val();
	    	$("#modalcontdetailsupdate").modal('toggle');                         
        });
	    $('#btnupdate').click(function(){ 
	    	clearfields();      
        	var enqno=$('#hidrowno').val();  
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}   
	        getSkips();
	    	document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val();
	    	$('#schedulediv').load('schdelGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=2');       
	    	$("#modalupdate").modal('toggle');                       
        });
	    $('#btnscheduleposting').click(function(){              
        	var rowno=$('#hidrowno').val(); 
        	var contrno=$('#hidcontrno').val(); 
        	var srno=$('#hidsrno').val(); 
	    	if(rowno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;  
	    	}
	    	funpostingvalidate(rowno,contrno,srno);  
        });
	    $('#btnservicerequest').click(function(){              
        	var enqno=$('#hidrowno').val();  
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	/* var srdocno=$('#hidsrdocno').val();  
	    	if(parseInt(srdocno)>0){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Service request already created.'     
				});
	    		return false;
	    	} */  
	    	var type = $("#hidtype").val();
		    if(type=="NOTAPPR"){  
		    		Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Contract is not approved!'     
					});
		    		return false;
		    }
		    if(type=="EXP"){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Contract is expired!'      
				});
	    		return false;
	        }
		    if(type=="CLD"){    
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Contract is closed!'     
				});
	    		return false;
	        }
	    	document.getElementById("lblotherdetails7").innerHTML=$("#lblnamesrf").val();  
	    	$("#modalservicerequest").modal('toggle');                    
        });
	    $('#txtroute').dblclick(function(){  
	    	$('#routeinfoWindow').jqxWindow('open');
	    	routeSearchContent('routesearch.jsp?', $('#routeinfoWindow')); 
	       });
        $('#btnsubmit').click(function(){    
        	clearfields();      
            loads(); 
            getCountData();
            $('.textpanel p').text(''); 
        	document.getElementById("hiddocno").value="";   
        	document.getElementById("hidrowno").value="";
        });
        $('#btncontractview').click(function(){    
	         var contrno=$('#hidrowno').val();    
	         if(contrno=="" || contrno=="0"){  
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document!'      
					});
	        		return false;
	         }
	         viewContract();                  
		});
        $('#btnhold').click(function(){           
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	document.getElementById("lblotherdetails5").innerHTML=$("#lblname").val();
	    	$("#modalhold").modal('toggle');        
        });
        $('#btnrelease').click(function(){           
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	document.getElementById("lblotherdetails6").innerHTML=$("#lblname").val();
	    	$("#modalrelease").modal('toggle');          
        });
        $('#btnclosejob').click(function(){           
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	document.getElementById("lblotherdetails8").innerHTML=$("#lblname").val();
	    	$("#modalclosejob").modal('toggle');           
        });
        $('#btnassign').click(function(){           
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val();
	    	$('#quotdetdiv').load('quotdetGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=1');          
	    	$("#modalassign").modal('toggle');      
        });
        $('#btnschdel').click(function(){                  
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	} 
	    	var statusid=$('#hidstatusid').val();  
	    	if(parseInt(statusid)<1){             
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Skip not assigned'     
				});
	    		return false;
	    	}  
	    	document.getElementById("lblotherdetails2").innerHTML=$("#lblname").val();
	    	$('#schedulediv').load('schdelGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=2');   
	    	$("#modalschdel").modal('toggle');      
        });
        $('#btnassignroute').click(function(){
        	clearfields();    
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	var statusid=$('#hidstatusid').val();  
	    	var ownership=$('#hidownership').val();
	    	if(ownership=="OWN SKIP"){
		    	if(parseInt(statusid)<1){             
		    		Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Skip not assigned'     
					});
		    		return false;  
		    	}
	    	}else{
	    		if(parseInt(statusid)<3){                    
		    		Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Delivery not updated'       
					});
		    		return false;
		    	}
	    	}    
	    	document.getElementById("lblotherdetails4").innerHTML=$("#lblname").val();  
	    	$('#routediv').load('routeGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=4');    
	    	$("#modalroute").modal('toggle');      
        });
        $('#btndeliverysave').click(function(){          
        	funUpdate(1);  
        });
        $('#btnschedulesave').click(function(){          
        	funUpdate(2);  
        });
        $('#btnclosesave').click(function(){ 
        	var startdt = $("#hidstartdt").val();     
        	var stdt = new Date(startdt);
        	var closedt = $("#closedate").jqxDateTimeInput('getDate');
        	if(closedt<stdt){
        		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Close date should not be less than contract start date'     
				});
	    		return false;
        	}else{
        		funUpdate(9);    
        	}
        });
        $('#btndelivery').click(function(){  
        	clearfields();      
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	var statusid=$('#hidstatusid').val();   
	    	var ownership=$('#hidownership').val();
	    	if(ownership=="OWN SKIP"){
		    	if(parseInt(statusid)<1){               
		    		Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Skip not assigned'     
					});
		    		return false;
		    	}
	    	}    
	    	document.getElementById("lblotherdetails3").innerHTML=$("#lblname").val(); 
	    	var ownership=$('#hidownership').val();
	    	if(ownership=="OWN SKIP"){  
	    		$('#deliverydiv').show(); 
	    		$('#deliverydiv').load('deliveryGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=3');       
	    		$('#delown').show(); 
	    	}else{
	    		$('#deliverydiv').hide();    
	    		$('#delown').hide(); 
	    	}
	    	       
	    	$("#modaldelivery").modal('toggle');
        });
        $('#btnschedule').click(function(){          
        	var enqno=$('#hidrowno').val(); 
	    	if(enqno==""){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}         
	    	$("#jqxScheduleGrid").jqxGrid('clear');     
	    	var statusid=$('#hidstatusid').val(); 
	    	$("#modalschedule").modal('toggle');      
        });
        $('#btnassignsave').click(function(){            
        	funUpdate(3);       
        });
        $('#btnschdelsave').click(function(){            
        	funUpdate(4);       
        });
        $('#btnroutesave').click(function(){            
        	funUpdate(5);         
        });
        $('#btnholdsave').click(function(){            
        	funUpdate(6);       
        });
        $('#btnreleasesave').click(function(){              
        	funUpdate(7);        
        });
        $('#btncomment').click(function(){    
	        var enqno=$('#hidrowno').val();
	    	if(enqno==""){
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
        	$("#contractdiv").excelexportjs({ 
        		containerid: "contractdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxContractGrid",   
        		columns: getColumns("jqxContractGrid") ,   
        		worksheetName:"Contract Management"  
         		});
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
        		$('#jqxContractGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
	function getDesigs(){  
	   	 var x= event.keyCode;
	   	 if(x==114){
		    	  $('#desginfowindow').jqxWindow('open');
		    	  desgSearchContent('desgSearch.jsp?', $('#desginfowindow'));    
	   	  }else{       
	   	  } 
	}   
	function desgSearchContent(url) {    
	         $.get(url).done(function (data) {
		           $('#desginfowindow').jqxWindow('setContent', data);
	     	  }); 
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
			    	  $('#cpinfowindow').jqxWindow('open');
			    	  contactSearchContent('Searchcontact.jsp?cldocno='+cldocno, $('#cpinfowindow'));          
		    	  }else{       
		    	  }     
		      
	}   
	function contactSearchContent(url) { 
		          $.get(url).done(function (data) {
			           $('#cpinfowindow').jqxWindow('setContent', data);
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
    	$("#jqxContractGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxContractGrid").jqxGrid('applyfilters');    
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
   
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var datechk = $('#hiddatechk').val();   
	    var todate = $('#todate').jqxDateTimeInput('val'); 
	    console.log(todate);    
	    $('#contractdiv').load('contractGrid.jsp?todate='+todate+'&datechk='+datechk+'&id=1');           
    }   
    function serreqloads(){   
	    $("#overlay, #PleaseWait").show();
	    var datechk = $('#hiddatechk').val();   
	    var todate = $('#todate').jqxDateTimeInput('val'); 
	    console.log(todate);  
	    $('#contractdiv').load('contractGrid.jsp?todate='+todate+'&datechk='+datechk+'&id=2');              
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
	function getSkips() {
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
				$('#cmbskip').html($.parseHTML(optionsbranch));
				var skipid=$("#hidskipid").val();    
				if(skipid!='' && skipid!=null){         
					 $("#cmbskip").val(skipid).trigger('change');     
				}  
	  			$('#cmbskip').select2({
	  				placeholder:"Please select a Skip",  
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getSkips.jsp?skiptype="+$("#hidskiptype").val()+"&skipid="+$("#hidskipid").val(), true);       
		x.send();
	}
	function getDays() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="8" selected>All</option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbdays').html($.parseHTML(optionsbranch));
	  			$('#cmbdays').select2({
	  				placeholder:"Please select a Day",    
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getDays.jsp", true);  
		x.send();
	}
	function getDates() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {   
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="0" selected>All</option>';   
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbdates').html($.parseHTML(optionsbranch));  
	  			$('#cmbdates').select2({
	  				placeholder:"Please select a Date",    
	  				allowClear:true 
	  			});
			} else {}
		}
		x.open("GET","getDates.jsp", true);  
		x.send();
	}
	
	function funUpdate(chkevent){   
		var processid="";
		var rowno = $('#hidrowno').val();
		var brhid= $("#hidbrhid").val();
		var delid = $('#hiddelid').val();
		if(parseInt(chkevent)==1){	
			var deldate= $('#deldate').val(); 
			var gpsx= $('#txtgpsx').val();
			var gpsy= $('#txtgpsy').val();
			var deltime= $('#deltime').val(); 
			var ownership= $('#hidownership').val();
			processid="Delivery"; 
			if(ownership=="OWN SKIP"){     
				if(delid=='' || delid=="0"){  
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Skip is not assigned!!!'    
						});
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
						funchanges(processid,rowno,delid,gpsx,gpsy,deldate,deltime,brhid,ownership);  
					}else{
					}
			});
		}else if(parseInt(chkevent)==2){   	
			 var schlength=0,val=0; 
		 	 var rows = $("#jqxScheduleGrid").jqxGrid('getrows');   
			 for(var i=0 ; i < rows.length ; i++){  
				 var chk=$('#jqxScheduleGrid').jqxGrid('getcellvalue',i,'date');  
				 if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					    newTextBox = $(document.createElement("input"))   
					       .attr("type", "dil")
					       .attr("id", "contrtest"+i)
					       .attr("name", "contrtest"+i)
					       .attr("hidden", "true"); 
					    newTextBox.val(rows[i].date+"::"+rows[i].time+"::"+rows[i].day+" :: ");  
					    newTextBox.appendTo('form');  
					    schlength++;
					    val++;  
				   }	   
			   }
			$('#schgridlength').val(schlength);
			$('#mode').val("SCH");  
			if(val==0){
				swal.fire({  
					icon: 'warning',
					title: 'Warning',
					text:  'Please fill data first!!!' 
				});
  		        return false;
			} 
			processid="Schedule";          
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
						document.getElementById("frmContractManagement").submit();     
					}else{
					}
			});
		}else if(parseInt(chkevent)==3){ 
			 var gridarray=new Array();
			 var rows=$('#jqxquotdetGrid').jqxGrid('getrows');
			 var val=0;
			 for(var i=0;i<rows.length;i++){
			    var chk=$('#jqxquotdetGrid').jqxGrid('getcellvalue',i,'skipid');
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					 gridarray.push(rows[i].skipid+"::"+rows[i].rowno);      
					 val++;
				 }
			}
			if(val==0){
				swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a skip!!!' 
				});
  		      return false;
			} 
			processid="Skip";          
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
						funskipchanges(processid,rowno,brhid,gridarray);    
					}else{
					}
			});
		}else if(parseInt(chkevent)==4){    	
			var deldate= $('#schdeldate').val();
			var deltime= $('#schdeltime').val(); 
			var driverid= $('#cmbdriver').val();
			var helperid= $('#cmbhelper').val();  
			var vehicleid= $('#cmbvehicle').val(); 
			var skipid= $('#cmbskip').val();   
			var name= $('#txtname').val(); 
			var mobile= $('#txtmobile').val(); 
			var email= $('#txtemail').val(); 
			var dayshift= $('#txtdayshift').val(); 
			var locmap= $('#txtlocmap').val(); 
			processid="Schedule Delivery";  
			console.log("delid="+delid);
			if(delid==''){       
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please select a document!!!'       
					});
	  		      return false;
			 }      
			if(skipid==''){  
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please select a skip!!!'     
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
						funschdelchanges(processid, rowno, delid, deldate, deltime, driverid, helperid, brhid, vehicleid, skipid, name, mobile, email, dayshift, locmap);  
					}else{
					}
			});
		}else if(parseInt(chkevent)==5){  	
			var routeid= $('#hidrouteid').val(); 
			processid="Route";  
			if(delid=='' || delid=="0"){       
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Skip is not assigned!!!'        
					});
	  		      return false;
			 }
			if(routeid==''){
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please select a route!!!'    
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
						funroutechanges(processid,rowno,delid,routeid,brhid);      
					}else{
					}
			});
		}else if(parseInt(chkevent)==6){  	
			var holddate = $('#holddate').val();  
			var reason= $('#txtholdreason').val();
			processid="Hold";         
			if(reason==''){
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please enter a reason!!!'    
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
						funholdreleasesave(processid,rowno,holddate,reason,brhid);      
					}else{
					}
			});
		}else if(parseInt(chkevent)==7){  	
			var releasedate = $('#releasedate').val();  
			var reason= $('#txtreleasereason').val(); 
			processid="Release";         
			if(reason==''){
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please enter a reason!!!'    
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
						funholdreleasesave(processid,rowno,releasedate,reason,brhid);      
					}else{
					}
			});
		}else if(parseInt(chkevent)==8){  	  
			var reason= $('#txtserreqremarks').val();   
			var entrydate = $('#entrydate').val();  
			var entrytime = $('#entrytime').val(); 
			var type = $('#hidtype').val();
			processid="Service Request";           
			if(reason==''){
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
						funserreqsave(processid, rowno, reason, brhid, entrydate, entrytime, type);   
					}else{
					}
			});
		}else if(parseInt(chkevent)==9){  	
			var closedate = $('#closedate').val();  
			var reason= $('#txtclosereason').val(); 
			processid="Close Job";           
			if(reason==''){
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please enter a reason!!!'    
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
						funholdreleasesave(processid,rowno,closedate,reason,brhid);        
					}else{
					}
			});
		}else if(parseInt(chkevent)==10){    	
			var cntcldocno = $('#hidcntcldocno').val();
			var cntcperson = $('#cntcperson').val();
			var cntcpersonid = $('#hidcntcpersonid').val();
			var cntemail = $('#cntemail').val();
			var cntmobile = $('#cntmobile').val();
			var cntinvoicemail = $('#cntinvoicemail').val();
			var cntrefno = $('#cntrefno').val();
			var cntsite = $('#cntsite').val();
			var cntareaid = $('#hidcntareaid').val(); 
			var cntdesc = $('#cntdesc').val();
			var cntdesgid = $('#hidcntdesgid').val();
			var cnttelephno = $('#cnttelephno').val();
			var cntextn = $('#cntextn').val();
			processid="Contract Update";              
			if(cntcldocno==''){
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please select a client!!!'       
					});
	  		      return false;
			 }  
			if(cntsite==''){   
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please enter a site!!!'       
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
						funcntdetailssave(processid,rowno,cntcldocno,cntcperson,cntcpersonid,cntemail,cntmobile,cntinvoicemail,cntrefno,cntsite,cntareaid,brhid,cntdesc,cntdesgid,cnttelephno,cntextn);          
					}else{
					}
			});
		}else if(parseInt(chkevent)==11){      	
			var statusid= $('#cmbstatus').val();       
			processid="Status Update";             
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
						funstatussave(processid,statusid,brhid);            
					}else{
					}
			});
		}else if(parseInt(chkevent)==12){  
			var witheffectdate= $('#witheffectdate').val();
			var renewalreqdate= $('#renewalreqdate').val();
			var requesteduser= $('#txtrequesteduser').val();   
			var renewreqremarks= $('#txtrenewreqremarks').val();          
			processid="Renewal Request";                
			if(renewreqremarks==''){   
				 swal.fire({  
					 icon: 'warning',
						title: 'Warning',
						text: 'Please enter a remarks!!!'         
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
						funrenewalrequestsave(processid,renewalreqdate,requesteduser,renewreqremarks,brhid,witheffectdate);                
					}else{
					}
			});
		}else if(parseInt(chkevent)==13){            	
			var poskipno= $('#poskipno').val();
			var podate= $('#podate').val(); 
			var delsrno= $('#cmbslnopo').val();  
			var potime= $('#potime').val(); 
			var poremarks= $('#poremarks').val(); 
			var cldate= $('#cldate').val(); 
			var cltime= $('#cltime').val();       
			processid="Pull Out";                
			if(poskipno==''){  
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter a Skip No!!!'       
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
						funpulloutsave(processid, poskipno, podate, brhid, delid, delsrno, potime, poremarks, cldate, cltime);                     
					}else{
					}
			});
		}else{}     
	}
	function funpulloutsave(processid, poskipno, podate, brhid, delid, delsrno, potime, poremarks, cldate, cltime){                 
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
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&cldate="+cldate+"&cltime="+cltime+"&potime="+potime+"&poremarks="+encodeURIComponent(poremarks)+"&delsrno="+delsrno+"&delid="+delid+"&brhid="+brhid+"&poskipno="+poskipno+"&podate="+podate+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);
		x.send();               
	}
	function funrenewalrequestsave(processid,renewalreqdate,requesteduser,renewreqremarks,brhid,witheffectdate){   
		renewreqremarks = removeSplCharacters(renewreqremarks);
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
								 $("#modalcntrenewalreq").modal('toggle');       
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}  
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&requesteduser="+encodeURIComponent(requesteduser)+"&renewreqremarks="+encodeURIComponent(renewreqremarks)+"&renewalreqdate="+renewalreqdate+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val()+"&holddate="+witheffectdate,true);
		x.send();             
	}
	function funstatussave(processid,statusid,brhid){      
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
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&statusid="+statusid+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);
		x.send();        
	}
	function funcntdetailssave(processid,rowno,cntcldocno,cntcperson,cntcpersonid,cntemail,cntmobile,cntinvoicemail,cntrefno,cntsite,cntareaid,brhid,cntdesc,cntdesgid,cnttelephno,cntextn){    
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
								 $("#modalcontdetailsupdate").modal('toggle');    
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}
			
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&cldocno="+cntcldocno+"&reason="+encodeURIComponent(cntdesc)+"&cperson="+encodeURIComponent(cntcperson)+"&email="+encodeURIComponent(cntemail)+"&mobile="+cntmobile+"&cpersonid="+cntcpersonid+"&invoicemail="+encodeURIComponent(cntinvoicemail)+"&refno="+encodeURIComponent(cntrefno)+"&site="+encodeURIComponent(cntsite)+"&areaid="+cntareaid+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val()+"&cntdesgid="+cntdesgid+"&cntextn="+encodeURIComponent(cntextn)+"&cnttelephno="+cnttelephno,true);
		x.send();        
	}
	function funchanges(processid,rowno,delid,gpsx,gpsy,deldate,deltime,brhid,ownership){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						    loads();
						    clearfields();
							if(processid=="Delivery"){
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $('#hidstatusid').val(items);      
								 var ownership=$('#hidownership').val();
							     if(ownership=="OWN SKIP"){     
							    		$('#deliverydiv').load('deliveryGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=3');  
							     }else{
							    	 $("#modaldelivery").modal('toggle');       
							     }     
							}
						}else{
							if(processid=="Delivery"){
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
							}
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&delid="+delid+"&gpsx="+encodeURIComponent(gpsx)+"&gpsy="+encodeURIComponent(gpsy)+"&deldate="+deldate+"&deltime="+deltime+"&ownership="+encodeURIComponent(ownership)+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);      
	x.send();      
	}
	function funfill(){  
		var alternatedays=0;
		if(document.getElementById("alternativechk").checked){
			 alternatedays=1;
		}
		var startdate=$("#servdate").val();  
		var enddate=$("#hidenddt").val();
		var days=$("#cmbdays").val();
		console.log("days="+days);  
		var time="00:00";
		var daynos=$("#cmbdates").val();         
		if(document.getElementById("preferredtimechk").checked){
			time=$("#servtime").val();  
		}
		var noofvisit=$("#hidnoofvisit").val();
		var serviceterm=$("#hidserviceterm").val();  
	  	$("#schdiv").load("scheduleGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&alternatedays="+alternatedays+"&days="+encodeURIComponent(days)+"&daynos="+encodeURIComponent(daynos)+"&time="+time+"&noofvisit="+noofvisit+"&serviceterm="+encodeURIComponent(serviceterm)+"&id=1"); 
	}
	function funschedulechanges1(processid,rowno,brhid,gridarray){         
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						    loads(); 
							if(processid=="Schedule"){
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalschedule").modal('toggle');  
							}
						}else{
							if(processid=="Schedule"){
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
							}
						} 
				}
		}
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&gridarray="+encodeURIComponent(gridarray)+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);        
	x.send();      
	}
	function funskipchanges(processid,rowno,brhid,gridarray){         
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						    loads();   
							if(processid=="Skip"){
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalassign").modal('toggle');    
							}
						}else{
							if(processid=="Skip"){
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
							}
						} 
				}
		}
	    x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&gridarray="+encodeURIComponent(gridarray)+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);                 
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
	function funschdelchanges(processid, rowno, delid, deldate, deltime, driverid, helperid, brhid, vehicleid, skipid, name, mobile, email, dayshift, locmap){      
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){  
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						    loads();
						    clearfields();
						    $('#hidstatusid').val(1);     
							if(processid=="Schedule Delivery"){
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 //$("#modalupdate").modal('toggle');    
								 $('#schedulediv').load('schdelGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=2');
							}
						}else{
							if(processid=="Schedule Delivery"){  
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
							}
						} 
				}
		} 
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&delid="+delid+"&deldate="+deldate
			+"&deltime="+deltime+"&driverid="+driverid+"&helperid="+helperid+"&vehicleid="+vehicleid+"&skipid="+skipid+"&srno="+$("#hidsrno").val()
			+"&contrno="+$("#hidcontrno").val()+"&name="+encodeURIComponent(name)+"&mobile="+encodeURIComponent(mobile)+"&email="+encodeURIComponent(email)+"&dayshift="+encodeURIComponent(dayshift)+"&locmap="+encodeURIComponent(locmap),true);        
	x.send();      
	}
	function funroutechanges(processid,rowno,delid,routeid,brhid){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						    loads(); 
						    clearfields();     
							if(processid=="Route"){
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 //$("#modalroute").modal('toggle');  
								 $('#routediv').load('routeGrid.jsp?rdocno='+$("#hidcontrno").val()+"&srno="+$("#hidsrno").val()+'&id=4');
							}
						}else{
							if(processid=="Route"){  
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
							}
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&delid="+delid+"&routeid="+routeid+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);        
	x.send();      
	}
	function funholdreleasesave(processid,rowno,holddate,reason,brhid){      
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						    loads();
						    clearfields();
							if(processid=="Hold"){
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalhold").modal('toggle');      
							}
							if(processid=="Release"){
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalrelease").modal('toggle');        
							}
							if(processid=="Close Job"){  
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'    
									});
								 $("#modalclosejob").modal('toggle');           
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
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&holddate="+holddate+"&reason="+encodeURIComponent(reason)+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);        
	x.send();      
	}
	function viewContract(){                           
		var contracttrno=document.getElementById("hidcontrno").value;         
		var brch=document.getElementById("hidbrhid").value; 
		
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
	function funserreqsave(processid,rowno,reason,brhid, entrydate, entrytime, type){       
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				     var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalservicerequest").modal('toggle');  
								 $('#txtserreqremarks').val('');   
								 loads();
								 getCountData();
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&type="+type+"&holddate="+entrydate+"&cltime="+entrytime+"&brhid="+brhid+"&rowno="+rowno+"&reason="+encodeURIComponent(reason)+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);          
	x.send();      
	}
	function getCountData(){  
		var datechk = $('#hiddatechk').val();   
	    var todate = $('#todate').jqxDateTimeInput('val'); 
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				$('.badge-serreq').text(items);  
			}      
			else
			{
			}  
		}
		x.open("GET","getCountData.jsp?todate="+todate+"&datechk="+datechk,true);      
		x.send();
    }
	function funpostingvalidate(rowno,contrno,srno){  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText.split("####");
				if(parseInt(items[0])==0){  	  
					swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Adv. Invoice not created!!!'      
					});
				}else if(parseInt(items[1])==0){
					swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Service schedule not updated!!!'    
					});
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
								 saveSchedulePosting(rowno,contrno,srno);        
							}else{
							}
					});		  
				} 
			}  
		}
	x.open("GET","postingValidate.jsp?rowno="+rowno+"&srno="+srno+"&contrno="+contrno,true);             
	x.send();     
	}
	function setValues(){ 
		var msg=$('#msg').val();
		console.log("msg = "+msg);  
		if(msg!=""){
			 if(msg.includes("Successfully")){  
				 swal.fire({  
						icon: 'success',
						title: 'Success',
						text: ''+msg  
					}); 
			 }else{
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: ''+msg    
					});
			 }
	   	 }  
	 }
	function saveSchedulePosting(rowno,contrno,srno){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
				if(parseInt(items)>0){ 
					 $("#overlay, #PleaseWait").hide(); 
					 swal.fire({  
							icon: 'success',
							title: 'Success',
							text: 'Successfully Updated'  
						});
				}else{
					 $("#overlay, #PleaseWait").hide();   
					swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Not Updated'        
					});		  
				} 
			}  
		}
	x.open("GET","saveSchedulePosting.jsp?rowno="+rowno+"&srno="+srno+"&contrno="+contrno,true);                   
	x.send();     
	} 
	function funalternatecheck(){     
		if(document.getElementById("alternativechk").checked){
			$('#cmbdays').attr("disabled",true); 
			$('#cmbdates').attr("disabled",true);
		}else{
			$('#cmbdays').attr("disabled",false); 
			$('#cmbdates').attr("disabled",false);  
		}
	}
	function clearfields(){  
    	$('#hiddelid').val("");  
		$('#schdeldate').val(new Date());
		$('#schdeltime').val(new Date()); 
		$("#cmbskip").val('').trigger('change');
		$("#cmbdriver").val('').trigger('change');
		$("#cmbhelper").val('').trigger('change');
		$("#cmbvehicle").val('').trigger('change'); 
		$('#txtname').val(""); 
		$('#txtmobile').val(""); 
		$('#txtemail').val(""); 
		$('#txtdayshift').val("");   
		$('#txtlocmap').val("");  
		$('#hidrouteid').val("");   
		$('#txtroute').val("");  
		$('#hidskipid').val("");  
		$('#holddate').val(new Date());  
		$('#txtholdreason').val('');
		$('#releasedate').val(new Date());  
		$('#txtreleasereason').val(''); 			
		$('#closedate').val(new Date());  
		$('#txtclosereason').val(''); 
		$('#txtrequesteduser').val(''); 
		$('#renewalreqdate').val(new Date()); 
		$('#txtrenewreqremarks').val('');
		$('#txtgpsx').val('');
		$('#txtgpsy').val('');
		$('#txtroute').val(''); 
		$('#podate').val(new Date());
		$('#potime').val(new Date());
		$('#cldate').val(new Date());
		$('#cltime').val(new Date());
		$('#jqxskipnoPO').val(''); 
		$('#poskipno').val('');
		$('#poremarks').val('');   
        getDeliveriesPO();
    }
	function contractRevise(){       
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
				if(parseInt(items)>0){ 
					 swal.fire({  
							icon: 'warning',
							title: 'Warning',   
							text: 'Some requests are still pending!!!'        
						});
				}else{
					$("#modalcntrenewalreq").modal('toggle');  
				} 
			}  
		}
	x.open("GET","getContractReviseCheck.jsp?srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);                     
	x.send();          
	}
	function funchangedate(){  
		if(document.getElementById('datechk').checked){
			$('#todate').jqxDateTimeInput('disabled',false);
			$('#hiddatechk').val(1);
		}else{
			$('#todate').jqxDateTimeInput('disabled',true);  
			$('#hiddatechk').val(0);
		}
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
		x.open("GET","getDeliveriesPO.jsp?srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(), true);         
		x.send();
	}
	function funLoadSkip(id){        
		$('#skipnodiv').load("skipnoSearch.jsp?cnttrno="+$("#hidcontrno").val()+"&cntsrno="+$("#hidsrno").val()+"&delsrno="+$("#cmbslnopo").val()+"&type="+1);       
	}
	function getSRFDetails(){ 
		var cnttrno = $("#hidcontrno").val();
		var srno = $("#hidsrno").val();
		var type = $("#hidtype").val();
		var x=new XMLHttpRequest();  
		x.onreadystatechange=function(){  
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText.split('####');
					document.getElementById('sraction').innerHTML=items[2];	 
					document.getElementById('sroldstatus').innerHTML=items[1];	 
					document.getElementById('srnewstatus').innerHTML=items[0];	  
					document.getElementById("contracttype").innerHTML = items[3];	
			}
		}
		x.open("GET","getSRFDetails.jsp?cnttrno="+cnttrno+"&srno="+srno+"&type="+type,true);    
		x.send();         
	}
	 function removeSplCharacters(desc){
		 if ((desc).includes(',')) {
			 desc = desc.replace(/,/g, '');  
		 }
		 if ((desc).includes('$')) {
			 desc = desc.replace(/$/g, '');
		 }
		 if ((desc).includes('%')) {
			 desc = desc.replace(/%/g, '');
		 }
		 if ((desc).includes('^')) { 
			 desc = desc.replace(/^/g, '');
		 }
		 if ((desc).includes('`')) {
			 desc = desc.replace(/`/g, '');
		 }
		 if ((desc).includes('~')) {
			 desc = desc.replace(/~/g, '');
		 }
		 if (desc.indexOf('\'')  >= 0 ) {
			 desc = desc.replace(/'/g, '');    
		 }
		 return desc;   
	}
  </script> 
<div id="desginfowindow">
	<div></div><div></div>
</div> 
<div id="areainfowindow">
	<div></div><div></div>
</div> 
<div id="clientsearch">
	<div></div><div></div>
</div> 
<div id="cpinfowindow">
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
