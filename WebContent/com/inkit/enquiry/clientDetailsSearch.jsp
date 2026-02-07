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

 	function loadSearch() {

 		var clientsname=document.getElementById("txtclientsname").value;
 		var clientdetails=document.getElementById("txtclientdetails").value;
 		var chk = 1;
 		
		getdata(clientsname,clientdetails,chk);
	}
	function getdata(clientsname,clientdetails,chk){
		 $("#refreshclientdiv").load('clientDetailsGrid.jsp?clientsname='+clientsname.replace(/ /g, "%20")+'&clientdetails='+clientdetails.replace(/ /g, "%20")+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Name</td>
    <td width="77%"><input type="text" name="txtclientsname" id="txtclientsname" style="width:90%;" value='<s:property value="txtclientsname"/>'></td>
    <td width="16%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Contact</td>
    <td><input type="text" name="txtclientdetails" id="txtclientdetails" style="width:40%;" value='<s:property value="txtclientdetails"/>'></td>
  </tr>
  <tr>
    <td colspan="3"><div id="refreshclientdiv"><jsp:include page="clientDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>