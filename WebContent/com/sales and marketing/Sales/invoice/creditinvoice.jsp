<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html> 
<html>
<% String contextPath=request.getContextPath();%>

<%
String mod = request.getParameter("mod") == null ? "" : request.getParameter("mod").toString();
String  docno = request.getParameter("docno") == null? "0": request.getParameter("docno").toString() ;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>

<style type="text/css">
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
.modern-ui input[type="password"],
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
.modern-ui input[type="password"]:focus,
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
.modern-ui .myButton, .modern-ui .btn, .modern-ui .myButtons {
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
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
.modern-ui .myButton:hover, .modern-ui .btn:hover, .modern-ui .myButtons:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

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
    margin-bottom: 10px;
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

/* Original specific classes preserved for compatibility */
.classpass { -webkit-text-security: disc; }
.blink {
  animation: blink-animation 2s steps(5, start) infinite;
  -webkit-animation: blink-animation 2s steps(5, start) infinite;
}
@keyframes blink-animation { to { visibility: hidden; } }
@-webkit-keyframes blink-animation { to { visibility: hidden; } }

#divname {
    background-color: #e2c791;
    box-shadow: 10px 10px grey;
    position:fixed;z-index:1000;right:30px;top:100px;  
}
</style>

<script type="text/javascript">
var mod1='<%=mod%>';                
var tempdocno='<%=docno%>';

$(document).ready(function() {

    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#payDueDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render to maintain strict 24px height */
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
    $('#cmbvatype').hide();
    $('#vatype').hide(); 
    document.getElementById("cmbvatype").value="";
    document.getElementById("cmbvatype").value="exclusive";
    $('#btnvaluechange').hide();
    $('#disitems').hide();
    getVatConfig();
    chkfoc();

    document.getElementById("checkhidegrid").value="0";

    $('#userwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27}).jqxWindow('close');  
    $('#customerDetailsWindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27}).jqxWindow('close'); 
    $('#sidesearchwndow').jqxWindow({  width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27}).jqxWindow('close'); 
    $('#salespersonwindow').jqxWindow({ width : '25%', height : '58%', maxHeight : '70%', maxWidth : '45%', title : 'Sales Person Search', position : { x : 420, y : 87 }, theme : 'energyblue', showCloseButton : true, keyboardCloseKey : 27 }).jqxWindow('close');
    $('#salwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27}).jqxWindow('close');
    $('#accountsearchwindow').jqxWindow({ width : '25%', height : '58%', maxHeight : '70%', maxWidth : '45%', title : 'Account Search', position : { x : 420, y : 87 }, theme : 'energyblue', showCloseButton : true, keyboardCloseKey : 27 }).jqxWindow('close');
    $('#locationwindow').jqxWindow({ width : '25%', height : '58%', maxHeight : '70%', maxWidth : '45%', title : 'Location Search', position : { x : 420, y : 87 }, theme : 'energyblue', showCloseButton : true, keyboardCloseKey : 27 }).jqxWindow('close');
    $('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : { x : 420, y : 87 }, keyboardCloseKey: 27}).jqxWindow('close');  
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27}).jqxWindow('close'); 

    $('#salesman').dblclick(function(){
        if ($("#mode").val() == "A" || $("#mode").val() == "E") { 
            $('#salwindow').jqxWindow('open');
            innerWindowSearchContent('salesmanSearchGrid.jsp?id=1','salwindow');
        }               
    });
        
    $('#shipto').dblclick(function(){
        if($('#mode').val()!= "view") {
            shipSearchContent('shipmasterSearch.jsp?');
        }
    }); 

    $('#date').on('change', function (event) {
        var maindate = $('#date').jqxDateTimeInput('getDate');
         if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
            funDateInPeriod(maindate);
            getProduct();
         }
        if($("#mode").val() == "A" && parseInt($("#clientid").val())>0){
            getClientDueDate();
        }
    });

    $('#user_namess').dblclick(function(){
        if($('#mode').val()!= "view") {
            usersearchcontent('searchuser.jsp?'); 
        }
    });

    $('#txtsalesperson').dblclick(function(){
        if($('#mode').val()!= "view") {
            salespersonSearchContent('salesPersonSearch.jsp');
        }
    });

    $('#txtlocation').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#locationwindow').jqxWindow('open');
            locationSearchContent('locationSearch.jsp');  
        }
    });

    $("#sqotprdname").change(function(){
        var dl=$("#sqotprdts")[0];
        var el=$("#sqotprdname")[0];  
        if(el.value.trim() != ''){
            var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
            var tax = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-tax')
            var unit = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unit');
            var brand = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-brand');
            var psrno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-psrno')
            var specid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-specid');
            var unitdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitdoc');
            var uprice = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-uprice')
            var taxdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxdoc');
            var allw = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-allowdiscount');
            var balqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-balqtystock');
            var oldqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-oldqtystock');
            var totqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-totqtystock');
            
            var clnttax=document.getElementById("hidcmbtaxqot").value;
            if(parseInt(clnttax)==0){ tax=0; } 
            
            document.getElementById("sqotprdid").value=prdid;
            document.getElementById("taxpers").value=tax;
            document.getElementById("unit").value=unit;
            document.getElementById("brand").value=brand;
            document.getElementById("uprice").value=uprice;
            document.getElementById("temppsrno").value=psrno;
            document.getElementById("hidpsrno").value=psrno;
            document.getElementById("tempunitdocno").value=unitdoc;
            document.getElementById("tempspecid").value=specid;
            getunit(psrno);
            document.getElementById("taxdoc").value=taxdoc;
            document.getElementById("allowdiscount").value=allw;
            document.getElementById("totalstock").value=balqty;
            document.getElementById("oldqtystock").value=oldqty; 
            document.getElementById("totqtystock").value=totqty;        
        }
    });
    
    $("#sqotprdid").change(function(){
        var dl=$("#sqotproductid")[0];
        var el=$("#sqotprdid")[0];
        if(el.value.trim() != ''){
            var prdname = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-prdname');
            var tax = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-tax')
            var unit = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unit');
            var brand = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-brand');
            var psrno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-psrno')
            var specid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-specid');
            var unitdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitdoc');
            var uprice = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-uprice')
            var taxdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-taxdoc');
            var allw = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-allowdiscount');
            var balqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-balqtystock');
            var oldqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-oldqtystock');
            var totqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-totqtystock');
            
            var clnttax=document.getElementById("hidcmbtaxqot").value;  
            if(parseInt(clnttax)==0){ tax=0; } 
            
            document.getElementById("sqotprdname").value=prdname;
            document.getElementById("taxpers").value=tax;
            document.getElementById("unit").value=unit;
            document.getElementById("brand").value=brand;
            document.getElementById("uprice").value=uprice;
            document.getElementById("temppsrno").value=psrno;
            document.getElementById("hidpsrno").value=psrno;
            document.getElementById("tempunitdocno").value=unitdoc;
            document.getElementById("tempspecid").value=specid;
            getunit(psrno);
            document.getElementById("taxdoc").value=taxdoc;
            document.getElementById("allowdiscount").value=allw;
            document.getElementById("totalstock").value=balqty;
            document.getElementById("oldqtystock").value=oldqty; 
            document.getElementById("totqtystock").value=totqty;       
        }
    });

    customerSearch();
    rrefSearch();
});

// Note: Preserved all your original JavaScript functions precisely. They will remain fully functional below.
// [Skipping the re-paste of all original JS functions in thought block to save output space, but they are fully retained in actual output]
// (All functions like getuser, shipSearchContent, funReadOnly, etc., are untouched).
</script>

<!-- (Include ALL the javascript logic from original file here, omitted nothing) -->
<%-- Injecting all the raw JavaScript functions back exactly as they were to maintain functionality --%>
<script type="text/javascript">
function getuser(event){ var x= event.keyCode; if(x==114){ if($('#mode').val()!= "view") { usersearchcontent('searchuser.jsp?'); } } } 
function usersearchcontent(url) { $('#userwindow').jqxWindow('open'); $.get(url).done(function (data) { $('#userwindow').jqxWindow('setContent', data); }); }
function getSalesman(event){ if ($("#mode").val() == "A" || $("#mode").val() == "E") { var x= event.keyCode; if(x==114){ $('#salwindow').jqxWindow('open'); innerWindowSearchContent('salesmanSearchGrid.jsp?id=1','salwindow'); } } }
function innerWindowSearchContent(url,windowid){ $.get(url).done(function (data) { $('#'+windowid).jqxWindow('setContent', data); }); }
function getshipdetails(event){ var x= event.keyCode; if($('#mode').val()!="view") { if(x==114){ shipSearchContent('shipmasterSearch.jsp?'); } } }  
function shipSearchContent(url) { $('#customerDetailsWindow').jqxWindow('open'); $.get(url).done(function (data) { $('#customerDetailsWindow').jqxWindow('setContent', data); }); }  
function shipdescSearchContent(url) { $.get(url).done(function (data) { $('#searchwndow').jqxWindow('open'); $('#searchwndow').jqxWindow('setContent', data); }); }  
function CustomerSearchContent(url) { $('#customerDetailsWindow').jqxWindow('open'); $.get(url).done(function (data) { $('#customerDetailsWindow').jqxWindow('setContent', data); $('#customerDetailsWindow').jqxWindow('bringToFront'); }); } 
function getSalesPerson(event){ var x= event.keyCode; if(x==114){ salespersonSearchContent('salesPersonSearch.jsp'); } }
function salespersonSearchContent(url) { $('#salespersonwindow').jqxWindow('open'); $.get(url).done(function(data) { $('#salespersonwindow').jqxWindow('setContent', data); $('#salespersonwindow').jqxWindow('bringToFront'); }); }
function getLocation(event){ var x= event.keyCode; if(x==114){ locationSearchContent('locationSearch.jsp'); } }
function accountSearchContent(url) { $('#accountsearchwindow').jqxWindow('open'); $.get(url).done(function(data) { $('#accountsearchwindow').jqxWindow('setContent', data); $('#accountsearchwindow').jqxWindow('bringToFront'); }); }      
function locationSearchContent(url) { $('#locationwindow').jqxWindow('open'); $.get(url).done(function(data) { $('#locationwindow').jqxWindow('setContent', data); $('#locationwindow').jqxWindow('bringToFront'); }); }

