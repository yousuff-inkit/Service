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

 		var docno=document.getElementById("txtspecificationsdocno").value;
 		var service=document.getElementById("txtspecificationsservice").value;
 		var discipline=document.getElementById("txtspecificationsdiscipline").value;
 		var comodities=document.getElementById("txtspecificationscomodities").value;
 		var chk = 1;
 		
		getdata(docno,service,discipline,comodities,chk);
	}
	function getdata(docno,service,discipline,comodities,chk){
		 $("#refreshspecdiv").load('specificationDetailGrid.jsp?docno='+docno+'&service='+service.replace(/ /g, "%20")+'&discipline='+discipline.replace(/ /g, "%20")+'&comodities='+comodities.replace(/ /g, "%20")+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Doc No</td>
    <td width="43%"><input type="text" name="txtspecificationsdocno" id="txtspecificationsdocno" style="width:70%;" value='<s:property value="txtspecificationsdocno"/>'></td>
    <td width="6%" align="right">Service</td>
    <td width="33%"><input type="text" name="txtspecificationsservice" id="txtspecificationsservice" style="width:70%;" value='<s:property value="txtspecificationsservice"/>'></td>
    <td width="12%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Discipline</td>
    <td><input type="text" name="txtspecificationsdiscipline" id="txtspecificationsdiscipline" style="width:70%;" value='<s:property value="txtspecificationsdiscipline"/>'></td>
    <td align="right">Commodities</td>
    <td><input type="text" name="txtspecificationscomodities" id="txtspecificationscomodities" style="width:70%;" value='<s:property value="txtspecificationscomodities"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshspecdiv"><jsp:include page="specificationDetailGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>