<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
     
	$(document).ready(function () {
	  	 /* Date */
	  	  $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    	     $('#nationalityWindow').jqxWindow('close');
	 	 $("#jqxDate").jqxDateTimeInput({ width: '80%', height: '15px', formatString:"dd.MM.yyyy"});
	 	$("#jqxBirthDate").jqxDateTimeInput({ width: '80%', height: '15px', formatString:"dd.MM.yyyy"});
	 	$("#jqxexpiryDate").jqxDateTimeInput({ width: '80%', height: '15px', formatString:"dd.MM.yyyy"});
		  getCurrencyIds();getCategory();getGroup();getTypeAllowed();getType(); 
		  $('#txtnationality').dblclick(function(){
	  	  	    $('#nationalityWindow').jqxWindow('open');
	  	   
	  	  	bdcSearchContent('nationsearchGrid.jsp?'); 
	         
	    	  	  }); 
	});  
	
	 function getGroup() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var groupItems = items[0].split(",");
  				var groupIdItems = items[1].split(",");
  				var optionsgroup = '<option value="">--Select--</option>';
  				for (var i = 0; i < groupItems.length; i++) {
  					optionsgroup += '<option value="' + groupIdItems[i] + '">'
  							+ groupItems[i] + '</option>';
  				}
  				$("select#cmbnation").html(optionsgroup);
  				if ($('#hidcmbnation').val() != null) {
  					$('#cmbnation').val($('#hidcmbnation').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getGroup.jsp", true);
  		x.send();
  	}  
	
	 function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var categoryItems = items[0].split(",");
  				var categoryIdItems = items[1].split(",");
  				var optionscategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < categoryItems.length; i++) {
  					optionscategory += '<option value="' + categoryIdItems[i] + '">'
  							+ categoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionscategory);
  				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
  			} else {
  			}
  			
  		}
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
	
	function getType() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var typeItems = items[0].split(",");
  				var typeIdItems = items[1].split(",");
  				var optionstype ;
  				for (var i = 0; i < typeItems.length; i++) {
  					optionstype += '<option value="' + typeIdItems[i] + '">'
  							+ typeItems[i] + '</option>';
  				}
  				$("select#cmbtype").html(optionstype);
  				if ($('#hidcmbtype').val() != null) {
  					$('#cmbtype').val($('#hidcmbtype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getType.jsp", true);
  		x.send();
  	}
	
	function getTypeAllowed(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    if(parseInt(items)==1) {
  			    	$('#typeallowed').val(1);
  			    	document.getElementById("lbltypeentity").style.display = 'inline-block';
  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
  			    	$('#cmbtype').attr('hidden', false);
  			    	$('#txtregisteredtrnno').attr('hidden', true);
  			    } else {
  			    	$('#typeallowed').val(0);
  			    	document.getElementById("lbltypeentity").style.display = 'none';
  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
  			    	$('#cmbtype').attr('hidden', true);
  			    	$('#txtregisteredtrnno').attr('hidden', true);
  			    }
  			    
  		}
  		}
  		x.open("GET", "getTypeAllowed.jsp", true);
  		x.send();
 }
	
	function getCategoryAccountGroup(a) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    $('#hidcmbaccgroup').val(items);
  				
  				if ($('#hidcmbaccgroup').val() != null || $('#hidcmbaccgroup').val() != "") {
  					$('#cmbaccgroup').val($('#hidcmbaccgroup').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
  		x.send();
  	} 
      
	function getCurrencyIds(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('####');
		        var curidItems=items[0];
		        var curcodeItems=items[1];
		        var multiItems=items[2];
		        var optionscurr = '';
		        
		     if(curcodeItems.indexOf(",")>=0){
		        	var currencyid=curidItems.split(",");
		        	var currencycode=curcodeItems.split(",");
		        	multiItems.split(",");
		       
		       for ( var i = 0; i < currencycode.length; i++) {
		    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		        }
		      
		         $("select#cmbcurrency").html(optionscurr);
		         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
		       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
		         } 
				     
			   }
		
		       else{
		    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
		    	   
			    	 $("select#cmbcurrency").html(optionscurr);
			       
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         }
			      }
			}
	     }
	      x.open("GET", "getCurrencyId.jsp",true);
	     x.send();
	    
	   }
	   
	   function getVendorAlreadyExists(vendorname,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 document.getElementById("errormsg").innerText="Vendor Already Exists.";
  					 return 0;
  				 }else{
  					$('#cmbaccgroup').attr('disabled', false);
  					$("#frmVendorDetails").submit();
  				 }
  			   
  		}
	}
	x.open("GET", "getVendorAlreadyExists.jsp?vendorname="+vendorname+"&docno="+docno+"&mode="+mode, true);
	x.send();
    }
	
	function getMobileNoAlreadyExists(mobileno,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 $.messager.alert('Message','Mobile No. Already Exists.','warning');
  					 return 0;
  				 }
  		}
	}
	x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
	
	function typecheck() {
		 if($('#cmbtype').val()=='1'){
			 document.getElementById("lbltrnnoentity").style.display = 'inline-block';
			 if($('#mode').val()!='view'){
			 	$('#txtregisteredtrnno').val('');
			 }
		     $('#txtregisteredtrnno').attr('hidden', false);
		 }
		 else{
			 document.getElementById("lbltrnnoentity").style.display = 'none';
			 if($('#mode').val()!='view'){
				 	$('#txtregisteredtrnno').val('');
			 }
		     $('#txtregisteredtrnno').attr('hidden', true);
		 }
	 } 
      
	 function funReadOnly(){
			$('#frmPropertyOwner input').attr('readonly', true );
		    $('#frmPropertyOwner select').attr('disabled', true); 
			$('#jqxDate').jqxDateTimeInput({disabled: true});
			
			$('#jqxBirthDate').jqxDateTimeInput({disabled: true});
			$('#jqxexpiryDate').jqxDateTimeInput({disabled: true});
			
			
			 
	 }
	 
	 function funRemoveReadOnly(){
		   /*  getCurrencyIds();getTypeAllowed(); */
		    
			$('#frmPropertyOwner input').attr('readonly', false );
			$('#frmPropertyOwner select').attr('disabled', false); 
			$('#jqxDate').jqxDateTimeInput({disabled: false});
			$('#jqxBirthDate').jqxDateTimeInput({disabled: false});
			$('#jqxexpiryDate').jqxDateTimeInput({disabled: false});
			
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#cmbaccgroup').attr('disabled', true);
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#jqxDate').val(new Date());
				
				$('#jqxBirthDate').val(new Date());
				$('#jqxexpiryDate').val(new Date());
				
			}
	 }
	 function funNotify(){	
		 
		/*  if(parseInt($('#typeallowed').val())==1) {
			 var taxtype=document.getElementById("cmbtype").value;
			 if(taxtype.trim()==''){
				 document.getElementById("errormsg").innerText="Type is Mandatory.";
				 return 0;
			 }
			 
			 if($('#cmbtype').find('option:selected').text()=='Registered'){
				 var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
				 if(registeredtrnno.trim()==''){
					 document.getElementById("errormsg").innerText="TRN No. is Mandatory for Registered.";
					 return 0;
				 } 
			 }
		 }
		 
		 vendorname=document.getElementById("txtvendorname").value; */
		 
		        var phoneNo = document.getElementById('txtmobpho');
		        if(phoneNo.value.length == 0){
		        }
		        else if (phoneNo.value.length < 12 || phoneNo.value.length > 12 || phoneNo.value.length == 0) {
		        	 $.messager.alert('Warning','Enter 12 Digit Mobile Number');
		            return false;
		        
		      
		        }

		       
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		return 1;
		} 
	 
	 function funSearchLoad(){
			changeContent('pownerMainSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 getCurrencyIds();
		 if($('#hidjqxDate').val()){ 
			 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());
		  }
		 if($('#hidjqxBirthDate').val()){
			 $("#jqxBirthDate").jqxDateTimeInput('val', $('#hidjqxBirthDate').val());
		  }
		 if($('#hidjqxexpiryDate').val()){
			 $("#jqxexpiryDate").jqxDateTimeInput('val', $('#hidjqxexpiryDate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		}
	 
	/*  function funChkButton() {
			/* funReset(); */
	//	} 
	 
	 /* Validations */
	 /* $(function(){
	        $('#frmVendorDetails').validate({
	                rules: {
	                txtvendorname:"required",
	                cmbcurrency:"required",
	                cmbcategory:"required",
	                cmbaccgroup:"required",
	                //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
	                 
	                 },
	                 messages: {
	                 txtvendorname:" *",
	                 cmbcurrency:" *",
	                 cmbcategory:" *",
	                 cmbaccgroup:" *",
	                 //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
	                 }
	        });}); */
	 
	/*  function funExcelBtn(){
		    var url=document.URL;
		    var reurl=url.split("suppliers");
		    top.addTab("VendorList",reurl[0]+"suppliers/vendorList.jsp");
		} */
		function isNumber(evt,id) {
			//Function to restrict characters and enter number only
				  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
			        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
			         {
			        	 $.messager.alert('Warning','Enter Numbers Only');
			           $("#"+id+"").focus();
			            return false;
			            
			         }
			        
			        return true;
			    }
	function getBDcenter(event)	{
			var x= event.keyCode;
		    if(x==114){
		     bdcSearchContent('nationsearchGrid.jsp');
		    }
		    else{
		     }
		}
		function bdcSearchContent(url) {
		    $('#nationalityWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
		 $('#nationalityWindow').jqxWindow('setContent', data);
		 $('#nationalityWindow').jqxWindow('bringToFront');
		}); 
		 
		}
		function ValidateNo(event,id) {
	        var phoneNo = document.getElementById('txtmobpho');
	        if(phoneNo.value.length == 0){
	        }
	        else if (phoneNo.value.length < 12 || phoneNo.value.length > 12 || phoneNo.value.length == 0) {
	        	 $.messager.alert('Warning','Enter 12 Digit Mobile Number');
	            return false;
	        
	        }
	        return true;
	        }
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmPropertyOwner" action="savePropertyOwner" method="post" autocomplete="off">
 <jsp:include page="../../../header.jsp"></jsp:include><br/> 
   
<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="10%"><div id="jqxDate" name="jqxDate" style="width:65%;" value='<s:property value="jqxDate"/>'></div>
    <input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>'/></td>
    <td width="4%"><td width="8%"></td>
    <td width="4%"></td><td></td><td width="4%" align="right">Doc No</td>
    <td width="5%"><input type="text" id="docno" name="docno" style="width:50%;" tabindex="-1" value='<s:property value="docno"/>'/></td>
    <td width="5%"><input type="hidden" id="vocno" name="vocno" style="width:50%;" tabindex="-1" value='<s:property value="vocno"/>'/></td>
    <td width="5%"></td>
  </tr>
  <tr>
   <td width="5%" align="right">Ejari no</td>
    <td width="10%"><input type="text" id="txtejarino" name="txtejarino" style="width:60%;" value='<s:property value="txtejarino"/>'/></td>
    <td width="4%" align="right">Primary Owner</td>
    <td width="8%"><input type="text" id="txtprimeowner" name="txtprimeowner" style="width:90%;" value='<s:property value="txtprimeowner"/>'/></td>
    <td width="4%" align="right">Co Owner 1</td>
    <td width="8%"><input type="text" id="txtcoowner1" name="txtcoowner1" style="width:90%;" value='<s:property value="txtcoowner1"/>'/></td>
   <td width="4%" align="right">Co Owner 2</td>
    <td width="8%"><input type="text" id="txtcoowner2"  name="txtcoowner2" style="width:90%;" value='<s:property value="txtcoowner2"/>'/></td>
    
    <%-- <td align="right">Currency</td>
    <td><select id="cmbcurrency" name="cmbcurrency" style="width:60%;" value='<s:property value="cmbcurrency"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
     --%><%-- <td align="right">Category</td>
    <td><select id="cmbcategory" name="cmbcategory" style="width:100%;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
    <td align="right"><label id="lbltypeentity">Type</label></td>
    <td><select id="cmbtype" name="cmbtype" style="width:70%;" onchange="typecheck();" value='<s:property value="cmbtype"/>'>
      </select>
      <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td align="right"><label id="lbltrnnoentity">TRN No.</label></td>
    <td><input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" style="width:75%;" value='<s:property value="txtregisteredtrnno"/>'/></td>
   --%></tr>
</table>
</fieldset><br/>

<fieldset><legend>Personal information</legend>
<table width="100%"  >
  <tr>
  <td width="5%" align="right">Date of Birth</td>
    <td width="10%"><div id="jqxBirthDate" name="jqxBirthDate" style="width:65%;" value='<s:property value="jqxBirthDate"/>'></div>
    <input type="hidden" id="hidjqxBirthDate" name="hidjqxBirthDate" value='<s:property value="hidjqxBirthDate"/>'/></td>
  
  <td width="6%" align="right">Address</td>
    <td width="32%"><input type="text" id="txtaddress" name="txtaddress" style="width:90%;" value='<s:property value="txtaddress"/>'/></td>
   <td width="6%" align="right">Telephone</td>
    <td width="18%"><input type="text" id="txttelepho" name="txttelepho" onkeypress="javascript:return isNumber (event,id)" style="width:90%;" value='<s:property value="txttelepho"/>'/></td>
   <td width="4%" align="right">Mobile</td>
    <td width="17%"><input type="text" id="txtmobpho" name="txtmobpho" onblur="ValidateNo (event,id)" style="width:90%;" value='<s:property value="txtmobpho"/>'/></td>
   <td></td>
   </tr>
   <%--  <td width="6%" align="right">Account Group</td>
    <td width="26%"><select id="cmbaccgroup" name="cmbaccgroup"  style="width:80%;" value='<s:property value="cmbaccgroup"/>'>
      <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup" value='<s:property value="hidcmbaccgroup"/>'/></td>
    <td width="5%" align="right">Account</td>
    <td width="14%"><input type="text" id="txtaccount" name="txtaccount" style="width:70%;" value='<s:property value="txtaccount"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Credit Period-Min(Days)</td>
    <td width="10%"><input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:50%;text-align: right;" value='<s:property value="txtcredit_period_min"/>'/></td>
    <td width="7%" align="right">Max(Days)</td>
    <td width="8%"><input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:50%;text-align: right;" value='<s:property value="txtcredit_period_max"/>'/></td>
    <td width="6%" align="right">Credit Limit</td>
    <td width="10%"><input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:50%;text-align: right;" value='<s:property value="txtcredit_limit"/>'/></td>
   --%>
</table>
<table width="100%" >
<tr >
   <td width="5%" align="right">Email</td>
    <td width="17%"><input type="text" id="txtemail" name="txtemail" style="width:90%;" value='<s:property value="txtemail"/>'/></td>
  <td width="7%" align="right">Passport Number</td>
    <td width="18%"><input type="text" id="txtpassport" name="txtpassport" style="width:100%;" value='<s:property value="txtpassport"/>'/></td>
   <td width="9%" align="right">Place Of Issue</td>
    <td width="18%"><input type="text" id="txtissuedplace" name="txtissuedplace" style="width:100%;" value='<s:property value="txtissuedplace"/>'/></td>
  <td width="4%"></td>
   <td width="17%">&nbsp;</td>
  </tr>

   
   <td  align="right">Expiry Date</td>
    <td ><div id="jqxexpiryDate" name="jqxexpiryDate" style="width:65%;" value='<s:property value="jqxexpiryDate"/>'></div>
    <input type="hidden" id="hidjqxexpiryDate" name="hidjqxexpiryDate" value='<s:property value="hidjqxexpiryDate"/>'/></td>
   <td align="right">Nationality</td> 
    <td colspan="4"><input type="text" id="txtnationality" name="txtnationality"  style="width:37%;" placeholder="Press F3 to Search" onkeydown="getBDcenter(event)" value='<s:property value="txtnationality"/>' />&nbsp;&nbsp;   
  <input type="hidden" id="natid" name="natid" value='<s:property value="natid"/>'/>
  <tr><td></td><td></td>
   </tr></table>
</fieldset><br/>

<fieldset><legend>Bank account details</legend>
<table width="100%" >
  <tr>
    
    <td width="5%" align="right">Bank Name</td>
    <td width="20%"><input type="text" id="txtbankname" name="txtbankname" style="width:95%;" value='<s:property value="txtbankname"/>'/></td>
   <td width="8%" align="right">Account No.</td>
    <td width="15%"><input type="text" id="txtaccountno" name="txtaccountno" style="width:95%;" value='<s:property value="txtaccountno"/>'/></td>
   <td width="6%" align="right">Account Name</td>
    <td width="21%"><input type="text" id="txtaccountname" name="txtaccountname" style="width:95%;" value='<s:property value="txtaccountname"/>'/></td>
   <td width="5%" align="right">Bank Address</td>
    <td width="23%"><input type="text" id="txtbankaddress" name="txtbankaddress" style="width:95%;" value='<s:property value="txtbankaddress"/>'/></td>
   
  </tr>
 <tr>
 
  <td width="5%" align="right">Country </td>
    <td width="23%"><input type="text" id="txtbankcountry" name="txtbankcountry" style="width:95%;" value='<s:property value="txtbankcountry"/>'/></td>
  
    <td width="8%" align="right">Preferred currency</td>
   <td><select id="cmbcurrency" name="cmbcurrency" style="width:60%;" value='<s:property value="cmbcurrency"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
   <td width="5%" align="right">Swift code </td>
    <td width="23%"><input type="text" id="txtbankswift" name="txtbankswift" style="width:95%;" value='<s:property value="txtbankswift"/>'/></td>
   <td width="5%" align="right">IBAN </td>
    <td width="23%"><input type="text" id="txtbankiban" name="txtbankiban" style="width:95%;" value='<s:property value="txtbankiban"/>'/></td>
  
 </tr>
  <tr>
  <td width="5%" align="right">Remarks</td>
    <td width="23%"><input type="text" id="txtbankremarks" name="txtbankremarks" style="width:95%;" value='<s:property value="txtbankremarks"/>'/></td>
  
  </tr>
</table>
</fieldset>
<input type="hidden" id="mode" name="mode" />
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
<input type="hidden" id="typeallowed" name="typeallowed" value='<s:property value="typeallowed"/>'/>
</div>
</form>
<div id="nationalityWindow">
   <div></div>
</div>
</div>
</body>
</html>