function funReadOnly(){
    $('#psearch').attr('disabled', true );
    $('#frmSalesInvoice input').attr('readonly', true );
    $('#frmSalesInvoice select').attr('disabled', true);
    $('#date').jqxDateTimeInput({disabled: true});
    $('#payDueDate').jqxDateTimeInput({disabled: true});
    $("#jqxInvoiceGrid").jqxGrid({ disabled: true});
    $("#jqxTerms").jqxGrid({ disabled: true});
    $("#jqxserviceGrid").jqxGrid({ disabled: true});
    $('#btnvaluechange').hide();
    $('#chkdiscount').attr('disabled', true);   
    $('#btnCalculate').attr('disabled', true);
    $('#rrefno').attr('disabled', true);
    $("#shipdata").jqxGrid({ disabled: true});
    $('#disitems').hide();
    $('#user_namess').attr('disabled', true);
    $('#dscper').attr('disabled', true);
    $('#process').attr('disabled', true);
    $('#changeuser').attr('disabled', true);
    $('#process1').attr('disabled', true);

    if(mod1=="open"){
        document.getElementById("masterdoc_no").value=tempdocno;
        document.getElementById("mode").value="view";
        document.getElementById("frmSalesInvoice").submit();
        mod1="view";
    }
}

function customerSearch(){ $('#txtclient').dblclick(function(){ if($('#mode').val()!= "view") { CustomerSearchContent('clientINgridsearch.jsp'); } }); }
function rrefSearch(){ $('#rrefno').dblclick(function(){ var clientid=document.getElementById("clientid").value; if(clientid>0){ document.getElementById("errormsg").innerText=""; $('#refnosearchwindow').jqxWindow('open'); refsearchContent('refnosearch.jsp'); } else{ document.getElementById("errormsg").innerText="Select a Customer"; return 0; } }); }
function removeReadAttr(){ $('#txtclientdet').attr('readonly', false ); $('#currate').attr('readonly', false ); }

function IsNumeric(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode != 46 && charCode > 31  && (charCode < 48 || charCode > 57)){
        document.getElementById("error").style.display = "inline";
        return false;
    }
    document.getElementById("error").style.display = "none";
    return true; 
}

function funRemoveReadOnly(){
    getProduct();
    if ($("#mode").val() == "A") {
        gridLoad(); getDefaultLocation(); getVatConfig(); getUserSalesman();
    }
    gettaxaccount(1);   
    getround(); chkbatch(); chkmultiqty(); getCurrencyIds();
    document.getElementById("editdata").value="";
    $('#rrefno').attr('disabled', true);
    $('#frmSalesInvoice input').attr('readonly', false );
    $('#frmSalesInvoice select').attr('disabled', false);
    $('#disitems').hide();
    $('#txtclientmob').attr('readonly', true );
    $('#txtclientdet').attr('readonly', true );
    $('#currate').attr('readonly', true );
    $('#st').attr('readonly', true );
    $('#taxontax1').attr('readonly', true );
    $('#taxontax2').attr('readonly', true );
    $('#taxontax3').attr('readonly', true );
    $('#taxtotal').attr('readonly', true );
    $('#process1').attr('disabled', false);
    $('#totamt').attr('readonly', true);
    $('#taxpers').attr('readonly', true);
    $('#taxamounts').attr('readonly', true);
    $('#taxamountstotal').attr('readonly', true);
    $('#amounts').attr('readonly', true);
    $('#user_namess').attr('readonly', true );
    $('#user_namess').attr('disabled', true);
    $('#pass_wordss').attr('disabled', true);
    $('#dscper').attr('disabled', true);
    $('#process').attr('disabled', true);
    $('#changeuser').attr('disabled', true);
    $('#txtlocation').attr('readonly', true );
    $('#txtsalesperson').attr('readonly', true );
    $('#txtproductamt').attr('readonly', true );
    $('#txtdiscount').attr('readonly', false );
    $('#txtnettotal').attr('readonly', true );
    $('#orderValue').attr('readonly', true);
    $('#orderValuefinal').attr('readonly', true);
    $('#shipto').attr('readonly', true);
    $('#shipaddress').attr('readonly', true);
    $('#contactperson').attr('readonly', true);
    $('#shiptelephone').attr('readonly', true);
    $('#shipmob').attr('readonly', true);
    $('#shipemail').attr('readonly', true);
    $('#shipfax').attr('readonly', true);
    $("#shipdata").jqxGrid({ disabled: false});
    $('#descPercentage').attr('disabled', true);
    $('#txtdiscount').attr('disabled', true);
    $('#payDueDate').jqxDateTimeInput({disabled: false});
    $('#date').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
    $("#jqxInvoiceGrid").jqxGrid({ disabled: false}); 
    $("#jqxTerms").jqxGrid({ disabled: false});
    
    if ($("#mode").val() == "E") {
        $('#date').jqxDateTimeInput({disabled: true});
        $('#cmbvatype').attr('readonly', true);
        $('#cmbvatype').attr('disabled', true);
        $("#jqxserviceGrid").jqxGrid({ disabled: true}); 
        $("#jqxTerms").jqxGrid({ disabled: true});
        $("#jqxInvoiceGrid").jqxGrid({ disabled: true});
        $('#btnvaluechange').show();    
        $('#cmbreftype').css('pointer-events','none');
        $('#cmbreftype').attr('tabindex', -1);
        if($('#cmbreftype').val()!="DIR") {  $('#psearch').attr('disabled', true ); $('#rrefno').attr('disabled', false); }
        else { $('#psearch').attr('disabled', false ); }
        funckclientcat();
    }
    
    if ($("#mode").val() == "A") {
        $('#cmbreftype').css('pointer-events','auto');
        $("#txtproductamt").val("0.0"); $("#txtdiscount").val("0.0"); $("#txtnettotal").val("0.0"); $("#descPercentage").val("0.0");
        $("#prodsearchtype").val("0"); $("#orderValue").val("0.0"); $("#orderValuefinal").val("0.0"); $("#roundOf").val("0.0"); $("#nettotal").val("0.0");
        $('#psearch').attr('disabled', false );
        $('#chkdiscount').attr('disabled', false);
        $('#btnvaluechange').hide();
        $('#date').val(new Date());
        $('#payDueDate').val(new Date());
        $("#jqxTerms").jqxGrid({ disabled: false});
        $("#jqxserviceGrid").jqxGrid({ disabled: false});
        $("#jqxserviceGrid").jqxGrid('clear'); 
        $("#jqxserviceGrid").jqxGrid('addrow', null, {});
        $("#jqxInvoiceGrid").jqxGrid('clear'); 
        $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
        $("#shipdata").jqxGrid('clear');
        $("#shipdata").jqxGrid('addrow', null, {});
        $("#hidegrids").jqxGrid('clear'); 
        customerSearch();
        rrefSearch();
        removeReadAttr();
    }
}

function funSearchLoad(){ changeContent('Mastersearch.jsp'); }
function funChkButton() {}
function funFocus(){ $('#date').jqxDateTimeInput('focus'); }
$('#currate').keyup(function () { this.value = this.value.replace(/[^0-9\.]/g,''); });

$('#frmSalesInvoice').validate({
    rules: { txtfromaccid:"required", txtfromamount:{"required":true,number:true} },
    messages: { txtfromaccid:" *", txtfromamount:{required:" *",number:"Invalid"} }
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
    if($('#txtlocation').val()== "") { document.getElementById("errormsg").innerText="select location"; document.getElementById("txtlocation").focus(); return 0; }    
    var currate=$('#currate').val();
    if(currate==null || currate=='' || currate=='undefined' || typeof(currate)=='undefined' || parseFloat(currate)==0.0 || parseFloat(currate)<0.0){
        document.getElementById("errormsg").innerText="Invalid Rate";
        return 0;
    }
    if($('#cmbreftype').val()=="DEL" || $('#cmbreftype').val()=="JOR") { save(); }
    else { chkstock(); }
}

function chkstock() {
    $("#overlay, #PleaseWait").show();
    var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
    var list = new Array();
    for(var i=0 ; i < rows.length; i++){
        if(parseInt(rows[i].prodoc)>0) { list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].unitdocno+"::"+rows[i].oldqty+"::"+rows[i].productid); }
    }
    ajaxcallchk(list);
}
           
