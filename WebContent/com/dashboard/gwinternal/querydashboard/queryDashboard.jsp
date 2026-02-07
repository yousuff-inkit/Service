<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Query Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">
<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
<link href="css/util.css" rel="stylesheet" />

  <style type="text/css">
  	:root {
	    --theme-deafult: #7366ff;
	    --theme-secondary: #f73164;
	}
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../vendors/fonts/Poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../vendors/fonts/Poppins/Poppins-Medium.ttf'); 
	}
	html,body{
		width:100%;
		height:100%;
		/* background-color:#E9E9E9; */
		font-family: Poppins-Regular, sans-serif;
	}
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
	
	.card-item{
		background-color: #fff;
	    padding-left: 10px;
	    padding-right: 10px;
	    border-radius: 4px;
	    padding-top: 1px;
	    padding-bottom: 4px;
	    margin-bottom:8px;
	    box-shadow:0 5px 10px rgba(154,160,185,.05), 0 15px 40px rgba(166,173,201,.2);
		background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		box-shadow: 0 2px 4px 0 rgb(62 57 107 / 13%);
		position:relative;
		transition:all 0.3s ease;
		cursor:pointer;
		
	}
	
	.card-item:hover,.card-item.active{
		transform:scale(1.1);
	}
	.card-item.active{
		border-bottom: 5px solid #08ad13;
	}
	.card-item:hover svg,.card-item.active svg {
		transform:rotate(12deg);
	}
	.card-item h2{
		margin-top: 5px;
    	margin-bottom: 5px;
    	color:#fff;
    	display:inline-block;
	}
	.card-item h6{
		color:#fff;
		letter-spacing:0.2px;
		font-weight:200;
		display:inline-block;
	}
	.card-item .progress{
		height: 6px;
    	margin-bottom: 6px;
		background-color:#fff;
	}
	.card-item .progress .progress-bar{
		background-color:var(--theme-secondary);
		opacity:0.7;
	}
	.card-item small{
		color: #f8f9fa;
		display:block;
	}
	.card-item svg.icon-bg{
		position: absolute;right: 2px;
		width: 48px;height:48px;opacity: 0.5;
		transition:all 0.3s ease;
		stroke:#fff;
	}
	button[data-dismiss="modal"] {
		background-color:#fff;
	}
	.modal .well{
		padding:15px;
		margin-bottom:10px;
	}
	.modal .well fieldset legend{
		margin-bottom:10px;
	}
	.border{
		border:1px solid #000;
	}
  </style>
