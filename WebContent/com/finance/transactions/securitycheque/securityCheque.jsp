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

<script type="text/javascript">
	$(document).ready(function() {
		 $("#jqxSecurityChequeDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxValidUpTo").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  
	});
	
	function accountFromSearchContent(url) {
	    $('#accountDetailsFromWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsFromWindow').jqxWindow('setContent', data);
		$('#accountDetailsFromWindow').jqxWindow('bringToFront');
	}); 
	}

	function accountToSearchContent(url) {
		 	$('#accountDetailsToWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsToWindow').jqxWindow('setContent', data);
			$('#accountDetailsToWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function SecurityChequePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function funReadOnly(){
			$('#frmSecurityCheque input').attr('readonly', true );
			$('#frmSecurityCheque select').attr('disabled', true);
			$('#chckchqdate').attr('disabled', true);
			$('#chckamount').attr('disabled', true);
			$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxValidUpTo').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmSecurityCheque input').attr('readonly', false );
			$('#frmSecurityCheque select').attr('disabled', false);
			$('#chckchqdate').attr('disabled', false);
			$('#chckamount').attr('disabled', false);
			$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxValidUpTo').jqxDateTimeInput({disabled: false});
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#jqxSecurityChequeDate').val(new Date());
			}		
	 }
	 
	 function funSearchLoad(){
		 changeContent('secMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
		  $('#jqxSecurityChequeDate').jqxDateTimeInput('focus'); 
	    }
	 
	   $(function(){
	        $('#frmSecurityCheque').validate({
	                rules: {
	                txtfromaccid:"required",
					txtremarks:{maxlength:500}
	                 },
	                 messages: {
	                 txtfromaccid:" *",
					 txtremarks: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		  		$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: false});
		  		$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
		  		$('#jqxValidUpTo').jqxDateTimeInput({disabled: false});
			    $('#frmSecurityCheque select').attr('disabled', false); 
		  		
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxSecurityChequeDate').val()){
				 $("#jqxSecurityChequeDate").jqxDateTimeInput('val', $('#hidjqxSecurityChequeDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
			  }
		  
		  if($('#hidjqxValidUpTo').val()){
				 $("#jqxValidUpTo").jqxDateTimeInput('val', $('#hidjqxValidUpTo').val());
			  }
		  
		  if(document.getElementById("hidchckchqdate").value==1){
	 			 document.getElementById("chckchqdate").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckchqdate").value==0){
	 			document.getElementById("chckchqdate").checked = false;
	 		 }
		  
		  if(document.getElementById("hidchckamount").value==1){
	 			 document.getElementById("chckamount").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckamount").value==0){
	 			document.getElementById("chckamount").checked = false;
	 		 }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		}
	  
	  function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			SecurityChequePrintContent('printVoucherWindow.jsp');
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{
           }
          }
	  
	  function funchequedate(){
	      var chequedate = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  var chequeDates =new Date(chequedate).setDate(chequedate.getDate()+1); 
		  $('#jqxChequeDate').jqxDateTimeInput('setDate', new Date(chequeDates));
		  
		  var validupto = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  var validuptos =new Date(validupto).setDate(chequedate.getDate()+1); 
		  $('#jqxValidUpTo').jqxDateTimeInput('setDate', new Date(validuptos));
     }
	  	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function checkChequeDate(){
	 		 if(document.getElementById("chckchqdate").checked){
	 			 document.getElementById("hidchckchqdate").value = 1;
	 			 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
	 		 }
	 		 else{
	 			 document.getElementById("hidchckchqdate").value = 0;
	 			 $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
	 		 }
	 	 }
	  
	  function checkAmount(){
		  if(document.getElementById("chckamount").checked){
	 			 document.getElementById("hidchckamount").value = 1;
	 			 $('#txtamount').attr('readonly', false );
	 		 }
	 		 else{
	 			 document.getElementById("hidchckamount").value = 0;
	 			 $('#txtamount').attr('readonly', true );
	 		 }
	  }
	  
	  function datechange(){
		  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  
</script>



</head>
<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

#frmSecurityCheque input[type="text"],
#frmSecurityCheque select,
.textbox { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
    width: 100%;
}

#frmSecurityCheque input[type="text"]:focus,
#frmSecurityCheque select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmSecurityCheque input[readonly],
#frmSecurityCheque input:disabled,
#frmSecurityCheque select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; 
}

.modern-ui .input-search-container {
    position: relative;
    display: flex;
    flex-shrink: 0;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
    width: 100%;
    box-sizing: border-box;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* CSS-only JQX Overrides for Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
    font-family: Arial, sans-serif !important;
    padding: 0 6px !important;
}
.jqx-action-button {
    height: 24px !important;
    top: 0px !important;
}
.jqx-widget-content {
    box-sizing: border-box !important;
}
</style>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSecurityCheque" action="saveSecurityCheque" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='modern-ui hidden-scrollbar'>
        
        <!-- General Info -->
        <div class="middle-panel" style="background: #fdfdfd;">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="jqxSecurityChequeDate" name="jqxSecurityChequeDate" onchange="datechange();" value='<s:property value="jqxSecurityChequeDate"/>'></div>
                    <input type="hidden" id="hidjqxSecurityChequeDate" name="hidjqxSecurityChequeDate" value='<s:property value="hidjqxSecurityChequeDate"/>'/>
                </div>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: auto;">Doc No.</label>
                <input type="text" id="docno" name="txtsecuritychequedocno" value='<s:property value="txtsecuritychequedocno"/>' tabindex="-1" readonly style="width:120px; flex-shrink:0;"/>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Paid To</label>
                <select id="cmbtotype" name="cmbtotype" style="width:60px; flex-shrink:0;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AP">AP</option>
                    <option value="AR">AR</option>
                    <option value="GL">GL</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>      
                
                <div class="input-search-container" style="width:120px; flex-shrink:0; margin-left:8px;">
                    <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                    <svg class="magnifier-icon" onclick="if($('#mode').val()!='view'){ var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', date); accountToSearchContent('<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype='+$('#cmbtotype').val()+'&date='+date); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' tabindex="-1" readonly style="flex:1; min-width:0; margin-left: 8px;"/>
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
            </div>
        </div>

        <!-- Cheque Details -->
        <div class="middle-panel">
            <span class="middle-panel-title">Cheque Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Bank</label>
                <div class="input-search-container" style="width:120px; flex-shrink:0;">
                    <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
                    <svg class="magnifier-icon" onclick="if($('#mode').val()!='view'){ var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', date); accountFromSearchContent('<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date='+date); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' tabindex="-1" readonly style="flex:1; min-width:0; margin-left: 8px;"/>
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Cheque No.</label>
                <input type="text" id="txtchequeno" name="txtchequeno" style="width:150px; flex-shrink:0;" onchange="funchequedate();" value='<s:property value="txtchequeno"/>' />
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Valid Up To</label>
                <div style="width:125px; flex-shrink:0;">
                    <div id="jqxValidUpTo" name="jqxValidUpTo" value='<s:property value="jqxValidUpTo"/>'></div>
                    <input type="hidden" id="hidjqxValidUpTo" name="hidjqxValidUpTo" value='<s:property value="hidjqxValidUpTo"/>'/>
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0; display:flex; align-items:center; justify-content:flex-end;">
                    <input type="checkbox" id="chckchqdate" name="chckchqdate" value="" onchange="checkChequeDate();" style="margin: 0 4px 0 0;"> Chq Date
                </label>
                <input type="hidden" id="hidchckchqdate" name="hidchckchqdate" value='<s:property value="hidchckchqdate"/>'/>
                
                <div style="width:125px; flex-shrink:0;">
                    <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
                    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                </div>

                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px; display:flex; align-items:center; justify-content:flex-end;">
                    <input type="checkbox" id="chckamount" name="chckamount" value="" onchange="checkAmount();" style="margin: 0 4px 0 0;"> Amount
                </label>
                <input type="hidden" id="hidchckamount" name="hidchckamount" value='<s:property value="hidchckamount"/>'/>
                
                <input type="text" id="txtamount" name="txtamount" style="width:125px; flex-shrink:0; text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);" />
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Remarks</label>
                <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>' style="flex:1; min-width:0;"/>
            </div>
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="hidden" id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>'/>
            <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
            <input type="hidden" id="txtfromrate" name="txtfromrate" value='<s:property value="txtfromrate"/>'/>
            <input type="hidden" id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>'/>
            <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
            <input type="hidden" id="txttorate" name="txttorate" value='<s:property value="txttorate"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
            <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
            <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
        </div>

    </div>
</form>  
                
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="printWindow"><div></div><div></div></div>

</div>
</body>
</html>