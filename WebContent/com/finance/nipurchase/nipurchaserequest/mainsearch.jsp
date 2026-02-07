 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var datess=document.getElementById("datess").value;

 		var requestedbyss=document.getElementById("requestedbyss").value.replace(' ', '%20');
 		var descriptionss=document.getElementById("descriptionss").value.replace(' ', '%20');
		
 		var aa="yes";
		getdata(docnoss,requestedbyss,datess,descriptionss,aa);
	}
 	
	function getdata(docnoss,requestedbyss,datess,descriptionss,aa){
		
		 $("#refreshdivs").load('Subsearch.jsp?docnoss='+docnoss+'&requestedbyss='+requestedbyss+'&datess='+datess+'&descriptions='+descriptionss+'&aa='+aa);

	}

</script>

<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>
   <table width="100%" >
  <tr>
    <td align="right" width="6%">Doc No</td>
    <td align="left" width="20%"><input type="text" name="docnoss" id="docnoss"  style="width:80%;" value='<s:property value="docnoss"/>'></td>
    <td align="right" width="7%">Requested By</td>
    <td align="left"><input type="text" name="requestedbyss" id="requestedbyss" style="width:100%;"  value='<s:property value="accountss"/>'></td>
  <tr>
    
  <tr> 
    <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess" name="datess"  value='<s:property value="datess"/>'></div></td>
    <td align="right" width="10%">Remark</td><td  width="30%" colspan="4"><input type="text" name="descriptionss" style="width:100%;" id="descriptionss" value='<s:property value="descriptionss"/>'></td>
    <td  width="20%" align="center"><input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchs()"></td>
  <tr>
   
    </table>
    </td>
  </tr>
  <tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="Subsearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>