<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Contract Review</title>           
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
  		overflow:auto; 
  		width:150px;           
  		/* height:50px;       */           
  } 
  .selecteddiv{
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
    .padtopbtn{
        padding-top: 18px; 
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
  </style>
</head>       
<body>   
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
      <div class="row padtop">
       <div class="card-outer-container" id="allvaliddiv">
                <div class="card-container" id="allvalidid">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <div id="allvalid"></div>
                            <span><img src="../icons/icons-all.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">     
                             <span>All Valid</span><br/>        
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>      
             <div class="card-outer-container" id="newdiv">
                <div class="card-container" id="newid">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <div id="new"></div>
                            <span><img src="../icons/icons-new.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container"> 
                             <span>Created</span><br/>        
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>
             <div class="card-outer-container" id="revdiv">
                <div class="card-container" id="revid">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <div id="rev"></div>
                            <span><img src="../icons/icons-decision.png" alt="" width="30" height="30"></span>   
                        </div>
                        <div class="card-detail-container">
                             <span>Revision</span><br/>        
                             <span class="counter">10</span>    
                        </div>
                    </div>
                </div>
            </div>
             <div class="card-outer-container" id="rnewdiv">
                <div class="card-container" id="rnewid">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="rnew"></div>  
                            <span><img src="../icons/icons-renewable.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Renewed (Old Cnt.)</span><br/>     
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>	
             <div class="card-outer-container" id="termdiv">
                <div class="card-container" id="termid">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="term"></div>  
                            <span><img src="../icons/icons-cancel.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Terminated</span><br/>  
                             <span class="counter">10</span>     
                        </div>
                    </div>
                </div>
            </div>	
             <div class="card-outer-container" id="expdiv">
                <div class="card-container" id="expid">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="exp"></div>  
                            <span><img src="../icons/icons-expired.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">  
                            <span>Expired</span><br/>  
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
		 <div class="primarypanel custompanel2">
		      <table>
			      <tr>              
			      <td align="right"><label style="font-size: 13px">From:&nbsp;&nbsp;</label></td>   
			      <td align="left"><div id='fromdate' name='fromdate'></div></td>
			      
			      <td align="right"><label style="font-size: 13px">To:&nbsp;&nbsp;</label></td>   
			      <td align="left"><div id='todate' name='todate'></div></td>
			      </tr>                              
			 </table>   
        </div>	
      
        <div class="primarypanel custompanel1">        
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>  
            <button type="button" class="btn btn-default" id="btndelpullout" data-toggle="tooltip"  title="Delivery & Pullout" data-placement="bottom"><i class="fa fa-share "  aria-hidden="true"></i></button>        
            <button type="button" class="btn btn-default" id="btncntrenewalreq" data-toggle="tooltip"  title="Contract Revise Request" data-placement="bottom"><i class="fa fa-plus-square "  aria-hidden="true"></i></button>        
            <button type="button" class="btn btn-default" id="btnservicerequest" data-toggle="tooltip"  title="Service Request" data-placement="bottom"><i class="fa fa-pencil "  aria-hidden="true"></i></button>        
            <button type="button" class="btn btn-default" id="btnclosejob" data-toggle="tooltip"  title="Terminated / Cancel job request" data-placement="bottom"><i class="fa fa-times-circle "  aria-hidden="true"></i></button>        
            <button type="button" class="btn btn-default" id="btncontractview"><i class="fa fa-scribd" aria-hidden="true" data-toggle="tooltip"  title="View Service Contract" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnrenewal" ><i class="fa fa-paste" aria-hidden="true" data-toggle="tooltip" title="From Renewal" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnrevised" ><i class="fa fa-retweet" aria-hidden="true" data-toggle="tooltip" title="Revised" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnrenewalhistory" ><i class="fa fa-history" aria-hidden="true" data-toggle="tooltip" title="Renewal History" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnrevisedhistory" ><i class="fa fa-file-text-o" aria-hidden="true" data-toggle="tooltip" title="Revised History" data-placement="bottom"></i></button>
           	<button type="button" class="btn btn-default" id="btnmail" ><i class="fa fa-envelope" aria-hidden="true" data-toggle="tooltip" title="Send Mail" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnhold" data-toggle="tooltip"  title="Hold" data-placement="bottom"><i class="fa fa-sign-in "  aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btnrelease" data-toggle="tooltip"  title="Release" data-placement="bottom"><i class="fa fa-sign-out "  aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btnholdreleaselog" data-toggle="tooltip"  title="Hold/Release Log" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button> 
            <button type="button" class="btn btn-default" id="btnattach" ><i class="fa fa-paperclip" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>        
       <div class="textpanel custompanel">          
           <table>  
		      <tr> 
			      <td align="left" width="80%"><p style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p></td>  
			      <td align="left" width="20%" id="selectedid"><label for="divid" id="selecteddiv" style="font-size:75%;padding-right:5px"></label></td>                        
			  </tr>                                          
		  </table>
	   </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>          
      </div>
    </div>    
    
<div id="contractrenwindow">
   <div></div>
</div>

<div id="contractrevwindow">
   <div></div>
</div>

<div id="printWindow">
	<div></div>
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
    
    <div id="modalservicerequest" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Service Request<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>         
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
    <div id="modalclosejob" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>    
            		<h4 class="modal-title">Terminated / Cancel job request<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>     
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
    <div id="modalcntrenewalreq" class="modal fade" role="dialog">  
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Contract Revise Request<span></span></h4>  <label for="otherdetails3" id="lblotherdetails3"></label>         
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
    <div id="modaldelpullout" class="modal fade" role="dialog">          
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">   
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Delivery & Pull Out<span></span></h4><label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>
          		<div class="modal-body">     
            		<div class="row">      
				      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                
				        <div id="delpulldiv"><jsp:include page="delpulloutGrid.jsp"></jsp:include></div>                   
				      </div>
				    </div>  
  					<div class="row"> 
  					   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="dpdelqty">Del. Qty:</label>         
		        					<input type="text" id="dpdelqty" name="dpdelqty" class="form-control input-sm">    
	                     	    </div>     
		                   </div> 
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="dpdeldate">Del. Date:</label>         
		        					<div id="dpdeldate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">           
		        				<div class="form-group">
		        					<label for="remarks">Del. Remarks:</label>      
		        					<input type="text" id="dpdelremarks" name="dpdelremarks" class="form-control input-sm">    
	                     	    </div>     
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
			                   <div class="padtopbtn">  
			                   		<button type="button" class="btn btn-default btn-primary" id="btndelivery">Delivery</button>      
			                   </div> 
		                   </div>      
            		</div> 
            	    <div class="row"> 
  					   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="dpaddqty">Add. Qty:</label>            
		        					<input type="text" id="dpaddqty" name="dpaddqty" class="form-control input-sm">    
	                     	    </div>     
		                   </div> 
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="dpadddate">Date:</label>         
		        					<div id="dpadddate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">           
		        				<div class="form-group">
		        					<label for="addremarks">Remarks:</label>                
		        					<input type="text" id="dpaddremarks" name="dpaddremarks" class="form-control input-sm">    
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
			                   <div class="padtopbtn">  
			                   		<button type="button" class="btn btn-default btn-primary" id="btnadddelivery">Add. Delivery</button>      
			                   </div> 
		                   </div>       
            		</div> 
            		<div class="row"> 
  					   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="dppoqty">Pull Out Qty:</label>            
		        					<input type="text" id="dppoqty" name="dppoqty" class="form-control input-sm">    
	                     	    </div>     
		                   </div> 
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="dppodate">Date:</label>           
		        					<div id="dppodate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">           
		        				<div class="form-group">
		        					<label for="dpporemarks">Remarks:</label>                  
		        					<input type="text" id="dpporemarks" name="dpporemarks" class="form-control input-sm">    
	                     	    </div>     
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
			                   <div class="padtopbtn">  
			                   		<button type="button" class="btn btn-default btn-primary" id="btnpullout">Pull Out</button>      
			                   </div>    
		                   </div>      
            		</div>    
          		</div>
          		<!-- <div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          		</div> -->       
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
  <input type="hidden" name="hiddpdeliveryqty" id="hiddpdeliveryqty">      
  <input type="hidden" name="hiddpqty" id="hiddpqty">    
  <input type="hidden" name="hiddpsrno" id="hiddpsrno">   
  <input type="hidden" name="hidsrno" id="hidsrno">   
  <input type="hidden" name="hidcontrno" id="hidcontrno">    
  <input type="hidden" name="hidbrhid" id="hidbrhid">  
  <input type="hidden" name="hidrowno" id="hidrowno"> 
  <input type="hidden" name="hidcomments" id="hidcomments">  
  <input type="hidden" name="hidloadtype" id="hidloadtype">    
  <input type="hidden" name="divname" id="divname">   
  <input type="hidden" name="lblname" id="lblname">
  <input type="hidden" name="lblnamesrf" id="lblnamesrf">
  <input type="hidden" name="hidsrdocno" id="hidsrdocno">
  <input type="hidden" name="hiddelid" id="hiddelid">  
  <input type="hidden" name="hiddpdelid" id="hiddpdelid"> 
  <input type="hidden" name="hiddptype" id="hiddptype">  
  <input type="hidden" name="hidstartdt" id="hidstartdt">   
  <input type="hidden" name="cldocno" id="cldocno"> 
  <input type="hidden" name="hidtype" id="hidtype">     
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){  
    	$("#selectedid").hide() 
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');      
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:300px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();   
    	
   	    $('#contractrenwindow').jqxWindow({ width: '60%', height: '40%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Renewal Details' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#contractrenwindow').jqxWindow('close'); 
    	
   	    $('#contractrevwindow').jqxWindow({ width: '90%', height: '40%',  maxHeight: '85%' ,maxWidth: '90%' ,title: 'Contract Revision' , position: { x: 60, y: 60 }, keyboardCloseKey: 27});
        $('#contractrevwindow').jqxWindow('close'); 
    	
        $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
   	 	$('#printWindow').jqxWindow('close');   
   	    $("#dpadddate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
   	    $("#dpdeldate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
   	    $("#dppodate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
   	    $("#closedate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
        $('#closedate').jqxDateTimeInput('setDate', new Date());    
        $("#witheffectdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
        $("#renewalreqdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
        $("#holddate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
        $("#releasedate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
        $("#entrydate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
        $("#entrytime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
        $('#entrydate').jqxDateTimeInput('setDate', new Date()); 
	    $('#entrytime').jqxDateTimeInput('setDate', new Date()); 
        $("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$('#releasedate').jqxDateTimeInput('setDate', new Date());   
	    $('#holddate').jqxDateTimeInput('setDate', new Date());
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
				  getCountData()
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
				  getCountData()
			   }   
		 });
		getCountData();
		document.getElementById('selecteddiv').innerHTML=" - All Valid";      
		document.getElementById("divname").value="allvalid"; 
		$('.card-container').removeClass('cardactive');      
        $("#allvalidid").addClass('cardactive'); 
		
        $('#btnsubmit').click(function(){    
            $("#hidloadtype").val("0");
            loads(); 
            getCountData(); 
        }); 
        
        $('#btnrenewal').click(function(){ 
        	 $("#hidloadtype").val("REN");
             loads(); 
             getCountData(); 
        });
        
        $('#btnrevised').click(function(){ 
        	 $("#hidloadtype").val("REV");
        	 loads(); 
        	 getCountData(); 
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
	    	document.getElementById("lblotherdetails1").innerHTML=$("#lblnamesrf").val();    
	    	$("#modalservicerequest").modal('toggle');                      
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
	    	document.getElementById("lblotherdetails2").innerHTML=$("#lblname").val();
	    	$("#modalclosejob").modal('toggle');           
        });
	    $('#btndelpullout').click(function(){               
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}    
	    	document.getElementById("lblotherdetails4").innerHTML=$("#lblname").val();
	    	fundpload();
	    	$("#dpdelqty").val(1);
	    	$("#dppoqty").val(1);
	    	$("#dpaddqty").val(1); 
	    	$("#modaldelpullout").modal('toggle');               
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
        $('#btncntrenewalreq').click(function(){          
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
	    	document.getElementById("lblotherdetails3").innerHTML=$("#lblname").val();
	    	contractRevise();                          
        });
        $('#btnservicerequestsave').click(function(){    
	    	funUpdate("service request");    
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
        		funUpdate("close job"); 
        	}
        });
        $('#btncntrenewalreqsave').click(function(){                     
        	funUpdate("revision request");              
        });
        $('#btndelivery').click(function(){                     
        	funUpdate("delivery");                
        });
        $('#btnadddelivery').click(function(){                     
        	funUpdate("add delivery");                   
        });
        $('#btnpullout').click(function(){                     
        	funUpdate("pull out");                   
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
        		worksheetName:"Contract Review"  
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
        $('#btnmail').click(function(){   
        	var docno=$('#hidcontrno').val();
    		if(docno==""){
    	        Swal.fire({
    				type: 'error',
    				title: 'Warning',
    				text: 'Please select a document'
    			});
    	    	return false;
    	    }
    		contractPrintContent('printVoucherWindow.jsp');
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
	    	$('#hrldiv').load('holdreleaselogGrid.jsp?cldocno='+$('#cldocno').val()+'&id=1');    
	    	$("#modalholdreleaselog").modal('toggle');                                       
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
        $('#btnholdsave').click(function(){            
        	funUpdate("HOLD");       
        });
        $('#btnreleasesave').click(function(){              
        	funUpdate("RELEASE");        
        });
    });      
    
    function contractPrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#printWindow').jqxWindow('setContent', data);
			$('#printWindow').jqxWindow('bringToFront');
		}); 
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
    function funSendmail(xlstat, typeid, value){ 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim().split("####");
				var email="";
				var cldocno="";
				var msg="";      
				var client="";
				var subject="Contract";    
				if(items!=""){
					 msg=items[0];
				     email=items[1];
				     cldocno=items[2];
				     //client=items[3];    
				}
				var brchid=document.getElementById("hidbrhid").value;
				var userid="<%= session.getAttribute("USERID").toString() %>";     
		   		var docno=document.getElementById("hidcontrno").value;       
		   		var frmdet="AMC";        
		   		var dtype="AMC";        
		   		var fname="Contract";
		   		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+docno+"&brchid="+brchid+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet+"&subject="+encodeURIComponent(subject)+"&msg="+encodeURIComponent(msg),"E-Mail","menubar=0,resizable=1,width=900,height=950"); 
			}
		}      
		x.open("GET","sendMail.jsp?trno="+$('#hidcontrno').val()+"&xlstat="+xlstat+"&typeid="+typeid+"&value="+value,true);                
		x.send();        
	}
    
    $('#btnattach').click(function(){
		var docno=$('#hidcontrno').val();
		if(docno==""){
	        Swal.fire({
				type: 'error',
				title: 'Warning',
				text: 'Please select a document'
			});
	    	return false;
	    }
	    attach();      
	});
    
    function attach(){
	   	
		var fcode="AMC";
		var fname="Contract";

		var brchid=$('#hidbrhid').val(); 
		var docno=$('#hidcontrno').val(); 
		
		var myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+docno+"&brchid="+brchid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
		myWindow.focus();
				
	}  
    
    $('#btnrenewalhistory').click(function(){
    	var docno=$('#hidcontrno').val();
		if(docno==""){
	        Swal.fire({
				type: 'error',
				title: 'Warning',
				text: 'Please select a document'
			});
	    	return false;
	    }
    	contractrenewal('contractrenewalGrid.jsp?docno='+docno)
    });
    
    function contractrenewal(url) {
	    $('#contractrenwindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#contractrenwindow').jqxWindow('setContent', data);
			$('#contractrenwindow').jqxWindow('bringToFront');
		}); 
	}
    
    $('#btnrevisedhistory').click(function(){
    	var docno=$('#hidcontrno').val();
		if(docno==""){
	        Swal.fire({
				type: 'error',
				title: 'Warning',
				text: 'Please select a document'
			});
	    	return false;
	    }
    	contractrevision('contractrevisionGrid.jsp?docno='+docno)
    });
    
    function contractrevision(url) {
	    $('#contractrevwindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#contractrevwindow').jqxWindow('setContent', data);
			$('#contractrevwindow').jqxWindow('bringToFront');
		}); 
	}
    
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("hidcontrno").value="";   
    	document.getElementById("hidrowno").value="";   
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
    	clearfields();      
	    var fromdate = $("#fromdate").val();
	    var todate = $("#todate").val();
	    var loadtype = $("#hidloadtype").val();  
	    var divname = $("#divname").val();  
	    $('#contractdiv').load('contractGrid.jsp?id=1&fromdate='+fromdate+'&todate='+todate+'&type='+loadtype+'&divname='+divname);           
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
	function getCountData(){  
		var loadtype = $("#hidloadtype").val();
		var fromdate = $("#fromdate").val();
		var todate = $("#todate").val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				var guagedata=JSON.parse(items);                    
	          	$("#new").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.newcount);  
	        	$("#rev").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.revcount);  
	          	$("#rnew").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.rencount);	
	          	$("#term").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.termcount);
	          	$("#exp").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.expcount);	
	          	$("#allvalid").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.allcount);	
			}          
			else   
			{
			}  
		}
		x.open("GET","getCountData.jsp?loadtype="+loadtype+'&fromdate='+fromdate+'&todate='+todate,true);          
		x.send();
    }
	$('div').click(function() {
		  var divid=$(this).attr('id');  
		  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
			  var realid=divid.replace(/div/g, "");
			  if(realid=="allvalid" || realid=="new" || realid=="rev" || realid=="rnew" || realid=="term" || realid=="exp"){        
				  $("#jqxContractGrid").jqxGrid('clear');      
				  $('.textpanel p').text(''); 
				  document.getElementById("divname").value=realid;  
				  $('.card-container').removeClass('cardactive');      
		          $("#"+realid+"id").addClass('cardactive'); 
				  $("#hidloadtype").val("0"); 
				  loads();                   
			  }
			  if(realid=="new"){   
				  document.getElementById('selecteddiv').innerHTML=" - Created";  
			  }else if(realid=="rev"){
				  document.getElementById('selecteddiv').innerHTML=" - Revision";    
			  }else if(realid=="rnew"){
				  document.getElementById('selecteddiv').innerHTML=" - Renewed (Old Cnt.)";   
			  }else if(realid=="term"){
				  document.getElementById('selecteddiv').innerHTML=" - Terminated";     
			  }else if(realid=="exp"){
				  document.getElementById('selecteddiv').innerHTML=" - Expired";       
			  }else if(realid=="allvalid"){
				  document.getElementById('selecteddiv').innerHTML=" - All Valid";       
			  }else{}         
		  }
	  });
	
	function funUpdate(chkevent){   
		var processid = "";
		var rowno = $('#hidrowno').val();
		var brhid = $("#hidbrhid").val();
		var delid = $('#hiddelid').val();
		if(chkevent=="service request"){  	  
			var reason = $('#txtserreqremarks').val();  
			var entrydate = $('#entrydate').val();  
			var entrytime = $('#entrytime').val(); 
			var type = $('#hidtype').val();
			processid = "Service Request";           
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
		}else if(chkevent=="close job"){  	
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
		}else if(chkevent=="revision request"){   
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
			}else if(chkevent=="delivery"){     
				var contrno = $("#hidcontrno").val();
				var deldate = $("#dpdeldate").val();
				var dpdelqty = $("#dpdelqty").val();
				var availqty = $("#hiddpqty").val();  
				var dpdelremarks = $("#dpdelremarks").val(); 
				var dpdeltime = "00:00"; 
				var srno =  $("#hiddpsrno").val(); 
				var deliveryqty =  $("#hiddpdeliveryqty").val();    
				processid="delivery";  
				if(srno=="" || srno=="0"){    
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Please select a document!!!'                 
						});
		  		      return false;
				}
				if(dpdelqty=="" || dpdelqty=="0"){  
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Please enter Qty!!!'        
						});
		  		      return false;
				}  
				if(parseInt(deliveryqty)>0){           
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Already delivered!!!'            
						});
		  		      return false;   
				} 
				if(parseInt(dpdelqty)>parseInt(availqty)){        
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Maximum allowed qty is '+availqty       
						});
					  document.getElementById("dpdelqty").focus();      
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
							fundeliverysave(processid, rowno, brhid, deldate, dpdelqty, dpdelremarks, contrno, dpdeltime, srno);         
						}else{
						}
				});
			}else if(chkevent=="add delivery"){       
				var contrno = $("#hidcontrno").val();
				var addqty = $("#dpaddqty").val();
				var addtime = "00:00";      
				var adddate = $("#dpadddate").val();
				var addremarks = $("#dpaddremarks").val();       
				var srno =  1;     
				processid="add delivery";    
				if(addqty=="" || addqty=="0"){    
					 swal.fire({  
						 icon: 'warning',
							title: 'Warning',
							text: 'Please enter Qty!!!'        
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
							funadddeliverysave(processid, rowno, brhid, addqty, adddate, addremarks, srno, addtime, contrno);         
						}else{    
						}
				});
			}else if(chkevent=="pull out"){       
				var contrno = $("#hidcontrno").val();
				var potime = "00:00";      
				var poqty = $("#dppoqty").val();
				var podate = $("#dppodate").val();
				var poremarks = $("#dpporemarks").val();
				var delid = $("#hiddpdelid").val();  
				var srno =  $("#hiddpsrno").val();  
				var deliveryqty =  $("#hiddpdeliveryqty").val(); 
				var type =  $("#hiddptype").val(); 
				processid="pull out";  
				if(srno=="" || srno=="0"){       
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Please select a document!!!'                 
						});
		  		      return false;
				}
				if(type=="P"){         
					 swal.fire({  
						 icon: 'warning',
							title: 'Warning',
							text: 'Pull out already done!!!'          
						});
		  		      return false;
				}
				if(poqty=="" || poqty=="0"){       
					 swal.fire({  
						 icon: 'warning',
							title: 'Warning',
							text: 'Please enter Qty!!!'        
						});
		  		      return false;
				} 
				if(parseInt(poqty)>parseInt(deliveryqty)){           
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Maximum allowed qty is '+deliveryqty            
						});
					  document.getElementById("dppoqty").focus();              
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
							funpodeliverysave(processid, rowno, brhid, poqty, podate, poremarks, srno, potime, contrno, delid); 
						}else{    
						}  
				});
			}else if(chkevent=="HOLD"){  	
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
			}else if(chkevent=="RELEASE"){     	
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
			}else{}     
	}
	function funrenewalrequestsave(processid,renewalreqdate,requesteduser,renewreqremarks,brhid,witheffectdate){             
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
						 loads();
						 getCountData();    
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
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&type="+type+"&holddate="+entrydate+"&time="+entrytime+"&brhid="+brhid+"&rowno="+rowno+"&reason="+encodeURIComponent(reason)+"&srno="+$("#hidsrno").val()+"&contrno="+$("#hidcontrno").val(),true);          
	x.send();      
	}
	function funholdreleasesave(processid,rowno,holddate,reason,brhid){        
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
							  loads();
							  getCountData(); 
							  $('#txtholdreason').val('');
							  $('#txtreleasereason').val('');  
							  if(processid=="Hold"){
								  $("#modalhold").modal('toggle');     
							  }
							  if(processid=="Release"){
								  $("#modalrelease").modal('toggle');   
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
	   
	function fundpload(){        
		$('#delpulldiv').load('delpulloutGrid.jsp?contrno='+$("#hidcontrno").val()+'&id=1');           
	} 
	
	function fundeliverysave(processid, rowno, brhid, deldate, dpdelqty, dpdelremarks, contrno, dpdeltime, srno){   
		dpdelremarks = removeSplCharacters(dpdelremarks);
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
							  fundpload(); 
							  funcleardp();
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'  
									});
						} 
				}
		}
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&time="+dpdeltime+"&brhid="+brhid+"&rowno="+rowno+"&holddate="+deldate+"&reason="+encodeURIComponent(dpdelremarks)+"&contrno="+contrno+"&qty="+dpdelqty+"&srno="+srno,true);               
		x.send();      
	}
	function funadddeliverysave(processid, rowno, brhid, addqty, adddate, addremarks, srno, addtime, contrno){ 
		addremarks = removeSplCharacters(addremarks);
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
							  fundpload(); 
							  funcleardp();
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'    
									});
						} 
				}
		}
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&time="+addtime+"&brhid="+brhid+"&rowno="+rowno+"&holddate="+adddate+"&reason="+encodeURIComponent(addremarks)+"&contrno="+contrno+"&qty="+addqty+"&srno="+srno,true);               
		x.send();      
	}
	function funpodeliverysave(processid, rowno, brhid, poqty, podate, poremarks, srno, potime, contrno, delid){ 
		poremarks = removeSplCharacters(poremarks);
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
							  fundpload(); 
							  funcleardp();
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'    
									});
						} 
				}
		}
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&time="+potime+"&brhid="+brhid+"&rowno="+rowno+"&holddate="+podate+"&reason="+encodeURIComponent(poremarks)+"&contrno="+contrno+"&qty="+poqty+"&srno="+srno+"&delid="+delid,true);    
		x.send();         
	}
	function funcleardp(){
		$("#dpdeldate").val(new Date());
		//$("#dpdelqty").val('');
		$("#dpdelremarks").val(''); 
		//$("#dpaddqty").val('');
		$("#dpadddate").val(new Date());   
		$("#dpaddremarks").val('');
		//$("#dppoqty").val('');
		$("#dppodate").val(new Date());
		$("#dpporemarks").val('');
		$("#hiddpsrno").val('')
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
  </div>
  </form>   
</body>
</html>
