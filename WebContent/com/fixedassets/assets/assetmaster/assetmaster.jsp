<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
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
    $("#masterdate, #purchasedate, #warexpdate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    setTimeout(function () {
        $("#masterdate, #purchasedate, #warexpdate").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#masterdate, #purchasedate, #warexpdate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);

    var popupConfig = {theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27};
    $('#accountDetailsWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 }})).jqxWindow('close');
    $('#fixaccountDetailsWindow').jqxWindow($.extend({}, popupConfig, {width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 }})).jqxWindow('close');
    
    $('#supplieraccId').dblclick(function(){
        if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
            $('#accountDetailsWindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp');
        }
    }); 
    
    $('#masterdate').on('change', function (event) {
        var maindate = $('#masterdate').jqxDateTimeInput('getDate');
         if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
            funDateInPeriod(maindate);
         }
    });
    
    $('#fixedassetaccId').dblclick(function(){
        if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
            $('#fixaccountDetailsWindow').jqxWindow('open');
            accountSearchContent1('depaccountsDetailsSearch.jsp?value='+1);
        }
    }); 
    
    $('#accdepraccId').dblclick(function(){
        if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
            $('#fixaccountDetailsWindow').jqxWindow('open');
            accountSearchContent1('depaccountsDetailsSearch.jsp?value='+2);
        }
    }); 
    
    $('#depraccId').dblclick(function(){
        if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
            $('#fixaccountDetailsWindow').jqxWindow('open');
            accountSearchContent1('depaccountsDetailsSearch.jsp?value='+3);
        }
    }); 
    
    $('#purchasedate').on('change', function (event) {
         if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
           var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));
           var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate'));
           if(purchsedate>masterdate){
               document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
               $('#purchasedate').jqxDateTimeInput('focus'); 
               return false;
           } else {
               document.getElementById("errormsg").innerText="";  
           }
         }
    });
});

function getaccountdetails1(value){
    if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
        var x= event.keyCode;
        if(x==114){
            $('#fixaccountDetailsWindow').jqxWindow('open');
            accountSearchContent1('depaccountsDetailsSearch.jsp?value='+value);    
        }
    }
}  

function getaccountdetails(event){
    if($('#mode').val()=="A" || $('#mode').val()=="E" ) {
        var x= event.keyCode;
        if(x==114){
            $('#accountDetailsWindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp');    
        }
    }
}  

function accountSearchContent1(url) {
    $.get(url).done(function (data) {
        $('#fixaccountDetailsWindow').jqxWindow('setContent', data);
    }); 
}
    
function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
    }); 
}

function funReset(){}

function funReadOnly(){     
    $('#frmassetmastrer input').attr('readonly',true);   
    $('#frmassetmastrer select').attr('disabled',true);  
    $('#warexpdate').jqxDateTimeInput({ disabled: true});
    $('#masterdate').jqxDateTimeInput({ disabled: true});
    $('#purchasedate').jqxDateTimeInput({ disabled: true});
    $('#subgriddis').attr('disabled',true); 
    $('#opening').attr('disabled',true); 
}

