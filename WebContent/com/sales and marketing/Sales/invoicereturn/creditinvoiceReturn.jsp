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
.modern-ui .myButton, .modern-ui .btn {
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
.modern-ui .myButton:hover, .modern-ui .btn:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

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

/* Retained Original Specific Overrides */
#psearch { background: #FAEBD7; }
</style>

<script type="text/javascript">
$(document).ready(function() {
    locationset();
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
            if(txtlocation>0){
                document.getElementById("errormsg").innerText="";
            }
            else {
                document.getElementById("errormsg").innerText="Select Location";
                document.getElementById("txtlocation").focus();
                return 0;
            }
        }
        else{
            document.getElementById("errormsg").innerText="Select a client";
            document.getElementById("clientid").focus();
            return 0;
        }
        if($('#mode').val()!= "view") {
            $('#refnosearchwindow').jqxWindow('open');
            refsearchContent('refnosearch.jsp');  
        }
    });

    $('#date').on('change', function (event) {
        var maindate = $('#date').jqxDateTimeInput('getDate');
         if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
            funDateInPeriod(maindate);
         }
    });
       
    $("#sqotprdname").change(function(){
        var dl=$("#sqotprdts")[0];
        var el=$("#sqotprdname")[0];
        if(el.value.trim() != ''){
            var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
            var tax = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxper');
            var unit = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unit');
            var brand = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-brandname');
            var psrno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-psrno');
            var specid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-specid');
            var unitdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitdocno');
            var uprice = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitprice');
            var balqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-balqty');
            var qty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-qty');
            var outqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-outqty');
            var totqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-totqty');
            var stkid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-stkid');
            var dis = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-dis');
            var discper = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-discper');
            var rdocno=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-rdocno');
            var foc=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-foc');
            var totamt=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-netotal');
            var taxamt=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxamt');
            var nettotal=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-finaltotamt');
            var total=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-total');
            var prodoc=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-doc_no');
            var deldoc=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-deldoc');
            var billtype=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-billtype');
            var vattype=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-vattype');
            
            document.getElementById("sqotprdid").value=prdid;
            document.getElementById("unit").value=unit;
            document.getElementById("unitdocno").value=unitdoc;
            document.getElementById("outqty").value=outqty;
            document.getElementById("balqty").value=balqty;
            document.getElementById("totqty").value=totqty;
            document.getElementById("stkid").value=stkid;
            document.getElementById("brand").value=brand;
            document.getElementById("psrno").value=psrno;
            document.getElementById("quantity").value=qty;
            document.getElementById("tempspecid").value=specid;
            document.getElementById("rdocno").value=rdocno;
            document.getElementById("deldoc").value=deldoc;
            document.getElementById("prodoc").value=prodoc;
            document.getElementById("biltype").value=billtype;
            document.getElementById("vattype").value=vattype;
            
            funRoundAmt2(totamt,"amounts");
            funRoundAmt2(uprice,"uprice");
            funRoundAmt2(nettotal,"taxamountstotal");
            funRoundAmt2(taxamt,"taxamounts");
            funRoundAmt2(tax,"taxpers");
            funRoundAmt2(totamt,"totamt");
            funRoundAmt2(dis,"dict");
            funRoundAmt2(discper,"dispers");
            getunit(psrno);
        }
    });
    
    $("#sqotprdid").change(function(){
        var dl=$("#sqotproductid")[0];
        var el=$("#sqotprdid")[0];
        if(el.value.trim() != ''){
            var productname = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-productname');
            var tax = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-taxper');
            var unit = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unit');
            var brand = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-brandname');
            var psrno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-psrno');
            var specid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-specid');
            var unitdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitdocno');
            var uprice = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitprice');
            var balqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-balqty');
            var qty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-qty');
            var outqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-outqty');
            var totqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-totqty');
            var stkid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-stkid');
            var dis = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-dis');
            var discper = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-discper');
            var rdocno=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-rdocno');
            var foc=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-foc');
            var totamt=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-netotal');
            var taxamt=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-taxamt');
            var nettotal=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-finaltotamt');
            var total=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-total');
            var prodoc=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-doc_no');
            var deldoc=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-deldoc');
            var billtype=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-billtype');
            var vattype=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-vattype');

            document.getElementById("sqotprdname").value=productname;
            document.getElementById("biltype").value=billtype;
            document.getElementById("vattype").value=vattype;
            document.getElementById("unit").value=unit;
            document.getElementById("psrno").value=psrno;
            document.getElementById("unitdocno").value=unitdoc;
            document.getElementById("outqty").value=outqty;
            document.getElementById("balqty").value=balqty;
            document.getElementById("totqty").value=totqty;
            document.getElementById("stkid").value=stkid;
            document.getElementById("temppsrno").value=psrno;  
            document.getElementById("quantity").value=qty;  
            document.getElementById("brand").value=brand;
            document.getElementById("tempspecid").value=specid;
            document.getElementById("rdocno").value=rdocno;
            document.getElementById("totamt").value=total;
            document.getElementById("prodoc").value=prodoc;
            document.getElementById("deldoc").value=deldoc;
            
            funRoundAmt2(totamt,"amounts");
            funRoundAmt2(uprice,"uprice");
            funRoundAmt2(nettotal,"taxamountstotal");
            funRoundAmt2(taxamt,"taxamounts");
            funRoundAmt2(tax,"taxpers");
            funRoundAmt2(totamt,"totamt");
            funRoundAmt2(dis,"dict");
            funRoundAmt2(discper,"dispers");
            getunit(psrno);
        }
    });
});

