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
    $('#btnvaluechange').hide();
    
    /* Configured for modern UI 24px height */
    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#payDueDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    setTimeout(function () {
        $("#date, #payDueDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date, #payDueDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    refChange();
    chkfoc();
    
    var popupConfig = {theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27};
    $('#customerDetailsWindow').jqxWindow($.extend({}, popupConfig, {width: '60%', height: '60%', maxHeight: '75%', maxWidth: '60%', title: 'Client Search', position: { x: 300, y: 87 }})).jqxWindow('close'); 
    $('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%', maxHeight: '90%', maxWidth: '80%', title: 'Search ', position: { x: 943, y: 0 }, keyboardCloseKey: 27}).jqxWindow('close'); 
    $('#salespersonwindow').jqxWindow($.extend({}, popupConfig, {width: '25%', height: '58%', maxHeight: '70%', maxWidth: '45%', title: 'Sales Person Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    $('#accountsearchwindow').jqxWindow($.extend({}, popupConfig, {width: '25%', height: '58%', maxHeight: '70%', maxWidth: '45%', title: 'Account Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    $('#locationwindow').jqxWindow($.extend({}, popupConfig, {width: '25%', height: '58%', maxHeight: '70%', maxWidth: '45%', title: 'Location Search', position: { x: 420, y: 87 }})).jqxWindow('close');
    $('#searchwndow').jqxWindow({ width: '30%', height: '58%', maxHeight: '90%', maxWidth: '80%', title: 'Search ', position: { x: 420, y: 87 }, keyboardCloseKey: 27}).jqxWindow('close');  
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%', maxHeight: '75%', maxWidth: '50%', title: ' Search', position: { x: 500, y: 60 }, keyboardCloseKey: 27}).jqxWindow('close'); 
    
    $('#date').on('change', function (event) {
        var maindate = $('#date').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
            funDateInPeriod(maindate);
        }
    });

    $('#txtclient').dblclick(function(){
        if($('#mode').val()!= "view") { CustomerSearchContent('clientINgridsearch.jsp'); }
    });

    $('#txtsalesperson').dblclick(function(){
        if($('#mode').val()!= "view") { salespersonSearchContent('salesPersonSearch.jsp'); }
    });

    $('#txtlocation').dblclick(function(){
        if($('#mode').val()!= "view") { $('#locationwindow').jqxWindow('open'); locationSearchContent('locationSearch.jsp'); }
    });

    $('#rrefno').dblclick(function(){
        var clientid=document.getElementById("clientid").value;
        if(clientid>0){
            document.getElementById("errormsg").innerText="";
            var txtlocation=document.getElementById("locationid").value;
            if(txtlocation>0){ document.getElementById("errormsg").innerText=""; }
            else { document.getElementById("errormsg").innerText="Select Location"; document.getElementById("txtlocation").focus(); return 0; }
        }
        else{ document.getElementById("errormsg").innerText="Select a client"; document.getElementById("clientid").focus(); return 0; }
        if($('#mode').val()!= "view") { $('#refnosearchwindow').jqxWindow('open'); refsearchContent('refnosearch.jsp'); }
    });
});

function CustomerSearchContent(url) {
    $('#customerDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#customerDetailsWindow').jqxWindow('setContent', data);
        $('#customerDetailsWindow').jqxWindow('bringToFront');
    }); 
} 

function getSalesPerson(event){
    var x= event.keyCode;
    if(x==114){ salespersonSearchContent('salesPersonSearch.jsp'); }
}

function salespersonSearchContent(url) {
    $('#salespersonwindow').jqxWindow('open');
    $.get(url).done(function(data) {
        $('#salespersonwindow').jqxWindow('setContent', data);
        $('#salespersonwindow').jqxWindow('bringToFront');
    });
}

function getLocation(event){
    var x= event.keyCode;
    if(x==114){ locationSearchContent('locationSearch.jsp'); }
}
         
function accountSearchContent(url) {
    $('#accountsearchwindow').jqxWindow('open');
    $.get(url).done(function(data) {
        $('#accountsearchwindow').jqxWindow('setContent', data);
        $('#accountsearchwindow').jqxWindow('bringToFront');
    });
}       

