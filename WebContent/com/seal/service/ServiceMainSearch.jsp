<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function () {
	 $("#searchdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 
	
	
	function loadSearch() {
 		var docno=document.getElementById("searchdocno").value;
 		var date=document.getElementById("searchdate").value;
 		var service=document.getElementById("searchservice").value;
 		service=service.replace(/ /g, "%20");
 		getdata(docno,date,service);
	}
	function getdata(docno,date,service){
	var check=1;
		 $("#refreshdiv").load('servicemaingrid.jsp?docno='+docno+'&check='+check+'&date='+date+'&service='+service);
	}

	
</script>

</head>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="43%"><div id="searchdate" ></div></td>
    <td width="9%" align="right">Doc No</td>
    <td  width="20%"><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td align="right">Service</td>
  <td colspan="3"><input type="text" name="searchservice" id="searchservice" style="width:94%;" value='<s:property value="searchservice"/>'></td>
   </tr>
    <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="servicemaingrid.jsp"></jsp:include></div></td>
  </tr> 
   
   </table> 
</div> 
</body>
</html>