<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Job Progress Report</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../logincontents/css/util.css" rel="stylesheet">
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> --%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<style>
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
	/* .detail-data{
		display: none;
	}
	.detail-data.active{
		display: block;
	} */
	input[type="text"] {
	    height: 30px;
	    padding: 5px 10px;
	    font-size: 12px;
	    line-height: 1.5;
	    border-radius: 3px;
	}
	table tbody tr td{
		font-size:12px;
	}
	table thead tr th{
		font-size:14px;
	}
	.border{
		border:1px solid #000;
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
</style>
</head>
<body onload="getBranch();">
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<div class="panel panel-default m-b-0">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-3">
					<a class="navbar-brand">Job Follow Up Report</a>
				</div>
				<div class="col-md-1 p-t-15 p-b-15 p-l-0 p-r-0 m-r-40">
					<!-- <div class="col-md-6 p-l-0 p-r-0">
						<div id="fromdate"></div>	
					</div> -->
					<div class="col-md-12 p-l-40 p-r-0">
						<div id="todate"></div>	
					</div>
				</div>
				<div class="col-md-1 p-t-10 p-b-5">
					<select class="form-control" id="cmbbranch" name="cmbbranch">
						<option value="">--Select--</option>
					</select>
				</div>
				<div class="col-md-2 p-t-10 p-b-5">
					<select class="form-control" id="cmbsalesman" name="cmbsalesman">
						<option value="">--Select--</option>
					</select>
				</div>
				<div class="col-md-4">
					<ul class="nav navbar-nav">
						<li><label class="radio-inline p-t-15 m-l-10"><input type="radio" name="optcontracttype" checked id="optcontracted">Contracted</label></li>
						<li><label class="radio-inline p-t-15 m-l-10"><input type="radio" name="optcontracttype" id="optnotcontracted">Not Contracted</label></li>
						<li><a onClick="funLoadData();"><i class="fa fa-refresh"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container-fluid boxshadow1 img-rounded">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="detail-data custom-scrollbar p-l-10 p-r-10 p-t-10" style="max-height:540px;overflow-y: auto; ">
					<div class="panel panel-default panel-primary hidden">
						<div class="panel-heading">Mohammed Hussain Mohammed - 19 - 10-10-2019</div>
						<div class="panel-body">
							<table class="table">
								<tbody>
									<tr>
										<td>Customer Name</td>
										<td colspan="5">Muhammed Hussain Muhammed</td>
									</tr>
									<tr>
										<td>Address</td>
										<td colspan="5">Not Available</td>
									</tr>
									<tr>
										<td>Mobile</td>
										<td colspan="4">919895098950</td>
										<td><a data-toggle="collapse" data-target="#moredata1">More Details</a></td>
									</tr>
								</tbody>
							</table>
									<div class="collapse" id="moredata1">
										<table class="table">
											<tbody>
												<tr>
										<td>Job No</td>
										<td>10021</td>
										<td>Date</td>
										<td>10-10-2019</td>
										<td>Job Amount</td>
										<td align="right">125485.25</td>
									</tr>
									<tr>
										<td>Discount %</td>
										<td>2</td>
										<td>Discount</td>
										<td align="right">2509.71</td>
										<td>Net Amount</td>
										<td align="right">122975.54</td>
									</tr>
									<tr>
										<td>Enquiry #</td>
										<td>1525</td>
										<td>Date</td>
										<td colspan="3">08-10-2019</td>
									</tr>
									<tr>
										<td>Current Status</td>
										<td colspan="5">Job Completed</td>
									</tr>
									<tr>
										<td>Lead Created by</td>
										<td colspan="5">&nbsp;</td>
									</tr>
									<tr>
										<td>Quoted Created by</td>
										<td colspan="5">&nbsp;</td>
									</tr>
									<tr>
										<td>Job Created by</td>
										<td colspan="5">&nbsp;</td>
									</tr>
									<tr>
										<td>No. of days taken to quote</td>
										<td colspan="5">&nbsp;</td>
									</tr>
									<tr>
										<td>No. of days taken to create job</td>
										<td colspan="5">&nbsp;</td>
									</tr>
									<tr>
										<td>No.of days till Enquiry created</td>
										<td colspan="5">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="6">
											<div class="panel panel-default">
												<div class="panel-heading">
													<h4 class="panel-title">
        												<a data-toggle="collapse" href="#collapse1">Job Progress Details</a>
      												</h4>
												</div>
												<div id="collapse1" class="panel-collapse collapse">
													<div class="panel-body">
														<table class="table">
															<thead>
																<tr>
																	<th>Sr.No</th>
																	<th>Completion Date</th>
																	<th>Install %</th>
																	<th align="right" class="text-right">Install Amount</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>1</td>
																	<td>01-10-2019</td>
																	<td>40</td>
																	<td>18227.68</td>
																</tr>
																<tr>
																	<td>2</td>
																	<td>03-10-2019</td>
																	<td>60</td>
																	<td>27341.68</td>
																</tr>
																<tr>
																	<td>3</td>
																	<td>05-10-2019</td>
																	<td>80</td>
																	<td>36455.68</td>
																</tr>
																<tr>
																	<td>3</td>
																	<td>01-10-2019</td>
																	<td>100</td>
																	<td>45569.68</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
												
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="6">
											<div class="panel panel-default">
												<div class="panel-heading">
													<h4 class="panel-title">
        												<a data-toggle="collapse" href="#collapse2">Follow Up &amp; Remarks</a>
        												<button type="button" class="btn btn-default"><i class="fa fa-refresh m-r-5"></i>Load</button>	
      												</h4>
												</div>
												<div id="collapse2" class="panel-collapse collapse">
													<div class="panel-body">
														<table class="table">
															<thead>
																<tr>
																	<th>Sr #</th>
																	<th>Dtype</th>
																	<th>Date</th>
																	<th>Remarks</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>1</td>
																	<td>PRD</td>
																	<td>10-10-2019</td>
																	<td>Nil</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</td>
									</tr>
									
								</tbody>
							</table>
									</div>
									
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			//$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 		/*var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 		var onemonthbackdate=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
	 		$('#fromdate').jqxDateTimeInput('setDate',onemonthbackdate);*/
	    	$("#cmbbranch").select2({
			    placeholder: "Select a branch",
			    allowClear: true
			});
			$("#cmbsalesman").select2({
			    placeholder: "Select Salesman",
			    allowClear: true
			});
			funLoadData();
			$('.page-loader').hide();
			getSalesman();
		});
		
		function getSalesman() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items=x.responseText.trim();
					var rawdata=JSON.parse(items);
					var salesmanhtml='<option value="">--Select--</option>';
					$.each(rawdata.salesmandata, function(key,value){
						salesmanhtml+='<option value="'+value.docno+'">'+value.name+'</option>';
					});
					$("select#cmbsalesman").html($.parseHTML(salesmanhtml));
				} else {
				}
			}
			x.open("GET","getSalesman.jsp", true);
			x.send();
		}
		function getBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
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
				} else {
				//alert("Error");
				}
			}
			x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
			x.send();
		}
		
		function funLoadData(){
			//var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
			var cmbbranch=$('#cmbbranch').val();
			var cmbsalesman=$('#cmbsalesman').val();
			var contracttype=0;
			if(document.getElementById("optcontracted").checked==true){
				contracttype=1;
			}
			else if(document.getElementById("optnotcontracted").checked==true){
				contracttype=2;
			}
			$('.page-loader').show();
			//funLoadMainData(todate,contracttype);
			funLoadDetailData(todate,contracttype,cmbsalesman,cmbbranch);
		}
		
		function funLoadMainData(todate,contracttype,cmbsalesman,cmbbranch){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					var rawdata=JSON.parse(items);
					var mainhtml='';
					
					$.each( rawdata.maindata, function( key, value ) {
						if(contracttype=="2"){
							mainhtml+='<a class="list-group-item" style="cursor:pointer;" data-jobno="'+value.enqdocno+'">';	
						}
						else{
							mainhtml+='<a class="list-group-item" style="cursor:pointer;" data-jobno="'+value.jobno+'">';
						}
						mainhtml+='<h5 class="list-group-item-heading searchitem"><i class="fa fa-user m-r-15"></i>'+value.clientname+'</h5>';
						mainhtml+='<p class="list-group-item-text searchitem"><i class="fa fa-mobile m-r-15"></i>'+value.clientmobile+'</p>';
						mainhtml+='<p class="list-group-item-text searchitem"><i class="fa fa-map-marker m-r-15"></i>'+value.area+'</p>';
						mainhtml+='<p class="list-group-item-text searchitem"><i class="fa fa-briefcase m-r-10"></i>'+value.jobno+' '+value.jobdate+'</p>';
						mainhtml+='<p class="list-group-item-text searchitem"><i class="fa fa-money m-r-10"></i>AED '+value.netamount+'</p>';
						mainhtml+='</a>';
					});
					$('.main-data-list').html($.parseHTML(mainhtml));
					document.querySelectorAll('.main-data-list a')
					.forEach(e => e.addEventListener("click", clickMainDataHandler));
					clickMainDataHandler();
					$('.page-loader').hide();
				}
				else
				{
				}
			}
			x.open("GET","loadMainData.jsp?todate="+todate+"&contracttype="+contracttype+"&salesman="+cmbsalesman+"&branch="+cmbbranch,true);
			x.send();
		}
		
		function clickMainDataHandler(){
			
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
		}
		
		function funLoadDetailData(todate,contracttype,cmbsalesman,cmbbranch){
			var contracttype=0;
			if(document.getElementById("optcontracted").checked==true){
				contracttype=1;
			}
			else if(document.getElementById("optnotcontracted").checked==true){
				contracttype=2;
			}
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					var rawdata=JSON.parse(items);
					var detailhtmldata='';
					$('.detail-data').html('');
					$.each( rawdata.detaildata, function( key, value ) {
						detailhtmldata+='<div class="panel panel-default panel-primary">';
						if(contracttype==2){
							detailhtmldata+='<div class="panel-heading">'+value.clientname+' - '+value.enqvocno+' - '+value.enqdate+' - '+value.currentstatus+'</div>';	
						}
						else{
							detailhtmldata+='<div class="panel-heading">'+value.clientname+' - '+value.jobno+' - '+value.jobdate+' - '+value.currentstatus+'</div>';
						}
						
						/*detailhtmldata+='<div class="panel-body">';*/
						detailhtmldata+='<table class="table">';
						detailhtmldata+='<tbody>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Customer Name</td>';
						detailhtmldata+='<td colspan="5">'+value.clientname+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Address</td>';
						detailhtmldata+='<td colspan="5">'+value.clientaddress+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Mobile</td>';
						detailhtmldata+='<td colspan="4">'+value.clientmobile+'</td>';
						detailhtmldata+='<td><a data-toggle="collapse" data-target="#moredata'+key+'" style="cursor:pointer;">More Details</a></td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='</tbody>';
						detailhtmldata+='</table>';
						detailhtmldata+='<div id="moredata'+key+'" class="collapse">';
						detailhtmldata+='<table class="table">';
						detailhtmldata+='<tbody>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Job No</td>';
						detailhtmldata+='<td>'+value.jobno+'</td>';
						detailhtmldata+='<td>Date</td>';
						detailhtmldata+='<td>'+value.jobdate+'</td>';
						detailhtmldata+='<td>Job Amount</td>';
						detailhtmldata+='<td align="right">'+value.netamount+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Discount %</td>';
						detailhtmldata+='<td>'+value.discountpercent+'</td>';
						detailhtmldata+='<td>Discount</td>';
						detailhtmldata+='<td align="right">'+value.discount+'</td>';
						detailhtmldata+='<td>Net Amount</td>';
						detailhtmldata+='<td align="right">'+value.netamount+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Enquiry #</td>';
						detailhtmldata+='<td>'+value.enqvocno+'</td>';
						detailhtmldata+='<td>Date</td>';
						detailhtmldata+='<td colspan="3">'+value.enqdate+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Current Status</td>';
						detailhtmldata+='<td colspan="5">'+value.currentstatus+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Lead Created by</td>';
						detailhtmldata+='<td colspan="5">'+value.leadcreation+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Quoted Created by</td>';
						detailhtmldata+='<td colspan="5">'+value.qotcreation+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>Job Created by</td>';
						detailhtmldata+='<td colspan="5">'+value.jobcreation+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>No. of days taken to quote</td>';
						detailhtmldata+='<td colspan="5">'+value.qotdaystaken+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>No. of days taken to create job</td>';
						detailhtmldata+='<td colspan="5">'+value.jobdaystaken+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td>No.of days till Enquiry created</td>';
						detailhtmldata+='<td colspan="5">'+value.enqdaystaken+'</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td colspan="6">';
						detailhtmldata+='<div class="panel panel-default">';
						detailhtmldata+='<div class="panel-heading">';
						detailhtmldata+='<h4 class="panel-title">';
						detailhtmldata+='<a data-toggle="collapse" href="#collapse'+key+'">Job Progress Details</a>';
						detailhtmldata+='</h4>';
						detailhtmldata+='</div>';
						detailhtmldata+='<div id="collapse'+key+'" class="panel-collapse collapse">';
						/*detailhtmldata+='<div class="panel-body">';*/
						detailhtmldata+='<table class="table">';
						detailhtmldata+='<thead>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<th>Sr.No</th>';
						detailhtmldata+='<th>Completion Date</th>';
						detailhtmldata+='<th>Install %</th>';
						detailhtmldata+='<th align="right" class="text-right">Install Amount</th>';
						detailhtmldata+='</tr>';
						detailhtmldata+='</thead>';
						detailhtmldata+='<tbody>';
						$.each( value.progressarray, function( arrkey, arrvalue ) {
							detailhtmldata+='<tr>';
							detailhtmldata+='<td>'+arrvalue.serial+'</td>';
							detailhtmldata+='<td>'+arrvalue.installdate+'</td>';
							detailhtmldata+='<td>'+arrvalue.installpercent+'</td>';
							detailhtmldata+='<td align="right">'+arrvalue.installamt+'</td>';
							detailhtmldata+='</tr>';
						});
						detailhtmldata+='</tbody>';
						detailhtmldata+='</table>';
						detailhtmldata+='</div>';
						detailhtmldata+='</div>';
						detailhtmldata+='</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='<tr>';
						detailhtmldata+='<td colspan="6">';
						detailhtmldata+='</td>';
						detailhtmldata+='</tr>';
						detailhtmldata+='</tbody>';
						detailhtmldata+='</table>';
						detailhtmldata+='</div>';
						detailhtmldata+='</div>';
					});
					//console.log(detailhtmldata);
					$('.detail-data').html($.parseHTML(detailhtmldata));
					$('.page-loader').hide();
				}
				else
				{
				}
			}
			x.open("GET","loadDetailData.jsp?todate="+todate+"&contracttype="+contracttype+"&salesman="+cmbsalesman+"&branch="+cmbbranch,true);
			x.send();
		}
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
	</script>
</body>
</html>