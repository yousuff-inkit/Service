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
<%
String partsconfig = request.getParameter("partsconfig")==null?"0":request.getParameter("partsconfig");
%>
<script type="text/javascript">
	
var config='<%=partsconfig%>';
//alert(config);
$(document).ready(function () {
	//getbankname();
	//getPrintExcelConfig();
	//document.getElementById("rdheader").checked=true;
	 //$("#rdbnxlshow").hide();
	/*  $("#rdbnxlhide").hide();
	 if(config.trim()=='1'){
		 $("#rdbnxlshow").show();
		 $("#rdbnxlhide").show();
		 //$("#lblwithtotal").show();
		 //$("#lblwithouttotal").show();
	} */
	 
});


 	function printlogo() {
 		//getPrintExcelConfig();
    //	 var partsconfig=$("#partsconfig").val();

 		//document.getElementById("rdheader").checked=true;
 		
 		 //$("#rdbnxlshow").hide();
 		 //$("#rdbnxlhide").hide();
			//$("#docno").prop("disabled", false);                
			//alert("printlogo");
			 var xlstat=$('#xlstat').val();

		  		
		  		if(xlstat==""){
		  			$.messager.alert('Message','Select XL status option...','warning');
		  		}
			
			
		  		if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
				 	  
			  var url=document.URL;
              var reurl=url.split("savedeliveryNote");
			  $("#docno").prop("disabled", false); 
	 		  //var url=document.URL;
		       // var reurl=url.split("deliveryNote.jsp");
		       // console.log("ac print");   
		        //$("#txtacountno").prop("disabled", false);
		        //var win= window.open(reurl[0]+"printAgeingOutstandingsStatement?&acno="+document.getElementById("txtacountno").value+'&header='+header+'&xlstat='+xlstat+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        var win= window.open(reurl[0]+"printdeliveryNote?docno="+document.getElementById("masterdoc_no").value+"&partsconfig="+config+"&xlstat="+xlstat,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				 win.focus();
				//funGetOutstandingTable(); 
			//var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header="+header+"&bankdocno="+bankdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
		    //$('#printWindow').jqxWindow('close');
 	}

 	}
 /* 	function getPrintExcelConfig(){ 
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				items = x.responseText.trim();
 				$('#partsconfig').val(items); 
 				
 				alert("partsconfigVouch=="+$('#partsconfig').val());
 				if($('#partsconfig').val().trim()=='1'){
 					 $("#rdbnxlshow").show();
 					 $("#rdbnxlhide").show();
 					 //$("#lblwithtotal").show();
 					 //$("#lblwithouttotal").show();
 				}
 				
 					
 			} else {
 				// $("#lblwithxl").hide();
				// $("#rdbnxlshow").hide();
				// $("#rdbnxlhide").hide();
 			}
 		}
 		x.open("GET", "getPrintExcelConfig.jsp", true);
 		x.send();
 	}
 	 */
 	function funxlshowcheck(){
 		alert("funxl");
 		
 		
 		if(document.getElementById("rdbnxlshow").checked){
 				$('#xlstat').val("0");
 			}
 			if(document.getElementById("rdbnxlhide").checked){
 				$('#xlstat').val("1");
 			}
 	}

</script>

<body>
<div id=searchprint>
<br/>
<table width="100%">

 
  
   <tr>
    <td>&nbsp; <input type="hidden" id="xlstat" name="xlstat" value="0" /></td>
    <td colspan="2" align="center"><input type="radio" id="rdbnxlshow" name="rdbnxl" onchange="funxlshowcheck();" value="Show xl" checked="checked">&nbsp;<label id="lblwithoutxl">Print</label>
    <input type="radio" id="rdbnxlhide" name="rdbnxl" onchange="funxlshowcheck();" value="Hide xl" ><label id="lblwithxl">With Excel</label>
    							 </td>
    
    </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td colspan="2"  width="87%" align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="Print"  onclick="printlogo();"></td>
    <td width="76%">&nbsp;</td>
  </tr>
 

</table>
&nbsp;
  </div>
</body>
</html>