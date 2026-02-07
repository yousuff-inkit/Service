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
	 $("#issueddate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#issuedtime").jqxDateTimeInput({ width: '50%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	 getCompanyCode();
	}); 
	
	function getCompanyCode() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var companyItems = items[0].split(",");
  				var companyIdItems = items[1].split(",");
  				var optionstype = '<option value="">--Select--</option>';
  				for (var i = 0; i < companyItems.length; i++) {
  					optionstype += '<option value="' + companyIdItems[i] + '">'
  							+ companyItems[i] + '</option>';
  				}
  				$("select#cmbcompanyname").html(optionstype);
  			} else {
  			}
  		}
  		x.open("GET", "getCompany.jsp", true);
  		x.send();
  	}

 	function loadSearch() {
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("issueddate").value;
 		var issuedstatus=document.getElementById("cmbissuestatus").value;
 		var companyname=document.getElementById("cmbcompanyname").value;
 		var issuedtime=document.getElementById("issuedtime").value;
	    
		getdata(docNo,date,issuedstatus,companyname,issuedtime);
	}
 	
	function getdata(docNo,date,issuedstatus,companyname,issuedtime){
		 $("#refreshdivs").load("esdMainSearchGrid.jsp?docNo="+docNo+"&date="+date+"&issuedstatus="+issuedstatus+"&companyname="+companyname+"&issuedtime="+issuedtime+"&check=1");
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="16%"><div id="issueddate" name="issueddate"  value='<s:property value="issueddate"/>'></div>
        <input type="hidden" name="hidissueddate" id="hidissueddate" value='<s:property value="hidissueddate"/>'></td>
    <td colspan="2" align="right">Doc No</td>
    <td width="29%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="17%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Status</td>
    <td><select id="cmbissuestatus" name="cmbissuestatus" value='<s:property value="cmbissuestatus"/>'>
      <option value="">--Select--</option>
      <option value=1>Open</option>
      <option value=2>Pending</option>
      <option value=0>Closed</option></select></td>
    <td width="9%" align="right">Company</td>
    <td width="21%"><select id="cmbcompanyname" name="cmbcompanyname" style="width:73%;" value='<s:property value="cmbcompanyname"/>'>
      <option></option></select></td>
    <td align="right">Time</td>
    <td><div id="issuedtime" name="issuedtime"></div></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdivs"><jsp:include page="esdMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>