function locationSearchContent(url) {
    $('#locationwindow').jqxWindow('open');
    $.get(url).done(function(data) {
        $('#locationwindow').jqxWindow('setContent', data);
        $('#locationwindow').jqxWindow('bringToFront');
    });
}

function funReadOnly(){
    $('#frmSalesReturn input').attr('readonly', true );
    $('#frmSalesReturn select').attr('disabled', true);
    $('#date').jqxDateTimeInput({disabled: true});
    $('#payDueDate').jqxDateTimeInput({disabled: true});
    $("#jqxInvoiceReturn").jqxGrid({ disabled: true});
    $('#btnvaluechange').hide();
    chkfoc();
    chktax();
}

function funRemoveReadOnly(){
    gridLoad();
    chkmultiqty();
    chkfoc();
    chktax();
    getCurrencyIds();
    document.getElementById("editdata").value="";
    $('#frmSalesReturn input').attr('readonly', false );
    $('#frmSalesReturn select').attr('disabled', false);
    
    $('#txtclient').attr('readonly', true );
    $('#rrefno').attr('readonly', true );
    $('#txtlocation').attr('readonly', true );
    $('#txtsalesperson').attr('readonly', true );
    $('#txtproductamt').attr('readonly', true );
    $('#txtdiscount').attr('readonly', true );
    $('#txtnettotal').attr('readonly', true );
    $('#orderValue').attr('readonly', true);
    
    $('#payDueDate').jqxDateTimeInput({disabled: false});
    $('#date').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
    $("#jqxInvoiceReturn").jqxGrid({ disabled: false}); 
    
    if ($("#mode").val() == "E") {
        $('#btnvaluechange').show();
        $("#jqxInvoiceReturn").jqxGrid({ disabled: true});
    }
    
    if ($("#mode").val() == "A") {
        $("#txtproductamt").val("0.0"); $("#txtdiscount").val("0.0"); $("#txtnettotal").val("0.0"); $("#descPercentage").val("0.0");
        $("#prodsearchtype").val("0"); $("#orderValue").val("0.0"); $("#roundOf").val("0.0"); $("#nettotal").val("0.0");
        $('#date').val(new Date()); $('#payDueDate').val(new Date());
        $("#jqxInvoiceReturn").jqxGrid('clear'); 
        $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
    }
}

function funSearchLoad(){ changeContent('Mastersearch.jsp'); }
function funChkButton() { /* funReset(); */ }
function funFocus(){ $('#date').jqxDateTimeInput('focus'); }

$(function(){
   $('#frmSalesReturn').validate({
        rules: { txtfromaccid:"required", txtfromamount:{"required":true,number:true} },
        messages: { txtfromaccid:" *", txtfromamount:{required:" *",number:"Invalid"} }
   });
});

function funDateInPeriodchk(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0); edyear.setHours(0,0,0,0); styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value>currentDate){ document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. "; return 0; } 
    document.getElementById("errormsg").innerText="";
    return 1;
}

function funNotify(){   
    var maindate = $('#date').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(maindate);
    if(validdate==0){ return 0; }

    if($('#txtlocation').val()== "") {
        document.getElementById("errormsg").innerText="select location"; document.getElementById("txtlocation").focus(); return 0;
    }

    var rows = $("#jqxInvoiceReturn").jqxGrid('getrows');
    $('#gridlength').val(rows.length);
    var cnt=0;
    for(var i=0 ; i < rows.length ; i++){ 
        newTextBox = $(document.createElement("input")).attr("type", "dil").attr("id", "prodg"+i).attr("name", "prodg"+i).attr("hidden", "true");
        newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"
         +rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netsss+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"
         +rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].rdocno+"::"+rows[i].detdocno+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].fintot);
        newTextBox.appendTo('form');
        cnt=cnt+1;   
    }
    $('#gridlength').val(cnt);
    return 1;
} 