function funRemoveReadOnly(){
    $('#frmassetmastrer input').attr('readonly',false);  
    $('#frmassetmastrer select').attr('disabled',false); 
    $('#subgriddis').attr('disabled',false); 
    $('#opening').attr('disabled',false); 
    $('#accumdepr').attr('disabled',true); 
    $('#docno').attr('readonly',true);  
    $('#warexpdate').jqxDateTimeInput({ disabled: false});
    $('#masterdate').jqxDateTimeInput({ disabled: false});
    $('#purchasedate').jqxDateTimeInput({ disabled: false});
    
    $('#fixedassetaccId').attr('readonly',true);  
    $('#accdepraccId').attr('readonly',true);  
    $('#depraccId').attr('readonly',true);  
    $('#fixedassetaccName').attr('readonly',true);  
    $('#accdepraccIdName').attr('readonly',true);  
    $('#supplieraccId').attr('readonly',true);  
    $('#supplieraccName').attr('readonly',true);  
       
    if ($("#mode").val() == "A") {
        $('#subdetail').hide();
        $('#freespace').show();
        $('#accumdepr').attr('disabled',true); 
        $('#warexpdate').val(new Date());
        $('#masterdate').val(new Date());
        $('#purchasedate').val(new Date());
        $("#jqxsubdetails").jqxGrid('clear');
        $("#jqxsubdetails").jqxGrid('addrow', null, {});
        $("#jqxsubdetails").jqxGrid('addrow', null, {});
        $("#jqxsubdetails").jqxGrid('addrow', null, {});
        document.getElementById("masteredit").value="";
    }
    
    if($('#mode').val()=='E') {
        if(document.getElementById("openingval").value==1) {
            document.getElementById("opening").checked =true;
            $('#accumdepr').attr('disabled',false); 
            $('#accumdepr').attr('readonly',false);
        } else {
            document.getElementById("opening").checked =false;
            $('#accumdepr').attr('disabled',true); 
        }
        var rows = $('#jqxsubdetails').jqxGrid('getrows');
        var rowlength= rows.length;
        if (rowlength == 0) {
             $("#jqxsubdetails").jqxGrid('addrow', null, {});   
             $("#jqxsubdetails").jqxGrid('addrow', null, {});   
             $("#jqxsubdetails").jqxGrid('addrow', null, {});   
        } else {
             $("#jqxsubdetails").jqxGrid('addrow', null, {});   
        }
        funchkforedit(document.getElementById("srno").value);   
    }
    
    if($('#mode').val()=='D') {
        $('#frmassetmastrer input').attr('readonly',false);  
        $('#frmassetmastrer select').attr('disabled',false); 
        $('#warexpdate').jqxDateTimeInput({ disabled: false});
        $('#masterdate').jqxDateTimeInput({ disabled: false});
        $('#purchasedate').jqxDateTimeInput({ disabled: false});
        $('#accumdepr').attr('disabled',false); 
        funchkfordel(document.getElementById("srno").value);    
        funReadOnly();
        exit();
    }

    function funchkfordel(srno) {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();  
                if(parseInt(items)>0) {
                    $.messager.alert('Message',' Transaction Already Exists','warning');  
                    return 0;
                } else {
                    $('#frmassetmastrer').submit(); 
                }
            }
        }
        x.open("GET", "geteditcasechk.jsp?srno="+document.getElementById("srno").value, true);
        x.send();
    }
}

function funchkforedit(srno) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            if(parseInt(items)>0) {
                document.getElementById("masteredit").value="master";
                $('#supplieraccId').attr('disabled',true); 
                $('#totalpuchvalue').attr('disabled',true); 
                $('#opening').attr('disabled',true); 
                $('#accumdepr').attr('disabled',true); 
                $('#fixedassetaccId').attr('disabled',true); 
                $('#accdepraccId').attr('disabled',true); 
                $('#depraccId').attr('disabled',true); 
            } else {
                document.getElementById("masteredit").value="do";
            }
        }
    }
    x.open("GET", "geteditcasechk.jsp?srno="+srno, true);
    x.send();
}