</head>
<body>
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
  
  
  
    <div class="warningpanel custompanel">
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnna" data-toggle="tooltip" title="Not Acknowledge" data-placement="bottom" data-filtervalue="" data-datafield="priority" data-filtertype="stringfilter" data-filtercondition="empty"><i class="fa fa-cogs " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-na">3</span>
          </div>	
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btncs" data-toggle="tooltip" title="Complete Stopage" data-placement="bottom"  data-filtervalue="Complete Stopage" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-stop " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-cs">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnro" data-toggle="tooltip" title="Restricted Operation" data-placement="bottom"   data-filtervalue="Restricted Operation" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-renren " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-ro">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnmi" data-toggle="tooltip" title="Minor Issue" data-placement="bottom"  data-filtervalue="Minor Issue" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-bug fa-lg " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-mi">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btndc" data-toggle="tooltip" title="Data Correction" data-placement="bottom" data-filtervalue="Data Correction" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-edit " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-dc">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnnw" data-toggle="tooltip" title="New Request" data-placement="bottom" data-filtervalue="New Request" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-plus-square " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-nw">3</span>
          </div>
        <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnscr" data-toggle="tooltip" title="System Check Required" data-placement="bottom" data-filtervalue="System Check Required" data-datafield="priority" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-desktop " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-scr">3</span>
          </div>
          
          
          
          
          
        </div>
      <div class="warningpanel1 custompanel">
  
           <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnentered" data-toggle="tooltip" title="Entered" data-placement="bottom" data-filtervalue="entered" data-datafield="assignstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-plus " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-entered">3</span>
          </div>	
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btndocumented" data-toggle="tooltip" title="Documented" data-placement="bottom"  data-filtervalue="Documented" data-datafield="assignstatus" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-file " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-documented">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnstarted" data-toggle="tooltip" title="Started" data-placement="bottom"   data-filtervalue="Started" data-datafield="assignstatus" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-tasks " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-started">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnonhold" data-toggle="tooltip" title="On Hold" data-placement="bottom"  data-filtervalue="On Hold" data-datafield="assignstatus" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-pause " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-onhold">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btncompleted" data-toggle="tooltip" title="Completed" data-placement="bottom" data-filtervalue="Completed" data-datafield="assignstatus" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-check-circle-o " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-completed">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btntandc" data-toggle="tooltip" title="Tested and Confirmed" data-placement="bottom" data-filtervalue="Tested and Confirmed" data-datafield="assignstatus" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-thumbs-o-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-tandc">3</span>
          </div>
        <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btndandc" data-toggle="tooltip" title="Deployed and Communicated" data-placement="bottom" data-filtervalue="Deployed and Communicated" data-datafield="assignstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-paper-plane " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-dandc">3</span>
          </div>
           <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btncc" data-toggle="tooltip" title="Client Confirmed" data-placement="bottom" data-filtervalue="Client Confirmed" data-datafield="assignstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-handshake-o " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-cc">3</span>
          </div>
          
          
  </div>
     <div class="primarypanel custompanel">
               	<button type="button" class="btn btn-default" id="btndepstatus" data-toggle="tooltip" title="Department Wise Status" data-placement="bottom" ><i class="fa fa-list-alt " aria-hidden="true"></i></button>
     
  			</div>
  		
  
  
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 panel-container" >
        <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        	<select name="cmbcompany" id="cmbcompany" style="max-width:200px;"><option value="">--Select--</option></select>
        	<select name="cmbuser" id="cmbuser" style="max-width:200px;"><option value="">--Select--</option></select>
        	<select name="cmbtype" id="cmbtype" style="max-width:200px;"><option value="1">Queries</option><option value="2">Change Request</option><option value="3">Project Management</option></select>
        </div>
        <!-- <div class="actionpanel custompanel">
          <button type="button" class="btn btn-default" id="btnvehmovupdate" data-target="#modalvehmovupdate" ><i class="fa fa-car " aria-hidden="true" data-toggle="tooltip" title="Vehicle Movement Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnjobstatus"  data-target="#modaljobstatus" ><i class="fa fa-filter " aria-hidden="true" data-toggle="tooltip" title="Job Status" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnteamselection" data-target="#modalteamselection"><i class="fa fa-users " aria-hidden="true" data-toggle="tooltip" title="Team Selection" data-placement="bottom"></i></button>
        </div> -->
        <!-- <div class="warningpanel custompanel">
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnpartsdelay" data-toggle="tooltip" title="Parts Delay" data-placement="bottom" data-filtervalue="Delayed" data-datafield="partsstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-cogs " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-partsdelay">3</span>
          </div>	
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnhrsexceeded" data-toggle="tooltip" title="Hours Exceeded" data-placement="bottom"  data-filtervalue="0" data-datafield="hrsdiff" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-hourglass-2 " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-hrsexceeded">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnoverdue" data-toggle="tooltip" title="Overdue" data-placement="bottom"   data-filtervalue="0" data-datafield="promiseddate" data-filtertype="datefilter"  data-filtercondition="LESS_THAN"><i class="fa fa-toggle-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-overdue">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnextendeddate" data-toggle="tooltip" title="Extended Date" data-placement="bottom"  data-filtervalue="0" data-datafield="extdate" data-filtertype="datefilter"  data-filtercondition="NOT_NULL"><i class="fa fa-level-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-extendeddate">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnhighpriority" data-toggle="tooltip" title="High Priority" data-placement="bottom" data-filtervalue="High" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-exclamation-triangle " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-highpriority">3</span>
          </div>
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnunattended" data-toggle="tooltip" title="Un Attended" data-placement="bottom" data-filtervalue="0" data-datafield="unattendedstatus" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-low-vision " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-unattended">3</span>
          </div>
        	
        </div> -->
        <div class="detailpanel custompanel">
          <button type="button" class="btn btn-default" id="btnacknowledge" ><i class="fa fa-handshake-o" aria-hidden="true" data-toggle="tooltip" title="Acknowledge" data-placement="bottom"></i></button>
    	  <button type="button" class="btn btn-default" id="btnedd" ><i class="fa fa-edit" aria-hidden="true" data-toggle="tooltip" title="Update Expected Delivery Date" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnmail"><i class="fa fa-envelope" aria-hidden="true" data-toggle="tooltip" title="Send Mail" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnstatusupdate" ><i class="fa fa-check-square-o" aria-hidden="true" data-toggle="tooltip" title="Status Update" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnattach" ><i class="fa fa-paperclip" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnchangereq" ><i class="fa fa-archive" aria-hidden="true" data-toggle="tooltip" title="Change Request" data-placement="bottom"></i></button>
           <button type="button" class="btn btn-default" id="btnprgmgmt" ><i class="fa fa-file-text" aria-hidden="true" data-toggle="tooltip" title="Project Management" data-placement="bottom"></i></button>
        </div>
        <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        <div class="textpanel custompanel">
			<p style="word-wrap:break-word;">&nbsp;</p>
        </div>
      </div>
    </div>
    <div class="row">
    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        	<div id="querygriddiv"><jsp:include page="queryGrid.jsp"></jsp:include></div>
      	</div>
    </div>
    <div class="row">
    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        	<div id="queryfollowupgriddiv"><jsp:include page="queryFollowupGrid.jsp"></jsp:include></div>
      	</div>
    </div>
    
	
	<!-- Acknowldgement Modal-->
	<div id="modalacknowledge" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Acknowldgement</h4>
          		</div>
          		<div class="modal-body container-fluid">
            		<div class="form-horizontal">
            			<div class="form-group">
		    				<label class="control-label col-sm-3" for="cmbformname">Form Name:</label>
		    				<div class="col-sm-9">
		      					<select id="cmbformname" name="cmbformname" class="form-control" style="width:100%;">
		      						<option value="">--Select--</option>
		      					</select>
		    				</div>
		  				</div>
		  				<div class="form-group">
		    				<label class="control-label col-sm-3" for="cmbpriority">Priority:</label>
		    				<div class="col-sm-9">
		      					<select id="cmbpriority" name="cmbpriority" class="form-control" style="width:100%;">
		      						<option value="">--Select--</option>
		      						<option value="CS">Complete Stoppage</option>
		      						<option value="RO">Restricted Operation</option>
		      						<option value="MI">Minor Issue</option>
		      						<option value="DCUM">Data Correction - User Mistake</option>    
		      						<option value="DCSE">Data Correction - System Error</option>
		      						<option value="NW">New Request</option>
		      					    <option value="SCR">System Check Required</option>
		      						
		      					</select>
		    				</div>
		  				</div>
		  				<div class="form-group">
		    				<label class="control-label col-sm-3" for="cmbdeptype">Department:</label>
		    				<div class="col-sm-9">
		      					<select id="cmbdeptype" name="cmbdeptype" class="form-control" style="width:100%;">
		      						<option value="">--Select--</option>
		      					</select>
		    				</div>
		  				</div>
		  				 <div class="form-group">
		    				<label class="control-label col-sm-3" for="eddate">Exp.Del.Date:</label>
		    				<div class="col-sm-9">
                 <table>
                 <tr>
                 <td>
                 </td>
                 <td></td>
		      <td align="left"><div id='eddate' name='eddate'></div></td></tr>  
		      </table>
		      </div>
		      </div>   
            
		  				<div class="form-group">
		    				<label class="control-label col-sm-3" for="ackremarks">Remarks:</label>
		    				<div class="col-sm-9">
		      					<input type="text" name="ackremarks" id="ackremarks" class="form-control" placeholder="Enter Remarks">
		    				</div>
		  				</div>
            		</div>
          		</div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            		<button type="button" class="btn btn-default btn-primary btn-acknowledge-save">Save Changes</button>
          		</div>
        	</div>
      	</div>
    </div>
	
	
	<!-- EDD Modal-->
	<div id="modaledd" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Updation of Acknowldgement</h4>
          		</div>
          		<div class="modal-body container-fluid">
            		<div class="form-horizontal">
            			
		  				
		  				<div class="form-group">
		    				<label class="control-label col-sm-3" for="cmbdeptype1">Department:</label>
		    				<div class="col-sm-9">
		      					<select id="cmbdeptype1" name="cmbdeptype1" class="form-control" style="width:100%;">
		      						<option value="">--Select--</option>
		      					</select>
		      			    <input type="hidden" id="hidcmbdeptype1" name="hidcmbdeptype1" value='<s:property value="hidcmbdeptype1"/>'/>
		      					
		    				</div>
		  				</div>
		  				 <div class="form-group">
		    				<label class="control-label col-sm-3" for="eddate1">Exp.Del.Date:</label>
		    				<div class="col-sm-9">
                 <table>
                 <tr>
                 <td>
                 </td>
                 <td></td>
		      <td align="left"><div id='eddate1' name='eddate1'></div></td></tr>  
		      </table>
		      </div>
		      </div>   
            
		  			
            		</div>
          		</div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            		<button type="button" class="btn btn-default btn-primary btn-edd-save">Save Changes</button>
          		</div>
        	</div>
      	</div>
    </div>
	
	
	
	
	
	<!-- Acknowldgement Modal-->
	<div id="modalstatusupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Status Update</h4>
          		</div>
          		<div class="modal-body container-fluid">
            		<div class="form-horizontal">
            			<div class="form-group">
		    				<label class="control-label col-sm-3" for="cmbstatus">Status:</label>
		    				<div class="col-sm-9">
		      					<select id="cmbstatus" name="cmbstatus" class="form-control" style="width:100%;">
		      						<option value="">--Select--</option>
		      					</select>
		    				</div>
		  				</div>
		  				<div class="form-group">
		    				<label class="control-label col-sm-3" for="cmbpriority">Priority:</label>
		    				<div class="col-sm-9">
		      					<input type="text" name="priorityseqno" id="priorityseqno" class="form-control">
		    				</div>
		  				</div>
		  				<div class="form-group">
		    				<label class="control-label col-sm-3" for="statusremarks">Remarks:</label>
		    				<div class="col-sm-9">
		      					<input type="text" name="statusremarks" id="statusremarks" class="form-control" placeholder="Enter Remarks">
		    				</div>
		  				</div>
		  				<div class="form-group">
		    				<label class="control-label col-sm-3" for="cmbmember">Assign User:</label>
		    				<div class="col-sm-9">
		      					<select id="cmbmember" name="cmbmember" class="form-control" style="width:100%;">
		      						<option value="">--Select--</option>
		      					</select>
		    				</div>
		  				</div>
            		</div>
          		</div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            		<button type="button" class="btn btn-default btn-primary btn-status-save">Save Changes</button>
          		</div>
        	</div>
      	</div>
    </div>
    
    
    
	<!-- Depwise Status Modal-->
	<div id="modaldepstatus" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">DepartmentWise Status </h4>
          		</div>
          		
            		<div class="row">      
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
		        <div id="depstatusdiv"><jsp:include page="depwiseGrid.jsp"></jsp:include></div>                          
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
  </div>
    <input type="hidden" name="hiddeptype" id="hiddeptype">
    <input type="hidden" name="hideddate" id="hideddate">
  
  <input type="hidden" name="docno" id="docno">
  <input type="hidden" name="vocno" id="vocno">
  <input type="hidden" name="rowindex" id="rowindex">
  <input type="hidden" name="z2count" id="z2count">
  <input type="hidden" name="z3count" id="z3count">
  <input type="hidden" name="z4count" id="z4count">
  <input type="hidden" name="z5count" id="z5count">
  <input type="hidden" name="z6count" id="z6count">
  <input type="hidden" name="z7count" id="z7count">
  <input type="hidden" name="z8count" id="z8count">
  <input type="hidden" name="z9count" id="z9count">
  <input type="hidden" name="z10count" id="z10count">
  <input type="hidden" name="z11count" id="z11count">
  <input type="hidden" name="z12count" id="z12count">
  <input type="hidden" name="z13count" id="z13count">
  <input type="hidden" name="z14count" id="z14count">
  
  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!--  -->
