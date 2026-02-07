<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<script type="text/javascript">
$(document).ready(function () {
	  $('#accountSearchwindow').jqxWindow({ width: '50%', height: '75%',  maxHeight: '74%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
	    $('#accountSearchwindow').jqxWindow('close');
	 $("#servicedate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	  document.getElementById("formdet").innerText="Service Type(CST)";
	  document.getElementById("formdetail").value="Service Type";
	  document.getElementById("formdetailcode").value="CST";
	  window.parent.formCode.value="CST";
      window.parent.formName.value="Service Type";
      $('#inaccid').dblclick(function(){
	  		if($('#mode').val()!= "view")
  		{
		  	    $('#accountSearchwindow').jqxWindow('open');
		 
		
		  	  accountSearchContent('accountsDetailsFromGrid.jsp?den=110');
  		} 
});   
      $('#exaccid').dblclick(function(){
	  		if($('#mode').val()!= "view")
		{
		  	    $('#accountSearchwindow').jqxWindow('open');
		 
		
		  	  accountSearchContent('accountsDetailsFromGrid.jsp?den=115');
		} 
});   
    });
    
 
function funSearchLoad(){
	changeContent('serviceTypeSearch.jsp'); 
 }

	function funReadOnly(){
			$('#frmServiceType input').attr('readonly', true );
			$('#frmServiceType select').attr('disabled', true );
			$('#servicedate').jqxDateTimeInput({ disabled: true}); 
	}

	function funRemoveReadOnly(){
			$('#frmServiceType input').attr('readonly', false );
			$('#frmServiceType select').attr('disabled', false );
			$('#servicedate').jqxDateTimeInput({ disabled: false}); 
			$('#docno').attr('readonly', true);

			if ($("#mode").val() == "A") {
				$('#servicedate').val(new Date());
			}
	
	
	 }
	 function funNotify(){
		 if(document.getElementById("servicetype").value==''){
				document.getElementById("errormsg").innerText="Service Type is Mandatory.";
				return 0;
			}
		var chk= $('#modechk').val();
		//alert("chk=========="+chk);
		if(chk==1){
			var smode= $('#cmbsubmode').val();
			//alert("smode=========="+smode);
			if((smode==null) || (smode==0)){
				document.getElementById("errormsg").innerText="Sub Mode is Mandatory.";
				return 0;
			}
		}
		 
		 
			return 1;
	 }
	function funChkButton() {
		   /* funReset(); */
	 }
	function getinaccountdetails(event){
	 	 var x= event.keyCode;
	 	 
	 	if($('#mode').val()!= "view")
		{
		 	 if(x==114){
		 	  $('#accountSearchwindow').jqxWindow('open');
		 
		 
		 	 accountSearchContent('accountsDetailsFromGrid.jsp?den=110');   }
		 	 else{
		 		 }
		  } 
	 	 }  
	function getexaccountdetails(event){
	 	 var x= event.keyCode;
	 	 
	 	if($('#mode').val()!= "view")
		{
		 	 if(x==114){
		 	  $('#accountSearchwindow').jqxWindow('open');
		 
		 
		 	 accountSearchContent('accountsDetailsFromGrid.jsp?den=115');   }
		 	 else{
		 		 }
		  } 
	 	 } 
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);
	
		}); 
	    	}  
	function setValues() {
		var chk=$('#chkhidtax').val();
		
		//alert("cshprchse==========="+chk);
		
		if(parseFloat(chk)==1){
			document.getElementById("chktaxable").checked = true;
			document.getElementById("chktaxable").value=1; 
		}else{
			document.getElementById("chktaxable").checked = false;
			document.getElementById("chktaxable").value=0; 
		}
		
		if($('#hidservicedate').val()){
				$("#servicedate").jqxDateTimeInput('val', $('#servicedate').val());
		  }
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		 }
	    
		 $('#servicetypediv').load("serviceTypeGrid.jsp?check=1");
		 getMode();
		 getShipment;
      }

	function funFocus(){
			document.getElementById("servicetype").focus();
	}
	
	function getMode() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var mode = items[1].split(",");
				var chk = items[2].split(",");
				var optionsmode = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < mode.length; i++) {
					optionsmode += '<option value="' + srno[i].trim() + '">'
							+ mode[i] + '</option>';
				}
				$("select#cmbmode").html(optionsmode);
				if ($('#hidcmbmode').val() != null) {
					$('#cmbmode').val($('#hidcmbmode').val());
					getSubMode();
				}
			} else {}
		}
		x.open("GET","getMode.jsp", true);
		x.send();
	}
	function getSubMode() {
		var modeval=0;
	
		modeval=$('#cmbmode').val();
		if ((modeval != null) && (modeval>0)) {
			//alert("==in modechk===="+modeval);
		  getModechk();
		}
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var srno=0;
				  srno= items[0].split(",");
				var submode = items[1].split(",");
				var optionssubmode = '<option value="0" selected>-- Select -- </option>';
				for (var i = 0; i < submode.length; i++) {
					optionssubmode += '<option value="' + srno[i].trim() + '">'
							+ submode[i] + '</option>';
				}
				$("select#cmbsubmode").html(optionssubmode);
				if ($('#hidcmbsubmode').val() != null) {
					$('#cmbsubmode').val($('#hidcmbsubmode').val());
				}
			} else {}
		}
		x.open("GET","getSubMode.jsp?modeid="+modeval, true);
		x.send();
	}
	function getShipment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var shipment = items[1].split(",");
				var optionsshipment = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < shipment.length; i++) {
					optionsshipment += '<option value="' + srno[i].trim() + '">'
							+ shipment[i] + '</option>';
				}
				$("select#cmbshipment").html(optionsshipment);
				if ($('#hidcmbshipment').val() != null) {
					$('#cmbshipment').val($('#hidcmbshipment').val());
				}
			} else {}
		}
		x.open("GET","getShipment.jsp", true);
		x.send();
	}
	 function getModechk()
		{
		 var modeval=0;
			modeval=$('#cmbmode').val();
		   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
			       var items= x.responseText.trim();
			       //alert("items"+items);
			       if(parseInt(items)>0){
			    	   
			    	   
			    	   $('#modechk').val(1);
			    	 
			       }
					else{
						 
						  $('#modechk').val(0);
							 
					}
					}
				else{
					
				}
				}
		x.open("GET","modechk.jsp?mode="+modeval,true);

		x.send();
				
		}
	 function isNumberKey(evt){
		 var charCode = (evt.which) ? evt.which : event.keyCode
		 if (charCode > 31 && ((charCode < 48) || (charCode > 57))) 
		 return false;
		 return true;
		 } 
