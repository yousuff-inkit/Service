 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#surdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function loadSearch() {
 		var surdate=document.getElementById("surdate").value;
 		var Cl_namess=document.getElementById("Cl_names").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ','%20');
 		
	    getdata1(Cl_names,msdocno,surdate);
	}
	function getdata1(Cl_names,msdocno,surdate){
		 var id=1;
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&surdate='+surdate+'&id='+id);
	}  

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
   <table width="100%">   
     <tr>
	    <td align="right" width="5%">Date</td>
	    <td width="5%"><div id="surdate" name="surdate"  value='<s:property value="surdate"/>'></div></td>
	    <td width="5%" align="right">Doc No</td>
	    <td width="14%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
	    <td width="4%" align="right" >Client</td> 
	    <td width="25%"><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
        <td align="center" width="4%"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch()"></td>
     </tr>   
     <tr>      
        <td align="center" colspan="14"><div id="refreshdivmas"><jsp:include  page="subMastersearch.jsp"></jsp:include></div></td>
     </tr>
</table>
  </div>
</body>
</html>