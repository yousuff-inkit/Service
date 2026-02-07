<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Dispatch</title>                      
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../underwritingIncludes.jsp"></jsp:include>        
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">
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
  </style>
</head>       
<body>            
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
             <form  class="form-inline">      
      
      
      
       <div>
      	 <div class="primarypanel custompanel1">   
  			<input type="radio"  id="radiosum"  data-toggle="tooltip" name="rdo" title="Invoice Details" onclick="radioClick();" value="radiosum" checked="checked" >Invoice Details  
          	<input type="radio"  id="radiodet" data-toggle="tooltip" name="rdo" title="Others" onclick="radioClick();" value="radiodet">Others
          </div>   
        </div> 
         <div class="primarypanel custompanel1">
	                      
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">From:</label>
    						<div class="form-group mb-2">
      							<div id='fromdate' name='fromdate'></div>
    						</div> </div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">To:</label>
    						<div class="form-group mb-2">
      							<div id='todate' name='todate'></div>      
			               </div> 	</div>
			                </div>
            
        <div class="primarypanel custompanel">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        </div>    
        <div class="actionpanel custompanel">        
            <button type="button" class="btn btn-default" id="btnvehmovupdate" data-toggle="modal" data-target="#modalstatusupdate"><i class="fa fa-database " aria-hidden="true" data-toggle="tooltip" title="Status Update" data-placement="bottom"></i></button>
         
       <button type="button" class="btn btn-default" id="btnstatupdate"  data-toggle="modal" data-target="#modalstatupdation" ><i class="fa fa-paper-plane " aria-hidden="true" data-toggle="tooltip" title="Dispatch Creation" data-placement="bottom"></i></button>
                                                         
          <button type="button" class="btn btn-default" id="btnvehmovupdate1" data-toggle="modal" data-target="#modalstatusupdate1"><i class="fa fa-list-alt " aria-hidden="true" data-toggle="tooltip" title="Dispatch" data-placement="bottom"></i></button>
                 
          <button type="button" class="btn btn-default" id="btnpartsdetails" data-toggle="modal" data-target="#modalprocesslog" ><i class="fa fa-check-circle " aria-hidden="true" data-toggle="tooltip" title="Under Process " data-placement="bottom"></i></button>
        
        <button type="button" class="btn btn-default" id="btnjobstatus"  data-toggle="modal" data-target="#modaltaskcreation" ><i class="fa fa-plus-square " aria-hidden="true" data-toggle="tooltip" title="Task Creation" data-placement="bottom"></i></button>
<!--        <button type="button" class="btn btn-default" id="btndispatch"  data-toggle="modal" data-target="#modaldispatch"><i class="fa fa-list-alt " aria-hidden="true" data-toggle="tooltip" title="Dispatch Task" data-placement="bottom"></i></button> -->
       <!-- <button type="button"  class="btn btn-default" id="btnconfirm"  data-toggle="modal" data-target="#modalconfirm" ><i class="fa fa-check-circle " aria-hidden="true" data-toggle="tooltip" title="Confirm" data-placement="bottom"></i></button> -->
        </div>                  
        <div class="warningpanel custompanel">  
       
       <div class="btn-group" role="group">
        <button type="button" class="btn btn-default" id="btnteamselection"  data-toggle="modal" data-target="#modalpendingtask"><i class="fa fa-newspaper-o " aria-hidden="true" data-toggle="tooltip" title="Pending Task" data-placement="bottom"></i></button>
        <span class="badge badge-notify badge-pendingtask"></span>
         </div> 
         
         <!-- <div class="btn-group" role="group">
       <button type="button" class="btn btn-default" id="btndispatch"  data-toggle="modal" data-target="#modaldispatch"><i class="fa fa-list-alt " aria-hidden="true" data-toggle="tooltip" title="Dispatch Task" data-placement="bottom"></i></button>
        <span class="badge badge-notify badge-dispatch"></span>
         </div>  -->
                 
          <!-- <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnpcdocrvd" data-toggle="tooltip" title="Policy document received" data-placement="bottom" data-filtervalue="Policy document received" data-datafield="estatus"><i class="fa fa-envelope-open-o " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-pcdocrvd"></span>     
          </div>	
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btncardsrvd" data-toggle="tooltip" title="Cards/Certificate Received" data-placement="bottom" data-filtervalue="Cards/Certificate Received" data-datafield="estatus"><i class="fa fa-certificate " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-cardsrvd"></span>
          </div> 
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnsndbymsngr" data-toggle="tooltip" title="Sent by messenger" data-placement="bottom" data-filtervalue="Sent by messenger" data-datafield="estatus"><i class="fa fa-commenting-o  " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-sndbymsngr"></span>
          </div>   
          <div class="btn-group" role="group">
          	<button type="button" class="btn btn-default" id="btnbkdcorr" data-toggle="tooltip" title="Booked Courier" data-placement="bottom" data-filtervalue="Booked Courier" data-datafield="estatus"><i class="fa fa-archive " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-bkdcorr"></span> 
          </div>  --> 
        </div>                      
       <!--  <div class="detailpanel custompanel">
          <button type="button" class="btn btn-default" id="btnpartsdetails" data-toggle="modal" data-target="#modalprocesslog" ><i class="fa fa-list-alt " aria-hidden="true" data-toggle="tooltip" title="Process Log" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnworks" data-toggle="modal" data-target="#modalstatusdetails" ><i class="fa fa-bar-chart " aria-hidden="true" data-toggle="tooltip" title="Status Statistics" data-placement="bottom"></i></button>        
          <button type="button" class="btn btn-default" id="btnsalesman" data-toggle="modal" data-target="#modalsalesman" ><i class="fa fa-bar-chart " aria-hidden="true" data-toggle="tooltip" title="Salesman Statistics" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnunderwriter" data-toggle="modal" data-target="#modalunderwriter" ><i class="fa fa-bar-chart " aria-hidden="true" data-toggle="tooltip" title="Underwriter Statistics" data-placement="bottom"></i></button>
        </div> -->
        <div class="detailpanel custompanel">       
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
        </div>                                     
        <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>
        <div class="textpanel custompanel">
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>
        </div>
        </form>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
