<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath(); %>

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
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String mastertrno =request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
String brch1 =request.getParameter("brch")==null?"0":request.getParameter("brch").toString();

String client =request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String cperson =request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
String mob =request.getParameter("mob")==null?"0":request.getParameter("mob").toString();
String tel =request.getParameter("tel")==null?"0":request.getParameter("tel").toString();
String mail =request.getParameter("mail")==null?"0":request.getParameter("mail").toString();
String cpersonid =request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String address =request.getParameter("address")==null?"0":request.getParameter("address").toString();
String amcno =request.getParameter("amcno")==null?"0":request.getParameter("amcno").toString();
String salname =request.getParameter("salname")==null?"0":request.getParameter("salname").toString();
String salid =request.getParameter("salid")==null?"0":request.getParameter("salid").toString();
%>

<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
var brhidview='<%=brch1%>';

$(document).ready(function() {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#date").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
	  
    $('#contractwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' contract Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#contractwindow').jqxWindow('close');
	  
    $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#costCodeSearchWindow').jqxWindow('close');
	  
    $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#clientsearch1').jqxWindow('close');
	 
    $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#printWindow').jqxWindow('close');
    
    $('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#enquirywindow').jqxWindow('close');
    
    $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#servicetypewindow').jqxWindow('close');
      
    $('#scopetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Scope Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#scopetypewindow').jqxWindow('close');
      
    $('#sitewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Site Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#sitewindow').jqxWindow('close');
    
    $('#unitsearchwindow').jqxWindow({ width : '25%', height : '58%', maxHeight : '70%', maxWidth : '45%', title : 'Unit Search', position : { x : 420, y : 87 }, theme : 'energyblue', showCloseButton : true, keyboardCloseKey : 27 });
    $('#unitsearchwindow').jqxWindow('close');
    
    $('#txtrefdetails').dblclick(function(){
        if(document.getElementById("cmbcontracttype").value=="SINV") {
            costCodeSearchContent("costCodeSearchGrid.jsp");
        } else {
            $('#contractwindow').jqxWindow('open');
            contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
        }
    });
	  
    $('#txtclient').dblclick(function(){
        $('#clientsearch1').jqxWindow('open');
        clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
    });
    
    $('#date').on('change', function (event) {
        var invdate=new Date($('#date').jqxDateTimeInput('getDate'));
        var curdate=new Date(); 
        invdate.setHours(0,0,0,0);
        curdate.setHours(0,0,0,0);
        if(invdate>curdate){
            $.messager.alert('Message','Future Date Not Allowed','warning');   
            $('#date').jqxDateTimeInput('setDate', new Date());
            return false;
        }
        funDateInPeriod(invdate);
    });
});

function getcontract(event){
    var cmb=document.getElementById("cmbcontracttype").value;
	var x= event.keyCode;
 	if(x==114){
 		if(cmb=="SINV"){
 		    costCodeSearchContent("costCodeSearchGrid.jsp");
 		} else {
 			$('#contractwindow').jqxWindow('open');
 	 		contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
 		}
 	}
}
    	 
function contractSearchContent(url) {
	 $.get(url).done(function (data) {
	    $('#contractwindow').jqxWindow('setContent', data);
    }); 
}

function ProjectInvoicePrintContent(url) {
	$('#printWindow').jqxWindow('open');
	$.get(url).done(function (data) {
        $('#printWindow').jqxWindow('setContent', data);
        $('#printWindow').jqxWindow('bringToFront');
    }); 
} 

function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	    $('#clientsearch1').jqxWindow('open');
	    clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    
     }
} 

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientsearch1').jqxWindow('setContent', data);
   	}); 
}
    
function getPrintWindowAllowed() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $('#txtprintwindowallowed').val(items);
        }
    }
    x.open("GET", "getPrintWindowAllowed.jsp", true);
    x.send();
}

function funFocus(){}

function costCodeSearchContent(url) {
    $('#costCodeSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
        $('#costCodeSearchWindow').jqxWindow('setContent', data);
        $('#costCodeSearchWindow').jqxWindow('bringToFront');
    }); 
}

