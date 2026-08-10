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

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
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

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
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

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
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
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
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

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
    $(document).ready(function() {
        /* Configured for modern UI 24px height */
        $("#jqxChqPrintSetUpDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        setTimeout(function () {
            $("#jqxChqPrintSetUpDate").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $("#jqxChqPrintSetUpDate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
        
        $('#bankDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#bankDetailsWindow').jqxWindow('close');
        
        $('#txtbankid').dblclick(function(){
            bankSearchContent('bankDetails.jsp');
        });
    });
    
    function bankSearchContent(url) {
        $('#bankDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#bankDetailsWindow').jqxWindow('setContent', data);
            $('#bankDetailsWindow').jqxWindow('bringToFront');
        }); 
    } 
    
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
            $.messager.alert('Message',' Enter Numbers Only ','warning');   
            return false;
        }
        return true;
    }
    
    function getBankDetails(event){
        var x= event.keyCode;
        if(x==114){
            bankSearchContent('bankDetails.jsp');
        }
    }
    
    function funReadOnly(){
        $('#frmChequePrintingSetUp input').attr('readonly', true );
        $('#jqxChqPrintSetUpDate').jqxDateTimeInput({disabled: true});
    }
    
    function funRemoveReadOnly(){
        $('#frmChequePrintingSetUp input').attr('readonly', false );
        $('#jqxChqPrintSetUpDate').jqxDateTimeInput({disabled: false});
        $('#txtbankid').attr('readonly', true);
        $('#txtbankname').attr('readonly', true);
        $('#docno').attr('readonly', true);
        
        if ($("#mode").val() == "A") {
            $('#jqxChqPrintSetUpDate').val(new Date());
        }
    }
    
    function funSearchLoad(){
        changeContent('cpsMainSearch.jsp');   
    }
        
    function funChkButton() {
        /* funReset(); */
    }
     
    function funFocus(){
        $('#jqxChqPrintSetUpDate').jqxDateTimeInput('focus');           
    }
    
    function funNotify(){   
        return 1;
    } 
      
    function setValues(){
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
    }
      
    function funPrintBtn(){
        if (($("#mode").val() == "view") && $("#docno").val()!="") {
            var url=document.URL;
            var reurl=url.split("saveChequePrintingSetUp");
            $("#docno").prop("disabled", false);                
            var win= window.open(reurl[0]+"printChequeVoucher?docno="+document.getElementById("docno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
        } else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        }
    }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmChequePrintingSetUp" action="saveChequePrintingSetUp" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <!-- 1. Setup Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Setup Details</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id='jqxChqPrintSetUpDate' name='jqxChqPrintSetUpDate' value='<s:property value="jqxChqPrintSetUpDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxChqPrintSetUpDate" name="hidjqxChqPrintSetUpDate" value='<s:property value="hidjqxChqPrintSetUpDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtchqsetupdocno" style="width:125px;" value='<s:property value="txtchqsetupdocno"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- 2. Bank Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Bank Details</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Bank Account</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="txtbankid" name="txtbankid" placeholder="Press F3" onkeydown="getBankDetails(event);" value='<s:property value="txtbankid"/>'/>
                <svg class="magnifier-icon" onclick="$('#txtbankid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtbankdocno" name="txtbankdocno" value='<s:property value="txtbankdocno"/>'/>
            
            <label class="lbl-right" style="width:80px;">Bank Name</label>
            <input type="text" id="txtbankname" name="txtbankname" style="flex:1;" value='<s:property value="txtbankname"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- 3. Cheque Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Cheque Print Coordinates</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Page Size</label>
            <div style="display:flex; gap:5px; align-items:center;">
                <input type="text" id="txtpageheight" name="txtpageheight" style="width:60px; text-align:right;" placeholder="Height" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtpageheight"/>'/>
                <input type="text" id="txtpagewidth" name="txtpagewidth" style="width:60px; text-align:right;" placeholder="Width" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtpagewidth"/>'/>
            </div>

            <label class="lbl-right" style="width:100px; margin-left:auto;">Date Layout</label>
            <div style="display:flex; gap:5px; align-items:center;">
                <input type="text" id="txtdate" name="txtdate" style="width:60px; text-align:right;" placeholder="Ver" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdate"/>'/>
                <input type="text" id="txtdate1" name="txtdate1" style="width:60px; text-align:right;" placeholder="Hor" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdate1"/>'/>
            </div>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Pay To</label>
            <div style="display:flex; gap:5px; align-items:center;">
                <input type="text" id="txtvertical" name="txtvertical" style="width:60px; text-align:right;" placeholder="Ver" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtvertical"/>'/>
                <input type="text" id="txthorizontal" name="txthorizontal" style="width:60px; text-align:right;" placeholder="Hor" onkeypress="javascript:return isNumber(event)" value='<s:property value="txthorizontal"/>'/>
                <input type="text" id="txtlength" name="txtlength" style="width:60px; text-align:right;" placeholder="Len" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtlength"/>'/>
            </div>

            <label class="lbl-right" style="width:100px; margin-left:auto;">Account Payee</label>
            <div style="display:flex; gap:5px; align-items:center;">
                <input type="text" id="txtaccountpaying" name="txtaccountpaying" style="width:60px; text-align:right;" placeholder="Ver" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtaccountpaying"/>'/>
                <input type="text" id="txtaccountpaying1" name="txtaccountpaying1" style="width:60px; text-align:right;" placeholder="Hor" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtaccountpaying1"/>'/>
            </div>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Amt Words 1</label>
            <div style="display:flex; gap:5px; align-items:center;">
                <input type="text" id="txtamtvertical" name="txtamtvertical" style="width:60px; text-align:right;" placeholder="Ver" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamtvertical"/>'/>
                <input type="text" id="txtamthorizontal" name="txtamthorizontal" style="width:60px; text-align:right;" placeholder="Hor" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamthorizontal"/>'/>
                <input type="text" id="txtamtlength" name="txtamtlength" style="width:60px; text-align:right;" placeholder="Len" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamtlength"/>'/>
            </div>

            <label class="lbl-right" style="width:100px; margin-left:auto;">Amount</label>
            <div style="display:flex; gap:5px; align-items:center;">
                <input type="text" id="txtamount" name="txtamount" style="width:60px; text-align:right;" placeholder="Ver" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamount"/>'/>
                <input type="text" id="txtamount1" name="txtamount1" style="width:60px; text-align:right;" placeholder="Hor" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamount1"/>'/>
            </div>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Amt Words 2</label>
            <div style="display:flex; gap:5px; align-items:center;">
                <input type="text" id="txtamt1vertical" name="txtamt1vertical" style="width:60px; text-align:right;" placeholder="Ver" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamt1vertical"/>'/>
                <input type="text" id="txtamt1horizontal" name="txtamt1horizontal" style="width:60px; text-align:right;" placeholder="Hor" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamt1horizontal"/>'/>
                <input type="text" id="txtamt1length" name="txtamt1length" style="width:60px; text-align:right;" placeholder="Len" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtamt1length"/>'/>
            </div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>

</div>
</form>

<div id="bankDetailsWindow">
    <div></div><div></div>
</div>  
</div>
</body>
</html>