<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Schedule Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">
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
	.datepanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
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
	
/* 	.modal-dialog,
.modal-content {
    /* 80% of window height */
    height: 80%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}		 */
  </style>
</head>
<body onload="getDriver();getHelper()">
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <form class="form-inline"> 
        <div class="primarypanel custompanel">
            			<div class="form-group col-auto">
    						<select class="cmbload" name="cmbload" style="width: 100%" id="cmbload" onchange="loadGrid();">
  							<option value="1">Route</option>
  							<option value="2">Schedule</option>
						</select>
  						</div>
			    </div>		  
              <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>
         <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btncreateroute"><i class="fa fa-tachometer" aria-hidden="true" data-toggle="tooltip"  title="Create Route" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnschedule"><i class="fa fa-check-circle-o" aria-hidden="true" data-toggle="tooltip" title="Schedule" data-placement="bottom"></i></button>
        </div> 
       <!--  <div class="textpanel custompanel">    
			<p class="h4">&nbsp;</p>
        </div>  -->
        </form>
			     
		 </div> 
  
      </div>
   </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="routegriddiv"><jsp:include page="routeGrid.jsp"></jsp:include></div>
      </div>
    </div>
	  <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="schedulegriddiv"><jsp:include page="scheduleGrid.jsp"></jsp:include></div>
      </div>
    </div> 
	
	<div id="modalcreateroute" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Create Route<span></span></h4>
          		</div>
          		<div class="modal-body">
            		 <div class="row"> 
  				           <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Code">Code:</label>     
		        					<input type="text" id="txtcode" name="txtcode" class="form-control input-sm" style="height:5%;">   
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Name">Name:</label>       
		        					<input type="text" id="txtname" name="txtname" class="form-control input-sm" style="height:5%;">   
	                     	    </div>  
		                   </div>
            		</div>
            		<div class="row"> 
  				           <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Dumping">Dumping site:</label>     
		        					<input type="text" id="txtdumpsite" name="txtdumpsite" class="form-control input-sm" placeholder="press F3 to search" style="height:5%;" readonly  onKeyDown="getDump(event);">   
		        					<input type="hidden" id="hiddumpsiteid" name="hiddumpsiteid">       
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Vehicle">Vehicle group:</label>       
		        					<input type="text" id="txtvehgroup" name="txtvehgroup" class="form-control input-sm" placeholder="press F3 to search" style="height:5%;" readonly  onKeyDown="getVehgrp(event);">   
		        					<input type="hidden" id="hidvehgroupid" name="hidvehgroupid">        
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Area">Area:</label>       
		        					<input type="text" id="txtarea" name="txtarea" class="form-control input-sm" placeholder="press F3 to search" style="height:5%;" readonly  onKeyDown="getArea(event);">   
		        					<input type="hidden" id="hidareaid" name="hidareaid">                
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
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Schedule<span></span></h4>
          		</div>
          		<div class="modal-body">
            			<div class="row">  
	            		  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Driver">Driver:</label>   
		        					<select class="form-control select2" name="cmbdriver" id="cmbdriver" style="width:100%;"></select> 
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Helper">Helper:</label>     
		        					<select class="form-control select2" name="cmbhelper" id="cmbhelper" style="width:100%;"></select> 
	                     	    </div>  
		                   </div>
  					</div>
  				  <div class="row"> 
  				           <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Helper">Route:</label>     
		        					<input type="text" id="txtroute" name="txtroute" class="form-control input-sm" placeholder="press F3 to search" style="height:5%;" readonly  onKeyDown="getRoute();">   
		        					<input type="hidden" id="hidrouteid" name="hidrouteid">              
	                     	    </div>  
		                   </div>
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Helper">Date:</label>     
		        					<div id="schdate" name="schdate"></div>  
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Helper">Time:</label>     
		        					<div id="schtime" name="schtime"></div>    
	                     	    </div>  
		                   </div>    
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnchedulesave">Save Changes</button>
            		
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
    <div id="dumpsearchwndow">
   <div ></div>
   </div>
   <div id="vehgrpsearchwndow">
   <div ></div>
   </div>
   <div id="areasearchwndow">
   <div ></div>
   </div>
	<div id="routeinfoWindow">  
	<div></div><div></div>
