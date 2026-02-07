<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
 hr { 
   border-top: 1px solid #e1e2df  ;
    
    }
#maintbl th{
 background-color: #ffece5;
} 
#hddiv{
background-color: #ffece5;
}

#tabeltotal{
	font-size: 12px;
}   

</style> 
  
<script>

$(document).ready(function () {
	
	/* document.getElementById("image").style.display = "none"; */
	/*  */
	
	
});

function load(){
	
	var logss=document.getElementById("logo").value;
	/* alert(logss); */
	if(logss==1){
		$('#image').show();
	}
	else{
		$('#image').hide();
		document.getElementById("cmpnme").style.display = "none";
		document.getElementById("lblcompaddress").style.display = "none";
		document.getElementById("tel").style.display = "none";
		document.getElementById("fax").style.display = "none";
	}
}

</script>
</head>

<body style="font-size:10px; font-family:arial;"  bgcolor="white" onload="load();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 

 <div style="background-color:white;" >
 
 
<table width="100%" class="normaltable"  >
	
  <tr >
    <td width="30%" rowspan="6">   <div id="image"><img  src="<%=contextPath%>/icons/epic.jpg" width="100%" height="91"  alt=""/></div> </td>
    <td width="38%" rowspan="2">&nbsp;</td>
    <td width="32%" ><font style="font-size: 15.5px;" id="cmpnme"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font>&nbsp;</td>
  </tr>
 <%--  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2"  align="center" style="vertical-align: bottom;"><b><font size="5"><label id="lblprintname" name="lblprintname">  </label></font></b></td>
    <td align="left"><font id="tel"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></font>&nbsp;</td>
  </tr>
  <tr>
    <td align="left"><font id="fax"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></font>&nbsp;</td>
  </tr> --%>
   <tr>
    <td  align="center"><b><font size="5"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/>MANAGEMENT REPORTS</label></font></b></td>
    
  </tr>
  <%-- <tr><td  align="center"><b><font size="5"><label id="lblprintname2" name="lblprintname2"><s:property value="lblprintname2"/>ENQUIRY WITH JOB STATUS</label></font></b></td></tr> --%>
  <tr>
    <td align="left"><%-- <b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label> --%></td>
  </tr> 
  
    <tr>
    
       <td  >&nbsp;</td>
          <td  >&nbsp;</td>
    
    <td align="left" >&nbsp;</td>
  </tr>
  
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td> 
  </tr>
   <tr>
    <td colspan="3"></td></tr>
    
    <%-- <b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label> 
    
    --%>
    </table>
    
    
 

 
 


<div>
	<table id="maintbl" width="100%" border="1" cellpadding="4" style="border-collapse:collapse; border: 1px solid black;">
  <tr>
    <th width="5%" align="left">Sr No</th>
    <th  width="20%"align="left">branch</th>
    <th  align="left">salesman</th>
    <th  align="center">status</th>
    <th width="5%" align="center">code</th>
    <th width="5%" align="center">count</th>
   
  </tr>
  <s:iterator var="stat" value='#request.enqcountdetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>2){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr> 
</s:iterator> 
 
</table>
</div>
<br>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<table width="100%" border="1" style="border-collapse: collapse;" cellpadding="5">
  <tr>
    <td width="46%" height="90" style="vertical-align:top; font-size:12px"><b>Prepared By :<%=session.getAttribute("USERNAME")%></b></td>
    <td colspan="2" style="vertical-align:top; font-size:13px" align="center">We have received items mentioned as per our order in good condition . Report any descrepancies with in seven (7) days.</td>
  </tr>
  <tr style="border-top: hidden;">
    <td style="color: #D8D8D8;font-size: 10px;" align="center">System Generated Document Signature & Stamp Not Required.</td>
    <td width="27%" style="border-right: hidden;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Name</b> </td>
    <td width="27%" align="right"><b>Signature</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
<%-- <jsp:include page="../../common/printFooter.jsp"></jsp:include> --%>
</div>

</form>
</div>
</body>
</html>
