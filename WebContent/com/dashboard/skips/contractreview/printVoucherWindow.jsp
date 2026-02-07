 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" /> --%>
<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function(){  
		getTerms();getDefaults();
	});
	
	$("#btncontractmail").click(function(){   
		var value=0;
		var withtotal=$('#cmbwithtotal').val();     
		var typeid=$('#cmbterms').val();   
		
		var rowindex=$('#hidrowindex').val();   
		var ctype= $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex, "ctype");
        var ownership= $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex, "ownership");  
        var billingmethod= $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex, "billingmethodid");  

        var xlstat=$("#xlstat").val();

        if(xlstat==""){
  			$.messager.alert('Message','Select a Brand option...','warning');
  		}
        if(ctype=="RENT" && billingmethod=="1"){    
      	  value=1;
        }   
        if(ctype=="TRIP BASIS" && billingmethod=="1" && withtotal=="1"){      
      	  value=3;
        }
        if(ctype=="TRIP BASIS" && billingmethod=="1" && withtotal=="2"){      
      	  value=2;
        }
        if(ownership=="CLIENT SKIP" && billingmethod=="2"){      
      	  value=4;
        }
        if(ownership=="OWN SKIP" && billingmethod=="2"){      
      	  value=5;
        }
        if(billingmethod=="3"){      
      	  value=6;
        }
		
        $('#printWindow').jqxWindow('close');
        
        funSendmail(xlstat, typeid, value);
        
	})    

	function funxlshowcheck(){
		if(document.getElementById("rdbnxlshow").checked){
			$('#xlstat').val("0");
		}
		if(document.getElementById("rdbnxlhide").checked){
			$('#xlstat').val("1");
		}
	}
	
	function getTerms() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				
				for (var i = 0; i < process.length; i++) {
					
					optionsbranch += '<option  value="' + srno[i].trim()+'">'   
					+ process[i] + '</option>';
						
				}
				$("select#cmbterms").html(optionsbranch);
				getDefaults();
			} 
		}
		x.open("GET","getTerms.jsp", true);  
		x.send();
	}
	
	function getDefaults(){
	   var rowindex=$('#hidrowindex').val();   
	   var ctype= $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex, "ctype");
       var ownership= $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex, "ownership");  
       var billingmethod= $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex, "billingmethodid");  
	   
	   if(ctype=="TRIP BASIS" && billingmethod=="1"){      
		  	$("#cmbwithtotal").attr('disabled', false );
	   }else{
       		$("#cmbwithtotal").attr('disabled', true );  
       }
		 
	if(ownership=="CLIENT SKIP" && billingmethod=="1"  && ctype=="TRIP BASIS"){      
			  $("#cmbterms").val(12);
    }else if(ownership=="CLIENT SKIP" && billingmethod=="2"){
   	 	 $("#cmbterms").val(13).trigger('change');  	
    }else if(ownership=="OWN SKIP" && billingmethod=="1" && ctype=="RENT"){
   		 $("#cmbterms").val(11);
    }else if(ownership=="OWN SKIP" && billingmethod=="2"){
   	 	 $("#cmbterms").val(14);
    }else if(ownership=="OWN SKIP" && billingmethod=="1" && ctype=="TRIP BASIS"){
   	 	 $("#cmbterms").val(15);     
    }else{
   		 $("#cmbterms").val("");    
    }  
	} 
	
</script>
  
<body>
<div id=search>
<br/><br/><br/><br/> 
<table width="100%">
	<tr>
	  <td width="25%" align="center" colspan="2">Terms&nbsp;<select  id="cmbterms" name="cmbterms" style="width:60%;"></select></td> 
	</tr>
	  <tr>
    <td style="padding:5px" colspan="2" align="right" width="50%"><input type="radio" id="rdbnxlshow" name="rdbnxl" onchange="funxlshowcheck();" value="Show xl" checked="checked">&nbsp;
    <label id="lblwithoutxl">Header</label></td>
    
    <td style="padding:5px" align="left" width="50%"><input type="radio" id="rdbnxlhide" name="rdbnxl" onchange="funxlshowcheck();" value="Hide xl" >&nbsp;
    <label id="lblwithxl">Without Header</label>
    							  <input type="hidden" id="xlstat" name="xlstat" value="0" /></td>
    
    </tr>
  	<tr>
  	    <td style="padding:5px" width="40%" align="right" ><select  id="cmbwithtotal" name="cmbwithtotal">     
        <option value="1">With Total</option><option value="2">Without Total</option></select></td>              
   		<td style="padding:5px" align="left"><input type="button" name=""btncontractmail"" id="btncontractmail" class="myButton" value="Mail"></td>        
  	</tr>
</table>
<br/><br/><br/><br/> 
  </div>
</body>
</html>