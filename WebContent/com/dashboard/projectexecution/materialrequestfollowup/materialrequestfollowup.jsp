<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style>
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}


.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}


.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
input[type="text"],
select {
    width: 100%;
    height: 28px !important;   /* Slightly smaller */
    padding: 6px 10px;
    font-size: 13px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    box-sizing: border-box;
    background-color: #ffffff;
}

</style>


<script type="text/javascript">

$(document).ready(function() {
    $('#accountSearchwindow').jqxWindow({
        width: '50%',
        height: '62%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'Account Search',
        position: {
            x: 150,
            y: 60
        },
        keyboardCloseKey: 27
    });
    $('#accountSearchwindow').jqxWindow('close');
    $('#lastpurchasewindow').jqxWindow({
        width: '50%',
        height: '32%',
        maxHeight: '75%',
        maxWidth: '50%',
        title: 'Search',
        position: {
            x: 500,
            y: 120
        },
        keyboardCloseKey: 27
    });
    $('#lastpurchasewindow').jqxWindow('close');
    $("#fromdate").jqxDateTimeInput({
        width: '125px',
        height: '15px',
        formatString: "dd.MM.yyyy"
    });
    $("#todate").jqxDateTimeInput({
        width: '125px',
        height: '15px',
        formatString: "dd.MM.yyyy"
    });

    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth() - 1));

    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
    $('#todate').on('change', function(event) {

        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));

        // out date
        var todates = new Date($('#todate').jqxDateTimeInput('getDate')); //del date

        if (fromdates > todates) {

            $.messager.alert('Message', 'To Date Less Than From Date  ', 'warning');

            return false;
        }
    })

    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $('#sidesearchwndow').jqxWindow({
        width: '30%',
        height: '90%',
        maxHeight: '90%',
        maxWidth: '80%',
        title: 'Search ',
        position: {
            x: 943,
            y: 0
        },
        keyboardCloseKey: 27
    });
    $('#sidesearchwndow').jqxWindow('close');
    $('#servicetypewindow').jqxWindow({
        width: '25%',
        height: '70%',
        maxHeight: '85%',
        maxWidth: '80%',
        title: ' Service Type Search',
        position: {
            x: 250,
            y: 60
        },
        keyboardCloseKey: 27
    });
    $('#servicetypewindow').jqxWindow('close');

    $('#txtvendor').dblclick(function() {
        //($("#mode").val() == "view")
        if ($('#mode').val() != "view") {


            $('#accountSearchwindow').jqxWindow('open');

            accountSearchContent('accountsDetailsSearch.jsp?');
        }
    });


});



function productSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {

        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);

    });
}



function getservicetype(rowBoundIndex) {

    $('#servicetypewindow').jqxWindow('open');

    serviceSearchContent('servicesearch.jsp?rowBoundIndex=' + rowBoundIndex);
}

function serviceSearchContent(url) {

    $.get(url).done(function(data) {

        $('#servicetypewindow').jqxWindow('setContent', data);

    });
}

function priceSearchContent(url) {
    $('#lastpurchasewindow').jqxWindow('open');
    $.get(url).done(function(data) {
        //alert(data);
        $('#lastpurchasewindow').jqxWindow('setContent', data);

    });
}

function getvendor(event) {
    var x = event.keyCode;

    if ($('#mode').val() != "view") {

        if (x == 114) {
            $('#accountSearchwindow').jqxWindow('open');

            accountSearchContent('accountsDetailsSearch.jsp?');
        } else {}
    }
}

function accountSearchContent(url) {
    //alert(url);
    $.get(url).done(function(data) {
        //alert(data);
        $('#accountSearchwindow').jqxWindow('setContent', data);

    });
}

function disable() {
    $("#procurementSubGrid").jqxGrid('clear');
    $("#procurementSubGrid").jqxGrid({
        disabled: true
    });
}

function funreload(event) {
    disable();
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    var branchval = document.getElementById("cmbbranch").value;

    $("#overlay, #PleaseWait").show();
    $("#procFolDiv").load("procurementFollowupGrid.jsp?branchval=" + branchval + '&fromdate=' + fromdate + '&todate=' + todate + "&check=1");
}

