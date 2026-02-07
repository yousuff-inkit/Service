<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">    
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript">

$(document).ready(function () {
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  $("body").prepend("<div id='PleaseWaitSub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");
	  $("#expdate").jqxDateTimeInput({ width: '110px', height: '18px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
	  $("#todate").jqxDateTimeInput({ width: '110px', height: '18px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
		    
});

function funreload(event){
	  $('#overlay,#PleaseWait').show();
	  var brhid = $("#cmbbranch").val();
	  var todate = $("#todate").val();
	  $("#jqxinvdetGrid").jqxGrid('clear');     
	  $("#invdiv").load("contractrenewalGrid.jsp?id="+1+"&brhid="+brhid+"&todate="+todate);   
}
   
function funExportBtn(){
	$("#invdiv").excelexportjs({
		containerid: "invdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxinvGrid", 
		columns: getColumns("jqxinvGrid") ,   
		worksheetName:"Contract Renewal"
		}); 
	 $("#detdiv").excelexportjs({
		containerid: "detdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxinvdetGrid", 
		columns: getColumns("jqxinvdetGrid") ,   
		worksheetName:"Contract Renewal"
		});    
}  
 
 function funupdate(){
	 var expdate = $("#expdate").val();
	 var expdesc = $("#expdesc").val();
	 var trno = $("#hidtrno").val();
	 expdesc = expdesc.replace(/(\r\n|\n|\r)/gm, " ");    
	 expdesc = removeSplCharacters(expdesc);   
	 if(trno=="" || trno=="0"){
		 $.messager.alert('Warning','Please select a document!');    
		 return false;  
	 }
	 $.messager.confirm('Confirm', 'Do you want to update Expiry Date?', function(r){
			if(r==false) {
				return false; 
			} else {
				$("#overlay, #PleaseWait").show();
				saveData(trno, expdate, expdesc);     
			}  
      });
 }
function saveData(trno, expdate, expdesc, todate){  
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){  
			var items = x.responseText.split('####');
			 $("#overlay, #PleaseWait").hide();
			 funreload(event);
			 $("#expdate").val(new Date());
			 $("#expdesc").val('');  
			if(parseInt(items[0])>0){ 
			      $.messager.alert('Message',' Successfully updated','success');
			}else{
				  $.messager.alert('Message','Not updated','warning');               
			}    
		}  
	}  
	x.open("GET","saveData.jsp?trno="+trno+"&expdate="+expdate+"&expdesc="+encodeURIComponent(expdesc),true);                                
	x.send();    
}
</script>
</head>
<body onload="getBranch();"> 
<form>
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
 <fieldset style="background: #ECF8E0;">
		<table width="100%"  >
	     <jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td>&nbsp;</td></tr>  
	<tr>  <td width="6%" align="right"><label class="branch">Upto Date</label></td>
		    <td width="25%" align="left"><div id="todate" name="todate"></div></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td colspan="2"><fieldset>
	    <table width="100%">
	    <tr>
		    <td width="5%" align="right"><label class="branch">Expiry Date</label></td>
		    <td width="25%" align="left"><div id="expdate" name="expdate"></div></td>   
	    </tr>
	    <tr>
		    <td width="5%" align="right"><label class="branch">Description</label></td>  
		    <td width="25%" align="left"><textarea id="expdesc" name="expdesc" rows="4"></textarea></td>
	    </tr>    
	    <tr>
	        <td align="center" colspan="2"><input type="button" id="btnupdate" name="btnupdate" class="myButton" onclick="funupdate();" value="Update"></td>
	    </tr>  
	    <tr><td>&nbsp;</td></tr>
	    </table>
	    <tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	</fieldset></td></tr>
	<tr><td>
	<input type="hidden" id="hidtrno" name="hidtrno">
	<input type="hidden" id="hiddocno" name="hiddocno">
	<input type="hidden" id="detaildesc" name="detaildesc">
	<input type="hidden" id="txtvalidation" name="txtvalidation">  
	<!-- <input type="hidden" id="hidpayterms" name="hidpayterms">   -->      
	<!-- <input type="hidden" id="hiddelterms" name="hiddelterms">    -->     
	</td></tr>  
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	
	</table>
</fieldset>  	
</td>
<td width="80%">    
	<table width="100%"> 
	    <tr><td>
	       <div id="invdiv"><jsp:include page="contractrenewalGrid.jsp"></jsp:include></div>
	    </td></tr>
	    <tr><td>
	       <div id="detdiv"><jsp:include page="contractrenewaldetailGrid.jsp"></jsp:include></div>
	    </td></tr>   
	</table>
</td>
</tr>
</table>
</div>
</div>
</form>
</body>
</html>