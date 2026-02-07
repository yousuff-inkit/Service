<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>GW Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../floorMgmtIncludes.jsp"></jsp:include>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<link href="css/util.css" rel="stylesheet" />
<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../vendors/fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../vendors/fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('../vendors/fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('../vendors/fonts/montserrat/Montserrat-SemiBold.ttf'); 
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
	}
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:rgba(88,103,221,1);
	}
	.custom-tabs li.active a, .custom-tabs li.active, .custom-tabs li.focus a, .custom-tabs li.focus {
    	color: #fff;
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: rgba(88,103,221,1);
	}
	.panel-body{
		border:none;
	}
	.help-block{
		display:none;
	}
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top custom-navbar">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span> 
      			</button>
      			<a class="navbar-brand" href="#" style="padding-top: 2px;padding-bottom: 2px;padding-left: 15px;padding-right: 15px;">
      				<span style="margin-right:10px;"><img alt="" src="../icons/1242-GATEWAY-ERPi.gif" style="width:auto; height: 100%;"></span>
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> <span class="user-dropdown-text">John Doe</span>
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu">
          					<li><a href="#" onclick="location.replace('index.jsp');">Sign Out</a></li>
          					<!-- <li><a href="#">Change Password</a></li> -->
        				</ul>
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav>
	<form autocomplete="off">
		<div class="container-fluid">
			<ul class="nav nav-pills custom-tabs nav-justified m-t-60">
	    		<li class="active"><a data-toggle="pill" href="#menucallregister"><i class="fa fa-phone p-r-5"></i>Call Register</a></li>
	    		<li><a data-toggle="pill" href="#menuassignjob"><i class="fa fa-address-card-o p-r-5"></i>Call Register Details</a></li>
	  		</ul>
			<div class="tab-content">
				<div id="menucallregister" class="tab-pane fade in active">
					<div class="container-fluid m-t-20">
						<div class="row">
							<div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="form-horizontal">
	    									<div class="form-group">
	      										<label class="control-label col-sm-2" for="name">Name:</label>
	      										<div class="col-sm-10">
	        										<input type="text" class="form-control input-sm" id="name" placeholder="Enter Name" name="name" onkeydown="funFilterPersons();" >
	      											<span class="help-block m-b-0"></span>
	      											<div class="container-fluid" style="max-height:200px;overflow-y:auto;">
														<ul id="personlist" class="list-group">
															
														</ul>	      											
	      											</div>
	      										</div>
	    									</div>
	    									<div class="form-group">
	      										<label class="control-label col-sm-2" for="cmbcompany">Company:</label>
	      										<div class="col-sm-10">
	        										<select name="cmbcompany" id="cmbcompany" class="form-control">
	        											<option value="">--Select--</option>
	        										</select>
	        										<span class="help-block"></span>
	      										</div>
										    </div>
										    <div class="form-group">
	      										<label class="control-label col-sm-2" for="mobile">Mobile:</label>
	      										<div class="col-sm-10">
	        										<input type="text" name="mobile" id="mobile" class="form-control input-sm">
	        										<span class="help-block"></span>
	      										</div>
										    </div>
										    <div class="form-group">
	      										<label class="control-label col-sm-2" for="email">Email:</label>
	      										<div class="col-sm-10">
	        										<input type="email" name="email" id="email" class="form-control input-sm">
	        										<span class="help-block"></span>
	      										</div>
										    </div>
										    <div class="form-group">
	      										<label class="control-label col-sm-2" for="cmbservicetype">Service Type:</label>
	      										<div class="col-sm-10">
	        										<select name="cmbservicetype" id="cmbservicetype" class="form-control">
	        											<option value="">--Select--</option>
	        										</select>
	        										<span class="help-block"></span>
	      										</div>
										    </div>
										    <div class="form-group">
	      										<label class="control-label col-sm-2" for="query">Query:</label>
	      										<div class="col-sm-10">
	        										<input type="text" name="query" id="query" class="form-control input-sm">
	      											<span class="help-block"></span>
	      										</div>
	      										
										    </div>
										    <div class="form-group">
	      										<label class="control-label col-sm-2" for="query">Complaint:</label>
	      										<div class="col-sm-10">
	        										<select name="cmbcomplaint" id="cmbcomplaint" class="form-control">
	        											<option value="">--Select--</option>
	        										</select>
	        										<span class="help-block"></span>
	      										</div>
										    </div>
										    <div class="form-group">
	      										<label class="control-label col-sm-2" for="query">Comm.Type:</label>
	      										<div class="col-sm-10">
	        										<select name="cmbcommtype" id="cmbcommtype" class="form-control">
	        											<option value="call">Call</option>
	        											<option value="whatsapp">WhatsApp</option>
	        											<option value="mail">E-mail</option>
	        										</select>
	      										</div>
										    </div>
										    <div class="form-group">
	      										<label class="control-label col-sm-2" for="query">Priority:</label>
	      										<div class="col-sm-10">
	        										<select name="cmbpriority" id="cmbpriority" class="form-control">
	        											<option value="1">P1 - Complete Stoppage</option>
	        											<option value="2">P2 - Restricted Working</option>
	        											<option value="3">P3 - Minor Issue</option>
	        											<option value="4" selected>P4 - Modification</option>
	        										</select>
	      										</div>
										    </div>
										    <div class="form-group">        
										      	<div class="col-sm-offset-2 col-sm-10">
										        	<button type="button" class="btn btn-default" id="btnsubmit">Submit</button>
										      	</div>
										    </div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xs-12 col-sm-12 col-md-5 col-lg-5">
								<div class="panel panel-default">
									<div class="panel-heading">
										<p class="panel-title m-b-0">Active Contract Details</p>
									</div>
									<div class="panel-body p-b-0 p-t-0">
										<div class="container-fluid table-responsive">
											<table class="table m-b-0 tblactivecontract">
												<thead>
													<tr>
														<th>Type</th>
														<th>From Date</th>
														<th>To Date</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<p class="panel-title m-b-0">Pending Complaints</p>
									</div>
									<div class="panel-body p-b-0 p-t-0">
										<div class="table-responsive custom-scrollbar" style="max-height:300px;overflow-y:auto;">
											<table class="table m-b-0 tblpendingcomplaints">
												<thead>
													<tr>
														<th>Sr.No</th>
														<th>Serv.Type</th>
														<th>Complaint</th>
														<th>Description</th>
													</tr>
												</thead>
												<tbody>
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id=menuassignjob class="tab-pane fade">
					<div class="panel panel-default m-t-10">
						<div class="table-responsive">
							<table class="table tbl-cregdetail">
								<thead>
									<tr>
										<th>SL No</th>
										<th>CREG No</th>
										<th>Date</th>
										<th>Name</th>
										<th>Service Type</th>
										<th>Complaint</th>
										<th>Description</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<input type="hidden" name="userid" id="userid">
		<input type="hidden" name="contactid" id="contactid">
		<input type="hidden" name="contracttype" id="contracttype">
		<input type="hidden" name="contracttrno" id="contracttrno">
	</form>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#cmbcompany").select2({
			    placeholder: "Select Company",
			    allowClear: true,
			    width: '100%'
			});
			$("#cmbservicetype").select2({
			    placeholder: "Select Service Type",
			    allowClear: true,
			    width: '100%'
			});
			$("#cmbcomplaint").select2({
			    placeholder: "Select Complaint",
			    allowClear: true,
			    width: '100%'
			});
			$("#cmbpriority").select2({
			    placeholder: "Select Priority",
			    width: '100%'
			});
			$("#cmbcommtype").select2({
			    placeholder: "Select Communication Type",
			    width: '100%'
			});
			$(document).on('click',function(e){
				
				if ($('#personlist').is(':visible') && $(e.target).is("#name,#personlist") === false) {
      				$('#personlist').slideUp('fast');
    			}
			});
			
			$('#personlist').slideUp('fast');
			
			$('#name').click(function(){
				$('#personlist').slideDown('fast');
			});
			$("#cmbcompany").change(function(){
				var compid=$(this).val();
				funGetServiceType(compid);
			});
			funInitData();
			$('#btnsubmit').click(function(){
				var contact=$('#name').val();
				var contactid=$('#contactid').val();
				var mobile=$('#mobile').val();
				var email=$('#email').val();
				var cmbservicetype=$('#cmbservicetype').val();
				var query=$('#query').val();
				var cmbcomplaint=$('#cmbcomplaint').val();
				var cmbcompany=$('#cmbcompany').val();
				var contracttrno=$('#contracttrno').val();
				var contracttype=$('#contracttype').val();
				var cmbcommtype=$('#cmbcommtype').val();
				var cmbpriority=$('#cmbpriority').val();
				if(contact==''){
					$('#name').closest('.form-group').addClass('has-error').find('.help-block').text('Name is Mandatory').css('display','block');
					return false;
				}
				else{
					$('#name').closest('.form-group').removeClass('has-error').find('.help-block').text('').css('display','none');
				}
				if(cmbcompany==''){
					$('#cmbcompany').closest('.form-group').addClass('has-error').find('.help-block').text('Company is Mandatory').css('display','block');
					return false;
				}
				else{
					$('#cmbcompany').closest('.form-group').removeClass('has-error').find('.help-block').text('').css('display','none');
				}
				/*if(mobile==''){
					$('#mobile').closest('.form-group').addClass('has-error').find('.help-block').text('Mobile is Optional').css('display','block');
				}
				else{
					$('#mobile').closest('.form-group').removeClass('has-error').find('.help-block').text('').css('display','none');
				}*/
				if(query==''){
					$('#query').closest('.form-group').addClass('has-error').find('.help-block').text('Query is Mandatory').css('display','block');
					return false;
				}
				else{
					$('#query').closest('.form-group').removeClass('has-error').find('.help-block').text('').css('display','none');
				}
				
				funSaveAJAX(contact,contactid,mobile,email,cmbservicetype,query,cmbcomplaint,cmbcompany,contracttrno,contracttype,cmbcommtype,cmbpriority);
			});
		});
		
		function funSaveAJAX(contact,contactid,mobile,email,cmbservicetype,query,cmbcomplaint,cmbcompany,contracttrno,contracttype,cmbcommtype,cmbpriority){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items=x.responseText.trim();
	  				if(items.split("::")[0]=="0"){
	  					Swal.fire({
							icon: 'success',
						  	title: 'Successfully Saved',
						  	text: 'CREG #'+items.split("::")[1]+' Created',
						});
						$("#menucallregister select").val('').trigger('change');
						$("#cmbcommtype").val('call').trigger('change');
						$("#cmbpriority").val('4').trigger('change');
						$("#menucallregister").find("input[type=text],input[type=email],#contactid,#contracttype,#contracttrno").val('');
	  					$('.tblactivecontract tbody tr').html('');
	  					$('.tblpendingcomplaints tbody').html('');
	  					funInitData();
	  				}
	  				else{
	  					Swal.fire({
							icon: 'error',
						  	title: 'Not Saved',
						  	text: 'There was an error creating Call Register',
						});
						return false;
	  				}
	  			}
	  		}
	  		x.open("GET", "saveData.jsp?contact="+contact+"&contactid="+contactid+"&mobile="+mobile+"&email="+email+"&cmbservicetype="+cmbservicetype+"&cmbcomplaint="+cmbcomplaint+"&cmbcompany="+cmbcompany+"&query="+query+"&contracttrno="+contracttrno+"&contracttype="+contracttype+"&cmbcommtype="+cmbcommtype+"&cmbpriority="+cmbpriority, true);
	  		x.send();
		}
		function funFilterPersons(){
			// Declare variables
  			var input, filter, ul, li, a, i, txtValue;
  			input = document.getElementById('name');
  			filter = input.value.toUpperCase();
  			ul = document.getElementById("personlist");
  			li = ul.getElementsByTagName('li');

  			// Loop through all list items, and hide those who don't match the search query
  			for (i = 0; i < li.length; i++) {
    			a = li[i].getElementsByTagName("a")[0];
    			txtValue = a.textContent || a.innerText;
    			if (txtValue.toUpperCase().indexOf(filter) > -1) {
      				li[i].style.display = "";
    			} else {
      				li[i].style.display = "none";
    			}
  			}
		}
		
		function funInitData(){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items=x.responseText.trim();
	  				var rawdata=JSON.parse(items.trim());
	  				var personhtml='',companyhtml='<option value="">--Select--</option>',complainthtml='<option value="">--Select--</option>';
	  				$.each(rawdata.persondata, function( index, value ) {
	  					personhtml+='<li class="list-group-item row">';
						personhtml+='<a href="#" data-contactid="'+value.contactid+'" data-compid="'+value.compid+'" data-mobile="'+value.mobile+'" data-email="'+value.email+'">';
						personhtml+='<div class="col-xs-4">';
						personhtml+='<span>'+value.contactperson+'</span>';
						personhtml+='</div>';
						personhtml+='<div class="col-xs-8">';
						personhtml+='<span>'+value.company+'</span>';
						personhtml+='</div>';
						personhtml+='</a>';
						personhtml+='</li>';
	  				});
	  				$('#userid').val(rawdata.userid);
	  				$('.custom-navbar .user-dropdown .user-dropdown-text').text(rawdata.username);
	  				$('#personlist').html($.parseHTML(personhtml));
	  				
	  				$.each(rawdata.companydata, function( index, value ) {
	  					companyhtml+='<option value="'+value.compid+'">'+value.company+'</option>';
	  				});
	  				$('#cmbcompany').html($.parseHTML(companyhtml));
	  				
	  				$.each(rawdata.complaintdata, function( index, value ) {
	  					complainthtml+='<option value="'+value.id+'">'+value.name+'</option>';
	  				});
	  				$('#cmbcomplaint').html($.parseHTML(complainthtml));
	  				var creghtml='';
	  				$.each(rawdata.cregdata, function( index, value ) {
	  					creghtml+='<tr>';
	  					creghtml+='<td>'+value.serial+'</td>';
	  					creghtml+='<td>'+value.cregno+'</td>';
	  					creghtml+='<td>'+value.cregdate+'</td>';
	  					creghtml+='<td>'+value.name+'</td>';
	  					creghtml+='<td>'+value.servicetype+'</td>';
	  					creghtml+='<td>'+value.complaint+'</td>';
	  					creghtml+='<td>'+value.description+'</td>';
	  					creghtml+='<td>'+value.status+'</td>';
	  					creghtml+='</tr>';
	  				});
	  				$('.tbl-cregdetail tbody').html($.parseHTML(creghtml));
	  				document.querySelectorAll('#personlist li a')
					.forEach(e => e.addEventListener("click", clickPersonHandler));
	  			}
	  		}
	  		x.open("GET", "getInitData.jsp", true);
	  		x.send();
		}
		
		function clickPersonHandler(){
			var contactperson=$(this).find('div').eq(0).find('span').text();
			var contactid=$(this).attr('data-contactid');
			var compid=$(this).attr('data-compid');
			var mobile=$(this).attr('data-mobile');
			var email=$(this).attr('data-email');
			$('#contactid').val(contactid);
			$('#name').val(contactperson);
			$('#cmbcompany').val(compid).trigger('change');
			$('#mobile').val(mobile);
			$('#email').val(email);
			$('#personlist').slideUp('fast');
			funGetServiceType(compid);
		}
		
		function funGetServiceType(compid){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items=x.responseText.trim();
	  				var rawdata=JSON.parse(items.trim());
	  				var servicetypehtml='<option value="">--Select</option>';
	  				var pendinghtml='';
	  				$.each(rawdata.servicetypedata, function( index, value ) {
	  					servicetypehtml+='<option value="'+value.id+'">'+value.name+'</option>';
	  				});
	  				if(rawdata.contractexpiry=="1"){
	  					$('.tblactivecontract tbody tr').html($.parseHTML('<td colspan="3" style="text-align:center;"><span class="label label-default label-danger">Contract Expired</span></td>'));
	  				}
	  				else{
	  					$('.tblactivecontract tbody tr').html($.parseHTML('<td>'+rawdata.contracttype+" - "+rawdata.contractdocno+'</td><td>'+rawdata.contractfrom+'</td><td>'+rawdata.contractto+'</td>'));
	  					$('#contracttype').val(rawdata.contracttype);
	  					$('#contracttrno').val(rawdata.contracttrno);	
	  				}
	  				$.each(rawdata.pendingdata, function( index, value ) {
	  					pendinghtml+='<tr>';
	  					pendinghtml+='<td>'+value.serial+'</td>';
	  					pendinghtml+='<td>'+value.servicetype+'</td>';
	  					pendinghtml+='<td>'+value.complaint+'</td>';
	  					pendinghtml+='<td>'+value.description+'</td>';
	  					pendinghtml+='</tr>';
	  				});
	  				$('.tblpendingcomplaints tbody').html($.parseHTML(pendinghtml));
	  				$('#cmbservicetype').html($.parseHTML(servicetypehtml));
	  				
	  			}
	  		}
	  		x.open("GET", "getServiceType.jsp?compid="+compid, true);
	  		x.send();	
		}
	</script>
</body>
</html>