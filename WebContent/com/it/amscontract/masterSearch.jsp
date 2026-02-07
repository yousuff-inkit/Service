<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title> 

<script type="text/javascript">
	
	$(document).ready(function () {}); 

 	function mainloadSearch() {
 		var brcid=document.getElementById("brchName").value;
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var dno=document.getElementById("dno").value;
 		var RefNo=document.getElementById("refno").value;
 		var id=1;
 		
 		getdata(brcid,sclname,smob,dno,RefNo,id);
	}
 	
	function getdata(brcid,sclname,smob,dno,RefNo,id){
		 $("#srefreshdiv").load('submainSearch.jsp?brcid='+brcid+'&sclname='+sclname.replace(/ /g, "%20")+'&smob='+smob.replace(/ /g, "%20")+'&dno='+dno+'&RefNo='+RefNo.replace(/ /g, "%20")+'&id='+id);
	} 
 
</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    <td width="9%" align="right">Client Name</td>
    <td width="41%"><input type="text" name="SCl_name" id="SCl_name"  style="width:96.5%;" value='<s:property value="SCl_name"/>'></td>
    <td width="7%" align="right">Doc No</td>
    <td width="31%"><input type="text" name="dno" id="dno" value='<s:property value="dno"/>'>
    <td width="12%" rowspan="2" align="center"><input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Mobile</td>
    <td><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
    <td align="right">Ref No</td>
    <td><input type="text" name="refno" id="refno" style="width:96.5%;" value='<s:property value="refno"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="srefreshdiv"><jsp:include  page="submainSearch.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>