// Full preservation of your existing functions precisely as written 
function setgrid() {
    var temppsrno=document.getElementById("temppsrno").value; 
    var unit=document.getElementById("unit").value; 
    var rows1 = $("#jqxInvoiceReturn").jqxGrid('getrows');
    var aa=0;
    var upr=document.getElementById("uprice").value;
    var rows = $('#jqxInvoiceReturn').jqxGrid('getrows');
    var rowlength= rows.length;
    var rowg=$('#rowindexg').val();
    var qutval=$("#totqty").val();
    var qty=$('#quantity').val();
    var foc=$('#ffocs').val();
    var focval=$('#focval').val();
    
    if(parseFloat(qutval)<parseFloat(qty)){
        document.getElementById("errormsg").innerText="Qty should not be grater that available QTY : "+qutval;
        return 0;
    }else{ document.getElementById("errormsg").innerText=""; }
    
    if(parseFloat(focval)<parseFloat(foc)){
        document.getElementById("errormsg").innerText="Foc should not be grater that available FOC : "+focval;
        return 0;
    }else{ document.getElementById("errormsg").innerText=""; }
    
    if(parseInt(aa)==0) {
        if(document.getElementById("rowindexg").value!="" && !(document.getElementById("rowindexg").value==null) && !(document.getElementById("rowindexg").value=="undefiend")){
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "productid", document.getElementById("sqotprdid").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "productname", document.getElementById("sqotprdname").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "brandname", document.getElementById("brand").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unitdocno", document.getElementById("unitdoc").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unitprice", document.getElementById("uprice").value);  
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "total", document.getElementById("totamt").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "rdocno", document.getElementById("rdocno").value);
            if(parseFloat(document.getElementById("dispers").value)>0){
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "discper", document.getElementById("dispers").value);  
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "dis", document.getElementById("dict").value);
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "netotal", document.getElementById("amounts").value);   
            } else{
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg,"discpers", 0);  
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg,"dict", 0);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "nettotal", document.getElementById("totamt").value);
            }
            if(parseFloat(document.getElementById("taxpers").value)>0) {
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxper", document.getElementById("taxpers").value);
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxperamt", document.getElementById("taxamounts").value);
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "fintot", document.getElementById("taxamountstotal").value);           
            } else{
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxper", 0);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxperamt", 0);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "fintot",  document.getElementById("amounts").value);  
            }
            if(document.getElementById("unit").value>0) {
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unit", $("#unit option:selected").text());
            } 
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "psrno", document.getElementById("temppsrno").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowg, "prodoc", document.getElementById("doc_no").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "specid", document.getElementById("tempspecid").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowg, "productid" ,document.getElementById("sqotprdid").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "productname", document.getElementById("sqotprdname").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "qty", document.getElementById("qty").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "totqty", document.getElementById("totqty").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "balqty", document.getElementById("balqty").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "outqty", document.getElementById("outqty").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "detdocno", document.getElementById("deldoc").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unitdocno", document.getElementById("unitdocno").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "billtype", document.getElementById("biltype").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "vatype", document.getElementById("vattype").value);
            document.getElementById("rowindexg").value=""; 
        } else {
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("sqotprdid").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("sqotprdname").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "stkid", document.getElementById("stkid").value); 
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("prodoc").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);    
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowlength-1 , "productid", document.getElementById("sqotprdid").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("sqotprdname").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "rdocno", document.getElementById("rdocno").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unitdocno").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "totqty", document.getElementById("totqty").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "balqty", document.getElementById("balqty").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "outqty", document.getElementById("outqty").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "detdocno", document.getElementById("deldoc").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "billtype", document.getElementById("biltype").value);
            $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "vatype", document.getElementById("vattype").value);
            if(parseFloat(document.getElementById("dispers").value)>0){
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "discper", document.getElementById("dispers").value); 
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "dis", document.getElementById("dict").value);
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "netsss", document.getElementById("amounts").value);   
            } else{ 
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1,"discper", 0);  
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1,"dis", 0);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "netsss", document.getElementById("totamt").value);
            } 
            if(parseFloat(document.getElementById("taxpers").value)>0) {
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxper", document.getElementById("taxpers").value);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", document.getElementById("taxamounts").value);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "fintot", document.getElementById("taxamountstotal").value);            
            } else{
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxper", 0);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", 0);
                 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "fintot",  document.getElementById("amounts").value);  
            }
            if(document.getElementById("unit").value>0) {
                $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
            }
            $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
        }
        var ordertotal="0";
        var nettotalval="0";
        var exptotalval="0";
        funRoundAmt2(0,"roundOf");
        funRoundAmt2(ordertotal,"nettotal"); 
    }   
    document.getElementById("sqotprdid").value ="";
    document.getElementById("sqotprdname").value="";
    document.getElementById("brand").value=""; 
    document.getElementById("quantity").value ="";
    document.getElementById("unit").value ="";
    document.getElementById("dispers").value ="";
    document.getElementById("dict").value ="";
    document.getElementById("uprice").value="";
    document.getElementById("totamt").value="";
    document.getElementById("amounts").value="";
    document.getElementById("taxpers").value=""
    document.getElementById("taxamounts").value="";
    document.getElementById("taxamountstotal").value="";
    document.getElementById("temppsrno").value="";
    document.getElementById("tempspecid").value="";
}

