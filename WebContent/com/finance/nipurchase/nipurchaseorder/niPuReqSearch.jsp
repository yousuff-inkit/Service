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
	  $("#nipureqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function niPuReqLoadSearch() {
 		var nipureqdate=document.getElementById("nipureqdate").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var requestedby=document.getElementById("reqbynipureq").value; 
 		var remarkreq=document.getElementById("remarkreq").value; 
 		var desc=document.getElementById("descnipureq").value; 
 		var orderdocno=document.getElementById("masterdoc_no").value; 
 		
		getdata1(msdocno,nipureqdate,requestedby,remarkreq,desc,orderdocno);
	}
 	
	function getdata1(msdocno,nipureqdate,requestedby,remarkreq,desc,orderdocno){
		var id=1;
		$("#refreshdivmas").load('niPuReqSearchGrid.jsp?msdocno='+msdocno+'&nipureqdate='+nipureqdate+'&requestedby='+requestedby+'&remark='+remarkreq+'&desc='+desc+'&orderdocno='+orderdocno+'&id='+id);
	}
	
	function loadnireq(){
		var orderdocno=document.getElementById("masterdoc_no").value; 
		var selectedrows=$("#niPuReqSearch").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
			$.messager.alert('Warning','Select documents.');
			return false;
		}
		
		var reqrefnoarr = [];
		var rownos='';
		for (i = 0; i < selectedrows.length; i++) {
			reqrefnoarr.push($('#niPuReqSearch').jqxGrid('getcellvalue',selectedrows[i],'voc_no'));
			rownos += $('#niPuReqSearch').jqxGrid('getcellvalue',selectedrows[i],'rowno')+',';			
		}     
		
		var unique = reqrefnoarr.filter(function(itm, i, reqrefnoarr) {
		    return i == reqrefnoarr.indexOf(itm);
		});
		
		$("#txtreqrefno").val(unique);
		
		rownos = rownos.substring(0,rownos.length - 1);
		
		$("#descdetail").load('descgridDetails.jsp?reftype=NRQ&nipurdoc='+orderdocno+'&rowno='+rownos);
		
		$('#window').jqxWindow('close');
	}

</script>

<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
    <tr>
    <td align="right" width="6%">Doc No</td>
    <td align="left" width="20%"><input type="text" name="msdocno" id="msdocno"  style="width:80%;" value='<s:property value="msdocno"/>'></td>
    <td align="right" width="7%">Requested By</td>
    <td align="left"><input type="text" name="reqbynipureq" id="reqbynipureq" style="width:100%;"  value='<s:property value="reqbynipureq"/>'></td>
    <td align="right" width="10%">Remark</td>
    <td  width="30%" colspan="4"><input type="text" name="remarkreq" style="width:100%;" id="remarkreq" value='<s:property value="remarkreq"/>'></td>
  <tr>
    
  <tr> 
    <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="nipureqdate" name="nipureqdate"  value='<s:property value="nipureqdate"/>'></div></td>
    <td align="right" width="10%">Description</td>
    <td  width="30%" colspan="4"><input type="text" name="descnipureq" style="width:100%;" id="descnipureq" value='<s:property value="descnipureq"/>'></td>
    <td  width="20%" align="center"><input type="button" name="nipureqbtnrasearch" id="nipureqbtnrasearch" class="myButton" value="Search"  onclick="niPuReqLoadSearch()"></td>
    <td  width="20%" align="center"><input type="button" name="btnloadnireq" id=""btnloadnireq"" class="myButton" value="Laod"  onclick="loadnireq()"></td>
  <tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="niPuReqSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>