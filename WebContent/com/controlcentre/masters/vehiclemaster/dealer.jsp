<%@page import="com.controlcentre.masters.vehiclemaster.dealer.ClsDealerAction" %>
<%ClsDealerAction cda=new ClsDealerAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    margin: 0;
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
$(document).ready(function () {          
    /* Configured for modern UI 24px height */
    $("#dealerdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });  
    setTimeout(function () {
        $("#dealerdate").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#dealerdate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
    
    $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#accountWindow').jqxWindow('close');
      
    document.getElementById("formdet").innerText="Dealer(VDR)";
    document.getElementById("formdetail").value="Dealer";
    document.getElementById("formdetailcode").value="VDR";
    window.parent.formCode.value="VDR";
    window.parent.formName.value="Dealer";
    
    var data1= '<%=cda.searchDetails() %>';
             
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'DOC_NO' , type: 'int' },
            {name : 'name', type: 'String'  },
            {name : 'acc_no', type: 'String'  },
            {name : 'date',type:'date'},
            {name : 'description',type:'string'}
        ],
        localdata: data1,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
             
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);   
        }
    });
           
    $("#jqxDealerSearch1").jqxGrid({
        width: '100%',
        height: 315,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'singlerow',
        sortable: true,
        altrows:true,
        columns: [
            { text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
            { text: 'Dealer',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
            { text: 'Acc No',columntype: 'textbox', filtertype: 'input', datafield: 'acc_no', width: '20%',hidden:true },
            { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
            { text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '40%' }
        ]
    });

    $('#jqxDealerSearch1').on('rowdoubleclick', function (event) { 
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxDealerSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
        document.getElementById("dealername").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "name");
        $("#dealerdate").jqxDateTimeInput('val',$("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        document.getElementById("txtaccname").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "description");
        document.getElementById("txtaccno").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "acc_no");
    });            
});

function accountSearchContent(url) {
    $('#accountWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#accountWindow').jqxWindow('setContent', data);
    }); 
}

function funSearchdblclick(){
    var url=document.URL;
    var reurl=url.split("com/");
    accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
}

function getAcc(event){
    var x= event.keyCode;
    if(x==114){
        var url=document.URL;
        var reurl=url.split("com/");
        accountSearchContent(reurl[0]+'com/search/accountsearch/accountsSearchAP.jsp?dtype='+document.getElementById("formdetailcode").value);
    }
}

function funSearchLoad(){
    changeContent('dealerSearch.jsp', $('#window')); 
}
               
function funReadOnly() {
    $('#frmDealer input').attr('readonly', true);
    $('#dealerdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly() {
    $('#frmDealer input').attr('readonly', false);
    $('#dealerdate').jqxDateTimeInput({ disabled: false}); 
    $('#docno').attr('readonly', true);
    $('#txtaccname').attr('readonly', true);
    $('#dealername').attr('readonly', false);
}

function setValues(){   
    if($('#dealerdatehidden').val()){
        $("#dealerdate").jqxDateTimeInput('val', $('#dealerdatehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus() {
    document.getElementById("dealername").focus();
}

$(function(){
    $('#frmDealer').validate({
        rules: {
            dealername:{ required:true, maxlength:45 } 
        },
        messages: {
            dealername:{ required:" *", maxlength:"max 45 chars" }
        }
    });
});

function funNotify(){
    if(document.getElementById("txtaccname").value==''){
        document.getElementById("errormsg").innerText="A/c is Mandatory";
        return 0;
    }
    else{
        document.getElementById("errormsg").innerText="";
    }
    return 1;
} 

function funExcelBtn(){
    $("#jqxDealerSearch1").jqxGrid('exportdata', 'xls', 'Dealer');
}
</script>
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDealer" action="saveActionDealer" autocomplete="off" >
    <jsp:include page="../../../../header.jsp" />
    
    <div class='modern-ui hidden-scrollbar'>
        <div id="errormsg"></div>

        <!-- Dealer Details Panel -->
        <div class="middle-panel">
            <span class="middle-panel-title">Dealer Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="dealerdate" name="dealerdate" value='<s:property value="dealerdate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:125px;">
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Acc. No.</label>
                <div class="input-search-container" style="width:250px;">
                    <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" readonly placeholder="Press F3" required>
                    <svg class="magnifier-icon" onclick="funSearchdblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Dealer</label>
                <input type="text" name="dealername" id="dealername" value='<s:property value="dealername"/>' style="flex:1;">
            </div>
        </div>

        <!-- Grid Data Panel -->
        <div class="middle-panel" style="padding-bottom:10px;">
            <span class="middle-panel-title">Search Results</span>
            <div id="jqxDealerSearch1" class="grid-container" style="border:none; margin:0;"></div>
        </div>

        <!-- Hidden Logic Fields -->
        <div style="display:none;">
            <input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'>
            <input type="hidden" id="dealerdatehidden" name="dealerdatehidden" value='<s:property value="dealerdatehidden"/>'>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        </div>

    </div>
</form>

<div id="accountWindow"><div></div><div></div></div>

</div>
</body>
</html>