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

<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
var brhidview='<%=brch1%>';

var clientname='<%=client%>';
var clientno='<%=cldocno%>';
var cpersonname='<%=cperson%>';
var mob='<%=mob%>';
var tel='<%=tel%>';
var mail='<%=mail%>';
var cpersonid='<%=cpersonid%>';
var address='<%=address%>';
var amcno='<%=amcno%>';
var salname='<%=salname%>';
var salid='<%=salid%>';

$(document).ready(function() {
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#serviceReportDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#serviceReportDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#serviceReportDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#customerDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Customer Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#customerDetailsWindow').jqxWindow('close');
        
    $('#contractDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#contractDetailsWindow').jqxWindow('close');

    $('#activityGridWindow').jqxWindow({width: '30%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Activity Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#activityGridWindow').jqxWindow('close');
    
    $('#sidesearchwndow').jqxWindow({ width: '55%', height: '92%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#sidesearchwndow').jqxWindow('close'); 
    
    $('#workstatuswindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '68%' ,maxWidth: '30%' ,title: 'Work status ' , position: { x: 260, y: 87 } ,theme: 'energyblue', keyboardCloseKey: 27});
    $('#workstatuswindow').jqxWindow('close');
    
    $('#ServiceTypeWindow').jqxWindow({width: '30%', height: '53%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Service Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#ServiceTypeWindow').jqxWindow('close');
    
    $('#txtcustomer').dblclick(function(){
        customerSearchContent("customerDetailsSearch.jsp");
    });
    
    $('#txtcontractno').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            if($("#txtcustomerdocno").val()==''){
                $.messager.alert('Message','Customer is Mandatory.','warning');
                if($("#txtcustomerdocno").val()==''){
                    $('#txtcustomer').attr('placeholder', 'Press F3 to Search');
                }
                return 0;
            }
            if($("#cmbcontracttype").val()==''){
                $.messager.alert('Message','Choose Contract Type & Search.','warning');
                if($("#txtcontractno").val()==''){
                    $('#txtcontractno').attr('placeholder', 'Press F3 to Search');
                }
                return 0;
            }
            contractSearchContent("contractDetailsSearch.jsp?docno="+document.getElementById("cmbcontracttype").value);
        }
    });
});
	
	function customerSearchContent(url) {
	 	$('#customerDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#customerDetailsWindow').jqxWindow('setContent', data);
		$('#customerDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function contractSearchContent(url) {
		$('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function activitySearchContent(url) {
		$('#activityGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#activityGridWindow').jqxWindow('setContent', data);
		$('#activityGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function productSearchContent(url) {
        $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
	  }); 
	  }
	
	 function serviceSearchContent(url) {
		 	$('#ServiceTypeWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#ServiceTypeWindow').jqxWindow('setContent', data);
			$('#ServiceTypeWindow').jqxWindow('bringToFront');
		}); 
		}
	 
	function getCustomerInfo(event){
        var x= event.keyCode;
        if(x==114){
        	customerSearchContent("customerDetailsSearch.jsp");
        }
    }
	
	function getContractDetails(event){
        var x= event.keyCode;
        if(x==114){
            if($("#txtcustomerdocno").val()==''){
                $.messager.alert('Message','Customer is Mandatory.','warning');
                if($("#txtcustomerdocno").val()==''){
                    $('#txtcustomer').attr('placeholder', 'Press F3 to Search');
                }
                return 0;
            }
            if($("#cmbcontracttype").val()==''){
                $.messager.alert('Message','Choose Contract Type & Search.','warning');
                if($("#txtcontractno").val()==''){
                    $('#txtcontractno').attr('placeholder', 'Press F3 to Search');
                }
                return 0;
            }
            contractSearchContent("contractDetailsSearch.jsp?docno="+document.getElementById("cmbcontracttype").value);
        }
    }
	
	function clearContractInfo(){
		 $("#txtcontractno").val('');$("#txtcontractdetails").val('');$("#txtcontracttrno").val('');$("#txtsitename").val('');$("#txtsiteid").val('');
		 $("#txtareaname").val('');$("#txtareaid").val('');$("#txtscheduleno").val('');
		 
		 if($("#txtcontractno").val()==''){
			 	$('#txtcontractno').attr('placeholder', 'Press F3 to Search');
		 }
		 $("#hidcmbcontracttype").val(document.getElementById("cmbcontracttype").value);
		 
		 $("#activityDetailsGridID").jqxGrid('clear');
		 $("#activityDetailsGridID").jqxGrid('addrow', null, {});
	}

	function funsetmod() {
		 mod1="view";
	} 
	
	function funReadOnly(){
        $('#frmServiceReport input').attr('readonly', true );
        $('#frmServiceReport select').attr('disabled', true);  
        $('#serviceReportDate').jqxDateTimeInput({disabled: true});
        $("#activityDetailsGridID").jqxGrid({ disabled: true});
        $("#materialDetailsGridID").jqxGrid({ disabled: true});
        $('#textrect').attr('readonly', true);
        $('#btnwork').attr('disabled', true);
        
        if(document.getElementById("status").value.trim()=="0" ) {
            mod1="view";
        }
        
        if(mod1=="A") {
            document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
            document.getElementById("formdetail").value=window.parent.formName.value;
            document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
            funCreateBtn();
        }
        
        if(modes=="view") {
            document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
            document.getElementById("formdetail").value=window.parent.formName.value;
            document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
            
            $('#docno').attr('disabled', false);
            $('#mode').attr('disabled', false);
            
            document.getElementById("docno").value=reportdocno;
            document.getElementById("mode").value=modes;
            
            var names = [];
            $("form").each(function() {
               names.push(this.id);
            }); 
            var form=names[0];
            document.forms[form].submit(); 
            
            $('#docno').attr('disabled', false);
            $('#mode').attr('disabled', false);
        }
	}
	 
	function funRemoveReadOnly(){
        $('#frmServiceReport input').attr('readonly', false );
        $('#frmServiceReport select').attr('disabled', false);
        $('#serviceReportDate').jqxDateTimeInput({disabled: false});
        $("#activityDetailsGridID").jqxGrid({ disabled: false});
        $("#materialDetailsGridID").jqxGrid({ disabled: false});
        $('#textrect').attr('readonly', true);
        
        var chk_rect_val= $('#chkrect').val();
        if(chk_rect_val>0){
            document.getElementById("chkrectification").checked=true;
            rectification();
        }
        
        if ($("#mode").val() == "E") {
            $('#btnwork').attr('disabled', false);
            $('#frmServiceReport input').attr('readonly', false );
            $('#frmServiceReport select').attr('disabled', false);
            $("#materialDetailsGridID").jqxGrid('addrow', null, {});
        }
        
        if ($("#mode").val() == "A") {
            $('#serviceReportDate').val(new Date());
            $("#activityDetailsGridID").jqxGrid('clear');
            $("#activityDetailsGridID").jqxGrid('addrow', null, {});
            $("#materialDetailsGridID").jqxGrid('clear');
            $("#materialDetailsGridID").jqxGrid('addrow', null, {});
            $('#btnwork').attr('disabled', false);
        }
        
        var contrno='<%=conttrno%>';
        
        if(mod1=="A") {
            var cregdoc='<%=cregdoc%>';
            var serdocno='<%=serdocno%>';
            var cregtrno='<%=cregtrno%>';
            var ctype='<%=ctype%>';
            
            if(ctype=="CREG") {
                document.getElementById("txtcontractno").value='<%=cno%>';
                document.getElementById("txtcontracttrno").value='<%=cregtrno%>';
            } else {
                document.getElementById("txtcontractno").value='<%=cregdoc%>';
                document.getElementById("txtcontracttrno").value='<%=cregtrno%>';
            }
            
            document.getElementById("hidserviceReportDate").value="";
            document.getElementById("txtcustomer").value='<%=client%>';
            document.getElementById("hidcmbcontracttype").value='<%=ctype%>';
        
            document.getElementById("txtsitename").value='<%=site%>';
            document.getElementById("txtareaname").value='<%=area%>';
            document.getElementById("txtscheduleno").value='<%=scheduleno%>';
            document.getElementById("txtcustomerdocno").value='<%=cldocno2%>';
            document.getElementById("txtcustomeracno").value='<%=clacno%>';
            document.getElementById("txtcustomerdetails").value='<%=claddress2%>';
            
            document.getElementById("txtcontractdetails").value='<%=contdet%>';
            document.getElementById("txtsiteid").value='<%=siteid%>';
            document.getElementById("txtareaid").value='<%=areaid%>';
            
            if(contrno>0) {
                if(ctype=="CREG") {
                     $("#activityDiv").load("activityDetailsGrid.jsp?contractno="+cregtrno+"&serdocno="+serdocno+"&dtype="+ctype);	
                } else {
                     $("#activityDiv").load("activityDetailsGrid.jsp?contractno="+contrno+"&serdocno="+serdocno+"&dtype="+ctype);
                }
            }
        }
        
        $('#docno').attr('readonly', true);
        $('#txtcustomer').attr('readonly', true );
        $('#txtcustomerdetails').attr('readonly', true );
        $('#txtcontractno').attr('readonly', true );
        $('#txtcontractdetails').attr('readonly', true );
        $('#txtsitename').attr('readonly', true );
        $('#txtareaname').attr('readonly', true );
        $('#txtscheduleno').attr('readonly', true );
	}
	 
	function funSearchLoad(){
		changeContent('srveMainSearch.jsp');  
	}
		
	function funChkButton() {}
	 
	function funFocus(){
	    $('#serviceReportDate').jqxDateTimeInput('focus'); 	    		
	}
	 
    $(function(){
        $('#frmServiceReport').validate({
            rules: {
                txtcompletionperc:{"required":true,number:true}
            },
            messages: {
                txtcompletionperc:{required:" *",number:"Invalid"}
            }
        });
    }); 
	   
    function funNotify(){	
        customer=document.getElementById("txtcustomerdocno").value;
        if(customer==""){
            document.getElementById("errormsg").innerText="Customer is Mandatory.";
            return 0;
        }
        
        contracttype=document.getElementById("cmbcontracttype").value;
        if(contracttype==""){
            document.getElementById("errormsg").innerText="Contract Type is Mandatory.";
            return 0;
        }
        
        contractno=document.getElementById("txtcontracttrno").value;
        if(contractno==""){
            document.getElementById("errormsg").innerText="Contract No. is Mandatory.";
            return 0;
        }
        
        site=document.getElementById("txtsiteid").value;
        if(site==""){
            document.getElementById("errormsg").innerText="Site is Mandatory.";
            return 0;
        }
        
        scheduleno=document.getElementById("txtscheduleno").value;
        if(scheduleno==""){
            document.getElementById("errormsg").innerText="Schedule No is Mandatory.";
            return 0;
        }
        var chkrectid=document.getElementById("chkrect").value;
        var rectdes=document.getElementById("textrect").value;
        
        if(chkrectid=="1" && rectdes==""){
            document.getElementById("errormsg").innerText="Rectification Description is Mandatory.";
            return 0;
        }
        document.getElementById("errormsg").innerText="";
        
        /* Activity Grid  Saving*/
        var rows = $("#activityDetailsGridID").jqxGrid('getrows');
        var length=0;
        for(var i=0 ; i < rows.length ; i++){
            var chk=rows[i].description;
            var sert=rows[i].sertypeid;
            if(typeof(sert) != "undefined" && typeof(sert) != "NaN" && sert != ""){
                var chks=rows[i].numbers;
                if(typeof(chks) == "undefined" || typeof(chks) == "NaN" || chks == "" || chks =="0"){
                     document.getElementById("errormsg").innerText="Nos is Mandatory for Service "+rows[i].stype+".";
                     return 0;
                }
                
                document.getElementById("errormsg").innerText="";
                
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "test"+length)
                .attr("name", "test"+length)
                .attr("hidden", "true");
                length=length+1;
                
                newTextBox.val(rows[i].sertypeid+":: "+rows[i].item+":: "+rows[i].numbers+":: "+rows[i].activityid+":: "+rows[i].description);
                newTextBox.appendTo('form');
            }
        }
        $('#activitygridlength').val(length);
        
        /* To Be Invoiced Grid  Saving*/
        var rows = $("#materialDetailsGridID").jqxGrid('getrows');
        var length=0;
        for(var i=0 ; i < rows.length ; i++){
            var chk=rows[i].total;
            if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "tests"+length)
                .attr("name", "tests"+length)
                .attr("hidden", "true");
                length=length+1;
                
                newTextBox.val(rows[i].desc1+":: "+rows[i].prodoc+":: "+rows[i].psrno+":: "+rows[i].unitdocno+":: "+rows[i].specid+":: "+rows[i].qty+":: "+rows[i].amount+":: "+rows[i].total+":: "+rows[i].invoiced);
                newTextBox.appendTo('form');
            }
        }
        $('#tobeinvoicedgridlength').val(length);
        return 1;
    } 
	  
	function setValues(){
        $("#materialDetailsGridID").jqxGrid('clear');
        $("#materialDetailsGridID").jqxGrid('addrow', null, {});
        
        document.getElementById("cmbcontracttype").value=document.getElementById("hidcmbcontracttype").value;
        
        if($('#hidserviceReportDate').val()){
             $("#serviceReportDate").jqxDateTimeInput('val', $('#hidserviceReportDate').val());
        } 
        
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
        
        var indexVal = $('#docno').val();
        if(indexVal>0){
            $("#activityDiv").load("activityDetailsGrid.jsp?trno="+$('#txtservicereporttrno').val());
            $("#materialDiv").load("materialDetailsGrid.jsp?trno="+$('#txtservicereporttrno').val());
        }
        var chk_rect_val= $('#chkrect').val();
        if(chk_rect_val>0){
            document.getElementById("chkrectification").checked=true;
            rectification();
        }
	}
	  
	function funPrintBtn() {
        var dtype=document.getElementById("hidcmbcontracttype").value;
        if (($("#mode").val() == "view") && $("#docno").val()!="" && dtype=="AMC") {
            var url=document.URL;
            var reurl=url.split("saveServiceReport");
            var branch=<%=session.getAttribute("BRANCHID").toString()%>;
            var trno=document.getElementById("txtservicereporttrno").value;
            $("#docno").prop("disabled", false);
                
            var win= window.open(reurl[0]+"printServiceReportAMC?docno="+document.getElementById("docno").value+"&branch="+branch+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();  
        } else if(($("#mode").val() == "view") && $("#docno").val()!="" && dtype=="SJOB") {
            var url=document.URL;
            var reurl=url.split("saveServiceReport");
            var branch=<%=session.getAttribute("BRANCHID").toString()%>;
            var trno=document.getElementById("txtservicereporttrno").value;
            $("#docno").prop("disabled", false);
                
            var win= window.open(reurl[0]+"printServiceReportSJOB?docno="+document.getElementById("docno").value+"&branch="+branch+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();  
        } else if(($("#mode").val() == "view") && $("#docno").val()!="" && dtype=="CREG") {
            var url=document.URL;
            var reurl=url.split("saveServiceReport");
            var branch=<%=session.getAttribute("BRANCHID").toString()%>;
            var trno=document.getElementById("txtservicereporttrno").value;
            $("#docno").prop("disabled", false);
                
            var win= window.open(reurl[0]+"printServiceReportCREG?docno="+document.getElementById("docno").value+"&branch="+branch+"&trno="+trno+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus(); 
        } else {
            $.messager.alert('Message','Please Select a Client.','warning');
            return;
        }
    }
	 
	function rectification(){
        if(document.getElementById("chkrectification").checked){
            $('#textrect').attr('readonly', false);
            $('#chkrect').val("1");
        } else{
            $('#textrect').attr('readonly', true);
            $('#textrect').val("");
            $('#chkrect').val("0");
        }
	}

	function gettobeinvconfig(){
        $("#tobeinv").hide();
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var res= x.responseText;
                if(res>0){
                    $("#tobeinv").show();
                }
            }
        }
        x.open("GET",'gridHideconfig.jsp',true);
        x.send();
    }

	function funWorkstatus() {
        $('#workstatuswindow').jqxWindow('open');
        wrkStatusContent('workstatus.jsp?trno='+$('#txtservicereporttrno').val());  
    }

	function wrkStatusContent(url) {
        $.get(url).done(function (data) {
            $('#workstatuswindow').jqxWindow('setContent', data);
        }); 
    }
</script>

</head>
<body onload="setValues();gettobeinvconfig();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmServiceReport" action="saveServiceReport" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include>

        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Service Report Details</span>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="serviceReportDate" name="serviceReportDate" value='<s:property value="serviceReportDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidserviceReportDate" name="hidserviceReportDate" value='<s:property value="hidserviceReportDate"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref. No.</label>
                    <input type="text" id="txtrefno" name="txtrefno" style="width:125px;" value='<s:property value="txtrefno"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                    <input type="text" id="docno" name="txtservicereportdocno" style="width:125px;" value='<s:property value="txtservicereportdocno"/>' tabindex="-1"/>
                    <input type="hidden" id="txtservicereporttrno" name="txtservicereporttrno" value='<s:property value="txtservicereporttrno"/>'/>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Customer & Contract Information</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Customer</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtcustomer" name="txtcustomer" placeholder="Press F3" value='<s:property value="txtcustomer"/>' onkeydown="getCustomerInfo(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtcustomer').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtcustomerdocno" name="txtcustomerdocno" value='<s:property value="txtcustomerdocno"/>'/>
                    <input type="hidden" id="txtcustomeracno" name="txtcustomeracno" value='<s:property value="txtcustomeracno"/>'/>
                    
                    <input type="text" id="txtcustomerdetails" name="txtcustomerdetails" style="flex:1; margin-left:8px;" value='<s:property value="txtcustomerdetails"/>' tabindex="-1" readonly/>
                    
                    <div style="display:none;">
                        <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>' />   
                        <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>' />
                    </div>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Contract Type</label>
                    <select id="cmbcontracttype" name="cmbcontracttype" style="width:125px;" onchange="clearContractInfo();" value='<s:property value="cmbcontracttype"/>'>
                        <option value=''>--Select--</option>
                        <option value='AMC'>AMC</option>
                        <option value='SJOB'>SJOB</option>
                        <option value='CREG'>Ticket No</option>
                    </select>
                    <input type="hidden" id="hidcmbcontracttype" name="hidcmbcontracttype" value='<s:property value="hidcmbcontracttype"/>'/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Contract No.</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtcontractno" name="txtcontractno" placeholder="Press F3" value='<s:property value="txtcontractno"/>' onkeydown="getContractDetails(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtcontractno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Contract Details</label>
                    <input type="text" id="txtcontractdetails" name="txtcontractdetails" style="flex:1;" value='<s:property value="txtcontractdetails"/>' tabindex="-1" readonly/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Site</label>
                    <input type="text" id="txtsitename" name="txtsitename" style="flex:1;" value='<s:property value="txtsitename"/>' tabindex="-1" readonly/>
                    <input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Area</label>
                    <input type="text" id="txtareaname" name="txtareaname" style="flex:1;" value='<s:property value="txtareaname"/>' tabindex="-1" readonly/>
                    <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Schedule No.</label>
                    <input type="text" id="txtscheduleno" name="txtscheduleno" style="width:125px;" value='<s:property value="txtscheduleno"/>' tabindex="-1" readonly/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Completion %</label>
                    <input type="text" id="txtcompletionperc" name="txtcompletionperc" style="width:80px; text-align:right;" value='<s:property value="txtcompletionperc"/>'/>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; width:100px; justify-content: flex-end; padding-right:5px; font-weight:bold; font-size:12px; color:#444;">
                        <input type="checkbox" name="chkrectification" id="chkrectification" onchange="rectification();" style="margin:0;"> Rectification
                    </label>
                    <input type="hidden" id="chkrect" name="chkrect" value='<s:property value="chkrect"/>'/>
                    
                    <input type="text" id="textrect" name="textrect" style="flex:1;" value='<s:property value="textrect"/>'/> 
                    <button class="myButton" type="button" id="btnwork" name="btnwork" onclick="funWorkstatus();" style="margin-left: 15px;">Work status</button>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Activity Details</span>
                <div id="activityDiv" class="grid-container" style="border: none;">
                    <jsp:include page="activityDetailsGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel" id="tobeinv">
                <span class="middle-panel-title">To be Invoiced</span>
                <div id="materialDiv" class="grid-container" style="border: none;">
                    <jsp:include page="materialDetailsGrid.jsp"></jsp:include>
                </div>
                <input type="hidden" id="txttobeinvoicednettotal" name="txttobeinvoicednettotal" value='<s:property value="txttobeinvoicednettotal"/>'/>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="activitygridlength" name="activitygridlength" value='<s:property value="activitygridlength"/>'/>
                <input type="hidden" id="tobeinvoicedgridlength" name="tobeinvoicedgridlength" value='<s:property value="tobeinvoicedgridlength"/>'/>
            </div>

        </div>
    </form>
	
    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="customerDetailsWindow"><div></div><div></div></div>
    <div id="contractDetailsWindow"><div></div><div></div></div>
    <div id="activityGridWindow"><div></div><div></div></div>
    <div id="sidesearchwndow"><div></div><div></div></div>
    <div id="workstatuswindow"><div></div><div></div></div>
    <div id="ServiceTypeWindow"><div></div><div></div></div>
</div>
</body>
</html>