function setValues(){
    if($('#hiddate').val()){ $("#date").jqxDateTimeInput('val', $('#hiddate').val()); }
    if($('#hidpayDueDate').val()){ $("#payDueDate").jqxDateTimeInput('val', $('#hidpayDueDate').val()); }
    if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }
    if($('#hidcmbcurr').val()!=""){
        if($('#hidcmbcurr').val()=="1"){ $('#cmbcurr').val("AFN"); }
        if($('#hidcmbcurr').val()=="2"){ $('#cmbcurr').val("USD"); }
        if($('#hidcmbcurr').val()=="3"){ $('#cmbcurr').val("RUP"); }
    } 
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel(); combochange();
    var masterdoc_no=$('#masterdoc_no').val().trim();
    var refmasterdocno=$('#refmasterdocno').val().trim();
    var dtype=$('#formdetailcode').val().trim();
    var locaid=$('#locationid').val();
    if(masterdoc_no>0){
        funchkforedit();
        $("#btnEdit").attr('disabled', true ); $("#btnDelete").attr('disabled', true ); 
        $("#invoiceDiv").load("invoiceReturnGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&locaid="+locaid+"&cond=2");
    }
}

function getCustomer(event){ var x= event.keyCode; if(x==114){ } }
function funRoundAmt4(value,id){ var res=parseFloat(value).toFixed(4); var res1=(res=='NaN'?"0":res); document.getElementById(id).value=res1; }  
function funRoundAmt2(value,id){ var res=parseFloat(value).toFixed(2); var res1=(res=='NaN'?"0":res); document.getElementById(id).value=res1; }  

function getCurrencyIds(){
    var dates=document.getElementById("masterdate").value;
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items=items.split('####');
            var curidItems=items[0].split(","); var curcodeItems=items[1].split(",");
            var optionscurr = '';
            for ( var i = 0; i < curcodeItems.length; i++) { optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>'; }
            $("select#cmbcurr").html(optionscurr);
            if($('#hidcmbcurr').val()!="") { $('#cmbcurr').val($('#hidcmbcurr').val()); }
        }
    }
    x.open("GET","getCurrencyId.jsp?date="+dates,true); x.send();
}

function getPriceGroup(){ }

