
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
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}


.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}


.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
input[type="text"],
select {
    width: 100%;
    height: 28px !important;   /* Slightly smaller */
    padding: 6px 10px;
    font-size: 13px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    box-sizing: border-box;
    background-color: #ffffff;
}

</style>

<script type="text/javascript">

$(document).ready(function () {

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#txtclientname').dblclick(function(){
	    	 
			  accountsSearchContent('clientAccountDetailsSearch.jsp');
		 });
	     $('#txtzone').dblclick(function(){
	    	 $('#zoneDetailsWindow').jqxWindow('open');
	    	 zoneSearchContent('zoneDetailsSearch.jsp');
		 });
	     $('#txtcontract').dblclick(function(){
		  	    $('#contractwindow').jqxWindow('open');
		   
		  	//  contractSearchContent('contractMastersearch.jsp');
		  	  contractSearchContent('contractDetailsSearch.jsp');
	 });
	     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#contractwindow').jqxWindow({width: '40%', height: '50%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#contractwindow').jqxWindow('close');
		  
		  $('#zoneDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Zone Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
			 $('#zoneDetailsWindow').jqxWindow('close');
		  
		  
 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	 
});

function funExportBtn(){
	/* JSONToCSVCon(projectlistexcel, 'Project List', true); */
	$("#loadgriddata").excelexportjs({
		containerid: "loadgriddata", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxloaddataGrid", 
		columns: getColumns("jqxloaddataGrid") , 
		worksheetName:"Project List"
		});
	   }



function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  }
	  
	 	 
	  
		   var barchval = document.getElementById("cmbbranch").value;
	 var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var rds=$('#ctype').val();
	 var contrctid= $("#trno").val();
	 var clientid=$('#txtclientaccountdocno').val();
	 var zoneid=$('#zoneid').val();
	
	 
	 $("#overlay, #PleaseWait").show();
	 $("#loadgriddata").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&rds="+rds+"&contrctid="+contrctid+"&clientid="+clientid+"&zoneid="+zoneid);
	
	  
	}

function getClientAccount(event){
	var rds=$('#ctype').val();
	if(rds=='ALL'){
		
	}
    var x= event.keyCode;
    if(x==114){
  	  accountsSearchContent('clientAccountDetailsSearch.jsp');
    }
    else{}
    }
function accountsSearchContent(url) {
	
 $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getcontract(event){

	   var contractType=document.getElementById("ctype").value;
	   var txtcontract=document.getElementById("txtcontract").value; 
	   
	   
		
	  
		var x= event.keyCode;
	 	 if(x==114){
	 		 $('#contractwindow').jqxWindow('open');
	 		// changeContent('contractMastersearch.jsp');  
	 		 contractSearchContent('contractDetailsSearch.jsp?contracttype='+contractType, $('#contractwindow'));
	    	 }
	 	 else{
	 		 
	 		 }
	 	 }
	    	 
	function contractSearchContent(url) {
		 $.get(url).done(function (data) {
		$('#contractwindow').jqxWindow('setContent', data);
	           	}); 
	 	}
	function getzone(event){

		  
		   
			var x= event.keyCode;
		 	 if(x==114){
		 		 $('#zoneDetailsWindow').jqxWindow('open');
		 		// changeContent('contractMastersearch.jsp');  
		 		 zoneSearchContent('zoneDetailsSearch.jsp')
		    	 }
		 	 else{
		 		 
		 		 }
		 	 }
		    	 
		function zoneSearchContent(url) {
			 $.get(url).done(function (data) {
			$('#zoneDetailsWindow').jqxWindow('setContent', data);
		           	}); 
		 	}
		function  funClearData(){
			 $('#txtclientname').val('');
			 $('#txtclientaccountdocno').val('');
			 $('#txtcontract').val('');
			 $('#txtzone').val('');
			 $('#acno').val('');
			 $('#trno').val('');
			 $('#zoneid').val('');
			 $('#jqxloaddataGrid').jqxGrid('clear');
			 $('#txtclientname').val('Press F3 To Search');
			 $('#txtcontract').val('Press F3 To Search');
			 $('#txtzone').val('Press F3 To Search');
			
			
		}	
	function getdesable(){
		$('#txtclientname').attr('disabled', true);
		$('#txtcontract').attr('disabled', true);
		$('#txtzone').attr('disabled', true);
	}
	function funundesable(){
		$('#txtclientname').attr('disabled', false);
		$('#txtcontract').attr('disabled', false);
		$('#txtzone').attr('disabled', false);
	}
</script>
</head>
<body onload="getBranch();getdesable();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

<!-- Fixed Header -->
<div class="sidebar-fixed-top">
<div class="filter-card">
<jsp:include page="../../heading.jsp"></jsp:include>
</div>
</div>

<!-- Scrollable Filters -->
<div class="sidebar-scroll-content">

<!-- Date & Type Section -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">From</td>
<td>
<div id="fromdate"
value='<s:property value="fromdate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">To</td>
<td>
<div id="todate"
value='<s:property value="todate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">Type</td>
<td>
<select id="ctype"
name="ctype"
onclick="funundesable();">
<option value="ALL">ALL</option>
<option value="AMC">AMC</option>
<option value="SJOB">SJOB</option>
</select>
</td>
</tr>

</table>
</div>

<!-- Client & Contract Section -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Client</td>
<td>
<input type="text"
id="txtclientname"
name="txtclientname"
readonly
placeholder="Press F3 to Search"
onkeydown="getClientAccount(event);"
value='<s:property value="txtclientname"/>'/>
<input type="hidden"
id="txtclientaccountdocno"
name="txtclientaccountdocno"
value='<s:property value="txtclientaccountdocno"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Contract No</td>
<td>
<input type="text"
id="txtcontract"
name="txtcontract"
readonly
placeholder="Press F3 To Search"
onkeydown="getcontract(event);"
value='<s:property value="txtcontract"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Assign Group</td>
<td>
<input type="text"
id="txtzone"
name="txtzone"
readonly
placeholder="Press F3 To Search"
onkeydown="getzone(event);"
value='<s:property value="txtzone"/>'/>
</td>
</tr>

</table>
</div>

<!-- Action Button -->
<div class="button-group">
<button type="button"
class="myButton"
onclick="funClearData();">
Clear
</button>
</div>

<!-- Hidden Fields -->
<input type="hidden" id="trno" name="trno"
value='<s:property value="trno"/>'/>

<input type="hidden" id="acno" name="acno"
value='<s:property value="acno"/>'/>

<input type="hidden" id="zoneid" name="zoneid"
value='<s:property value="zoneid"/>'/>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
<td>
<div id="loadgriddata">
<jsp:include page="gridDetails.jsp"></jsp:include>
</div>
</td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<!-- Popups -->
<div id="accountDetailsWindow"><div></div></div>
<div id="zoneDetailsWindow"><div></div></div>
<div id="contractwindow"><div></div></div>

</div>
</body>
</html>