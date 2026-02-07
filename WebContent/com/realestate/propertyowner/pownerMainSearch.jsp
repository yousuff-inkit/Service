 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
	
	$(document).ready(function () {}); 

 	function loadSearch() {
 		
 		var powner=document.getElementById("txtprimaryowner").value;
 		var ejarino=document.getElementById("txtejarino").value;
 		var vndmob=document.getElementById("txtmobile").value;
 		var vndtel=document.getElementById("txttelephone").value;

 		getdata(powner,ejarino,vndmob,vndtel);
	}
	function getdata(powner,ejarino,vndmob,vndtel){
		
		 $("#refreshdiv").load('pownerMainSearchGrid.jsp?powner='+powner.replace(/ /g, "%20")+'&ejarino='+ejarino+'&vndmob='+vndmob+'&vndtel='+vndtel);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="15%" align="right">Primary Owner</td>
    <td colspan="4"><input type="text" name="txtprimaryowner" id="txtprimaryowner" style="width:80%" value='<s:property value="txtprimaryowner"/>'></td>
    <td width="24%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Ejari No.</td>
    <td width="21%"><input type="text" name="txtejarino" id="txtejarino" value='<s:property value="txtejarino"/>'></td>
    <td width="7%" align="right">Mob No.</td>
    <td width="36%"><input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'></td>
    <td width="6%" align="right">Tel No.</td>
    <td><input type="text" name="txttelephone" id="txttelephone" value='<s:property value="txttelephone"/>'></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include  page="pownerMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>