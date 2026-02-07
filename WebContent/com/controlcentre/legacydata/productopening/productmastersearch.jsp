  <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
	 
	});   
		   
 	function loadSearchs() {
 		
 	 
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var productnames=document.getElementById("productname").value;
 		 
 		var productname = productnames.replace(' ', '%20');

		
 		var aa="yes";
		getdata(docnoss,productname,aa);
 

	}
	function getdata(docnoss,productname,aa){
		
		 $("#refreshdivs").load('productSearch.jsp?docnoss='+docnoss+'&productname='+productname+'&aa='+aa);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
 
   <table width="100%" >
   <tr> 
    <td align="right" width="6%">Product Id</td> 
    <td align="left" width="20%"><input type="text" name="docnoss" id="docnoss"  style="width:90%;" value='<s:property value="docnoss"/>'></td>
    <td align="right" width="10%">Product Name</td>
    <td align="left"><input type="text" name="productname" id="productname" style="width:80%;"  value='<s:property value="productname"/>'></td>
     
     <td><input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchs()"></td>
     
     
    <tr>
    </table>
    
    
    <div id="refreshdivs">
      
   <jsp:include  page="productSearch.jsp"></jsp:include> 
   
   </div>
     
  </div>
</body>
</html>