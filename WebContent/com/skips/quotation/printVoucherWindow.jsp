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
	$(document).ready(function(){  
		getTerms();getDefaults();
	});
 	function funPrint(){  
 		  var value=0;
 		  var withtotal=$('#cmbwithtotal').val();     
 		  var typeid=$('#cmbterms').val();   
 		 // alert("typid"+typeid);
          var ctype= $('#jqxQuote').jqxGrid('getcellvalue', 0, "ctype");
          var ownership= $('#jqxQuote').jqxGrid('getcellvalue', 0, "ownership");  
          var billingmethod=$('#cmbbillingmethod').val();
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
 		 var url=document.URL;
 	     var reurl=url.split("com/");   
 	     $("#docno").prop("disabled", false);  
 	     console.log(reurl[0]);  
 	     var win= window.open(reurl[0]+"printQuotationSkip?docno="+document.getElementById("masterdoc_no").value+"&branch="+document.getElementById("brchName").value+"&typeid="+typeid+"&valuee="+value+"&header=1&dtype=QOT","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
 		 win.focus(); 
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
			} else {}
		}
		x.open("GET","getTerms.jsp", true);  
		x.send();
	}
 	function getDefaults(){
 		  var ctype= $('#jqxQuote').jqxGrid('getcellvalue', 0, "ctype");
 		  var billingmethod=$('#cmbbillingmethod').val();
 		  if(ctype=="TRIP BASIS" && billingmethod=="1"){      
 			  $("#cmbwithtotal").attr('disabled', false );
          }else{
        	  $("#cmbwithtotal").attr('disabled', true );  
          }
 		 var ownership= $('#jqxQuote').jqxGrid('getcellvalue', 0, "ownership"); 
 		 
 		 //console.log(billingmethod);
 		// var billingm= $("#cmbbillingmethod").val();
 		//console.log(billingm);
 		//alert("billingmethod=="+billingmethod+"==ownership=="+ownership+"==ctype=="+ctype);
 		
 		 if(ownership=="CLIENT SKIP" && billingmethod=="1"  && ctype=="TRIP BASIS"){      
			  $("#cmbterms").val(2);
         }else if(ownership=="CLIENT SKIP" && billingmethod=="2"){
        	 $("#cmbterms").val(3);
         }else if(ownership=="OWN SKIP" && billingmethod=="1" && ctype=="RENT"){
        	 $("#cmbterms").val(1);
         }else if(ownership=="OWN SKIP" && billingmethod=="2"){
        	 $("#cmbterms").val(4);
         }else if(ownership=="OWN SKIP" && billingmethod=="1" && ctype=="TRIP BASIS"){
        	 $("#cmbterms").val(5);
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
  	    <td width="40%" align="right" ><select  id="cmbwithtotal" name="cmbwithtotal">     
        <option value="1">With Total</option><option value="2">Without Total</option></select></td>              
   		<td align="left"><input type="button" name="btnquoteprint" id="btnquoteprint" class="myButton" value="Print" onclick="funPrint();"></td>        
  	</tr>
</table>
<br/><br/><br/><br/> 
  </div>
</body>
</html>