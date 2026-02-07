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

 		var areas=document.getElementById("txtareas").value;
 		var cities=document.getElementById("txtcities").value;
 		var countries=document.getElementById("txtcountries").value;
 		var regions=document.getElementById("txtregions").value;
 		var chk = 1;
 		
		getdata(areas,cities,countries,regions,chk);
	}
	function getdata(areas,cities,countries,regions,chk){
		 $("#refreshareadiv").load('areaDetailsGrid.jsp?areas='+areas.replace(/ /g, "%20")+'&cities='+cities.replace(/ /g, "%20")+'&countries='+countries.replace(/ /g, "%20")+'&regions='+regions.replace(/ /g, "%20")+'&chk='+chk);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Area</td>
    <td width="43%"><input type="text" name="txtareas" id="txtareas" style="width:70%;" value='<s:property value="txtareas"/>'></td>
    <td width="6%" align="right">City</td>
    <td width="33%"><input type="text" name="txtcities" id="txtcities" style="width:70%;" value='<s:property value="txtcities"/>'></td>
    <td width="12%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Country</td>
    <td><input type="text" name="txtcountries" id="txtcountries" style="width:70%;" value='<s:property value="txtcountries"/>'></td>
    <td align="right">Region</td>
    <td><input type="text" name="txtregions" id="txtregions" style="width:70%;" value='<s:property value="txtregions"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshareadiv"><jsp:include page="areaDetailsGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>