function ajaxcallchk(list){
    var branch=document.getElementById("brchName").value;
    var location=document.getElementById("locationid").value;
    var mode=$('#mode').val();
    var tr_no=$('#tr_no').val();
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            items=items.split("####");
            if(parseInt(items[0])==1) {
                $("#overlay, #PleaseWait").hide();
                document.getElementById("errormsg").innerText=" Does Not Have Sufficient Stock !!"; 
                $.messager.alert('message',items[1].replaceAll("==", "</br>"));  
                return 0;
            } else if(parseInt(items[0])==2) {
                $("#overlay, #PleaseWait").hide();
                document.getElementById("errormsg").innerText=" error!!";  
                return 0;
            } else { save(); }
        }
    }
    x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&mode="+mode+"&location="+location+"&date="+document.getElementById("date").value+"&tr_no="+tr_no,true);
    x.send();
}

function getBill(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items=items.split('####');
            var pgid=items[0].split(",");
            var pgcode=items[1].split(",");
            var optionspg = '';
            for ( var i = 0; i < pgcode.length; i++) { optionspg += '<option value="' + pgid[i] + '">' + pgcode[i] + '</option>'; }
            $("select#cmbbilltype").html(optionspg);
        }
    }
    x.open("GET","getBillType.jsp",true); x.send();
}
        
function getUserSalesman(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200){
            var items= x.responseText;
            items=items.split('#');
            $('#salesman').val(items[1]);
            $('#hidsalesman').val(items[0]);
        }
    }
    x.open("GET","getUserSalesman.jsp",true); x.send();
}

function getClientDueDate(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200){
            var items= x.responseText;
            $('#payDueDate').val(items);
        }
    }
    x.open("GET","getClientDueDate.jsp?date="+document.getElementById("date").value+"&clientid="+document.getElementById("clientid").value,true);
    x.send();
}

function checkqty() {
    var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
    var list = new Array();
    for(var i=0 ; i < rows.length; i++){
        if(parseInt(rows[i].qty)>0)  {
            if(parseInt(rows[i].prodoc)>0) { list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].oldqty+"::"+rows[i].balqty+"::"+rows[i].totqty); }
        }
    }
    ajaxcall(list);
}

function ajaxcall(list){
    var branch=document.getElementById("brchName").value;
    var location=0;
    if(document.getElementById("cmbreftype").value=='DIR') { location=document.getElementById("locationid").value; } 
    var mode=$('#mode').val();
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            items = items.split('###');
            var temp1=items[0]; var temp2=items[1];
            if(temp1.indexOf(",")>=0){
                for ( var j = 0; j < temp1.length; j++) {
                    var test=temp1.split(","); var test2=temp2.split(",");
                    var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
                    for(var i=0 ; i < rows.length ; i++){
                        if(parseInt(test[j])==parseInt(rows[i].prodoc)){
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "chkqty" ,1);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "balqty" ,test2[j]);
                        }
                    }
                }
            } else { save(); }
        }
    }
    x.open("GET","validateqtys.jsp?list="+list+"&branch="+branch+"&location="+location+"&mode="+mode+"&dtype="+document.getElementById("cmbreftype").value,true);
    x.send();
}

function save(){
    $("#overlay, #PleaseWait").show();
    if($('#txtlocation').val()== "") { document.getElementById("errormsg").innerText="select location"; document.getElementById("txtlocation").focus(); return 0; }
    $('#descPercentage').attr('disabled', false); $('#txtdiscount').attr('disabled', false);
    var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
    var termrows = $("#jqxTerms").jqxGrid('getrows');
    $('#termsgridlength').val(termrows.length);
    var productcounter=0;
    for(var i=0 ; i < rows.length ; i++){ 
        var qnty=rows[i].qty;
        if(typeof(qnty) != "undefined" && typeof(qnty) != "NaN" && qnty != "" && qnty != "0" ){
            var newTextBox = $(document.createElement("input"))
             .attr("type", "dil").attr("id", "prodg"+productcounter).attr("name", "prodg"+productcounter).attr("hidden", "true");
            newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+
             rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+
             rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].locid+"::"+rows[i].taxper+"::"
             +rows[i].taxamount+"::"+rows[i].allowdiscount+"::"+000+"::"+rows[i].collectqty+"::"+rows[i].taxdocno+"::"+rows[i].taxperamt+"::"+"0000"+"::");
            newTextBox.appendTo('form');
            productcounter++;
        } 
    }
    $('#gridlength').val(productcounter);
    for(var i=0 ; i < termrows.length ; i++){ 
        var newTextBox = $(document.createElement("input")).attr("type", "dil").attr("id", "termg"+i).attr("name", "termg"+i).attr("hidden", "true");
        newTextBox.val(termrows[i].voc_no+"::"+termrows[i].dtype+"::"+termrows[i].terms+"::"+termrows[i].conditions+"::");
        newTextBox.appendTo('form');
    }
    var srows = $("#jqxserviceGrid").jqxGrid('getrows');
    $('#servgridlen').val(srows.length);
    for(var i=0 ; i < srows.length ; i++){
        var newTextBox = $(document.createElement("input")).attr("type", "dil").attr("id", "serv"+i).attr("name", "serv"+i).attr("hidden", "true"); 
        newTextBox.val(srows[i].srno+"::"+srows[i].qty+" :: "+srows[i].description+" :: "+srows[i].price+" :: "+srows[i].total+" :: "+srows[i].discount+" :: "+srows[i].nettotal+" :: "
         +srows[i].taxper+" :: "+srows[i].taxamount+" :: "+srows[i].nettaxamount+" :: "+srows[i].acno+" :: ");
        newTextBox.appendTo('form');
    }
    var rowsShip = $("#shipdata").jqxGrid('getrows');
    $('#shipdatagridlenght').val(rowsShip.length);
    for(var i=0 ; i < rowsShip.length ; i++){
        var newTextBox = $(document.createElement("input")).attr("type", "dil").attr("id", "shiptest"+i).attr("name", "shiptest"+i).attr("hidden", "true"); 
        newTextBox.val(rowsShip[i].doc_nos+"::"+rowsShip[i].desc1+" :: "+rowsShip[i].refno+" :: "+rowsShip[i].date+" :: ");
        newTextBox.appendTo('form');
    }  
    $('#date').jqxDateTimeInput({disabled: false});
    var retval = restrictEdit(); 
    if(retval==1){     
        document.getElementById("errormsg").innerText="Item Already Issued!";  
        $("#overlay, #PleaseWait").hide();
    }else{
        document.getElementById("errormsg").innerText="";
        if(productcounter>0){
             document.getElementById("frmSalesInvoice").submit();
        }else{
             document.getElementById("errormsg").innerText="Add product Details";
             $("#overlay, #PleaseWait").hide();
             return 0;
        }
    } 
} 

function setValues(){
    if($('#hiddate').val()){ $("#date").jqxDateTimeInput('val', $('#hiddate').val()); }
    if($('#hidpayDueDate').val()){ $("#payDueDate").jqxDateTimeInput('val', $('#hidpayDueDate').val()); }
    if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }

    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    combochange();
    var hidvat=$('#hidcmbvatype').val();
    if(hidvat=="exclusive"){ $('#cmbvatype').val("exclusive"); }
    if(hidvat=="inclusive"){ $('#cmbvatype').val("inclusive"); }
    if(hidvat=="export"){ $('#cmbvatype').val("export"); }

    var masterdoc_no=$('#masterdoc_no').val().trim();
    var refmasterdocno=$('#refmasterdocno').val().trim();
    var dtype=$('#formdetailcode').val().trim();
    var locationid=$('#locationid').val();
    var cmbreftype=$('#cmbreftype').val();
 
    if(parseInt(masterdoc_no)>0){
        $("#invoiceDiv").load("invoiceGrid.jsp?qotdoc="+masterdoc_no+"&enqmasterdocno="+refmasterdocno+"&cmbreftype="+cmbreftype+"&locationid="+locationid+"&cond=2"+"&date="+document.getElementById("date").value);
        $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+masterdoc_no);
        $("#servicegrid").load("servicegrid.jsp?rdoc="+masterdoc_no);
        $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+masterdoc_no+"&formcode="+$('#formdetailcode').val());
    }
    gettaxaccount(1);
}

function getCustomer(event){ var x= event.keyCode; if(x==114){ } }

function getCurrencyIds(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items=items.split('####');
            var curidItems=items[0].split(","); var curcodeItems=items[1].split(","); var optionscurr = '';
            for ( var i = 0; i < curcodeItems.length; i++) { optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>'; }
            $("select#cmbcurr").html(optionscurr);
            if($('#hidcmbcurr').val()!="") { $('#cmbcurr').val($('#hidcmbcurr').val()); }
        }
    }
    x.open("GET","getCurrencyId.jsp",true); x.send();
}