function calculatedata(val) {
    var quantity=document.getElementById("quantity").value;
    var qutval=document.getElementById("qutval").value;
    var uprice=document.getElementById("uprice").value;
    var taxpers=document.getElementById("taxpers").value;
    var disper=document.getElementById("dispers").value;
    var discount=0; var totamt=0; var netamount=0; var taxamounts=0; var taxamountstotal=0; 
    
    if(quantity=="" || quantity==null || quantity==0 ||typeof(width)=="quantity"|| typeof(quantity)=="NaN") { quantity=0; }
    if(qutval=="" || qutval==null || qutval==0 ||typeof(width)=="qutval"|| typeof(qutval)=="NaN") { qutval=0; }
    if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN") { uprice=0; }
    if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN") { disper=0; }
    
    if(parseFloat(quantity)>0 && parseFloat(uprice)>0){
         totamt=parseFloat(quantity)*parseFloat(uprice);
         if(parseFloat(disper)>0){
            discount=(parseFloat(totamt)*parseFloat(disper))/100;
            netamount=parseFloat(totamt)-parseFloat(discount);
        }else{
            disper=0; discount=0; netamount=totamt;
        }
    }
    
    if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN") { taxpers=0; }
    
    if(parseFloat(taxpers)>0) {
         taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
         taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
    } else{
         taxamountstotal=netamount;
    }
    document.getElementById("totamt").value=(totamt).toFixed(2);
    document.getElementById("amounts").value=(netamount).toFixed(2);
    document.getElementById("dict").value=(discount).toFixed(2);
    document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
    document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
} 

