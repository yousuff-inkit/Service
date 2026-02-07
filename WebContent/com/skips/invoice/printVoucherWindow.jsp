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
		getbankname();
	});

	
	function getbankname() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var banknameItems = items[0].split(",");
				var bankIdItems = items[1].split(",");
				
				var optionsbanknames = '<option value="">--Select--</option>';
				for (var i = 0; i < banknameItems.length; i++) {
					optionsbanknames += '<option value="' + bankIdItems[i] + '">'
							+ banknameItems[i] + '</option>';
				}
				$("select#cmbprintbankname").html(optionsbanknames);
				
			} else {
			}
		}
		x.open("GET", "getBankName.jsp", true);
		x.send();
	}
	
	function funPrint() {
		         var withheader = $("#cmbwithheader").val(); 
		         var bankdocno=$('#cmbprintbankname').val();
		         //alert("bankdocno=="+bankdocno);
					if($('#cmbprintbankname').val()==''){
			 			$.messager.alert('Message','Choose a Bank.','warning');
			 			return 0;
			 		}
					
	      	     var url1=document.URL;  
	      	     var reurl=url1.split("com/");   
	      	     $("#docno").prop("disabled", false);  
	      	     console.log(reurl[0]);  
	      	   var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("masterdoc_no").value+"&branch="+document.getElementById("brchName").value+"&header="+withheader+"&bankdocno="+bankdocno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      		 win.focus();   
	    }  
	 
	 
</script>
  
<body>
<div id="search" >   
<br/><br/><br/><br/> 
<table width="100%" >
  		<tr>
    <td width="20%" align="right">Bank</td>
    <td colspan="2"><select id="cmbprintbankname" name="cmbprintbankname" style="width:65%;" value='<s:property value="cmbprintbankname"/>'>
      <option value="">--Select--</option></select></td>
  </tr>
  	<tr>
  	    <td width="40%" align="right" ><select  id="cmbwithheader" name="cmbwithheader">             
        <option value="1">With Header</option><option value="2">Without Header</option></select></td>              
   		<td align="left"><input type="button" name="btninvoiceprint" id="btninvoiceprint" class="myButton" value="Print" onclick="funPrint();"></td>        
  	</tr>
  	
</table>
<br/><br/> 
  </div>
</body>
</html>