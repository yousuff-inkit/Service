<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Sales Activity Management</title>     
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
  }    
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
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
  </style>
</head>       
<body onload="getBranch();">       
  <div class="container-fluid">
  		<div class="row padtop">
  		<div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="prosdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">   
                            <div id="pros"></div>  
                            <span><img src="icons/icons8-schedule-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                             <span>Prospects</span><br/>
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="enqdiv">    
                <div class="card-container">
                    <div class="card-body text-center">
                        <div class="card-chart-container">
                            <div id="enq"></div>
                            <span><img src="icons/icons8-collaboration-30.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Enquired</span><br/>        
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="quotdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="quot"></div>
                            <span><img src="icons/icons8-paycheque-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Quote</span><br/>
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>	
             <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="appntdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="appnt"></div>  
                            <span><img src="icons/icons8-ledger-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Appointments</span><br/>
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>	
        </div>  
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
      <div class="primarypanel custompanel">
               <label for="branch" class="branch">Branch</label>  
        </div>
        <div class="primarypanel custompanel">
               <select class="cmbbranch form-control input-sm" id="cmbbranch" name="cmbbranch" onchange="loads();getInitChartData();" value='<s:property value="cmbbranch"/>' style="width:140px;">
  					<option></option>     
				</select>
        </div>          
        <div class="primarypanel custompanel">     
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
      <div class="actionpanel custompanel">   
          <button type="button" class="btn btn-default" id="btnappointment" data-toggle="tooltip"  title="Appointment Fix" data-placement="bottom"><i class="fa fa-plus "  aria-hidden="true"></i></button>     
          <button type="button" class="btn btn-default" id="btnnextfollowup" data-toggle="tooltip"  title="Next Follow Up" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncreateprospective"  data-toggle="tooltip" title="Create Prospective Client" data-placement="bottom" ><i class="fa fa-plus-square "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnconvert"  data-toggle="tooltip" title="Convert to Client" data-placement="bottom" ><i class="fa fa-retweet "  aria-hidden="true"></i></button>            
          <button type="button" class="btn btn-default" id="btncreateenquiry"  data-toggle="tooltip" title="Create Enquiry" data-placement="bottom"><i class="fa fa-plus-square "  aria-hidden="true"></i></button>        
        </div>              
        <div class="otherpanel custompanel">               
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        <div class="textpanel custompanel" >
			<label for="divid" id="selecteddiv" style="font-size:75%;padding-top:9px;padding-left:6px;"></label>  
        </div>
        <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>  
        </div>
      </div>
    </div>
    <div class="row" id="prospective">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
        <div id="prospectivediv"><jsp:include page="prospectiveGrid.jsp"></jsp:include></div>     
      </div>  
    </div> 
    <div class="row" id="enquiry">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="enquirydiv"><jsp:include page="enquiryGrid.jsp"></jsp:include></div>     
      </div>  
    </div>
    <div class="row" id="quote">          
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="quotediv"><jsp:include page="quoteGrid.jsp"></jsp:include></div>     
      </div>  
    </div>
    <div class="row" id="appointment">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="appointmentdiv"><jsp:include page="appointmentGrid.jsp"></jsp:include></div>     
      </div>    
    </div>     

    <!-- Comments Modal-->
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
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
    
 	 <!-- Next Follow up Modal-->      
    <div id="modalnextfollowup" class="modal fade" role="dialog">    
      <div class="modal-dialog modal-md">  
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Next Follow Up</h4>                            
          </div>  
		<div class="modal-body"> 
		  <div class="container-fluid">     
		     <div class="row m-t-5">
		         <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">	       			
	        				<div class="form-group">
	        					<label for="vname">Extent</label>
	        					<input type="radio" id="appntextent" name="nextflwup" onchange="funfollowupradio();">      
	        				</div>
	        	 </div>
	        	 <div class="col-xs-12 col-sm-6 col-md-2 col-lg-3">	       			
	        				<div class="form-group">
	        					<label for="vname">Follow Up</label>
	        					<input type="radio" id="appntflwup" name="nextflwup" onchange="funfollowupradio();">      
	        				</div>
	        	 </div>
	        	 <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">	       			
	        				<div class="form-group">
	        					<label for="vname">Cancel</label>    
	        					<input type="radio" id="appntcancel" name="nextflwup" onchange="funfollowupradio();">      
	        				</div>
	        	 </div>
	        	 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3"> 		
	        				<div class="form-group">
	        					<label for="vname">Date</label>
	        					<div id="flwupdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
	        				</div>
	            </div>
	            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     	        		
	        				<div class="form-group">      
	        					<label for="vname">Time</label>    
	        					<div id="flwuptime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
	        				</div>
	            </div>  
		      </div>  
	          <div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	        				<div class="form-group">
	        					<label for="trname">Description</label>  
	        						<input type="text" id="flwupdesc" class="form-control input-sm">             
	        				</div>    
	        			</div>
	          </div>
	           <div class="row m-t-5">      
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            
			        <div id="flwupdiv"><jsp:include page="nextfollowupGrid.jsp"></jsp:include></div>       
			      </div>    
			    </div>
			</div>
			<div class="clear"></div>  
			</div>
			          <div class="modal-footer" style="background-color:#CDFDFA">   
			          <button type="button" class="btn btn-default" onclick="funnextfollowup();">SAVE</button>   
			            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
			          </div>                 
			        </div>
			      </div>
			    </div>  	    
		    
	 <!-- appointment creation Modal-->      
    <div id="modalappointment" class="modal fade" role="dialog">    
      <div class="modal-dialog modal-xl">  
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Appointment Fix</h4>                       
          </div>  
		<div class="modal-body"> 
		  <div class="container-fluid">     
		     <div class="row m-t-5">
		        <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">	       			
	        				<div class="form-group">
	        					<label for="vname">New Contact</label>
	        					<input type="radio" id="newcontact" name="contact" onchange="funchangeradio();">    
	        				</div>
	        	 </div> 
	        	 <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">	       			
	        				<div class="form-group">
	        					<label for="vname">Existing Contact</label>        
	        					<input type="radio" id="existcontact" name="contact" onchange="funchangeradio();">        
	        				</div>
	        	 </div>    
	             <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" id="newcontacthide">	         			
	        				<div class="form-group">
	        					<label for="vname">Client</label>
	        					<input type="text" id="txtclient" class="form-control input-sm">        
	        				</div>
	        	 </div>
	        	 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" id="existcontacthide">   
	        	            <div class="form-group">  	 
	        					<label for="vname">Client</label>  
	        					<div id="client" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientsearch.jsp"></jsp:include></div>
                     	        <input type="hidden" id="hidclientid" name="hidclientid">           
	        			 	</div>
	        	 </div>
	        	 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2"> 		
	        				<div class="form-group">
	        					<label for="vname">Date</label>
	        					<div id="appntdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
	        				</div>
	            </div>
	            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     	        		
	        				<div class="form-group">      
	        					<label for="vname">Time</label>  
	        					<div id="appnttime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
	        				</div>
	            </div>            
		     </div> 
		     <div class="row m-t-5" id="newdetailshide">
	        			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
	        				<div class="form-group">
	        					<label for="trname">Contact Person</label>     
	        						<input type="text" id="txtcperson" class="form-control input-sm">           
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
	        				<div class="form-group">
	        					<label for="trname">Mobile No.</label>
	        						<input type="text" id="txtmob" class="form-control input-sm">           
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
	        				<div class="form-group">
	        					<label for="trname">Telephone No.</label>  
	        						<input type="text" id="txtteleph" class="form-control input-sm">             
	        				</div>
	        			</div>
	        	</div> 
	        	<div class="row m-t-5" id="existdetailshide">   
	        			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">       
	        				<div class="form-group">
	        					<label for="trname">Contact Person</label>     
	        						<div id="cpersondiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="cpersonsearch.jsp"></jsp:include></div> 
	        						<input type="hidden" id="hidcperson" name="hidcperson" value='<s:property value="hidcperson"/>'>          
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
	        				<div class="form-group">
	        					<label for="trname">Mobile No.</label>
	        						<div id="mobdiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="mobilesearch.jsp"></jsp:include></div> 
	        						<input type="hidden" id="hidmob" name="hidmob" value='<s:property value="hidmob"/>'>         
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">  
	        				<div class="form-group">
	        					<label for="trname">Telephone No.</label>  
	        						<div id="telediv" onkeydown="return (event.keyCode!=13);"><jsp:include page="telephsearch.jsp"></jsp:include></div> 
	        						<input type="hidden" id="hidtel" name="hidtel" value='<s:property value="hidtel"/>'>                   
	        				</div>
	        			</div>
	        	</div> 
		     	<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">
	        				<div class="form-group">
	        					<label for="fromdest">Comm. Mode</label>
	        					<select id="cmbcommmode" class="form-control">
									<option value="">--Select--</option>
									<option value="Call">Call</option>
									<option value="Online Meeting">Online Meeting</option>
									<option value="On Premise">On Premise</option>                   
								</select>
	        				</div>
	        			</div>  
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
							<div class="form-group">
							   <label>Meeting Date and Time</label>
								<div class="row">
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
											<div id="meetdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>	
									</div>
									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
											<div id="meettime" style="border: 1px solid black" placeholder="" style="width:69%;"></div>	
									</div>   
								</div>							        				
				            </div>
					   </div> 
					   <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
	        				<div class="form-group">
	        					<label for="trname">Venue</label>
	        						<input type="text" id="txtvenue" class="form-control input-sm">           
	        				</div>
	        			</div> 
	        		</div>
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	        				<div class="form-group">
	        					<label for="trname">Description</label>  
	        						<input type="text" id="txtdescription" class="form-control input-sm">           
	        				</div>    
	        			</div>
	        		</div>
		
			</div>
			<div class="clear"></div>  
			</div>
			          <div class="modal-footer" style="background-color:#CDFDFA">   
			          <button type="button" class="btn btn-default" onclick="funAppoinmentSave();">SAVE</button>
			            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
			          </div>                 
			        </div>
			      </div>
			    </div>  
  <input type="hidden" name="brhid" id="brhid">  
  <input type="hidden" name="divname" id="divname">           
  <input type="hidden" name="hidcomments" id="hidcomments">
  <input type="hidden" name="enqdocno" id="enqdocno">    
  <input type="hidden" name="enqvocno" id="enqvocno"> 
  <input type="hidden" name="dtype" id="dtype">
  <input type="hidden" name="frmname" id="frmname">        
  <input type="hidden" name="clienttype" id="clienttype">  
  <input type="hidden" name="nextflwuptype" id="nextflwuptype">
  
  <input type="hidden" name="hidrefname" id="hidrefname">
  <input type="hidden" name="hidcldocno" id="hidcldocno">
  <input type="hidden" name="hidclmob" id="hidclmob">
  <input type="hidden" name="hidcltel" id="hidcltel"> 
  <input type="hidden" name="hidmail" id="hidmail"> 
  <input type="hidden" name="hidfax" id="hidfax">   
  <input type="hidden" name="hidcpname" id="hidcpname">
  <input type="hidden" name="hidcpmob" id="hidcpmob">
  <input type="hidden" name="hidcptel" id="hidcptel"> 
  <input type="hidden" name="hidaddress" id="hidaddress">  
  <input type="hidden" name="hidppctrno" id="hidppctrno">
  <input type="hidden" name="clientacid" id="clientacid">   
  <input type="hidden" name="hidsalid" id="hidsalid">
  <input type="hidden" name="hidsalesman" id="hidsalesman">              
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip(); 
    	
    	$("#appntdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
    	$("#appnttime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
    	
    	$("#meetdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
    	$("#meettime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
    	
    	$("#flwupdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
    	$("#flwuptime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
    	
    	$("#appnttime").val(new Date());    
    	$("#meettime").val(new Date());
    	$("#flwuptime").val(new Date());
        readyMethods();      
          
        $('#btnsubmit').click(function(){  
        	clearfields();      
            loads();
            getInitChartData();
        });       
        $('#btnappointment').click(function(){   
	    	$("#modalappointment").modal('toggle');      
        });
        $('#btncreateprospective').click(function(){ 
        	var enqno=$('#enqdocno').val();
        	var cldocno=$('#hidcldocno').val();
        	var ppctrno=$('#hidppctrno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	if(parseInt(cldocno)>0){    
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Client exists!!!'       
				});
	    		return false;
	    	}
	    	if(parseInt(ppctrno)>0){          
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Prospective Client Already Created!!!'         
				});
	    		return false;
	    	}
	    	createProspectiveClient(); 
	    	$("#jqxAppointmentGrid").jqxGrid('clear');
        });
        $('#btnconvert').click(function(){ 
        	var enqno=$('#enqdocno').val();
        	var clientacid=$('#clientacid').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	if(parseInt(clientacid)>0){          
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Already Converted!!!'           
				});
	    		return false;
	    	}
	    	funconverttoclient();      
        });
        $('#btncreateenquiry').click(function(){   
        	var enqno=$('#enqdocno').val();
        	var cldocno=$('#hidcldocno').val();
        	var clientacid=$('#clientacid').val();
        	var divname=$('#divname').val();   
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	if(divname=="pros"){
	    		if(clientacid=="" || clientacid=="0"){             
		    		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please convert to client first!!!'         
					});
		    		return false;
		    	} 
		    }else if(divname=="appnt"){
		    	if(cldocno=="" || cldocno=="0"){     
		    		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please convert to client first!!!'         
					});
		    		return false;
		    	} 
			}else{}  
	    	 
	    	createEnuiry();
	    	 $("#jqxProspectiveGrid").jqxGrid('clear');
        });
        $('#btnnextfollowup').click(function(){ 
        	var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	$('#flwupdiv').load('nextfollowupGrid.jsp?docno='+enqno+'&id=1');  
	    	$("#modalnextfollowup").modal('toggle');
        });
        $('#btnattachs').click(function(){   
        	funAttachs(event);      
        });
        $('#btncomment').click(function(){    
	        var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	 getComments(); 
        }); 
        $('#btnexcel').click(function(){  
           var divname=$("#divname").val();  
      	   if(divname=="pros"){
      	    	 $("#prospectivediv").excelexportjs({
              		containerid: "prospectivediv",       
              		datatype: 'json', 
              		dataset: null, 
              		gridId: "jqxProspectiveGrid", 
              		columns: getColumns("jqxProspectiveGrid") , 
              		worksheetName:"Sales Activity Management - Prospects"
               		});
      	    }
      		if(divname=="enq"){
      			  $("#enquirydiv").excelexportjs({
              		containerid: "enquirydiv",       
              		datatype: 'json', 
              		dataset: null, 
              		gridId: "jqxEnquiryGrid", 
              		columns: getColumns("jqxEnquiryGrid") , 
              		worksheetName:"Sales Activity Management - Enquired"
               		});
      		}		
      		if(divname=="appnt"){
      			  $("#appointmentdiv").excelexportjs({
              		containerid: "appointmentdiv",       
              		datatype: 'json', 
              		dataset: null, 
              		gridId: "jqxAppointmentGrid", 
              		columns: getColumns("jqxAppointmentGrid") , 
              		worksheetName:"Sales Activity Management - Appointments"     
               		});
      		}		
      		if(divname=="quot"){
      	    	 $("#quotediv").excelexportjs({
              		containerid: "quotediv",       
              		datatype: 'json', 
              		dataset: null, 
              		gridId: "jqxQuoteGrid", 
              		columns: getColumns("jqxQuoteGrid") , 
              		worksheetName:"Sales Activity Management - Quote"    
               		});			 
      	    }
        });
        $('#btncommentsend').click(function(){
        	var enqno=$('#enqdocno').val();
        	var txtcomment=$('#txtcomment').val();
        	if(enqno==""){
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
        		$('#jqxEnquiryGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    
    function readyMethods(){  
    	getInitChartData(); 
    	document.getElementById('selecteddiv').innerHTML=" - Prospects";    
    	document.getElementById("divname").value="pros";
    	document.getElementById("dtype").value="PPC";
    	document.getElementById("frmname").value="Prospective Client";  
    	$("#prospective").show();
    	$("#enquiry").hide();
    	$("#quote").hide();
    	$("#appointment").hide(); 
    	document.getElementById('newcontact').checked=true;      
    	$("#existcontacthide").hide();  
    	$("#existdetailshide").hide();      
    	document.getElementById("clienttype").value="New"; 
    	document.getElementById('appntextent').checked=true;  
    	document.getElementById("nextflwuptype").value="Extent"; 
    	$('#btnnextfollowup').attr('disabled', true);
    	$('#btncreateprospective').attr('disabled', true);
    }
    function inputsload(){   
    	var cldocno=$("#hidclientid").val(); 
    	 $('#cpersondiv').load('cpersonsearch.jsp?cldocno='+cldocno+'&id=1');
    	 $('#mobdiv').load('mobilesearch.jsp?cldocno='+cldocno+'&id=1');
    	 $('#telediv').load('telephsearch.jsp?cldocno='+cldocno+'&id=1');
    }
    function funchangeradio(){
    	if(document.getElementById('newcontact').checked){
    		$("#existcontacthide").hide(); 
    		$("#newcontacthide").show(); 
    		$("#existdetailshide").hide(); 
    		$("#newdetailshide").show();   
    		document.getElementById("clienttype").value="New"; 
    		$("#txtclient").val('');
    		$("#hidclientid").val('');
    		$("#jqxclientsearch").val('');
    		$("#txtcperson").val('');
     		$("#txtmob").val('');
     		$("#txtteleph").val('');
     		$("#hidcperson").val('');
     		$("#hidmob").val('');
     		$("#hidtel").val('');
     		$("#jqxcperson").val('');
     		$("#jqxmob").val('');
     		$("#jqxtel").val('');  
    	}
    	if(document.getElementById('existcontact').checked){
    		$("#newcontacthide").hide(); 
    		$("#existcontacthide").show(); 
    		$("#newdetailshide").hide(); 
    		$("#existdetailshide").show();    
    		document.getElementById("clienttype").value="Existing";  
    		$("#txtclient").val('');
    		$("#hidclientid").val('');
    		$("#jqxclientsearch").val('');
    		$("#txtcperson").val('');
     		$("#txtmob").val('');
     		$("#txtteleph").val('');
     		$("#hidcperson").val('');
     		$("#hidmob").val('');
     		$("#hidtel").val('');
     		$("#jqxcperson").val('');
     		$("#jqxmob").val('');
     		$("#jqxtel").val('');   
    	}
    }
    function funfollowupradio(){ 
    	if(document.getElementById('appntflwup').checked){
    		document.getElementById("nextflwuptype").value="Followup";     
    		$("#flwupdesc").val('');
    		$("#flwupdate").val(new Date());
    		$("#flwuptime").val(new Date());  
    	}
    	if(document.getElementById('appntextent').checked){
    		document.getElementById("nextflwuptype").value="Extent";       
    		$("#flwupdesc").val('');
    		$("#flwupdate").val(new Date());
    		$("#flwuptime").val(new Date());  
    	}
    	if(document.getElementById('appntcancel').checked){
    		document.getElementById("nextflwuptype").value="Cancel";         
    		$("#flwupdesc").val('');
    		$("#flwupdate").val(new Date());
    		$("#flwuptime").val(new Date());  
    	}
    }
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("enqdocno").value="";  
    	document.getElementById("enqvocno").value="";  
    	document.getElementById("brhid").value="";  
		document.getElementById("hidcomments").value="";
		document.getElementById("clienttype").value="";
		document.getElementById("nextflwuptype").value="";
		document.getElementById("hidrefname").value="";
		document.getElementById("hidcldocno").value="";
		document.getElementById("hidclmob").value="";
		document.getElementById("hidcltel").value="";
		document.getElementById("hidmail").value="";
		document.getElementById("hidfax").value="";
		document.getElementById("hidcpname").value="";
		document.getElementById("hidcpmob").value="";
		document.getElementById("hidcptel").value="";
		document.getElementById("hidaddress").value="";
		document.getElementById("hidppctrno").value="";
		document.getElementById("clientacid").value="";
		document.getElementById("hidsalid").value="";
		document.getElementById("hidsalesman").value="";  
    }	   
    function getInitChartData(){
		  var x=new XMLHttpRequest();
		  x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				var guagedata=JSON.parse(items);           
		        
	          	$("#pros").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.proscount);
	          	$("#enq").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.enqcount);	
	          	$("#quot").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.quotcount);
	          	$("#appnt").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.appntcount); 
			}
			else{
			}
		}
		x.open("GET","getInitChartData.jsp?brhid="+$("#cmbbranch").val(),true);                        
		x.send();    
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
    	$("#jqxEnquiryGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxEnquiryGrid").jqxGrid('applyfilters');
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#enqdocno').val();
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&enqno="+enqno+"&dtype="+$('#dtype').val(),true);  
		x.send();
    }
    function getComments(){
    	var enqno=$('#enqdocno').val();
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
		x.open("GET","getComments.jsp?enqno="+enqno+"&dtype="+$('#dtype').val(),true);        
		x.send();
    }
   
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var divname=$("#divname").val();
	    var brhid=$("#cmbbranch").val();  
	    
	    if(divname=="pros"){
	    	 $('#prospectivediv').load('prospectiveGrid.jsp?brhid='+brhid+'&id=1');
	    }
		if(divname=="enq"){
			  $('#enquirydiv').load('enquiryGrid.jsp?brhid='+brhid+'&id=1');
		}		
		if(divname=="appnt"){
			  $('#appointmentdiv').load('appointmentGrid.jsp?brhid='+brhid+'&id=1');
		}		
		if(divname=="quot"){
	    	 $('#quotediv').load('quoteGrid.jsp?brhid='+brhid+'&id=1');    
	    }
    }   

	function funAttachs(event){
		if($("#dtype").val()!="APNT"){   
			var brchid=$("#brhid").val();       
	   		var docno=document.getElementById("enqvocno").value; 
		}else{
			var brchid=1;       
	   		var docno=document.getElementById("enqdocno").value;         
		}  
		var frmdet=$("#dtype").val();      
		var fname=$("#frmname").val();
   		var url=document.URL;
		var reurl=url.split("/com/");
 		if(docno!="" && docno!="0"){                
   		    var  myWindow= window.open(reurl[0]+"/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
   		}else{   
			swal({
				type: 'warning',
				title: 'Warning',
				text: 'Select a Document....!'                                   
			});
			return;
		    }               
	   }  
	$('div').click(function() {
		  var divid=$(this).attr('id');  
		  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
			  var realid=divid.replace(/div/g, "");
			  if(realid=="enq" || realid=="pros" || realid=="appnt" || realid=="quot"){    
				  clearfields();      
				  var widgetid="enquirylist";   
				  document.getElementById("divname").value=realid;       
				  loads();            
			  }
			  if(realid=="pros"){ 
				  document.getElementById('selecteddiv').innerHTML=" - Prospects";
				  $("#prospective").show();
			      $("#enquiry").hide();
			      $("#quote").hide();
			      $("#appointment").hide();   
			      $('#btnnextfollowup').attr('disabled', true);
			      document.getElementById("dtype").value="PPC";
			      document.getElementById("frmname").value="Prospective Client"; 
			      $('#btnconvert').attr('disabled', false);
			      $('#btncreateprospective').attr('disabled', true);
			      $('#btncreateenquiry').attr('disabled', false);  
			  }else if(realid=="enq"){
				  document.getElementById('selecteddiv').innerHTML=" - Enquiry";
				  $("#prospective").hide();
			      $("#enquiry").show();
			      $("#quote").hide();
			      $("#appointment").hide();
			      $('#btnnextfollowup').attr('disabled', true);
			      document.getElementById("dtype").value="ENQ";
			      document.getElementById("frmname").value="Enquiry"; 
			      $('#btnconvert').attr('disabled', true);
			      $('#btncreateprospective').attr('disabled', true);
			      $('#btncreateenquiry').attr('disabled', true); 
			  }else if(realid=="appnt"){
				  document.getElementById('selecteddiv').innerHTML=" - Appointment";  
				  $("#prospective").hide();
			      $("#enquiry").hide();
			      $("#quote").hide();
			      $("#appointment").show();
			      $('#btnnextfollowup').attr('disabled', false);
			      document.getElementById("dtype").value="APNT";
			      document.getElementById("frmname").value="Appointment";
			      $('#btnconvert').attr('disabled', true);
			      $('#btncreateprospective').attr('disabled', false);
			      $('#btncreateenquiry').attr('disabled', false);   
			  }else if(realid=="quot"){
				  document.getElementById('selecteddiv').innerHTML=" - Quote";  
				  $("#prospective").hide();
			      $("#enquiry").hide();
			      $("#quote").show();
			      $("#appointment").hide();
			      $('#btnnextfollowup').attr('disabled', true);  
			      document.getElementById("dtype").value="SQOT";       
			      document.getElementById("frmname").value="Quotation"; 
			      $('#btnconvert').attr('disabled', true);
			      $('#btncreateprospective').attr('disabled', true);    
			      $('#btncreateenquiry').attr('disabled', true); 
			  }else{}            
		  }
	  });
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
	 
	 function funAppoinmentSave(){   
	    	var cldocno=document.getElementById("hidclientid").value; 
	    	var clienttype=document.getElementById("clienttype").value;
	    	if(clienttype==""){	    		
	    	clienttype="New";
	    	}
	    	var client=document.getElementById("txtclient").value;
	    	var appntdate=$('#appntdate').jqxDateTimeInput('val');
	    	var appnttime=document.getElementById("appnttime").value;  
	    	var meetdate=$('#meetdate').jqxDateTimeInput('val');
	    	var meettime=document.getElementById("meettime").value;
	    	var venue=document.getElementById("txtvenue").value;
	    	var description=document.getElementById("txtdescription").value;  
	    	var commmode=document.getElementById("cmbcommmode").value; 
	    	if(clienttype=="New"){
	    		var cperson=document.getElementById("txtcperson").value;
	    		var mob=document.getElementById("txtmob").value;
	    		var tel=document.getElementById("txtteleph").value;
	    	}else{
	    		var cperson=document.getElementById("hidcperson").value;
	    		var mob=document.getElementById("hidmob").value;
	    		var tel=document.getElementById("hidtel").value;   
	    	}  
	    	
	    	if(client=="" && cldocno==""){                  
		         swal({
						type: 'warning',   
						title: 'Warning',
						text: 'Please select client'  	  		
				}); 
		    }
	    	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	if(r==false)
			     	  {
			     		return false;    
			     	  }  
			     	else {
			    	     saveAppoinment(cldocno,clienttype,appntdate,appnttime,client,meetdate,meettime,venue,cperson,description,commmode,mob,tel);         
			     	}  
			 });      
	    	
	    }    
	    function saveAppoinment(cldocno,clienttype,appntdate,appnttime,client,meetdate,meettime,venue,cperson,description,commmode,mob,tel){            
	    	var x=new XMLHttpRequest();
	    	x.onreadystatechange=function()
	    			{
	    				if(x.readyState==4 && x.status==200)
	    				{
	    					var msg=x.responseText.trim();
	    					// alert(msg);
	    					if(parseInt(msg)==1){    
	    			            	  swal({   
	    									type: 'success',
	    									title: 'Message',
	    									text: 'Successfully Saved'      
	    								});
	    			            	  document.getElementById("hidclientid").value="";
	    			            	  document.getElementById("jqxclientsearch").value="";
	    			            	  document.getElementById("clienttype").value=""; 
	    			            	  document.getElementById("txtclient").value="";  
	    			            	  $('#meetdate').val(new Date());  
	    			            	  $('#appntdate').val(new Date());  
	    			            	  document.getElementById("appnttime").value="";  
	    			            	  document.getElementById("meettime").value="";
	    			            	  document.getElementById("txtvenue").value="";
	    			            	  document.getElementById("txtcperson").value="";
	    			            	  $("#txtmob").val('');
	    			          		  $("#txtteleph").val('');
	    			          		  $("#hidcperson").val('');
	    			          		  $("#hidmob").val('');
	    			          		  $("#hidtel").val('');
	    			          		  $("#jqxcperson").val('');
	    			          		  $("#jqxmob").val('');
	    			          		  $("#jqxtel").val('');   
	    			            	  document.getElementById("txtdescription").value=""; 
	    			            	  document.getElementById("cmbcommmode").value="";  
	    			            	  getInitChartData(); 
	    			            	  loads();   
								      $('#modalappointment').modal('toggle');   
								 							      
	    			              } else{   
	    		            	swal({
	    							type: 'error',
	    							title: 'Message',    
	    							text: 'Not Saved'                      
	    						});    
	    		            }
	    				}            
	    			}      
	    			x.open("GET","appoinmentCreate.jsp?cldocno="+cldocno+"&mob="+mob+"&tel="+tel+"&clienttype="+clienttype+"&actdate="+appntdate+"&acttime="+appnttime+"&client="+client+"&commmode="+commmode+"&meetdate="+meetdate+"&meettime="+meettime+"&venue="+venue+"&cperson="+cperson+"&description="+description,true);
	    			x.send();
	    } 
	    function funnextfollowup(){      
	    	var flwupdate=$('#flwupdate').jqxDateTimeInput('val');
	    	var flwuptime=document.getElementById("flwuptime").value;  
	    	var flwupdesc=document.getElementById("flwupdesc").value; 
	    	var docno=document.getElementById("enqdocno").value;   
	    	var nextflwuptype=document.getElementById("nextflwuptype").value;
	    	$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	if(r==false)
			     	  {
			     		return false;    
			     	  }  
			     	else {
			     		saveNextfollowup(flwupdate,flwuptime,flwupdesc,docno,nextflwuptype);            
			     	}  
			 });      
	    	
	    }    
	    function saveNextfollowup(flwupdate,flwuptime,flwupdesc,docno,nextflwuptype){                    
	    	var x=new XMLHttpRequest();
	    	x.onreadystatechange=function()
	    			{
	    				if(x.readyState==4 && x.status==200)
	    				{
	    					var msg=x.responseText.trim();
	    					// alert(msg);
	    					if(parseInt(msg)==1){    
	    			            	  swal({   
	    									type: 'success',
	    									title: 'Message',
	    									text: 'Successfully Saved'      
	    								});
	    			            	  $("#flwupdesc").val('');
	    			          		  $("#flwupdate").val(new Date());
	    			          		  $("#flwuptime").val(new Date()); 
	    			          		  loads();  
								      $('#modalnextfollowup').modal('toggle');        
	    			              } else{   
	    		            	swal({
	    							type: 'error',
	    							title: 'Message',    
	    							text: 'Not Saved'                      
	    						});    
	    		            }
	    				}            
	    			}      
	    			x.open("GET","saveNextfollowup.jsp?flwupdate="+flwupdate+"&flwuptime="+flwuptime+"&flwupdesc="+flwupdesc+"&docno="+docno+"&nextflwuptype="+nextflwuptype,true);      
	    			x.send();
	    }
	    
		function createProspectiveClient(){  
			var client=document.getElementById("hidrefname").value;   
			var mob=document.getElementById("hidclmob").value;
			var tel=document.getElementById("hidcltel").value;
			var mail=document.getElementById("hidmail").value;
			var fax=document.getElementById("hidfax").value;
			var cperson=document.getElementById("hidcpname").value;
			var cpmob=document.getElementById("hidcpmob").value;
			var cptel=document.getElementById("hidcptel").value;  
			var apntdocno=document.getElementById("enqdocno").value;  
			
			var path1="/com/project/leadmanagement/prospectiveclient/prospectiveclient.jsp";  
		    var name="Prospective Client";
			var url=document.URL;
			var reurl=url.split("/com/");

			window.parent.formName.value="Prospective Client";     
			window.parent.formCode.value="PPC";
			var detName="Prospective Client";
			var mode="A";
			var path= path1+"?mod="+mode+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&mob="+mob+"&tel="+tel+"&apntdocno="+apntdocno
					  +"&fax="+fax+"&mail="+mail.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cperson="+cperson.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cpmob="+cpmob+"&cptel="+cptel;  
			 
			  top.addTab( detName,reurl[0]+""+path);
		}
	    
		function createEnuiry(){    
			var client=document.getElementById("hidrefname").value;  
			var cldocno=document.getElementById("hidcldocno").value;
			var mob=document.getElementById("hidclmob").value;
			var tel=document.getElementById("hidcltel").value;
			var mail=document.getElementById("hidmail").value;
			var fax=document.getElementById("hidfax").value;  
			var address=document.getElementById("hidaddress").value; 
			var salid=document.getElementById("hidsalid").value;
			var salesman=document.getElementById("hidsalesman").value;    
			 var path1="com/operations/marketing/enquirynew/enquiry.jsp";    
		     var name="Enquiry";
			 var url=document.URL;
			 var reurl=url.split("/com/");

			 window.parent.formName.value="Enquiry";   
			 window.parent.formCode.value="ENQ";
			 var detName="Enquiry";
			 var mode="A";  
			 var path= path1+"?mod="+mode+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&mob="+mob+"&telno="+tel+"&salid="+salid+"&salesman="+salesman.replace("/\s/g","%20").replace('#','%23').replace('&','%26')  
			  +"&fax="+fax+"&address="+address.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&mail="+mail.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cldocno="+cldocno;   
			 top.addTab( detName,reurl[0]+"/"+path);
		}  
		
		function funconverttoclient(){        
	    	var trno=document.getElementById("enqdocno").value;  
	    	var brhid=document.getElementById("brhid").value;  
	    	$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	if(r==false)
			     	  {
			     		return false;    
			     	  }  
			     	else {
			     		converttoclient(trno,brhid);            
			     	}  
			 });      
	    	
	    }    
	    function converttoclient(trno,brhid){                         
	    	var x=new XMLHttpRequest();
	    	x.onreadystatechange=function()
	    			{
	    				if(x.readyState==4 && x.status==200)
	    				{
	    					var msg=x.responseText.trim().split("::");  
	    					if(parseInt(msg[0])>0){         
	    			            	  swal({   
	    									type: 'success',
	    									title: 'Message',
	    									text: 'Successfully Converted'        
	    								});
	    			          		  loads(); 
	    			          		  $("#clientacid").val(msg[1]);    
	    			              } else{   
	    		            	swal({
	    							type: 'error',
	    							title: 'Message',    
	    							text: 'Not Converted'                         
	    						});    
	    		            }
	    				}            
	    			}        
	    		x.open("GET","convertToClient.jsp?trno="+trno+"&brhid="+brhid,true);                
	    		x.send();
	      }   
  </script>
</body>
</html>
