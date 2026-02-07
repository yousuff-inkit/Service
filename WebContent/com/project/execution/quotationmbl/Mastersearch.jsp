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
	  $("#surdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	  funConfirmConfig();
	}); 

 	function qotloadSearch1() {
 		
 		 var surdate=document.getElementById("surdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		 var sereftype=document.getElementById("sereftype").value;
 		 var msdocno=document.getElementById("msdocno").value; 
 	     var Cl_names = Cl_namess.replace(' ','%20');
 		 var cntrtype=document.getElementById("cntrtype").value;
	     var Cl_site1=document.getElementById("cl_site").value;
 		 var Cl_area1=document.getElementById("cl_area").value;
 		 var Cl_amount=document.getElementById("cl_amount").value;
 		 var Cl_site = Cl_site1.replace(' ','%20');
 		 var Cl_area = Cl_area1.replace(' ','%20');
 		 var refno=document.getElementById("refno").value;
 		 var revisionno=document.getElementById("ms_revisionno").value;   
 		
	getdata1(Cl_names,msdocno,surdate,cntrtype,sereftype,Cl_site,Cl_area,Cl_amount,refno,revisionno);
 

	}
	function getdata1(Cl_names,msdocno,surdate,cntrtype,sereftype,Cl_site,Cl_area,Cl_amount,refno,revisionno){
		
		var id=1;
		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&revisionno='+revisionno+'&msdocno='+msdocno+'&sereftype='+sereftype+'&surdate='+surdate+'&cntrtype='+cntrtype+'&Cl_site='+Cl_site+'&Cl_area='+Cl_area+'&Cl_amount='+Cl_amount+'&refno='+refno+'&id='+id);
		
		}
	function funConfirmConfig(){   
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			 	var items= x.responseText;
			 	if(items==1){
	            	 $("#ms_revnolbl").show();  
			 		 $("#ms_revisionno").show();
	            }else{
			 		 $("#ms_revnolbl").hide();
			 		 $("#ms_revisionno").hide();
	            }
		 } else {}
	     }
	     x.open("GET","getConfirmConfig.jsp",true);
	     x.send();
		}
	
	

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
   <td>                         
   <table>
   <tr>
	    <td width="10%" align="right">Docno</td>
	    <td align="left" width="5%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
	    <td width="5%" align="right" >Client</td>
	    <td align="left" width="50%" colspan="2"><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
	    <td align="right" width="5%">Ref.Type</td>
	    <td align="left" width="10%"><select id="sereftype" name="sereftype"  style="width:100%;"  value='<s:property value="sereftype"/>'>
	      <option value=""></option>
	      <option value="DIR">DIR</option>
	      <option value="ENQ">ENQ</option>
	      </select>  
	    </td>
   </tr>
   <tr>
        <td width="10%" align="right">Cont. Type</td>
        <td align="left" width="5%"><select id="cntrtype" name="cntrtype"  style="width:100%;"  value='<s:property value="cntrtype"/>'>
	      <option value=""></option>
	      <option value="AMC">AMC</option>
	      <option value="SJOB">SJOB</option>
	      </select>
	    </td>
	    <td width="5%" align="right">Date</td>
	    <td align="left" width="10%"><div id="surdate" name="surdate"></div></td>  
	    <td width="40%" align="left">&nbsp;&nbsp;Amount&nbsp;<input type="text" name="cl_amount" id="cl_amount" style="width:65%;"  value='<s:property value="cl_amount"/>'></td>
	    <td align="right" width="5%" >Ref.No.</td>
        <td align="left" width="10%"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td> 
   </tr>
   <tr>
        <td width="10%" align="right">Area</td>  
	    <td align="left" width="5%"><input type="text" name="cl_area" id="cl_area"  value='<s:property value="cl_area"/>'></td>
	    <td width="5%" align="right">Site</td>
	    <td align="left" width="50%" colspan="2"><input type="text" name="cl_site" style="width:97%;" id="cl_site"  value='<s:property value="cl_site"/>'></td>
	    <td align="right"><label for="revisionno" id="ms_revnolbl">Revision</label></td>
	    <td align="left" width="10%"><input type="text" name="ms_revisionno" id="ms_revisionno"  value='<s:property value="ms_revisionno"/>'></td>
	    <td><input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
    </tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>