function funReadOnly(){
	 $('#frmTemplate input').attr('readonly', true);
	 $('#frmTemplate select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
     $('#btnSummary').attr('disabled', true);
	 $("#materialGrid").jqxGrid({ disabled: true});
     
     if(modes=="view") {
        document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
        document.getElementById("formdetail").value=window.parent.formName.value;
        document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
        $('#doc_no').attr('disabled', false);
        $('#masterdoc_no').attr('disabled', false);
        $('#mode').attr('disabled', false);
        $('#date').jqxDateTimeInput({ disabled: false}); 
        
        document.getElementById("masterdoc_no").value=mastertrno;
        document.getElementById("mode").value=modes;
        var loadid=2;
        var docno=mastertrno;

        document.getElementById("docno").value= '<%=docno%>';
        $('#date').jqxDateTimeInput('val','<%=date%>');
        $('#hiddate').jqxDateTimeInput('val','<%=date%>');
        document.getElementById("clientid").value='<%=cldocno%>';
        document.getElementById("txtenquiry").value='<%=refdocno%>';
        document.getElementById("enquiryid").value='<%=reftrno%>';
        document.getElementById("txtmatotal").value='<%=material%>';
        document.getElementById("txtnettotal").value='<%=nettotal%>';
        document.getElementById("txtnettotalshow").value='<%=nettotal%>';
         
        $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
        
        $('#docno').attr('disabled', false);
        $('#mode').attr('disabled', false);
    }
    
    if(document.getElementById("status").value.trim()=="0" ) {
        mod1="view";
    }
        
    if(mod1=="A") {
        document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
        document.getElementById("formdetail").value=window.parent.formName.value;
        document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
        funCreateBtn();
    }
}

function funRemoveReadOnly(){
	 $('#frmTemplate input').attr('readonly', false);
	 $('#frmTemplate select').attr('disabled', false);
	 $('#date').jqxDateTimeInput({ disabled: false});
     $('#btnSummary').attr('disabled', false);
	 $('#docno').attr('readonly', true);
     $('#txtactivityname').attr('readonly', true);
     $('#txtreftype').attr('readonly', true);
	 $("#materialGrid").jqxGrid({ disabled: false});
	 
     if ($("#mode").val() == "E") {
         $('#txtenquiry').attr('disabled', false );
         $('#enquiryid').attr('disabled', false );
         $('#clientid').attr('disabled', false );
         
         $("#materialGrid").jqxGrid('addrow', null, {});
         $('#gridtext').attr('readonly', false );
         $('#gridtext1').attr('readonly', false );
	 }
     
     if ($("#mode").val() == "A") {
         $("#activitiesid").val("0");
         $('#date').val(new Date());
         $("#materialGrid").jqxGrid('clear');
         $("#materialGrid").jqxGrid('addrow', null, {});
     }
     
     if(mod1=="A") {
         document.getElementById("clientid").value='<%=cldocno%>';
         document.getElementById("txtenquiry").value='<%=refdocno%>';
         document.getElementById("enquiryid").value='<%=reftrno%>';
         document.getElementById("hidenqtrno").value='<%=reftrno%>';
         document.getElementById("hidsurtrno").value='<%=surtrno%>';
         $("#materialDiv").load("materialDetailsGrid.jsp?enqtrno="+'<%=reftrno%>'+"&loadid=3");
     }
     
     chkproductconfig();
}

function funNotify(){
    if($('#clientid').val()==""){
        document.getElementById("errormsg").innerText="select a Client";
        return 0;
    }
     
    var rows1 = $("#materialGrid").jqxGrid('getrows');
    document.getElementById("errormsg").innerText="";
    $('#matgridlen').val(rows1.length);
    var griddesc="";
    var errorstatus=0;
    
    if(rows1.length=="0"){
        $.messager.alert('Message','Enter Proper Details','warning');
        errorstatus=1;
        return 0;
    } else {
        for(var i=0;i<rows1.length-1;i++){
            if(rows1[i].prodoc>0) {
                if(rows1[i].stdprice>=rows1[i].amount){
                    document.getElementById("errormsg").innerText="Amount Should Be Greater than Standard Price ("+rows1[i].stdprice+")";
                    return 0;
                    errorstatus=1;
                }
            } else{
                document.getElementById("errormsg").innerText="";
                errorstatus=0;
            }
            if((rows1[i].desc1=="undefined" || typeof(rows1[i].desc1)=="undefined" || rows1[i].desc1==null || rows1[i].desc1=="") &&
                (rows1[i].stypeid=="undefined" || typeof(rows1[i].stypeid)=="undefined" || rows1[i].stypeid==null || rows1[i].stypeid=="" )&&
                (rows1[i].prodoc=="undefined" || typeof(rows1[i].prodoc)=="undefined" || rows1[i].prodoc==null || rows1[i].prodoc=="" )) {
                $.messager.alert('Message','Enter Proper Details','warning');
                errorstatus=1;
                return 0;
            } else{
                errorstatus=0;
            }
        }
    }
     	 
    if(errorstatus==1){
        return 0;
    }

    var srno=0; 
    for(var i=0 ; i < rows1.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "mate"+i)
            .attr("name", "mate"+i)
            .attr("hidden", "true"); 
        
        newTextBox.val(rows1[i].stypeid+" :: "+rows1[i].scopeid+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].specid+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].scope_amount+" :: "+rows1[i].total+" :: "+rows1[i].desc1+" :: "+rows1[i].scopestdcost+" :: "+rows1[i].lbrchg+" :: "+rows1[i].stdprice+" :: "+srno+" :: " );
        newTextBox.appendTo('form');
    }	 
    return 1;
} 