function getclinfo(event){
    var x= event.keyCode;
    if(x==114){ $('#customerDetailsWindow').jqxWindow('open'); clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow')); }
} 

function getDocumentSearch(event){
    var x= event.keyCode;
    if(x==114){ $('#customerDetailsWindow').jqxWindow('open'); clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow')); }
} 

function clientSearchContent(url) {
    $.get(url).done(function (data) { $('#customerDetailsWindow').jqxWindow('setContent', data); }); 
} 

function termsSearchContent(url) {
    $('#searchwndow').jqxWindow('open');
    $.get(url).done(function (data) { $('#searchwndow').jqxWindow('setContent', data); $('#searchwndow').jqxWindow('bringToFront'); }); 
} 

function productSearchContent(url) {
    $.get(url).done(function (data) { $('#sidesearchwndow').jqxWindow('open'); $('#sidesearchwndow').jqxWindow('setContent', data); }); 
} 

function refChange(){
    var reftype=$('#cmbreftype').val();
    if(reftype=='DIR'){ $('#rrefno').attr('disabled', true); }
    else{ $('#rrefno').attr('disabled', false); }
}

function gridLoad(){
    var dtype=document.getElementById("formdetailcode").value;
}

function getrefno(event) {
    var clientid=document.getElementById("clientid").value;
    if(clientid>0){ document.getElementById("errormsg").innerText=""; }
    else{ document.getElementById("errormsg").innerText="Select a client"; return 0; }
    var x= event.keyCode;
    if(x==114){ $('#refnosearchwindow').jqxWindow('open'); refsearchContent('refnosearch.jsp'); }
}  
    
function refsearchContent(url) {
    $.get(url).done(function (data) { $('#refnosearchwindow').jqxWindow('setContent', data); }); 
}   
    
function combochange() {
    if($('#hidcmbcurrency').val()!="") { $('#cmbcurr').val($('#hidcmbcurrency').val()); }
    if($('#hidcmbreftype').val()!="") { $('#cmbreftype').val($('#hidcmbreftype').val()); }
    if($('#hidcmbprice').val()!="") { $('#cmbprice').val($('#hidcmbprice').val()); }
    if($('#hidcmbbilltype').val()!="") { $('#cmbbilltype').val($('#hidcmbbilltype').val()); }
    if($('#hidcmbreftype').val()!='DIR') { $('#rrefno').attr('disabled', false); $('#rrefno').attr('readonly', true); }
    if($('#cmbreftype').val()!='DIR'){ $('#btnDelete').attr('disabled', true); }
}
    
function funcalcu(){
    document.getElementById('prddiscount').value="";
    $('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
    var  productTotal=document.getElementById('txtproductamt').value;
    var  descPercentage=document.getElementById('descPercentage').value;
    var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
    var netval=parseFloat(productTotal)-parseFloat(descvalue);
    var  roundOf=document.getElementById('roundOf').value;
    
    if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") { netval=parseFloat(productTotal)+parseFloat(roundOf); }
    
    funRoundAmt2(descvalue,"txtdiscount"); funRoundAmt2(netval,"txtnettotal");
    var aa;
    if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") {
        aa=parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
    }
    else { aa=document.getElementById("txtnettotal").value; }
    document.getElementById("orderValue").value=aa; 
    funRoundAmt2(aa,"orderValue");
    
    var rows = $('#jqxInvoiceReturn').jqxGrid('getrows');
    var rowlength= rows.length;
    var disval=parseFloat(descvalue)/(parseInt(rowlength));
    for(var i=0;i<rowlength;i++) {
        var totamt=rows[i].total;
        var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
        var nettot=parseFloat(totamt)-parseFloat(discounts);
        $('#jqxInvoiceReturn').jqxGrid('setcellvalue',i, "dis" ,discounts);
        $('#jqxInvoiceReturn').jqxGrid('setcellvalue',i, "netotal" ,nettot);
    }
}
        
function funvalcalcu() {
    document.getElementById('prddiscount').value="";
    $('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
    var  productTotal=document.getElementById('txtproductamt').value;
    var  descountVal=document.getElementById('txtdiscount').value;
    var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
    var netval=parseFloat(productTotal)-parseFloat(descountVal);
    funRoundAmt2(descper,"descPercentage"); funRoundAmt2(netval,"txtnettotal");
    funcalcu();
}
        
function roundval() {
    var  netTotaldown=document.getElementById('txtnettotal').value;
    var roundOf=document.getElementById('roundOf').value;
    var  netval=parseFloat(netTotaldown)+parseFloat(roundOf);
    funRoundAmt2(netval,"txtnettotal"); funRoundAmt2(netval,"orderValue");
}
 
function isNumber(evt) {
   var iKeyCode = (evt.which) ? evt.which : evt.keyCode
   if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) { document.getElementById("errormsg").innerText=" Enter Numbers Only"; return false; }
   document.getElementById("errormsg").innerText=""; return true;
}
    
function fundisable() {
    if (document.getElementById('chkdiscount').checked) {
        $.messager.confirm('Confirm', 'Line Discount Will Override With Bill Discount', function(r){
            if (r==false){ document.getElementById('chkdiscount').checked=false; return 0; }
            else { if (document.getElementById('chkdiscount').checked) { $('#descPercentage').attr('disabled', false); $('#txtdiscount').attr('disabled', false); } }
        });
    } else {
        document.getElementById('descPercentage').value=""; document.getElementById('txtdiscount').value="";
        var summaryData3= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
        $('#descPercentage').attr('disabled', true); $('#txtdiscount').attr('disabled', true);
        $('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
    }
}
    
function chkfoc() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim(); var item = items.split('##'); var foc  = item[0]; var kg = item[1];
            if(parseInt(foc)>0) { $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'foc'); } else { $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'foc'); }
            if(parseInt(kg)>0) { $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'kgprice'); $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'totwtkg'); }
            else { $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'kgprice'); $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'totwtkg'); } 
        }
    }
    x.open("GET","checkfoc.jsp",true); x.send();
}

function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
        if (r){
            document.getElementById("editdata").value="Editvalue";
            $('#rrefno').attr('disabled', false); $('#rrefno').attr('readonly', true);
            $("#jqxInvoiceReturn").jqxGrid({ disabled: false});
            $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
        }
    });
}

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveSalesInvoiceReturn");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"printinvcashret?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=CASH","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else { $.messager.alert('Message','Select a Document....!','warning'); return false; }
}
        
function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            if(parseInt(items)>0) { $("#btnEdit").attr('disabled', true ); $("#btnDelete").attr('disabled', true ); }
        }
    }
    x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
    x.send();
}
</script>

