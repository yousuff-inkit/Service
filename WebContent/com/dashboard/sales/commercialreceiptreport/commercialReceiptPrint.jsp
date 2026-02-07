<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
    font-size: 9px;
}
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCommercialReceiptReport" action="printCommercialReceiptReport" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<table width="95%" class=tablereceipt align="center">
<tr height="25" style="background-color: #F6CECE;">
    <td width="8%" align="center" class=tablereceipt><b>CMR No</b></td>
    <td width="8%" align="center" class=tablereceipt><b>Date</b></td>
    <td width="5%" align="center" class=tablereceipt><b>Type</b></td>
    <td width="6%" align="center" class=tablereceipt><b>Doc No</b></td>
    <td width="10%" align="center" class=tablereceipt><b>Branch</b></td>
    <td width="12%" align="left" class=tablereceipt><b>&nbsp;Client</b></td>
    <td width="8%" align="right" class=tablereceipt><b>Cash&nbsp;</b></td>
    <td width="8%" align="right" class=tablereceipt><b>Card&nbsp;</b></td>
    <td width="8%" align="right" class=tablereceipt><b>Cheque&nbsp;</b></td>
    <td width="8%" align="right" class=tablereceipt><b>Applied&nbsp;</b></td>
    <td width="8%" align="right" class=tablereceipt><b>Balance&nbsp;</b></td>
    <td width="13%" align="left" class=tablereceipt><b>&nbsp;Description</b></td>
  </tr>
  
    <s:iterator var="stat" value='#request.printingarray' >
	<tr height="20" class=tablereceipt>   
		<%int i=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==5 || i==11){%>
    	<td class=tablereceipt align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i==6 || i==7 || i==8 || i==9 || i==10){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			&nbsp;</td>
   		<%} else{ %>
  		<td class=tablereceipt align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } i++;  %>
 		</s:iterator>
	</tr>
	</s:iterator>
	<tr height="20" class=tablereceipt>
		<td  align="right" colspan="6" class=tablereceipt><b>Total </b>&nbsp;</td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcashtotal" name="lblcashtotal"><s:property value="lblcashtotal"/></label>&nbsp;</td>
        <td width="8%" align="right" class=tablereceipt><label id="lblcardtotal" name="lblcardtotal"><s:property value="lblcardtotal"/></label>&nbsp;</td>
        <td width="8%" align="right" class=tablereceipt><label id="lblchequetotal" name="lblchequetotal"><s:property value="lblchequetotal"/></label>&nbsp;</td>
        <td width="8%" align="right"class=tablereceipt><label id="lblappliedtotal" name="lblappliedtotal"><s:property value="lblappliedtotal"/></label>&nbsp;</td>
        <td width="8%" align="right"class=tablereceipt><label id="lblbalancetotal" name="lblbalancetotal"><s:property value="lblbalancetotal"/></label>&nbsp;</td>
        <td class=tablereceipt align="center" style="background-color: #A4A4A4;">&nbsp;</td>
	</tr>
</table><br/>

<table width="100%">
<tr>
		<td width="92%" align="right"><b>Net Amount :</b>&nbsp;</td>
        <td width="8%" align="left"><label id="lblnetbalance" name="lblnetbalance"><s:property value="lblnetbalance"/></label></td>
</tr>
</table><br/>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
</div>
</form>
</div>
</body>
</html>