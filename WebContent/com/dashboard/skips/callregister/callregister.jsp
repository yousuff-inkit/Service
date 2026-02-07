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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
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
#contractdetlbl{
   color: #2b45ed;
    font-weight: bold;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  $("#date").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy"});    
	  $("#time").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
	  $('#contractDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Contract Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#contractDetailsWindow').jqxWindow('close');
	  $('#txtcontract').dblclick(function(){     
		  contractSearchContent('contractSeacrh.jsp');     
	  });
	  $('#time').val(new Date());  
});
function contractSearchContent(url) {
 	$('#contractDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
    });    
}
function getContract(event){    
    var x= event.keyCode;
    if(x==114){
		    contractSearchContent('contractSeacrh.jsp');      
    }
    else{}
}
function funExportBtn(){  
	$("#cregdiv").excelexportjs({
		containerid: "cregdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxCallRegisterGrid", 
		columns: getColumns("jqxCallRegisterGrid") ,    
		worksheetName:"Call Register"   
		}); 
 } 

function funreload(event){
	 var barchval = document.getElementById("cmbbranch").value; 
	 $("#overlay, #PleaseWait").show();  
	 $("#cregdiv").load("callregisterGrid.jsp?barchval="+barchval+"&id="+1);     
 }   

function funClear(){   
	 $("#jqxCallRegisterGrid").jqxGrid('clear'); 
	 document.getElementById("jqxcontract").value="";
	 document.getElementById("contrno").value="";  
	 $('#date').val(new Date());
	 $('#time').val(new Date());
	 $('#jqxwastetype').val('');  
	 $('#wasteid').val('');  
	 $('#wastename').val(''); 
	 $('#jqxcontract').attr('placeholder', 'Enter Contract No');
	 $('#jqxwastetype').attr('placeholder', 'Enter Wastetype');
	 document.getElementById("contractdetlbl").innerHTML=""; 
 }

function funUpdate(){  
	var contrno=document.getElementById("contrno").value;
	var date =  $('#date').val();
	var time = $('#time').val();
	var wastetype = $('#jqxwastetype').val();    
	var wasteid = $('#wasteid').val(); 
	var wastename = $('#wastename').val();   
	if(contrno==''){
		$.messager.alert('Message','Please select a contract.','warning'); 
		    return false;  
	 }
	if(wastetype==''){  
		$.messager.alert('Message','Please Enter Waste Type.','warning');  
		    return false;  
	 }
	$.messager.confirm('Message', 'Do you want to update?', function(r){
	 			if(r==false) {
	 				return false; 
	 			} else {
	 				saveDetails(contrno, date, time, wastename, wasteid);         
	 			}
    });   
}
function saveDetails(contrno, date, time, wastetype, wasteid){              
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){  
			var items=x.responseText;
				 if(parseInt(items)>0){  
					 $.messager.alert('Message','Successfully Updated','success');
					 funClear();
					 $("#jqxcontract").focus();
					 funreload(event);
					}else{
						$.messager.alert('Message','Not Updated','warning');  
					} 
			}  
	}  
x.open("GET","saveData.jsp?wastetype="+encodeURIComponent(wastetype)+"&contrno="+contrno+"&date="+date+"&time="+time+"&wasteid="+wasteid,true);       
x.send();  
}
</script>
</head>
<body onload="getBranch();">
<form autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"> 
	<jsp:include page="../../heading.jsp"></jsp:include>   
	 <tr><td colspan="2">&nbsp;</td></tr>
 	 <tr><td colspan="2">&nbsp;</td></tr>  
    <tr><td colspan="2"><label class="branch" id="contractdetlbl"></label></td></tr>    
    <tr><td align="right" width="27%"><label class="branch">Contract No</label></td>  
	<td align="left" width="73%"><div id="contractno" onkeydown="return (event.keyCode!=13);"><jsp:include page="contractSearch.jsp"></jsp:include></div>
    <input type="hidden" id="contrno" name="contrno" value='<s:property value="contrno"/>'/></td></tr>    
     <tr><td align="right" width="27%"><label class="branch">Date</label></td>  
	<td align="left" width="73%"><div id='date'></div></td></tr>    
     <tr><td align="right" width="27%"><label class="branch">Time</label></td>  
	<td align="left" width="73%"><div id="time"></div></td></tr> 
	 <tr><td align="right" width="27%"><label class="branch">Waste Type</label></td>    
		<td align="left" width="73%"><div id="wastetype" onkeydown="return (event.keyCode!=13);"><jsp:include page="wastetypeSearch.jsp"></jsp:include></div>
       <input type="hidden" id="wasteid" name="wasteid" value='<s:property value="wasteid"/>'/>
       <input type="hidden" id="wastename" name="wastename" value='<s:property value="wastename"/>'/></td></tr>                 
	<tr><td colspan="2" align="center"> <input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Update" onclick="funUpdate();"> </td></tr> 
	 <tr> <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClear();"></td> </tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
	<input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno">
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="cregdiv"><jsp:include page="callregisterGrid.jsp"></jsp:include></div></td>      
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clinfowindow">
   <div ></div>
</div> 
<div id="contractDetailsWindow">
	<div></div><div></div>
</div>
</div>
</form>
</body>
</html>