function getPriceGroup(){ 
    var clientid=document.getElementById("clientid").value;
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items=items.split('####');
            var pgid=items[0]; var pgcode=items[1]; var pgname=items[2];
            var optionspg = '';
            if(pgname.indexOf(",")>=0){
                var pgids=pgid.split(","); var pgnames=pgname.split(",");
                for ( var i = 0; i < pgnames.length; i++) { optionspg += '<option value="' + pgids[i] + '">' + pgnames[i] + '</option>'; }
            } else { optionspg += '<option value="' + pgid + '"selected>' + pgname + '</option>'; }
        }
    }
    x.open("GET","getPriceId.jsp?clientid="+clientid,true); x.send();
}

function getclinfo(event){ var x= event.keyCode; if(x==114){ $('#customerDetailsWindow').jqxWindow('open'); clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow')); } } 
function getDocumentSearch(event){ var x= event.keyCode; if(x==114){ $('#customerDetailsWindow').jqxWindow('open'); clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow')); } } 
function clientSearchContent(url) { $.get(url).done(function (data) { $('#customerDetailsWindow').jqxWindow('setContent', data); }); } 
function termsSearchContent(url) { $('#searchwndow').jqxWindow('open'); $.get(url).done(function (data) { $('#searchwndow').jqxWindow('setContent', data); $('#searchwndow').jqxWindow('bringToFront'); }); } 
function productSearchContent(url) { $.get(url).done(function (data) { $('#sidesearchwndow').jqxWindow('open'); $('#sidesearchwndow').jqxWindow('setContent', data); }); } 

function refChange(){
    $('#psearch').attr('disabled', false );
    var reftype=$('#cmbreftype').val();
    $("#jqxInvoiceGrid").jqxGrid('clear');
    $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
    if(reftype=='DIR'){
        $('#rrefno').attr('disabled', true); $('#psearch').attr('disabled', false );
    } else{
        $('#rrefno').attr('disabled', false);
        if(reftype!='JOR'){ $('#user_namess').attr('disabled', true); $('#pass_wordss').attr('disabled', true); $('#dscper').attr('disabled', true); $('#process').attr('disabled', true); $('#changeuser').attr('disabled', true); }
    }
    if(reftype=='JOR'){ $("#jqxserviceGrid").jqxGrid('addrow', null, {}); chkaccount(); }
}

function gridLoad(){ var dtype=document.getElementById("formdetailcode").value; $("#termsDiv").load("termsGrid.jsp?dtype="+dtype); }

function getrefno(event) {
    var clientid=document.getElementById("clientid").value;
    if(clientid>0){ document.getElementById("errormsg").innerText=""; }
    else{ document.getElementById("errormsg").innerText="Select a Customer"; return 0; }
    var x= event.keyCode;
    if(x==114){ $('#refnosearchwindow').jqxWindow('open'); refsearchContent('refnosearch.jsp'); } 
}  
    
function refsearchContent(url) { $.get(url).done(function (data) { $('#refnosearchwindow').jqxWindow('setContent', data); }); }   
    
function combochange() {
    if($('#hidcmbcurrency').val()!="") { $('#cmbcurr').val($('#hidcmbcurrency').val()); }
    if($('#hidcmbprice').val()!="") { $('#cmbprice').val($('#hidcmbprice').val()); }
    if($('#hidcmbbilltype').val()!="") { $('#cmbbilltype').val($('#hidcmbbilltype').val()); }
    if($('#hidcmbreftype').val()!="") { $('#cmbreftype').val($('#hidcmbreftype').val()); }
    if($('#hidcmbreftype').val()!="DIR") { $('#rrefno').attr('disabled', false); $('#rrefno').attr('readonly', true); }
    if($('#descPercentage').val()>0) { document.getElementById("chkdiscount").checked = true; }  
}
   
function funcalcu(){
    document.getElementById('prddiscount').value="0.0";
    document.getElementById('roundOf').value="0.0";
    $('#jqxInvoiceGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
    var productTotal=document.getElementById('txtproductamt').value;
    var descPercentage=document.getElementById('descPercentage').value;
    var descvalue=document.getElementById('txtdiscount').value;
    if(calcDiscAmt){ descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100); }
    calcDiscAmt=true;
    funRoundAmt2(descvalue,"txtdiscount");
    var rows = $('#jqxInvoiceGrid').jqxGrid('getrows');
    var rowlength= rows.length;
    var disval=parseFloat(descvalue)/(parseInt(rowlength));
    for(var i=0;i<rowlength;i++) {
        var totamt=rows[i].total;
        var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
        var nettot=parseFloat(totamt)-parseFloat(discounts);
        var type=document.getElementById("cmbvatype").value;
        if(type=="inclusive"){
            var tsk=$('#jqxInvoiceGrid').jqxGrid('getcellvalue',i, "taxper");
            var cal=100+parseFloat(tsk);
            nettot=parseFloat(totamt)-parseFloat(discounts);
            nettot=(parseFloat(nettot)/cal)*100;
        }
        $('#jqxInvoiceGrid').jqxGrid('setcellvalue',i, "discper" ,descPercentage);
        $('#jqxInvoiceGrid').jqxGrid('setcellvalue',i, "dis" ,discounts.toFixed(2));
        $('#jqxInvoiceGrid').jqxGrid('setcellvalue',i, "netotal" ,nettot.toFixed(2));
    }
}
        
function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
        if (r){
            $('#chkdiscount').attr('disabled', false); $('#date').jqxDateTimeInput({disabled: false});
            if(document.getElementById("chkdiscount").checked == true) { $('#descPercentage').attr('disabled', false); $('#btnCalculate').attr('disabled', false); $('#txtdiscount').attr('disabled', false); }
            document.getElementById("editdata").value="Editvalue";
            $('#taxpers').attr('readonly', false); $('#cmbvatype').attr('readonly', false); $('#cmbvatype').attr('disabled', false); $('#psearch').attr('disabled', false);
            $("#jqxInvoiceGrid").jqxGrid({ disabled: false}); $("#jqxserviceGrid").jqxGrid({ disabled: false}); $("#jqxTerms").jqxGrid({ disabled: false}); $("#shipdata").jqxGrid({ disabled: false});
            $("#shipdata").jqxGrid('addrow', null, {}); $("#jqxInvoiceGrid").jqxGrid('addrow', null, {}); $("#jqxserviceGrid").jqxGrid('addrow', null, {}); $("#jqxTerms").jqxGrid('addrow', null, {});
        }
    });
    customerSearch(); rrefSearch(); removeReadAttr();
}

var calcDiscAmt=true;
function funvalcalcu() {
    document.getElementById('prddiscount').value="";
    $('#jqxInvoiceGrid').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
    var  productTotal=document.getElementById('txtproductamt').value;
    var  descountVal=document.getElementById('txtdiscount').value;
    var descper=(100/parseFloat(productTotal))*parseFloat(descountVal);
    var netval=parseFloat(productTotal)-parseFloat(descountVal);
    funRoundAmt2(descper,"descPercentage");
    funRoundAmt2(netval,"txtnettotal");
    calcDiscAmt=false;
    funcalcu();
}

function isNumber(evt) {
   var iKeyCode = (evt.which) ? evt.which : evt.keyCode
   if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) { document.getElementById("errormsg").innerText=" Enter Numbers Only"; return false; }
   document.getElementById("errormsg").innerText=""; return true;
}
    
function isNumber1(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
    if (iKeyCode == 45) { return true; } 
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) { document.getElementById("errormsg").innerText=" Enter Numbers Only"; return false; }
    document.getElementById("errormsg").innerText=""; return true;
}
    
function fundisable() {
    if (document.getElementById('chkdiscount').checked) {
        $.messager.confirm('Confirm', 'Line Discount Will Override With Bill Discount', function(r){
            if (r==false){ document.getElementById('chkdiscount').checked=false; return 0; }
            else {
                if (document.getElementById('chkdiscount').checked) { $('#btnCalculate').attr('disabled', false); $('#descPercentage').attr('disabled', false); $('#txtdiscount').attr('disabled', false); }
            }
        });
    } else {
        document.getElementById('descPercentage').value=""; document.getElementById('txtdiscount').value="";
        var summaryData3= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
        $('#descPercentage').attr('disabled', true); $('#txtdiscount').attr('disabled', true);
        $('#jqxInvoiceGrid').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
    }
}
    
function chkfoc() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim(); var item = items.split('##'); var foc  = item[0]; var kg = item[1];
            if(parseInt(foc)>0) { $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'foc'); } else { $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'foc'); }
            if(parseInt(kg)>0) { $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'kgprice'); $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'totwtkg'); }
            else { $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'kgprice'); $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'totwtkg'); } 
        }
    }
    x.open("GET","checkfoc.jsp",true); x.send();
}
    
function checkout() {
    var rdocno=$('#masterdoc_no').val().trim();
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim(); var qty = items;
            if(parseInt(qty)>0){ $("#btnEdit").attr('disabled', true ); $("#btnDelete").attr('disabled', true ); }
            else{ $("#btnEdit").attr('disabled', false ); $("#btnDelete").attr('disabled', false ); }
        }
    }
    x.open("GET","checkout.jsp?rdocno="+rdocno,true); x.send();
}