<!-- <script src="../vendors/jquery/jquery-3.2.1.min.js"></script> -->
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
	
    $(document).ready(function(){
    	var mainpanelwidth=$('.panel-container').outerWidth();
    	var panelwidth=0;
    	$('.panel-container div.custompanel:not(.textpanel)').each(function(){
    		panelwidth+=$(this).outerWidth();
    	});
    	$('.textpanel').css('width',((mainpanelwidth-panelwidth)-350)+'px');
        $('[data-toggle="tooltip"]').tooltip();
        $('#cmbcompany').select2({
        	placeholder:"Select Company",
        	allowClear:true
        });
        $('#cmbuser').select2({
        	placeholder:"Select User",
        	allowClear:true
        });
        $('#cmbtype').select2();
        $('#cmbformname').select2({
        	placeholder:"Select Form Name",
        	allowClear:true
        });
        $('#cmbdeptype').select2({
        	placeholder:"Select Department ",
        	allowClear:true
        });
        $('#cmbpriority').select2({
        	placeholder:"Select Priority",
        	allowClear:true
        });
        $('#cmbstatus').select2({
        	placeholder:"Select Status",
        	allowClear:true
        });
        funGetCountData();
        funGetCountPriority();        //funGetFilterData();
        
        $('.load-wrapp').hide();
		 $("#eddate").jqxDateTimeInput({ width: '130px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#eddate1").jqxDateTimeInput({ width: '130px', height: '15px',formatString:"dd.MM.yyyy"});
		 var comprefid=$('#cmbcompany').val();
     	var empdocno=$('#cmbuser option:selected').attr('data-empdocno');
     	var type=$('#cmbtype').val();
     	$('#querygriddiv').load('queryGrid.jsp?type='+type+'&id=1&comprefid='+comprefid+'&empdocno='+empdocno);
     
        $('#btnattach').click(function(){
        	var targetid=$(this).attr('id');
        	var rowindex=$('#rowindex').val();
        	var docno=$('#queryGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	if(selecteddocs.length!=1){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select a single document'
				});
				return false;
        	}
        	if(selecteddocs.length==1){
        		docno=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'doc_no');
        	}
        	var frmdet="GWQ";
			var frmname="GW Query";             
			var brhid=1;               
			var myWindow=window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
        	
        });
        
        $('#btnsubmit').click(function(){
        	//funGetFilterData();
        	$('.page-loader').show();
        	var comprefid=$('#cmbcompany').val();
        	var empdocno=$('#cmbuser option:selected').attr('data-empdocno');
        	var type=$('#cmbtype').val();
        	$('#querygriddiv').load('queryGrid.jsp?type='+type+'&id=1&comprefid='+comprefid+'&empdocno='+empdocno);
        	funGetCountPriority();
        });
        
        $('#btnexcel').click(function(){
        	$("#queryGrid").excelexportjs({
				containerid: "queryGrid",
				datatype: 'json',
				dataset: null,
				gridId: "queryGrid",
				columns: getColumns("queryGrid"),
				worksheetName: "Query Management Data"
			});
        });
  		
  		$('#btnchangereq').click(function(){
  			var rowindex=$('#rowindex').val();
        	/*if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var docnoarray=new Array();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	else{
        		for(var i=0;i<selecteddocs.length;i++){
        			docnoarray.push($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no'));
        		}
        	}
        	
        	Swal.fire({
  				title: 'Are you sure?',
  				text: "Do you want to change request of Ticket#"+$('#docno').val(),
  				icon: 'warning',
  				showCancelButton: true,
  				confirmButtonColor: '#3085d6',
  				cancelButtonColor: '#d33',
  				confirmButtonText: 'Yes'
			}).then((result) => {
  				if (result.isConfirmed) {
  					$.post('saveChangeRequest.jsp',
					{
						'docnoarray[]':docnoarray,
						docno:$('#docno').val()
						/*comprefid:$('#queryGrid').jqxGrid('getcellvalue',rowindex,'comprefid')*/
					},
					function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=='0'){
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Ticket #'+data.docno+' change requested Successfully'
							});
							$('.modal.in').modal('hide');
							$('#btnsubmit').trigger('click');
						}
						else{
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Updated'
							});
						}
					});
  				}
  			});
  		});      
  		$('#btnprgmgmt').click(function(){
  			var rowindex=$('#rowindex').val();
        	/*if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var docnoarray=new Array();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	else{
        		for(var i=0;i<selecteddocs.length;i++){
        			docnoarray.push($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no'));
        		}
        	}
        	
        	Swal.fire({
  				title: 'Are you sure?',
  				text: "Do you want to Project Management of Ticket#"+$('#docno').val(),
  				icon: 'warning',
  				showCancelButton: true,
  				confirmButtonColor: '#3085d6',
  				cancelButtonColor: '#d33',
  				confirmButtonText: 'Yes'
			}).then((result) => {
  				if (result.isConfirmed) {
  					$.post('saveProjectMangement.jsp',   
					{
						'docnoarray[]':docnoarray,
						docno:$('#docno').val()
						/*comprefid:$('#queryGrid').jqxGrid('getcellvalue',rowindex,'comprefid')*/
					},
					function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=='0'){
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Ticket #'+data.docno+' Project Management Successfully'
							});
							$('.modal.in').modal('hide');
							$('#btnsubmit').trigger('click');
						}
						else{
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Updated'
							});
						}
					});
  				}
  			});
  		});      
        $('#btnacknowledge').click(function(){
        	var rowindex=$('#rowindex').val();
        	/*
        	if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var docnoarray=new Array();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	var errorstatus=0;
        	for(var i=0;i<selecteddocs.length;i++){
        		if(parseInt($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'processstatus'))>1){
	        		Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Already Acknowledged'
					});
					errorstatus=1;
	        		return false;
	        	}	
        	}
        	if(errorstatus==1){
	        	return false;
        	}
        	var strdocno='';
        	for(var i=0;i<selecteddocs.length;i++){
        		if(strdocno==''){
	        		strdocno+=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
	        	}	
	        	else{
	        		strdocno+=','+$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
	        	}
        	}
       		$('#modalacknowledge').find('.modal-title').text('Acknowledgement of Ticket #'+strdocno);
       		$('#modalacknowledge').modal('show');
        });
        
        $('#btnedd').click(function(){
        	var rowindex=$('#rowindex').val();
     
        	var docnoarray=new Array();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	var errorstatus=0;
        	/* for(var i=0;i<selecteddocs.length;i++){
        		//alert($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'eddate'));
        		if($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'eddate')==''){
	        		Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Please Enter Expected Delivery Date'
					});
					errorstatus=1;
	        		return false;
	        	}	
        	}
        	if(errorstatus==1){
	        	return false;
        	} */
        	var strdocno='',streddate='',strdepid='',strdep='';
        	for(var i=0;i<selecteddocs.length;i++){
        		if(strdocno==''){
	        		strdocno+=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
	        	
	        	}	
	        	else{
	        		strdocno+=','+$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
	        	}
        		 streddate=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'eddate');
        		 strdepid=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'deptypeid');
        		 strdep=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'deptype');

        		 //alert(streddate);
        		// alert(strdep);
        	}
    		$('#cmbdeptype1').val(strdep);

    		$('#hidcmbdeptype1').val(strdepid);
    		if($('#hidcmbdeptype1').val()!= null){
				document.getElementById("cmbdeptype1").value=document.getElementById("hidcmbdeptype1").value;
				//funreload(event);       
    		}
    		$('#eddate1').val(streddate);

       		$('#modaledd').find('.modal-title').text('Updation of Acknowledgement of Ticket #'+strdocno);
       		$('#modaledd').modal('show');
        });
         
        
        $('#btndepstatus').click(function(){
     
        	 $('#depstatusdiv').load('depwiseGrid.jsp?');       
 	    	$("#modaldepstatus").modal('toggle');  
        });
         
        
        
        $('#btnstatusupdate').click(function(){
        	var rowindex=$('#rowindex').val();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	/*if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var errorstatus=0;
        	for(var i=0;i<selecteddocs.length;i++){
        		if(parseInt($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'processstatus'))<3){
	        		Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Please mail the ticket'
					});
					errorstatus=1;
	        		return false;
	        	}	
        	}
        	if(errorstatus==1){
	        	return false;
        	}
        	
       		var strdocno='';
        	for(var i=0;i<selecteddocs.length;i++){
        		if(strdocno==''){
	        		strdocno+=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
	        	}	
	        	else{
	        		strdocno+=','+$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
	        	}
        	}
       		$('#modalstatusupdate').find('.modal-title').text('Status Update of Ticket #'+strdocno);
       		$('#modalstatusupdate').modal('show');
        });
        $('#btnmail').click(function(){
        	var rowindex=$('#rowindex').val();
        	
        	/*if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	var errorstatus=0;
        	for(var i=0;i<selecteddocs.length;i++){
        		if(parseInt($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'processstatus'))<2){
	        		Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Please acknowledge the ticket'
					});
					errorstatus=1;
	        		return false;
	        	}	
        	}
        	if(errorstatus==1){
	        	return false;
        	}
        	if(selecteddocs.length!=1){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select single document'
				});
				return false;
        	}
        	
			var username=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'username');
       		var usermail=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'usermail');
       		var userid='<%=session.getAttribute("USERID")==null?"":session.getAttribute("USERID")%>';
       		var shortdesc=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'shortdesc');
       		var docno=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[0],'doc_no');
       		var msg=' Dear </br>'+
					'Greetings !!!</br>'+
					'Thank you for the mail, We have raised a ticket with the subjected Reference number <b>'+docno+'</b> against your request for <b>'+shortdesc+'</b>.</br>'+
					'We will get to it as soon as possible.</br>'+
					'If you have any concern please feel free to write to helpdesk@gatewayerp.com or call us at +971 65505582.';
       		//msg=encodeURIComponent(msg);
       		username=encodeURIComponent(username);
       		var subject="Acknowledgement for the ticket "+shortdesc;
       		subject=encodeURIComponent(subject);
			shortdesc=encodeURIComponent(shortdesc);
       		window.open("<%=contextPath%>/com/emailnew/Email.jsp?subject="+subject+"&formcode=BGWQ&docno="+docno+"&brchid="+1+"&frmname=Query&recipient="+usermail+"&cldocno=1&client="+username+"&userid="+userid+"&dtype=BGWQ&msg="+msg,"E-Mail","menubar=0,resizable=1,width=900,height=950");
		        	
        });
        $('.btn-status-save').click(function(){
        	var rowindex=$('#rowindex').val();
        	/*if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var strdocno='';
        	var docnoarray=new Array();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	else{
        		for(var i=0;i<selecteddocs.length;i++){
        			docnoarray.push($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no'));
        			if(strdocno==''){
		        		strdocno+=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
		        	}	
		        	else{
		        		strdocno+=','+$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
		        	}
        		}
        	}
        	if($('#cmbstatus').val()==''){
        		$('#cmbstatus').closest('div').find('span.help-block').remove();
        		$('#cmbstatus').closest('div').append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
        		return false;
        	}
        	else{
        		$('#cmbstatus').closest('div').find('span.help-block').remove();
        	}
        	if($('#priorityseqno').val()==''){
        		$('#priorityseqno').closest('div').find('span.help-block').remove();
        		$('#priorityseqno').closest('div').append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
        		return false;
        	}
        	else{
        		$('#priorityseqno').closest('div').find('span.help-block').remove();
        	}
        	if(!$.isNumeric($('#priorityseqno').val())){
        		$('#priorityseqno').closest('div').find('span.help-block').remove();
        		$('#priorityseqno').closest('div').append($.parseHTML('<span class="help-block" style="color:red;">Only Numbers Allowed</span>'));
        		return false;
        	}
        	else{
        		$('#priorityseqno').closest('div').find('span.help-block').remove();
        	}
        	if($('#cmbmember').val()==''){
        		$('#cmbmember').closest('div').find('span.help-block').remove();
        		$('#cmbmember').closest('div').append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
        		return false;
        	}
        	else{
        		$('#cmbmember').closest('div').find('span.help-block').remove();
        	}
        	
        	Swal.fire({
  				title: 'Are you sure?',
  				text: "Do you want to update status of Ticket#"+strdocno,
  				icon: 'warning',
  				showCancelButton: true,
  				confirmButtonColor: '#3085d6',
  				cancelButtonColor: '#d33',
  				confirmButtonText: 'Yes'
			}).then((result) => {
  				if (result.isConfirmed) {
  					$.post('saveData.jsp',
					{
						'docnoarray[]':docnoarray,
						docno:$('#docno').val(),
						priorityseqno:$('#priorityseqno').val(),
						processstatus:4,
						status:$('#cmbstatus').val(),
						comprefid:$('#queryGrid').jqxGrid('getcellvalue',rowindex,'comprefid'),
						statusremarks:$('#statusremarks').val(),
						teamdocno:$("#cmbmember").select2().find(":selected").attr("data-teamdocno"),
						empdocno:$("#cmbmember").select2().find(":selected").attr("data-empdocno"),
						memberdocno:$("#cmbmember").select2().find(":selected").val()
					},
					function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=='0'){
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Ticket #'+data.docno+' Updated Successfully'
							});
							$('.modal.in').modal('hide');
							$('#btnsubmit').trigger('click');
						}
						else{
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Updated'
							});
						}
					});
  							
  				}
  			});
        });
        $('.btn-acknowledge-save').click(function(){
        	var rowindex=$('#rowindex').val();
        	/*if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var strdocno='';
        	var docnoarray=new Array();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	else{
        		for(var i=0;i<selecteddocs.length;i++){
        			docnoarray.push($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no'));
        			if(strdocno==''){
		        		strdocno+=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
		        	}	
		        	else{
		        		strdocno+=','+$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
		        	}
        		}
        	}
        	if($('#cmbformname').val()==''){
        		$('#cmbformname').closest('div').find('span.help-block').remove();
        		$('#cmbformname').closest('div').append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
        		return false;
        	}
        	else{
        		$('#cmbformname').closest('div').find('span.help-block').remove();
        	}
        	if($('#cmbpriority').val()==''){
        		$('#cmbpriority').closest('div').find('span.help-block').remove();
        		$('#cmbpriority').closest('div').append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
        		return false;
        	}
        	else{
        		$('#cmbpriority').closest('div').find('span.help-block').remove();
        	}
        	Swal.fire({
  				title: 'Are you sure?',
  				text: "Do you want to acknowledge Ticket#"+strdocno,
  				icon: 'warning',
  				showCancelButton: true,
  				confirmButtonColor: '#3085d6',
  				cancelButtonColor: '#d33',
  				confirmButtonText: 'Yes'
			}).then((result) => {
  				if (result.isConfirmed) {
  					$.post('saveData.jsp',
					{
						'docnoarray[]':docnoarray,
						docno:$('#docno').val(),
						formname:$('#cmbformname').val(),
						priority:$('#cmbpriority').val(),
						processstatus:1,
						comprefid:$('#queryGrid').jqxGrid('getcellvalue',rowindex,'comprefid'),
						ackremarks:$('#ackremarks').val(),
						dept:$('#cmbdeptype').val(),
						eddate:$('#eddate').val()
						

					},
					function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=='0'){
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Ticket #'+data.docno+' Acknowledged Successfully'
							});
							$('.modal.in').modal('hide');
							$('#btnsubmit').trigger('click');
						}
						else{
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Acknowledged'
							});
						}
					});
  							
  				}
  			});
        });
        
        
        $('.btn-edd-save').click(function(){
        	var rowindex=$('#rowindex').val();
        	/*if($('#docno').val()==''){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}*/
        	var strdocno='';
        	var docnoarray=new Array();
        	var selecteddocs=$('#queryGrid').jqxGrid('getselectedrowindexes');
        	if(selecteddocs.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
				return false;
        	}
        	else{
        		for(var i=0;i<selecteddocs.length;i++){
        			docnoarray.push($('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no'));
        			if(strdocno==''){
		        		strdocno+=$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
		        	}	
		        	else{
		        		strdocno+=','+$('#queryGrid').jqxGrid('getcellvalue',selecteddocs[i],'doc_no');
		        	}
        		}
        	}
        	
        	Swal.fire({
  				title: 'Are you sure?',
  				text: "Do you want to Update Acknowledgement Ticket#"+strdocno,
  				icon: 'warning',
  				showCancelButton: true,
  				confirmButtonColor: '#3085d6',
  				cancelButtonColor: '#d33',
  				confirmButtonText: 'Yes'
			}).then((result) => {
  				if (result.isConfirmed) {
  					$.post('saveData.jsp',
					{
						'docnoarray[]':docnoarray,
						docno:$('#docno').val(),
						chk:1,
						processstatus:1,
						dept1:$('#cmbdeptype1').val(),
						eddate1:$('#eddate1').val()
				},
					function(data,status){
						data=JSON.parse(data);
						if(data.errorstatus=='0'){
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Ticket #'+data.docno+' Acknowledgement Updated Successfully'
							});
							$('.modal.in').modal('hide');
							$('#btnsubmit').trigger('click');
						}
						else{
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Acknowledged'
							});
						}
					});
  							
  				}
  			});
        });
        
        
        $('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#docno').val();
        	if(txtcomment==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
        
        $('.warningpanel div button').click(function(){
        	var gridrows=$('#queryGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'error',
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
        		$('#queryGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
        
        $('.warningpanel1 div button').click(function(){
        	var gridrows=$('#queryGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'error',
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
        		$('#queryGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
       
        
        
    });
    
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	if(id=="btnoverdue"){
    		filtervalue=new Date();
    	} 
    	//var filtercondition = 'contains';
    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#queryGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#queryGrid").jqxGrid('applyfilters');
 	}
    
    function funGetCountPriority(){
    	var comprefid=$('#cmbcompany').val();
    	var empdocno=$('#cmbuser option:selected').attr('data-empdocno');
    	var type=$('#cmbtype').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				$('.badge-dc').text(items[0]);
				$('.badge-cs').text(items[1]);
				$('.badge-ro').text(items[2]);
				$('.badge-mi').text(items[3]);
				$('.badge-scr').text(items[4]);
				$('.badge-nw').text(items[5]);
				$('.badge-na').text(items[6]);
				
				$('.badge-entered').text(items[7]);
				$('.badge-documented').text(items[8]);
				$('.badge-started').text(items[9]);
				$('.badge-onhold').text(items[10]);
				$('.badge-completed').text(items[11]);
				$('.badge-tandc').text(items[12]);
				$('.badge-dandc').text(items[13]);
				$('.badge-cc').text(items[14]);

				
			}
			else
			{
			}
		}
		x.open("GET","getCountPriorityandstatus.jsp?comprefid="+comprefid+"&empdocno="+empdocno+"&type="+type,true);
		x.send();
    }
    
    
    
    function saveComment(){
    	var comment=$('#txtcomment').val();
    	var docno=$('#docno').val();
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
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&docno="+docno,true);
		x.send();
    }
    function getComments(){
    	var jobcarddocno=$('#docno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
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
		x.open("GET","getComments.jsp?docno="+jobcarddocno,true);
		x.send();
    }
    
    
    function funGetCountData(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items=JSON.parse(items);
				var htmldata='<option value="">--Select--</option>';
				$.each(items.companydata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbcompany').html($.parseHTML(htmldata));
	  			$('#cmbcompany').select2({
	  				placeholder:"Select Company",
	  				allowClear:true
	  			});	
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.formdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbformname').html($.parseHTML(htmldata));
	  			$('#cmbformname').select2({
	  				placeholder:"Select Form",
	  				allowClear:true
	  			});
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.statusdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbstatus').html($.parseHTML(htmldata));
	  			$('#cmbstatus').select2({
	  				placeholder:"Select Status",
	  				allowClear:true
	  			});	
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.memberdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'" data-teamdocno="'+value.teamdocno+'" data-empdocno="'+value.empdocno+'">'+value.member+'</option>';
	  			});
			
	  			$('#cmbmember,#cmbuser').html($.parseHTML(htmldata));
	  			$('#cmbmember').select2({
	  				placeholder:"Select Assign User",
	  				allowClear:true
	  			});	
	  			$('#cmbuser').select2({
	  				placeholder:"Select User",
	  				allowClear:true
	  			});	
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.deptdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.type+'</option>';
	  			});
				$('#cmbdeptype').html($.parseHTML(htmldata));
				$('#cmbdeptype1').html($.parseHTML(htmldata));
				if($('#hidcmbdeptype1').val()!= null){
						document.getElementById("cmbdeptype1").value=document.getElementById("hidcmbdeptype1").value;
						//funreload(event);       
					  }
	  			$('#cmbdeptype').select2({
	  				placeholder:"Select Department",
	  				allowClear:true
	  			});
	  			$('#cmbdeptype1').select2({
	  				placeholder:"Select Department",
	  				allowClear:true
	  			});
			}
			else
			{
			}
		}
		x.open("GET","getCountData.jsp",true);
		x.send();
    }

function funDateInPeriod(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
    	//$.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     	Swal.fire({
			icon:'warning',
			type: 'error',
			title: 'Warning',
			text: 'Transaction prior or after Account Period is not valid.'
		});
     $('#txtvalidation').val(1);
     return 0;
    }
     if(value>currentDate){
    	 //$.messager.alert('Warning',"Future Date, Transaction Restricted. ");
     	Swal.fire({
			icon:'warning',
			type: 'error',
			title: 'Warning',
			text: 'Future Date, Transaction Restricted.'
		});
     $('#txtvalidation').val(1);
     return 0;
    } 
    if(value<=mclose){
    	//$.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
     	Swal.fire({
			icon:'warning',
			type: 'error',
			title: 'Warning',
			text: 'Closing Done, Transaction Restricted.'
		});
     $('#txtvalidation').val(1);
     return 0;
    }
    
    $('#txtvalidation').val(0);
     return 1;
 }
 function funRoundAmt(value,id){
    var res=parseFloat(value).toFixed(window.parent.amtdec.value);
    var res1=(res=='NaN'?"0":res);
    document.getElementById(id).value=res1;  
   }
  </script>
</body>
</html>
