<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>AMC Management</title>         
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
  		width:260px;  
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
<body onload="getBranch(); getCostBudgetingConfig();">   
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
  		<div class="row padtop">
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="notassigneddiv">      
                <div class="card-container">
                    <div class="card-body text-center">
                        <div class="card-chart-container">
                            <div id="notassigned"></div>  
                            <span><img src="icons/icons8-schedule-30.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Not Assigned</span><br/>        
                             <span class="counter">10</span>    
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="assigneddiv">   
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">   
                            <div id="assigned"></div>
                            <span><img src="icons/icons8-collaboration-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                             <span>Assigned</span><br/>
                             <span class="counter">10</span>    
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="workstarteddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="workstarted"></div>
                            <span><img src="icons/icons8-survey-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Work Started</span><br/>
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>	
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="pndcnfrddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="pndcnfrd"></div>    
                            <span><img src="icons/icons8-ledger-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Service Confirmation</span><br/>  
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>	
        </div>  
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
      <div class="todatepanel custompanel">
	      <table>
		      <tr> 
		      <td align="right"><input type="checkbox" id="fdate" name="fdate" onchange="funchangedate();">&nbsp;&nbsp;
		       <input type="hidden" name="fdatechk" id="fdatechk"></td>                        
		      <td align="right"><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='fromdate' name='fromdate'></div></td>
		      <td align="right"><label class="branch" style="font-size: 13px">&nbsp;To Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='todate' name='todate'></div></td></tr>                                          
		 </table>          
      </div>  
        <div class="primarypanel custompanel">
               <label for="branch" class="branch">&nbsp;Branch</label>    
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
          <button type="button" class="btn btn-default" id="btncostbudget" data-toggle="tooltip"  title="Cost Budgeting" data-placement="bottom"><i class="fa fa-bold "  aria-hidden="true"></i></button>     
          <button type="button" class="btn btn-default" id="btnassignment" data-toggle="tooltip"  title="Assignment" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btndeploytechnician"  data-toggle="tooltip" title="Deploy Technician" data-placement="bottom"><i class="fa fa-cogs "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btndeploytechnicianprint"  data-toggle="tooltip" title="Deploy Technician Print" data-placement="bottom"><i class="fa fa-print "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnserviceupdate"  data-toggle="tooltip" title="Service Update" data-placement="bottom"><i class="fa fa-pencil-square-o "  aria-hidden="true"></i></button>        
        </div>          
        <div class="otherpanel custompanel">                
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        <div class="textpanel1 custompanel" >  
			<label for="divid" id="selecteddiv" style="font-size:75%;padding-top:9px;padding-left:6px;"></label>  
        </div> 
        <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>  
        </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="projectdiv"><jsp:include page="projectGrid.jsp"></jsp:include></div>          
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
    
    <!--Cost Budgeting Modal-->
    <div id="modalcostbudget" class="modal fade" role="dialog">    
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Cost Budgeting</h4>  
            <p id="lblname1" style="text-align:center;"></p>                  
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">     
	   <div class="row rowgap">   
                 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
				        <div id="budgetdiv"><jsp:include page="budgetdivisionGrid.jsp"></jsp:include></div>              
				 </div>
        </div>
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">  
		            <button type="button" class="btn btn-default" id="btncostbudgeting" onclick="funbudgetdivision();" data-toggle="tooltip" title="Save" data-placement="bottom"><i class="fa fa-floppy-o "  aria-hidden="true"></i></button> 
                    <button type="button" class="btn btn-default" id="btndeployprintclose" data-dismiss="modal" data-toggle="tooltip" title="Close" data-placement="bottom" style="background-color:red"><i class="fa fa-window-close "  aria-hidden="true"></i></button>  
		          </div>                 
		        </div>
		      </div>
	</div>  	    
	
	 <!-- Assignment Modal-->
    <div id="modalassignment" class="modal fade" role="dialog">    
      <div class="modal-dialog modal-lg">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Assignment</h4>
            <p id="lblname2" style="text-align:center;"></p>                              
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">   
	    <div class="row rowgap">   
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
		        <div id="assgndiv"><jsp:include page="assignGrid.jsp"></jsp:include></div>                  
		      </div>  
        </div>
	   <div class="row rowgap"> 
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="assigngrp">Assign Group</label>
	        					<div id="assigngroup" onkeydown="return (event.keyCode!=13);"><jsp:include page="servicegrpsearch.jsp"></jsp:include></div>
                     	        <input type="hidden" name="hidgroupid" id="hidgroupid">
                     	    </div>  
	        </div>  
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="grpmember">Group Member</label>  
	        					<div id="groupmember" onkeydown="return (event.keyCode!=13);"><jsp:include page="servicegrptoearch.jsp"></jsp:include></div>
                     	        <input type="hidden" id="hidgrpmemberid" name="hidgrpmemberid" value='<s:property value="hidgrpmemberid"/>'>
                                <input type="hidden" id="hidgrpempid" name="hidgrpempid" value='<s:property value="hidgrpempid"/>'>
                            </div>
	        </div> 
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
	        				<div class="form-group">
	        					<label for="assignmethod">Assign Method</label>
	        					<div id="assignid" onkeydown="return (event.keyCode!=13);"><jsp:include page="assignmodesearch.jsp"></jsp:include></div>
                     	        <input type="hidden" name="hidassignid" id="hidassignid">
                     	    </div>  
	        </div> 
	         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
	        				<div class="form-group">
	        					<label for="pldate">Planned Date</label>   
	        					<div id="surveydate" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
                     	    </div>  
	        </div>    
	          
        </div>
        <div class="row rowgap">
         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="pltime">Planned Time</label>   
	        					<div id="surveytime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
                     	    </div>  
	        </div> 
              <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">
	        				<div class="form-group">
	        					<label for="description">Description</label>     
	        					<input type="text" style="width:100%;" placeholder="Description" id="surveydesc" class="form-control input-sm"/>  
                     	    </div>  
	          </div>   
        </div>  
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">  
		            <button type="button" class="btn btn-default" id="btnassignsave" onclick="funAssignment();" data-toggle="tooltip" title="Save" data-placement="bottom"><i class="fa fa-floppy-o "  aria-hidden="true"></i></button> 
                    <button type="button" class="btn btn-default" id="btnassgnclose" data-dismiss="modal" data-toggle="tooltip" title="Close" data-placement="bottom" style="background-color:red"><i class="fa fa-window-close "  aria-hidden="true"></i></button>  
		          </div>                 
		        </div>
		      </div>
	</div> 
	
	<!--Deploy Technician Modal-->  
    <div id="modaldeploytechnician" class="modal fade" role="dialog">    
      <div class="modal-dialog modal-xl">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button> 
            <h4 class="modal-title" style="text-align:center">Deploy Technician</h4>
            <p id="lblname3" style="text-align:center;"></p>                
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid"> 
	      <div class="row rowgap">   
                 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">           
				        <div id="depassigndiv"><jsp:include page="depassignGrid.jsp"></jsp:include></div>                 
				 </div>
           </div>    
	       <div class="row rowgap"> 
	              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">          
				        <div id="depdetaildiv"><jsp:include page="depDetailsGrid.jsp"></jsp:include></div>                   
				 </div>  
                 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">            
				        <div id="deploydiv"><jsp:include page="deploytechnicianGrid.jsp"></jsp:include></div>                 
				 </div>
           </div>
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">      
		            <button type="button" class="btn btn-default" id="btndeploysave" onclick="fundeploytechnician();" data-toggle="tooltip" title="Save" data-placement="bottom"><i class="fa fa-floppy-o "  aria-hidden="true"></i></button> 
                    <button type="button" class="btn btn-default" id="btnassgnclose" data-dismiss="modal" data-toggle="tooltip" title="Close" data-placement="bottom" style="background-color:red"><i class="fa fa-window-close "  aria-hidden="true"></i></button>  
		          </div>                 
		        </div>
		      </div>
	</div>   	
		    
	<!-- Service Update Modal--> 
    <div id="modalserviceupdate" class="modal fade" role="dialog">  
      <div class="modal-dialog modal-md">  
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Service Update</h4> 
            <p id="lblname4" style="text-align:center;"></p>                     
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">  
	    <div class="row rowgap">   
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">           
		        <div id="servicediv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>                        
		      </div>  
        </div> 
	    <div class="row rowgap"> 
	         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="Percentage">Percentage</label>   
	        					<input  type="text" name="txtper" id="txtper" class="form-control input-sm"> 
                     	    </div>  
	         </div> 
	         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="Rectification">Rectification</label>   
			        			<select id="rect" name="rect" onChange="funselect();"  class="form-control input-sm">    
							      <option value="" selected>--SELECT--</option>
							      <option value="1">YES</option>
							      <option value="0">NO</option>  
							     </select>
                     	    </div>  
	         </div>    
        </div>   
        <div class="row rowgap"> 
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
	        				<div class="form-group">
	        					<label for="Description">Description</label>   
	        					<input  type="text" name="txtdesc" id="txtdesc" class="form-control input-sm">  
                     	    </div>    
	         </div>  
         </div>
            	  
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">     
		             <button type="button" class="btn btn-default" id="btnserupdate"  data-toggle="tooltip" title="Service Update" data-placement="bottom"><i class="fa fa-pencil-square-o "  aria-hidden="true"></i></button>        
                     <button type="button" class="btn btn-default" id="btnserviceattach"   data-toggle="tooltip" title="Service Attach" data-placement="bottom"><i class="fa fa-paperclip "  aria-hidden="true"></i></button>        
                     <button type="button" class="btn btn-default" id="btnserviceconfirm"   data-toggle="tooltip" title="Service Confirm" data-placement="bottom"><i class="fa fa-check-square "  aria-hidden="true"></i></button> 
		             <button type="button" class="btn btn-default" id="btnserupclose" data-dismiss="modal" data-toggle="tooltip" title="Close" data-placement="bottom" style="background-color:red"><i class="fa fa-window-close "  aria-hidden="true"></i></button>  
		          </div>                 
		        </div>
		   </div>  
	</div>
 <!-- Assignment Modal-->
    <div id="modaldeploytechnicianprint" class="modal fade" role="dialog">    
      <div class="modal-dialog modal-md"> 
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Deploy Technician Print</h4> 
            <p id="lblname5" style="text-align:center;"></p>                                   
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">   
	      <div class="row rowgap"> 
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
	        					<label for="assigngrp">Job</label>
	        </div>  					 
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
	        					<input type="radio" id="rdjobno" onchange="funRadioType();" name="rdo" value="rdjobno">
	        </div> 
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        					<label for="assigngrp">Employee</label>  
	        </div>  					 
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
	        					<input type="radio" id="rdemployee" onchange="funRadioType();" name="rdo" value="rdemployee">
	        </div>  
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="grpmember">Date</label>  
	        					<div id="date" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                            </div>
	        </div> 
        </div>
         <div class="row rowgap">
         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
	        				<div class="form-group">
	        					<label for="Job">Job No</label>
	        					<input type="text" id="txtjobno" name="txtjobno" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getJob(event);" class="form-control input-sm"/>
                     	        <input type="hidden" id="txtjobid" name="txtjobid" style="width:100%;height:20px;"/>  
                     	    </div>  
	        </div> 
	        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
	        				<div class="form-group">
	        					<label for="Employee">Employee</label>
	        					<input type="text" id="txtemployee" name="txtemployee" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getEmployee(event);" class="form-control input-sm"/>
							    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" style="width:100%;height:20px;" />
						 </div>  
	        </div> 
         </div>
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">    
		            <button type="button" class="btn btn-default" id="btndeployPrint" onclick="funPrintDetails();" data-toggle="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print "  aria-hidden="true"></i></button> 
                    <button type="button" class="btn btn-default" id="btndeployprintclose" data-dismiss="modal" data-toggle="tooltip" title="Close" data-placement="bottom" style="background-color:red"><i class="fa fa-window-close "  aria-hidden="true"></i></button> 
                  </div>                 
		        </div>
		      </div>
	</div> 
  <input type="hidden" name="budgetno" id="budgetno">   
  <input type="hidden" name="divname" id="divname">       
  <input type="hidden" name="hidcomments" id="hidcomments">
  <input type="hidden" name="jobdocno" id="jobdocno">    
  <input type="hidden" name="jobvocno" id="jobvocno">   
  <input type="hidden" name="schtrno" id="schtrno">  
  <input type="hidden" name="brhid" id="brhid">    
  
  <input type="hidden" name="trno" id="trno">     
  <input type="hidden" name="cldocno" id="cldocno">   
  <input type="hidden" name="srno" id="srno">   
  <input type="hidden" name="dtype" id="dtype">     
  
   <input type="hidden" name="site" id="site"> 
   <input type="hidden" name="budget" id="budget">
   <input type="hidden" name="consumed" id="consumed"> 
   <input type="hidden" name="balance" id="balance">
   
  <input type="hidden" name="srtrno" id="srtrno"> 												
  <input type="hidden" name="srdocno" id="srdocno"> 
  <input type="hidden" name="sheduleno" id="sheduleno"> 
  <input type="hidden" name="serdocno" id="serdocno"> 
  <input type="hidden" name="areaid" id="areaid"> 
  <input type="hidden" name="siteid" id="siteid"> 						
  <input type="hidden" name="reftrno" id="reftrno"> 						
  <input type="hidden" name="acno" id="acno">   
  <input type="hidden" name="tempname" id="tempname">             
  <input type="hidden" name="assigntrno" id="assigntrno">  
  <input type="hidden" name="lblname" id="lblname">    
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
     	$("#surveydate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
    	$("#surveytime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
        $('#surveydate').jqxDateTimeInput('setDate', new Date());
        $('#surveytime').jqxDateTimeInput('setDate', new Date());   
        $('#manPowerGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#manPowerGridWindow').jqxWindow('close');
		$('#assignedDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#assignedDetailsWindow').jqxWindow('close');
	    $('#jobDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Job Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#jobDetailsWindow').jqxWindow('close');
	    $("#date").jqxDateTimeInput({ width: '100px', height: '21px',formatString:"dd.MM.yyyy"});  
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
	    $('#txtemployee').dblclick(function(){
	    	 manPowerSearchContent('employeeDetailsSearch.jsp?id=0');
		 });
	     
	     $('#txtjobno').dblclick(function(){
	    	 jobSearchContent('jobDetailsSearch.jsp?dtype='+$('#dtype').val());  
	      });
	    $('#fromdate').jqxDateTimeInput("disabled",true);
	    $('#fdatechk').val(0);  
    	getInitChartData();   
    	//inputload();
    	document.getElementById('selecteddiv').innerHTML=" - Not Assigned"; 
    	document.getElementById("divname").value="notassigned";     
        $('#btnsubmit').click(function(){  
        	clearfields();      
            loads(); 
            getInitChartData(); 
        }); 
        $('#btndeploytechnicianprint').click(function(){     
        	var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;  
	    	}  
	    	document.getElementById("rdjobno").checked=true;
		    $('#txtemployee').attr('disabled', true);$('#txtjobno').attr('disabled', false);
		    document.getElementById("txtemployee").value="";document.getElementById("txtemployeedocno").value="";
			document.getElementById("txtjobid").value="";document.getElementById("txtjobno").value="";
			document.getElementById("lblname5").innerHTML=$("#lblname").val();
	    	$("#modaldeploytechnicianprint").modal('toggle');  
        });
        $('#btncostbudget').click(function(){   
        	var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	} 
			$('#budgetdiv').load('budgetdivisionGrid.jsp?docno='+enqno+'&id='+1); 
			document.getElementById("lblname1").innerHTML=$("#lblname").val();  
	    	$("#modalcostbudget").modal('toggle');  
        });
        $('#btnassignment').click(function(){   
        	var enqno=$('#jobdocno').val();
        	var tempname=$('#tempname').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;  
	    	} 
	    	$('#assgndiv').load('assignGrid.jsp?trno='+enqno+'&check='+1);  
	    	document.getElementById("lblname2").innerHTML=$("#lblname").val();
	    	$("#modalassignment").modal('toggle');  
        });
        $('#btndeploytechnician').click(function(){    
	        var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	$('#depassigndiv').load('depassignGrid.jsp?trno='+enqno+'&check='+1);
	    	$("#deployTechnicianDetailsGridId").jqxGrid('clear');  
	    	$("#deployTechnicianDetailsGridId").jqxGrid({ disabled: true});
	    	$("#manPowerAssignedGridID").jqxGrid({ disabled: true});
	    	$('#btndeploysave').attr('disabled', true);  
	    	document.getElementById("lblname3").innerHTML=$("#lblname").val();
	    	$("#modaldeploytechnician").modal('toggle');    
        });
        $('#btnserviceupdate').click(function(){        
        	var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	$('#servicediv').load('serviceGrid.jsp?trno='+enqno+'&check='+1);  
	    	$('#btnserviceattach').attr("disabled",true); 
	    	$('#btnserupdate').attr("disabled",true);  
	    	$('#btnserviceconfirm').attr("disabled",true);
	    	document.getElementById("lblname4").innerHTML=$("#lblname").val();
	    	$("#modalserviceupdate").modal('toggle');    
        });
        $('#btnserupdate').click(function(){
        	var method="Saved";
        	funserviceupdate(method);      
        });  
        $('#btnserviceconfirm').click(function(){     
        	var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	var method="Confirmed";   
        	funserviceupdate(method); 
        });
        $('#btnserviceattach').click(function(){      
	        var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	serattach();       
        }); 
        $('#btnattachs').click(function(){   
        	funAttachs(event);      
        });
        $('#btncomment').click(function(){    
	        var enqno=$('#jobdocno').val();
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
        	$("#projectdiv").excelexportjs({
        		containerid: "projectdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxProjectGrid", 
        		columns: getColumns("jqxProjectGrid") ,   
        		worksheetName:"AMC Management"
         		});
        });
        $('#btncommentsend').click(function(){
        	var enqno=$('#jobdocno').val();
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
        		$('#jqxProjectGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    function assignedDetailsContent(url) {
		$('#assignedDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#assignedDetailsWindow').jqxWindow('setContent', data);
		$('#assignedDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
    function funchangedate(){  
    	if(document.getElementById("fdate").checked){
    		$('#fromdate').jqxDateTimeInput("disabled",false);
    		$('#fdatechk').val(1);
    	}else{
    		$('#fromdate').jqxDateTimeInput("disabled",true);
    		$('#fdatechk').val(0);
    	}
    	getInitChartData();    
    }
    function funselect(){
		var rect =  $('#rect').val();
		if(rect=="1")
			{
			$('#txtdesc').attr("disabled",false);
			}
		else{
			document.getElementById("txtdesc").value ="";  
			$('#txtdesc').attr("disabled",true);
		}
	}
    function funRoundAmt(value,id){
        var res=parseFloat(value).toFixed(window.parent.amtdec.value);
        var res1=(res=='NaN'?"0":res);
        document.getElementById(id).value=res1;  
       }  
    function manPowerSearchContent(url) {
		$('#manPowerGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#manPowerGridWindow').jqxWindow('setContent', data);
		$('#manPowerGridWindow').jqxWindow('bringToFront');
	}); 
	}  
    function jobSearchContent(url) {
		$('#jobDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#jobDetailsWindow').jqxWindow('setContent', data);
		$('#jobDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
    function getManPowerConsumed(costtype,costcode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				if(!(isNaN(items))){
	  			    var budget = $('#budget').val();
	      		    var balance = parseFloat(budget) - parseFloat(items);
	           	    funRoundAmt(items,"consumed");
	           	    funRoundAmt(balance,"balance");
  				} else if(isNaN(items)){
  	            	 funRoundAmt(0.00,"consumed");
  	            	 funRoundAmt(0.00,"balance");   
  	        	}
  		}
  		}
  		x.open("GET", "getManPowerConsumed.jsp?costtype="+costtype+'&costcode='+costcode, true);
  		x.send();
   }
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("jobdocno").value="";  
    	document.getElementById("jobvocno").value=""; 
    	document.getElementById("brhid").value=""; 
    	document.getElementById("hidcomments").value="";  
     	document.getElementById("schtrno").value="";  
    	document.getElementById("budgetno").value="";
		document.getElementById("trno").value="";  
    	document.getElementById("cldocno").value="";  
    	document.getElementById("srno").value="";  
    	document.getElementById("dtype").value="";  
    	document.getElementById("site").value="";  
    	document.getElementById("budget").value="";  
    	document.getElementById("consumed").value="";  
    	document.getElementById("balance").value=""; 
		document.getElementById("srtrno").value="";  
    	document.getElementById("srdocno").value="";  
    	document.getElementById("sheduleno").value="";  
    	document.getElementById("serdocno").value="";  
    	document.getElementById("areaid").value="";  
    	document.getElementById("siteid").value=""; 
		document.getElementById("reftrno").value=""; 
		document.getElementById("acno").value="";  
	    document.getElementById("tempname").value="";
    }
    
    function getInitChartData(){  
    	 var brhid=$("#cmbbranch").val();
    	 var fdatechk=$("#fdatechk").val();  
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');     
	     var todate=$('#todate').jqxDateTimeInput('val');  
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				var guagedata=JSON.parse(items);           
		        
				$("#notassigned").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.notassignedcount);
	          	$("#assigned").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.assignedcount);	
	          	$("#workstarted").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.workstartedcount);
	          	$("#pndcnfrd").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.pndcnfrdcount);          
				
			}
			else{
			}
		}
		x.open("GET","getInitChartData.jsp?brhid="+brhid+"&fromdate="+fromdate+"&todate="+todate+"&fdatechk="+fdatechk,true);                           
		x.send();    
	 }
   
    function inputload(){  
    	 var assgnid=document.getElementById("hidgroupid").value;
		 $('#groupmember').load('servicegrptoearch.jsp?assgnid='+assgnid);    
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
    	$("#jqxProjectGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxProjectGrid").jqxGrid('applyfilters');  
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#jobdocno').val();
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&enqno="+enqno,true);
		x.send();
    }
    function getComments(){
    	var enqno=$('#jobdocno').val();
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
		x.open("GET","getComments.jsp?enqno="+enqno,true);
		x.send();
    }
   
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var brhid=$("#cmbbranch").val();
	    var divname=$("#divname").val();
	    var fdatechk=$("#fdatechk").val();  
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');     
	    var todate=$('#todate').jqxDateTimeInput('val');  
	    $('#projectdiv').load('projectGrid.jsp?divname='+divname+'&brhid='+brhid+"&fromdate="+fromdate+"&todate="+todate+"&fdatechk="+fdatechk+'&id=1'); 
    }   
  
	function funAttachs(event){                         
		var brchid=document.getElementById("brhid").value;  
   		var docno=document.getElementById("jobvocno").value;   
   		var url=document.URL;
		var reurl=url.split("/com/");
 		if(docno!="" && docno!="0"){                
   			var frmdet="AMC"; 
   			var fname="Service Contract";    
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
	function serattach(){  
		var fcode="SRVE";
		var fname="Sevice Report";
		var url=document.URL;
		var reurl=url.split("/com/");    
		console.log(reurl[0]);  
		var  myWindow= window.open(reurl[0]+"/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("srdocno").value+"&brchid="+document.getElementById("brhid").value+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
		myWindow.focus();   
	}
	$('div').click(function() {
		  var divid=$(this).attr('id');  
		  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
			  var realid=divid.replace(/div/g, "");
			  if(realid=="notassigned" || realid=="assigned" || realid=="workstarted" || realid=="pndcnfrd"){ 
				  clearfields();      
				  document.getElementById("divname").value=realid;       
				  loads();            
			  }
			  if(realid=="notassigned"){ 
				  document.getElementById('selecteddiv').innerHTML=" - Not Assigned";  
			  }else if(realid=="assigned"){
				  document.getElementById('selecteddiv').innerHTML=" - Assigned";  
			  }else if(realid=="workstarted"){
				  document.getElementById('selecteddiv').innerHTML=" - Work Started"; 
			  }else if(realid=="pndcnfrd"){
				  document.getElementById('selecteddiv').innerHTML=" - Service Confirmation";
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
	
	function funAssignment(){        
		var rows = $("#jqxassignGrid").jqxGrid('getrows');
		var selectedrows=$("#jqxassignGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select a document!!!'                                          
			});
			return false;
		}
		 var groupid=document.getElementById("hidgroupid").value;
	     var grpmemberid=document.getElementById("hidgrpmemberid").value;
	     var grpempid=document.getElementById("hidgrpempid").value;
	     var assignid=document.getElementById("hidassignid").value; 
         var surveydate=document.getElementById("surveydate").value;  
         var surveytime=document.getElementById("surveytime").value;  
         var surveydesc=document.getElementById("surveydesc").value;  
         var dtype=document.getElementById("dtype").value; 
         var cldocno=document.getElementById("cldocno").value; 
         var brhid=document.getElementById("brhid").value;
         
        /*  var srno=document.getElementById("srno").value;  
         var trno=document.getElementById("trno").value;  */       
         
         if(groupid== ""){
         	swal({
				type: 'warning',
				title: 'Warning',
				text: 'select Assign Group'                                   
			});
     	    return 0;
     	 }
     	
     	if(grpmemberid== ""){
     		swal({
				type: 'warning',
				title: 'Warning',
				text: 'select Group Member'                                   
			});
     	    return 0;
     	}
     	
     	if(assignid== ""){  
     		swal({
				type: 'warning',
				title: 'Warning',
				text: 'Select Assign Method'                                     
			});
     	    return 0;
     	}
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		if(r==false){
			return false; 
		}else
		{
			$("#overlay, #PleaseWait").show();
	
			var i=0;
			var temptrno="",temptrno1="";               
			var j=0;
			for (i = 0; i < selectedrows.length; i++) {   
				if(i==0){
					var srvdetmtrno= $('#jqxassignGrid').jqxGrid('getcellvalue', selectedrows[i], "tr_no")+"###"+$('#jqxassignGrid').jqxGrid('getcellvalue', selectedrows[i], "refdocno");
					temptrno=srvdetmtrno;
				}else{
					var srvdetmtrno= $('#jqxassignGrid').jqxGrid('getcellvalue', selectedrows[i], "tr_no")+"###"+$('#jqxassignGrid').jqxGrid('getcellvalue', selectedrows[i], "refdocno");             
					temptrno=temptrno+","+srvdetmtrno;        
				}
				temptrno1=temptrno+",";
				j++; 
			}
			$('#assigntrno').val(temptrno1);   
            saveAssignment(groupid,grpmemberid,grpempid,assignid,surveydate,surveytime,surveydesc,brhid,dtype,cldocno,$('#assigntrno').val());			
		}
		});
		}
	function saveAssignment(groupid,grpmemberid,grpempid,assignid,surveydate,surveytime,surveydesc,brhid,dtype,cldocno,assigntrno){              
        var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	if(parseInt(items)>0){  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'Successfully Saved'    
						});
						 document.getElementById("hidgroupid").value="";
					     document.getElementById("hidgrpmemberid").value="";
					     document.getElementById("hidgrpempid").value="";
					     document.getElementById("hidassignid").value="";
					     document.getElementById("jqxgrptosearch").value="";  
				         document.getElementById("jqxgrpsearch").value="";  
				         document.getElementById("jqxassignsearch").value="";         
				         document.getElementById("surveydesc").value="";  
				         $("#surveydate").val(new Date());  
				         $("#surveytime").val(new Date());
				         $("#overlay, #PleaseWait").hide();
				         loads(); 
				         getInitChartData();    
				         $("#modalassignment").modal('toggle');   
				}else{
				 		swal({
							type: 'error',
							title: 'Error', 
							text: 'Not Saved'      
						});  
			 	 }
				}
		       else
			  {}  
	     }
		x.open("GET","saveAssignment.jsp?assigntrno="+encodeURIComponent(assigntrno)+"&clientid="+cldocno+"&dtype="+dtype+"&brchid="+brhid+"&groupid="+groupid+"&grpmemberid="+grpmemberid+"&grpempid="+grpempid+"&assignid="+assignid+"&desc="+encodeURIComponent(surveydesc)+"&pdate="+surveydate+"&ptime="+surveytime+"&jobvocno="+$("#jobvocno").val(),true);
		x.send();    
    }
	
	function getCostBudgetingConfig(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var res= x.responseText;
			 	if(res<=0){
			 		$("#btncostbudget").hide();
				}
			}
		       else
			  {}
	     }
	     x.open("GET",'costBudgetingbtnConfig.jsp',true);
	     x.send();   
	}
	
	function funbudgetdivision(){        
		var rows = $("#jqxsubdivGrid").jqxGrid('getrows');
		var selectedrows=$("#jqxsubdivGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select a document!!!'                                          
			});
			return false;
		}
		
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		if(r==false){
			return false; 
		}else
		{
			$("#overlay, #PleaseWait").show();
	
			var i=0;
			var temptrno="",temptrno1="";               
			var j=0;
			for (i = 0; i < selectedrows.length; i++) {   
				if(i==0){
					var srvdetmtrno= $('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no")+"###"+$('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "budget");
					temptrno=srvdetmtrno;
				}else{
					var srvdetmtrno= $('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no")+"###"+$('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "budget");             
					temptrno=temptrno+","+srvdetmtrno;        
				}
				temptrno1=temptrno+",";
				j++; 
			}
			$('#budgetno').val(temptrno1);      
	
			saveBudget($('#budgetno').val());	            
		}
		});
		}  
	
	function saveBudget(trno){      
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			 if (x.readyState==4 && x.status==200) {
			    var items=x.responseText;
			    if(parseInt(items)>=1){
			    	swal({
						type: 'success',
						title: 'Success',
						text: 'Updated Successfully'    
					});
			      $("#jqxsubdivGrid").jqxGrid('clear');    
				  $('#budgetno').val("");   
				  $("#modalcostbudget").modal('toggle'); 
				  $("#overlay, #PleaseWait").hide();
				}else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Updated'       
					});
					$("#overlay, #PleaseWait").hide();
				}
			} 
		}   
		x.open("GET","saveBudgetData.jsp?trno="+encodeURIComponent(trno)+"&docno="+$("#jobdocno").val()+"&vocno="+$("#jobvocno").val()+"&brhid="+$("#brhid").val(),true);  
		x.send();       
	}
	
	function fundeploytechnician(){ 
		 var costtype = $('#dtype').val();  
		 var costcode = $('#trno').val();  
		 var site = $('#site').val();
		 var budget = $('#budget').val();
		 var consumed = $('#consumed').val();
		 var balance = $('#balance').val();     
		 
		 if(costtype==''){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select an item.'         
				});
			 return 0;
		 }
		 
		 if(costcode==''){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select an item.'            
				});
			 return 0;
		 }
		 
		 var rows = $("#manPowerAssignedGridID").jqxGrid('getrows');   
		 var gridarray=new Array();
		 for(var i=0;i<rows.length;i++){
			
			var chk=rows[i].actualhrs;
			var chks=rows[i].empdocno;
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
		    	if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
					var date=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'date');
					var empid=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'empdocno');
					var intime=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'intime');
					var outtime=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'outtime');
					var hrs=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'hrs');
					var actualhrs=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'actualhrs');
					var stdcost=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'stdcost');
					var total=$('#manPowerAssignedGridID').jqxGrid('getcelltext',rows[i],'total');
					
					gridarray.push(date+":: "+empid+":: "+intime+":: "+outtime+":: "+hrs+":: "+actualhrs+":: "+stdcost+":: "+total+":: "+costtype+":: "+costcode+":: "+site.replace(/,/g , "#"));
		    	}
		    }
		 }
		 	
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		 saveDeploytech(costtype,costcode,budget,consumed,balance,gridarray);	  
		     	}
		 });
	}
	
	function saveDeploytech(costtype,costcode,budget,consumed,balance,gridarray) {   
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				var docno = items[1];  
				
				if(parseInt(val)>0){
					swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Saved'      
					});
					$("#manPowerAssignedGridID").jqxGrid('clear');
					$("#manPowerAssignedGridID").jqxGrid("addrow", null, {});  
					$("#modaldeploytechnician").modal('toggle');   
					//loads();   
			        getInitChartData();  
				} else if(parseInt(val)==-1){
					 swal({
							type: 'warning',
							title: 'Warning',
							text: 'Already Exists.'         
						});
				} else {
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Saved'                 
						});
				}
		  }
		}    
	x.open("GET","saveDeployTechnician.jsp?costtype="+costtype+"&jobvocno="+$('#jobvocno').val()+"&trno="+$('#srno').val()+"&brchid="+$('#brhid').val()+"&costcode="+costcode+"&budget="+budget+"&consumed="+consumed+"&balance="+balance+"&gridarray="+encodeURIComponent(gridarray),true);
	x.send();
	}
	
	function funserviceupdate(method){
		 var txtsrtrno=$('#srtrno').val();
		 var txtsrdocno =  $('#srdocno').val();
		 var txtxper=$('#txtper').val();
		 var rect =  $('#rect').val();
		 var txtdesc = $('#txtdesc').val();
		 var brhid = $('#brhid').val();
		 console.log("branch-"+brhid);
		 var rectval=0;
		 if(txtxper==''){  
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please Enter Percentage'         
				});
			 return 0;
		 }
		
		 if(rect>0){
			 if(txtdesc==''){
				 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please Enter Description'            
					});
				 return 0;
			 }
			 rectval=1; 
		 }
		    var txtcustomerdocno=document.getElementById("cldocno").value;
			var txtcustomeracno=document.getElementById("acno").value;
			var cmbcontracttype=document.getElementById("dtype").value;  
			
			var txtcontracttrno=document.getElementById("reftrno").value;     
			var txtsiteid=document.getElementById("siteid").value;
			var txtareaid=document.getElementById("areaid").value;
			var txtscheduleno=document.getElementById("sheduleno").value;   
			var servicetype=document.getElementById("serdocno").value;  
			
		   $.messager.confirm('Confirm', 'Do you want to save changes? ', function(r){
	 			if (r){
	 			  		saveService(txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,txtsiteid,txtareaid,txtscheduleno,servicetype,txtxper,txtdesc,rectval,txtsrtrno,txtsrdocno,method,brhid);
						}
		   });  
	}
	function saveService(txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,txtsiteid,txtareaid,txtscheduleno,servicetype,txtxper,txtdesc,rectval,txtsrtrno,txtsrdocno,method,brhid){  
        var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
		     			
					var items=x.responseText;
					if(parseInt(items)==1){	
						swal({
							type: 'success',
							title: 'Success',
							text: 'Successfully '+method      
						});
						//loads();   
				        getInitChartData();  
						if(method=="Saved"){     
							$('#txtper').val('');
							$('#rect').val('');
							$('#txtdesc').val('');       
						}
					}else{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not '+method                    
						});  
					}
			}  
		}
      x.open("GET","saveService.jsp?txtcustomerdocno="+txtcustomerdocno+"&txtcustomeracno="+txtcustomeracno+"&cmbcontracttype="+cmbcontracttype
		   +"&txtcontracttrno="+txtcontracttrno+"&txtsiteid="+txtsiteid+"&txtareaid="+txtareaid+"&txtscheduleno="+txtscheduleno+"&brhid="+brhid+"&jobvocno="+$('#jobvocno').val()  
		   +"&servicetype="+servicetype+"&txtxper="+txtxper+"&txtdesc="+txtdesc+"&rectval="+rectval+"&txtsrtrno="+txtsrtrno+"&txtsrdocno="+txtsrdocno+"&method="+method,true);      		
	  x.send();    
	}
	function funRadioType(){
		if(document.getElementById("rdjobno").checked==true){  
			document.getElementById("txtemployee").value="";document.getElementById("txtemployeedocno").value="";
			document.getElementById("txtjobid").value="";document.getElementById("txtjobno").value="";
			$('#txtjobno').attr('disabled', false);$('#txtemployee').attr('disabled', true);
			if (document.getElementById("txtjobid").value == "") {
		        $('#txtjobno').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		} else if(document.getElementById("rdemployee").checked==true){
			document.getElementById("txtemployee").value="";document.getElementById("txtemployeedocno").value="";
			document.getElementById("txtjobid").value="";document.getElementById("txtjobno").value="";
			$('#txtemployee').attr('disabled', false);$('#txtjobno').attr('disabled', true);
			if (document.getElementById("txtemployeedocno").value == "") {
		        $('#txtemployee').attr('placeholder', 'Press F3 to Search');   
		    }
		}
	}
	function getJob(event){
        var x= event.keyCode;
        if(x==114){
	    	 jobSearchContent('jobDetailsSearch.jsp?dtype='+$('#dtype').val());  
        }
        else{}
    }
	function getEmployee(event){
        var x= event.keyCode;
        if(x==114){
        	manPowerSearchContent('employeeDetailsSearch.jsp?id=0');    
        }
        else{}
    }
	function funPrintDetails(){
		 var date = $('#date').val();
		 var employeedocno = $('#txtemployeedocno').val();
		 var jobno = $('#txtjobid').val();
		
        var url=document.URL;
        var reurl=url.split("amcmanagement.jsp");    
			 var win= window.open(reurl[0]+"printDeployTechnician?date="+date+'&employeedocno='+employeedocno+'&jobno='+jobno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		      win.focus();
	   }
	
  </script>
  <div id="manPowerGridWindow">     
	<div></div><div></div>
</div>
<div id="assignedDetailsWindow">
	<div></div><div></div>
</div>
<div id="jobDetailsWindow">
	<div></div><div></div>
</div>  
  </div>
  </form>   
</body>
</html>