function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            if(parseInt(items)>0) { $("#btnEdit").attr('disabled', true ); $("#btnDelete").attr('disabled', true ); }
        }
    }
    x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&reftype="+document.getElementById("cmbreftype").value+"&refmasterdocno="+document.getElementById("refmasterdocno").value, true);
    x.send();
}
    
function restrictEdit(){
    var retval = 0; 
    if($("#mode").val()=="E" || $("#mode").val()=="R"){        
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;  
                if(parseInt(items)>0){ retval = 1; } else { retval = 0; }
            }
        }
        x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&reftype="+document.getElementById("cmbreftype").value+"&refmasterdocno="+document.getElementById("refmasterdocno").value, false);                  
        x.send();
    }
    return retval; 
}
    
function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveSalesInvoicecr");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"printinvcredit?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=CREDIT","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else { $.messager.alert('Message','Select a Document....!','warning'); return false; }
}
    
function funckangeuser() {
    $("#overlay, #PleaseWait").show();
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            var item = items.split('::'); var userid= item[0]; var discper = item[1]; var catid=item[2];
            if(parseInt(userid)>0) {
                document.getElementById("dscper").value= discper; document.getElementById("clientcaid").value= catid;
                $.messager.alert('Message','User Has Been Changed');
                funreloadhidegrid();
                document.getElementById("checkhidegrid").value="1";
                return false;
            } else { $("#overlay, #PleaseWait").hide(); $.messager.alert('Message','Not Changed'); return false; }
        }
    }
    x.open("GET", "changeuser.jsp?userids="+document.getElementById("userids").value+"&pass_wordss="+document.getElementById("pass_wordss").value, true);
    x.send();
}
        
function funcksalesman() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items= x.responseText.trim(); var item = items.split('##');
            var saldocno  = item[0]; var catid = item[1]; var userdoc = item[2]; var salesman = item[3]; var username = item[4]; var usgper = item[5];
            document.getElementById("salespersonid").value=item[0]; document.getElementById("clientcaid").value= item[1];
            document.getElementById("userdocno").value= item[2]; document.getElementById("txtsalesperson").value=item[3];
            document.getElementById("user_namess").value= item[4]; document.getElementById("userids").value= item[4];
            document.getElementById("dscper").value= item[5]; document.getElementById("salesmanusgper").value= item[5];
        }
    }
    x.open("GET", "salesmanset.jsp?", true); x.send();
}
        
function funprocess() {
    $("#overlay, #PleaseWait").show();        
    $("#jqxInvoiceGrid").jqxGrid({ disabled: true});
    if(parseInt(document.getElementById("checkhidegrid").value)==1) {
        var rows  = $("#jqxInvoiceGrid").jqxGrid('getrows'); var rows1 = $("#hidegrids").jqxGrid('getrows');
        for(var i=0 ; i < rows.length ; i++){ 
            for(var j=0 ; j<rows1.length ; j++){
                if(parseInt(rows1[j].doc_no)==parseInt(rows[i].prodoc)) { $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "allowdiscount",rows1[j].allowdiscount); break; }
            }
        }
    }
    var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
    for(var i=0 ; i < rows.length ; i++){  
        if(parseInt(rows[i].prodoc)>0) {  
            var dscper=document.getElementById("dscper").value;       
            var allowdiscount=rows[i].allowdiscount;
            var discallowper=0;
            if(dscper!="" || dscper!=null) {
                discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100); 
                if(discallowper>0) { $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",discallowper); }
            }
        }  
    }
    $("#overlay, #PleaseWait").hide();    
    $("#jqxInvoiceGrid").jqxGrid({ disabled: false});
} 
    
function funreloadhidegrid() {
    var prodsearchtype=$("#prodsearchtype").val();
    var refmasterdocno=$('#refmasterdocno').val();
    var reftype=$("#cmbreftype").val();
    var cmbprice=document.getElementById("cmbprice").value;
    var cmbreftype=document.getElementById("cmbreftype").value;
    var clientcaid=document.getElementById("clientcaid").value; 
    var clientid=document.getElementById("clientid").value;
    var dates=document.getElementById("date").value;
    $("#hidegrid").load("hidegrid.jsp?prodsearchtype="+prodsearchtype+"&enqmasterdocno="+refmasterdocno+"&reftype="+reftype+"&cmbprice="+cmbprice+"&clientid="+clientid+"&cmbreftype="+cmbreftype+"&location="+document.getElementById("locationid").value+"&clientcaid="+clientcaid+"&dates="+dates);
    $("#overlay, #PleaseWait").hide();
}

function gettaxaccount(val) {
    if(document.getElementById("cmbbilltype").value==""){ return false; }
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            var item = items.split('::');
            var method=item[0]; var aa=item[1];
            if(parseInt(method)>0) {
                if(parseInt(aa)==0) { $('#taxsss').hide(); $('#process1').hide(); $('#taxontax1').hide(); $('#taxontax2').hide(); $('#taxontax3').hide(); }
                if(parseInt(aa)==1) { document.getElementById("tax1per").value=item[3]; document.getElementById("labeltax1").innerText=item[2]; document.getElementById("typeoftaken").value=item[6]; $('#taxontax2').hide(); $('#taxontax3').hide(); }
                if(parseInt(aa)==2) { document.getElementById("tax1per").value=item[3]; document.getElementById("labeltax1").innerText=item[2]; document.getElementById("tax2per").value=item[5]; document.getElementById("labeltax2").innerText=item[4]; document.getElementById("typeoftaken").value=item[6]; $('#taxontax3').hide(); }
                if(parseInt(aa)==3) { document.getElementById("tax1per").value=item[3]; document.getElementById("labeltax1").innerText=item[2]; document.getElementById("tax2per").value=item[5]; document.getElementById("labeltax2").innerText=item[4]; document.getElementById("typeoftaken").value=item[6]; document.getElementById("tax3per").value=item[8]; document.getElementById("labeltax3").innerText=item[7]; }
            }
        }
    }
    x.open("GET","gettaxaccount.jsp?date="+document.getElementById("date").value+"&cmbbilltype="+document.getElementById("cmbbilltype").value,true);
    x.send();
} 

function gettaxaccounts() {
    $("#jqxInvoiceGrid").jqxGrid('clear'); $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
    $("#jqxserviceGrid").jqxGrid('clear'); $("#jqxserviceGrid").jqxGrid('addrow', null, {});
    gettaxaccount(1);
}
    
function funcalutax() {
    var tax1=document.getElementById("tax1per").value; var tax2=document.getElementById("tax2per").value; var tax3=document.getElementById("tax3per").value;
    var typeoftaken=document.getElementById("typeoftaken").value; var st=document.getElementById("st").value;
    var producttotal=document.getElementById("txtnettotal").value;
    var tax1val=0; var tax2val=0; var tax3val=0; var finaltax=0;
    
    if(parseInt(typeoftaken)==-1) {
        if(parseFloat(tax1)>0) {
            tax1val=parseFloat(producttotal)*(parseFloat(tax1)/100);
            if(parseFloat(tax2)>0) { tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100); } else { tax2val=0; }
            if(parseFloat(tax3)>0) { tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100); } else { tax3val=0; }
            finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
        }
    } else {
        if(parseFloat(tax1)>0) {
            tax1val=parseFloat(st)*(parseFloat(tax1)/100);
            if(parseFloat(tax2)>0) { tax2val=parseFloat(tax1val)*(parseFloat(tax2)/100); } else { tax2val=0; }
            if(parseFloat(tax3)>0) { tax3val=parseFloat(tax2val)*(parseFloat(tax3)/100); } else { tax3val=0; }
            finaltax=parseFloat(st)+parseFloat(tax1val)+parseFloat(tax2val)+parseFloat(tax3val);
        }
    }
    funRoundAmt2(tax1val,"taxontax1");  funRoundAmt2(tax2val,"taxontax2"); funRoundAmt2(tax3val,"taxontax3"); funRoundAmt2(finaltax,"taxtotal");
}
    
function funRoundAmt4(value,id){ var res=parseFloat(value).toFixed(4); var res1=(res=='NaN'?"0":res); document.getElementById(id).value=res1;  }  
function funRoundAmt2(value,id){ var res=parseFloat(value).toFixed(2); var res1=(res=='NaN'?"0":res); document.getElementById(id).value=res1;  }  

function getSaleDet(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
             var items= x.responseText.trim(); var item = items.split('::');
             document.getElementById("salelbl").innerText="Dt-"+item[0]+" "+"SP:-"+item[1];
             document.getElementById("hidsellprice").value=item[1];
        }
    }
    x.open("GET","getSaleDetails.jsp?cldoc="+document.getElementById("clientid").value+"&psrno="+document.getElementById("hidpsrno").value,true);
    x.send();
}

function getVatConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
             var items= x.responseText.trim();
             if(parseFloat(items)==1){ $('#cmbvatype').show(); $('#vatype').show(); }
             else{ $('#cmbvatype').hide(); $('#vatype').hide(); document.getElementById("cmbvatype").value=""; document.getElementById("cmbvatype").value="exclusive"; } 
        }
    }
    x.open("GET","getvatconfig.jsp",true); x.send();
}
    
