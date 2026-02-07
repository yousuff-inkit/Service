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
		 $("#searchadjdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 
	
	function loadSearch() {
 		var docno=document.getElementById("searchdocno").value;
 		var date=document.getElementById("searchdate").value;
 		var adjdate=document.getElementById("searchadjdate").value;
 		getdata(docno,date,adjdate);
	}
	
	function getdata(docno,date,adjdate){
	     var check=1;
		 $("#refreshdiv").load('subMasterSearch.jsp?docno='+docno+'&check='+check+'&date='+date+'&adjdate='+adjdate);
	}
</script>  

</head>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="10%"><div id="searchdate" ></div></td>
     <td width="15%" align="right">Adjust Date</td>
    <td width="10%"><div id="searchadjdate" ></div></td> 
    <td width="10%" align="right">Doc No</td>
    <td  width="10%"><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
    <tr>
    <td colspan="7"><div id="refreshdiv"><jsp:include page="subMasterSearch.jsp"></jsp:include></div></td>  
  </tr> 
   
   </table> 
</div> 
</body>
</html>