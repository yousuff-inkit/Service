<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#fromdate,#todate').jqxDateTimeInput('setDate', new Date());
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemonthbefore=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', onemonthbefore);
     funChangeGroup();
});

function radioClick(){
 	if(document.getElementById("radiosum").checked){
 		$("#summaryDiv").prop("hidden", false);
		$("#detailDiv").prop("hidden", true);
		$("#cmbgroupby").prop("disabled", false);
		
	}else if(document.getElementById("radiodet").checked){
		$("#summaryDiv").prop("hidden", true);
		$("#detailDiv").prop("hidden", false);
		$("#cmbgroupby").prop("disabled", true);

	}
}

function funExportBtn(){
	if(document.getElementById("radiosum").checked){
		$("#summaryDiv").excelexportjs({
			containerid: "summaryGrid",
			datatype: 'json',
			dataset: null,
			gridId: "summaryGrid",
			columns: getColumns("summaryGrid"),
			worksheetName: "Skip Revenue Analysis Summary"
		});	
		
	}else if(document.getElementById("radiodet").checked){
		$("#detailDiv").excelexportjs({
			containerid: "detailGrid",
			datatype: 'json',
			dataset: null,
			gridId: "detailGrid",
			columns: getColumns("detailGrid"),
			worksheetName: "Skip Revenue Analysis Detail"
		});		
		
	}
}

function funreload(){
	var fromdate = $('#fromdate').jqxDateTimeInput('val');
	var todate = $('#todate').jqxDateTimeInput('val');
	var brhid = $('#cmbbranch').val();
	var groupby = $('#cmbgroupby').val();
	var topclschk = $("#hidtopclschk").val();    
	
	if(document.getElementById("radiosum").checked){
    	$("#summaryDiv").load("revenueanalysisGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&brhid="+brhid+"&topclschk="+topclschk+"&groupby="+groupby+"&id=1");
    	$('#overlay,#PleaseWait').show();
    	
	}else if(document.getElementById("radiodet").checked){
    	$("#detailDiv").load("revenueanalysisDetailGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&brhid="+brhid+"&id=1");
    	$('#overlay,#PleaseWait').show();
    	 
	}
}

function funClear(){
	$("#summaryGrid").jqxGrid('clear'); 
	$("#detailDiv").jqxGrid('clear'); 
	$('#fromdate,#todate').jqxDateTimeInput('setDate', new Date());
	var basedate=new Date($('#todate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(basedate).setMonth(basedate.getMonth()-1)); 
	$('#overlay,#PleaseWait').show();
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbefore);
}
function topclsCheck(){
	if(document.getElementById('topclschk').checked){
		  $("#hidtopclschk").val(1);
	}else{
		  $("#hidtopclschk").val(0);   
	}
	funreload();
}	
function funChangeGroup(){
	$("#summaryGrid").jqxGrid('clear');    
	if(document.getElementById("radiosum").checked){
		 var group = $("#cmbgroupby").val();
		 if(group=="CL"){
			 $("#topclschk").show();
			 $("#topclslbl").show();
		 }else{
			 $("#topclschk").hide();
			 $("#topclslbl").hide();
		 } 
	}else{
		 $("#topclschk").hide();
		 $("#topclslbl").hide();
	}
}	
</script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<div class='hidden-scrollbar'>
			<table width="100%" >
			<tr>
			<td width="20%" >
			    <fieldset style="background: #ECF8E0;">
					<table width="100%"  >
						<jsp:include page="../../heading.jsp"></jsp:include>
						<tr><td width="30%"  align="right" ><label class="branch">From Date</label></td>
							<td width="70%" align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
						</tr>
						<tr><td width="30%"  align="right" ><label class="branch">To Date</label></td>
							<td width="70%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
						</tr>
						
						<tr><td></td>
						<td> 
  							<input type="radio" id="radiosum"  data-toggle="tooltip" name="rdo" title="Summary" onclick="radioClick();" value="radiosum" checked="checked" ><label class="branch">Summary</label>  
          				</td></tr>
          				
          				<tr><td></td>
          				<td>
          				    <input type="radio" id="radiodet" data-toggle="tooltip" name="rdo" title="Detail" onclick="radioClick();" value="radiodet"><label class="branch">Detail</label>
        				</td></tr>  
        				
        				<tr><td width="30%"  align="right" ><label class="branch">Group By</label></td>
          				<td>
          				    <select  id="cmbgroupby" name="cmbgroupby" style="width:99%;" onchange="funChangeGroup();">       
			      				<option value="AC">Account</option><option value="CT">Contract Type</option><option value="SM">Salesman</option>
			      				<option value="SS">Skip Size</option><option value="WT">Waste Type</option><option value="OW">Ownership</option>
			      				<option value="CL">Client</option><option value="MO">Month</option>  
			      			</select>
        				</td></tr>  
        				<tr><td></td>
          				<td>
          				    <input type="checkbox" id="topclschk" name="topclschk" onclick="topclsCheck();"><label class="branch" id="topclslbl">Top 25 clients</label>
          				    <input type="hidden" id="hidtopclschk" name="hidtopclschk">   
        				</td></tr> 
						<tr><td colspan="2"><br><br><br><br><br><br><br><br><br><br><br><br></td></tr>
					</table>
				</fieldset>
			</td>
			<td width="40">
				<table width="100%">
					<tr><td>
					<div id="summaryDiv"><jsp:include page="revenueanalysisGrid.jsp"></jsp:include></div>
					<div id="detailDiv" hidden="true"><jsp:include page="revenueanalysisDetailGrid.jsp"></jsp:include></div>
					</td></tr>
				</table>
			</td>
			</tr>
			</table>
		</div>
	</div>
</body>
</html>