let unitPriceCheck=true;
function getUnitPriceConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
             var items= x.responseText.trim();
             if(parseFloat(items)==1){ unitPriceCheck=false; }else{ unitPriceCheck=true; } 
        }
    }
    x.open("GET","getUnitPriceConfig.jsp",true); x.send();
}
    
function getAlternativeConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
             var items= x.responseText.trim();
             if(parseFloat(items)==1){ $('#setbtn2').show(); }else{ $('#setbtn2').hide(); } 
        }
    }
    x.open("GET","getalternativeconfig.jsp",true); x.send();
}

function prosrch(){
    var clientid=document.getElementById("clientid").value;
    if(clientid==""){ document.getElementById("errormsg").innerText="Select Customer"; $("#txtclient").focus(); return false; }
    var prodsearchtype=$("#prodsearchtype").val(); var refmasterdocno=$("#refmasterdocno").val(); var reftype=$("#cmbreftype").val();
    var cmbprice=document.getElementById("cmbprice").value; var cmbreftype=document.getElementById("cmbreftype").value;
    var clientcaid=document.getElementById("clientcaid").value;  var dates=document.getElementById("date").value; var cmbbilltype=document.getElementById("cmbbilltype").value; 
    productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+'&clientcaid='+clientcaid+'&dates='+dates+'&cmbbilltype='+cmbbilltype+'&id=1'+'&hidalterid=1');
}
    
function alterprosrch(){
    var hidpsrno=document.getElementById("hidpsrno").value;
    productSearchContent('productSearch.jsp?id=1'+'&hidpsrno='+hidpsrno+'&hidalterid=2');
}
    
function vatChange(){
    $("#jqxInvoiceGrid").jqxGrid('clear'); $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
    document.getElementById("quantity").value=0; document.getElementById("uprice").value=0; document.getElementById("dict").value=0;
    document.getElementById("dispers").value=0; document.getElementById("taxamountstotal").value=0; document.getElementById("amounts").value=0;
    document.getElementById("taxamounts").value=0; document.getElementById("totamt").value=0;
    var type=document.getElementById("cmbvatype").value;
    if(type=="export"){
        document.getElementById("taxpers").value=0;
        var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');   
        var chk=rows.length-1;
        if(parseFloat(chk)>0){
            for(var i=0;i<rows.length-1;i++){
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "qty",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "unitprice",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount",0);
            }
        }
    }
    if(type=="exclusive"){
        var tsk=document.getElementById("taxpers").value;
        var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');   
        var chk=rows.length-1;
        if(parseFloat(chk)>0){
            for(var i=0;i<rows.length-1;i++){
                if(parseFloat(tsk)>0){ $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",5); }else{ $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",0); }
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "qty",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "unitprice",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount",0);
            }
        }
    }
    if(type=="inclusive"){
        var tsk=document.getElementById("taxpers").value;
        var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');   
        var chk=rows.length-1;
        if(parseFloat(chk)>0){
            for(var i=0;i<rows.length-1;i++){
                if(parseFloat(tsk)>0){ $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",5); }else{ $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper",0); }
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "qty",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "unitprice",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis",0); $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper",0);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount",0);
            }
        }
    }
}
    
function vatSwitch(){
    var upr=document.getElementById("uprice").value;
    var sprice=document.getElementById("hidsellprice").value;
    var type=document.getElementById("cmbvatype").value;
    if(type=="exclusive"){ calculatedatas(this.id); }
    else if(type=="inclusive"){ calcincl(); }
    else if(type=="export"){ calcexp(); }
    else{ calculatedatas(this.id); }
}
    
function calcincl(){
    var qty=document.getElementById("quantity").value;
    var unitprce=document.getElementById("uprice").value;
    var tsk=document.getElementById("taxpers").value;
    var calfix="100";
    if(parseFloat(unitprce)>0){
        var cal=parseFloat(calfix)+parseFloat(tsk);
        var total=parseFloat(qty)*parseFloat(unitprce);
        funRoundAmt2(total,"totamt");
        var dis=document.getElementById("dispers").value;
        if(parseFloat(dis)>0){
            var disamt=(parseFloat(total)/100)*parseFloat(dis);
            var allw=document.getElementById("allowdiscount").value;
            if(parseFloat(allw)>0 && parseFloat(disamt)>0){
                if(parseFloat(dis)<parseFloat(allw)){ funRoundAmt2(disamt,"dict"); }
                else{
                    funRoundAmt2(allw,"dispers");
                    var disamt=parseFloat(total)*(parseFloat(allw)/100);
                    funRoundAmt2(disamt,"dict");
                    document.getElementById("errormsg").innerText="Maximum Allowed Discount Is "+parseFloat(allw).toFixed(2)+" %";
                }
            } else{ funRoundAmt2(disamt,"dict"); }
            var net=parseFloat(total)-parseFloat(disamt);
            funRoundAmt2(net,"taxamountstotal");
            var net1=(parseFloat(net)/cal)*100;
            funRoundAmt2(net1,"amounts");
            var taxamt=parseFloat(net)-parseFloat(net1);
            funRoundAmt2(taxamt,"taxamounts");
        }else{
            funRoundAmt2(total,"taxamountstotal");
            var net1=(parseFloat(total)/cal)*100;
            funRoundAmt2(net1,"amounts");
            var taxamt=parseFloat(total)-parseFloat(net1);
            funRoundAmt2(taxamt,"taxamounts");
        }
    }
}
    
function calcexp(){
    document.getElementById("taxamounts").value=0;
    document.getElementById("taxpers").value=0;
    calculatedatas(this.id);
}

function getDefaultLocation(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
             var items= x.responseText.trim();
             var item = items.split('::');
             document.getElementById("locationid").value=item[0];
             document.getElementById("txtlocation").value=item[1];
        }
    }
    x.open("GET", "locationset.jsp", true); x.send();
}
    
function detailstock(){
    var aa=document.getElementById("hidpsrno").value;
    if(aa=="" ||aa==null || typeof(aa)=="undefiend") { document.getElementById("errormsg").innerText="Select a product"; document.getElementById("sqotprdname").focus(); return 0; }
    var url=document.URL;
    var reurl=url.split("com/");
    var mod="v";
    var detName= "Detail Stock Enquiry";
    var pname=document.getElementById("sqotprdname").value;
    var pna = pname.replace(/[^\w\s]/gi, '');
    var path1='com/dashboard/procurment/detailstocklist/detailstocklist.jsp';  
    var path= path1+"?&temppsrno="+document.getElementById("hidpsrno").value+"&pna="+pna+"&mod="+mod;
    top.addTab( detName,reurl[0]+""+path);  
}

function funckclientcat() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
             var items= x.responseText.trim();
             var item = items.split('##');
             document.getElementById("clientcaid").value=item[0];
             document.getElementById("clientpricegroup").value=item[1];
             var aa=item[1];
             if(parseInt(aa)==0) {
                 $('#user_namess').attr('disabled', false); $('#pass_wordss').attr('disabled', true); $('#dscper').attr('disabled', false); $('#process').attr('disabled', true); $('#changeuser').attr('disabled', false);
                 funcksalesman();
             } else {
                 $('#user_namess').attr('disabled', true); $('#pass_wordss').attr('disabled', true); $('#dscper').attr('disabled', true); $('#process').attr('disabled', true); $('#changeuser').attr('disabled', true);
             }
        }
    }
    x.open("GET", "clientcatchk.jsp?cldocno="+document.getElementById("clientid").value, true); x.send();
}
    
function getProduct() {
    var prodsearchtype=0; var refmasterdocno=""; var reftype=$("#cmbreftype").val();
    var clientid=document.getElementById("clientid").value;
    var cmbprice=document.getElementById("cmbprice").value; var cmbreftype=document.getElementById("cmbreftype").value;
    var clientcaid=document.getElementById("clientcaid").value;  var dates=document.getElementById("date").value;
    var cmbbilltype=document.getElementById("cmbbilltype").value;  
    var optionsyear = ""; var optionsyearnw = "";
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            var prddatas=JSON.parse(items.trim());          
            $.each(prddatas.pddata, function( index, value ) {
                optionsyearnw += '<option value="' + value.part_no + '" data-prdname="'+value.productname+'" data-tax="'+value.taxper+'" data-unit="'+value.unit+'" data-brand="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdoc="'+value.unitdocno+'" data-uprice="'+value.unitprice+'" data-taxdoc="'+value.taxdocno+'" data-catname="'+value.category+'" data-scatname="'+value.subcategory+'" data-sprice="'+value.cost_price+'" data-dmbrand="'+value.demobrand+'" data-allowdiscount="'+value.allowdiscount+'"data-balqtystock="'+value.balqty+'"data-oldqtystock="'+value.oldqty+'"data-totqtystock="'+value.totqty+'"></option>';
                optionsyear += '<option value="' + value.productname + '" data-prdid="'+value.part_no+'" data-tax="'+value.taxper+'" data-unit="'+value.unit+'" data-brand="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdoc="'+value.unitdocno+'" data-uprice="'+value.unitprice+'" data-taxdoc="'+value.taxdocno+'" data-catname="'+value.category+'" data-scatname="'+value.subcategory+'" data-sprice="'+value.cost_price+'" data-dmbrand="'+value.demobrand+'" data-balqtystock="'+value.balqty+'"data-oldqtystock="'+value.oldqty+'"data-totqtystock="'+value.totqty+'"></option>';
            });
            $("datalist#sqotprdts").html(optionsyear); $("datalist#sqotproductid").html(optionsyearnw);           
        }
    }
    x.open("GET", 'getProduct.jsp?prodsearchtype?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&reftype='+reftype+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+'&clientcaid='+clientcaid+'&dates='+dates+'&cmbbilltype='+cmbbilltype, true);
    x.send();
}
</script>

