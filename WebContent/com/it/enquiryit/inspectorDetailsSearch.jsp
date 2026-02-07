<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
<%int vendortype =request.getParameter("vendortype")==null?0:Integer.parseInt(request.getParameter("vendortype").trim());%>
 
<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadInspectorSearch() {

 		var inspectorname=document.getElementById("txtinspectorname").value;
 		var specdocno=document.getElementById("txttempspecdocno").value;
 		var chk = 1;
 		
		getdata(inspectorname,specdocno,chk);
	}
	function getdata(inspectorname,specdocno,chk){
		 $("#refreshinspectordiv").load('inspectorDetailsGrid.jsp?inspectorname='+inspectorname.replace(/ /g, "%20")+'&specdocno='+specdocno+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td width="68%"><input type="text" name="txtinspectorname" id="txtinspectorname" style="width:90%;" value='<s:property value="txtinspectorname"/>'></td>
    <td width="26%" align="center"><input type="button" name="btninspectorsearch" id="btninspectorsearch" class="myButton" value="Search"  onclick="loadInspectorSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshinspectordiv"><jsp:include page="inspectorDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>