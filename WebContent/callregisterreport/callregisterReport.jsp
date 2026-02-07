<%--     

<%String contextPath=request.getContextPath();%> --%>
<jsp:include page="../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Job Progress Report</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="util.css" rel="stylesheet">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> --%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<style>
    .buttonClass {
	  background-color: #F3F8F8; /* Green */
	  border: none;
	  margin: 4px 2px;
	  padding: 7px;
	  color: Black;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  cursor: pointer;
	  border-radius: 12px;
	  box-shadow:  0 0 10px  rgba(0,0,0,0.6);
      -moz-box-shadow: 0 0 10px  rgba(0,0,0,0.6);
      -webkit-box-shadow: 0 0 10px  rgba(0,0,0,0.6);
      -o-box-shadow: 0 0 10px  rgba(0,0,0,0.6);
}
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
		font-size:14px;
	}
	.boxshadow1{
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
	}
	.custom-scrollbar::-webkit-scrollbar {
	    width: 4px;
	}

	.custom-scrollbar::-webkit-scrollbar-track {
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
	    border-radius: 10px;
	}

	.custom-scrollbar::-webkit-scrollbar-thumb {
	    border-radius: 10px;
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
	}
	.detail-data{
		display: none;
	}
	.detail-data.active{
		display: block;
	}
	input[type="text"] {
	    height: 30px;
	    padding: 5px 10px;
	    font-size: 12px;
	    line-height: 1.5;
	    border-radius: 3px;
	}
	table tbody tr td{
		font-size:14px;
	}
	table thead tr th{
		font-size:14px;
	}
	.border{
		border:1px solid #000;
	}
	.tblinstallation .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
	
	.tblinstallation .table-responsive {
	  overflow-y: visible !important;
	}
	.bg-primary {
	    background-color: #007bff!important;
	}
	.bg-success {
	    background-color: #28a745!important;
	}
	.bg-info {
	    background-color: #17a2b8!important;
	}
	.bg-warning {
	    background-color: #ffc107!important;
	}
	.bg-danger {
	    background-color: #dc3545!important;
	}
	.bg-secondary {
	    background-color: #6c757d!important;
	}
	.bg-dark {
	    background-color: #343a40!important;
	}
	.bg-light {
	    background-color: #f8f9fa!important;
	}
	.custom-control {
	    position: relative;
	    display: block;
	    min-height: 1.5rem;
	    padding-left: 1.5rem;
	}
	.custom-control-label {
	    margin-bottom: 0;
	}
	input[type=checkbox], input[type=radio] {
	   box-sizing: border-box;
	   padding: 0;
	}
	.custom-control-input {
	   position: absolute;
	   z-index: -1;
	   opacity: 0;
	}
	.custom-radio .bg-primary.custom-control-input:checked~.custom-control-label::before {
	    background-color: #007bff;
	}

	.bg-primary.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #007bff;
	}
	.custom-radio .bg-success.custom-control-input:checked~.custom-control-label::before {
	    background-color: #28a745;
	}

	.bg-success.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #28a745;
	}
	.custom-radio .bg-info.custom-control-input:checked~.custom-control-label::before {
	    background-color: #17a2b8;
	}

	.bg-info.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #17a2b8;
	}
	.custom-radio .bg-warning.custom-control-input:checked~.custom-control-label::before {
	    background-color: #ffc107;
	}

	.bg-warning.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #ffc107;
	}
	.custom-radio .bg-danger.custom-control-input:checked~.custom-control-label::before {
	    background-color: #dc3545;
	}

	.bg-danger.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #dc3545;
	}
	.custom-radio .bg-secondary.custom-control-input:checked~.custom-control-label::before {
	    background-color: #6c757d;
	}

	.bg-secondary.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #6c757d;
	}
	.custom-radio .bg-dark.custom-control-input:checked~.custom-control-label::before {
	    background-color: #343a40;
	}

	.bg-dark.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #343a40;
	}
	.custom-radio .bg-light.custom-control-input:checked~.custom-control-label::before {
	    background-color: #f8f9fa;
	}

	.bg-light.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #28a745;
	}
	.custom-radio .custom-control-input:checked~.custom-control-label::before {
	    background-color: #007bff;
	}

	.custom-control-input:checked~.custom-control-label::before {
	    color: #fff;
	    background-color: #007bff;
	}
	.custom-radio .custom-control-label::before {
	    border-radius: 50%;
	}
	.custom-control-label::before {
	    position: absolute;
	    top: .25rem;
	    left: 0;
	    display: block;
	    width: 1rem;
	    height: 1rem;
	    pointer-events: none;
	    content: "";
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	    background-color: #dee2e6;
	}
	.page-loader{
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.5);
		z-index:9999999;
		position:fixed;
		text-align:center;
		
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: #5867dd;
    	border-color: #5867dd;
		color:#fff;
		margin-top:20%;
	}
	.datewise-dropdown{
		height: auto;
    	max-height: 100px;
    	overflow-x: hidden;
    	position: absolute;
    	z-index:99999;
	}
