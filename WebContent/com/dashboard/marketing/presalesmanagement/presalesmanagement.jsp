<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Pre Sales Management</title>     
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
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="enqschdiv">    
                <div class="card-container">
                    <div class="card-body text-center">
                        <div class="card-chart-container">
                            <div id="enqsch"></div>
                            <span><img src="icons/icons8-collaboration-30.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Enquiry for schedule</span><br/>        
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="schenqdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">   
                            <div id="schenq"></div>
                            <span><img src="icons/icons8-schedule-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                             <span>Scheduled Enquiry</span><br/>
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="surdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="sur"></div>
                            <span><img src="icons/icons8-survey-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Surveyed</span><br/>
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>	
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="estdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="est"></div>
                            <span><img src="icons/icons8-ledger-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Estimated</span><br/>
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>	
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="quotdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="quot"></div>
                            <span><img src="icons/icons8-paycheque-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Quoted</span><br/>
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>	  
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="totalenqdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">   
                            <div id="totalenq"></div>
                            <span><img src="icons/icons8-inspection-16.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Total Enquiry</span><br/>
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
               <select class="cmbbranch form-control input-sm" id="cmbbranch" name="cmbbranch" onchange="getInitChartData();loads();" value='<s:property value="cmbbranch"/>' style="width:140px;">
  					<option></option>     
				</select>
        </div>          
        <div class="primarypanel custompanel">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
        <div class="actionpanel custompanel">                                                               
          <button type="button" class="btn btn-default" id="btnsurveymark" data-toggle="tooltip"  title="Surveyed Mark" data-placement="bottom"><i class="fa fa-check-square-o "  aria-hidden="true"></i></button>     
          <button type="button" class="btn btn-default" id="btnsurveyschedule" data-toggle="tooltip"  title="Survey Schedule" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncreatesurvey"  data-toggle="tooltip" title="Create Survey" data-placement="bottom"><i class="fa fa-plus-square "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnestassign"   data-toggle="tooltip" title="Estimator Assign" data-placement="bottom"><i class="fa fa-external-link-square "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncreateestimation"  data-toggle="tooltip" title="Create Estimation" data-placement="bottom" ><i class="fa fa-plus-square "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncreatequote"  data-toggle="tooltip" title="Create Quotation" data-placement="bottom" ><i class="fa fa-plus-square "  aria-hidden="true"></i></button>            
        
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
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="presalesdiv"><jsp:include page="presalesGrid.jsp"></jsp:include></div>     
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
    
    <!-- Survey Schedule Modal-->
    <div id="modalsurveyschedule" class="modal fade" role="dialog">    
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Survey Schedule</h4>                
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">   
	   <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assign Group</div>  
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="assigngroup" onkeydown="return (event.keyCode!=13);"><jsp:include page="servicegrpsearch.jsp"></jsp:include></div>
                     	<input type="hidden" name="hidgroupid" id="hidgroupid"></div>         
        </div>
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Group Member</div>    
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <div id="groupmember" onkeydown="return (event.keyCode!=13);"><jsp:include page="servicegrptoearch.jsp"></jsp:include></div>
                     	 <input type="hidden" id="hidgrpmemberid" name="hidgrpmemberid" value='<s:property value="hidgrpmemberid"/>'>
                         <input type="hidden" id="hidgrpempid" name="hidgrpempid" value='<s:property value="hidgrpempid"/>'> 
                    </div>           
        </div>
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assign Method</div>             
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="assignid" onkeydown="return (event.keyCode!=13);"><jsp:include page="assignmodesearch.jsp"></jsp:include></div>
                     	<input type="hidden" name="hidassignid" id="hidassignid"></div>            
        </div> 
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Planned Date</div>    
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="surveydate" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>  
        </div>  
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Planned Time</div>  
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="surveytime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>        
         </div>
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="surveydesc"></textarea>
					</div>  
        </div>  
            	  
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">  
		          <button type="button" class="btn btn-default" onclick="funSurverySchedule();">SAVE</button>
		            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
		          </div>                 
		        </div>
		      </div>
		  </div>
	</div>  	    
		    
	<!-- Estimation Assign Modal--> 
    <div id="modalestassign" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Estimator Assign</h4>                    
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">   
	    <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assign User</div>    
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="assigngroup" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch.jsp"></jsp:include></div>
                     	<input type="hidden" id="hiduserid" name="hiduserid" value='<s:property value="hiduserid"/>'></div>         
        </div>   
         <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Amount</div>    
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<input style="height:19px;" type="text" name="estamount" id="estamount"> 
					</div>  
         </div>   
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="estdesc"></textarea>
					</div>  
         </div>
            	  
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">   
		          <button type="button" class="btn btn-default" onclick="funestimator();">SAVE</button>
		            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
		          </div>                 
		        </div>
		   </div>  
	</div>
  
  <input type="hidden" name="divname" id="divname">       
  <input type="hidden" name="hidcomments" id="hidcomments">
  <input type="hidden" name="enqdocno" id="enqdocno">    
  <input type="hidden" name="enqvocno" id="enqvocno">   
  <input type="hidden" name="schtrno" id="schtrno">  
  <input type="hidden" name="brhid" id="brhid">    
  
  <input type="hidden" name="surtrno" id="surtrno">   
  <input type="hidden" name="cldocno" id="cldocno">   
  <input type="hidden" name="address" id="address">   
  <input type="hidden" name="client" id="client">   
  
  <input type="hidden" name="pertel" id="pertel"> 
  <input type="hidden" name="per_mob" id="per_mob">   
  <input type="hidden" name="mail1" id="mail1">
  <input type="hidden" name="salname" id="salname"> 
  <input type="hidden" name="salid" id="salid"> 
  <input type="hidden" name="esttrno" id="esttrno"> 
  <input type="hidden" name="txtcpersonid" id="txtcpersonid">   
  <input type="hidden" name="txtcperson" id="txtcperson">
  <input type="hidden" name="txtcpersondet" id="txtcpersondet"> 
  <input type="hidden" name="txtsjobtype" id="txtsjobtype">  
  <input type="hidden" name="txtclienttaxper" id="txtclienttaxper">  
  <input type="hidden" name="contrtype" id="contrtype">                 
  <input type="hidden" name="cpersonmob" id="cpersonmob">           
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
    	getInitChartData(); 
    	inputload();
    	document.getElementById('selecteddiv').innerHTML=" - Enuiry for schedule"; 
    	document.getElementById("divname").value="enqsch"; 
        $('#btnsubmit').click(function(){  
        	clearfields();      
            loads(); 
            getInitChartData(); 
        });       
        $('#btncreatesurvey').click(function(){   
        	var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	createSurvey();
	    	$("#jqxEnquiryGrid").jqxGrid('clear');
        });
        $('#btncreateestimation').click(function(){   
        	var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	createEstimation();  
	    	$("#jqxEnquiryGrid").jqxGrid('clear');
        });
        $('#btncreatequote').click(function(){   
        	var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	createQuote();   
	    	$("#jqxEnquiryGrid").jqxGrid('clear');
        });
        $('#btnsurveymark').click(function(){   
        	var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	funsurveymark(enqno);  
        });
        $('#btnattachs').click(function(){   
        	funAttachs(event);      
        });
        $('#btnestassign').click(function(){    
	        var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	$("#modalestassign").modal('toggle');   
        }); 
        $('#btnsurveyschedule').click(function(){    
	        var enqno=$('#enqdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	$("#modalsurveyschedule").modal('toggle');  
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
        	$("#presalesdiv").excelexportjs({
        		containerid: "presalesdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxEnquiryGrid", 
        		columns: getColumns("jqxEnquiryGrid") , 
        		worksheetName:"Pre Sales Management"
         		});
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
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("enqdocno").value="";  
    	document.getElementById("enqvocno").value="";  
    	document.getElementById("schtrno").value="";  
    	document.getElementById("brhid").value="";  
    	document.getElementById("surtrno").value="";  
    	document.getElementById("cldocno").value="";  
    	document.getElementById("address").value="";  
    	document.getElementById("client").value="";  
    	document.getElementById("pertel").value="";  
    	document.getElementById("per_mob").value="";  
    	document.getElementById("mail1").value="";  
    	document.getElementById("salname").value="";  
    	document.getElementById("salid").value="";  
    	document.getElementById("esttrno").value="";  
    	document.getElementById("txtcpersonid").value="";  
    	document.getElementById("txtcperson").value="";  
    	document.getElementById("txtcpersondet").value="";  
    	document.getElementById("txtsjobtype").value="";  
    	document.getElementById("txtclienttaxper").value=""; 
		document.getElementById("contrtype").value=""; 
		document.getElementById("cpersonmob").value=""; 
		document.getElementById("hidcomments").value="";
    }
    function getInitChartData(){
		  var x=new XMLHttpRequest();
		  x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				var guagedata=JSON.parse(items);           
		        
	          	$("#enqsch").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.enqschcount);
	          	$("#schenq").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.schenqcount);	
	          	$("#sur").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.surcount);
	          	$("#est").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.estcount);
	          	$("#quot").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.quotcount);
	          	$("#totalenq").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.totalcount);     
				
			}
			else{
			}
		}
		x.open("GET","getInitChartData.jsp?brhid="+$("#cmbbranch").val(),true);                          
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&enqno="+enqno,true);
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
		x.open("GET","getComments.jsp?enqno="+enqno,true);
		x.send();
    }
   
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var divname=$("#divname").val();
	    var brhid=$("#cmbbranch").val();
	    $('#presalesdiv').load('presalesGrid.jsp?divname='+divname+'&brhid='+brhid+'&id=1');                         
    }   

	function funAttachs(event){                         
		var brchid="<%= session.getAttribute("BRANCHID").toString() %>";    
   		var docno=document.getElementById("enqvocno").value; 
   		var url=document.URL;
		var reurl=url.split("com/");
 		if(docno!="" && docno!="0"){                
   			var frmdet="ENQ"; 
   			var fname="Enquiry";
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
			  if(realid=="enqsch" || realid=="schenq" || realid=="est" || realid=="sur" || realid=="totalenq" || realid=="quot"){ 
				  clearfields();      
				  var widgetid="enquirylist"; 
				  document.getElementById("divname").value=realid;       
				  loads();            
			  }
			  if(realid=="enqsch"){ 
				  document.getElementById('selecteddiv').innerHTML=" - Enuiry for schedule";
				  document.getElementById("btnsurveymark").disabled = false;
				  document.getElementById("btnsurveyschedule").disabled = false;
				  document.getElementById("btncreatesurvey").disabled = false;  
				  
				  document.getElementById("btnestassign").disabled = false;
				  document.getElementById("btncreateestimation").disabled = false;  
			  }else if(realid=="schenq"){
				  document.getElementById('selecteddiv').innerHTML=" - Scheduled Enquiry";  
				  document.getElementById("btnsurveymark").disabled = false;
				  document.getElementById("btnsurveyschedule").disabled = false;
				  document.getElementById("btncreatesurvey").disabled = false; 
				  
				  document.getElementById("btnestassign").disabled = false;
				  document.getElementById("btncreateestimation").disabled = false; 
			  }else if(realid=="sur"){
				  document.getElementById('selecteddiv').innerHTML=" - Surveyed";
				  document.getElementById("btnsurveymark").disabled = true;
				  document.getElementById("btnsurveyschedule").disabled = true;
				  document.getElementById("btncreatesurvey").disabled = true; 
				  
				  document.getElementById("btnestassign").disabled = false;
				  document.getElementById("btncreateestimation").disabled = false; 
			  }else if(realid=="est"){
				  document.getElementById('selecteddiv').innerHTML=" - Estimated";
				  document.getElementById("btnsurveymark").disabled = true;
				  document.getElementById("btnsurveyschedule").disabled = true;
				  document.getElementById("btncreatesurvey").disabled = true; 
				  
				  document.getElementById("btnestassign").disabled = true;
				  document.getElementById("btncreateestimation").disabled = true; 
			  }else if(realid=="totalenq"){
				  document.getElementById('selecteddiv').innerHTML=" - Total Enquiry";
				  document.getElementById("btnsurveymark").disabled = true;
				  document.getElementById("btnsurveyschedule").disabled = true;
				  document.getElementById("btncreatesurvey").disabled = true; 
				  
				  document.getElementById("btnestassign").disabled = true;
				  document.getElementById("btncreateestimation").disabled = true; 
			  }else if(realid=="quot"){
				  document.getElementById('selecteddiv').innerHTML=" - Quoted";
				  document.getElementById("btnsurveymark").disabled = true;
				  document.getElementById("btnsurveyschedule").disabled = true;
				  document.getElementById("btncreatesurvey").disabled = true; 
				  
				  document.getElementById("btnestassign").disabled = true;
				  document.getElementById("btncreateestimation").disabled = true;   
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
	 function funsurveymark(enqno){   
		 $.messager.confirm('Message', 'Do you want to mark as surveyed?', function(r){  
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		     		surveymark(enqno);             
		     	}  
		 });  
	 }
	function surveymark(enqno){    
	        var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	if(parseInt(items)>0){  
						   swal({
								type: 'success',
								title: 'Success',
								text: 'Updated Successfully'    
							});
						  }
				 	else{
					 		swal({
								type: 'error',
								title: 'Error',
								text: 'Not Updated'     
							});  
				 	 }
					}
			       else
				  {}
		     }
		      x.open("GET","savemarksurvey.jsp?docno="+enqno,true);      
		     x.send();
	}
	
	function funSurverySchedule(){
		 var brhid=document.getElementById("brhid").value;
		 var schtrno=document.getElementById("schtrno").value;  
		 var enqno=document.getElementById("enqdocno").value;
		 var groupid=document.getElementById("hidgroupid").value;
	     var grpmemberid=document.getElementById("hidgrpmemberid").value;
	     var grpempid=document.getElementById("hidgrpempid").value;
	     var assignid=document.getElementById("hidassignid").value; 
         var surveydate=document.getElementById("surveydate").value;  
         var surveytime=document.getElementById("surveytime").value;  
         var surveydesc=document.getElementById("surveydesc").value;  
         
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
	     
		 $.messager.confirm('Message', 'Do you want to schedule survey?', function(r){    
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		     		surverySchedule(groupid,grpmemberid,grpempid,assignid,surveydate,surveytime,surveydesc,enqno,schtrno,brhid);                 
		     	}  
		 });  
	 }
	function surverySchedule(groupid,grpmemberid,grpempid,assignid,surveydate,surveytime,surveydesc,enqno,schtrno,brhid){            
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
				         document.getElementById("surveydesc").value="";
				         document.getElementById("jqxgrptosearch").value="";  
				         document.getElementById("jqxgrpsearch").value="";  
				         document.getElementById("jqxassignsearch").value="";
				         $("#surveydate").val(new Date());  
				         $("#surveytime").val(new Date());
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
	      x.open("GET","savesurveyschedule.jsp?docno="+enqno+"&schtrno="+schtrno+"&brhid="+brhid+"&groupid="+groupid+"&grpmemberid="+grpmemberid+"&grpempid="+grpempid+"&assignid="+assignid+"&desc="+surveydesc+"&pdate="+surveydate+"&ptime="+surveytime,true);        
	     x.send();
    }
	
	function funestimator(){
		var reftrno=document.getElementById("enqdocno").value;  
	    var brhid1=document.getElementById("brhid").value;
	    var refdtype="ENQ";
	    var userid=document.getElementById("hiduserid").value; 
	    var amount=document.getElementById("estamount").value;
	    var remark=document.getElementById("estdesc").value;  
        
        if(userid== ""){
        	swal({
				type: 'warning',
				title: 'Warning',
				text: 'select a user'                                       
			});
    	    return 0;
    	 }
		 $.messager.confirm('Message', 'Do you want to assign estimator?', function(r){      
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		     		saveesimator(reftrno,brhid1,refdtype,userid,amount,remark);                 
		     	}  
		 });
	}
	
	function saveesimator(reftrno,brhid1,refdtype,userid,amount,remark){   
		    var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				var items= x.responseText;
			 	if(parseInt(items)>0){  
				 		swal({
							type: 'success',
							title: 'Success',
							text: 'Updated Successfully'    
						});
						    document.getElementById("hiduserid").value="";  
						    document.getElementById("estamount").value="";  
						    document.getElementById("estdesc").value="";  
						    document.getElementById("jqxusersearch").value=""; 
					}else{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Updated'       
						});
				 	}
					}
			       else
				  {}
		     }        
		      x.open("GET","saveestassign.jsp?reftrno="+reftrno+"&brhid1="+brhid1+"&refdtype="+refdtype+"&userid="+userid+"&remark="+remark+"&amount="+amount,true);
		     x.send();
		   } 
	function createSurvey(){
		var client=document.getElementById("client").value;
		var cldocno=document.getElementById("cldocno").value;
		var ref_type="ENQ";  
		var refdocno=document.getElementById("enqvocno").value;
		var reftrno=document.getElementById("enqdocno").value;
		var address=document.getElementById("address").value;
		var pertel=document.getElementById("pertel").value;
		var per_mob=document.getElementById("per_mob").value;
		var mail1=document.getElementById("mail1").value;
		var cpersonid=document.getElementById("txtcpersonid").value;
		var cperson=document.getElementById("txtcperson").value;
		var cpersondet=document.getElementById("cpersonmob").value;
		var clientdet=address+", "+per_mob+", "+mail1;  
	
		var path1="/com/project/execution/surveyDetails/surveydet.jsp";  
		var name="Survey Details";
			 var url=document.URL;
			var reurl=url.split("com/");

		window.parent.branchid.value=$('#brhid').val(); 
		window.parent.formName.value="Survey Details";
		window.parent.formCode.value="SUR";
		  var detName="Survey Details";
		  var mode="A";
		  var path= path1+"?mod="+mode+"&client="+encodeURIComponent(client)+"&cldocno="+cldocno+"&ref_type="+ref_type
		  +"&refdocno="+refdocno+"&reftrno="+reftrno+"&clientdet="+encodeURIComponent(clientdet)+"&cpersonid="+cpersonid+"&cperson="+encodeURIComponent(cperson)  
		  +"&cpersondet="+encodeURIComponent(cpersondet);   
		 
		   top.addTab( detName,reurl[0]+""+path);
	}
	function createEstimation(){
		var client=document.getElementById("client").value;
		var cldocno=document.getElementById("cldocno").value;
		var ref_type="ENQ";
		var refdocno=document.getElementById("enqvocno").value;    
		var reftrno=document.getElementById("enqdocno").value;
		var address=document.getElementById("address").value; 
		var surtrno=document.getElementById("surtrno").value; 
		var path1="/com/project/execution/estimationnew/estimation.jsp";
		var name="Estimation";
		var url=document.URL;
		var reurl=url.split("com/");

		window.parent.branchid.value=$('#brhid').val();      
		window.parent.formName.value="Estimation";
		window.parent.formCode.value="JEST";
		var detName="Estimation";
		var mode="A";
		var path= path1+"?mod="+mode+"&client="+encodeURIComponent(client)+"&cldocno="+cldocno+"&ref_type="+ref_type   
		  +"&refdocno="+refdocno+"&reftrno="+reftrno+"&address="+encodeURIComponent(address)+"&surtrno="+surtrno;
		 
		 top.addTab( detName,reurl[0]+""+path);  
	}
	function createQuote(){
		var client=document.getElementById("client").value;
		var cldocno=document.getElementById("cldocno").value;
		var ref_type="ENQ";  
		var refdocno=document.getElementById("enqvocno").value;
		var reftrno=document.getElementById("enqdocno").value;
		var address=document.getElementById("address").value;
		
		var pertel=document.getElementById("pertel").value;
		var per_mob=document.getElementById("per_mob").value;
		var mail1=document.getElementById("mail1").value;
		var salname=document.getElementById("salname").value;
		var salid=document.getElementById("salid").value;
		var contrtype=document.getElementById("contrtype").value;
		
		var surtrno=document.getElementById("surtrno").value;
		var esttrno=document.getElementById("esttrno").value;
		var cpersonid=document.getElementById("txtcpersonid").value;
		var cperson=document.getElementById("txtcperson").value;
		var cpersondet=document.getElementById("txtcpersondet").value;
		var sjobtype=document.getElementById("txtsjobtype").value;
		var clienttaxper=document.getElementById("txtclienttaxper").value;
		 
		 var path1="/com/project/execution/quotationnew/quotation.jsp";
	     var name="Quotation";
		 var url=document.URL;
		 var reurl=url.split("com/");

		 window.parent.branchid.value=$('#brhid').val();    
		 window.parent.formName.value="Quotation";
		 window.parent.formCode.value="SQOT";
		 var detName="Quotation";
		 var mode="A";
		 
		 console.log(mail1+"="+salname+"="+cperson+"="+address+"="+cpersondet+"="+client); 
		 
			var path= path1+"?mod="+mode+"&cldocno="+cldocno+"&ref_type="+ref_type+"&sjobtype="+sjobtype+"&salid="+salid+"&contrtype="+contrtype+"&surtrno="+surtrno+"&esttrno="+esttrno+"&cpersonid="+cpersonid
				  +"&refdocno="+refdocno+"&reftrno="+reftrno+"&pertel="+pertel+"&per_mob="+per_mob+"&clienttaxper="+clienttaxper
				  +"&mail1="+encodeURIComponent(mail1)+"&salname="+encodeURIComponent(salname)+"&cperson="+encodeURIComponent(cperson)+"&address="+encodeURIComponent(address) 
				  +"&cpersondet="+encodeURIComponent(cpersondet)+"&client="+encodeURIComponent(client); 
		 
				  top.addTab( detName,reurl[0]+""+path);   
	}
  </script>
</body>
</html>
