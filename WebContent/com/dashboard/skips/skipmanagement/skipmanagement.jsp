<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Skip Management</title>         
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
  </style>
</head>       
<body onload="getSkips();">  
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
  		<div class="row padtop">
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="notassigneddiv">      
                <div class="card-container">
                    <div class="card-body text-center">
                        <div class="card-chart-container">
                            <div id="notassigned"></div>  
                            <span><img src="icons/icons8-document-30.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Entered</span><br/>         
                             <span class="counter">10</span>    
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="assigneddiv">   
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">   
                            <div id="assigned"></div>
                            <span><img src="icons/icons8-inspection-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                             <span>Inducted</span><br/>
                             <span class="counter">5</span>    
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="workstarteddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="workstarted"></div>
                            <span><img src="icons/icons8-ok-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Available</span><br/>
                             <span class="counter">8</span>  
                        </div>
                    </div>
                </div>
            </div>	
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="pndcnfrddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="pndcnfrd"></div>    
                            <span><img src="icons/icons8-rent-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Rented</span><br/>  
                             <span class="counter">1</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="pndcnfrddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="pndcnfrd"></div>    
                            <span><img src="icons/icons8-ledger-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Sold</span><br/>  
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>	
        </div>  
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
          <button type="button" class="btn btn-default" id="btninduction" data-toggle="tooltip"  title="Induction" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btninspection"  data-toggle="tooltip" title="Inspection" data-placement="bottom"><i class="fa fa-search-minus "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnmaintenance"  data-toggle="tooltip" title="Maintenance" data-placement="bottom"><i class="fa fa-cogs "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnmovement"  data-toggle="tooltip" title="Movement Details" data-placement="bottom"><i class="fa fa-pencil-square-o "  aria-hidden="true"></i></button>        
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
        <div id="skipdiv"><jsp:include page="skipGrid.jsp"></jsp:include></div>          
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
    <div id="modalinduction" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Induction<span></span></h4>    
          		</div>
          		<div class="modal-body"> 
            		<div class="row">  
	            		  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Code">Code :</label>   
		        					<input type="text" id="txtcode" name="txtcode" class="form-control input-sm">
	                     	    </div>  
		                   </div>
  					</div>	
  					<div class="row">  
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Name">Name :</label>     
		        					<input type="text" id="txtname" name="txtname" class="form-control input-sm">  
	                     	    </div>  
		                   </div>
  					</div>
  					<div class="row">  
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Helper">Skip Size :</label>     
		        					<select class="form-control select2" name="cmbskipsize" id="cmbskipsize" style="width:100%;"></select>   
	                     	    </div>  
		                   </div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btninductionsave">Save Changes</button>  
            		
          		</div>
        </div>
      </div>
    </div> 
  <input type="hidden" name="hidbrhid" id="hidbrhid">   
  <input type="hidden" name="hiddocno" id="hiddocno">   
  <input type="hidden" name="divname" id="divname">       
  <input type="hidden" name="hidcomments" id="hidcomments">    
  <input type="hidden" name="lblname" id="lblname">    
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip(); 
	    $('#jobDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Job Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#jobDetailsWindow').jqxWindow('close');
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
    	getInitChartData();   
    	//inputload();
    	document.getElementById('selecteddiv').innerHTML=" - Entered"; 
    	document.getElementById("divname").value="entered";       
        $('#btnsubmit').click(function(){  
        	clearfields();      
            loads(); 
            getInitChartData(); 
        }); 
        $('#btninduction').click(function(){          
	    	$("#modalinduction").modal('toggle');  
        });
        $('#btninductionsave').click(function(){          
        	 funUpdate(1);  
        });
        $('#btninspection').click(function(){          
        	var enqno=$('#hiddocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	/* document.getElementById("lblname4").innerHTML=$("#lblname").val();
	    	$("#modalserviceupdate").modal('toggle'); */     
        });
        $('#btnmaintenance').click(function(){          
        	var enqno=$('#hiddocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	/* document.getElementById("lblname4").innerHTML=$("#lblname").val();
	    	$("#modalserviceupdate").modal('toggle'); */     
        });
        $('#btnmovement').click(function(){            
        	var enqno=$('#hiddocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	/* document.getElementById("lblname4").innerHTML=$("#lblname").val();
	    	$("#modalserviceupdate").modal('toggle'); */     
        });
        $('#btncomment').click(function(){    
	        var enqno=$('#hiddocno').val();
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
        	$("#skipdiv").excelexportjs({
        		containerid: "skipdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxSkipGrid",   
        		columns: getColumns("jqxSkipGrid") ,   
        		worksheetName:"Project Management"
         		});
        });
        $('#btncommentsend').click(function(){
        	var enqno=$('#hiddocno').val();
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
        		$('#jqxSkipGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    function jobSearchContent(url) {
		$('#jobDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#jobDetailsWindow').jqxWindow('setContent', data);
		$('#jobDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("hiddocno").value="";   
    }
    
    function getInitChartData(){  
    	 /* var brhid=$("#cmbbranch").val();
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
		x.send();     */  
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
    	$("#jqxSkipGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxSkipGrid").jqxGrid('applyfilters');    
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#hiddocno').val();
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
    	var enqno=$('#hiddocno').val();
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
	    var divname=$("#divname").val();
	  /*   var brhid=$("#cmbbranch").val();
	    var fdatechk=$("#fdatechk").val();  
	    var fromdate=$('#fromdate').jqxDateTimeInput('val');         
	    var todate=$('#todate').jqxDateTimeInput('val');   */  
	    $('#skipdiv').load('skipGrid.jsp?divname='+divname+'&id=1');   
    }   

	
	/* $('div').click(function() {
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
	  }); */	     
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
					$('#cmbskipsize').html($.parseHTML(optionsbranch));
		  			$('#cmbskipsize').select2({
		  				placeholder:"Please select a skip size",          
		  				allowClear:true 
		  			});
				} else {}
			}
			x.open("GET","getSkipsize.jsp", true);  
			x.send();
		}
		function funUpdate(chkevent){   
			var processid="";
			var docno = $('#hiddocno').val();
			var brhid= $("#hidbrhid").val();
			if(parseInt(chkevent)==1){	
				var skipsizeid = $('#cmbskipsize').val();      
				var name= $('#txtname').val(); 
				var code= $('#txtcode').val();
				processid="Skip Master"; 
				if(name==""){       
						 swal.fire({  
							 icon: 'warning',
								title: 'Warning',
								text: 'Please select enter name!!!'  
							});
			  		      return false;
				}  
				if(code==""){       
					 swal.fire({  
						 icon: 'warning',
							title: 'Warning',
							text: 'Please select enter code!!!'  
						});
		  		      return false;
			    }
				if(skipsizeid==""){       
					 swal.fire({  
						 icon: 'warning',
							title: 'Warning',
							text: 'Please select a skip size!!!'    
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
							funskipmaster(processid,name,code,skipsizeid);      
						}else{
						}
				});
			}else{}        
		}
		
		function funskipmaster(processid,name,code,skipsizeid){      
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText;
						 if(parseInt(items)=="1"){  	  
								$('#btnsubmit').trigger('click');
								if(processid=="Skip Master"){
									 swal.fire({  
											icon: 'success',
											title: 'Success',
											text: 'Successfully Created'  
										});
									 $("#modalinduction").modal('toggle');     
								}
							}else{
								if(processid=="Skip Master"){  
									 swal.fire({  
										    icon: 'warning',
											title: 'Warning',
											text: 'Not Created'  
										});
								}
							} 
					}
			}
				
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&skipsizeid="+skipsizeid+"&name="+encodeURIComponent(name)+"&code="+encodeURIComponent(code),true);      
		x.send();        
		}
  </script>
<div id="jobDetailsWindow">
	<div></div><div></div>
</div>  
  </div>
  </form>   
</body>
</html>