function funNotify(){   
    var maindate = $('#masterdate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(maindate);
    if(validdate==0){ return 0; }
           
    var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));    
    var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate')); 
    if(purchsedate>masterdate){
        document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
        $('#purchasedate').jqxDateTimeInput('focus'); 
        return false;
    } else {
        document.getElementById("errormsg").innerText="";  
    }
             
    if($('#mode').val()=='E') {
        if(document.getElementById("masteredit").value=="master") {
            $('#supplieraccId').attr('disabled',false); 
            $('#totalpuchvalue').attr('disabled',false); 
            $('#opening').attr('disabled',false); 
            $('#accumdepr').attr('disabled',false); 
            $('#fixedassetaccId').attr('disabled',false); 
            $('#accdepraccId').attr('disabled',false); 
            $('#depraccId').attr('disabled',false); 
        } else {
            if(document.getElementById("supplieraccId").value=="") {
                document.getElementById("errormsg").innerText="Search Supplier Account";  
                document.getElementById("supplieraccId").focus();
                return 0;
            }
            if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
                document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                document.getElementById("totalpuchvalue").focus();
                return 0;
            }
            if(document.getElementById("openingval").value==1) {
                if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0) {
                    document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
                    document.getElementById("accumdepr").focus();
                    return 0;
                }
                var total= document.getElementById("totalpuchvalue").value;
                var accdepn=document.getElementById("accumdepr").value;
                if(parseFloat(accdepn)>parseFloat(total)) {
                    document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
                    document.getElementById("accumdepr").focus();
                    return 0;
                } 
            }
            if(document.getElementById("depper").value=="") {
                document.getElementById("errormsg").innerText="Enter Depreciation %";  
                document.getElementById("depper").focus();
                return 0;
            }
            if(document.getElementById("fixedassetaccId").value=="") {
                document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
                 document.getElementById("fixedassetaccId").focus();
                return 0;
            }
            if(document.getElementById("accdepraccId").value=="") {
                document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
                 document.getElementById("accdepraccId").focus();
                return 0;
            }
            if(document.getElementById("depraccId").value=="") {
                document.getElementById("errormsg").innerText="Search Depreciation Account";  
                 document.getElementById("depraccId").focus();
                return 0;
            }
        }
    }
       
    if($('#mode').val()=='A') {
        if(document.getElementById("supplieraccId").value=="") {
            document.getElementById("errormsg").innerText="Search Supplier Account";  
            document.getElementById("supplieraccId").focus();
            return 0;
        }
        if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
            document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
            document.getElementById("totalpuchvalue").focus();
            return 0;
        }
        if(document.getElementById("openingval").value==1) {
            if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0) {
                document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
                document.getElementById("accumdepr").focus();
                return 0;
            }
            var total= document.getElementById("totalpuchvalue").value;
            var accdepn=document.getElementById("accumdepr").value;
            if(parseFloat(accdepn)>parseFloat(total)) {
                document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
                document.getElementById("accumdepr").focus();
                return 0;
            } 
        }
        if(document.getElementById("depper").value=="") {
            document.getElementById("errormsg").innerText="Enter Depreciation %";  
            document.getElementById("depper").focus();
            return 0;
        }
        if(document.getElementById("fixedassetaccId").value=="") {
            document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
             document.getElementById("fixedassetaccId").focus();
            return 0;
        }
        if(document.getElementById("accdepraccId").value=="") {
            document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
             document.getElementById("accdepraccId").focus();
            return 0;
        }
        if(document.getElementById("depraccId").value=="") {
            document.getElementById("errormsg").innerText="Search Depreciation Account";  
             document.getElementById("depraccId").focus();
            return 0;
        }
    }
    
    var rows = $("#jqxsubdetails").jqxGrid('getrows');
    $('#gridval').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
           .attr("type", "dil")
           .attr("id", "paytest"+i)
           .attr("name", "paytest"+i)
           .attr("hidden", "true"); 
       newTextBox.val(rows[i].sr_no+"::"+rows[i].desc1+" :: "+rows[i].qty+" :: ");
       newTextBox.appendTo('form');
    }
    return 1;
}

function funChkButton() {}

function funFocus(){
    $('#masterdate').jqxDateTimeInput('focus'); 
}

function setValues() {
    if($('#hidmasterdate').val()){
        $("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
    }
    if($('#hidpurchasedate').val()){
        $("#purchasedate").jqxDateTimeInput('val', $('#hidpurchasedate').val());
    }
    if($('#hidwarexpdate').val()){
        $("#warexpdate").jqxDateTimeInput('val', $('#hidwarexpdate').val());
    }
    var docnos=document.getElementById("docno").value;
    if(parseInt(docnos)>0) {
        if(document.getElementById("subgriddisval").value==1) {
            $("#subdetail").load("subdetails.jsp?docno="+docnos);
        }
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    funSetlabel();  
    funsetdatas();
}

function funsetdatas() {
    if(document.getElementById("subgriddisval").value==1) {
        document.getElementById("subgriddis").checked=true;
        $('#subdetail').show();
        $('#freespace').hide();
    } else {
        document.getElementById("subgriddis").checked=false;
        $('#subdetail').hide();
        $('#freespace').show();
    }
    
    if(document.getElementById("openingval").value==1) {
        document.getElementById("opening").checked =true;
        if($('#mode').val()!='view') {
            $('#accumdepr').attr('disabled',false); 
            $('#accumdepr').attr('readonly',false);
        }
    } else {
        document.getElementById("opening").checked =false;
        $('#accumdepr').attr('disabled',true); 
    }
    
    if($('#assetGroupval').val()!=""){
        $("#assetGroup").val($('#assetGroupval').val());
    }
    if($('#locationval').val()!=""){
        $("#location").val($('#location').val());
    }
}

function fundisgrid() {
    if(document.getElementById("subgriddis").checked == true) {
        $('#subdetail').show();
        $('#freespace').hide();
        document.getElementById("subgriddisval").value=1;
    } else {
        $('#subdetail').hide();
        $('#freespace').show();
        document.getElementById("subgriddisval").value=0;
    }
}
    
function funopening() {
    if(document.getElementById("opening").checked == true) {
        document.getElementById("openingval").value=1;
        $('#accumdepr').attr('disabled',false);     
        $('#accumdepr').attr('readonly',false); 
    } else {
        document.getElementById("openingval").value=0;
        document.getElementById("accumdepr").value="";
        $('#accumdepr').attr('disabled',true);  
        $('#accumdepr').attr('readonly',false);
    }
}
    
function funSearchLoad(){
    changeContent('mastersearch.jsp', $('#window'));
}
    
function getAssetgp() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText; 
            items = items.split('***');
            var branchItems = items[0].split(",");
            var branchIdItems = items[1].split(",");
            var optionsbranch = '<option value="">--Select--</option>';
            for (var i = 0; i < branchItems.length; i++) {
                optionsbranch += '<option value="' + branchIdItems[i] + '">' + branchItems[i] + '</option>';
            }
            $("select#assetGroup").html(optionsbranch);
            if ($('#assetGroupval').val() != null) {
                $('#assetGroup').val($('#assetGroupval').val());
            }
        }
    }
    x.open("GET", "getAssetgp.jsp", true);
    x.send();
}

