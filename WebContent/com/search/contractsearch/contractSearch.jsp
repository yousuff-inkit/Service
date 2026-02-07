 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
   <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>    --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
<% String type=request.getParameter("type")==null || request.getParameter("type")==""?"0":request.getParameter("type").trim().toString();   %>
	<script type="text/javascript">      
	$(document).ready(function () {  
		/* $('#contractWindow').jqxWindow({ width: '65%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#contractWindow').jqxWindow('close');   This for search window size reference */   
	}); 

 	function loadSearch() {
 		var type = '<%=type%>';   
 		var clname = $('#Cl_name').val();     
 		//clname = clname.replace(' ', '%20');     
 		var docno = $('#Cl_docno').val();  
 		var refno = $('#Cl_refno').val();
 		var qty = $('#Cl_qty').val();
 		var site = $('#Cl_site').val();
 		var area = $('#Cl_area').val();
 		var skipsize = $('#Cl_skipsize').val();  
		getdata(clname, docno, type, refno, qty, site, area, skipsize);  
	}
	function getdata(clname, docno, type, refno, qty, site, area, skipsize){   
		 var id=1;
		 $("#refreshdiv1").load(<%=contextPath+"/"%>+'com/search/contractsearch/searchContract.jsp?clname='+encodeURIComponent(clname)+'&docno='+docno+'&type='+type+'&id='+id+'&refno='+encodeURIComponent(refno)+'&site='+encodeURIComponent(site)+'&area='+encodeURIComponent(area)+'&skipsize='+encodeURIComponent(skipsize)+'&qty='+qty);          
	}   
	</script>
<body bgcolor="#E0ECF8">   
<div id=search>
<table width="100%" >
  <tr >
   <td>
	   <table>
		   <tr>
			    <td align="right" width="7%">Doc No</td>     
			    <td align="left" width="25%"><input type="text" name="Cl_docno" id="Cl_docno" style="width:96.5%;" value='<s:property value="Cl_docno"/>'></td> 
			    <td align="right" width="5%">Name</td>    
			    <td align="left" width="30%"><input type="text" name="Cl_name" id="Cl_name"  style="width:96.5%;" value='<s:property value="Cl_name"/>'></td>
			    <td align="right" width="8%">Ref No</td>   
			    <td align="left" width="10%"><input type="text" name="Cl_refno" id="Cl_refno" value='<s:property value="Cl_refno"/>'></td> 
			    <td align="right" width="5%">Qty</td>     
			    <td align="left" width="5%"><input type="text" name="Cl_qty" id="Cl_qty" value='<s:property value="Cl_qty"/>'></td>   
		   </tr>   
		   <tr>
			    <td align="right" width="7%">Site</td>     
			    <td align="left" width="25%"><input type="text" name="Cl_site" id="Cl_site"  style="width:96.5%;" value='<s:property value="Cl_site"/>'></td>
			    <td align="right" width="5%">Area</td>   
			    <td align="left" width="30%"><input type="text" name="Cl_area" id="Cl_area" style="width:96.5%;" value='<s:property value="Cl_area"/>'></td>  
			    <td align="right" width="8%">Skip Size</td>      
			    <td align="left" width="10%"><input type="text" name="Cl_skipsize" id="Cl_skipsize" value='<s:property value="Cl_skipsize"/>'></td>  
			    <td colspan="2" align="center" width="5%"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
		   </tr>      
	   </table>      
    </td>
  </tr>  
  <tr>
    <td colspan="8" align="right">
    <div id="refreshdiv1">
   <jsp:include  page="searchContract.jsp"></jsp:include>       
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>