<%--         <div id="Undwtrdiv"><jsp:include page="UndwtrGrid.jsp"></jsp:include></div> --%>
   		<div id="summarydiv"><jsp:include page="summarygrid.jsp"></jsp:include></div>
   	 </div>
    </div>
    
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
   		<div id="disdiv"><jsp:include page="dispatchGrid.jsp"></jsp:include></div>  
      </div>
    </div>
    
   
    
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
   		 <div id="disflwupdiv2"> <jsp:include page="dispatchfollowupGrid2.jsp"></jsp:include></div>
      </div>
    </div>
    
     <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
   		 <div id="disflwupdiv"> <jsp:include page="dispatchfollowupGrid.jsp"></jsp:include></div>
      </div>
    </div>


  

    <!-- Vehicle Movement Modal-->
    <div id="modalstatusupdate" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Status Update</h4> 
            <table width="100%" >
            <tr>
          <td align="center"><label id="clientref1"></label> </td>
          </tr></table> 
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">      
            	<div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Status</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select class="cmbbaymovupdate" name="cmbstatus" id="cmbstatus" style="width: 100%">
						</select>
						
					</div>
				</div>
            	<div class="row rowgap">  
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assign To</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<div id="part" onkeydown="return (event.keyCode!=13);"><jsp:include page="disuserSearch.jsp"></jsp:include></div>
						<input type="hidden" name="hiduserdis" id="hiduserdis"></div> 
				</div>		
				<div class="row rowgap">  	
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Remarks</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<input type="text" style="width:100%;height:20px;" id="remarks"/>
					</div>
					 
            	</div>
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
<!-- 						<button type="button" name="btnstatuspdate" id="btnstatuspdate" class="btn btn-default">UPDATE</button> -->
					<button type="button" name="btnupdate" class="btn btn-info" id="btnupdate" onclick="fundispatchUpdate();" class="btn btn-default">Update</button>
					</div>
				</div>
            	</div>   
            </div>  
           <!--   <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:F32020">Close</button>
          </div> -->
          </div>  
        </div>
      </div>
    
    
     <!-- Vehicle Movement Modal-->
    <div id="modalstatusupdate1" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Dispatch</h4> 
            <table width="100%" >
            <tr>
         <!--  <td align=clientref1"center"><label id=""></label> </td> -->
          </tr></table> 
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">      
            	<div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Dispatch mode</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select class="cmbbaymovupdate" name="cmbmode" id="cmbmode" style="width: 100%">
						</select>
						
					</div>
				</div>
				
				
            	<div class="row rowgap">  
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">User</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<div id="part1" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch4.jsp"></jsp:include></div>
						<input type="hidden" name="disuser" id="disuser"></div> 
				</div>	
				
				  <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Date</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="ddate" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>  
            	</div>
					
					<div class="row rowgap">  	
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Received By</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<input type="text" style="width:100%;height:20px;" id="receivedby"/>
					</div>
					 
            	</div>
					
				 <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Acknowledged Date</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="ackdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>  
            	</div>  
					
				<div class="row rowgap">  	
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Remarks</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<input type="text" style="width:100%;height:20px;" id="remark"/>
					</div>
					 
            	</div>
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
<!-- 						<button type="button" name="btnstatuspdate" id="btnstatuspdate" class="btn btn-default">UPDATE</button> -->
					</div>
				</div>
            	</div>   
            </div>  
              <div class="modal-footer">
              <button type="button" name="btnupdate" class="btn btn-info" id="btnupdate" onclick="fundispatchmodeUpdate();" class="btn btn-default">Update</button>
              
            <button type="button" class="btn btn-default" data-dismiss="modal"  style="background-color:F32020">Close</button>
          </div> 
          </div>  
        </div>
      </div>
 <!-- Dispatch Modal-->        
    <div id="modaldispatch" class="modal fade" role="dialog">     
      <div class="modal-dialog modal-xl">    
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Dispatch Task</h4>      
          </div>
          <div class="modal-body">
           <div class="modal-body"> 
    	<div class="container-fluid">
				<table width="100%">  
 				 <tr> 
   				 <td colspan="6"><div id="disdiv"><jsp:include page="dispatchGrid.jsp"></jsp:include></div></td>
  				</tr> 
  				 <tr> 
<%--    				 <td colspan="6"><div id="disflwupdiv"><jsp:include page="dispatchfollowupGrid.jsp"></jsp:include></div></td> --%>
  				</tr>    
  				<tr><td>&nbsp;</td></tr>                
  			<tr>  
    <td width="7%" align="right">Select Status</td>      
    <td width="9%"><select id="dispatchtask" style="width:100%;height: 20px;position: static;"></select></td>
    <td width="7%" align="right">Assign To</td>            
	<td width="4%"><div id="part" onkeydown="return (event.keyCode!=13);"><jsp:include page="disuserSearch.jsp"></jsp:include></div>
	<input type="hidden" name="hiduserdis" id="hiduserdis">         
	                </td>     
	<td width="5%" align="right">Remarks</td>                  
	<td width="25%"><input type="text" style="width:100%;height:20px;" id="remarks"/></td>                            
  </tr>       
 </table> 
 </div>   
   <div class="clear"></div>                                   
     </div>
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">
          <button type="button" name="btnupdate" class="btn btn-info" id="btnupdate" onclick="fundispatchUpdate();" class="btn btn-default">Update</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal" style="background-color:red">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Pending Modal-->        
    <div id="modalpendingtask" class="modal fade" role="dialog">     
      <div class="modal-dialog modal-xl">    
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Pending Task</h4>      
          </div>
          <div class="modal-body">
           <div class="modal-body"> 
    	<div class="container-fluid">
				<table width="100%">  
 				 <tr> 
   				 <td colspan="6"><div id="pnddiv"><jsp:include page="pendingtaskGrid.jsp"></jsp:include></div></td>
  				</tr> 
  				<tr> 
   				 <td colspan="6"><div id="flwupdiv"><jsp:include page="taskfollowupGrid.jsp"></jsp:include></div></td>
  				</tr>   
  				<tr><td>&nbsp;</td></tr>                       
  			<tr>  
    <td width="7%" align="right">Select Status</td>      
    <td width="9%"><select id="assgntask" style="width:100%;height: 20px;position: static;"></select></td>
    <td width="7%" align="right">Assign To</td>            
	<td width="4%"><div id="part" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch.jsp"></jsp:include></div>
	<input type="hidden" name="hiduser2" id="hiduser2">         
	                </td>     
	<td width="5%" align="right">Remarks</td>                  
	<td width="25%"><input type="text" style="width:100%;height:20px;" id="remarks"/></td>                            
  </tr>       
 </table> 
 </div>   
   <div class="clear"></div>                                   
     </div>
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">
          <button type="button" class="btn btn-info" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="btn btn-default">Update</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal" style="background-color:red">Close</button>
          </div>
        </div>
      </div>
    </div>
    <!-- task creation Modal-->
    <div id="modaltaskcreation" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Task Creation</h4>                
          </div>  
<div class="modal-body"> 
    <div class="container-fluid">
    <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Select a Reference Type</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select id="reftype" style="width:69%;">
							<option value="Enquiry">Enquiry</option>
							<option value="Quotation">Quotation</option>
							<option value="Others">Others</option>
						</select>
					</div>  
            	</div>

      <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Reference No</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<input type="number" placeholder="Ref.No" id="refno" style="width:69%;">
					</div>  
            	</div>

        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Start Date</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="date" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>  
            	</div>  
            	
      <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Start Time</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="vtime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>        
            	</div>
            	
       <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assigned User</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="partss" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch2.jsp"></jsp:include></div>
                     	<input type="hidden" name="hiduser" id="hiduser">  	</div>  
            	</div>
            	   
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="desc"></textarea>
					</div>  
            	</div>
</div>
<div class="clear"></div>
</div>
          <div class="modal-footer" style="background-color:#CDFDFA">
          <button type="button" class="btn btn-info" onclick="funSave();">SAVE</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal" style="background-color:red">Close</button>
          </div>                 
        </div>
      </div>
    </div>
  
      <!-- status updation Modal-->
    <div id="modalstatupdation" class="modal fade" role="dialog">  
      <div class="modal-dialog  modal-lg">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Dispatch Creation</h4>                
          </div>  
