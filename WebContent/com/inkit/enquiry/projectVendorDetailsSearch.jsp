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
	$(document).ready(function () {
		var value = '<%=vendortype%>';
		document.getElementById("txtprojectsvendortype").value=value;
	}); 

 	function loadProjectVendorSearch() {

 		var projectsvendorname=document.getElementById("txtprojectsvendorname").value;
 		var projectsvendortype=document.getElementById("txtprojectsvendortype").value;
 		var chk = 1;
 		
		getdata(projectsvendorname,projectsvendortype,chk);
	}
	function getdata(projectsvendorname,projectsvendortype,chk){
		 $("#refreshprojectsvendordiv").load('projectVendorDetailsGrid.jsp?projectsvendorname='+projectsvendorname.replace(/ /g, "%20")+'&vendortype='+projectsvendortype+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td width="68%"><input type="text" name="txtprojectsvendorname" id="txtprojectsvendorname" style="width:90%;" value='<s:property value="txtprojectsvendorname"/>'>
    <input type="hidden" name="txtprojectsvendortype" id="txtprojectsvendortype" style="width:90%;" value='<s:property value="txtprojectsvendortype"/>'></td>
    <td width="26%" align="center"><input type="button" name="btnprojectvendorsearch" id="btnprojectvendorsearch" class="myButton" value="Search"  onclick="loadProjectVendorSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshprojectsvendordiv"><jsp:include page="projectVendorDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>