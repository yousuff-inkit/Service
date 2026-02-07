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
	$(document).ready(function () {
	 $("#correctiondate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("correctiondate").value;
 		var formname=document.getElementById("txtform").value;
 		var empname=document.getElementById("txtemployee").value;
	
		getdata(docNo,date,formname,empname);
	}
	function getdata(docNo,date,formname,empname){
		 $("#refreshdiv").load('ewdMainSearchGrid.jsp?docNo='+docNo+'&date='+date+'&formname='+formname.replace(/ /g, "%20")+'&empname='+empname.replace(/ /g, "%20"));
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="correctiondate" name="correctiondate"  value='<s:property value="correctiondate"/>'></div>
        <input type="hidden" name="hidcorrectiondate" id="hidcorrectiondate" value='<s:property value="hidcorrectiondate"/>'></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtemployee" id="txtemployee" style="width:100%" value='<s:property value="txtemployee"/>'></td>
    <td align="right">Form Name</td>
    <td><input type="text" name="txtform" id="txtform" value='<s:property value="txtform"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="ewdMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>