function getunit(val){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype;
            for ( var i = 0; i < type.length; i++) { optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>'; }
            $("select#unit").html(optionstype);     
        }
    }
    x.open("GET","getunit.jsp?psrno="+val,true);
    x.send();
}

function getProduct() {
     var prodsearchtype=$("#prodsearchtype").val();
     var locid=document.getElementById("locationid").value;
     var docno=document.getElementById("refmasterdocno").value;
     var docdepid=0; 
     var optionsyear = "";
     var optionsyearnw = "";
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            var response = JSON.parse(items.trim());
            var prddatas = response.pddata; 
            $.each(prddatas, function( index, value ) {
                optionsyearnw += '<option value="' + value.part_no + '" data-productname="'+value.productname+'" data-taxper="'+value.taxper+'" data-unit="'+value.unit+'" data-brandname="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdocno="'+value.unitdocno+'" data-unitprice="'+value.unitprice+'"data-balqty="'+value.balqty+'" data-qty="'+value.qty+'" data-outqty="'+value.outqty+'" data-totqty="'+value.totqty+'"data-stkid="'+value.stkid+'"data-dis="'+value.dis+'"data-discper="'+value.discper+'"data-doc_no="'+value.doc_no+'"data-rdocno="'+value.rdocno+'"data-foc="'+value.foc+'"data-total="'+value.total+'"data-taxamt="'+value.taxamt+'"data-netotal="'+value.netotal+'"data-finaltotamt="'+value.finaltotamt+'"data-deldoc="'+value.detdocno+'"data-billtype="'+value.billtype+'"data-vattype="'+value.vattype+'"></option>';
                optionsyear += '<option value="' + value.productname + '" data-prdid="'+value.part_no+'" data-taxper="'+value.taxper+'" data-unit="'+value.unit+'" data-brandname="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdocno="'+value.unitdocno+'" data-unitprice="'+value.unitprice+'"data-balqty="'+value.balqty+'" data-qty="'+value.qty+'" data-outqty="'+value.outqty+'" data-totqty="'+value.totqty+'"data-stkid="'+value.stkid+'"data-dis="'+value.dis+'"data-discper="'+value.discper+'"data-doc_no="'+value.doc_no+'"data-rdocno="'+value.rdocno+'"data-foc="'+value.foc+'"data-total="'+value.total+'"data-taxamt="'+value.taxamt+'"data-netotal="'+value.netotal+'"data-finaltotamt="'+value.finaltotamt+'"data-deldoc="'+value.detdocno+'"data-billtype="'+value.billtype+'"data-vattype="'+value.vattype+'"></option>';
            });
            $("datalist#sqotprdts").html(optionsyear);
            $("datalist#sqotproductid").html(optionsyearnw);           
        }
    }
    x.open("GET", "getProduct.jsp?prodsearchtype="+prodsearchtype+"&docno="+docno+"&locid="+locid, true);
    x.send();
}

function locationset(){
    var brchid = $("#brchName").val();
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('####');
            var locItems = items[0].split(",");
            var locIdItems = items[1].split(",");
            document.getElementById("txtlocation").value=locItems;
            document.getElementById("locationid").value= locIdItems;
        }
    }
    x.open("GET", "locationset.jsp?brchid="+brchid, true);
    x.send();
} 

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

function funRoundAmt4(value,id){ var res=parseFloat(value).toFixed(4); var res1=(res=='NaN'?"0":res); document.getElementById(id).value=res1; }  
function funRoundAmt2(value,id){ var res=parseFloat(value).toFixed(2); var res1=(res=='NaN'?"0":res); document.getElementById(id).value=res1; }  

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
    $('#payDueDate').jqxDateTimeInput({disabled: true});
    $("#jqxInvoiceReturn").jqxGrid({ disabled: true});
    $('#btnvaluechange').hide();
    chkfoc();
    chktax();
}

