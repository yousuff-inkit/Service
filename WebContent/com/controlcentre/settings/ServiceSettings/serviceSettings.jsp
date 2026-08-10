<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%@page import="com.controlcentre.settings.servicesettings.ClsServiceSettingDAO"%>
<%
ClsServiceSettingDAO DAO= new ClsServiceSettingDAO();
String doctype = request.getParameter("doctype")==null?"0":request.getParameter("doctype").trim();
String name=request.getParameter("formname"); 
String code=request.getParameter("formcode");
String lblname=request.getParameter("lblname");
String lbldrp=request.getParameter("lbldrp");
String mode=request.getParameter("mode");
%> 
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
    
    document.getElementById("formdet").innerText="Service Settings(SRS)";
    document.getElementById("formdetail").value="Service Settings";
    document.getElementById("formdetailcode").value="SRS";
    window.parent.formCode.value="SRS";
    window.parent.formName.value="Service Settings";
    
    <%if(!(name==null)) {%>
    document.getElementById("formdet").innerText="<%=name%>(<%=code%>)";
    document.getElementById("formdetail").value="<%=name%>";
    document.getElementById("formdetailcode").value="<%=code%>";
    window.parent.formCode.value="<%=code%>";
    window.parent.formName.value="<%=name%>"; 
    document.getElementById("txtcategory").value="<%=lbldrp%>";
    document.getElementById("test").innerText="<%=lblname%>";
    document.getElementById("mode").value="<%=mode%>";  
    <%}%>
    
    $('#btnEdit').attr('disabled', true);
    $('#btnSearch').attr('disabled', true);
    
    /* Configured for modern UI 24px height */
    $("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });  
    setTimeout(function () {
        $("#date").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#date").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
    
    var data='<%=DAO.settingList(session,doctype) %>';
    
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'int' },
            {name : 'groupname', type: 'String'  },
            {name : 'description', type: 'String'  },
            {name : 'codeno',type:'String'},
            {name : 'dtype',type:'String'},
            {name : 'date',type:'String'},
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
    
    $("#jqxServiceSetting").jqxGrid({
        width: '100%',
        height: 350,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        sortable: true,
        altrows:true,
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '10%',editable:false  },  
            { text: 'Category', datafield: 'dtype', width: '15%',editable:false },
            { text: 'Code', datafield: 'codeno', width: '15%',editable:false  },
            { text: 'Name', datafield: 'groupname', width: '30%',editable:false },
            { text: 'Description', datafield: 'description', width: '30%',editable:false  },
            { text: 'date', datafield: 'date', width: '30%',hidden:true  },
        ]
    });

    $('#jqxServiceSetting').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxServiceSetting').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("txtcategory").value = $("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "dtype");
        $('#frmServiceSetting select').attr('disabled', false);
        $('#date').jqxDateTimeInput({disabled: false});
        $("#date").jqxDateTimeInput('val',$("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "date"));
        $('#txtcode').val($("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "codeno")) ;
        $('#txtname').val($("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "groupname")) ;
        $('#txtdesc').val($("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "description")) ;
        $('#frmServiceSetting select').attr('disabled', true);
        $('#date').jqxDateTimeInput({disabled: true});
    }); 
});
    
function funSearchLoad(){
    changeContent('modelSearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmServiceSetting input').attr('readonly', true);
    $('#frmServiceSetting select').attr('disabled', true);
    $('#date').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly() {
    $('#frmServiceSetting input').attr('readonly', false);
    $('#frmServiceSetting select').attr('disabled', false);
    $('#date').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
    
    <%if(!(name==null)) {%>
    document.getElementById("txtcategory").value="<%=lbldrp%>";  
    <%}%>
}

function funFocus(){
    document.getElementById("txtcode").focus();
}

$(function(){
    $('#frmServiceSetting').validate({
        rules: {
            brand:{ required:true },
            model:{ required:true, maxlength:20 }
        },
        messages: {
            brand:{ required:" *" },
            model:{ required:" *", maxlength:"max 20 chars" }
        }
    });
});
        
function funNotify(){
    return 1;
} 
     
function setValues() {
    if ( $('#hidtxtcategory').val() != null && $('#hidtxtcategory').val() !="") {
        $('#txtcategory').val($('#hidtxtcategory').val());
    }
    
    if ($('#brandid').val() != null) {
        $('#brand').val($('#brandid').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
    
function refChange(){
    var value=document.getElementById("txtcategory").value;
    
    if(value=="area"){ document.getElementById("test").innerText="Service Area Settings"; }
    if(value=="service"){ document.getElementById("test").innerText="Service Settings"; }
    if(value=="agent"){ document.getElementById("test").innerText="Service Agent Settings"; }
    if(value=="complaints"){ document.getElementById("test").innerText="Service Complaint Settings"; }
    if(value=="equipments"){ document.getElementById("test").innerText="Service Equipments Settings"; }
    if(value=="holdlocation"){ document.getElementById("test").innerText="Service Hold Location Settings"; }
    if(value=="jobcategory"){ document.getElementById("test").innerText="Service Job Category Settings"; }
    if(value=="serviceactivity"){ document.getElementById("test").innerText="Service Activity Settings"; }
    if(value=="section"){ document.getElementById("test").innerText="Service Section Settings"; }
    if(value=="assignmode"){ document.getElementById("test").innerText="Service Assign Mode Settings"; }
    if(value=="site"){ document.getElementById("test").innerText="Service Site Settings"; }
    if(value=="project"){ document.getElementById("test").innerText="Service Project Settings"; }
}
</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmServiceSetting" action="saveServiceSetting" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <!-- Header Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title" id="test">Service Settings</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly tabindex="-1" style="width:125px;">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Category</label>
            <select name="txtcategory" id="txtcategory" onchange="refChange();" style="width:150px;">
                <option value="service">Service</option>
                <option value="complaints">Complaints</option>
                <option value="area">Area</option>
                <option value="serviceactivity">Service Activity</option>
                <option value="assignmode">Assign Mode</option>
            </select>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Code</label>
            <input type="text" name="txtcode" id="txtcode" value='<s:property value="txtcode"/>' style="width:125px;">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Name</label>
            <input type="text" name="txtname" id="txtname" style="width:150px;" value='<s:property value="txtname"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Description</label>
            <input type="text" name="txtdesc" id="txtdesc" style="flex:1;" value='<s:property value="txtdesc"/>'>
        </div>
    </div>

    <!-- Grid Data Panel -->
    <div class="middle-panel" style="padding-bottom:10px;">
        <span class="middle-panel-title">Details</span>
        <div id="jqxServiceSetting" class="grid-container" style="border:none; margin:0;"></div>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        <input type="hidden" id="hidtxtcategory" name="hidtxtcategory" value='<s:property value="hidtxtcategory"/>' />
    </div>

</div>
</form>
</div>
</body>
</html>