</script>
</head>


<body onload="setValues();getMode();getShipment();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmServiceType" action="saveService1"  autocomplete="off">
<jsp:include page="../../../header.jsp" /><br/> 

<fieldset>
<legend>Service Type</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="13%"><div id="servicedate" name="servicedate" value='<s:property value="servicedate"/>'></div></td>
    <td width="6%">Service Type</td>
    <td width="35%"><input type="text" id="servicetype" name="servicetype"  style="width:100%;" value='<s:property value="servicetype"/>' readonly tabindex="-1"></td>
    <td width="5%" align="center" id="lbltax">Taxable</td><td width="2%"><input type="checkbox"  value="0" id="chktaxable" name="chktaxable"  onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
     <td align="right">Sequence No.</td>
    <td width="10%"><input type="text" id="seqno" name="seqno" onkeypress="return isNumberKey(event)" value='<s:property value="seqno"/>'></td>
    <td align="right">Doc No.</td>
    <td width="10%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
   
  </tr>
  </table>
  <table width="100%">
  <tr>
    <td  width="3%" align="right">Mode</td>
    <td width="10%"><select id="cmbmode" name="cmbmode" onchange="getSubMode();" style="width:100%;" value='<s:property value="cmbprocess"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbmode" name="hidcmbmode" value='<s:property value="hidcmbmode"/>'/>
      <input type="hidden" id="hidmodetype" name="hidmodetype" value='<s:property value="hidmodetype"/>'/></td>
  
   <td width="3%" align="right">Sub Mode</td>
    <td width="15%"><select id="cmbsubmode" name="cmbsubmode" style="width:100%;" value='<s:property value="cmbsubmode"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbsubmode" name="hidcmbsubmode" value='<s:property value="hidcmbsubmode"/>'/>
      <input type="hidden" id="hidsubmodetype" name="hidsubmodetype" value='<s:property value="hidsubmodetype"/>'/></td>
   
   <td  width="5%" align="right">Shipment</td>
    <td width="16%"><select id="cmbshipment" name="cmbshipment" style="width:100%;" value='<s:property value="cmbshipment"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbshipment" name="hidcmbshipment" value='<s:property value="hidcmbshipment"/>'/>
      <input type="hidden" id="hidshipmenttype" name="hidshipmenttype" value='<s:property value="hidshipmenttype"/>'/></td>
          
   </tr>
   </table>
    <table width="100%" >
 <tr> <td width="7%" align="left">Income Account
     
      <input type="hidden" name="inacctype" id="inacctype" value='<s:property value="inacctype"/>'></td>
 
    <td width="10%" align="left"><input type="text" name="inaccid" style="width:95%;" id="inaccid" value='<s:property value="inaccid"/>' placeholder="Press F3 To Search"  style="width:30%;" onKeyDown="getinaccountdetails(event);" ></td>  
      <td width="25%" align="left"><input type="text" id="inaccname" name="inaccname" style="width:95%;" value='<s:property value="inaccname"/>'></td>
        <td width="7%" align="left">Expense Account
   
      <input type="hidden" name="exacctype" id="exacctype" value='<s:property value="exacctype"/>'></td>
  <td width="10%" align="left"><input type="text" name="exaccid" style="width:95%;" id="exaccid" value='<s:property value="exaccid"/>' placeholder="Press F3 To Search"  style="width:28%;" onKeyDown="getexaccountdetails(event);" >  </td>
      <td width="25%" align="left"><input type="text" id="exaccname" name="exaccname"  style="width:95%;" value='<s:property value="exaccname"/>'></td>
 </tr>
</table>
</fieldset><br/>
<div id="servicetypediv"><jsp:include page="serviceTypeGrid.jsp"></jsp:include></div>

<input type="hidden" name="hidservicedate" id="hidservicedate" value='<s:property value="hidservicedate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="inaccdocno" id="inaccdocno" value='<s:property value="inaccdocno"/>'>
<input type="hidden" name="exaccdocno" id="exaccdocno" value='<s:property value="exaccdocno"/>'>
<input type="hidden" name="modechk" id="modechk" value='<s:property value="modechk"/>'>
<input type="hidden" id="chkhidtax" name="chkhidtax"  value='<s:property value="chkhidtax"/>'/>
</form>
<div id="accountSearchwindow">
		   <div></div>
		</div>
</div>
</body>
</html>