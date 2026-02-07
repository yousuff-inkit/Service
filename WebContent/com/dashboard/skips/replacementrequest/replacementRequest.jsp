<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Book a Call</title>           
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
  		width:250px;            
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
<body>   
	<form id="frmReplacementRequest" action="saveReplacementRequest" method="post" autocomplete="off">  
  		<div class="container-fluid">  
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
					          <td align="right"><label  style="font-size: 13px">&nbsp;Client&nbsp;&nbsp;</label></td>       
					          <td align="left"><select class="form-control select2" name="cmbrefname" id="cmbrefname" style="width:100px;" onchange="loads();"></select></td> 
					      </tr>                                            
					 </table>          
			       </div>  
      				<div class="primarypanel custompanel1">
            			<!-- <button type="button" class="btn btn-default" id="btnfilter"  data-toggle="tooltip" title="Filter" data-placement="bottom"><i class="fa fa-filter" aria-hidden="true"></i></button>               -->
  						<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
          				<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			</div> 
        			<div class="actionpanel custompanel1">                                          
			              <button type="button" class="btn btn-default" id="btnschedule" data-toggle="tooltip" title="Book a Call" data-placement="bottom"><i class="fa fa-calendar-check-o "  aria-hidden="true"></i></button>        
			              <button type="button" class="btn btn-default" id="btnreplacementrequest" data-toggle="tooltip" title="Replacement Request" data-placement="bottom"><i class="fa fa-exchange "  aria-hidden="true"></i></button>        
			              <button type="button" class="btn btn-default" id="btncancel" data-toggle="tooltip" title="cancel" data-placement="bottom"><i class="fa fa-ban"  aria-hidden="true"></i></button>        
			        </div>
        		 	<div class="textpanel custompanel">     
						<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>                            
        			</div>    
     		 	</div>
   			</div>
   			<div class="row">               
      			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
        			<div id="serschdiv"><jsp:include page="replacementRequestGrid.jsp"></jsp:include></div>          
      			</div>
    		</div>
    		<div id="modalschedule" class="modal fade" role="dialog">  
    			<div class="modal-dialog modal-lg">  
        			<div class="modal-content">
          				<div class="modal-header">
            				<button type="button" class="close" data-dismiss="modal">&times;</button>   
            				<h4 class="modal-title">Book a Call<span></span></h4>  <label for="otherdetails4" id="lblotherdetails4"></label>   
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
          					<!-- <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="Route">Contract:</label>   
		        					<input type="text" id="txtcontract" name="txtcontract" class="form-control input-sm" placeholder="press F3 to search" readonly  onKeyDown="getContract();">  
		        					<input type="hidden" name="hidcnttrno" id="hidcnttrno"> 
		        					<input type="hidden" name="hidcntsrno" id="hidcntsrno">        
	                    		</div>  
		             		</div>  -->  
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
		                  	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="restriction" id="restrictionmsg" style="color:red;text-align:right"></label>   
		        					<input type="hidden" name="hidrestrict" id="hidrestrict">    
	                     		</div>  
		                  	</div>
		          		</div> 
          			    <div class="row">
          			    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="Contract">Job No:</label>   
		        					<div id="contractno" onkeydown="return (event.keyCode!=13);"><jsp:include page="contractSearch.jsp"></jsp:include></div>
		        					<input type="hidden" name="hidcnttrno" id="hidcnttrno"> 
		        					<input type="hidden" name="hidcntsrno" id="hidcntsrno">         
	                    		</div>  
		             		</div> 
          			      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="Client">Client:</label>   
		        					<div id="client" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearch.jsp"></jsp:include></div>
		        					<input type="hidden" name="hidcldocno" id="hidcldocno">         
	                    		</div>  
		             		</div>
          			       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="Site">Site:</label>   
		        					<div id="site" onkeydown="return (event.keyCode!=13);"><jsp:include page="siteSearch.jsp"></jsp:include></div>
		        					<input type="hidden" name="hidsiteid" id="hidsiteid">         
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
		        					<label for="Skip Type2">Skip Type:</label>            
		        					<div id="skiptypesc" onkeydown="return (event.keyCode!=13);"><jsp:include page="skiptypeSearch.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="scskipid" name="scskipid">                   
	                     	    </div>  
		                   </div>
		                  <%--  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="slno">Delivery</label>                   
		        					<select class="form-control select2" id="cmbslno" style="width:100%;" name="cmbslno" onchange="getDetails();"></select>                
	                     	    </div>  
		                   </div> --%>
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
		        					<label for="Cont.Qty">Cont. Qty :</label>        
		        					<input type="text" id="txtcontqty" name="txtcontqty" class="form-control input-sm" style="height:27px" readonly >           
	                     		</div>  
		                	</div>
		                	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="Location">Qty:</label>           
		        					<input type="text" id="txtqty" name="txtqty" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Qty" onchange="funchangeqty();">                
	                     		</div>  
		                	 </div>
		                	<!-- <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="Email">Email:</label>        
		        					<input type="text" id="txtemail" name="txtemail" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Email ID">           
	                     		</div>  
		                	</div> -->
          			    	<!-- <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="Location">Location:</label>           
		        					<input type="text" id="txtlocation" name="txtlocation" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Location">                
	                     		</div>  
		                	 </div>  -->
          				</div> 
          				<div class="row">
          				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">   
		        				<div class="form-group">
		        					<label for="Location">Remarks:</label>           
		        					<input type="text" id="txtremarks" name="txtremarks" class="form-control input-sm" style="height:27px" placeHolder="Please Enter Remarks">                
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
    		<!--  Replacement Request modal -->
    		<div id="modalreplacementrequest" class="modal fade" role="dialog">  
    			<div class="modal-dialog modal-lg">
        			<div class="modal-content">
          				<div class="modal-header">
            				<button type="button" class="close" data-dismiss="modal">&times;</button>   
            				<h4 class="modal-title">Replacement Request<span></span></h4>  <label for="otherdetails6" id="lblotherdetails6"></label>    
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
     		</div>  --%>
     		<div id="modalcancel" class="modal fade" role="dialog">
    			<div class="modal-dialog">
        			<div class="modal-content">
          				<div class="modal-header">
            				<button type="button" class="close" data-dismiss="modal">&times;</button>
            				<h4 class="modal-title">Cancel<span></span></h4>  
            				<label for="otherdetails1" id="lblotherdetails1"></label>      
          				</div>
          				<div class="modal-body">
  							<div class="row" id="delown">  
  					      		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        					<div class="form-group">
		        						<label for="cdate">Date:</label>     
		        						<div id="cdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    	</div>  
		                   		</div>
		                   		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        					<div class="form-group">
		        						<label for="ctime">Time:</label>     
		        						<div id="ctime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    	</div>  
		                  		</div>
		                  		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        					<div class="form-group">
		        						<label for="cremarks">Remarks:</label>   
		        						<input type="text" id="cremarks" name="cremarks" class="form-control input-sm">     
	                     	    	</div>  
		                   		</div>  
            				</div>
          				</div>
          				<div class="modal-footer">
          					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          					<button type="button" class="btn btn-default btn-primary" id="btncancelsave">Save Changes</button>  
          				</div>
        			</div>
      			</div>
   			 </div>
    		<input type="hidden" name="hidcomments" id="hidcomments">   
      		<input type="hidden" name="lblname" id="lblname">
      		<input type="hidden" name="hiddocno" id="hiddocno">   
	  		<input type="hidden" name="hidcontrno" id="hidcontrno">      
	  		<input type="hidden" name="hidbrhid" id="hidbrhid">
	  		<input type="hidden" name="hidroute" id="hidroute"> 
      		<input type="hidden" name="hidsrno" id="hidsrno"> 
      		<input type="hidden" name="hiddelid" id="hiddelid">     
      		<input type="hidden" name="hidskipid" id="hidskipid">
      		<input type="hidden" name="hidskipstatus" id="hidskipstatus">
      		
      		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
			<script src="../../../../js/sweetalert2.all.min.js"></script>  
			<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
			<script type="text/javascript">
			 	$(document).ready(function(){
			 		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
			        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
			    	$('[data-toggle="tooltip"]').tooltip();
			    	$('#contractWindow').jqxWindow({ width: '65%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			        $('#contractWindow').jqxWindow('close');
			        $("#scdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
				    $("#sctime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false}); 
				    $("#rpdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
				    $("#rptime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
				    $("#fromdate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"});          
				    $("#todate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"}); 
				    $("#cldate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
				    $("#cltime").jqxDateTimeInput({ width: '50px', height: '22px',formatString:"HH:mm",showCalendarButton: false}); 
				    $("#ctime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
				    $("#cdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
				    
				    getRefname();funchangedate();
				    
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
				    
				    $('#btnfilter').click(function(){ 
				    	funchangedate();
				    	$("#modalfilter").modal('toggle');      
			        });
				    
				    $('#btnfilterok').click(function(){
				    	$("#modalfilter").modal('toggle');
				    	loads();     
			        });
				    
				    $('#btnschedule').click(function(){     
				    	clearfields();
				    	$("#modalschedule").modal('toggle');
			        });
				    
				    $('#btncancel').click(function(){     
				    	clearfields();
				    	$("#modalcancel").modal('toggle');
			        });
				    
				    $('#btnschedulesave').click(function(){     
				    	var processid="Schedule on call basis";            
				    	funUpdate(processid);            
			        });
				    
				    
				    $('#btncancelsave').click(function(){     
				    	var processid="Cancel request";            
				    	funUpdate(processid);            
			        });
				    
				    $('#btnreplacementrequest').click(function(){                
				    	clearfields();    
				    	$('#rpskipnodiv').load("skipnoSearchRp.jsp?type="+2);  
				    	$("#modalreplacementrequest").modal('toggle');      
			        });
				    
				    $('#btnreplacementsave').click(function(){        
				    	var processid="Replacement Request";         
				    	funUpdate(processid);                
			        });
				    $('#btnexcel').click(function(){  
			        	$("#serschdiv").excelexportjs({ 
			        		containerid: "serschdiv",       
			        		datatype: 'json', 
			        		dataset: null, 
			        		gridId: "jqxReplacementRequestGrid",     
			        		columns: getColumns("jqxReplacementRequestGrid") ,   
			        		worksheetName:"Book a Call"     
			         	});  
			        });
				    
				    $('.warningpanel div button').click(function(){
			        	$(this).toggleClass('active');
			        	if($(this).hasClass('active')){
			        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
			        	}
			        	else{   
			        		$('#jqxReplacementRequestGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
			        	}
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
				    
			 	});
			 	
			 	function getContractRP(){         
			 	   	 var x= event.keyCode;
			 	   	 if(x==114){
			 		     	  $('#contractWindow').jqxWindow('open');  
			 		     	  contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+3, $('#contractWindow'));      
			 		     }else{}
			 	}
			 	
			 	function loads(){   
				    $("#overlay, #PleaseWait").show();
				    var fromdate=$('#fromdate').jqxDateTimeInput('val');         
				    var todate=$('#todate').jqxDateTimeInput('val');  
				    var routeid = $("#cmbroute").val();    
				    var cldocno = $("#cmbrefname").val();    
				    var frmdtchk = 0;
				    if(document.getElementById('fromdatechk').checked){
				    	frmdtchk = 1;  
				    }else{
				    	frmdtchk = 0; 
				    }
				    $('#serschdiv').load('replacementRequestGrid.jsp?fromdate='+fromdate+"&todate="+todate+"&cldocno="+cldocno+"&frmdtchk="+frmdtchk+'&id=1');             
			    }   
				function clearfields(){  
					$('#hidcnttrno').val('');     
					$('#hidcntsrno').val(''); 
					$('#scdate').val(new Date());   
					$('#sctime').val(new Date());
					$('#cldate').val(new Date());   
					$('#cltime').val(new Date());
					$('#scwasteid').val(''); 
					$('#scskipid').val(''); 
					$('#txtcontract').val('');
					$('#rpdate').val(new Date());
					$('#rptime').val(new Date());
					$('#rpremarks').val('');
					document.getElementById("lblotherdetails4").innerHTML="";
					document.getElementById("lblotherdetails6").innerHTML="";   
					$('#hidrpcntbrhid').val(''); 
					$('#hidrpcntsrno').val(''); 
					$('#hidrpcnttrno').val(''); 
					$('#rpcontract').val(''); 
					$('#txtname').val('');  
					$('#txtmobile').val(''); 
					/* $('#txtemail').val(''); 
					$('#txtlocation').val(''); */
					$('#txtremarks').val('');
					$('#hidsiteid').val('');
					$('#hidcldocno').val('');
					$('#txtqty').val(''); 
					$('#txtcontqty').val(''); 
					document.getElementById("jqxClient").value="";
					document.getElementById("jqxSite").value="";
					document.getElementById("jqxwastetypeSC").value="";
					document.getElementById("jqxcontract").value="";
					document.getElementById("jqxskiptypeSC").value="";
					document.getElementById("restrictionmsg").innerHTML ="";
					$('#hidrestrict').val(''); 
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
					if(processid=="Schedule on call basis"){               	
						var sccnttrno = $('#hidcnttrno').val();     
				    	var sccntsrno = $('#hidcntsrno').val(); 
				    	var scdate = $('#scdate').val();   
				    	var sctime = $('#sctime').val();
				    	var scwasteid = $('#scwasteid').val();
				    	var delsrno = $('#cmbslno').val();
				    	var name = $('#txtname').val();  
				    	var mobno = $('#txtmobile').val(); 
				    	var email = ""; 
				    	var location = ""; 
				    	var cldate = $('#cldate').val();   
				    	var cltime = $('#cltime').val();   
				    	var remarks = $('#txtremarks').val();
				    	var qty = $('#txtqty').val();
				    	var restict = $('#hidrestrict').val();
				    	if(parseInt(restict)==1){        
				    		swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Contract on HOLD'             
							});	
				    		    return false;  
				    	 }
				    	if(parseInt(restict)==2){        
				    		swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Scheduling is restricted'                 
							});	
				    		    return false;  
				    	 }
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
				    	/* if(scskipid==''){  
				    		swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Please select a Skip type'        
							});	
				    		    return false;  
				    	 } */
				    	if(qty==''){  
				    		swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Please enter qty'        
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
				    	/* var emailchk = ValidateEmailAddress(email);
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
				    	} */
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
									saveScheduleCall(processid, sccnttrno, sccntsrno, scdate, sctime, scwasteid, delsrno, name, mobno, email, location, cldate, cltime, remarks,qty);                           
								}else{
								}
						});
					} else if (processid=="Replacement Request"){ 
						var rpcnttrno = $('#hidrpcnttrno').val();     
				    	var rpcntsrno = $('#hidrpcntsrno').val(); 
				    	var rpcntbrhid = $('#hidrpcntbrhid').val();  
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
									saveReplacementRequest(processid, rpdate, rptime, rpcnttrno, rpcntbrhid, rpcntsrno, delsrno, rpremarks);                              
								}else{
								}
						});
					} else if (processid=="Cancel request"){ 
						var rpcnttrno = $('#hidcontrno').val();     
						var docno = $('#hiddocno').val();     
						var skipstatus = $('#hidskipstatus').val();  
						var rpcntbrhid = $('#hidbrhid').val();
						var rpdate= $('#cdate').val();
						var rptime= $('#ctime').val();
						var rpremarks= $('#cremarks').val();  
						var delsrno = $('#hidsrno').val(); 
						if(rpcnttrno=='' && skipstatus!=="Replacement Request"){          
				    		swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Please select a Replacement Request contract'             
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
									cancelReplacementRequest(processid, rpdate, rptime, rpcnttrno, rpcntbrhid, delsrno, rpremarks, docno);                              
								}
						});
					}
				}	
				
				function cancelReplacementRequest(processid, rpdate, rptime, cnttrno, brhid, srno, rpremarks, docno){                          
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
											 $("#modalcancel").modal('toggle');       
									}else{
											 swal.fire({  
												    icon: 'warning',
													title: 'Warning',
													text: 'Not Updated'  
												});  
									}   
							}
					}  
					x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&poremarks="+encodeURIComponent(rpremarks)+"&cnttrno="+cnttrno+"&brhid="+brhid+"&srno="+srno+"&podate="+rpdate+"&potime="+rptime+"&docno="+docno,true);                 
					x.send();                
				}
				
				function saveReplacementRequest(processid, rpdate, rptime, cnttrno, brhid, srno, delsrno, rpremarks){                          
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
											 $("#modalreplacementrequest").modal('toggle');       
									}else{
											 swal.fire({  
												    icon: 'warning',
													title: 'Warning',
													text: 'Not Updated'  
												});  
									}   
							}
					}  
					x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&poremarks="+encodeURIComponent(rpremarks)+"&delsrno="+delsrno+"&cnttrno="+cnttrno+"&brhid="+brhid+"&srno="+srno+"&podate="+rpdate+"&potime="+rptime,true);                 
					x.send();                
				}
				
				function funchangedate(){
					if(document.getElementById('fromdatechk').checked){  
						$("#fromdate").jqxDateTimeInput('disabled',false);     
					}else{
						$("#fromdate").jqxDateTimeInput('disabled',true);
					}
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
								optionsbranch += '<option  value="' + srno[i].trim() +'">'
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
							/* $('#txtemail').val(items[2]); 
							$('#txtlocation').val(items[3]); */
						}
					}
					x.open('GET','getDetails.jsp?slno='+slno+'&contrno='+cnttrno+'&srno='+detsrno) 
					x.send();  
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
			    
			    function saveScheduleCall(processid, sccnttrno, sccntsrno, scdate, sctime, scwasteid, delsrno, name, mobno, email, location, cldate, cltime,  remarks,qty){             
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
					x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&delsrno="+delsrno+"&sccnttrno="+sccnttrno+"&sccntsrno="+sccntsrno+"&podate="+cldate+"&potime="+cltime+"&scdate="+scdate+"&sctime="+sctime+"&scwasteid="+scwasteid+"&name="+encodeURIComponent(name)+"&mobno="+mobno+"&email="+encodeURIComponent(email)+"&location="+encodeURIComponent(location)+"&remarks="+encodeURIComponent(remarks)+"&qty="+qty,true);          
					x.send();                 
				}
			   function funchangeqty(){
				   var qty=$("#txtqty").val();
				   var contqty=$("#txtcontqty").val();
			    	if(parseInt(qty)>parseInt(contqty)){
			    		 swal.fire({  
							    icon: 'warning',
								title: 'Warning',
								text: 'Entered Qty is greater than Contract Qty!'  
							});
			    		//document.getElementById('restrictionmsg').innerHTML='Entered Qty is greater than Contract Qty!'; 
			    		$("#txtqty").val(contqty);
			    	}
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
								optionsbranch += '<option  value="' + srno[i] +'">'
								+ process[i] + '</option>';
								
							}
							$('#cmbrefname').html($.parseHTML(optionsbranch));
				  			$('#cmbrefname').select2({
				  				placeholder:"Please select a Client",         
				  				allowClear:true 
				  			});
						} else {}
					}
					x.open("GET","getRefname.jsp", true);      
					x.send();
				}
			    
			   function getSchDet() {   
					var x = new XMLHttpRequest();
					x.onreadystatechange = function() {
						if (x.readyState == 4 && x.status == 200) {
							var items = x.responseText.split('####'); 
							if(parseInt(items[0])==0){
								  document.getElementById("restrictionmsg").innerHTML = "Maximum allowed schedules "+items[1]; 
								  document.getElementById("hidrestrict").value = 2;
							}
							
						} else {}
					}
					x.open("GET","getSchDet.jsp?schdate="+$("#scdate").val()+"&cnttrno="+$("#hidcnttrno").val(), true);          
					x.send();
				}
			</script>
        </div>
        <div id="contractWindow">
			<div></div><div></div>
		</div>    
	</form>       
</body>
</html>         