 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<% String type = request.getParameter("type")==null?"1":request.getParameter("type"); %>
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
	var type=<%=type%>;
	
	$(document).ready(function () {}); 

 	function loadContractSearch() {
 		var contractno=document.getElementById("txtcontractsno").value;
 		
 	   	var monthdate = new Date($('#monthdate').jqxDateTimeInput('getDate'));
		$("#hidmonthdate").jqxDateTimeInput('setDate', new Date(monthdate));
		var todate = $("#hidmonthdate").val();
 		var check=1;

 		getdata(contractno,todate,check);
	}
 	
	function getdata(contractno,todate,check){
		 $("#refreshcontractdiv").load('contractDetailsSearchGrid.jsp?type='+type+'&todate='+todate+'&contractno='+contractno.replace(/ /g, "%20")+'&check='+check);
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="20%" align="left"><label style="background-color:transparent;font:10px Tahoma;">Contract No.</label>
    <input type="text" name="txtcontractsno" id="txtcontractsno" style="height:20px;"   value='<s:property value="txtcontractsno"/>'></td>
    
    <td width="16%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadContractSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshcontractdiv"><jsp:include page="contractDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>