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

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadProjectOwnerSearch() {

 		var projectsownername=document.getElementById("txtprojectsownername").value;
 		var chk = 1;
 		
		getdata(projectsownername,chk);
	}
	function getdata(projectsownername,chk){
		 $("#refreshprojectsownerdiv").load('projectOwnerDetailsGrid.jsp?projectsownername='+projectsownername.replace(/ /g, "%20")+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td width="68%"><input type="text" name="txtprojectsownername" id="txtprojectsownername" style="width:90%;" value='<s:property value="txtprojectsownername"/>'></td>
    <td width="26%" align="center"><input type="button" name="btnprojectownersearch" id="btnprojectownersearch" class="myButton" value="Search"  onclick="loadProjectOwnerSearch();"></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshprojectsownerdiv"><jsp:include page="projectOwnerDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>