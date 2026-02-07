<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>GW Queries</title>          
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../vendors/animate/animate.css">
<link href="../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../vendors/select2/css/select2.min.css" rel="stylesheet" />
<link href="css/util.css" rel="stylesheet" />
<style>
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../vendors/fonts/Poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../vendors/fonts/Poppins/Poppins-Medium.ttf'); 
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
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	
	.txt2 {
	  	font-family: Poppins-Regular;
	  	font-size: 14px;
	  	color: #999999;
	  	line-height: 1.5;
	}
	.rowgap{
    	margin-bottom:6px;
    }
	.page-loader{
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.5);
		position:relative;
		z-index:9999999;
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: #5867dd;
    	border-color: #5867dd;
		color:#fff;
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		
	}
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:rgba(88,103,221,1);
	}
	.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-bottom: 5px;
	}
	.card-container .card-header{
		width: 100%;
		text-align: center;
		padding-top: 10px;
		padding-bottom: 5px;
	}
	.card-container .card-body{
		width: 100%;
		padding-left: 10px;
		padding-right: 10px;
	}
	.card-container .card-body .list-group .list-group-item{
		margin-bottom: 10px;
		border-radius: 25px;
	}
	.card-container .card-body .list-group .list-group-item .badge{
		background-color: rgba(0,0,0,.05);
		color: #000;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	.card-body h1.txt1{
		font-size: 26px;
		margin-top: 5px;
	}
	.primary{
		color:#5867dd;
	}
	
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
    .datepanel div{
    	display:inline-block;
    }
    .datepanel{
    	height:54px;
    	padding-top:20px;
    }
    .stmtpanel{
    	height:54px;
    	padding-top:15px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
	
.admin-cover .panel-body{
	border:none;
}

.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-top: 10px;
	}
	.card-container .card-icon-wrapper{
		width: 30%;
		display: inline-block;
		clear: both;
		float: left;
		padding-left: 10px;
		padding-right: 10px;
		
	}
	.card-container .card-detail-wrapper{
		width: 70%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-detail-wrapper{
		width: 50%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-expand-wrapper{
		width: 18%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container .card-detail-wrapper p:nth-child(1){
		margin-top: 5px;
		margin-bottom: 2px;
	}
	.centered{
	    margin: 0 auto;
	}
	.custom-tabs li.active a, .custom-tabs li.active, .custom-tabs li.focus a, .custom-tabs li.focus {
    	color: #fff;
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: rgba(88,103,221,1);
	}
	.contact-container{
		width:100%;
		background-color:#fff;
	}
	.contact-header{
		background-image:url("images/bg-02.jpg");
		background-size:cover;
		background-repeat:no-repeat;
		background-position:center top;
	}
	.boxshadow1{
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
	}
	#tblsurvey tbody tr.active td,#tblservice tbody tr.active td{
		color: #fff;
	    background-color: rgba(88,103,221,1);
	}
	#tblservice tbody tr.active td span.badge,#tblsurvey tbody tr.active td span.badge{   
		background-color:#fff;
		color:rgba(88,103,221,1);
	}
	/* #tblexenq tbody tr{
		cursor:pointer;
	} */  
	.btn-outline-primary{
	    color: rgba(88,103,221,1);
	    background-color: transparent;
	    background-image: none;
	    border-color: rgba(88,103,221,1);
	}
	.btn-outline-primary:hover,.btn-outline-primary:focus,.btn-outline-primary:active{
	    color: #fff;
	    background-color: rgba(88,103,221,1);
	    background-image: none;
	    border-color: rgba(88,103,221,1);
	}
	
	#tblservice .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
	
	#tblservice .table-responsive {
	  overflow-y: visible !important;
	}
	#fieldset-existing div ul li{
		cursor:pointer;
	}
	.select2-drop{
		display:none !important;
	}
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<div class="page-loader hidden">
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
      			<a class="navbar-brand" href="#" style="padding-top:12px;padding-bottom: 2px;padding-left: 15px;padding-right: 15px;">
      				<span style="margin-right:10px;"><img alt="" src="images/epic.jpg" style="width:auto; height: 100%;"></span>
      				GW Query Dashboard     
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> <span class="user-dropdown-text">John Doe</span>
        					<span class="caret"></span>
        				</a>
        				<!-- <ul class="dropdown-menu">
          					<li><a href="#" onclick="location.replace('index.jsp');">Sign Out</a></li>
        				</ul> -->
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav> 
	
	<div class="container-fluid">
		<div class="panel panel-default" style="margin-top:70px;">
			<div class="panel-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
							<fieldset><legend>New Query</legend>
							<div class="form-horizontal">
								<div class="form-group">
				    				<label class="control-label col-sm-2" for="compname">Company Name:</label>
				    				<div class="col-sm-10">
				      					<input type="text" class="form-control" id="compname" placeholder="Enter Company Name" readonly>
				    					<select id="cmbcompany" name="cmbcompany" class="form-control" hidden="true">
				    						<option value="">--Select--</option>
				    					</select>
				    				</div>
				  				</div>
				  				<div class="form-group">
				    				<label class="control-label col-sm-2" for="username">User Name:</label>
				    				<div class="col-sm-10">
				      					<input type="text" class="form-control" id="username" placeholder="Enter User Name" readonly>
				    				</div>
				  				</div>
				  				<div class="form-group">
				    				<label class="control-label col-sm-2" for="usermobile">User Mobile:</label>
				    				<div class="col-sm-10">
				      					<input type="text" class="form-control" id="usermobile" placeholder="Enter User Mobile">
				    				</div>
				  				</div>
				  				<div class="form-group">
				    				<label class="control-label col-sm-2" for="useremail">User Email:</label>
				    				<div class="col-sm-10">
				      					<input type="text" class="form-control" id="useremail" placeholder="Enter User E-Mail">
				    				</div>
				  				</div>
				  				<div class="form-group">
				    				<label class="control-label col-sm-2" for="formname">Form Name:</label>
				    				<div class="col-sm-10">
				      					<input type="text" class="form-control" id="formname" placeholder="Enter Form Name">
				    				</div>
				  				</div>
				  				<div class="form-group">
				    				<label class="control-label col-sm-2" for="shortdesc">Short Description:</label>
				    				<div class="col-sm-10">
				      					<input type="text" class="form-control" id="shortdesc" placeholder="Enter Short Description">
				    				</div>
				  				</div>
				  				<div class="form-group">
				    				<label class="control-label col-sm-2" for="querytext">Query:</label>
				    				<div class="col-sm-10">
				      					<input type="text" class="form-control" id="querytext" placeholder="Enter Your Query">
				    				</div>
				  				</div>						
							</div>
							<div class="panel-footer text-right">
				<button type="button" class="btn btn-default btn-primary btn-save"><i class="fa fa-check" style="margin-right:3px;"></i>Save Changes</button>
			</div> 
							</fielset>
						</div>
						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
							<fieldset id="fieldset-existing"><legend>Existing Queries</legend>
								<div class="panel panel-default">
									<div class="panel-body" style="height:400px;overflow-y:auto;">
										
									</div>
									<div class="panel-footer text-right">
										<button type="button" class="btn btn-default btn-attach"><i class="fa fa-paperclip" style="margin-right:3px;"></i>Attach</button>
									</div>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		<!--	<div class="panel-footer text-right">
				<button type="button" class="btn btn-default btn-attach"><i class="fa fa-paperclip" style="margin-right:3px;"></i>Attach</button>
				<button type="button" class="btn btn-default btn-primary btn-save"><i class="fa fa-check" style="margin-right:3px;"></i>Save Changes</button>
			</div> -->
		</div>
  	</div>
  	<input type="hidden" id="comprefid">
  	<input type="hidden" id="querydocno">
	<script src="../vendors/jquery/jquery-3.2.1.min.js"></script>
	<script src="../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
	<script src="../vendors/sweetalert/sweetalert2.all.min.js"></script>
	<script src="../vendors/select2/js/select2.min.js"></script>
    <script>
    	var username='<%=request.getParameter("username")==null?"":request.getParameter("username").toString().trim()%>';
		var usermobile='<%=request.getParameter("usermobile")==null?"":request.getParameter("usermobile").toString().trim()%>';
		var usermail='<%=request.getParameter("usermail")==null?"":request.getParameter("usermail").toString().trim()%>';
		var compname='<%=request.getParameter("compname")==null?"":request.getParameter("compname").toString().trim()%>';
		var comprefid='<%=request.getParameter("comprefid")==null?"":request.getParameter("comprefid").toString().trim()%>';
		$('#comprefid').val(comprefid);   
		if($('#comprefid').val()=='9710001'){
			$('#cmbcompany').show();
			$('#compname').hide();
		}
		else{
			$('#cmbcompany').hide();
			$('#compname').show();
		}
    	$(document).ready(function(){
    		funGetQueries();
			$('#compname').val(compname);
			$('#username').val(username);
			$('#useremail').val(usermail);
			$('#usermobile').val(usermobile);
			$('.user-dropdown-text').text(username);
			$('.btn-attach').click(function(){
				var activerow=$('#fieldset-existing div ul li.active');
				if(activerow.length==0){
					Swal.fire({
						icon:'warning',
						title: 'Warning',
						text: 'Please select an existing query'
					});
					return false;
				}
				var docno=$('#querydocno').val();
				var frmdet="GWQ";
				var frmname="GW Query";             
				var brhid=1; 
				<%
				String username=request.getParameter("username")==null?"GWUSER":request.getParameter("username").toString();
				session.setAttribute("COMPANYID","1");
				session.setAttribute("BRANCHID","1");
				session.setAttribute("USERNAME",username);
				%>
				//alert("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank");
				var myWindow=window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
			});
			$('.btn-save').click(function(){
				if($('#comprefid').val()==''){
					Swal.fire({
						icon:'warning',
						type: 'error',
						title: 'Warning',
						text: 'Company Refernce Mandatory'
					});
					return false;
				}
				if($('#username').val()==''){
					$('#username').parent().find('span.help-block').remove();
					$('#username').parent().append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
					$('#username').focus();
					return false;
				}
				else{
					$('#username').parent().find('span.help-block').remove();
				}
				
				if($('#usermobile').val()==''){
					$('#usermobile').parent().find('span.help-block').remove();
					$('#usermobile').parent().append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
					$('#usermobile').focus();
					return false;
				}
				else{
					$('#usermobile').parent().find('span.help-block').remove();
				}
				if(!$.isNumeric($('#usermobile').val())){
					$('#usermobile').parent().find('span.help-block').remove();
					$('#usermobile').parent().append($.parseHTML('<span class="help-block" style="color:red;">Only Digits Allowed</span>'));
					$('#usermobile').focus();
					return false;
				}
				else{
					$('#usermobile').parent().find('span.help-block').remove();
				}
				if($('#usermobile').val().length>12){
					$('#usermobile').parent().find('span.help-block').remove();
					$('#usermobile').parent().append($.parseHTML('<span class="help-block" style="color:red;">Max 12 Digits</span>'));
					$('#usermobile').focus();
					return false;
				}
				else{
					$('#usermobile').parent().find('span.help-block').remove();
				}
				if($('#useremail').val()==''){
					$('#useremail').parent().find('span.help-block').remove();
					$('#useremail').parent().append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
					$('#useremail').focus();
					return false;
				}
				else{
					$('#useremail').parent().find('span.help-block').remove();
				}
				var emailregex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  				if(emailregex.test($('#useremail').val())){
  					$('#useremail').parent().find('span.help-block').remove();
  				}
  				else{
  					$('#useremail').parent().find('span.help-block').remove();
					$('#useremail').parent().append($.parseHTML('<span class="help-block" style="color:red;">Enter Valid Email Id</span>'));
					$('#useremail').focus();
					return false;
  				}
				if($('#shortdesc').val()==''){
					$('#shortdesc').parent().find('span.help-block').remove();
					$('#shortdesc').parent().append($.parseHTML('<span class="help-block" style="color:red;">Mandatory</span>'));
					$('#shortdesc').focus();
					return false;
				}
				else{
					$('#shortdesc').parent().find('span.help-block').remove();
				}
				
				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to save changes?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Yes'
				}).then((result) => {
	  				if (result.isConfirmed) {
	  					$('.page-loader').show();	
	  					var newrefid=comprefid;
	  					if(comprefid=='9710001'){
	  						newrefid=$('#cmbcompany').val();
	  					}		
	  					
	  					$.post('saveQueries.jsp',
					{
						username:$('#username').val(),
						usermobile:$('#usermobile').val(),
						usermail:$('#useremail').val(),
						formname:$('#formname').val(),
						shortdesc:$('#shortdesc').val(),
						query:$('#querytext').val(),
						comprefid:newrefid
					},
					function(data,status){
						$('.page-loader').hide();		
						data=JSON.parse(data);
						if(data.errorstatus==0){
							Swal.fire({
								icon:'success',
								type: 'success',
								title: 'Success',
								text: 'Query Saved Successfully'
							});
							$('#querydocno').val(data.querydocno);
							$('#formname,#shortdesc,#querytext').val('');
							funGetQueries();
						}else if(data.errorstatus<0){
							Swal.fire({
								icon:'warning',
								type: 'warning',
								title: 'Warning',
								text: 'License Expiry , Cannot raise new tickets'   
							});
						}
						else {
							Swal.fire({
								icon:'warning',
								type: 'error',
								title: 'Warning',
								text: 'Not Saved'
							});
							
						}
					});
	  				}
	  			});
				
			});
			
			
    	});
    	
    	function funGetQueries(){
    		$.get('getQueries.jsp',{comprefid:$('#comprefid').val()},function(data){
				data=JSON.parse(data);
				console.log(data.complist);
				var htmldata='<option value="">--Select--</option>';
				$.each(data.complist,function(index,value){
					htmldata+='<option value="'+value.comprefid+'">'+value.compname+'</option>';
				});
				$('#cmbcompany').html($.parseHTML(htmldata));
				$('#cmbcompany').select2({
					placeholder:"Please Select Company",
					allowClear:true
				});
				if($('#comprefid').val()!='9710001'){
					$('#cmbcompany').select2('destroy');
				}
				htmldata='';
				if(data.querydata.length>0){
					htmldata='<ul class="list-group">';
					$.each(data.querydata,function(index,value){
						htmldata+='<li class="list-group-item" data-comprefid="'+value.comprefid+'" data-querydocno="'+value.docno+'" data-username="'+value.username+'" data-usermobile="'+value.usermobile+'" data-usermail="'+value.usermail+'" data-formname="'+value.formname+'" data-shortdesc="'+value.shortdesc+'" data-query="'+value.query+'" data-compname="'+value.compname+'">'+(value.username+' - '+value.shortdesc+' - '+value.assignstatus)+'</li>';
					});	
					htmldata+='</ul>';
				}
				if(data.changedata.length>0){
					htmldata+='<h4><strong>Change Requested Queries</strong></h4>';
					htmldata+='<ul class="list-group">';
					$.each(data.changedata,function(index,value){
						htmldata+='<li class="list-group-item" data-comprefid="'+value.comprefid+'" data-querydocno="'+value.docno+'" data-username="'+value.username+'" data-usermobile="'+value.usermobile+'" data-usermail="'+value.usermail+'" data-formname="'+value.formname+'" data-shortdesc="'+value.shortdesc+'" data-query="'+value.query+'" data-compname="'+value.compname+'">'+(value.username+' - '+value.shortdesc+' - '+value.assignstatus)+'</li>';
					});	
					htmldata+='</ul>';					
				}
				
				if(data.querydata.length==0 && data.changedata.length==0){
					$('#fieldset-existing .panel .panel-body').empty();
					$('#fieldset-existing .panel .panel-body').html($.parseHTML('<div class="text-center"><small class="text-muted">No data to display</small></div>'));
				}
				else{
					$('#fieldset-existing .panel .panel-body').empty();
					$('#fieldset-existing .panel .panel-body').html($.parseHTML(htmldata));
				}
				$('#fieldset-existing div ul li').click(function(){
					$('#fieldset-existing div ul li').removeClass('active');
					$(this).addClass('active');
					$('#compname').val($(this).attr('data-compname'));
					$('#querydocno').val($(this).attr('data-querydocno'));
					$('#username').val($(this).attr('data-username'));
					$('#useremail').val($(this).attr('data-usermail'));
					$('#usermobile').val($(this).attr('data-usermobile'));
					$('#formname').val($(this).attr('data-formname'));
					$('#shortdesc').val($(this).attr('data-shortdesc'));
					$('#querytext').val($(this).attr('data-query'));
					$('#cmbcompany').val($(this).attr('data-comprefid')).trigger('change');
				});
			});
    	}
    </script>           
</body>     
</html>