</style>
</head>
<body>
<div class="custom-scrollbar" style="overflow:auto;">              
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<div class="panel panel-default m-b-0">
		<div class="panel-body" style="padding:0;">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-2">
					<a class="navbar-brand">Call Register Report</a>  
				</div>
				<div class="col-md-2 p-t-15 p-b-15 p-l-0 p-r-0 m-r-40">
					<div class="col-md-6" id="hidefrmdate">
						<div id="fromdate"></div>	     
					</div>
					<div class="col-md-6 p-l-40 p-r-0">
						<div id="todate"></div>	
					</div>
				</div>
				<div class="col-md-2 m-l-20 p-t-10">     
					<div class="btn-group btn-statuswise">        
						<a class="btn btn-default btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" href="#"><span class="text">Statuswise Statistics</span>
	          				<span class="caret"></span>
	        			</a>
	        			<ul class="statuswise-dropdown dropdown-menu" style="width:250px;">
	  						<%-- <li><a href="#">Open<span class="badge pull-right">40</span></a></li>
	  						<li><a href="#">Close<span class="badge pull-right">65</span></a></li>
	  						<li><a href="#">All<span class="badge pull-right">105</span></a></li>   --%>      
						</ul>   
					</div>
				</div>
				<div class="col-md-2 m-l-20 p-t-10">    
					<div class="btn-group btn-datewise">
						<a class="btn btn-default btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" href="#"><span class="text">Datewise Statistics</span>
	          				<span class="caret"></span>
	        			</a>
	        			<ul class="datewise-dropdown dropdown-menu" style="width:250px;">
	  						<%-- <li><a href="#">24-10-2019 Thursday<span class="badge pull-right">4</span></a></li>
	  						<li><a href="#">25-10-2019 Friday<span class="badge pull-right">5</span></a></li>
	  						<li><a href="#">26-10-2019 Saturday<span class="badge pull-right">6</span></a></li> --%>
						</ul>
					</div>
				</div>
	  </div>
	  <div class="row">
	      <div class="col-md-12">
					<ul class="nav navbar-nav">
					    <li>
							<a>
					            <select class="form-control" id="cmbclient" name="cmbclient" style="width:100%;"><option value="">--Select--</option></select>
							</a>   
						</li>
						<li>
							<a>
								<select class="form-control" id="cmbstatus" name="cmbstatus" onchange="funfrmdatedisable();"  style="width:100%;">               
								    <option value="">--Select--</option>  
									<option value="OPEN">OPEN</option>
									<option value="CLOSE">CLOSE</option>
								    <option value="ALL">ALL</option>                  
								</select>	
							</a>                                      
						</li>
						<li>
							<a>
								<select class="form-control" id="cmbasgngrp" name="cmbasgngrp" onchange="getAssignMember();" style="width:100%;"><option value="">--Select--</option></select>	
							</a>
						</li>            
						<li>
							<a>
								<select class="form-control" id="cmbasgnmembr" name="cmbasgnmembr" style="width:100%;"><option value="">--Select--</option></select>	
							</a>
						</li>
						<li><a onClick="funLoadData();" style="padding-top:20px;padding-bottom:20px;"><i class="fa fa-refresh"></i></a></li>
					</ul>
			</div>
		  </div>
		  <br/> 
		  <br/>	
		</div>
	</div>
	</div>
	<div class="container-fluid boxshadow1 img-rounded">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"  >
				<div class="panel-group m-t-20  panel-install-list">
					 <div style="height:55%;" class="install-list-wrap"></div>    
				</div>
			</div>
		</div>
	</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
	 		$("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
	 		$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
			var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 		var onemonthbackdate=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
	 		$('#fromdate').jqxDateTimeInput('setDate',onemonthbackdate);    
			$("#cmbstatus").select2({
			    placeholder: "Select status",
			    allowClear: true
			});
			$("#cmbclient").select2({        
			    placeholder: "Select Client",
			    allowClear: true
			});
			$("#cmbasgngrp").select2({                    
			    placeholder: "Select Assign Group",
			    allowClear: true
			});
			$("#cmbasgnmembr").select2({        
			    placeholder: "Select Assign Member",           
			    allowClear: true
			});
			getAssignGroup();   
			getAssignMember();
		    getClient();    
			funLoadData();
			$('.page-loader').hide();
			
			
		});
		function funfrmdatedisable(){
	         if($('#cmbstatus').val()=="OPEN"){          
	              $('#hidefrmdate').hide();         
	         }else{
	         	$('#hidefrmdate').show(); 
	         }
		}   
		function getAssignGroup() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items=x.responseText.trim();
					var rawdata=JSON.parse(items);
					var asgngrphtml='<option value="">--Select--</option>';
					$.each(rawdata.asgngrpdata, function(key,value){
						asgngrphtml+='<option value="'+value.docno+'">'+value.name+'</option>';  
					});
					$("select#cmbasgngrp").html($.parseHTML(asgngrphtml));
				} else {
				}
			}
			x.open("GET","getAssignGroup.jsp", true);
			x.send();
		}
		function getAssignMember() {  
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {   
					var items=x.responseText.trim();
					var rawdata=JSON.parse(items);
					var asgnmembrhtml='<option value="">--Select--</option>';
					$.each(rawdata.asgnmembrdata, function(key,value){
						asgnmembrhtml+='<option value="'+value.docno+'">'+value.name+'</option>';
					});
					$("select#cmbasgnmembr").html($.parseHTML(asgnmembrhtml));
				} else {
				}
			}  
			x.open("GET","getAssignMember.jsp?assignid="+$('#cmbasgngrp').val(), true);
			x.send();      
		}
		function getClient() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items=x.responseText.trim();
					var rawdata=JSON.parse(items);
					var clienthtml='<option value="">--Select--</option>';
					$.each(rawdata.clientdata, function(key,value){       
						clienthtml+='<option value="'+value.docno+'">'+value.name+'</option>';
					});
					$("select#cmbclient").html($.parseHTML(clienthtml));   
				} else {
				}  
			}
			x.open("GET","getClient.jsp", true);
			x.send();
		}
		function funLoadData(){
			var todate=$('#todate').jqxDateTimeInput('val');
			var fromdate=$('#fromdate').jqxDateTimeInput('val');                 
			var clientid=$('#cmbclient').val();
		    var statusid=$('#cmbstatus').val();
			var asgngrpid=$('#cmbasgngrp').val();
			var asgnmembrid=$('#cmbasgnmembr').val();    
			$('.btn-datewise').find('.btn span.text').text('Datewise Statistics');
			$('.btn-statuswise').find('.btn span.text').text('Statuswise Statistics');                  
			$('.page-loader').show();
			funLoadMainData(fromdate,todate,clientid,statusid,asgngrpid,asgnmembrid);  
		}
		
		function funLoadMainData(fromdate,todate,clientid,statusid,asgngrpid,asgnmembrid){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					var rawdata=JSON.parse(items);
					var mainhtml='';
		    		$('.panel-install-list .install-list-wrap').html('');
		    		//alert(rawdata.datedata);
					var datedrophtml='';
			    		$.each(rawdata.datedata,function(key,value){
						datedrophtml+='<li><a style="cursor:pointer;"><span class="text">'+value.date+'</span><span class="badge pull-right">'+value.count+'</span></a></li>';
					});
					$('.datewise-dropdown').html($.parseHTML(datedrophtml));  
					
					document.querySelectorAll('.datewise-dropdown li a')
					.forEach(e => e.addEventListener("click", clickDateHandler));   
					
					var statusdrophtml='';                                             
			    		$.each(rawdata.statusdata,function(key,value){
						statusdrophtml+='<li><a style="cursor:pointer;"><span class="text">'+value.status+'</span><span class="badge pull-right">'+value.count+'</span></a></li>';
					});
					$('.statuswise-dropdown').html($.parseHTML(statusdrophtml));    
					
					document.querySelectorAll('.statuswise-dropdown li a')
					.forEach(e => e.addEventListener("click", clickStatusHandler));         
					
					$.each( rawdata.maindata, function( key, value ) {
						mainhtml+='<div class="panel panel-default panel-primary">';
						mainhtml+='<div class="panel-heading">';
						mainhtml+='<h6 class="panel-title">CREG  '+value.refdocno+' - '+value.refname+'</h6>';
						mainhtml+='</div>';
						mainhtml+='<div class="table-responsive img-rounded">';
						mainhtml+='<table class="table tblinstallation">';  
						mainhtml+='<tbody>';
						mainhtml+='<tr>';      
						mainhtml+='<td width="6.8%">Client</td>';
						mainhtml+='<td colspan="4" width="30%"><strong>'+value.refname+'</strong></td>'; 
						mainhtml+='<td width="1%"  style="display: none;">'+value.refstatus+'</td>';              
						mainhtml+='<td width="6.8%">Date</td>';   
						mainhtml+='<td width="5%"><strong>'+value.pldate+'</strong></td>';         
						mainhtml+='</tr>';
						mainhtml+='<tr>';
						mainhtml+='<td width="6.8%">Status</td>';
						mainhtml+='<td width="15%" colspan="2"><strong>'+value.status+'</strong></td>';   
						mainhtml+='<td width="6.8%">Entered User</td>';
						mainhtml+='<td width="15%"><strong>'+value.enuser+'</strong></td>';
						mainhtml+='<td width="6.8%">Assign Group</td>';
						mainhtml+='<td width="5%" colspan="2"><strong>'+value.asgngrp+'</strong></td>';  
						mainhtml+='</tr>';
                        mainhtml+='<tr>';
                        mainhtml+='<td width="6.8%">Assign Member</td>';   
						mainhtml+='<td width="15%" colspan="2"><strong>'+value.emp+'</strong></td>';
						mainhtml+='<td width="6.8%">Service Type</td>';
						mainhtml+='<td width="35%" colspan="2"><strong>'+value.sertype+'</strong></td>';   
						mainhtml+='<td width="6.8%">Age</td>';
						mainhtml+='<td width="5%"><strong>'+value.age+'</strong><input type="hidden" id="hidrefdocno" value="'+value.refdocno+'"/><input type="hidden" id="hidbrhid" value="'+value.branch+'"/></td>';           
						mainhtml+='</tr>';
  						mainhtml+='<tr>';
						mainhtml+='<td width="6.8%">Description</td>';   
						mainhtml+='<td width="90%" colspan="6"><strong>'+value.description+'</strong></td>';   
						mainhtml+='<td width="5%"><button type="button" class="buttonClass" id="btnattach" title="Attach" onclick="funattach();">Attach</button></td>';     
						mainhtml+='</tr>';
						mainhtml+='<tr>';
						mainhtml+='<td colspan="8">';
						mainhtml+='<div class="panel panel-default">';  
						mainhtml+='<div class="panel-heading">';
						mainhtml+='<h4 class="panel-title">';
						mainhtml+='<a data-toggle="collapse" href="#collapse'+key+'">Followup Details</a>';
						mainhtml+='</h4>';
						mainhtml+='</div>';
						mainhtml+='<div id="collapse'+key+'" class="panel-collapse collapse">';
						/*mainhtml+='<div class="panel-body">';*/
						mainhtml+='<table class="table">';
						mainhtml+='<thead>';
						mainhtml+='<tr>';
						mainhtml+='<th>Sr.No</th>';
						mainhtml+='<th>Assign Group</th>';
						mainhtml+='<th>Group Member</th>';
						mainhtml+='<th>Status</th>';
						mainhtml+='<th>Planned Date</th>';
						mainhtml+='<th>Planned Time</th>';
						mainhtml+='<th align="right" class="text-right">Age</th>';
						mainhtml+='<th>Description</th>';
						mainhtml+='</tr>';
						mainhtml+='</thead>';
						mainhtml+='<tbody>';
						$.each( value.detaildata, function( arrkey, arrvalue ) {
							mainhtml+='<tr>';
							mainhtml+='<td>'+arrvalue.srno+'</td>';
							mainhtml+='<td>'+arrvalue.empgroupid+'</td>';
							mainhtml+='<td>'+arrvalue.empid+'</td>';
							mainhtml+='<td>'+arrvalue.assignstatus+'</td>';  
							mainhtml+='<td>'+arrvalue.plannedon+'</td>';  
							mainhtml+='<td>'+arrvalue.pltime+'</td>';  
							mainhtml+='<td>'+arrvalue.age+'</td>';  
							mainhtml+='<td>'+arrvalue.description+'</td>';    
							mainhtml+='</tr>';
						});
						mainhtml+='</tbody>';
						mainhtml+='</table>';
						mainhtml+='</tbody>';
						mainhtml+='</table>';  
						mainhtml+='</div>';
						mainhtml+='</div>';
					});
					$('.panel-install-list .install-list-wrap').html($.parseHTML(mainhtml));
					$('.page-loader').hide();
				}
				else
				{
				}   
			}
			x.open("GET","loadMainData.jsp?fromdate="+fromdate+"&todate="+todate+"&clientid="+clientid+"&statusid="+statusid+"&asgngrpid="+asgngrpid+"&asgnmembrid="+asgnmembrid,true);
			x.send();  
		}
		
		function clickDateHandler(){
			var selectedval=$(this).find('.text').text();
			var date=$(this).find('.text').text().split(" ")[0];
			var filter=date.toUpperCase();
			var table=document.getElementsByClassName("tblinstallation");
			
			for(var j=0;j<table.length;j++){   
				var tr=table[j].getElementsByTagName("tr");	
				var txtValue;
				var td = tr[0].getElementsByTagName("td")[4];
				if(td){
					txtValue = td.textContent || td.innerText;
					//console.log(txtValue+"::"+filter);                                      
					//alert(txtValue+"::"+filter);
      				if(txtValue.toUpperCase().indexOf(filter) > -1) {
        				//tr[i].style.display = "";
      					table[j].closest(".panel-primary").style.display="";
      				}
      				else{
        				//tr[i].style.display = "none";
      					table[j].closest(".panel-primary").style.display="none";
      				}
				}
			}
			
			$(this).closest('.btn-group').find('.btn span.text').text(selectedval);  
		 }
		function clickStatusHandler(){
			var selectedval=$(this).find('.text').text();
			var status=$(this).find('.text').text();
			var filter=status.toUpperCase();
			var table=document.getElementsByClassName("tblinstallation");
			
			for(var j=0;j<table.length;j++){
				var tr=table[j].getElementsByTagName("tr");	
				var txtValue;
				var td = tr[0].getElementsByTagName("td")[2];
				if(td){
					txtValue = td.textContent || td.innerText;
					//console.log(txtValue+"::"+filter);
      				if(txtValue.toUpperCase().indexOf(filter) > -1) {
        				//tr[i].style.display = "";
      					table[j].closest(".panel-primary").style.display="";
      				}
      				else{
        				//tr[i].style.display = "none";
      					table[j].closest(".panel-primary").style.display="none";
      				}
				}
			}
			
			$(this).closest('.btn-group').find('.btn span.text').text(selectedval);
		}
	/*	function clickMainDataHandler(){   
			
			$('.main-data-list a').removeClass('active');
			$(this).addClass('active');
			var jobno=$(this).attr('data-jobno');
			if(jobno=="" || jobno=="undefined" || jobno==null){
				jobno=$('.main-data-list a').first().attr('data-jobno');
				$('.main-data-list a').first().addClass('active');
			}
			funLoadDetailData(jobno);
			$('.detail-data').addClass('active');
			return false;
		} */
		
		function funFilterMessages(){
			var input=document.getElementById("searchmsg");
			var filter=input.value.toUpperCase();
			var inboxitem=$('.main-data-list a');
			for(var i=0;i<inboxitem.length;i++){
				var a = inboxitem[i].getElementsByClassName("searchitem")[0];
		    	var txtValue = a.textContent || a.innerText;
		    	if (txtValue.toUpperCase().indexOf(filter) > -1) {
		      		inboxitem[i].style.display = "";
		    	}
		    	else {
		      		inboxitem[i].style.display = "none";
		    	}
			}
		}  
		function funattach(){
                                var brchid=$("#hidbrhid").val(); 
			             		var docno=$("#hidrefdocno").val();         
			             		var frmdet="CREG";
			             		if ($("#hidrefdocno").val()!="") {   
			   				var  myWindow= window.open("http://gate-way.dyndns.org:8879/ServiceDB/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			 							  myWindow.focus();
			 				
				 				} else {
				 					$.messager.alert('Message','Select a Document....!','warning');
				 					return;
				 				    }
		}     			                    
	</script>
</body>
</html>