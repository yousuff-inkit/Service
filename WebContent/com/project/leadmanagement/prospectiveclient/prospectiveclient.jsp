<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

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
.modern-ui select,
.modern-ui textarea { 
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

.modern-ui textarea {
    height: 48px !important; 
    resize: none;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus,
.modern-ui textarea:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled,
.modern-ui textarea[readonly] { 
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
    width: 100%;
}

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }
form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Sub-panel layout (from tables) */
.sub-panel-flex {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}
.sub-panel-flex > div {
    flex: 1;
    min-width: 300px;
}
</style>

<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
System.out.println("====masterdocno===="+request.getParameter("mastertrno"));
String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String masterdocno =request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();

String mod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
String client=request.getParameter("client")==null?"":request.getParameter("client").toString();
String clmob=request.getParameter("mob")==null?"":request.getParameter("mob").toString();
String cltel=request.getParameter("tel")==null?"":request.getParameter("tel").toString();
String clmail=request.getParameter("mail")==null?"":request.getParameter("mail").toString();
String clfax=request.getParameter("fax")==null?"":request.getParameter("fax").toString(); 
String cperson=request.getParameter("cperson")==null?"":request.getParameter("cperson").toString();
String cpmob=request.getParameter("cpmob")==null?"":request.getParameter("cpmob").toString();
String cptel=request.getParameter("cptel")==null?"":request.getParameter("cptel").toString(); 
String apntdocno=request.getParameter("apntdocno")==null || request.getParameter("apntdocno")==""?"0":request.getParameter("apntdocno").toString();        
%>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
var masterdocno='<%=masterdocno%>';
var mod1='<%=mod%>';

$(document).ready(function() {
    $("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    
    /* force internal alignment AFTER render for modern 24px height */
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

    $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#activityinfowindow').jqxWindow('close');
      
    $('#salesmanwindow').jqxWindow({ width: '25%', height: '50%',  maxHeight: '75%' ,maxWidth: '35%' ,title: ' Salesman Search' , position: { x: 800, y: 60 }, keyboardCloseKey: 27});
    $('#salesmanwindow').jqxWindow('close');
    
    $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#areainfowindow').jqxWindow('close');
    
    $('#enqurywindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 650, y: 90 }, keyboardCloseKey: 27});
    $('#enqurywindow').jqxWindow('close');
      
    $('#txtsalesman').dblclick(function(){
        $('#salesmanwindow').jqxWindow('open');
        salesmanSearchContent('salesmanMasterSearch.jsp?', $('#salesmanwindow'));
    });
    
    $('#txtenqsource').dblclick(function(){
        $('#enqurywindow').jqxWindow('open');
        enquirySearchContent('enquirySearch.jsp?', $('#enqurywindow'));
    });
          
    $('#txtarea').dblclick(function(){
        $('#areainfowindow').jqxWindow('open');
        areaSearchContent('area.jsp?getarea=0');
    });
});

function getareas(event){
    var x= event.keyCode;
    if(x==114){
        $('#areainfowindow').jqxWindow('open');
        areaSearchContent('area.jsp?getarea=0');     
    }
}
             
function areaSearchContent(url) {
    $.get(url).done(function (data) {
        $('#areainfowindow').jqxWindow('setContent', data);
    }); 
}

function getsalesman(event){
    var x= event.keyCode;
    if(x==114){
        $('#salesmanwindow').jqxWindow('open');
        salesmanSearchContent('salesmanMasterSearch.jsp?', $('#salesmanwindow'));
    }
}
         
function salesmanSearchContent(url) {
    $.get(url).done(function (data) {
        $('#salesmanwindow').jqxWindow('setContent', data);
    }); 
}
    
function getEnquiry(event){
    var x= event.keyCode;
    if(x==114){
        $('#enqurywindow').jqxWindow('open');
        enquirySearchContent('enquirySearch.jsp?', $('#enqurywindow'));
    }
}
         
function enquirySearchContent(url) {
    $.get(url).done(function (data){
        $('#enqurywindow').jqxWindow('setContent', data);
    }); 
}   

function funFocus(){
    //document.getElementById("txtsalesman").focus();
}

function funReadOnly(){
     $('#frmprospectiveclient input').attr('readonly', true);
     $('#frmprospectiveclient input').attr('disabled', true);
     $('#frmprospectiveclient select').attr('disabled', true);
     $('#date').jqxDateTimeInput({ disabled: true});
     $('#docno').attr('readonly', true);
     $("#contactGrid").jqxGrid({ disabled: true});
     
     if(modes=="view") {
        document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
        document.getElementById("formdetail").value=window.parent.formName.value;
        document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
        
        $('#maintrno').attr('disabled', false);
        $('#docno').attr('disabled', false);
        $('#mode').attr('disabled', false);
        document.getElementById("maintrno").value=mastertrno;
        document.getElementById("mode").value=modes;
        document.getElementById("frmprospectiveclient").submit();
     }
     
     if(mod1=="A") {
         document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
         document.getElementById("formdetail").value=window.parent.formName.value;
         document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
         funCreateBtn();
     } 
}

function funRemoveReadOnly(){
     $('#frmprospectiveclient input').attr('readonly', false);
     $('#frmprospectiveclient input').attr('disabled', false);
     $('#frmprospectiveclient select').attr('disabled', false);
     $('#txtsalesman').attr('readonly', true);
     $('#txtclient').attr('readonly', true);
     $('#txtclientdet').attr('readonly', true);
     $('#docno').attr('readonly', true);
     $('#date').jqxDateTimeInput({ disabled: false});
     $("#contactGrid").jqxGrid({ disabled: false});
     
     if ($("#mode").val() == "A") {
         getsalesmanonload();
        $("#contactGrid").jqxGrid('clear');
        $("#contactGrid").jqxGrid('addrow', null, {});
     }
     if(mod1=="A") {
         document.getElementById("txtname").value= '<%=client%>';
         document.getElementById("txtmob").value='<%=clmob%>';
         document.getElementById("txttelephone").value='<%=cltel%>';
         document.getElementById("txtemail").value='<%=clmail%>';
         document.getElementById("txtfax").value='<%=clfax%>';
         document.getElementById("apntdocno").value='<%=apntdocno%>';
         var cperson= '<%=cperson%>';
         var cpmob= '<%=cpmob%>';
         var cptel= '<%=cptel%>';
         $("#contactGriddiv").load("contactGrid.jsp?cperson="+encodeURIComponent(cperson)+"&cpmob="+cpmob+"&cptel="+cptel);      
     }
}

function mobileValid(value){
    if(value!=""){ 
        var phoneno = /^\d{12}$/;  
        if(value.match(phoneno)){
            document.getElementById("errormsg").innerText="";
            return true;
        } else{
            document.getElementById("errormsg").innerText="Invalid Mobile Number";
            return false;
        }
    } 
    return true;
}

function validateEmail($email) {
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    if(emailReg.test( $email )){
        document.getElementById("errormsg").innerText="";
        return true;
    } else{
        document.getElementById("errormsg").innerText="Email Address Not Valid";
        return false;
    }
    return true;
}

function funNotify(){
    if(document.getElementById("txtname").value=="") {
        document.getElementById("errormsg").innerText="Name Mandatory";
        return 0;
    }
    if(document.getElementById("txtsalesman").value=="") {
        document.getElementById("errormsg").innerText="Salesman Mandatory";
        return 0;
    }
    if(!mobileValid($("#txtmob").val())){ return 0; }
    if(!validateEmail($("#txtemail").val())){ return 0; }
    
    var rows = $("#contactGrid").jqxGrid('getrows');
    var len=0;
    
    for(var i=0;i<rows.length;i++){
        var cpersion= $.trim(rows[i].cpersion);
        if(cpersion.trim()!="" && typeof(cpersion)!="undefined" && typeof(cpersion)!="NaN" ) {
            newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "test"+len)
               .attr("name", "test"+len)
               .attr("hidden", "true");
            
            newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "+rows[i].phone+" :: "+rows[i].extn+" :: "+rows[i].email+" :: "+rows[i].activity_id+"");
            newTextBox.appendTo('form'); 
            len=len+1;
        }
    }
    $('#contactGridlength').val(len);
    return 1;
} 

function funclear() {}

function setValues() {
    var docVal1 = document.getElementById("maintrno").value.trim();
    if(docVal1>0) {
        var indexVal2 = document.getElementById("maintrno").value.trim();
        $("#contactGriddiv").load("contactGrid.jsp?cptrno="+indexVal2);
    }
    if($('#msg').val()!=""){
       $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
}
    
function funSearchLoad(){
     changeContent('Mastersearch.jsp'); 
} 

$(function(){
    $('#frmprospectiveclient').validate({
        rules: { 
            txtsalesman:{"required":true},
            desc:{"required":true,maxlength:300},
        },
        messages: {
            txtsalesman: {required:" * Required"},
            desc: {required:" * Please Fill",maxlength:" Max 300 chars"},
        }
    });
});
     
function funPrintBtn() {}

function getsalesmanonload(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var res= x.responseText;
            var ressplt=res.split("::");
            var salname=ressplt[0].trim();
            var salid=ressplt[1].trim();
            if(salid>0){
                document.getElementById("txtsalesman").value=salname;
                document.getElementById("txtsalid").value=salid;
            }
        } else {}
    }
    x.open("GET",'salesmanonload.jsp',true);
    x.send();
}
</script>
</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmprospectiveclient" action="saveProspectiveClient" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />

        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Prospective Client</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Enquiry Source</label>
                    <div class="input-search-container" style="width: 150px;">
                        <input type="text" name="txtenqsource" id="txtenqsource" placeholder="Press F3" value='<s:property value="txtenqsource"/>'>
                        <svg class="magnifier-icon" onclick="$('#txtenqsource').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" id="docno" style="width:125px;" value='<s:property value="docno"/>'>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Name</label>
                    <input type="text" name="txtname" id="txtname" style="flex:1;" value='<s:property value="txtname"/>'>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Mob No.</label>
                    <input type="text" name="txtmob" id="txtmob" style="flex:1;" onblur="mobileValid(this.value);" placeholder="mobile number with country code" value='<s:property value="txtmob"/>'>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Telephone</label>
                    <input type="text" id="txttelephone" name="txttelephone" style="flex:1;" value='<s:property value="txttelephone"/>'/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Fax</label>
                    <input type="text" id="txtfax" name="txtfax" style="flex:1;" value='<s:property value="txtfax"/>'/>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Email</label>
                    <input type="text" name="txtemail" id="txtemail" style="flex:1;" placeholder="someone@example.com" onblur="validateEmail(this.value);" value='<s:property value="txtemail"/>'>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Salesman</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" name="txtsalesman" id="txtsalesman" placeholder="Press F3" onKeyDown="getsalesman(event);" value='<s:property value="txtsalesman"/>'>
                        <svg class="magnifier-icon" onclick="$('#txtsalesman').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Area</label>
                    <div class="input-search-container" style="width:200px;">
                        <input type="text" id="txtarea" name="txtarea" readonly placeholder="Press F3" value='<s:property value="txtarea"/>' onKeyDown="getareas(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtarea').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="txtareadet" name="txtareadet" readonly style="flex:1; margin-left:8px;" value='<s:property value="txtareadet"/>'/>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Description</label>
                    <input type="text" name="desc" id="desc" style="flex:1;" value='<s:property value="desc"/>'>
                </div>
            </div>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Contact Person Details</span>
                <div id="contactGriddiv" class="grid-container">
                    <jsp:include page="contactGrid.jsp"></jsp:include>
                </div>
            </div>
            
            <!-- Hidden Fields -->
            <div style="display:none;">
                <input type="hidden" name="txtenqsourceid" id="txtenqsourceid" value='<s:property value="txtenqsourceid"/>'/>  
                <input type="hidden" name="txtsalid" id="txtsalid" value='<s:property value="txtsalid"/>'/>
                <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'/>
                <input type="hidden" id="apntdocno" name="apntdocno" value='<s:property value="apntdocno"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
                <input type="hidden" id="costid" name="costid" value='<s:property value="costid"/>'/>
                <input type="hidden" id="clacno" name="clacno" value='<s:property value="clacno"/>'/>
                <input type="hidden" name="contypeval" id="contypeval" value='<s:property value="cmbcontracttype"/>'/>
                <input type="hidden" name="maintrno" id="maintrno" value='<s:property value="maintrno"/>'/>
                <input type="hidden" id="contactGridlength" name="contactGridlength" />
            </div>

        </div>

        <!-- Popup Windows -->
        <div id="activityinfowindow"><div></div></div>
        <div id="salesmanwindow"><div></div></div>
        <div id="enqurywindow"><div></div></div>
        <div id="areainfowindow"><div></div></div>

    </form>
</div>     
</body>
</html>