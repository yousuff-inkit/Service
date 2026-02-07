<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:include page="../includes.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Call Register Report</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="util.css" rel="stylesheet">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> --%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<style type="text/css">
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
	.custom-navbar .dropdown.open a.dropdown-toggle,.custom-navbar .dropdown a.dropdown-toggle,.custom-navbar .dropdown a.dropdown-toggle:hover{
		background-color: #5867dd;
		color:#fff;
	}
</style>
</head>
<body>
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<nav class="navbar navbar-default navbar-fixed-top custom-navbar">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
      			</button>
      			<a class="navbar-brand" href="#">Call Register Report</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav">
      				<li></li>
        			<li><a href="#"><div id="fromdate"></div></a></li>
        			<li><a href="#"><div id="todate"></div></a></li>
        			<li>
        				<a href="#">
        					<select class="form-control" id="cmbclient" name="cmbclient" style="width:100%;">
        						<option value="">--Select--</option>
        					</select>
        				</a>
        			</li>
        			<li>
        				<a href="#">
        					<select class="form-control input-sm" id="cmbstatus" name="cmbstatus" onchange="funfrmdatedisable();"  style="width:100%;">               
								<option value="">--Select--</option>  
								<option value="OPEN" selected>OPEN</option>
								<option value="CLOSE">CLOSE</option>
								<option value="ALL" >ALL</option>                  
							</select>
						</a>
					</li>
					<li>
						<a href="#">
							<select class="form-control  input-sm" id="cmbasgngrp" name="cmbasgngrp" onchange="getAssignMember();" style="width:100%;">
								<option value="">--Select--</option>
							</select>
						</a>
					</li>
					<li>
						<a href="#">
							<select class="form-control input-sm" id="cmbasgnmembr" name="cmbasgnmembr" style="width:100%;">
								<option value="">--Select--</option>
							</select>
						</a>
					</li>
					<li class="text-center"><a href="#" onClick="funLoadData();">Load Data <i class="fa fa-refresh"></i></a></li>
      			</ul>
      			<ul class="nav navbar-nav navbar-right">
        			<%-- <li>
        				<div class="btn-group btn-statuswise m-t-18 m-r-5">
							<a class="btn btn-default btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" href="#">
								<span class="text">Statuswise Statistics</span>
	          					<span class="caret"></span>
	        				</a>
	        				<ul class="statuswise-dropdown dropdown-menu" style="width:250px;">
							</ul>   
						</div>
					</li> --%>
					<li class="dropdown">
        				<a href="#" class="dropdown-toggle btn btn-default btn-primary btn-sm m-b-5" data-toggle="dropdown" style="color:#fff;padding-top: 5px;padding-bottom: 5px;margin-right: 5px;"><span class="text">Statuswise Statistics</span> <b class="caret"></b></a>
        				<ul class="dropdown-menu statuswise-dropdown">
				        	<li><a href="#">Action</a></li>
				          	<li><a href="#">Another action</a></li>
				          	<li><a href="#">Something else here</a></li>
				          	<li><a href="#">Separated link</a></li>
				          	<li><a href="#">One more separated link</a></li>
        				</ul>
      				</li>
      				<li class="dropdown">
        				<a href="#" class="dropdown-toggle btn btn-default btn-primary btn-sm" data-toggle="dropdown" style="color:#fff;padding-top: 5px;padding-bottom: 5px;margin-right: 5px;"><span class="text">Datewise Statistics</span> <b class="caret"></b></a>
        				<ul class="datewise-dropdown dropdown-menu">
				        	<li><a href="#">Action</a></li>
				          	<li><a href="#">Another action</a></li>
				          	<li><a href="#">Something else here</a></li>
				          	<li><a href="#">Separated link</a></li>
				          	<li><a href="#">One more separated link</a></li>
        				</ul>
      				</li>
        			<%-- <li>
        				<div class="btn-group btn-datewise  m-t-18">
							<a class="btn btn-default btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" href="#">
								<span class="text">Datewise Statistics</span>
	          					<span class="caret"></span>
	        				</a>
	        				<ul class="datewise-dropdown dropdown-menu" style="width:250px;">
							</ul>
						</div>
        			</li> --%>
      			</ul>
    		</div>
  		</div>
	</nav>
	<div class="container-fluid boxshadow1 img-rounded m-t-60 custom-scrollbar" style="overflow:auto;">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"  >
				<div class="panel-group panel-install-list">
					 <div style="height:88%;" class="install-list-wrap hidden-xs"></div>
					 <div class="visible-xs" style="overflow:auto;max-height:100vh;">
					 	<div class="panel panel-default panel-primary">
					 		<div class="panel-heading">
					 			<p class="panel-title">CREG 1024 Sayara Car Rental</p>
					 		</div>
					 		<div class="panel-body" style="padding-left:5px;padding-top:0;padding-bottom:0;">
					 			<ul class="list-group" class="margin-bottom:0;">
      								<li class="list-group-item row">
          								<div class="col-xs-2 text-left" style="padding-left:0;margin-left:0;">Client</div>
          								<div class="col-xs-10">Sayara Car Rental</div>
      								</li>
								    <li class="list-group-item row">
								    	<div class="col-xs-2" style="padding-left:0;margin-left:0;">Date</div>
          								<div class="col-xs-10">05.11.2019 16:26</div>
								    </li>
      								<li class="list-group-item row">
          								<div class="col-xs-2" style="padding-left:0;margin-left:0;">Status</div>
          								<div class="col-xs-10">Client Confirmed</div>
      								</li>
      								<li class="list-group-item row">
          								<div class="col-xs-2" style="padding-left:0;margin-left:0;">Assigned Member</div>
          								<div class="col-xs-10">Support Team - Dilna</div>
      								</li>
      								<li class="list-group-item row">
          								<div class="col-xs-2" style="padding-left:0;margin-left:0;">Service Type</div>
          								<div class="col-xs-10">NI Purchase</div>
      								</li>
      								<li class="list-group-item row">
          								<div class="col-xs-2" style="padding-left:0;margin-left:0;">Description</div>
          								<div class="col-xs-10">Please upload the below excel, NI-1489 HO SHJ</div>
      								</li>
      								<li class="list-group-item row">
          								<div class="col-xs-2" style="padding-left:0;margin-left:0;">Entered User</div>
          								<div class="col-xs-10">Sree Lakshmy</div>
      								</li>
  								</ul>
					 		</div>
					 	</div>
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
			var clientselect=$("#cmbclient,#cmbasgngrp,#cmbasgnmembr,#cmbstatus");
			clientselect.on("select2:close", function () {
	            setTimeout(function () {
	                $('.select2-container-active').removeClass('select2-container-active');
	                $(':focus').blur();
	            }, 1);
	        });
	        clientselect.on('select2:open', function () {
	            $('.select2-search__field').prop('focus', false);
	        });
		});
		
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
					var mainhtml='',mobilehtml='';
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
						
						mobilehtml+='<div class="panel panel-default panel-primary mobile-panel">';
						mobilehtml+='<div class="panel-heading">';
						mobilehtml+='<p class="panel-title">CREG  '+value.refdocno+' - '+value.refname+'</p>';
						mobilehtml+='</div>';
						mobilehtml+='<div class="panel-body" style="padding-left:5px;padding-top:0;padding-bottom:0;overflow:hidden;">';
						mobilehtml+='<ul class="list-group" class="margin-bottom:0;">';
						mobilehtml+='<li class="list-group-item row">';
						mobilehtml+='<div class="col-xs-2 text-left" style="padding-left:0;margin-left:0;">Client</div>';
						mobilehtml+='<div class="col-xs-10">'+value.refname+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='<li class="list-group-item row">';
						mobilehtml+='<div class="col-xs-2" style="padding-left:0;margin-left:0;">Date</div>';
						mobilehtml+='<div class="col-xs-10">'+value.pldate+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='<li class="list-group-item row">';
						mobilehtml+='<div class="col-xs-2" style="padding-left:0;margin-left:0;">Status</div>';
						mobilehtml+='<div class="col-xs-10">'+value.status+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='<li class="list-group-item row">';
						mobilehtml+='<div class="col-xs-2" style="padding-left:0;margin-left:0;">Assigned Member</div>';
						mobilehtml+='<div class="col-xs-10">'+value.asgngrp+' - '+value.emp+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='<li class="list-group-item row">';
						mobilehtml+='<div class="col-xs-2" style="padding-left:0;margin-left:0;">Service Type</div>';
						mobilehtml+='<div class="col-xs-10">'+value.sertype+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='<li class="list-group-item row">';
						mobilehtml+='<div class="col-xs-2" style="padding-left:0;margin-left:0;">Description</div>';
						mobilehtml+='<div class="col-xs-10">'+value.description+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='<li class="list-group-item row">';
						mobilehtml+='<div class="col-xs-2" style="padding-left:0;margin-left:0;">Entered User</div>';
						mobilehtml+='<div class="col-xs-10">'+value.enuser+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='<li class="list-group-item row hidden">';
						mobilehtml+='<div class="col-xs-2" style="padding-left:0;margin-left:0;">GW Status</div>';
						mobilehtml+='<div class="col-xs-10">'+value.refstatus+'</div>';
						mobilehtml+='</li>';
						mobilehtml+='</ul>';
						mobilehtml+='</div>';
						mobilehtml+='</div>';
					
					
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
					$('.visible-xs').html($.parseHTML(mobilehtml));
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
			var mobilepanel=document.getElementsByClassName("mobile-panel");
			for(var j=0;j<mobilepanel.length;j++){
				var dategroupitem=mobilepanel[j].getElementsByClassName("list-group-item");
				var dategroupvalue=dategroupitem[1].getElementsByTagName("div")[1];
				var txtValue;
				if(dategroupvalue){
					txtValue=dategroupvalue.textContent || dategroupvalue.innerText;
					if(txtValue.toUpperCase().indexOf(filter) > -1) {
						mobilepanel[j].style.display="";
					}
					else{
						mobilepanel[j].style.display="none";
					}
				}
			}
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
			
			$(this).closest('.dropdown').find('.btn').find('span.text').text(selectedval);  
		 }
		function clickStatusHandler(){
			var selectedval=$(this).find('.text').text();
			var status=$(this).find('.text').text();
			var filter=status.toUpperCase();
			var table=document.getElementsByClassName("tblinstallation");
			var mobilepanel=document.getElementsByClassName("mobile-panel");
			for(var j=0;j<mobilepanel.length;j++){
				var statusgroupitem=mobilepanel[j].getElementsByClassName("list-group-item");
				var statusgroupvalue=statusgroupitem[7].getElementsByTagName("div")[1];
				var txtValue;
				if(statusgroupvalue){
					txtValue=statusgroupvalue.textContent || statusgroupvalue.innerText;
					if(filter=="ALL"){
						mobilepanel[j].style.display="";
					}
					else{
						if(txtValue.toUpperCase().indexOf(filter) > -1) {
							mobilepanel[j].style.display="";
						}
						else{
							mobilepanel[j].style.display="none";
						}	
					}
				}
			}
			for(var j=0;j<table.length;j++){
				var tr=table[j].getElementsByTagName("tr");	
				var txtValue;
				var td = tr[0].getElementsByTagName("td")[2];
				if(td){
					txtValue = td.textContent || td.innerText;
					if(filter=="ALL"){
						table[j].closest(".panel-primary").style.display="";
					}
					else{
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
			}
			
			$(this).closest('.dropdown').find('.btn').find('span.text').text(selectedval);  
		}
	</script>
</body>
</html>