function funRemoveReadOnly(){
    gridLoad(); locationset();
    chkmultiqty();
    chkfoc();
    chktax();
    getCurrencyIds();
    document.getElementById("editdata").value="";
    $('#frmSalesReturn input').attr('readonly', false );
    $('#frmSalesReturn select').attr('disabled', false);
    $('#txtclient').attr('disabled', true);
    $('#txtclientdet').attr('disabled', true);
    $('#rrefno').attr('disabled', true);
    $('#cmbcurr').attr('disabled', true);
    $('#cmbbilltype').attr('disabled', true);
    $('#txtsalesperson').attr('readonly', true );

    $('#rrefno').attr('readonly', true );
    $('#txtlocation').attr('readonly', true );
    $('#txtsalesperson').attr('readonly', true );
    $('#txtproductamt').attr('readonly', true );
    $('#txtdiscount').attr('readonly', true );
    $('#txtnettotal').attr('readonly', true );
    $('#txtlocation').attr('disabled', true );
    
    $('#orderValue').attr('readonly', true);
    
    $('#date').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
    $("#jqxInvoiceReturn").jqxGrid({ disabled: false}); 
    
    if ($("#mode").val() == "E") {
        $('#btnvaluechange').show();
        $("#jqxInvoiceReturn").jqxGrid({ disabled: true});
        $('#date').jqxDateTimeInput({disabled: true});
        $('#payDueDate').jqxDateTimeInput({disabled: true});
    }
    
    if ($("#mode").val() == "A") {
        $('#date').jqxDateTimeInput({disabled: false});
        $('#txtsalesperson').attr('readonly', false );
        $('#payDueDate').jqxDateTimeInput({disabled: false});
        $('#txtlocation').attr('disabled', false );
        $('#txtclient').attr('disabled', false );
        $('#txtclientdet').attr('disabled', false );
        $('#cmbcurr').attr('disabled', false );
        $('#rrefno').attr('disabled', false );
        $('#cmbbilltype').attr('disabled', true );
        $('#txtlocation').attr('readonly', false );
        
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
    $('#date').jqxDateTimeInput({disabled: false});
    $('#payDueDate').jqxDateTimeInput({disabled: false});
    $('#txtlocation').attr('disabled', false );
    $('#txtclient').attr('disabled', false );
    $('#txtclientdet').attr('disabled', false );
    $('#cmbcurr').attr('disabled', false );
    $('#rrefno').attr('disabled', false );
    $('#cmbbilltype').attr('disabled', false );
    $('#txtlocation').attr('readonly', false );
    $('#txtsalesperson').attr('readonly', false );

    var maindate = $('#date').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(maindate);
    if(validdate==0){ return 0; }

    if($('#txtlocation').val()== "") { document.getElementById("errormsg").innerText="select location"; document.getElementById("txtlocation").focus(); return 0; }
    
    var currate=$('#currate').val();
    if(currate==null || currate=='' || currate=='undefined' || typeof(currate)=='undefined' || parseFloat(currate)==0.0 || parseFloat(currate)<0.0){
        document.getElementById("errormsg").innerText="Invalid Rate";
        return 0;
    }

    var rows = $("#jqxInvoiceReturn").jqxGrid('getrows');
    $('#gridlength').val(rows.length);
    var cnt=0;
    for(var i=0 ; i < rows.length ; i++){ 
        var newTextBox = $(document.createElement("input")).attr("type", "dil").attr("id", "prodg"+cnt).attr("name", "prodg"+cnt).attr("hidden", "true");
        if(parseInt(rows[i].qty)>0 && parseInt(rows[i].prodoc)>0) { 
            newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"
             +rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netsss+"::"+rows[i].specid+"::"+rows[i].outqty+"::"
             +rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].rdocno+"::"+rows[i].detdocno
             +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].fintot);
            newTextBox.appendTo('form');
            cnt=cnt+1;
        }
    }
    if(cnt<=0){
        document.getElementById("errormsg").innerText="Add product Details";
        $("#overlay, #PleaseWait").hide();
        return 0;
    }
    
    $('#gridlength').val(cnt);
    var retval = restrictEdit();  
    if(retval==0){      
        document.getElementById("errormsg").innerText="Item Already Returnd!";  
    }else{
        document.getElementById("errormsg").innerText="";
    }  
    return retval;
} 

function setValues(){
    $("#btnEdit").attr('disabled', true );
    $("#btnDelete").attr('disabled', true );
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
        $("#btnDelete").attr('disabled', true );  
        $("#invoiceDiv").load("invoiceReturnGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&locaid="+locaid+"&cond=2");
    }
}