function getloc() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText; 
            items = items.split('***');
            var branchItems1 = items[0].split(",");
            var branchIdItems1 = items[1].split(",");
            var optionsbranch1 = '<option value="">--Select--</option>';
            for (var i = 0; i < branchItems1.length; i++) {
                optionsbranch1 += '<option value="' + branchIdItems1[i] + '">' + branchItems1[i] + '</option>';
            }
            $("select#location").html(optionsbranch1);
            if ($('#locationval').val() != null) {
                $('#location').val($('#locationval').val());
            }
        }
    }
    x.open("GET", "getLocatons.jsp", true);
    x.send();
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText="Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}
    
function funcalculatedep() {
    if ($("#mode").val() == "A" ) {
        if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
            document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
            document.getElementById("lifetimeyear").value="";
            document.getElementById("totalpuchvalue").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        }
    }
    if($('#mode').val()=='E') {
        if(document.getElementById("masteredit").value=="master") {}
        else {
            if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
                document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                document.getElementById("lifetimeyear").value="";
                document.getElementById("totalpuchvalue").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText="";
            }
        }
    }
    if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
        var year=document.getElementById("lifetimeyear").value;
        var depval=((1/parseFloat(year))*100);
        funRoundAmt(depval,"depper");
    }
}
    
function funcalcuyear() {
    if ($("#mode").val() == "A" ) {
        if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
            document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
            document.getElementById("depper").value="";
            document.getElementById("totalpuchvalue").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        }
    }
    if($('#mode').val()=='E') {
        if(document.getElementById("masteredit").value=="master") {}
        else {
            if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
                document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                document.getElementById("depper").value="";
                document.getElementById("totalpuchvalue").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText="";
            }
        }
    }
    if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
        var dep=document.getElementById("depper").value;
        var yearval=(100/parseFloat(dep));
        funRoundAmt(yearval,"lifetimeyear");
    }
}

function funchktotal() {
    if ($("#mode").val() == "A" ) {
        if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
            document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
            document.getElementById("totalpuchvalue").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        }
        var total= document.getElementById("totalpuchvalue").value;
        var accdepn=document.getElementById("accumdepr").value;
        if(parseFloat(accdepn)>parseFloat(total)) {
            document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
            document.getElementById("accumdepr").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        }
    }
    if($('#mode').val()=='E') {
        if(document.getElementById("masteredit").value=="master") {}
        else {
            if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0) {
                document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                document.getElementById("totalpuchvalue").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText="";
            }
            var total= document.getElementById("totalpuchvalue").value;
            var accdepn=document.getElementById("accumdepr").value;
            if(parseFloat(accdepn)>parseFloat(total)) {
                document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
                document.getElementById("accumdepr").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText="";
            }
        }
    }
}
    
function funchkaccum() {
    if ($("#mode").val() == "A" ) {
        if(document.getElementById("openingval").value==1) {
            if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0) {
                document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
                document.getElementById("accumdepr").focus();
                return 0;
            }
            var total= document.getElementById("totalpuchvalue").value;
            var accdepn=document.getElementById("accumdepr").value;
            if(parseFloat(accdepn)>parseFloat(total)) {
                document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
                document.getElementById("totalpuchvalue").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText="";
            }
        }
    }
    if($('#mode').val()=='E') {
        if(document.getElementById("masteredit").value=="master") {}
        else {
            if(document.getElementById("openingval").value==1) {
                if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0) {
                    document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
                    document.getElementById("accumdepr").focus();
                    return 0;
                }
                var total= document.getElementById("totalpuchvalue").value;
                var accdepn=document.getElementById("accumdepr").value;
                if(parseFloat(accdepn)>parseFloat(total)) {
                    document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
                    document.getElementById("totalpuchvalue").focus();
                    return 0;
                } else {
                    document.getElementById("errormsg").innerText="";
                }
            }
        }
    }
}
</script>
</head>