<div class="modal-body"> 
    <div class="container-fluid">
     <!--  <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Doc No</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<input type="number" placeholder="Doc no" id="docno" style="width:69%;">
					</div>  
            	</div>
 -->
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Date</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="sdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>  
            	</div>  
            	
      <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Time</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="stime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>        
            	</div>
            	
       <div class="row rowgap">           
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assigned User</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="partss" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch3.jsp"></jsp:include></div>
                     	<input type="hidden" name="hiduser" id="hiduser">  	</div>  
            	</div>    	
        
       <div class="row rowgap">   
       <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"> 
       				<input type="radio" name="nam" id="hidclient" onchange="funCheck();">Client&nbsp;&nbsp;
            		<input type="radio" name="nam" id="hidvendor" onchange="funCheck();">Vendor</div>
            		<div id="clientdiv" class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="client"   onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearch.jsp"></jsp:include></div>
                     	<input type="hidden" name="hidcldocno" id="hidcldocno">  	</div>  
            	    <div id="vendordiv" class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="vendor"  onkeydown="return (event.keyCode!=13);"><jsp:include page="vendorSearch.jsp"></jsp:include></div>
                     	<input type="hidden" name="hidcldocno" id="hidcldocno">  	</div>  
            	    </div>
            	   
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Address</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <input type="text" style="width:100%;height:20px;" placeholder="Address" id="address">
					</div>  
            	</div>
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Location Details</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <input type="text" style="width:100%;height:20px;" placeholder="Location" id="location">
					</div>  
            	</div>
            	
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Contact Details</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <input type="text" style="width:100%;height:20px;" placeholder="Contact" id="contact">
					</div>  
            	</div>
       
       <div class="row rowgap">   
       <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
       				<input type='checkbox' id='chkval' name='chkval' onchange="intro1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
       Dispatch Details<input type="hidden" id="hidchkval" name="hidchkval"/>
       </div>
<!--             		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Dispatch Details</div> -->
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <input type="text" style="width:100%;height:20px;" placeholder="Dispatch details" id="dispatch">
					</div>  
            	</div>
       <div class="row rowgap">
       <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">    
       <input type='checkbox' id='chkval1' name='chkval1' onchange="introcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
       Collect details<input type="hidden" id="hidchkval1" name="hidchkval1"/>
       </div> 
<!--             		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Collect details</div> -->
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <input type="text" style="width:100%;height:20px;" placeholder="Collect details" id="collect">
					</div>  
            	</div>
            	
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Message</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Message" id="msg"></textarea>
					</div>  
            	</div>    	
            	
         