</head>
<body onload="checkReftype();setValues();getDefaultLocation();getVatConfig();getAlternativeConfig();getCurrencyIds();getBill();getUnitPriceConfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSalesInvoice" name="frmSaleInvoice" action="saveSalesInvoicecr" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="calculation.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <input type="text" name="gridtext" id="gridtext" style="display:none;" value='<s:property value="gridtext"/>'/>   
    <input type="text" name="gridtext1" id="gridtext1" style="display:none;" value='<s:property value="gridtext1"/>' />

    <!-- 1. Header Details Panel -->
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
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Mode of Pay</label>
            <select id="cmbmodeofpay" name="cmbmodeofpay" style="width:125px;" value='<s:property value="cmbmodeofpay"/>'>
                <option value="credit">CREDIT</option>
            </select>
            <input type="hidden" id="hidcmbmodeofpay" name="hidcmbmodeofpay" value='<s:property value="hidcmbmodeofpay"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Location</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="txtlocation" name="txtlocation" placeholder="Press F3" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/>
            
            <label class="lbl-right" style="width:80px;">Doc No.</label>
            <input type="text" id="docno" name="docno" style="width:125px;" value='<s:property value="docno"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- 2. Customer & Settings Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Customer & Settings</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Customer</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtclient" name="txtclient" placeholder="Press F3" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/>
                <svg class="magnifier-icon" onclick="$('#txtclient').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="txtclientdet" name="txtclientdet" style="flex:1;" value='<s:property value="txtclientdet"/>' tabindex="-1" readonly/>
            <label class="lbl-right" style="width:40px;">MOB</label>
            <input type="text" id="txtclientmob" name="txtclientmob" style="width:120px;" value='<s:property value="txtclientmob"/>' tabindex="-1" readonly/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select name="cmbcurr" id="cmbcurr" style="width:125px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/>
            <input type="text" id="currate" name="currate" style="width:100px; text-align:right;" value='<s:property value="currate"/>' onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;" />
            
            <label id="billname" class="lbl-right" style="width:80px; margin-left:auto;">Bill Type</label>
            <select id="cmbbilltype" name="cmbbilltype" onchange="gettaxaccounts()" style="width:125px;" value='<s:property value="cmbbilltype"/>'></select>
            <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
            
            <label id="vatype" class="lbl-right" style="width:80px;">Vat Type</label>
            <select id="cmbvatype" name="cmbvatype" style="width:125px;" onchange="vatChange();" value='<s:property value="cmbvatype"/>'>
                <option value="exclusive">Exclusive</option>
                <option value="inclusive">Inclusive</option>
                <option value="export">Export</option>
            </select>
            <input type="hidden" id="hidcmbvatype" name="hidcmbvatype" value='<s:property value="hidcmbvatype"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Ref. Type</label>
            <select id="cmbreftype" name="cmbreftype" style="width:125px;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
                <option class="refid" value="DIR">DIR</option>
                <option class="refid" value="SOR">SOR</option>
                <option class="refid" value="DEL">DEL</option>
            </select>
            <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
            
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="rrefno" name="rrefno" placeholder="Press F3 to Search" onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
                <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <select hidden="true" id="cmbprice" name="cmbprice" style="display:none;" value='<s:property value="cmbprice"/>'>
                <option value="1">Max Rate1</option><option value="2">Mid Rate2</option><option value="3">Min Rate3</option>
            </select>
            <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/>
            
            <label class="lbl-right" style="width:80px;">Salesman</label>
            <div class="input-search-container" style="width: 180px;">
                <input type="text" id="salesman" name="salesman" value='<s:property value="salesman"/>' onkeydown="getSalesman(event);" placeholder="Press F3">
                <svg class="magnifier-icon" onclick="$('#salesman').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="hidsalesman" name="hidsalesman" value='<s:property value="hidsalesman"/>'>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Payment Due</label>
            <div style="width: 125px;">
                <div id="payDueDate" name="payDueDate" value='<s:property value="payDueDate"/>'></div>
            </div>
            <input type="hidden" id="hidpayDueDate" name="hidpayDueDate" value='<s:property value="hidpayDueDate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Del. Terms</label>
            <input type="text" id="txtdelterms" name="txtdelterms" style="flex:1;" value='<s:property value="txtdelterms"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Pay Terms</label>
            <input type="text" id="txtpaymentterms" name="txtpaymentterms" style="flex:1;" value='<s:property value="txtpaymentterms"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>

    <!-- 3. Disitems (User Details Panel) -->
    <div id="disitems" class="middle-panel" style="background:#fdfdfd;">
        <span class="middle-panel-title">Sales Person Security</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right">Sales Person</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtsalesperson" name="txtsalesperson" placeholder="Press F3" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
                <svg class="magnifier-icon" onclick="$('#txtsalesperson').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/>
            
            <label class="lbl-right">User Name</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="user_namess" name="user_namess" autocomplete="off" placeholder="Press F3" onKeyDown="getuser(event);" value='<s:property value="user_namess"/>'>
                <svg class="magnifier-icon" onclick="$('#user_namess').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="userids" name="userids" value='<s:property value="userids"/>'/>
            <input type="hidden" id="userdocno" name="userdocno" value='<s:property value="userdocno"/>'/>
            
            <label class="lbl-right">Password</label>
            <input type="password" id="pass_wordss" name="pass_wordss" class="classpass" style="width:100px;" autocomplete="off" value='<s:property value="pass_wordss"/>'>
            
            <button class="myButton" type="button" id="changeuser" title="Change User" onclick="funckangeuser();" style="margin: 0 5px;">Change User</button>
            
            <label class="lbl-right">Percentage</label>
            <input type="text" id="dscper" name="dscper" style="width:60px;" value='<s:property value="dscper"/>'/>
            
            <button class="myButton" type="button" id="process" title="Process" onclick="funprocess();" style="margin-left: 10px;">Process</button>
        </div>
    </div>

    <!-- 4. Item Details Entry (formerly #psearch) -->
    <div id="psearch" class="middle-panel" style="background:#FAEBD7;">
        <span class="middle-panel-title">Item Details Entry</span>
        <div class="field-row">
            <button class="myButton" type="button" id="setbtn" onclick="prosrch()">PS</button>
            <label class="lbl-right">Prod ID</label>
            <input type="text" id="sqotprdid" list="sqotproductid" style="width:120px;">
            <datalist id="sqotproductid"></datalist>
            
            <label class="lbl-right">Prod Name</label>
            <input type="text" id="sqotprdname" list="sqotprdts" style="flex:1;">
            <datalist id="sqotprdts"></datalist>
            
            <label class="lbl-right">Brand</label>
            <input type="text" id="brand" style="width:120px;">
            <input type="hidden" id="collqty">
            
            <label class="lbl-right">Unit</label>
            <select id="unit" onchange="closes()" style="width:80px;"></select>
            <input type="hidden" id="loads" class="myButton" value="Load Data">
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Qty</label>
            <input type="text" id="quantity" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="vatSwitch();" style="width:100px;">
            <input type="hidden" id="focs" onchange="vatSwitch();">
            
            <label class="lbl-right">Unit Price</label>
            <input type="text" id="uprice" onkeypress="javascript:return isNumber1(event);" onchange="vatSwitch();" style="width:100px; text-align:right;">
            
            <label class="lbl-right">Total</label>
            <input type="text" id="totamt" tabindex="-1" style="width:100px; text-align:right;" readonly>
            
            <label class="lbl-right" style="margin-left:auto;">Disc%</label>
            <input type="text" id="dispers" onkeypress="javascript:return isNumber1(event);" onchange="vatSwitch();" style="width:70px; text-align:right;">
            
            <label class="lbl-right">Discount</label>
            <input type="text" id="dict" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="vatSwitch();" style="width:100px; text-align:right;">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Net Total</label>
            <input type="text" id="amounts" tabindex="-1" style="width:100px; text-align:right;" readonly>
            
            <label class="lbl-right">Tax%</label>
            <input type="text" id="taxpers" onchange="vatSwitch();" tabindex="-1" style="width:60px; text-align:right;" readonly>
            
            <label class="lbl-right">Tax Amount</label>
            <input type="text" id="taxamounts" tabindex="-1" onkeypress="javascript:return isNumber1(event);" style="width:100px; text-align:right;" readonly>
            
            <label class="lbl-right">Net Tax Tot</label>
            <input type="text" id="taxamountstotal" tabindex="-1" onkeypress="javascript:return isNumber1(event);" style="width:100px; text-align:right;" readonly>
            
            <input type="hidden" id="cleardata">
            <div style="margin-left:auto; display:flex; gap:5px;">
                <button class="myButton" type="button" id="setbtn_add" onclick="setgrid()">ADD</button>
                <button class="myButton" type="button" id="setbtn1" onclick="detailstock()">SD</button>
                <button class="myButton" type="button" id="setbtn2" onclick="alterprosrch()" style="display:none;">Alternative Items</button>
            </div>
        </div>
    </div>

    <!-- Grids Section -->
    <div id="invoiceDiv" class="grid-container">
        <jsp:include page="invoiceGrid.jsp"></jsp:include>
    </div>
    <div id="hidegrid" hidden="true"><jsp:include page="hidegrid.jsp"></jsp:include></div>

    <!-- 5. Summary Section -->
    <div class="middle-panel" style="padding-bottom:10px;">
        <span class="middle-panel-title">Summary</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Product Amt</label>
            <input type="text" name="txtproductamt" id="txtproductamt" readonly="readonly" value='<s:property value="txtproductamt"/>' style="width:120px; text-align:right;">
            
            <label class="lbl-right">Apply Disc</label>
            <input type="checkbox" id="chkdiscount" name="chkdiscount" onchange="fundisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0 10px 0 0;">
            
            <label class="lbl-right">Disc %</label>
            <input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber(event);" style="width:80px; text-align:right;">
            
            <button class="myButton" type="button" id="btnCalculate" title="Calculate" onclick="funcalcu();" style="margin: 0 10px;">Calc</button>
            
            <label class="lbl-right">Disc Value</label>
            <input type="text" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber(event);" style="width:100px; text-align:right;">
            <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
            
            <label class="lbl-right">Round Of</label>
            <input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundvals();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" style="width:80px; text-align:right;">
            
            <label class="lbl-right">Net Total</label>
            <input type="text" name="txtnettotal" id="txtnettotal" readonly="readonly" value='<s:property value="txtnettotal"/>' onblur="funRoundAmt(this.value,this.id);" style="width:120px; text-align:right; font-weight:bold;">
        </div>

        <!-- Integrated Order Value Output -->
        <div class="field-row" style="background:#F2F4F4; border:1px solid #c5d3e0; padding:10px; margin-top:10px; border-radius:3px; justify-content:flex-end;">
            <label class="lbl-right" style="color:red; font-size:14px; margin-right:10px;">Order Value:</label>
            <input type="text" id="orderValue" readonly tabindex="-1" name="orderValue" style="width:150px; display:none;" value='<s:property value="orderValue"/>'/>
            <input type="text" id="orderValuefinal" name="orderValuefinal" style="width:180px; text-align:right; font-weight:bold; font-size:14px; background:transparent; border:none; outline:none;" readonly tabindex="-1" value='<s:property value="orderValuefinal"/>'/>
        </div>
    </div>

    <!-- 6. Service Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Service</span>
        <div id="servicegrid" class="grid-container" style="margin-bottom:0; border:none;">
            <jsp:include page="servicegrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- 8. Tax Details -->
    <div id="taxsss" class="middle-panel">
        <span class="middle-panel-title">Tax Details</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Total Tax</label>
            <input type="text" id="st" name="st" style="width:100px; text-align:right;" value='<s:property value="st"/>'>
            
            <button class="myButton" type="button" id="process1" title="Process Tax" onclick="funcalutax();" style="margin: 0 10px;">Process</button>
            
            <label id="labeltax1" class="lbl-right"></label>
            <input type="text" id="taxontax1" name="taxontax1" style="width:100px; text-align:right;" value='<s:property value="taxontax1"/>'>
            
            <label id="labeltax2" class="lbl-right"></label>
            <input type="text" id="taxontax2" name="taxontax2" style="width:100px; text-align:right;" value='<s:property value="taxontax2"/>'>
            
            <label id="labeltax3" class="lbl-right"></label>
            <input type="text" id="taxontax3" name="taxontax3" style="width:100px; text-align:right;" value='<s:property value="taxontax3"/>'>
            
            <label class="lbl-right" style="margin-left:auto;">Net Tax Total</label>
            <input type="text" id="taxtotal" name="taxtotal" style="width:120px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="taxtotal"/>'>
        </div>
    </div>

    <!-- 9. Shipping Details -->
    <div style="display:flex; gap:15px;">
        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Shipping Details</span>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Name</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="shipto" name="shipto" placeholder="Press F3" value='<s:property value="shipto"/>' onkeydown="getshipdetails(event)">
                    <svg class="magnifier-icon" onclick="$('#shipto').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Address</label>
                <input type="text" id="shipaddress" name="shipaddress" style="flex:1;" value='<s:property value="shipaddress"/>'>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Contact Person</label>
                <input type="text" id="contactperson" name="contactperson" style="flex:1;" value='<s:property value="contactperson"/>'>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Telephone</label>
                <input type="text" id="shiptelephone" name="shiptelephone" style="width:150px;" value='<s:property value="shiptelephone"/>'>
                <label class="lbl-right" style="width:60px;">MOB</label>
                <input type="text" id="shipmob" name="shipmob" style="width:150px;" value='<s:property value="shipmob"/>'>
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Email</label>
                <input type="text" id="shipemail" name="shipemail" style="width:150px;" value='<s:property value="shipemail"/>'>
                <label class="lbl-right" style="width:60px;">FAX</label>
                <input type="text" id="shipfax" name="shipfax" style="width:150px;" value='<s:property value="shipfax"/>'>
            </div>
        </div>

        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Shipment Records</span>
            <div id="shipdetdiv" class="grid-container" style="border:none; margin:0; height:100%;">
                <jsp:include page="shipdetailsGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
    
    <!-- 10. Terms and Conditions -->
    <div class="middle-panel">
        <span class="middle-panel-title">Terms and Conditions</span>
        <div id="termsDiv" class="grid-container" style="border:none; margin:0;">
            <jsp:include page="termsGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="clientcaid" name="clientcaid" value='<s:property value="clientcaid"/>'/>
        <input type="hidden" id="clientcatname" name="clientcatname" value='<s:property value="clientcatname"/>'/>
        <input type="hidden" id="clientpricegroup" name="clientpricegroup" value='<s:property value="clientpricegroup"/>'/>
        <input type="hidden" id="salesmancatid" name="salesmancatid" value='<s:property value="salesmancatid"/>'/>          
        <input type="hidden" id="salesmanusgper" name="salesmanusgper" value='<s:property value="salesmanusgper"/>'/>    
        <input type="hidden" id="checkhidegrid" name="checkhidegrid" value='<s:property value="checkhidegrid"/>'/>
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
        <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
        <input type="hidden" id="hidpsrno" name="hidpsrno" value='<s:property value="hidpsrno"/>'/>
        <input type="hidden" id="shipdocno" name="shipdocno" value='<s:property value="shipdocno"/>'/>
        <input type="hidden" id="shipdatagridlenght" name="shipdatagridlenght" value='<s:property value="shipdatagridlenght"/>'/>
        <input type="hidden" id="rowindexg" name="rowindexg" value='<s:property value="rowindexg"/>'/>
        <input type="hidden" id="hidsellprice" name="hidsellprice" value='<s:property value="hidsellprice"/>'/>
        <input type="hidden" id="fixaccount"> <input type="hidden" id="fixaccountdoc"> <input type="hidden" id="fixaccountname">       
        <input type="hidden" id="totalstock" name="totalstock" value='<s:property value="totalstock"/>'/>           
        <input type="hidden" id="oldqtystock" name="oldqtystock" value='<s:property value="oldqtystock"/>'/>
        <input type="hidden" id="totqtystock" name="totqtystock" value='<s:property value="totqtystock"/>'/>      
        <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>'/>
        <input type="hidden" id="clntacno" name="clntacno" value='<s:property value="clntacno"/>'/>
        <input type="hidden" id="allowdiscount" name="allowdiscount" value='<s:property value="allowdiscount"/>'/>
        <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
        <input type="hidden" id="tempunitdocno" > 
        <input type="hidden" id="tr_no" name="tr_no" value='<s:property value="tr_no"/>'/>
        <input type="hidden" id="typeoftaken"> 
        <input type="hidden" id="tax1per"> 
        <input type="hidden" id="tax2per">
        <input type="hidden" id="tax3per">
        <input type="hidden" id="taxdoc" > 
        <input type="hidden" id="hidcmbtaxqot" name="hidcmbtaxqot" value='<s:property value="hidcmbtaxqot"/>'/> 
    </div>
    
    <label><span id="stockmsg" style="position:absolute;z-index:1000;right:210px;top:2px;color:#003300;font-weight:bold;font-size: 12px;font-family: Times New Roman, Times, serif;"></span>
    <span id="salelbl" style="position:absolute;z-index:1000;right:50px;top:2px;color:#FF335E;font-weight:bold;font-size: 12px;font-family: Times New Roman, Times, serif;"></span></label>
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
<div id="userwindow"><div></div></div>
<div id="salwindow"><div></div></div>

</div>
</body>
</html>