</head>
<body onload="setValues();getCurrencyIds();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSalesReturn" action="saveSalesInvoiceReturn" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include> 

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <input type="text" name="gridtext" id="gridtext" style="display:none;" value='<s:property value="gridtext"/>'/>   
    <input type="text" name="gridtext1" id="gridtext1" style="display:none;" value='<s:property value="gridtext1"/>' />

    <!-- Header Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Header Details</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:125px;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="docno" style="width:125px;" value='<s:property value="docno"/>' tabindex="-1" readonly/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Sales Person</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="txtsalesperson" name="txtsalesperson" placeholder="Press F3" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
                <svg class="magnifier-icon" onclick="$('#txtsalesperson').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/>
            
            <label class="lbl-right" style="width:80px;">Mode of Pay</label>
            <select id="cmbmodeofpay" name="cmbmodeofpay" style="width:125px;" value='<s:property value="cmbmodeofpay"/>'>
                <option value="cash">CASH</option>
            </select>
            <input type="hidden" id="hidcmbmodeofpay" name="hidcmbmodeofpay" value='<s:property value="hidcmbmodeofpay"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Location</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="txtlocation" name="txtlocation" placeholder="Press F3" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/>
        </div>
    </div>

    <!-- Customer & Terms Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Customer & Terms</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Customer</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtclient" name="txtclient" placeholder="Press F3" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtclient').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txtclientdet" name="txtclientdet" style="flex:1;" value='<s:property value="txtclientdet"/>' tabindex="-1" readonly/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select name="cmbcurr" id="cmbcurr" style="width:125px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/>
            <input type="text" id="currate" name="currate" style="width:100px; text-align:right;" value='<s:property value="currate"/>'/>
            
            <label id="billname" class="lbl-right" style="width:80px; margin-left:auto;">Bill Type</label>
            <select id="cmbbilltype" name="cmbbilltype" style="width:125px;" value='<s:property value="cmbbilltype"/>'>
                <option value="1">VAT</option>
            </select>
            <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Ref. Type</label>
            <select id="cmbreftype" name="cmbreftype" style="width:125px;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
                <option value="INV">INV</option>
            </select>
            <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
            
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="rrefno" name="rrefno" placeholder="Press F3 to Search" onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
                <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <select hidden="true" id="cmbprice" name="cmbprice" style="display:none;" value='<s:property value="cmbprice"/>'>
                <option></option>
            </select>
            <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Payment Due</label>
            <div style="width: 125px;">
                <div id="payDueDate" name="payDueDate" value='<s:property value="payDueDate"/>'></div>
            </div>
            <input type="hidden" id="hidpayDueDate" name="hidpayDueDate" value='<s:property value="hidpayDueDate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Del. Terms</label>
            <input type="text" id="txtdelterms" name="txtdelterms" style="flex:1;" value='<s:property value="txtdelterms"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Payment Terms</label>
            <input type="text" id="txtpaymentterms" name="txtpaymentterms" style="flex:1;" value='<s:property value="txtpaymentterms"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>

    <!-- Grid Data Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="invoiceDiv" class="grid-container">
            <jsp:include page="invoiceReturnGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" value='<s:property value="orderValue"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="refmasterdocno" name="refmasterdocno" value='<s:property value="refmasterdocno"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="termsgridlength" name="termsgridlength" value='<s:property value="termsgridlength"/>'/>
        <input type="hidden" id="servgridlen" name="servgridlen" value='<s:property value="servgridlen"/>'/>
        <input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
        <input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
        <input type="hidden" name="txtnettotal" id="txtnettotal" value='<s:property value="txtnettotal"/>'>
        <input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
        <input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
        <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
        <input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>
        <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
        <input type="hidden" id="hidload" name="hidload" value='<s:property value="hidload"/>'/>
        <input type="hidden" id="hidvatype" name="hidvatype" value='<s:property value="hidvatype"/>'/>
        <input type="hidden" id="clntacno" name="clntacno" value='<s:property value="clntacno"/>'/>
    </div>

</div>
</form>
    
<!-- Search Windows -->
<div id="salespersonwindow"><div></div><div></div></div>
<div id="customerDetailsWindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div>  
<div id="refnosearchwindow"><div></div></div>
<div id="searchwndow"><div></div></div>
<div id="locationwindow"><div></div></div>
<div id="accountsearchwindow"><div></div></div>  

</div>
</body>
</html>