function getCustomer(event){ var x= event.keyCode; if(x==114){ } }

function getCurrencyIds(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            items=items.split('####');
            var curidItems=items[0].split(",");
            var curcodeItems=items[1].split(",");
            var optionscurr = '';
            for ( var i = 0; i < curcodeItems.length; i++) { optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>'; }
            $("select#cmbcurr").html(optionscurr);
            if($('#hidcmbcurr').val()!="") { $('#cmbcurr').val($('#hidcmbcurr').val()); }
        }
    }
    x.open("GET","getCurrencyId.jsp",true); x.send();
}

function getPriceGroup(){ return 0; }

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
    if($('#hidcmbbilltype').val()!="") { $('#cmbbilltype').val($('#hidcmbbilltype').val()); }
    if($('#hidcmbreftype').val()!="") { $('#cmbreftype').val($('#hidcmbreftype').val()); }
    if($('#hidcmbreftype').val()=="SQOT") { $('#rrefno').attr('disabled', false); $('#rrefno').attr('readonly', true); }
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
    
    funRoundAmt(descvalue,"txtdiscount"); funRoundAmt(netval,"txtnettotal");
    var aa;
    if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") {
        aa=parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
    }
    else { aa=document.getElementById("txtnettotal").value; }
    document.getElementById("orderValue").value=aa; 
    funRoundAmt(aa,"orderValue");
    
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
    funRoundAmt(descper,"descPercentage"); funRoundAmt(netval,"txtnettotal");
    funcalcu();
}
        
function roundval() {
    var  netTotaldown=document.getElementById('txtnettotal').value;
    var roundOf=document.getElementById('roundOf').value;
    var  netval=parseFloat(netTotaldown)+parseFloat(roundOf);
    funRoundAmt(netval,"txtnettotal"); funRoundAmt(netval,"orderValue");
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
             $('#date').jqxDateTimeInput({disabled: false});
             $('#payDueDate').jqxDateTimeInput({disabled: false});
             $('#txtlocation').attr('disabled', false ); $('#txtclient').attr('disabled', false );
             $('#txtclientdet').attr('disabled', false ); $('#cmbcurr').attr('disabled', false );
             $('#rrefno').attr('disabled', false ); $('#cmbbilltype').attr('disabled', false );
             $('#txtlocation').attr('readonly', false ); $('#txtsalesperson').attr('readonly', false );
             $("#jqxInvoiceReturn").jqxGrid({ disabled: false});
             $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
        }
    });
}

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveSalesInvoiceReturncr");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"printinvcreditret?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=CREDIT","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
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

function restrictEdit(){
    var retval = 1; 
    if($("#mode").val()=="E" || $("#mode").val()=="R"){        
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;  
                if(parseInt(items)>0){ retval = 0; } else { retval = 1; }
            }
        }
        x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, false);                  
        x.send();
    }
    return retval; 
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
            for ( var i = 0; i < pgcode.length; i++) { optionspg += '<option  value="' + pgid[i] + '">' + pgcode[i] + '</option>'; }
            $("select#cmbbilltype").html(optionspg);
            if($('#hidcmbbilltype').val()!="") { $('#cmbbilltype').val($('#hidcmbbilltype').val()); }
            gettaxaccount(1);
        }
    }
    x.open("GET","getBillType.jsp",true); x.send();
}

function isNumber1(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
    if (iKeyCode == 45) { return true; } 
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) { document.getElementById("errormsg").innerText=" Enter Numbers Only"; return false; }
    document.getElementById("errormsg").innerText=""; return true;
}
</script>