</div>
<div class="clear"></div>
</div>
          <div class="modal-footer" style="background-color:#CDFDFA">
          <button type="button" class="btn btn-info" onclick="funSaveData();">SAVE</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal" style="background-color:red">Close</button>
          </div>                 
        </div>
      </div>
    </div>
  <!-- Process log model -->
     <div id="modalprocesslog" class="modal fade" role="dialog">         
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Under Process</h4>
             <table width="100%" >
            <tr>
         <!--   <td align="center"><label id="clientref2"></label> </td>   -->
          </tr></table>  
          </div>             
         <div class="modal-body"> 
         <div class="container-fluid">   
  				<div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Under Process</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<select class="cmbbaymovupdate" name="cmbunderprocess" id="cmbunderprocess" style="width: 100%">
						</select>
						
					</div>
				</div>
  				
  				<div class="row rowgap">  	
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Remarks</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            			<input type="text" style="width:100%;height:20px;" id="remarks1"/>
					</div>
					 
            	</div>
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
<!-- 						<button type="button" name="btnstatuspdate" id="btnstatuspdate" class="btn btn-default">UPDATE</button> -->
					</div>
				</div>
  				
  				</div>
          </div> 
          <div class="modal-footer" style="background-color:#CDFDFA">   
          	<button type="button" name="btnupdate" class="btn btn-info" id="btnupdate" onclick="fundispatchmodeUpdate();" class="btn btn-default">Update</button>
               
             <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Work Details Modal-->
    <div id="modalstatusdetails" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Status Statistics</h4>      
          </div>
          <div class="modal-body">
          <div id="statusdiv"><jsp:include page="statusGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div>
        </div>
      </div>
    </div>

   <!-- Salesman Details Modal-->
    <div id="modalsalesman" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Salesman Statistics</h4>      
          </div>
          <div class="modal-body">
          <div id="salmdiv"><jsp:include page="salesmanGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div>  
        </div>  
      </div>
    </div>
    
       <!-- Underwriter Details Modal-->   
    <div id="modalunderwriter" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Business Processor Statistics</h4>      
          </div>  
          <div class="modal-body">
          <div id="unddiv"><jsp:include page="undstatusGrid.jsp"></jsp:include></div>
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div>   
        </div>
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
    <input type="hidden" name="hidid" id="hidid">    
     <input type="hidden" name="hiddocno" id="hiddocno">
          <input type="hidden" name="hiddoc_no" id="hiddoc_no">    
         
    <input type="hidden" name="hidbrhid" id="hidbrhid">  
    <input type="hidden" name="hiddtype" id="hiddtype">
    <input type="hidden" name="hidvocno" id="hidvocno">       
  
    <input type="hidden" name="cnttrno" id="cnttrno"> 
    <input type="hidden" name="hidcomments" id="hidcomments">  
   <input type="hidden" name="txtrefname" id="txtrefname">
  <input type="hidden" name="txtoldstatus" id="txtoldstatus">       
  <input type="hidden" name="statusid" id="statusid">     
  <input type="hidden" name="txttrno" id="txttrno">  
  <input type="hidden" name="txtenqdate" id="txtenqdate">   
  <input type="hidden" name="txtenqno" id="txtenqno">  
  <input type="hidden" name="txtqotno" id="txtqotno">  
   <input type="hidden" name="txtcrtuser" id="txtcrtuser">                           
  <input type="hidden" name="txtasgnuser" id="txtasgnuser">   
   <input type="hidden" name="txtpendocno" id="txtpendocno">   
   
   <input type="hidden" name="dispatchdocno" id="dispatchdocno">   
   <input type="hidden" name="dispatchasgnuser" id="dispatchasgnuser">                           
  <input type="hidden" name="dispatchcrtuser" id="dispatchcrtuser">   
   <input type="hidden" name="dispatcholdstatus" id="dispatcholdstatus">  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){
    	$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#vtime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
    	$("#sdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#stime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../icons/31load.gif'/></div>");
	     $("#ackdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	    	$("#ddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	        $('#sdate').jqxDateTimeInput('setDate', new Date());  
	       // $('#ackdate').jqxDateTimeInput('setDate', new Date());  

	        $("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
			$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
			var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			  $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
				$('#todate').on('change', function (event) {
					   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
					   if(fromdates<todates){
						   Swal.fire({  
			        			icon: 'warning',
								title: 'Warning',
								text: 'To Date Less Than From Date'
							});
					        return false;  
					  }   
				 });
    	$('[data-toggle="tooltip"]').tooltip(); 
    	funClearInfo();
    	$('#vtime').jqxDateTimeInput('setDate', new Date());  
        $('#stime').jqxDateTimeInput('setDate', new Date());  
        
        $('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();
        funGetCountData(); 
        $("#collect").attr('disabled', true );
        $("#dispatch").attr('disabled', true );
			  $("#disdiv").prop("hidden", true);
			  $("#disflwupdiv").prop("hidden", true);

        document.getElementById('hidclient').checked=true;
		 $('#clientdiv').show();
         $('#vendordiv').hide();
         $('#btnvehmovupdate').hide();
         $('#btnstatupdate').hide();
        
        $('#btnsubmit').click(function(){     
        	 funGetCountData();     
        	 $('.textpanel p').text('');
        	document.getElementById("txttrno").value="";
        	document.getElementById("txtenqno").value="";
        	document.getElementById("txtenqdate").value="";      
        	$('#statusdiv').load('statusGrid.jsp?enqdate='+$('#txtenqdate').val()+'&enqno='+$('#txtenqno').val()+'&id='+1);
        	$('#salmdiv').load('salesmanGrid.jsp?enqdate='+$('#txtenqdate').val()+'&enqno='+$('#txtenqno').val()+'&id='+1);
        	$('#unddiv').load('undstatusGrid.jsp?enqdate='+$('#txtenqdate').val()+'&enqno='+$('#txtenqno').val()+'&id='+1);   
       loads();
       $('#disfollowupGrid').jqxGrid('clear');
        });
        
        
        $('#btnstatupdate').click(function(){   
	        	document.getElementById("address").value="";
	        	document.getElementById("dispatch").value="";
	        	document.getElementById("location").value="";
	        	document.getElementById("contact").value="";  
	        	document.getElementById("collect").value="";
	        	document.getElementById("jqxInputUserss").value="";  
	        	document.getElementById("msg").value="";  
	        	document.getElementById("jqxInputClient").value="";  
	        	document.getElementById("jqxInputVendor").value="";  
	        	//document.getElementById("hiduser").value=""; 
	            //document.getElementById("docno").value=""; 
	        	document.getElementById("hiduser").value="";                   
	        	document.getElementById("jqxInputUserss").value="";                                              
            });
 			
        $('#btndispatch').click(function(){   
        	
        	$('#disfollowupGrid').jqxGrid('clear');
        	
//         	document.getElementById("docno").value=""; 
            });
        
        $("#btnconfirm").attr('disabled', true ); 
   	    $('#btnconfirm').click(function(){     
      	funupdatecn();
        });
      //  $('#btnpartsdetails').click(function(){  
        //	$('#processdiv').load('processGrid.jsp?enqno='+$('#txtenqno').val());        
     //   });  
        $('#btnteamselection').click(function(){ 
        	reload();
        });
        $('#btndispatch').click(function(){ 
        	reload();
        });
        $('#btnattachs').click(function(){ 
        	funAttachs(event);      
        });
        
       
        
   /*      $('#btnworks').click(function(){  
        	$('#statusdiv').load('statusGrid.jsp?enqdate='+$('#txtenqdate').val()+'&enqno='+$('#txtenqno').val());        
        });  
        $('#btnsalesman').click(function(){  
        	$('#salmdiv').load('salesmanGrid.jsp?enqdate='+$('#txtenqdate').val()+'&enqno='+$('#txtenqno').val());        
        });
        $('#btnunderwriter').click(function(){  
        	$('#unddiv').load('undstatusGrid.jsp?enqdate='+$('#txtenqdate').val()+'&enqno='+$('#txtenqno').val());        
        }); */
        
        $('#btnvehmovupdate').click(function(){   
		        	$('#dispatchGrid').jqxGrid('clearfilters', true);  

        	if($('#dispatchdocno').val()==''){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	document.getElementById("clientref1").innerText=$('#txtrefname').val();      
        	getStatus();   
        }); 
        
        
        $('#btnvehmovupdate1').click(function(){ 
		        	$('#jqxsummarygrid').jqxGrid('clearfilters', true);  

        	loadSearchSelect();
        	var hiddocno=document.getElementById("hiddocno").value;
        	//alert(hiddocno);

        	if( $('#hiddocno').val()==''){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	//document.getElementById("clientref1").innerText=$('#txtrefname').val(); 
        //	$("#modalstatusupdate").modal('toggle');         

        	getDispatchmode();   
        });   
        $('#btnpartsdetails').click(function(){
			        	$('#jqxsummarygrid').jqxGrid('clearfilters', true);  

        	loadSearchSelect();
        	var hiddocno=document.getElementById("hiddocno").value;
        	//alert(hiddocno);
        	if( $('#hiddocno').val()==''){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	//document.getElementById("clientref2").innerText=$('#txtrefname').val();
        //	$("#modalprocesslog").modal('toggle');         

        	getUnderprocess();
        });
        $('#btncomment').click(function(){
        	 getComments();
        var enqno=$('#txtenqno').val();
    	if(enqno==""){
    		swal({
				type: 'error',
				title: 'Warning',
				text: 'Please select a document'   
			});
    		return false;
    	}
        }); 
        $('#btnexcel').click(function(){            
        	  var rad= document.getElementById("hidid").value; 
           	 if(rad==""){

             		rad=1;
             	}
     			if (rad==0)
     				{
     				$("#disdiv").excelexportjs({ 
     	        		containerid: "disdiv",       
     	        		datatype: 'json', 
     	        		dataset: null, 
     	        		gridId: "dispatchGrid",   
     	        		columns: getColumns("dispatchGrid") ,   
     	        		worksheetName:"Dispatch Management"  
     	         		});
     				
     	
     	}
             else
             	{
             	
             	$("#summarydiv").excelexportjs({ 
             		containerid: "summarydiv",       
             		datatype: 'json', 
             		dataset: null, 
             		gridId: "jqxsummarygrid",   
             		columns: getColumns("jqxsummarygrid") ,   
             		worksheetName:"Dispatch Management"  
              		});

             	}
            
             	});  
       
        $('#btncommentsend').click(function(){
        	var enqno=$('#txtenqno').val();
        	var txtcomment=$('#txtcomment').val();
        	if(enqno==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	saveComment();
        });
        
        
        
        $('#btnstatuspdate').click(function(){  
        	if($('#txttrno').val()==''){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}    
        	if($('#cmbstatus').val()==''){ 
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a status'  
				});
        		return false;
        	}     
        	funUpdateStatus();
        });
        
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#UnderwriterGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
        
        var userid= "<%= session.getAttribute("USERID").toString() %>";     
        //alert("in userid--->>>"+userid);   
      //pending  
		var str1="";
		var q=new XMLHttpRequest();
		q.onreadystatechange=function()
		{
			if(q.readyState==4 && q.status==200)
			{
				var msgg=q.responseText.trim().split(',');
				//alert(msgg);
				for(var i=0;i<=msgg.length-1;i++)
		        {
		        	var docid=msgg[i].split('::')[0].trim();
		        	//alert(docid);

		        	if(docid!="" && docid!="undefined" && docid!=null)
		        	{
		        	
		        	str1+='<tr class="taskrows"><td style="display:none;"><label class="taskdatas" style="display:none;">'+msgg[i].split('::')[0]+'</label></td><td width="19%" id="rftype"><label class="taskdatas">'+msgg[i].split('::')[1]+'</label></td><td width="18%"><label class="taskdatas">'+msgg[i].split('::')[2]+'</label></td><td width="10%"><label class="taskdatas">'+msgg[i].split('::')[3]+'</label></td><td width="19%"><label class="taskdatas">'+msgg[i].split('::')[4]+'</label></td><td width="10%"><label class="taskdatas">'+msgg[i].split('::')[5]+'</label></td><td width="24%"><label class="taskdatas">'+msgg[i].split('::')[6]+'</label></td></tr>';

		          	// alert(str1);
		          }
		        	if(str1!=""){
						$('#tblpendingtask tbody').html($.parseHTML(str1));
		        	}
		        }
		        
		        
			}
		}
		q.open("GET","getPendingtask.jsp?userid="+userid,true);
		q.send(); 
    });
  
function loadSearchSelect(){
	var selectedrows,rows;
 	 if(document.getElementById("radiodet").checked){

		 rows = $("#dispatchGrid").jqxGrid('getrows');		
		 selectedrows=$("#dispatchGrid").jqxGrid('selectedrowindexes');
 	 }
 	 else
 		 {
 		 rows = $("#jqxsummarygrid").jqxGrid('getrows');	
		 selectedrows=$("#jqxsummarygrid").jqxGrid('selectedrowindexes');
 	
 		 }
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		var i=0;var j=0;var k=0;var tempdocno="",tempdocno1="",tempdtype="",tempdtype1="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(k==0){
						tempdocno=rows[i].doc_no;
						tempdtype=rows[i].dtype;

					}
					else{
						tempdocno=tempdocno+","+rows[i].doc_no;
						tempdtype=tempdtype+","+rows[i].dtype;

					}
					tempdocno1=tempdocno;
					tempdtype1=tempdtype;

				k++;	
				j++; 
			  }
            }
	    
		    $('#hiddocno').val(tempdocno1);
		    $('#hiddtype').val(tempdtype1);

		   // alert("array--------"+tempdocno1);
		   
	}
	
function  funClearInfo(){
	$('#cmbmode').val('');
	$('#hiddtype').val('');
	$('#ddate').val('');
	$('#ackdate').val('');
	$('#receivedby').val('');
	$('#disuser').val('');
	$('#hiddocno').val('');
	$('#jqxInputUsersss').val('');
	 $('#remark').val('');
	 $('#remarks1').val('');
	 $('#underprocess').val('');
	 
	 	 $('#jqxsummarygrid').jqxGrid('clearselection');

	 $('#refno').val('');
    // $('#vtime').val('');
     $('#jqxInputUsers').val('');
     $('#hiduser').val('');
     $('#desc').val('');

     $('#jqxInputClient').val('');
     $('#jqxInputVendor').val('');
     $('#jqxInputUserss').val('');
     $('#hidcldocno').val('');
     $('#location').val('');
     $('#address').val('');
     $('#contact').val('');
     $('#dispatch').val('');
     $('#collect').val('');
     $('#msg').val('');
     $('#hiduser').val('');
     
	 $('#disfollowupGrid').jqxGrid('clear');
	 $('#disfollowupGrid2').jqxGrid('clear');
	 $('#disdiv').jqxGrid('clear');
	 $('#summarydiv').jqxGrid('clear');

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
    	$("#UnderwriterGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#UnderwriterGrid").jqxGrid('applyfilters');
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#txtenqno').val();
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
    	var enqno=$('#txtenqno').val();
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
   
    function funUpdateStatus(){
    	var trno=$('#txttrno').val();     
    	var statusid=$('#cmbstatus').val();  
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					swal({
						type: 'success',
						title: 'Message',
						text: 'Status Updated'
					});
					 funGetCountData();     
				}
				else{
					swal({
						type: 'error',
						title: 'Warning',
						text: 'Not Updated'
					});
				}
			funClearInfo();	
			}
			else
			{
			}    
		}
		x.open("GET","statUpdate.jsp?statusid="+statusid+"&trno="+trno,true);
		x.send();
    }
    
    function funGetCountData(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");
				$('.badge-pcdocrvd').text(items[0]);
				$('.badge-cardsrvd').text(items[1]);
				$('.badge-sndbymsngr').text(items[2]);  
				$('.badge-bkdcorr').text(items[3]); 
				$('.badge-pendingtask').text(items[4]);   
				$('.badge-dispatch').text(items[5]);   
			}        
			else
			{
			}  
		}
		x.open("GET","getCountData.jsp",true);
		x.send();
    }
    
    function getStatus(){
    	var statusid=document.getElementById("statusid").value;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var status = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < status.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'  
							+ status[i] + '</option>';  
				}
				$("select#cmbstatus").html(optionsbranch);  
				
			} else {}  
		}
		x.open("GET","getStatuses.jsp?statusid="+statusid, true);
		x.send();   
	}
    var check=0;
    function getDispatchmode(){
    	
    	var statusid=document.getElementById("statusid").value;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var status = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < status.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'  
							+ status[i] + '</option>';  
				}
				$("select#cmbmode").html(optionsbranch);  
				check=1;
			} else {}  
		}
		x.open("GET","getdispatchmode.jsp", true);
		x.send();   
	}
    
    
    function getUnderprocess(){
    	var statusid=document.getElementById("statusid").value;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var status = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < status.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'  
							+ status[i] + '</option>';  
				}
				$("select#cmbunderprocess").html(optionsbranch);  
				check=0;
			} else {}  
		}
		x.open("GET","getunderprocess.jsp", true);
		x.send();   
	}
    
    function radioClick(){
      	 if(document.getElementById("radiodet").checked){
      		document.getElementById("hidid").value=0;  
      		  $("#summarydiv").prop("hidden", true);
      		  $("#disflwupdiv2").prop("hidden", true);

     			  $("#disdiv").prop("hidden", false);
          		  $("#disflwupdiv").prop("hidden", false);
                  $('#btnvehmovupdate').show();
                  $('#btnstatupdate').show();
                  $('#btnvehmovupdate1').hide();
                  $('#btnpartsdetails').hide();

     			  $("#summarydiv").jqxGrid('clear');
     			  $("#disdiv").jqxGrid('clear');
     			  $("#summarydiv").jqxGrid("addrow", null, {});
     			  $("#disdiv").jqxGrid("addrow", null, {});
     			
   	 }
   	 else if(document.getElementById("radiosum").checked){

   		 	document.getElementById("hidid").value=1;
   		 	  $("#summarydiv").prop("hidden", false);
      		  $("#disflwupdiv2").prop("hidden", false);

   			  $("#disdiv").prop("hidden", true);
      		  $("#disflwupdiv").prop("hidden", true);
      		 $('#btnvehmovupdate').hide();
             $('#btnstatupdate').hide();
             $('#btnvehmovupdate1').show();
             $('#btnpartsdetails').show();

   			  $("#summarydiv").jqxGrid('clear');
   			  $("#disdiv").jqxGrid('clear');
   			  $("#summarydiv").jqxGrid("addrow", null, {});
   			  $("#disdiv").jqxGrid("addrow", null, {});
   			

   	 }
      	
      }
    
    function fundispatchmodeUpdate(){   
    	
    	var docno=$('#hiddocno').val(); 
    	var dtype=$('#hiddtype').val(); 
    //	alert(dtype);

    	var ddate=$('#ddate').val();
    	var ackdate=$('#ackdate').val();
    	var receivedby= document.getElementById("receivedby").value;  
    	var userid=$('#disuser').val();   
    var status,remarks;
    	if(check==1)
    		{
        	 status=$('#cmbmode').val(); 
         	 remarks= document.getElementById("remark").value;  
         	if(ddate=="")   
        	{
        		$.messager.alert('Message','Enter Date','warning');   
       		    document.getElementById('ddate').focus();
    			 return 0;
        	}
         	if(status=="")   
        	{
        		$.messager.alert('Message','Select Dispatch Mode','warning');   
       		    document.getElementById('cmbmode').focus();
    			 return 0;
        	}
    		}
    	else
    		{
    		status=$('#cmbunderprocess').val();
        	remarks= document.getElementById("remarks1").value;  
        	if(status=="")   
        	{
        		$.messager.alert('Message','Select Underprocess','warning');   
       		    document.getElementById('cmbunderprocess').focus();
    			 return 0;
        	}

    		}

    	
    	

    	//var crtuser=$('#dispatchcrtuser').val(); 
     	//var status=$('#dispatchtask').val(); 
    	//var oldstat= document.getElementById("dispatcholdstatus").value;  
      //	var asgnuser=$('#hiduserdis').val();    
      //	var oldassuser=document.getElementById("dispatchasgnuser").value;   
    //	var userid=$('#hiduserdis').val(); 
    
     $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		    	     saveData1();       
		     	}  
		 }); 
    
    function saveData1(){
    	
   
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{ 
				var items=x.responseText.trim();
				if(items>0){
					$('#cmbmode').val('');
					$('#hiddtype').val('');
					$('#ddate').val('');
					$('#ackdate').val('');
					$('#receivedby').val('');
					$('#disuser').val('');
					$('#hiddocno').val('');
					$('#jqxInputUsersss').val('');
					 $('#remark').val('');
					 $('#remarks1').val('');
					 $('#underprocess').val('');
					 $('#disfollowupGrid').jqxGrid('clear');
					swal({
						type: 'success',
						title: 'Message',
						text: ' Updated'
					});
					funGetCountData();
					if (check==1)
						{
			        	$("#modalstatusupdate1").modal('toggle');         

						}
					else
						{
			        	$("#modalprocesslog").modal('toggle');

						}


				}else{ 
					swal({
						type: 'error',
						title: 'Warning',
						text: 'Not Updated'                               
					});
				}
				funClearInfo();	

			}else
			{
			}    
		}
	//	alert("userid="+userid+"&docno="+docno+"&status="+status+"&dtype="+dtype+"&ddate="+ddate+"&ackdate="+ackdate+"&receivedby="+receivedby+"&remarks="+remarks);
		x.open("GET","dispatchmodeUpdate.jsp?userid="+userid+"&docno="+docno+"&status="+status+"&dtype="+dtype+"&ddate="+ddate+"&ackdate="+ackdate+"&receivedby="+receivedby+"&remarks="+remarks,true);           
		x.send();
    }
    } 
    
    function funUser()
	{
			//var mytext=localStorage.getItem("path");
			//var userid=Cookies.get("userid");
			var userid="<%= session.getAttribute("USERID").toString() %>";     
			var user=new Array();
			var x=new XMLHttpRequest();
			x.onreadystatechange=function()
			{
				if(x.readyState==4 && x.status==200)
				{
					var msg=x.responseText.trim().split(',');
					//alert(msg);
		            for(var i=0;i<=msg.length-1;i++)
		            {
		            	var cdoc=msg[i].split('::')[0];
		              	var unam=msg[i].split('::')[1];
		              	//var cc=cdoc+"::"+cl;
		              	user.push(unam+":"+cdoc);
		            }
		            autocomplete(document.getElementById("user"), user);
				}
			}  
			x.open("GET","getUser.jsp?userid="+userid,true);
			x.send();
	}
    function funCheck(){
    	 if (document.getElementById('hidclient').checked) {
 			
       		 $('#clientdiv').show();
       		$('#vendordiv').hide();
       		  
       		} 
       	 else  if (document.getElementById('hidvendor').checked){
       		$('#vendordiv').show();
       		$('#clientdiv').hide();
       	 }
    }
    
    function reload(){         
  	    var userid= '<%=session.getAttribute("USERID")%>';  
 	     $("#overlay, #PleaseWait").show();
	     var rad= document.getElementById("hidid").value; 
	     var fromdate= $("#fromdate").val();
		    var todate= $("#todate").val();

    	   if (rad==1|| rad=="")
    		  {
   		    $('#summarydiv').load('summarygrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');
    		  }
    	  else 
    		  {
	    	    $('#disdiv').load('dispatchGrid.jsp?userid='+userid+'&fromdate='+fromdate+'&todate='+todate+'&check=1'); 

    		  }
     		$('#pnddiv').load('pendingtaskGrid.jsp?userid='+userid);  

    }
    function funpendingUpdate(){                         
    	var docno=$('#txtpendocno').val();    
    	var crtuser=$('#txtcrtuser').val(); 
     	var status=$('#assgntask').val(); 
    	var oldstat= document.getElementById("txtoldstatus").value;  
      	var asgnuser=$('#hiduser2').val();    
      	var oldassuser=document.getElementById("txtasgnuser").value;   
    	var userid=$('#hiduser2').val();              
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{ 
				var items=x.responseText.trim();
				if(items>0){
					document.getElementById("txtcrtuser").value="";  
					document.getElementById("hiduser2").value="";
					document.getElementById("txtpendocno").value="";  
					document.getElementById("jqxInputUser").value=""; 
					 $('#remarks').val('');
					swal({
						type: 'success',
						title: 'Message',
						text: 'Status Updated'
					});
					funGetCountData();
				}else if(items==-888){  
					swal({
						type: 'error',
						title: 'Warning',
						text: 'Task is not completed'  
					});
				}else{ 
					swal({
						type: 'error',
						title: 'Warning',
						text: 'Not Updated'                               
					});
				}
				funClearInfo();	

			}else
			{
			}    
		}
		x.open("GET","penStatUpdate.jsp?userid="+userid+"&docno="+docno+"&status="+status+"&asgnuser="+asgnuser+"&oldassuser="+oldassuser+"&oldstatus="+oldstat+"&crtuser="+crtuser+"&remarks="+$('#remarks').val(),true);           
		x.send();
    }
    function funSave()   
    {
    	var reftype=document.getElementById("reftype").value;
    	var refno=document.getElementById("refno").value;
    	var sdate=$('#date').jqxDateTimeInput('val');
    	var stime=document.getElementById("vtime").value;
    	var user=document.getElementById("jqxInputUsers").value;
    	var hiduser=document.getElementById("hiduser").value;
    	var desc=document.getElementById("desc").value;
    	var userid="<%= session.getAttribute("USERID").toString() %>";     
    	if(refno=="")
    	{
    		$.messager.alert('Message','Enter Ref. No.','warning');   
    		 document.getElementById('refno').focus();
			 return 0;
    	}
    	if(stime=="")   
    	{
    		$.messager.alert('Message','Enter time','warning');   
   		    document.getElementById('stime').focus();
			 return 0;
    	}
    	if(user=="")
    	{
    		$.messager.alert('Message','Enter Assigned User','warning');   
   		    document.getElementById('user').focus();
			 return 0;
    	}
    	if(desc=="")
    	{
    		$.messager.alert('Message','Enter Description','warning');   
   		    document.getElementById('desc').focus();
			 return 0;
    	}

    	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		    	     saveDatasss(reftype,refno,sdate,stime,user,desc,userid,hiduser);       
		     	}  
		 });      
    	
    }    
    function saveDatasss(reftype,refno,sdate,stime,user,desc,userid,hiduser){
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function()
    			{
    				if(x.readyState==4 && x.status==200)
    				{
    					var msg=x.responseText.trim().split(',');
    					// alert(msg);
    					if(msg=="1"){ 
    			              	document.getElementById("refno").value="";
    			              	document.getElementById("vtime").value="";
    			              	document.getElementById("jqxInputUsers").value=""; 
    			              	document.getElementById("hiduser").value="";
    			              	document.getElementById("desc").value="";   
    			            	  swal({   
    									type: 'success',
    									title: 'Message',
    									text: 'Successfully Saved'      
    								});
    			               
    			              } else{
    		            	swal({
    							type: 'error',
    							title: 'Message',  
    							text: 'Not Saved'              
    						});    
    		            }
    					funClearInfo();	

    				}         
    			}
    			x.open("GET","taskCreate.jsp?reftype="+reftype+"&refno="+refno+"&sdate="+sdate+"&stime="+stime+"&user="+user+"&desc="+desc+"&userid="+userid+"&hiduser="+hiduser,true);
    			x.send();
    }  
    
    function fundispatchUpdate(){     
    	var status=$('#cmbstatus').val(); 
    	var docno=$('#dispatchdocno').val();    
    	var crtuser=$('#dispatchcrtuser').val(); 
     	//var status=$('#dispatchtask').val(); 
    	var oldstat= document.getElementById("dispatcholdstatus").value;  
      	var asgnuser=$('#hiduserdis').val();    
      	var oldassuser=document.getElementById("dispatchasgnuser").value;   
    	var userid=$('#hiduserdis').val();              
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{ 
				var items=x.responseText.trim();
				if(items>0){
					document.getElementById("dispatchcrtuser").value="";  
					document.getElementById("hiduserdis").value="";
					document.getElementById("dispatchdocno").value="";  
					document.getElementById("jqxInputUserdis").value=""; 
					document.getElementById("remarks").value=""; 
					 $('#remarks').val('');
					 $('#disfollowupGrid').jqxGrid('clear');
					swal({
						type: 'success',
						title: 'Message',
						text: 'Status Updated'
					});
					funGetCountData();
				}else if(items==-888){  
					swal({
						type: 'error',
						title: 'Warning',
						text: 'Dispatch is not completed'  
					});
				}else{ 
					swal({
						type: 'error',
						title: 'Warning',
						text: 'Not Updated'                               
					});
				} 
				funClearInfo();	

			}else
			{
			}    
		}
		x.open("GET","dispatchStatUpdate.jsp?userid="+userid+"&docno="+docno+"&status="+status+"&asgnuser="+asgnuser+"&oldassuser="+oldassuser+"&oldstatus="+oldstat+"&crtuser="+crtuser+"&remarks="+$('#remarks').val(),true);           
		x.send();
    }
    function funSaveData()   
    {
//     	var docno=document.getElementById("docno").value;
    	var sdate=$('#sdate').jqxDateTimeInput('val');
    	var stime=document.getElementById("stime").value;
    	var asuser=document.getElementById("jqxInputUserss").value;
    	var ashiduser=document.getElementById("hiduser").value;
    	var client=document.getElementById("jqxInputClient").value;
    	var hidclient=document.getElementById("hidcldocno").value;
    	var contact=document.getElementById("contact").value;
    	var location=document.getElementById("location").value;
    	var collect=document.getElementById("collect").value;
    	var dispatch=document.getElementById("dispatch").value;
    	var msg=document.getElementById("msg").value;
    	var address=document.getElementById("address").value;
    	var userid="<%= session.getAttribute("USERID").toString() %>"; 
    	
    	if(stime=="")   
    	{
    		$.messager.alert('Message','Enter time','warning');   
   		    document.getElementById('stime').focus();
			 return 0;
    	}
    	if(dispatch=="" &&  collect=="")
    	{
    		$.messager.alert('Message','Enter Dispatch or collect details','warning');   
   		    document.getElementById('dispatch').focus();
			 return 0;
    	}
    	
    	if(address=="")
    	{
    		$.messager.alert('Message','Enter Address','warning');   
   		    document.getElementById('address').focus();
			 return 0;
    	}
    	if(location=="")
    	{
    		$.messager.alert('Message','Enter Location','warning');   
   		    document.getElementById('location').focus();
			 return 0;
    	}
    	if(msg=="")
    	{
    		$.messager.alert('Message','Enter Message','warning');   
   		    document.getElementById('msg').focus();
			 return 0;
    	}

    	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		    	     savData(sdate,stime,asuser,ashiduser,client,hidclient,address,location,contact,dispatch,collect,msg,userid,hiduser);       
		     	}  
		 });      
    	
    }    
    function savData(sdate,stime,asuser,ashiduser,client,hidclient,address,location,contact,dispatch,collect,msg,userid,hiduser){
    	
    	var cltype="";
    	var cltypeid=document.getElementById("hidclient").checked;
    	 //alert(cltypeid); 
    	if(cltypeid==true){
    		cltype="CRM";
    		
    	}else{
    		cltype="VND";
    	}
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function()
    			{
    				if(x.readyState==4 && x.status==200)
    				{
    					var msg=x.responseText.trim().split(',');
    					// alert(msg);
    					if(msg=="1"){ 
    			              	/* document.getElementById("jqxInputClient").value="";
    			              	document.getElementById("jqxInputVendor").value="";
    			              	document.getElementById("jqxInputUserss").value=""; 
    			            	document.getElementById("hiduser").value="";
    			              	document.getElementById("hidcldocno").value="";
    			              	document.getElementById("location").value="";  
    			            	document.getElementById("address").value="";
    			            	document.getElementById("contact").value="";
    			            	document.getElementById("dispatch").value="";
    			            	document.getElementById("collect").value="";
    			            	document.getElementById("msg").value=""; */
    			            	  swal({   
    									type: 'success',
    									title: 'Message',
    									text: 'Successfully Saved'      
    								});
    			            	  funGetCountData();
    							  $('#modalstatupdation').modal('toggle');      
    			              } else{
    		            	swal({
    							type: 'error',
    							title: 'Message',  
    							text: 'Not Saved'              
    						});    
    		            }
    					funClearInfo();	

    				}         
    			}
//docno,sdate,stime,asuser,ashiduser,client,hidclient,location,contact,dispatch,collect,msg,userid,hiduser
    			x.open("GET","dispatchCreate.jsp?sdate="+sdate+"&stime="+stime+"&asuser="+asuser+"&ashiduser="+ashiduser+"&client="+client+"&hidclient="+hidclient+"&address="+address+"&location="+location+"&contact="+contact+"&dispatch="+dispatch+"&collect="+collect+"&msg="+msg+"&userid="+userid+"&hiduser="+hiduser+"&cltype="+cltype,true);
    			x.send();
    } 
    
	 function funAttachs(event){                         
			var brchid="<%= session.getAttribute("BRANCHID").toString() %>"; 
			 if(document.getElementById("radiodet").checked){

			var docno=$('#dispatchdocno').val(); 
			 }
			 else
				 {
				 var docno=$('#hiddoc_no').val();
				 
				 }
			// alert(docno);
	   		<%-- var enqdocno=document.getElementById("txtenqno").value;              
	 		var qotdocnosss=document.getElementById("txtqotno").value;
	   		var qotdocnos=qotdocnosss.split(','); 
	   		var qotdocno=qotdocnos[0];      
	   		if(qotdocno!="" && qotdocno!="0"){    
	   			var frmdet="SQOT";
	   			var fname="Quotation";
	   		    var  myWindow= window.open("<%=contextPath%>/com/dashboard/management/Attachmaster.jsp?formCode="+frmdet+"&docno="+qotdocno+"&brchid="+brchid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					 myWindow.focus();   
	   		}else if(enqdocno!="" && enqdocno!="0"){             
	   			var frmdet="ENQ"; 
	   			var fname="Enquiry";
	   		    var  myWindow= window.open("<%=contextPath%>/com/dashboard/management/Attachmaster.jsp?formCode="+frmdet+"&docno="+enqdocno+"&brchid="+brchid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					  myWindow.focus(); --%>
					 if(docno==""||docno=="0"){   
							$.messager.alert('Message','Select a Document....!','warning');
							return;
						    }			  
					  
					  
			if(docno!="" || docno!="0"){	
				var frmdet="SINV";
	   			var fname="Dispatch Management";
	   		    var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					 myWindow.focus();
					 docno="";
						
			}               
		   }
	   function funstatusval(crtuserid){     
	    	// var crtuserid=document.getElementById("txtcrtuser").value;  
	    	 var sesuserid= "<%= session.getAttribute("USERID").toString() %>";
	    	var optionref="";  
	    	 if(crtuserid==sesuserid){   
	    		  optionref += '<option value="Assigned">Assign</option>';
	    		  optionref += '<option value="Accepted">Accepted</option>';
	    		  optionref += '<option value="Completed">Completed</option>';
	    		  optionref += '<option value="Close">Close</option>';          
	    	      $("select#assgntask").html(optionref); 
	    	 }else{
	    		 optionref += '<option value="Assigned">Assign</option>';
	   		     optionref += '<option value="Accepted">Accepted</option>';
	   		     optionref += '<option value="Completed">Completed</option>';
	   	         $("select#assgntask").html(optionref);  
	    	 }
	    }
	   function fundisstatusval(crtuserid){     
	    	// var crtuserid=document.getElementById("txtcrtuser").value;  
	    	 var sesuserid= "<%= session.getAttribute("USERID").toString() %>";
	    	var optionref="";  
	    	 if(crtuserid==sesuserid){   
	    		  optionref += '<option value="Document Received">Document Received</option>';
	    		  optionref += '<option value="Under Delivery">Under Delivery</option>';
	    		  optionref += '<option value="Complete">Complete</option>';
	    	      $("select#dispatchtask").html(optionref); 
	    	 }else{
	    		 optionref += '<option value="Document Received">Document Received</option>';
	   		     optionref += '<option value="Under Delivery">Under Delivery</option>';
	   		     optionref += '<option value="Complete">Complete</option>';
	   	         $("select#dispatchtask").html(optionref);  
	    	 }
	    }
	   
	   
	   function introcheck(){
			 if(document.getElementById("chkval1").checked){  
				 document.getElementById("hidchkval1").value = 1;
				 $("#collect").attr('disabled', false );
			 }
			 else{
				 document.getElementById("hidchkval1").value = 0;
				 $("#collect").attr('disabled', true );
			 }
		 }
	   
	   function intro1check(){
			 if(document.getElementById("chkval").checked){  
				 document.getElementById("hidchkval").value = 1;
				 $("#dispatch").attr('disabled', false );
			 }
			 else{
				 document.getElementById("hidchkval").value = 0;
				 $("#dispatch").attr('disabled', true );
			 }
		 }
	   
		 function confrmstatus(){  
			    statusid=$('#statusid').val();   
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();	
						if(parseInt(items)>0 && statusid==19)       
							{  
							 $("#btnconfirm").attr('disabled', false );  
							}
						else
							{
							 $("#btnconfirm").attr('disabled', true );    
							}
					} else {  
					}  
				}
				x.open("GET", "getEditStat.jsp?cnttrno="+$('#cnttrno').val(), true);   
				x.send();
			}
		 function funupdatecn(){   
			 $.messager.confirm('Message', 'Do you want to confirm?', function(r){  
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }  
			     	else {
			     		updatConfrm();            
			     	}  
			 });  
		 }
		 function updatConfrm(){  
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items=x.responseText.trim();
						//alert(items);       
						if(parseInt(items)>0){  
						swal({
								type: 'success',
								title: 'Message',
								text: 'Successfully Confirmed'
							});   
						}else{ 
							swal({
								type: 'error',
								title: 'Warning',
								text: 'Not Confirmed'                                   
							});
						} 
					} else {  
					}   
				}
				x.open("GET", "SaveCofrm.jsp?cnttrno="+$('#cnttrno').val(), true);   
				x.send();
			}  
		 function loads(){      
	    	   
	    	    //$('#Undwtrdiv').load('UndwtrGrid.jsp?check=1');
	    	     var userid= '<%=session.getAttribute("USERID")%>';  
	    	     $("#overlay, #PleaseWait").show();
	    	     var rad= document.getElementById("hidid").value; 
	    	     var fromdate= $("#fromdate").val();
	    		    var todate= $("#todate").val();

		    	   if (rad==1|| rad=="")
		    		  {
		   		    $('#summarydiv').load('summarygrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');
		    		  }
		    	  else 
		    		  {
			    	    $('#disdiv').load('dispatchGrid.jsp?userid='+userid+'&fromdate='+fromdate+'&todate='+todate+'&check=1'); 

		    		  }
		    	   }	
  </script>
</body>
</html>
