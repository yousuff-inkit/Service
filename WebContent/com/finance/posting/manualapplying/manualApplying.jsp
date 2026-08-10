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

		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
		 $("#jqxAppliedInvoicing").jqxGrid({ disabled: true});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#cashPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashPaymentGridWindow').jqxWindow('close');
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#maindate').jqxDateTimeInput('getDate');
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val()+"&date="+date);
			  $('#txtforsearch').val(3); 
		     });
		 
	});
	
	function accountSearchContent(url){
	   $('#accountDetailsToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsToWindow').jqxWindow('setContent', data);
		$('#accountDetailsToWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	  var date = $('#maindate').jqxDateTimeInput('getDate');
	    	  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val()+"&date="+date);
			  $('#txtforsearch').val(3);
	       }
	    }
	    
	function funReadOnly(){} 
	
	function funRemoveReadOnly(){}
	
	function funSearchLoad(){}
	
	function funChkButton(){
		/* funReset(); */
	}
	
	function funFocus(){
		document.getElementById("cmbacctype").focus(); 	    		
	}
	
	function funNotify(){	
	  
	  /* Validation */
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Outstanding Amount !!!";
			 return 0;
		 }
		 
		    var rows1 = $("#jqxApplyInvoicing").jqxGrid('getrows');
		    for(var i=0 ; i < rows1.length ; i++){
				if(rows1[0].balance<0){
					document.getElementById("errormsg").innerText="Invalid Outstanding Amount !!!";
					return 0;
				}
		    } 
		    
		    document.getElementById("errormsg").innerText="";
			
	   /* Validation Ends*/
			
		 /* Applying Invoice Grid Saving */
			var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
			var lengthapply=0;
			for(var i=0 ; i < rows.length ; i++){
				    var chks=rows[i].applying;
	  				if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
				 	newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+lengthapply)
				    .attr("name", "test"+lengthapply)
				    .attr("hidden", "true");
				 	lengthapply=lengthapply+1;
				 	
				newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
				newTextBox.appendTo('form');
				}
			}
			$('#gridlength').val(lengthapply);
			 /* Applying Invoice Grid Saving Ends*/
			 
			return 1;
	} 
	
	
	function setValues(){
	  
	  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
	  
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  funSetlabel();
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
      
      var accId = document.getElementById("txtdocno").value;
      if(accId!=0){
    	  funloadappliedgrid();
      }
      
	}
	
	function funloadappliedgrid(){
		  $('#mode').val("A");
		  $('#txtgriddocno').val('');$('#txtdoctype').val('');$('#txtapplyinvoiceamt').val('');$('#txtapplyinvoiceapply').val('');$('#txtapplyinvoicebalance').val('');
		  
		  $("#jqxApplyInvoicing").jqxGrid('clear');
		  $("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
		  
		  $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
	      $("#jqxAppliedInvoicing").jqxGrid({ disabled: false});
			 
		  $("#jqxAppliedInvoicing").jqxGrid({ disabled: false});
		  var accId = document.getElementById("txtdocno").value;
		  var accType = document.getElementById("cmbacctype").value;
		  
	      $("#jqxManualAppliedGrid").load('appliedInvoicingGrid.jsp?accountno='+accId+'&accType='+accType);
	}
	
	function funUpdateChanges(){
		$('#btnSave').mousedown();
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');	
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

#frmManualApplying input[type="text"],
#frmManualApplying select,
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

#frmManualApplying input[type="text"]:focus,
#frmManualApplying select:focus,
.textbox:focus {
    border-color: #007bff;
}

#frmManualApplying input[readonly],
#frmManualApplying input:disabled,
#frmManualApplying select:disabled,
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
</style>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmManualApplying" action="saveManualApplying" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='modern-ui hidden-scrollbar'>

        <!-- General Info -->
        <div class="middle-panel">
            <span class="middle-panel-title">General Info</span>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:60px; flex-shrink:0;">Account</label>
                <select id="cmbacctype" name="cmbacctype" onchange="clearAccountInfo();" value='<s:property value="cmbacctype"/>' style="width:80px; flex-shrink:0;">
                    <option value="AP">AP</option>
                    <option value="AR">AR</option>
                </select>
                <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/>

                <div class="input-search-container" style="width:150px; flex-shrink:0;">
                    <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3 to Search" readonly value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                    <svg class="magnifier-icon" onclick="var date = $('#maindate').jqxDateTimeInput('getDate'); accountSearchContent('<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val()+'&date='+date); $('#txtforsearch').val(3);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>

                <input type="text" id="txtaccname" name="txtaccname" readonly value='<s:property value="txtaccname"/>' style="flex:1; min-width:0; margin-left: 8px;"/>
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>

                <button class="myButton" type="button" id="btnSubmit" name="btnSubmit" onclick="funloadappliedgrid();" style="margin-left: 10px;">Submit</button>
            </div>
        </div>

        <!-- Unapplied Grid -->
        <div class="middle-panel">
            <span class="middle-panel-title">Unapplied</span>
            <div class="grid-container">
                <div id="jqxManualAppliedGrid">
                    <jsp:include page="appliedInvoicingGrid.jsp"></jsp:include>
                </div>
            </div>
        </div>

        <!-- Outstanding Grid -->
        <div class="middle-panel">
            <span class="middle-panel-title">Outstanding</span>
            <div class="grid-container">
                <div id="jqxManualApplingGrid">
                    <jsp:include page="applyInvoicingGrid.jsp"></jsp:include>
                </div>
            </div>
        </div>

        <!-- Summary Row -->
        <div class="middle-panel">
            <span class="middle-panel-title">Summary</span>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:55px; flex-shrink:0;">Doc No</label>
                <input type="text" id="txtgriddocno" name="txtgriddocno" readonly value='<s:property value="txtgriddocno"/>' tabindex="-1" style="width:100px; flex-shrink:0;"/>

                <label class="lbl-right" style="width:60px; flex-shrink:0;">Doc Type</label>
                <input type="text" id="txtdoctype" name="txtdoctype" readonly value='<s:property value="txtdoctype"/>' tabindex="-1" style="width:90px; flex-shrink:0;"/>

                <label class="lbl-right" style="width:55px; flex-shrink:0;">Amount</label>
                <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" readonly value='<s:property value="txtapplyinvoiceamt"/>' tabindex="-1" style="width:100px; flex-shrink:0; text-align: right;"/>
                <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>

                <label class="lbl-right" style="width:55px; flex-shrink:0;">Applying</label>
                <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" readonly value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" style="width:100px; flex-shrink:0; text-align: right;"/>

                <label class="lbl-right" style="width:55px; flex-shrink:0;">Balance</label>
                <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" readonly value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" style="width:100px; flex-shrink:0; text-align: right;"/>

                <button class="myButton" type="button" id="btnUpdate" name="btnUpdate" onkeydown="funUpdateChanges();" onclick="funUpdateChanges();" style="margin-left: 10px;">Update</button>
            </div>
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
            <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
            <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
            <input type="hidden" id="txtoutamount" name="txtoutamount" value='<s:property value="txtoutamount"/>'/>
            <input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        </div>

    </div>
</form>

<div id="cashPaymentGridWindow"><div></div><div></div></div>
<div id="accountDetailsToWindow"><div></div><div></div></div>

</div>
</body>
</html>