</div> 
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
        $('.load-wrapp').hide();
        $("#schedulegriddiv").hide();
    	$('.cmbload').select2();  
    	$("#schdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
      	$("#schtime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false}); 
      	$('#routeinfoWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Route Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 	    $('#routeinfoWindow').jqxWindow('close');
 	    $('#dumpsearchwndow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Dump Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#dumpsearchwndow').jqxWindow('close');
	    $('#vehgrpsearchwndow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Vehicle Group Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#vehgrpsearchwndow').jqxWindow('close');
	    $('#areasearchwndow').jqxWindow({ width: '60%', height: '70%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Area Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#areasearchwndow').jqxWindow('close');
	    $("#schtime").val(new Date());  
 	    $('#txtroute').dblclick(function(){  
	    	$('#routeinfoWindow').jqxWindow('open');
	    	routeSearchContent('routesearch.jsp?', $('#routeinfoWindow')); 
	       });
 	    $('#txtdumpsite').dblclick(function(){
	    	$('#dumpsearchwndow').jqxWindow('open');
			 dumpinfoSearchContent('searchDump.jsp?', $('#dumpsearchwndow'));  
	     });
	    $('#txtvehgroup').dblclick(function(){
	    	$('#vehgrpsearchwndow').jqxWindow('open');
			 vehgrpinfoSearchContent('searchVehgrp.jsp?', $('#vehgrpsearchwndow'));  
	     });
	    $('#txtarea').dblclick(function(){
	    	$('#areasearchwndow').jqxWindow('open');
			 areainfoSearchContent('searchArea.jsp?', $('#areasearchwndow'));  
	    });
 	    $('#btnsubmit').click(function(){
			$('.load-wrapp').show(); 
			var id=$('#cmbload').val();
	    	if(parseInt(id)==1){
	    		 $('#routegriddiv').load('routeGrid.jsp?id=1');
	    	}
	    	if(parseInt(id)==2){
	    		 $('#schedulegriddiv').load('scheduleGrid.jsp?id=1');    
	   	    }
		});
		$('#btnexcel').click(function(){
			var id=$('#cmbload').val();
	    	if(parseInt(id)==1){
	    		 $("#routegriddiv").excelexportjs({
	 				containerid: "routegriddiv",
	 				datatype: 'json',
	 				dataset: null,
	 				gridId: "jqxroutegrid",
	 				columns: getColumns("jqxroutegrid"),
	 				worksheetName: "Schedule Management"
	 			});
	    	}
	    	if(parseInt(id)==2){
	    		 $("#schedulegriddiv").excelexportjs({
	 				containerid: "schedulegriddiv",
	 				datatype: 'json',
	 				dataset: null,
	 				gridId: "jqxschedulegrid",
	 				columns: getColumns("jqxschedulegrid"),  
	 				worksheetName: "Schedule Management"
	 			});
	   	    }
		});
		$('#btncreateroute').click(function(){
			$("#modalcreateroute").modal('toggle');        
        });
		$('#btnschedule').click(function(){
			$("#modalschedule").modal('toggle');      
        });
		 $('#btnchedulesave').click(function(){
				funUpdate(1); 
	        });
        $('#btnroutesave').click(function(){
			    funUpdate(2);   
        });
		$('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(txtcomment==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	saveComment();
        });
	}); 
	function getDump(event){
		 var x= event.keyCode;
   	 if(x==114){
   		 $('#dumpsearchwndow').jqxWindow('open');
   		 dumpinfoSearchContent('searchDump.jsp?', $('#dumpsearchwndow'));   
   	}
   	 else{
   		 
   	 }
	}
	function dumpinfoSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#dumpsearchwndow').jqxWindow('open');
  		$('#dumpsearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	}
	
	function getVehgrp(event){
		 var x= event.keyCode;
  	 if(x==114){
  		 $('#vehgrpsearchwndow').jqxWindow('open');
  		 vehgrpinfoSearchContent('searchVehgrp.jsp?', $('#vehgrpsearchwndow'));   
  	}
  	 else{
  		 
  	 }
	}
	
	function vehgrpinfoSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#vehgrpsearchwndow').jqxWindow('open');
 		$('#vehgrpsearchwndow').jqxWindow('setContent', data);
 
 	}); 
 	}
	
	function getArea(event){
		 var x= event.keyCode;
  	 if(x==114){
  		 $('#areasearchwndow').jqxWindow('open');
  		 areainfoSearchContent('searchArea.jsp?', $('#areasearchwndow'));   
  	}
  	 else{
  		 
  	 }
	}
	
	function areainfoSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#areasearchwndow').jqxWindow('open');
 		$('#areasearchwndow').jqxWindow('setContent', data);
 
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
    function loadGrid(){
    	var id=$('#cmbload').val();
    	if(parseInt(id)==1){
    		 $("#routegriddiv").show();
    		 $("#schedulegriddiv").hide();
    	}
    	if(parseInt(id)==2){
	   		 $("#routegriddiv").hide();
	   		 $("#schedulegriddiv").show();  
   	    }
    	$('#btnsubmit').trigger('click');
    }
	function funUpdate(chkevent){   
		var processid="";
		if(parseInt(chkevent)==1){	
			 var driver = $('#cmbdriver').val();  
		     var helper= $('#cmbhelper').val(); 
			 var routeid= $('#hidrouteid').val();
			 var schdate= $('#schdate').val();
			 var schtime= $('#schtime').val(); 
			 processid="Schedule";   
			 if(driver==''){
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Please select a driver!!!'  
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
						funschedule(processid,driver,helper,routeid,schdate,schtime);    
					}else{
					}
			});  
		}if(parseInt(chkevent)==2){	
			 var code = $('#txtcode').val();  
		     var name= $('#txtname').val(); 
			 var dumpsiteid= $('#hiddumpsiteid').val();
			 var vehgroupid= $('#hidvehgroupid').val();
			 var areaid= $('#hidareaid').val();
			 processid="Route";   
			 if(code==''){
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Please enter code!!!'  
						});
		  		      return false;
			 } 
			 if(name==''){
				 swal.fire({  
					    icon: 'warning',
						title: 'Warning',  
						text: 'Please enter name!!!'    
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
						funroute(processid,code,name,dumpsiteid,vehgroupid,areaid);      
					}else{
					}
			});
		}else{}     
	}  
	function funschedule(processid,driver,helper,routeid,schdate,schtime){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){    	  
							$('#btnsubmit').trigger('click');
							if(processid=="Schedule"){    
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Scheduled'    
									});
								 $("#modalschedule").modal('toggle');    
							}
						}else{
							if(processid=="Schedule"){
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Scheduled'  
									});
							}
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&driverid="+driver+"&helperid="+helper+"&routeid="+routeid+"&schdate="+schdate+"&schtime="+schtime,true);      
	x.send();         
	}
	function funroute(processid,code,name,dumpsiteid,vehgroupid,areaid){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)=="1"){    	  
							$('#btnsubmit').trigger('click');
							if(processid=="Route"){    
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Created'      
									});
								 $("#modalcreateroute").modal('toggle');      
							}
						}else{
							if(processid=="Route"){  
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Created'  
									});
							}
						} 
				}
		}
			
	x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&code="+code+"&name="+name+"&dumpsiteid="+dumpsiteid+"&vehgroupid="+vehgroupid+"&areaid="+areaid,true);        
	x.send();         
	}
</script>
</body>
</html>
