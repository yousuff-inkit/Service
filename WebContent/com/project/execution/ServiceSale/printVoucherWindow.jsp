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
	document.getElementById("rdheader").checked=true;
	document.getElementById("rdexisting").checked=true;
	getCurrencyIds1();
	funchange();
	funwithcurr();
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
 	function printlogo() {
 		if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			var url=document.URL;
			var reurl;
			if( url.indexOf('savesrvsale') >= 0){
				reurl=url.split("savesrvsale");
			}else {
				reurl=url.split("serviceSale.jsp");
			}
			$("#docno").prop("disabled", false);                
			var dtype=$('#formdetailcode').val();
			var brhid=$("#brchName").val();
			var bankdocno=$('#cmbprintbankname').val();
			if($('#cmbprintbankname').val()==''){
	 			$.messager.alert('Message','Choose a Bank.','warning');
	 			return 0;
	 		}
			var header=0;
	 		if(document.getElementById("rdheader").checked==true){
	 			header=1;
	 		} else if(document.getElementById("rdnoheader").checked==true){
	 			header=0;
	 		}
	 		var curid=0, rate=0, rdochanging=0;
	 		if(document.getElementById("rdexisting").checked){
	 			curid=$('#cmbcurr').val();
		 		rate=$('#currate').val();
		 		rdochanging=0;
	 		}
	 		
	 		if(document.getElementById("rdnochanging").checked){
	 			curid=$('#cmbcurr1').val();
		 		rate=$('#currate1').val();
		 		rdochanging=1;
		 		if(rate=="" || rate=="0"){
		 			$.messager.alert('Message','Please enter rate!!!','warning');  
					return false;
		 		}  
	 		}
	 		
	 		
			var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&rdochanging="+rdochanging+"&curid="+curid+"&rate="+rate+"&brhid="+brhid+"&dtype="+dtype+"&header="+header+"&bankdocno="+bankdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			win.focus();
		} 
		else {
			$.messager.alert('Message','Select a Document....!','warning');
			return false;
		}
 		$('#printWindow').jqxWindow('close');
 	}

 	/* function printnologo(){
 		if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			var url=document.URL;
			var reurl;
			if( url.indexOf('savesrvsale') >= 0){
				reurl=url.split("savesrvsale");
			}else {
				reurl=url.split("serviceSale.jsp");
			}
			$("#docno").prop("disabled", false);                
			var dtype=$('#formdetailcode').val();
			var brhid=$("#brchName").val();
			var win= window.open(reurl[0]+"PRINTServiceSale?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype+"&header=0","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			win.focus();
		} 
		else {
			$.messager.alert('Message','Select a Document....!','warning');
			return false;
		}
 		$('#printWindow').jqxWindow('close');
 	} */
	function getCurrencyIds1(){  
 		  var a = $('#nipurchasedate').val();
 	   var x=new XMLHttpRequest();
 	   x.onreadystatechange=function(){
 	   if (x.readyState==4 && x.status==200)
 	    {
 	      items= x.responseText;
 	      //console.log(items);
 	      items=items.split('####');
 	           var curidItems=items[0];
 	           var curcodeItems=items[1];
 	           var currateItems=items[2];
 	           var multiItems=items[3];
 	           var optionscurr = '';
 	           
 	        if(curcodeItems.indexOf(",")>=0){
 	            var currencyid=curidItems.split(",");
 	            var currencycode=curcodeItems.split(",");
 	            multiItems.split(",");
 	          
 	          for ( var i = 0; i < currencycode.length; i++) {
 	           optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
 	           }
 	         
 	            $("select#cmbcurr1").html(optionscurr);
 	            
 	            
		        	
 	            //funRoundRate(currateItems,"currate1");
		        	 
			         //$('#currate').attr('readonly', true);
 	          
 	       }
 	   
 	          else{
 	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
 	           
 	          $("select#cmbcurr1").html(optionscurr);
 	           
 	           
	        		  
 	          //funRoundRate(currateItems,"currate1");
	        	 
		          //$('#currate').attr('readonly', true);
		          
 	          }
 	    }
 	       }
 	        x.open("GET", "getCurrencyId.jsp?date="+a,true);
 	       x.send();
 	      
 	     }				        
/* function funrate1() {      
	 
	console.log("IN   Rate");
var x=new XMLHttpRequest();
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
 {
   var items= x.responseText;
 
      
     // funRoundRate(items,"currate1");    
      
     }
       else
   {
   }
}
x.open("GET","getRateFrom.jsp?curr="+$('#cmbcurr1').val(),true);  
x.send();
} */

function funchange(){
	if(document.getElementById("rdexisting").checked){
		$("#pntcurr").hide();
		$("#cmbcurr1").hide();
		$("#pntrate").hide();
		$("#currate1").hide(); 
	}
	
	if(document.getElementById("rdnochanging").checked){
		$("#pntcurr").show();
		$("#cmbcurr1").show();
		$("#pntrate").show();
		$("#currate1").show();
	}
	
}

function funwithcurr(){
   var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
	       var items= x.responseText.trim();
	       if(parseInt(items)>0){
	    	   $("#withcurrid").show();
	    	   $("#withrateid").show();
	       }else{
	    	   $("#withcurrid").hide();
	    	   $("#withrateid").hide(); 
			}
			}
		else{
			
		}
		}
		x.open("GET","getwithcurr.jsp?",true);
		x.send();  
}
</script>

<body>
<div id=search>
<br/>
<table width="100%">  
<tr>
    <td width="25%" align="center" colspan="3">Bank&nbsp;&nbsp;<select id="cmbprintbankname" name="cmbprintbankname" style="width:50%;" value='<s:property value="cmbprintbankname"/>'>
      <option value="">--Select--</option></select></td>
     
  </tr>
  <tr>
   
    <td width="10%" colspan="3" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rdheader" name="rdo" value="rdheader"><label for="rdheader">With Header</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="radio" id="rdnoheader" name="rdo" value="rdnoheader"><label for="rdnoheader">Without Header</label></td>
     
  </tr>
   <tr id="withcurrid">

    
     <td width="10%" colspan="3" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rdexisting" name="rdocurr" value="rdexisting" onchange="funchange()"><label for="rdexisting"> Existing curr</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="radio" id="rdnochanging" name="rdocurr" value="rdnochanging" onchange="funchange()"><label for="rdnochanging">Other curr </label></td>
  </tr>
  <tr id="withrateid">
  
  <td colspan="3" align="center" width="100%"><label id="pntcurr">Curr</label>&nbsp; <select name="cmbcurr1" id="cmbcurr1" style="width:40%;" value='<s:property value="cmbcurr1"/>'  >  
	      <option value="-1" >--Select--</option>
	    </select> 
	    <label id="pntrate">Rate</label> &nbsp; <input type="text" style="width:30%;"   name="currate1" id="currate1"  value='<s:property value="currate1"/>'></td> 
   </tr>
   <tr>
    
    <td>&nbsp;</td>
    <td width="57%" align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="Print"  onclick="printlogo();"></td>
     <td>&nbsp;</td>
  </tr>
<!-- <tr><td colspan="2" align="center"><h2>Choose the print type</h2></td></tr>
  <tr>
    <td align="center"><input type="button" name="btninv" id="btninv" class="myButton" value="With Header"  onclick="printlogo();"></td>
    <td align="center"><input type="button" name="btnfoc" id="btnfoc" class="myButton" value="With Out Header"  onclick="printnologo();"></td>
    
  </tr> -->
</table>
&nbsp;
  </div>
</body>
</html>