<body onload="setValues();getAssetgp();getloc();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmassetmastrer" action="saveAssetmaster" autocomplete="OFF">

<jsp:include page="../../../../header.jsp" />

<div class="modern-ui hidden-scrollbar">
    <div id="errormsg"></div>

    <!-- Asset Master Header -->
    <div class="middle-panel">
        <span class="middle-panel-title">Asset Master</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
            </div>
            <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>
            
            <label class="lbl-right" style="width:100px;">Doc No.</label>
            <input type="text" id="refno" name="refno" style="width:125px;" value='<s:property value="refno"/>'/>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Ref No.</label>
            <input type="text" id="docno" name="docno" style="width:125px;" value='<s:property value="docno"/>' readonly tabindex="-1"/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Asset ID</label>
            <input type="text" id="assetid" name="assetid" style="width:125px;" value='<s:property value="assetid"/>'/>
            
            <label class="lbl-right" style="width:100px;">Name</label>
            <input type="text" id="assetname" name="assetname" style="flex:1;" value='<s:property value="assetname"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Asset Group</label>
            <select id="assetGroup" name="assetGroup" style="width:180px;">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="assetGroupval" name="assetGroupval" value='<s:property value="assetGroupval"/>'/>

            <label class="lbl-right" style="width:100px;">Location</label>
            <select id="location" name="location" style="width:180px;">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="locationval" name="locationval" value='<s:property value="locationval"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Remarks</label>
            <input type="text" id="remarks" name="remarks" style="flex:1;" value='<s:property value="remarks"/>'/>
        </div>
    </div>

    <!-- Two-Column Layout -->
    <div style="display:flex; gap:15px; align-items:stretch;">

        <!-- LEFT COLUMN: Purchase -->
        <div class="middle-panel" style="flex:1; margin-bottom:0;">
            <span class="middle-panel-title">Purchase Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Supplier</label>
                <div class="input-search-container" style="width:125px;">
                    <input type="text" id="supplieraccId" name="supplieraccId" placeholder="Press F3" value='<s:property value="supplieraccId"/>' onkeydown="getaccountdetails(event)"/>
                    <svg class="magnifier-icon" onclick="$('#supplieraccId').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="supplieraccName" name="supplieraccName" style="flex:1;" value='<s:property value="supplieraccName"/>' readonly tabindex="-1"/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Purchase Ref No</label>
                <input type="text" id="purchrefno" name="purchrefno" style="width:125px;" value='<s:property value="purchrefno"/>'/>

                <label class="lbl-right" style="width:100px;">Purchase Date</label>
                <div style="width: 125px;">
                    <div id='purchasedate' name='purchasedate' value='<s:property value="purchasedate"/>'></div>
                </div>
                <input type="hidden" id="hidpurchasedate" name="hidpurchasedate" value='<s:property value="hidpurchasedate"/>'/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:120px;">No Of Items</label>
                <input type="text" id="noofitems" name="noofitems" style="width:125px; text-align:right;" value='<s:property value="noofitems"/>' onkeypress="javascript:return isNumber (event);"/>

                <label class="lbl-right" style="width:100px;">Tot Purch Value</label>
                <input type="text" id="totalpuchvalue" name="totalpuchvalue" style="width:125px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="totalpuchvalue"/>' onblur="funRoundAmt(this.value,this.id);funchkaccum();" onkeypress="javascript:return isNumber (event);"/>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:120px;">WNTY Exp Date</label>
                <div style="width: 125px;">
                    <div id='warexpdate' name='warexpdate' value='<s:property value="warexpdate"/>'></div>
                </div>
                <input type="hidden" id="hidwarexpdate" name="hidwarexpdate" value='<s:property value="hidwarexpdate"/>'/>

                <label class="lbl-right" style="width:100px;">WNTY DocNo</label>
                <input type="text" id="wntydocno" name="wntydocno" style="width:125px;" value='<s:property value="wntydocno"/>'/>
            </div>
        </div>

        <!-- RIGHT COLUMN: Sub Details -->
        <div class="middle-panel" style="flex:1; margin-bottom:0;">
            <span class="middle-panel-title">Sub Details</span>
            
            <div class="field-row">
                <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                    <input type="checkbox" id="subgriddis" name="subgriddis" onchange="fundisgrid();" style="margin:0;"> Enable Sub Details
                </label>
                <input type="hidden" id="subgriddisval" name="subgriddisval" value='<s:property value="subgriddisval"/>'/>
            </div>

            <div id="subdetail" style="display:none; height:100%;">
                <jsp:include page="subdetails.jsp"></jsp:include>
            </div>
        </div>

    </div>

    <!-- Two-Column Layout (Bottom) -->
    <div style="display:flex; gap:15px; align-items:stretch;">

        <!-- LEFT COLUMN: Depreciation Setup -->
        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Depreciation Setup</span>
            
            <div class="field-row">
                <label style="display:flex; align-items:center; gap:5px; cursor:pointer;">
                    <input type="checkbox" id="opening" name="opening" onchange="funopening()" style="margin:0;"> Opening
                </label>
                <input type="hidden" id="openingval" name="openingval" value='<s:property value="openingval"/>'/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Accum. Depr</label>
                <input type="text" id="accumdepr" name="accumdepr" style="width:125px; text-align:right;" value='<s:property value="accumdepr"/>' onblur="funRoundAmt(this.value,this.id);funchktotal();" onkeypress="javascript:return isNumber (event);"/>

                <label class="lbl-right" style="width:100px;">Life Time (Yr)</label>
                <input type="text" id="lifetimeyear" name="lifetimeyear" style="width:125px; text-align:right;" value='<s:property value="lifetimeyear"/>' onblur="funRoundAmt(this.value,this.id);funcalculatedep();" onkeypress="javascript:return isNumber (event);"/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Depr %</label>
                <input type="text" id="depper" name="depper" style="width:125px; text-align:right;" value='<s:property value="depper"/>' onblur="funRoundAmt(this.value,this.id);funcalcuyear();" onkeypress="javascript:return isNumber (event);"/>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:120px;">Notes</label>
                <input type="text" id="depnotes" name="depnotes" style="flex:1;" value='<s:property value="depnotes"/>'/>
            </div>
        </div>

        <!-- RIGHT COLUMN: Accounts Mapping -->
        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Accounts Mapping</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Fixed Asset</label>
                <div class="input-search-container" style="width:125px;">
                    <input type="text" id="fixedassetaccId" name="fixedassetaccId" placeholder="Press F3" value='<s:property value="fixedassetaccId"/>' onkeydown="getaccountdetails1(1)"/>
                    <svg class="magnifier-icon" onclick="$('#fixedassetaccId').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="fixedassetaccName" name="fixedassetaccName" style="flex:1;" value='<s:property value="fixedassetaccName"/>' readonly tabindex="-1"/>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Accu. Depr</label>
                <div class="input-search-container" style="width:125px;">
                    <input type="text" id="accdepraccId" name="accdepraccId" placeholder="Press F3" value='<s:property value="accdepraccId"/>' onkeydown="getaccountdetails1(2)"/>
                    <svg class="magnifier-icon" onclick="$('#accdepraccId').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="accdepraccName" name="accdepraccName" style="flex:1;" value='<s:property value="accdepraccName"/>' readonly tabindex="-1"/>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Depreciation</label>
                <div class="input-search-container" style="width:125px;">
                    <input type="text" id="depraccId" name="depraccId" placeholder="Press F3" value='<s:property value="depraccId"/>' onkeydown="getaccountdetails1(3)"/>
                    <svg class="magnifier-icon" onclick="$('#depraccId').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="depraccName" name="depraccName" style="flex:1;" value='<s:property value="depraccName"/>' readonly tabindex="-1"/>
            </div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="supaccdocno" name="supaccdocno" value='<s:property value="supaccdocno"/>'/>
        <input type="hidden" id="supcmbcurrency" name="supcmbcurrency" value='<s:property value="supcmbcurrency"/>'/>
        <input type="hidden" id="suprate" name="suprate" value='<s:property value="suprate"/>'/>
        <input type="hidden" id="suphidcurrencytype" name="suphidcurrencytype" value='<s:property value="suphidcurrencytype"/>'/>
        <input type="hidden" id="masteredit" name="masteredit" value='<s:property value="masteredit"/>'/>
        <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'/>
        <input type="hidden" id="gridval" name="gridval" value='<s:property value="gridval"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>

</div>

<!-- Search Windows -->
<div id="accountDetailsWindow"><div></div></div>
<div id="fixaccountDetailsWindow"><div></div></div>

</form>
</div>
</body>
</html>