function setValues() {
    var docno=$("#docno").val();
    var loadid=2;
    if($('#hiddate').val()){
        $("#date").jqxDateTimeInput('val', $('#hiddate').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    if(docno>0){
        $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
    }
}
	
function funSearchLoad(){
    changeContent('Mastersearch.jsp'); 
} 
	
function enquirySearchContent(url) {
    $.get(url).done(function (data) {
        $('#enquirywindow').jqxWindow('setContent', data);
    }); 
}

function funExcelBtn(){
    if(parseInt(window.parent.chkexportdata.value)=="1") {
        JSONToCSVCon(materialexcel,$("#docno").val(), true);
    }
}

function unitSearchContent(url) {
    $('#unitsearchwindow').jqxWindow('open');
    $.get(url).done(function(data) {
        $('#unitsearchwindow').jqxWindow('setContent', data);
        $('#unitsearchwindow').jqxWindow('bringToFront');
    });
}

function getclinfo(event){
    var x= event.keyCode;
    if(x==114){
        $('#clientsearch1').jqxWindow('open');
        clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    
    }
} 

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientsearch1').jqxWindow('setContent', data);
   	}); 
}
      
function getcontact(event,rowindex){
    var clientid=document.getElementById("clientid").value;
    if(clientid==""){
        document.getElementById("errormsg").innerText=" Select Client";
        return 0;
    }
    var x= event.keyCode;
    if(x==114){
        var type=1;
        $('#cpinfowindow').jqxWindow('open');
        cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowindex+'&type='+type); 
    }
}
  	        	 
function cpSearchContent(url) {
    $.get(url).done(function (data) {
        $('#cpinfowindow').jqxWindow('setContent', data);
    }); 
}

function productSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 
</script>
</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmTemplate" action="saveTemplatemaster" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Template Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                    <input type="text" id="docno" name="docno" style="width:125px;" value='<s:property value="docno"/>' tabindex="-1" readonly/>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Code</label>
                    <input type="text" id="txtcodeno" name="txtcodeno" style="width:125px;" value='<s:property value="txtcodeno"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Name</label>
                    <input type="text" id="txtname" name="txtname" style="flex:1;" value='<s:property value="txtname"/>'/>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Material Details</span>
                
                <div class="field-row" style="justify-content: flex-end; margin-bottom: 5px;">
                    <label class="lbl-right" style="font-size: 13px;">Total</label>
                    <input type="text" id="txtnettotalshow" name="txtnettotalshow" style="width:150px; text-align:right; font-weight:bold; color:#000000; background-color:#F2F4F4;" readonly tabindex="-1" value='<s:property value="txtnettotal"/>'/>
                    <input type="hidden" id="txtnettotal" name="txtnettotal" value='<s:property value="txtnettotal"/>'/>
                </div>
                
                <div id="materialDiv" class="grid-container" style="border:none;">
                    <jsp:include page="materialDetailsGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>'/>   
                <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>'/> 
                <input type="hidden" id="activitiesid" name="activitiesid" value='<s:property value="activitiesid"/>'/>
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="txtmatotal" name="txtmatotal" value='<s:property value="txtmatotal"/>'/>
                <input type="hidden" id="txtlabtotal" name="txtlabtotal" value='<s:property value="txtlabtotal"/>'/>
                <input type="hidden" id="txteqptotal" name="txteqptotal" value='<s:property value="txteqptotal"/>'/>
                <input type="hidden" id="matgridlen" name="matgridlen" value='<s:property value="matgridlen"/>'/>
                <input type="hidden" id="labgridlen" name="labgridlen" value='<s:property value="labgridlen"/>'/>
                <input type="hidden" id="eqgridlen" name="eqgridlen" value='<s:property value="eqgridlen"/>'/>
                <input type="hidden" id="actgridlen" name="actgridlen" value='<s:property value="actgridlen"/>'/>
                <input type="hidden" id="hidestedit" name="hidestedit" value='<s:property value="hidestedit"/>'/>
                <input type="hidden" id="hidsurtrno" name="hidsurtrno" value='<s:property value="hidsurtrno"/>' />
                <input type="hidden" id="hidenqtrno" name="hidenqtrno" value='<s:property value="hidenqtrno"/>' />
                <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>' />  
                <input type="hidden" id="txtgridservicetypeid" name="txtgridservicetypeid" value='<s:property value="txtgridservicetypeid"/>' />  
                <input type="hidden" id="txtgridscopeid" name="txtgridscopeid" value='<s:property value="txtgridscopeid"/>' />
            </div>

        </div>
    </form>

    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="customerDetailsWindow"><div></div><div></div></div>
    <div id="activitysearchwindow"><div></div><div></div></div>
    <div id="clientsearch1"><div></div><div></div></div>
    <div id="sidesearchwndow"><div></div><div></div></div>
    <div id="lchargeinfowindow"><div></div><div></div></div>
    <div id="echargeinfowindow"><div></div><div></div></div>
    <div id="enquirywindow"><div></div><div></div></div>
    <div id="servicetypewindow"><div></div><div></div></div>
    <div id="scopetypewindow"><div></div><div></div></div>
    <div id="sitewindow"><div></div><div></div></div>
    <div id="unitsearchwindow"><div></div><div></div></div>
</div>
</body>
</html>