function funPurchaseReq() {
	$('#procurementSubGrid').jqxGrid('clearfilters');
    var selectedrows = $("#procurementSubGrid").jqxGrid('selectedrowindexes');

    if (selectedrows.length == 0) {
        $.messager.alert('Warning', 'Product Is Mandatory');
        return false;
    }

    var estimationrequestarray = new Array();
    var purchaserequestarray = new Array();
    var selectedrows = $("#procurementSubGrid").jqxGrid('selectedrowindexes');
    selectedrows = selectedrows.sort(function(a, b) {
        return a - b
    });
    var qtyval = 0, unitval = 0; 
    for (var i = 0; i < selectedrows.length; i++) {
        var unitdocno = $("#procurementSubGrid").jqxGrid('getcellvalue', selectedrows[i], 'unitdocno');
        var psrno = $("#procurementSubGrid").jqxGrid('getcellvalue', selectedrows[i], 'psrno');
        var prodoc = $("#procurementSubGrid").jqxGrid('getcellvalue', selectedrows[i], 'prodoc');

        var purqty = $("#procurementSubGrid").jqxGrid('getcellvalue', selectedrows[i], 'proqty');
        var specid = $("#procurementSubGrid").jqxGrid('getcellvalue', selectedrows[i], 'specid');
		if(parseInt(purqty)<=0){
			qtyval++;
		}
		if(parseInt(unitdocno)==0 || unitdocno==""){
			unitval++;
		}
        var aa = 0;
        purchaserequestarray.push(psrno + "::" + psrno + "::" + unitdocno + "::" + purqty + "::" + "0" + "::" + aa + "::" + specid + "::" + aa + "::" + "0" + " :: " + "0");
    }
    if (qtyval == 1) {
        $.messager.alert('Warning', 'Proc Qty Is Mandatory');
        return false;
    }
    if (unitval == 1) {
        $.messager.alert('Warning', 'Unit Is Mandatory');
        return false;
    }
    
    $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r) {
        if (r) {
            openPurchase(purchaserequestarray, estimationrequestarray);
        }
    });
}

function openPurchase(purchaserequestarray, estimationrequestarray) {
    var btn = "request";
    var conttrno = $('#contracttrno').val();
    var contocno = $('#contractdocno').val();
    var txtcldocno = $('#txtcldocno').val();
    var txtsiteid = $('#txtsiteid').val();
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {

            var items = x.responseText;
            if (parseInt(items) == "1") {

                $.messager.alert('Message', '  Record Successfully Updated ');

                disable();
            } else {
                $.messager.alert('Message', '  Not Updated  ');
            }
        }
    }
    x.open("GET", "saveData.jsp?purchaserequestarray=" + purchaserequestarray + "&click=" + btn + "&conttrno=" + conttrno + "&contocno=" + contocno + "&estimationrequestarray=" + estimationrequestarray + "&txtsiteid=" + txtsiteid + "&txtcldocno=" + txtcldocno, true);
    x.send();



}

function funExportBtn() {
    $("#procFolDiv").excelexportjs({
        containerid: "procFolDiv",
        datatype: 'json',
        dataset: null,
        gridId: "jqxProcFolGrid",
        columns: getColumns("jqxProcFolGrid"),
        worksheetName: "Material Request Followup"
    });
}
</script>
</head>
<body onload="getBranch();disable();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

<!-- ===== Fixed Header ===== -->
<div class="sidebar-fixed-top">
    <div class="filter-card">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>
</div>

<!-- ===== Scrollable Sidebar Content ===== -->
<div class="sidebar-scroll-content">

<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">From</td>
<td>
    <div id="fromdate"
         value='<s:property value="fromdate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">To</td>
<td>
    <div id="todate"
         value='<s:property value="todate"/>'></div>
</td>
</tr>

</table>
</div>

<!-- ===== Action Button ===== -->
<div class="button-group">
    <button class="btn-submit"
            type="button"
            id="btnpurchse"
            name="btnpurchse"
            onclick="funPurchaseReq(event);">
        Material Request
    </button>
</div>

<!-- ===== Hidden Fields ===== -->
<input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
<input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
<input type="hidden" id="txtsalid" name="txtsalid" value='<s:property value="txtsalid"/>'/>
<input type="hidden" id="txtrdocno" name="txtrdocno" value='<s:property value="txtrdocno"/>'/>
<input type="hidden" id="txtbrchid" name="txtbrchid" value='<s:property value="txtbrchid"/>'/>
<input type="hidden" id="txtuserid" name="txtuserid" value='<s:property value="txtuserid"/>'/>
<input type="hidden" name="subgridlength" id="subgridlength" value='<s:property value="subgridlength"/>'/>
<input type="hidden" name="contracttrno" id="contracttrno" value='<s:property value="contracttrno"/>'/>
<input type="hidden" name="contractdocno" id="contractdocno" value='<s:property value="contractdocno"/>'/>
<input type="hidden" id="puchasechk" name="puchasechk"/>
<input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'/>
<input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT GRID SIDE ================= -->
<td width="80%" valign="top">

<div class="grid-container">

<div class="filter-card">
    <div id="procFolDiv">
        <jsp:include page="procurementFollowupGrid.jsp"></jsp:include>
    </div>
</div>

<div class="filter-card">
    <div id="detailDiv">
        <jsp:include page="procurementFollowupSubGrid.jsp"></jsp:include>
    </div>
</div>

</div>

</td>

</tr>
</table>

</div>

<!-- ===== POPUP WINDOWS ===== -->
<div id="sidesearchwndow"><div></div></div>
<div id="servicetypewindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="lastpurchasewindow"><div></div></div>

</div>

</body>
</html>