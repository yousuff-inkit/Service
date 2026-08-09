<%@page import="com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeAction" %>
<%ClsPlateCodeAction cpa=new ClsPlateCodeAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
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
$(document).ready(function() {
    /* Configured for modern UI 24px height */
    $("#date_plateCode").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    setTimeout(function () {
        $("#date_plateCode").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#date_plateCode").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
    
    document.getElementById("formdet").innerText="Plate Code(PLT)";
    document.getElementById("formdetail").value="Plate Code";
    document.getElementById("formdetailcode").value="PLT";
    window.parent.formCode.value="PLT";
    window.parent.formName.value="Plate Code";
    
    getAuth();
    
    var data= '<%=cpa.searchDetails() %>'; 
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'number' },
            {name : 'code_no' , type: 'String' },
            {name : 'code_name', type: 'String'  },
            {name : 'authname', type: 'String'  },
            {name : 'authId', type: 'String'  },
            {name : 'plateDate', type: 'date'  }
         ],
         localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);   
        }
    });
         
    $("#jqxPlateCodeSearch1").jqxGrid({
        width: '100%',
        height: 350,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'singlerow',
        sortable: true,
        altrows:true,
        columns: [
            {text: 'Doc No',datafield:'doc_no',hidden:true},
            { text: 'Plate Code', datafield: 'code_no', width: '30%' },
            { text: 'Plate Name', datafield: 'code_name', width: '40%' },
            { text: 'Authority Name', datafield: 'authname', width: '30%' },
            { text: 'Authority Id', datafield: 'authId', width: '30%',hidden:true },
            { text: 'Date', datafield: 'plateDate', width: '30%',hidden:true,cellsformat:'dd.MM.yyyy' }
        ]
    });
    
    $('#jqxPlateCodeSearch1').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        $('#date_plateCode').jqxDateTimeInput({ disabled: false});
        
        document.getElementById("docno").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("plateCode").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "code_no"); 
        document.getElementById("platename").value = $("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "code_name");
        $('#authName').val($("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "authId")) ;
        $("#date_plateCode").jqxDateTimeInput('val', $("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "plateDate")); 
        
        $('#frmPlateCode select').attr('disabled', true);
        $('#date_plateCode').jqxDateTimeInput({ disabled: true});
        document.getElementById("authorityname").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "authname");
        
        var auth12=$('#jqxPlateCodeSearch1').jqxGrid('getcelltext', rowindex1, "authname");
        auth=auth12.replace(/ /g, "%20");
        $("#nAliasgrid").load("nAliasgrid.jsp?code="+document.getElementById("plateCode").value+"&emir2="+auth);

        $('#window').jqxWindow('close');
     }); 
});
  
function funSearchLoad(){
    changeContent('plateCodeSearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmPlateCode input').attr('readonly', true);
    $('#frmPlateCode select').attr('disabled', true);
    $('#date_plateCode').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly() {
    $('#frmPlateCode input').attr('readonly', false);
    $('#date_plateCode').jqxDateTimeInput({ disabled: false}); 
    $('#frmPlateCode select').attr('disabled', false);
    $('#docno').attr('readonly', true);
    
    if(document.getElementById("mode").value=='E'){
        $("#jqxnalias").jqxGrid({ disabled: false});
        $('#jqxnalias').jqxGrid('addrow', null, {});
    }
}
    
function getAuth() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var authItems = items[0].split(",");
            var authIdItems = items[1].split(",");
            var optionsauth = '<option value="">--Select--</option>';
            for (var i = 0; i < authItems.length; i++) {
                optionsauth += '<option value="' + authIdItems[i] + '">' + authItems[i] + '</option>';
            }
            $("select#authName").html(optionsauth);
            if ($('#authId').val() != null) {
                $('#authName').val($('#authId').val());
            }
        }
    }
    x.open("GET", "getAuthority.jsp", true);
    x.send();
}

function setValues() {
    if($('#datehidden').val()){
        $("#date_plateCode").jqxDateTimeInput('val', $('#datehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus(){
    document.getElementById("authName").focus();
}

$(function(){
    $('#frmPlateCode').validate({
        rules: {
            authName:{ required:true },
            plateCode:{ required:true, maxlength:10 }
        },
        messages: {
            authName:{ required:" *" },
            plateCode:{ required:" *", maxlength:"max 10 chars" }
        }
    });
});
     
function funNotify(){
    var rows = $("#jqxnalias").jqxGrid('getrows'); 
    var listss = new Array();
    var a = 1;
    for(var i=0 ; i < rows.length ; i++){
        var code=rows[i].code;
        if(code!="undefined" && code!="" && code!=null && typeof(code)!="undefined" ){
            listss.push(rows[i].code+"::"+rows[i].doc_no+"::"+a+"::");  
        }
    }
    savenalias(listss);
    return 1;
} 
     
function funExcelBtn(){
    $("#jqxPlateCodeSearch1").jqxGrid('exportdata', 'xls', 'Platecode');
}
     
function savenalias(listss) {
    var codeno=document.getElementById("plateCode").value;
    var authname=$("#authName option:selected").text();
    var docno=document.getElementById("docno").value;
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var itemsapprove= x.responseText;
            var itemvalappr=itemsapprove.trim();
        }
    }
    x.open("GET","saveNAlias.jsp?list="+listss+"&docno="+docno+"&authname="+authname+"&codeno="+codeno);
    x.send();
}  
</script>
</head>

<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmPlateCode" action="saveActionPlate" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <!-- Two-Column Flexible Layout -->
    <div style="display:flex; gap:15px; align-items:stretch; margin-bottom:15px;">

        <!-- LEFT COLUMN: Plate Code Details -->
        <div class="middle-panel" style="flex:1; margin-bottom:0;">
            <span class="middle-panel-title">Plate Code Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id='date_plateCode' name='date_plateCode' value='<s:property value="date_plateCode"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' style="width:125px;" readonly tabindex="-1">
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Authority</label>
                <select name="authName" id="authName" style="width:180px;">
                    <option value="">--Select--</option>
                </select>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Plate Code</label>
                <input type="text" id="plateCode" name="plateCode" style="width:125px;" value='<s:property value="plateCode"/>'>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Name</label>
                <input type="text" name="platename" id="platename" style="flex:1;" value='<s:property value="platename"/>'>
            </div>
        </div>

        <!-- RIGHT COLUMN: Alias Grid -->
        <div class="middle-panel" style="flex:1; margin-bottom:0; display:flex; flex-direction:column;">
            <span class="middle-panel-title">Alias Matrix</span>
            <div id="nAliasgrid" class="grid-container" style="border:none; margin:0; flex:1;">
                <jsp:include page="nAliasgrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

    <!-- Grid Data Panel -->
    <div class="middle-panel" style="padding-bottom:10px;">
        <span class="middle-panel-title">Search Results</span>
        <div id="jqxPlateCodeSearch1" class="grid-container" style="border:none; margin:0;"></div>
    </div>

    <!-- Hidden Logic Fields -->
    <div style="display:none;">
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="authId" name="authId" value='<s:property value="authId"/>' />
        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>' />
        <input type="hidden" id="authorityname" name="authorityname" value='<s:property value="authorityname"/>' />
    </div>

</div>
</form>

</div>
</body>
</html>