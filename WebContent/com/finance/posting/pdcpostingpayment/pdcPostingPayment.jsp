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
		 $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
		 $('#btnExcel').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 $('#btnSave').attr('disabled', true ); 
		 
		 $("#jqxDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value: null });
		 $("#jqxFromDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxToDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#chequedate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#checkchequedate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');  
		 
		 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		
		$('#txtaccid').dblclick(function(){
			  accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());
			  });
		
		
		 getPDCAccounts();
		 $('#jqxFromDate').val(new Date());
	     $('#chequedate').val(new Date());
		 $('#checkchequedate').val(new Date());
		 $("#jqxJournalVoucher").jqxGrid('clear'); 
		 $("#jqxJournalVoucher").jqxGrid('addrow', null, {}); 
		 $("#jqxJournalVoucher").jqxGrid({ disabled: true});
	     $("#jqxJournalVoucherApplying").jqxGrid('clear');
		 $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		 $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
	});
	
	function accountSearchContent(url){
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getPDCAccounts(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
  			
  			    $('#txtpdcdocno').val(docNoItems);	
  			    $('#txtpdcaccid').val(accountIdItems);
  			    $('#txtpdcaccname').val(accountItems);
  			  	$('#txtpdcatype').val(accountTypeItems);
			    $('#txtpdccurid').val(accountCurIdItems);
			    $('#txtpdcrate').val(accountRateItems);
			    $('#txtpdctype').val(accCurrTypeItems);
  		}
  		}
  		x.open("GET", "getPDCAccounts.jsp", true);
  		x.send();
   }
	
	 function getAcc(event){
         var x= event.keyCode;
         if(x==114){
        	 accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());
            }
         }
	 
	 function funReadOnly(){} 
		
	 function funRemoveReadOnly(){}
	 
	 function funSearchLoad(){}
		
	 function funChkButton(){
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	document.getElementById("cmbcriteria").focus(); 	    		
	    }
	 
	 function funNotify(){	
		 
		 /* Validation */
		 
		    if(document.getElementById("cmbcriteria").value=="" || document.getElementById("cmbcriteria").value==null){
			  document.getElementById("errormsg").innerText="Criteria is Mandatory.";
			  return 0;
		    }
		  
		  	if(document.getElementById("jqxDate").value=="" || document.getElementById("jqxDate").value==null){
			  document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
			  return 0;
		  	}
	    	
			var postdate = $('#jqxDate').jqxDateTimeInput('getDate');
			var postvaliddate=funDateInPeriod(postdate);
			if(postvaliddate==0){
			return 0;	
			}
			
			if($('#txtchequevalidation').val()==1){
				 document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
				 return 0;
			}
			
			if($('#cmbcriteria').val()!='4'){
				var applyrows=$("#jqxJournalVoucherApplying").jqxGrid('getrows');
				if(applyrows.length<=1){
					document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					return 0;
			   }
			}else if($('#cmbcriteria').val()=='4'){
				if(document.getElementById("txtchequeno").value=="" || document.getElementById("txtchequeno").value==null){
					document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					return 0;
				 }
			}
			
			if($('#cmbcriteria').val()=='1'){
				var rows1 = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
				if(typeof(rows1[0].doc_no) == "undefined" || typeof(rows1[0].doc_no) == "NaN" || rows1[0].doc_no == ""){
					document.getElementById("errormsg").innerText="Select a Bank Account.";
					return 0;
				}
			}
			
	     document.getElementById("errormsg").innerText="";
		 /* Validation Ends*/
			
		 /* Journal Voucher Applying Grid Saving */
    	 var rows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
 		 var length=0;
 		 for(var i=0 ; i < rows.length ; i++){
 			var chk=rows[i].doc_no;
			if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
				length=length+1;
				
			var amount,baseamount,id;
			if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
				 amount=rows[i].credit*-1;
				 baseamount=rows[i].baseamount*-1;
				 id=-1;
				
			}
			
			if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
				 amount=rows[i].debit;
				 baseamount=rows[i].baseamount;
				 id=1;
			}
			
			if($('#txtdtype').val()=='IBP'){
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+id+":: 0:: 0:: "+rows[i].sr_no);
			} else if(($('#txtdtype').val()=='COT' && $('#txtibbranch').val()=='1')){
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+id+":: 0:: 0:: "+rows[i].sr_no);
			} else{
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+rows[i].sr_no+":: "+id+":: 0:: 0");
			}
			newTextBox.appendTo('form');
			}
 		 }
		 $('#gridlength').val(length);
 		/* Journal Voucher Applying Grid Saving Ends */
 		 
 		  $('#jqxFromDate').jqxDateTimeInput({disabled: false});
		  $('#jqxToDate').jqxDateTimeInput({disabled: false});
		  $('#jqxDate').jqxDateTimeInput({disabled: false});
		  $('#chequedate').jqxDateTimeInput({disabled: false});
		  $('#cmbcriteria').attr('disabled', false);
		  $('#cmbacctype').attr('disabled', false);
		  
		  return 1;
		} 
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbcriteria").value=document.getElementById("hidcmbcriteria").value;
		  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
		  
		  if($('#hidjqxFromDate').val()){
				 $("#jqxFromDate").jqxDateTimeInput('val', $('#hidjqxFromDate').val());
			  }
		  
		  if($('#hidjqxToDate').val()){
				 $("#jqxToDate").jqxDateTimeInput('val', $('#hidjqxToDate').val());
			  }
		  
		  if($('#hidjqxDate').val()){
				 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());
			  }
			  
		  if($('#hidchequedate').val()){
				 $("#chequedate").jqxDateTimeInput('val', $('#hidchequedate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  $('#cmbcriteria').attr('disabled', false);$('#cmbacctype').attr('disabled', false);
		  dateDisable();
		  
		}
		
		function checkChequeDate(){
		 var posted=$('#cmbcriteria').val();
         if(posted==4){
		  var newchequedate = $('#chequedate').jqxDateTimeInput('getDate');
		  var oldchequedate = $('#checkchequedate').jqxDateTimeInput('getDate');
		  if(newchequedate<oldchequedate){
			  document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
			  $('#txtchequevalidation').val(1);
			  return 0;
		  }
		  document.getElementById("errormsg").innerText="";
		  $('#txtchequevalidation').val(0);
		  return 1;
		  }
	  }
	  
	  function gridloading(){
		  $('#mode').val("A");
		  var criteria = document.getElementById("cmbcriteria").value;
		  var accId = document.getElementById("txtdocno").value;
		  var accType = document.getElementById("cmbacctype").value;
		  var fromDate = document.getElementById("jqxFromDate").value;
		  var toDate = document.getElementById("jqxToDate").value;
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#jqxJournalVoucherGrid").load('journalVoucherGrid.jsp?txtcriteria='+criteria+'&accId='+accId+'&accType='+accType+'&fromDate='+fromDate+'&toDate='+toDate+'&check='+check);
	  }
	  
	  function funloadgrid(){
		    
			if(document.getElementById("cmbcriteria").value=="" || document.getElementById("cmbcriteria").value==null){
			  document.getElementById("errormsg").innerText="Criteria is Mandatory.";
			  return 0;
		    }
			
			if(document.getElementById("jqxDate").value=="" || document.getElementById("jqxDate").value==null){
			  document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
			  return 0;
		    }
		    var date = $('#jqxDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(validdate==0){
			return 0;	
			}
		  
		  document.getElementById("errormsg").innerText="";
		  
		  $("#jqxJournalVoucher").jqxGrid({ disabled: false});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  
		  getPDCAccounts();
		  gridloading();
		  }
	  
	  function dateDisable(){
		 var posted=$('#cmbcriteria').val();
         if(posted==1){
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
        	 $("#pdcPostponedDiv").prop("hidden", true);
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
         }else if(posted==4){
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
        	 $("#pdcPostponedDiv").prop("hidden", false);
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", true);
         }else{
        	 $('#jqxFromDate').jqxDateTimeInput({disabled: false});
        	 $("#pdcPostponedDiv").prop("hidden", true);
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
         }
	  }
	 
	  function clearClientInfo(){
		  $("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
		  if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		  $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		  $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  $("#jqxJournalVoucher").jqxGrid('clear');
		  $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
	  }
	  
	   function datechange(){
		    var date = $('#jqxDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(validdate==0){
			return 0;	
			}
			
		   $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		   $("#jqxJournalVoucherApplying").jqxGrid('clear');
		   $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		   $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		   $("#jqxJournalVoucher").jqxGrid('clear');
		   $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
	  }
	   
	   function funUpdateChanges(){
			$('#btnSave').mousedown();
		}
	  
</script>
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

#frmPDCPostingPayment input[type="text"],
#frmPDCPostingPayment select,
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

#frmPDCPostingPayment input[type="text"]:focus,
#frmPDCPostingPayment select:focus,
.textbox:focus {
    border-color: #007bff;
}

#frmPDCPostingPayment input[readonly],
#frmPDCPostingPayment input:disabled,
#frmPDCPostingPayment select:disabled,
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

#errormsg {
    color: #e53e3e;
    font-size: 12px;
    font-weight: 600;
    padding: 4px 0;
}

.myButton, .btn {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .btn:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
}

/* Icon buttons (View / Save Changes) */
.icon {
    width: 30px;
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    background-color: #E0ECF8;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0;
    box-sizing: border-box;
    transition: background 0.2s;
}
.icon:hover {
    background-color: #cfe0f5;
}

button[id="btnview"] {
    cursor: pointer;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Grid Containers */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* JQX Widget Overrides for 24px Alignment */
.jqx-datetimeinput-input {
    height: 24px !important;
    line-height: 24px !important;
    margin-top: 0px !important;
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
}
.jqx-action-button {
    height: 24px !important;
}

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
    flex-wrap: wrap;
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
</style>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmPDCPostingPayment" action="savePDCPostingPayment" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='modern-ui hidden-scrollbar'>

        <!-- Criteria / Filter Panel -->
        <div class="middle-panel">
            <span class="middle-panel-title">Criteria</span>

            <div class="field-row">
                <label class="lbl-right" style="width:60px; flex-shrink:0;">Criteria</label>
                <select id="cmbcriteria" name="cmbcriteria" value='<s:property value="cmbcriteria"/>' onchange="dateDisable();getPDCAccounts();clearClientInfo();" style="width:220px; flex-shrink:0;">
                    <option value="">--Select--</option>
                    <option value="1">PDC to be Posted</option>
                    <option value="2">PDC to be Returned</option>
                    <option value="3">Posted PDC to be Dishonoured</option>
                    <option value="4">PDC to be Postponed</option>
                    <option value="5">Retuned PDC to be Reversed</option>
                    <option value="6">Dishourned PDC to be Reversed</option>
                    <option value="7">CDC to be Dishourned</option>
                </select>
                <input type="hidden" id="hidcmbcriteria" name="hidcmbcriteria" value='<s:property value="hidcmbcriteria"/>'/>

                <label class="lbl-right" style="width:40px; flex-shrink:0; margin-left: 10px;">From</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="jqxFromDate" name="jqxFromDate" value='<s:property value="jqxFromDate"/>'></div>
                    <input type="hidden" id="hidjqxFromDate" name="hidjqxFromDate" value='<s:property value="hidjqxFromDate"/>'/>
                </div>

                <label class="lbl-right" style="width:25px; flex-shrink:0;">To</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="jqxToDate" name="jqxToDate" value='<s:property value="jqxToDate"/>'></div>
                    <input type="hidden" id="hidjqxToDate" name="hidjqxToDate" value='<s:property value="hidjqxToDate"/>'/>
                </div>

                <label class="lbl-right" style="width:55px; flex-shrink:0;">Posting</label>
                <div style="width: 125px; flex-shrink:0;">
                    <div id="jqxDate" name="jqxDate" onchange="datechange();" value='<s:property value="jqxDate"/>'></div>
                    <input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>'/>
                </div>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:60px; flex-shrink:0;">Account</label>
                <select id="cmbacctype" name="cmbacctype" onchange="clearClientInfo();" value='<s:property value="cmbacctype"/>' style="width:110px; flex-shrink:0;">
                    <option value="0">--Select--</option>
                    <option value="BANK">Bank</option>
                    <option value="AP">AP</option>
                    <option value="AR">AR</option>
                </select>
                <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/>

                <div class="input-search-container" style="width:150px; flex-shrink:0;">
                    <input type="text" id="txtaccid" readonly name="txtaccid" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                    <svg class="magnifier-icon" onclick="accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>

                <input type="text" id="txtaccname" readonly name="txtaccname" value='<s:property value="txtaccname"/>' style="flex:1; min-width:150px;"/>
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>

                <button type="button" id="btnview" name="btnview" title="View" class="icon" onclick="funloadgrid();" style="margin-left: 10px;"><img alt="View" src="<%=contextPath%>/icons/process2.png" width="16" height="16"></button>
                <button type="button" class="icon" id="btnUpdate" name="btnUpdate" title="Save Changes" onclick="funUpdateChanges();"><img alt="saveChanges" src="<%=contextPath%>/icons/save_new.png"></button>
            </div>
        </div>

        <!-- Journal Voucher Grid -->
        <div class="grid-container" style="margin-bottom: 10px;">
            <div id="jqxJournalVoucherGrid">
                <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- Journal Voucher Applying Grid -->
        <div class="grid-container" style="margin-bottom: 15px;">
            <div id="jqxJournalVoucherApplyingGrid">
                <jsp:include page="journalVoucherApplyingGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- PDC Postponed Panel -->
        <div id="pdcPostponedDiv" hidden="true">
            <div class="middle-panel" style="background: #ECF8E0;">
                <span class="middle-panel-title">PDC Postponed</span>

                <div class="field-row">
                    <label class="lbl-right" style="width:50px; flex-shrink:0;">Bank</label>
                    <input type="text" id="txtbankaccid" name="txtbankaccid" readonly value='<s:property value="txtbankaccid"/>' style="width:150px; flex-shrink:0;"/>

                    <input type="text" id="txtbankaccname" name="txtbankaccname" readonly value='<s:property value="txtbankaccname"/>' style="flex:1; min-width:0; margin-left: 8px;"/>
                    <input type="hidden" id="txtbankdocno" name="txtbankdocno" value='<s:property value="txtbankdocno"/>'/>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Cheque No.</label>
                    <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>' style="width:150px; flex-shrink:0;"/>

                    <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Cheque Date</label>
                    <div style="width: 125px; flex-shrink:0;">
                        <div id="chequedate" name="chequedate" onchange="checkChequeDate();" value='<s:property value="chequedate"/>'></div>
                        <input type="hidden" id="hidchequedate" name="hidchequedate" value='<s:property value="hidchequedate"/>'/>
                        <div hidden="true" id="checkchequedate" name="checkchequedate" value='<s:property value="checkchequedate"/>'></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="txtpdcdocno" name="txtpdcdocno" value='<s:property value="txtpdcdocno"/>'/>
            <input type="hidden" id="txtpdcaccid" name="txtpdcaccid" value='<s:property value="txtpdcaccid"/>'/>
            <input type="hidden" id="txtpdcaccname" name="txtpdcaccname" value='<s:property value="txtpdcaccname"/>'/>
            <input type="hidden" id="txtpdcatype" name="txtpdcatype" value='<s:property value="txtpdcatype"/>'/>
            <input type="hidden" id="txtpdccurid" name="txtpdccurid" value='<s:property value="txtpdccurid"/>'/>
            <input type="hidden" id="txtpdcrate" name="txtpdcrate" value='<s:property value="txtpdcrate"/>'/>
            <input type="hidden" id="txtpdctype" name="txtpdctype" value='<s:property value="txtpdctype"/>'/>
            <input type="hidden" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'/>
            <input type="hidden" id="txtgriddocno" name="txtgriddocno" value='<s:property value="txtgriddocno"/>'/>
            <input type="hidden" id="txtrowno" name="txtrowno" value='<s:property value="txtrowno"/>'/>
            <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
            <input type="hidden" id="txtposttrno" name="txtposttrno" value='<s:property value="txtposttrno"/>'/>
            <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
            <input type="hidden" id="txtibbranch" name="txtibbranch" value='<s:property value="txtibbranch"/>'/>
            <input type="hidden" id="typevalue" name="typevalue" value='<s:property value="typevalue"/>'/>
            <input type="hidden" id="txtchequevalidation" name="txtchequevalidation" value='<s:property value="txtchequevalidation"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
        </div>

    </div>
</form>
<div id="accountDetailsWindow"><div></div><div></div></div>

</div>
</body>
</html>