</head>
<body onload="setValues();getCurrencyIds();getBill();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSalesReturn" action="saveSalesInvoiceReturncr" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>
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
                <option value="credit">CREDIT</option>
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
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select name="cmbcurr" id="cmbcurr" style="width:125px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/>
            <input type="text" id="currate" name="currate" style="width:100px; text-align:right;" value='<s:property value="currate"/>'/>
            
            <label id="billname" class="lbl-right" style="width:80px; margin-left:auto;">Bill Type</label>
            <select id="cmbbilltype" name="cmbbilltype" style="width:125px;" value='<s:property value="cmbbilltype"/>'></select>
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

    <!-- 3. Item Details Entry (formerly #psearch) -->
    <div id="psearch" class="middle-panel" style="background:#FAEBD7;">
        <span class="middle-panel-title">Item Details Entry</span>
        <div class="field-row">
            <label class="lbl-right">Prod ID</label>
            <input type="text" id="sqotprdid" list="sqotproductid" style="width:120px;">
            <datalist id="sqotproductid"></datalist>

            <label class="lbl-right">Prod Name</label>
            <input type="text" id="sqotprdname" list="sqotprdts" style="flex:1;">
            <datalist id="sqotprdts"></datalist>

            <label class="lbl-right">Unit</label>
            <select id="unit" onchange="closes()" style="width:80px;"></select>
            
            <label class="lbl-right">Qty</label>
            <input type="text" id="quantity" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:80px; text-align:right;">

            <label class="lbl-right">Unit Price</label>
            <input type="text" id="uprice" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:100px; text-align:right;">

            <label class="lbl-right">Total</label>
            <input type="text" id="totamt" tabindex="-1" style="width:100px; text-align:right;" readonly>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right">Disc%</label>
            <input type="text" id="dispers" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:60px; text-align:right;">

            <label class="lbl-right">Discount</label>
            <input type="text" id="dict" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="vatSwitch();" style="width:80px; text-align:right;">

            <label class="lbl-right">Net Total</label>
            <input type="text" id="amounts" tabindex="-1" style="width:100px; text-align:right;" readonly>

            <label class="lbl-right">Tax%</label>
            <input type="text" id="taxpers" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" tabindex="-1" style="width:60px; text-align:right;" readonly>

            <label class="lbl-right">Tax Amt</label>
            <input type="text" id="taxamounts" tabindex="-1" onkeypress="javascript:return isNumber1(event);" style="width:80px; text-align:right;" readonly>

            <label class="lbl-right">Net Tax Tot</label>
            <input type="text" id="taxamountstotal" tabindex="-1" onkeypress="javascript:return isNumber1(event);" style="width:100px; text-align:right;" readonly>

            <button class="myButton" type="button" id="setbtn" onclick="setgrid()" style="margin-left:auto;">ADD</button>
            <input type="hidden" id="cleardata">
        </div>
    </div>

    <!-- Grid Data Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="invoiceDiv" class="grid-container" style="border:none; margin:0;">
            <jsp:include page="invoiceReturnGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Output for Order Value -->
    <div class="field-row" style="display:none;">
        <input type="hidden" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
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
        <input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>'/>
        <input type="hidden" id="unitdocno" name="unitdocno" value='<s:property value="unitdocno"/>'/>
        <input type="hidden" id="outqty" name="outqty" value='<s:property value="outqty"/>'/>
        <input type="hidden" id="balqty" name="balqty" value='<s:property value="balqty"/>'/>
        <input type="hidden" id="totqty" name="totqty" value='<s:property value="totqty"/>'/>
        <input type="hidden" id="stkid" name="stkid" value='<s:property value="stkid"/>'/>
        <input type="hidden" id="temppsrno" name="temppsrno" value='<s:property value="temppsrno"/>'/>
        <input type="hidden" id="tempspecid" name="tempspecid" value='<s:property value="tempspecid"/>'/>
        <input type="hidden" id="rdocno" name="rdocno" value='<s:property value="rdocno"/>'/>
        <input type="hidden" id="dis" name="dis" value='<s:property value="dis"/>'/>
        <input type="hidden" id="discper" name="discper" value='<s:property value="discper"/>'/>
        <input type="hidden" id="rowindexg" name="rowindexg" value='<s:property value="rowindexg"/>'/>
        <input type="hidden" id="prodoc" name="prodoc" value='<s:property value="prodoc"/>'/>
        <input type="hidden" id="brand" name="brand" value='<s:property value="brand"/>'/>
        <input type="hidden" id="deldoc" name="deldoc" value='<s:property value="deldoc"/>'/>
        <input type="hidden" id="biltype" name="biltype" value='<s:property value="biltype"/>'/>
        <input type="hidden" id="vattype" name="vattype" value='<s:property value="vattype"/>'/>
        <input type="hidden" id="qutval" name="qutval" value='<s:property value="qutval"/>'/>
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