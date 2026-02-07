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
	  $("#invdate").jqxDateTimeInput({ width: '110px', height: '18px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
	  $("#todate").jqxDateTimeInput({ width: '110px', height: '18px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
		    
});

function funreload(event){
	  $('#overlay,#PleaseWait').show();
	  var brhid = $("#cmbbranch").val();
	  var todate = $("#todate").val();
	  $("#nidescdetailsGrid").jqxGrid('clear');     
	  $("#invdiv").load("invporcessingGrid.jsp?id="+1+"&brhid="+brhid+"&todate="+todate);   
}
   
function funExportBtn(){
	$("#invdiv").excelexportjs({
		containerid: "invdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxinvGrid", 
		columns: getColumns("jqxinvGrid") ,   
		worksheetName:"Service Sale Creation"
		}); 
}  
 
 function funGenerate(){
	 var invdate = $("#invdate").val();
	 var invno = $("#invno").val();
	 var invdesc = $("#invdesc").val();
	 var trno = $("#hiddocno").val();
	 var todate = $("#todate").val();
	 var payterms = removeSplCharacters($("#payterms").val());   
	 var delterms = removeSplCharacters($("#delterms").val());
	 invdesc = invdesc.replace(/(\r\n|\n|\r)/gm, " ");   
	 invdesc = removeSplCharacters(invdesc);   
	 if(trno=="" || trno=="0"){
		 $.messager.alert('Warning','Please select a document!');    
		 return false;  
	 }
	 if(invno=="" || invno=="0"){
		 $.messager.alert('Warning','Please enter PO NO!'); 
		 return false;  
	 }
	 var chkinvdt = $("#invdate").jqxDateTimeInput('getDate');   
	 var datecheck = funDateInPeriodNew(chkinvdt); 
	 if(parseInt(datecheck)!=1){      
		 return false;  
	 } 
	 $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
			if(r==false) {
				return false; 
			} else {
				$("#overlay, #PleaseWait").show();   
				saveData(trno, invdate, invno, invdesc, todate, payterms, delterms); 
			}  
      });
 }
function saveData(trno, invdate, invno, invdesc, todate, payterms, delterms){     
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){  
			var items = x.responseText.split('####');
			 $("#overlay, #PleaseWait").hide();
			 funreload(event);
			 $("#invdate").val(new Date());
			 $("#invno").val('');
			 $("#payterms").val('');
			 $("#invdesc").val('');  
			 $("#delterms").val('');  
			if(parseInt(items[0])>0){ 
			      $.messager.alert('Message','SRS - '+items[1]+' Successfully Generated','success');
			}else{
				  $.messager.alert('Message','Not Generated','warning');               
			}    
		}  
	}  
	x.open("GET","saveData.jsp?trno="+trno+"&todate="+todate+"&invdate="+invdate+"&invno="+invno+"&invdesc="+encodeURIComponent(invdesc)+"&payterms="+encodeURIComponent(payterms)+"&delterms="+encodeURIComponent(delterms),true);                        
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
		    <td width="5%" align="right"><label class="branch">Date</label></td>
		    <td width="25%" align="left"><div id="invdate" name="invdate"></div></td>
	    </tr>
	    <tr>
		    <td width="5%" align="right"><label class="branch">PO NO</label></td>    
		    <td width="25%" align="left"><input type="text" id="invno" name="invno" style="width:99.7%;height:20px;"></td>    
	    </tr>
	       <tr>
		    <td width="5%" align="right"><label class="branch">Pay Terms</label></td>    
		    <td width="25%" align="left"><input type="text" id="payterms" name="payterms" style="width:99.7%;height:20px;"></td>
	    </tr>  
	     <tr>  
		    <td width="5%" align="right"><label class="branch">Del Terms</label></td>      
		    <td width="25%" align="left"><input type="text" id="delterms" name="delterms" style="width:99.7%;height:20px;"></td>
	    </tr>   
	    <tr>
		    <td width="5%" align="right"><label class="branch">Description</label></td>  
		    <td width="25%" align="left"><textarea id="invdesc" name="invdesc" rows="4"></textarea></td>
	    </tr>    
	    <tr>
	        <td align="center" colspan="2"><input type="button" id="btngenerate" name="btngenerate" class="myButton" onclick="funGenerate();" value="Generate"></td>
	    </tr>      
	    </table>
	</fieldset></td></tr>
	<tr><td><input type="hidden" id="hiddocno" name="hiddocno">
	<input type="hidden" id="hidpayterms" name="hidpayterms">        
	<input type="hidden" id="hiddelterms" name="hiddelterms"> </td></tr>    
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	
	</table>
</fieldset>  	
</td>
<td width="80%">
	<table width="100%"> 
	    <tr><td>
	       <div id="invdiv"><jsp:include page="invporcessingGrid.jsp"></jsp:include></div>
	    </td></tr>
	      <tr><td> 
	       <div id="detdiv"><jsp:include page="invdetailGrid.jsp"></jsp:include></div>
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