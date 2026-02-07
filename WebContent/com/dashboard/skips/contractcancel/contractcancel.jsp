<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Contract Cancel</title>           
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
  		/* height:50px;       */           
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
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
      <%-- <div class="todatepanel custompanel">
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
        </div> --%>            
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
        <div class="actionpanel custompanel1">                                                                 
          <button type="button" class="btn btn-default" id="btncancel" data-toggle="tooltip"  title="Cancel" data-placement="bottom"><i class="fa fa-ban "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnapprove" data-toggle="tooltip"  title="Cancel Approve" data-placement="bottom"><i class="fa fa-thumbs-up "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncontractview"  data-toggle="tooltip" title="View Contract" data-placement="bottom"><i class="fa fa-scribd "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnacstatement" data-toggle="tooltip"  title="Account Statement" data-placement="bottom"><i class="fa fa-print "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnagstatement"  data-toggle="tooltip" title="Ageing Statement" data-placement="bottom"><i class="fa fa-print "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncollection" data-toggle="tooltip"  title="Collection" data-placement="bottom"><i class="fa fa-file-text "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>    
        <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>        
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
		        					<label for="creason">Reason:</label>   
		        					<input type="text" id="creason" name="creason" class="form-control input-sm">     
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
     <div id="modalcollection" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Collection<span></span></h4>  
            		<label for="otherdetails2" id="lblotherdetails2"></label>     
          		</div>
          		<div class="modal-body">
  					<div class="row">  
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="cldate">Date:</label>     
		        					<div id="cldate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="cltime">Time:</label>     
		        					<div id="cltime" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Reason">Status:</label>   
		        					  <select id="cmbstatus" name="cmbstatus" style="width:70%;" class="form-control input-sm">
	  						          <option value="">--Select--</option>
	  						          <option value="1">Completed</option>
	  						          <option value="2">Dropped</option>
	  						          <option value="3">Onshow</option></select>         
	                     	    </div>  
		                   </div> 
		                </div>
		                <div class="row">     
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Reason">Waste Weight:</label>   
		        					<input type="text" id="wasteweight" name="wasteweight" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Reason">Extra Collected Weight:</label>   
		        					<input type="text" id="exweight" name="exweight" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">   
		        				<div class="form-group">
		        					<label for="Reason">Extra Collected Price:</label>    
		        					<input type="text" id="exprice" name="exprice" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
		                  </div>
		                <div class="row"> 
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Reason">Reason:</label>   
		        					<input type="text" id="clreason" name="clreason" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btncollectionsave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
    <input type="hidden" name="hidapprove" id="hidapprove"> 
  <input type="hidden" name="hidacno" id="hidacno">     
  <input type="hidden" name="hidbrhid" id="hidbrhid">  
  <input type="hidden" name="hidrowno" id="hidrowno"> 
  <input type="hidden" name="hidcontrno" id="hidcontrno">
  <input type="hidden" name="hidcondocno" id="hidcondocno">       
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
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();     
	    $("#cdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
        $("#cldate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
    	$("#ctime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
    	$("#cltime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
        $('#ctime').jqxDateTimeInput('setDate', new Date());
        $('#cltime').jqxDateTimeInput('setDate', new Date());     
        $('#btncollection').attr('disabled',true);    
        $('#btnsubmit').click(function(){    
        	clearfields();      
            loads(); 
        });
    	$('#btncontractview').click(function(){    
			 var rowno=$('#hidrowno').val();  
	         if(rowno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         viewContract();                    
		});
        $('#btnacstatement').click(function(){             
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	getARprint();         
        });
        $('#btnagstatement').click(function(){             
        	var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	getAgeingprint();         
        });
        $('#btncancel').click(function(){           
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
	    	$("#modalcancel").modal('toggle');          
        });
        $('#btncollection').click(function(){           
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
	    	$("#modalcollection").modal('toggle');          
        });
        
        $('#btncancelsave').click(function(){          
        	funUpdate(1);    
        });
        $('#btnapprove').click(function(){          
        	funUpdate(2);    
        });
        $('#btncollectionsave').click(function(){          
        	funUpdate(3);    
        });
        $('#btncomment').click(function(){    
	        var enqno=$('#hidcontrno').val();
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
        		worksheetName:"Contract Cancel"  
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
  
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("hidrowno").value=""; 
    	document.getElementById("hidcondocno").value=""; 
    	document.getElementById("hidbrhid").value=""; 
    	document.getElementById("hidcontrno").value="";     
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
	    $('#contractdiv').load('contractGrid.jsp?id=1');         
    }   
	function funUpdate(chkevent){   
		var processid="";
		var rowno = $('#hidrowno').val();
		var brhid= $("#hidbrhid").val();
		var trno = $('#hidcontrno').val(); 
		if(parseInt(chkevent)==1){	
			var date = $('#cdate').val();  
			var time= $('#ctime').val(); 
			var reason= $('#creason').val();
			processid="Cancel"; 
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
				text: "Do you want cancel?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {
						funCancel(processid, trno, rowno, brhid, date, time, reason);      
					}else{
					}
			});
		}else if(parseInt(chkevent)==2){ 	
			processid="Approve";       
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want approve?", 
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {
						funapprove(processid,rowno,brhid);     
					}else{
					}
			});
		}else if(parseInt(chkevent)==3){	
			var date = $('#cldate').val();  
			var time= $('#cltime').val(); 
			var reason= $('#clreason').val();
			var status= $('#cmbstatus').val();
			var wasteweight= $('#wasteweight').val();
			var exweight= $('#exweight').val();
			var exprice= $('#exprice').val();  
			processid="Collection";   
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
				text: "Do you want save changes?", 
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {
						funSaveCollection(processid, trno, rowno, brhid, date, time, reason, status, wasteweight, exweight, exprice);        
					}else{
					}
			});
		}else{}     
	}
	
	function funCancel(processid, trno, rowno, brhid, date, time, reason){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Cancelled'  
									});
								 $('#btnsubmit').trigger('click');
								 $("#modalcancel").modal('toggle');  
						}else{
								 swal.fire({  
									    icon: 'error',
										title: 'Error',
										text: 'Not Cancelled'  
									});
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&trno="+trno+"&reason="+encodeURIComponent(reason)+"&date="+date+"&time="+time,true);          
	x.send();      
	}
	function funapprove(processid,rowno,brhid){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){  	  
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Approved'  
									});
								 $('#btnsubmit').trigger('click');
								 $("#hidapprove").val(1);  
						}else{
								 swal.fire({  
									    icon: 'error',
										title: 'Error',
										text: 'Not Approved'   
									});
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno,true);          
	x.send();      
	}
	function funSaveCollection(processid, trno, rowno, brhid, date, time, reason, status, wasteweight, exweight, exprice){      
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
								 $('#btnsubmit').trigger('click');
								 $("#modalcollection").modal('toggle');    
						}else{
								 swal.fire({  
									    icon: 'error',
										title: 'Error',
										text: 'Not Updated'  
									});
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&rowno="+rowno+"&trno="+trno+"&reason="+encodeURIComponent(reason)+"&date="+date+"&time="+time+"&status="+status+"&wasteweight="+wasteweight+"&exweight="+exweight+"&exprice="+exprice,true);           
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
	function getARprint(){   
            var type="AR";        
			var acno=$("#hidacno").val();   
			if(acno==0){      
				swal({
					type: 'warning',
					title: 'Message',  
					text: 'Account Satatement is not created'              
				});  
			}else{
			var brnach="a";  
			var url=document.URL;     
	        var reurl=url.split("skips");       
	        var netamt=0.00;   
	        var fdate=window.parent.txtaccountperiodfrom.value;
	        fdate=fdate.split("-");    
	        fdate=fdate[0].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+fdate[1].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+fdate[2];   
	        var tdate=new Date();   
            tdate=tdate.getDate().toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+(tdate.getMonth()+1).toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+tdate.getFullYear();  
	        console.log(fdate+" - "+tdate);
            var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();  
			}
    } 
	function getAgeingprint(){    
        var type="AR";        
		var acno=$("#hidacno").val();
		var brhid=$("#hidbrhid").val();
		if(acno==0){      
			swal({
				type: 'warning',
				title: 'Message',  
				text: 'Ageing Satatement is not created'                
			});  
		}else{
			 var level1from = 0;
			 var level1to =30;
			 var level2from = 31;
			 var level2to = 60;
			 var level3from = 61;
			 var level3to = 90;
			 var level4from = 91;
			 var level4to = 120;
			 var level5from = 121;   	 
		var brnach="a";  
		var url=document.URL;     
        var reurl=url.split("skips");       
        var netamt=0.00;   
        var fdate=window.parent.txtaccountperiodfrom.value;
        fdate=fdate.split("-");    
        fdate=fdate[0].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+fdate[1].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+fdate[2];   
        var tdate=new Date();   
        tdate=tdate.getDate().toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+(tdate.getMonth()+1).toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"."+tdate.getFullYear();  
        console.log(fdate+" - "+tdate);
        var win= window.open(reurl[0]+"accounts/ageingstatement/printAgeingOutstandingsStatement?&acno="+acno+'&atype='+type+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+brhid+'&uptoDate='+tdate+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();  
		}  
}
  </script>  
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
