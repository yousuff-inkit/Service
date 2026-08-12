<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>

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
	getconfig();
	
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    $("#stdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    $("#enddate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    $("#wstdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    $("#wenddate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
    $("#finsdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", enableBrowserBoundsDetection:true, theme: 'energyblue' });
    $("#serdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy" ,enableBrowserBoundsDetection:true, theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#date, #stdate, #enddate, #wstdate, #wenddate, #finsdate, #serdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date, #stdate, #enddate, #wstdate, #wenddate, #finsdate, #serdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

	$('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#clientsearch1').jqxWindow('close');
	$('#cpinfowindow').jqxWindow({ width: '35%', height: '62%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#cpinfowindow').jqxWindow('close');
	$('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#printWindow').jqxWindow('close');
	$('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#areainfowindow').jqxWindow('close');
	$('#siteinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#siteinfowindow').jqxWindow('close');
	$('#grpinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#grpinfowindow').jqxWindow('close');
	$('#teaminfowindow').jqxWindow({ width: '30%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#teaminfowindow').jqxWindow('close');
	$('#sertypefowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Type' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#sertypefowindow').jqxWindow('close');
	$('#schserchinfowindow').jqxWindow({ width: '80%', height: '60%',  maxHeight: '90%' ,maxWidth: '90%' ,title: 'Schedule Search' , position: { x: 150, y: 50 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#schserchinfowindow').jqxWindow('close');
	$('#serviceteamwindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Team Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#serviceteamwindow').jqxWindow('close');
				
	refChange();getsjobtype();
	  
	$('#txtclient').dblclick(function(){
		if($('#mode').val()!= "view") {
		   	$('#clientsearch1').jqxWindow('open');
			clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
		}
	});
	  
	$('#srvsite').dblclick(function(){
		if($('#mode').val()!= "view") {
		   	$('#siteinfowindow').jqxWindow('open');
		   	siteSearchContent('servicesitesearch.jsp?rowBoundIndex=1');
		}
	});
	  
	$('#srvser').dblclick(function(){
		if($('#mode').val()!= "view") {
		   	$('#sertypefowindow').jqxWindow('open');
		   	serTypeSearchContent('servicetypesearch.jsp?rowBoundIndex=1&sert=2');
		}
	});
	  
	$('#rrefno').dblclick(function(){
		if($('#mode').val()!= "view") {
		   	changeContent('enqMastersearch.jsp');  
		}
	});
	  
	$('#txtcontact').dblclick(function(){
		if($('#mode').val()!= "view") {
		   	var clientid=document.getElementById("clientid").value;
		  	if(clientid==""){
		  		document.getElementById("errormsg").innerText=" Select Client";
		  		return 0;
		  	}
		  	var type=1;
		  	var rowBoundIndex=0;
	  	 	$('#cpinfowindow').jqxWindow('open');
	  	    cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowBoundIndex+'&type='+type); 
		}
	});
	  
	$('#finsdate').on('change', function (event) {  
  	    if($('#finsdate').jqxDateTimeInput('getDate')!=null){
  		    var date=new Date($('#finsdate').jqxDateTimeInput('getDate'));
  		    var status=checkInstdate(date);
  		    if(status){
  			    document.getElementById("errormsg").innerText="";
  			    return true;
  		    } else {
  			    $('#finsdate').jqxDateTimeInput('focus');
  			    return false;
  		    }
  	    }
  	});
	  
	$('#serdate').on('change', function (event) {  
	  	if($('#serdate').jqxDateTimeInput('getDate')!=null){
	  		var date=new Date($('#serdate').jqxDateTimeInput('getDate'));
	  		var status=checkScheddate(date);
	  		if(status){
	  			document.getElementById("errormsg").innerText="";
	  			return true;
	  		} else {
	  			$('#serdate').jqxDateTimeInput('focus');
	  			return false;
	  		}
	  	}
	});
});

function isNumber(evt,id) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText="Enter Numbers Only.";
        $("#"+id+"").focus();
        return false;
    }
    document.getElementById("errormsg").innerText="";
    return true;
}

function funmaxlength(value,id){
	if(parseFloat(value)>100){
		document.getElementById("errormsg").innerText="Enter Numbers Upto 100.";
        $("#"+id+"").focus();
        $("#"+id+"").val(100);
        return false;
	}
	document.getElementById("errormsg").innerText="";
    return true;
}

function getareas(rowBoundIndex){
	$('#areainfowindow').jqxWindow('open');
    areaSearchContent('area.jsp?rowBoundIndex='+rowBoundIndex);
}
     	 
function areaSearchContent(url) {
	$.get(url).done(function (data) {
        $('#areainfowindow').jqxWindow('setContent', data);
    }); 
}
  	
function getserviceteam(rowBoundIndex){
	$('#serviceteamwindow').jqxWindow('open');
    serviceteamContent('serviceteam.jsp?rowBoundIndex='+rowBoundIndex);
}
   	 
function serviceteamContent(url) {
	$.get(url).done(function (data) {
        $('#serviceteamwindow').jqxWindow('setContent', data);
    }); 
}
  	
function schSearchContent(url) {
    $.get(url).done(function (data) {
	    $('#schserchinfowindow').jqxWindow('setContent', data);
    }); 
}
  	
function getEnquiry(event){
	var clientid=document.getElementById("clientid").value;
 	if(clientid>0){
 		document.getElementById("errormsg").innerText="";
 	} else {
 		document.getElementById("errormsg").innerText="Select a client";
 		return 0;
 	} 

    var x= event.keyCode;
    if(x==114){
        changeContent('enqMastersearch.jsp');  
    }
}
	 	 
function getsjobtype() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var srno  = items[0].split(",");
            var process = items[1].split(",");
            var optionsbranch = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                optionsbranch += '<option  value="' + srno[i].trim()+'">' + process[i] + '</option>';
            }
            $("select#cmbprocess").html(optionsbranch);
            
            if ($('#hidcmbprocess').val()>0) {
                $('#cmbprocess').val($('#hidcmbprocess').val());
            } 
        }
    }
    x.open("GET","getsjobtype.jsp", true);
    x.send();
}
	
function funcomprehensivetext(){
    if($('#cmbprocess').find('option:selected').text()=='Comprehensive'){
        $('#lblThresholdLimit').show();$('#lblPartLimitPerc').show();
        $('#txtthresholdlimit').show();$('#txtpartlimitperc').show();
        if($('#mode').val()!='view'){
            $('#txtthresholdlimit').val('');$('#txtpartlimitperc').val('');
        }
    } else {
        $('#lblThresholdLimit').hide();$('#lblPartLimitPerc').hide();
        $('#txtthresholdlimit').hide();$('#txtpartlimitperc').hide();
        if($('#mode').val()!='view'){
            $('#txtthresholdlimit').val('');$('#txtpartlimitperc').val('');
        }
    }
}
  	
function checkInstdate(date){
	 var date1=new Date(date);
	 date1.setHours(0,0,0,0);
	 var stdate=new Date($('#stdate').jqxDateTimeInput('getDate'));
	 var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
	 enddate.setHours(0,0,0,0);
	 
	 if(date1<stdate){
		 document.getElementById("errormsg").innerText="First Inst Date Should not less than Start Date";
		 return false;
	 } else if(date1>enddate){
		 document.getElementById("errormsg").innerText="First Inst Date Should not greater than End Date";
		 return false;
	 } else{
		 document.getElementById("errormsg").innerText="";
		 return true;
	 }
}

function checkScheddate(date){
	 var date1=new Date(date);
	 date1.setHours(0,0,0,0);
	 var stdate=new Date($('#stdate').jqxDateTimeInput('getDate'));
	 stdate.setHours(0,0,0,0);
	 var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
	 enddate.setHours(0,0,0,0);
	 
	 if(date1<stdate){
		 document.getElementById("errormsg").innerText="Service Date Should not less than Start Date";
		 return false;
	 } else if(date1>enddate){
		 document.getElementById("errormsg").innerText="Service Date Should not greater than End Date";
		 return false;
	 } else{
		 document.getElementById("errormsg").innerText="";
		 return true;
	 }
}
  	
function getsite(rowBoundIndex){
    $('#siteinfowindow').jqxWindow('open');
    var type=1;
    siteSearchContent('servicesitesearch.jsp?rowBoundIndex='+rowBoundIndex+'&type='+type);
}
   	 
function siteSearchContent(url) {
    $.get(url).done(function (data) {
        $('#siteinfowindow').jqxWindow('setContent', data);
        $('#siteinfowindow').jqxWindow('bringToFront');
    }); 
}
  	
function getgrpcode(rowBoundIndex){
    $('#grpinfowindow').jqxWindow('open');
    grpSearchContent('servicegrpsearch.jsp?rowBoundIndex='+rowBoundIndex);
}
   	 
function grpSearchContent(url) {
    $.get(url).done(function (data) {
        $('#grpinfowindow').jqxWindow('setContent', data);
    }); 
}
	
function getteam(rowBoundIndex,assgnid){
    $('#teaminfowindow').jqxWindow('open');
    teamSearchContent('servicegrptoearch.jsp?rowBoundIndex='+rowBoundIndex+'&assgnid='+assgnid);
}
 	 
function teamSearchContent(url) {
    $.get(url).done(function (data) {
        $('#teaminfowindow').jqxWindow('setContent', data);
    }); 
}
	
function getserType(rowBoundIndex,sert){
    $('#sertypefowindow').jqxWindow('open');
    serTypeSearchContent('servicetypesearch.jsp?rowBoundIndex='+rowBoundIndex+'&sert='+sert);
}
	 
function serTypeSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sertypefowindow').jqxWindow('setContent', data);
        $('#sertypefowindow').jqxWindow('bringToFront');
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

function funFocus(){}

function funReadOnly(){
	 $('#frmservicecontract input').attr('readonly', true);
	 $('#frmservicecontract input').attr('disabled', true);
	 $('#frmservicecontract select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $('#stdate').jqxDateTimeInput({ disabled: true});
	 $('#enddate').jqxDateTimeInput({ disabled: true});
	 $('#finsdate').jqxDateTimeInput({ disabled: true});
	 $('#serdate').jqxDateTimeInput({ disabled: true});
	 $("#serviceGrid").jqxGrid({ disabled: false});
	 $("#servscGrid").jqxGrid({ disabled: false});
	 $("#paymentGrid").jqxGrid({ disabled: false});
	 $("#siteGrid").jqxGrid({ disabled: false}); 
	 $('#btnvaluechange').hide();
	 $('#btnsearch').hide();
	 $('#chkinv').hide();
	 $('#chklblinv').hide();
	 $('#txtprogperiod').attr('readonly', true);
	 $('#txtprogper').attr('readonly', true);
     
	 if(modes=="view") {
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		
		$('#docno').attr('disabled', false);
		$('#mode').attr('disabled', false);
		$('#hidbrhid').attr('disabled', false);
		document.getElementById("docno").value=mastertrno;
		document.getElementById("mode").value=modes;
		window.parent.branchid.value=brhidview;
		setapprbrch(brhidview);
		var names = [];
		$("form").each(function() {
		   names.push(this.id);
		}); 
		var form=names[0];
		document.forms[form].submit(); 
		
		$('#masterdoc_no').attr('disabled', false);
        $('#mode').attr('disabled', false);
        $('#hidbrhid').attr('disabled', false);
    }
    
	if(modes=="A") {
	    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
		funCreateBtn();
		$('#txtclient').val(clientname);
		$('#txtclientdet').val(address);
		$('#txtmob1').val(tel);
		$('#txtmob2').val(mob);
		$('#txtcontact').val(cpersonname);
		$('#txtemail').val(mail);
		$('#clientid').val(clientno);
		$('#cpersonid').val(cpersonid);
		$('#txtsalman').val(salname);
		$('#salid').val(salid);
		
		if(parseInt(amcno)>0){
			$('#txtdocno').val(amcno);
			$("#schediv").load("serviceScheduleGrid.jsp?docno="+amcno);
			$("#sitediv").load("siteGrid.jsp?docno="+amcno);
			$("#paydiv").load("paymentGrid.jsp?docno="+amcno);
			$("#serdiv").load("serviceGrid.jsp?docno="+amcno);
		}
	}
}

function funRemoveReadOnly(){
	 $('#frmservicecontract input').attr('disabled', false);
	 $('#frmservicecontract input').attr('readonly', false);
	 $('#frmservicecontract select').attr('disabled', false);
	 funsercheck();
	 $('#chkinv').hide();
	 $('#chklblinv').hide();
	 $('#temp1').attr('disabled', true);
	 $('#temp2').attr('disabled', true);
	 $('#rrefno').attr('disabled', true);
	 $('#rrefno').attr('readonly', true);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	 $('#txtmob1').attr('readonly', true);
	 $('#txtmob2').attr('readonly', true);
	 $('#txtemail').attr('readonly', true);
	 $('#txtcontact').attr('readonly', true);
	 $('#docno').attr('readonly', true);
	 $('#isproformainv').val(0);
	 $("#editval").val(0);
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $('#stdate').jqxDateTimeInput({ disabled: false});
	 $('#enddate').jqxDateTimeInput({ disabled: false});
	 $('#finsdate').jqxDateTimeInput({ disabled: false});
	 $('#serdate').jqxDateTimeInput({ disabled: false});
	 $("#serviceGrid").jqxGrid({ disabled: false});
	 $("#servscGrid").jqxGrid({ disabled: false});
	 $("#paymentGrid").jqxGrid({ disabled: false});
	 $("#siteGrid").jqxGrid({ disabled: false});
	 funcmbprog();
	 refChange();
	 var islegaldoc=$("#islegaldoc").val();
		
     if(islegaldoc>0){
        document.getElementById("chklegaldoc").checked=true;
        legChange();
     }
		
     if($("#mode").val()=="A"){
        getsjobtype();
        $('#date').jqxDateTimeInput('setDate', new Date());
        $('#stdate').jqxDateTimeInput('setDate', new Date());
        $('#enddate').jqxDateTimeInput('setDate', new Date());
        $('#finsdate').jqxDateTimeInput('setDate', new Date());
        $('#serdate').jqxDateTimeInput('setDate', new Date());
        $("#installments").val(0);
        $("#paydueafter").val(0);
        $("#srvcinterval").val(0);
        $("#serdueafter").val(0);
        $("#txttaxper").val(0);
        funRoundAmt(0,"txtcntrval");
        $("#salesincentive").val(0);
        $("#incentive").val(0);
        
        $("#serviceGrid").jqxGrid('clear');
        $("#serviceGrid").jqxGrid('addrow', null, {});
        $("#servscGrid").jqxGrid('clear');
        $("#servscGrid").jqxGrid('addrow', null, {});
        $("#paymentGrid").jqxGrid('clear');
        $("#paymentGrid").jqxGrid('addrow', null, {});
        $("#siteGrid").jqxGrid('clear');
        $("#siteGrid").jqxGrid('addrow', null, {});
     }
     else if($("#mode").val()=="E"){
        funsercheck();
        $('#btnvaluechange').show();
        $("#serviceGrid").jqxGrid({ disabled: true});
        $("#servscGrid").jqxGrid({ disabled: true});
        $("#paymentGrid").jqxGrid({ disabled: true});
        $("#siteGrid").jqxGrid({ disabled: true});
        var chkserv=$("#chkserv").val();
        if(chkserv>0){
            $('#chkserv').attr('disabled', true);
        }
     }
}

function funwarningopen(){
	if($("#mode").val()=="E"){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	    	     $("#serviceGrid").jqxGrid({ disabled: false});
				 $("#servscGrid").jqxGrid({ disabled: false});
				 $("#paymentGrid").jqxGrid({ disabled: false});
				 $("#siteGrid").jqxGrid({ disabled: false});
				 $("#editval").val(1);
	       } else {
	    	     $("#serviceGrid").jqxGrid({ disabled: true});
				 $("#servscGrid").jqxGrid({ disabled: true});
				 $("#paymentGrid").jqxGrid({ disabled: true});
				 $("#siteGrid").jqxGrid({ disabled: true});
				 $("#editval").val(0);
	       }
	    });
	 } 
}

function funpay(){
	var startdate=$("#finsdate").val();
	var stdate=$("#stdate").val();
	var enddate=$("#enddate").val();
	var amount=$("#txtcntrval").val();
	var instno=$("#installments").val();
	var cmbpaytype=$("#cmbpaytype").val();
	var paydueafter=$("#paydueafter").val();
	document.getElementById("cvalchnge").value=0;
	if($("#mode").val()=="E"){
		$("#editval").val(1);
	}
	if($('#finsdate').jqxDateTimeInput('getDate')!=null){
  		var date=new Date($('#finsdate').jqxDateTimeInput('getDate'));
  		var status=checkInstdate(date);
  		if(status){
  			document.getElementById("errormsg").innerText="";
  			$("#paydiv").load("paymentGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&amount="+amount+"&instno="+instno+"&cmbpaytype="+cmbpaytype+"&paydueafter="+paydueafter+"&gridload=1");
  		}
  	}
}

function funscheduler(){
	var startdate=$("#serdate").val();
	var enddate=$("#enddate").val();
	var stdate=$("#stdate").val();
	var amount=0;
	var instno=$("#srvcinterval").val();
	var cmbpaytype=$("#cmbsrvctype").val();
	var serdueafter=$("#serdueafter").val();
	
	if($('#serdate').jqxDateTimeInput('getDate')!=null){
  		var date=new Date($('#serdate').jqxDateTimeInput('getDate'));
  		var status=checkScheddate(date);
  		if(status){
  			$("#schediv").load("serviceScheduleGrid.jsp?startdate="+startdate+"&enddate="+enddate+"&amount="+amount+"&instno="+instno+"&cmbpaytype="+cmbpaytype+"&serdueafter="+serdueafter+"&gridload=1");
  		}
  	}
}

function funNotify(){
	if($('#cmbprog').val()==2) {
		if($('#txtprogperiod').val()=="" || $('#txtprogper').val()=="" || $('#txtprogperiod').val()==0 || $('#txtprogper').val()==0){  
	        document.getElementById("errormsg").innerText="Progressive With Retention , Period And Percentage Mandatory ";
	        return 0;
		}
	}
	
	if($('#clientid').val()== "") {
	    document.getElementById("errormsg").innerText="select Client";
	    return 0;
	}
	$('#chkserv').attr('disabled', false);
	
	if($('#txtcntrval').val()== "") {
	    document.getElementById("errormsg").innerText="Enter contract value";
	    return 0;
	}
	
	var rows1 = $("#paymentGrid").jqxGrid('getrows');
    var rows2 = $("#serviceGrid").jqxGrid('getrows');
	var rows3 = $("#siteGrid").jqxGrid('getrows');
	var rows4 = $("#servscGrid").jqxGrid('getrows');
	var cvalchnge=$("#cvalchnge").val();
	var msgid=0;
	if(cvalchnge>0){
		 document.getElementById("errormsg").innerText="Contract value Changed,Payment data showuld be changed";
		 return 0;
	}
	$('#paymentlen').val(rows1.length);
	$('#servicelen').val(rows2.length);
	$('#sitelen').val(rows3.length);
	$('#serviceSchedulelen').val(rows4.length);
	
	for(var i=0 ; i < rows3.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "site"+i)
            .attr("name", "site"+i)
            .attr("hidden", "true"); 
        if($('#siteGrid').jqxGrid('iscolumnvisible', 'serviceteam')) {
            if((rows3[i].site!="undefined" && rows3[i].site!=null && rows3[i].site!="" )) {
                if(rows3[i].steamid=="undefined" || rows3[i].steamid==null || rows3[i].steamid=="") {
                    msgid++;
                    break;
                }
            }
        }
        newTextBox.val(rows3[i].site+" :: "+rows3[i].areaid+" :: "+rows3[i].siteadd+" :: "+rows3[i].contid+" :: "+rows3[i].rowno+" :: "+rows3[i].steamid+" :: ");
        newTextBox.appendTo('form');
    }
    if($('#siteGrid').jqxGrid('iscolumnvisible', 'serviceteam')) {	 
        if(msgid>0) {
            document.getElementById("errormsg").innerText="Service Team Is Mandatory In Site Details";
            return 0;
        }
    }

    for(var i=0 ; i < rows1.length ; i++){
        var dueafterser="";
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "pay"+i)
            .attr("name", "pay"+i)
            .attr("hidden", "true"); 
        
        if (rows1[i].terms =="LEGAL DOCUMENT") { dueafterser=99; }
        if (rows1[i].terms =="SERVICE") { dueafterser=rows1[i].service; }
        if (rows1[i].terms =="PROFORMA INVOICE") {
            dueafterser=98;
            document.getElementById("isproformainv").value=1;
        }
        newTextBox.val(rows1[i].duedate+" :: "+rows1[i].amount+" :: "+rows1[i].runtotal+" :: "+rows1[i].desc1+" :: "+rows1[i].terms+" :: "+dueafterser+" :: "+rows1[i].service+" :: "+rows1[i].rowno+" :: ");
        newTextBox.appendTo('form');
    }
	   
    for(var i=0 ; i < rows2.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "service"+i)
            .attr("name", "service"+i)
            .attr("hidden", "true"); 
        newTextBox.val(rows2[i].stypeid+" :: "+rows2[i].item+" :: "+rows2[i].qty+" :: "+rows2[i].amount+" :: "+rows2[i].total+" :: "+rows2[i].desc1+" :: "+rows2[i].trno+" :: "+rows2[i].srno+" :: ");
        newTextBox.appendTo('form');
    }
			
    for(var i=0 ; i < rows4.length ; i++){
        var dis=0;
        var valu=0;
        var chkserv=document.getElementById("chkserv").value;
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "sersc"+i)
            .attr("name", "sersc"+i)
            .attr("hidden", "true");
            
        if (rows4[i].priority == true) { dis=1; }
        var d=new Date(rows4[i].pltime);
        var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
            
        if(chkserv==0){
            newTextBox.val(rows4[i].pldate+" :: "+tempstarttime+" :: "+dis+" :: "+rows4[i].trno+" :: "+rows4[i].type+" :: ");
        } else if(chkserv==1){
            newTextBox.val(rows4[i].pldate+" :: "+tempstarttime+" :: "+dis+" :: "+rows4[i].serviceid+"::"+rows4[i].siteid+"::"+rows4[i].value+"::"+rows4[i].trno+" :: "+rows4[i].type+" :: ");
        } 
        newTextBox.appendTo('form');
    }

    var retval  = getEditStat(); 
    if(retval==0){
        $.messager.alert('Warning',"You cannot change invoice generated document!",true);    
    }
    return retval;
} 

function getEditStat(){
	var retval = 1; 
	if($("#mode").val()=="E" || $("#mode").val()=="D"){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0){
					retval = 0;
				} else {
					retval = 1; 
				}
			}
		}
		x.open("GET", "linkchk.jsp?docno="+document.getElementById("masterdoc_no").value, false);
		x.send();  
	}
	return retval;   
}

function refChange(){
    var reftype=$('#cmbreftype').val();
    if(reftype=='DIR'){
        $('#rrefno').attr('disabled', true);
    } else {
        $('#rrefno').attr('disabled', false);
    }
}
	
function legChange(){
    if(document.getElementById("chklegaldoc").checked){
        document.getElementById("islegaldoc").value=1;
        $('#temp1').attr('disabled', false);
        $('#temp2').attr('disabled', false);
        $('#temp2').attr('readonly', true);
    } else {
        document.getElementById("islegaldoc").value=0;
        $('#temp1').attr('disabled', true);
        $('#temp2').attr('disabled', true);
    }
}
	
function setValues(){
    if($('#hiddate').val()){
        $("#date").jqxDateTimeInput('val', $('#hiddate').val());
    }

    var masterdoc_no=$('#masterdoc_no').val().trim();
    var refmasterdocno=0;
	
    if(masterdoc_no>0){
        if ($('#hidcmbreftype').val() != "" || $('#hidcmbreftype').val() !=null) {
            $('#cmbreftype').val($('#hidcmbreftype').val());
        }
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        $("#InvTransIssueGrid").load("InvTransIssueGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&cond=2");
    }
    funchkforedit();
}

function set() {
    document.getElementById("errormsg").innerText="";
}

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("savetransferIssue");
        var win= window.open(reurl[0]+"printtransissueAction?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}
 
function funchkforedit() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0) {
                $("#btnEdit").attr('disabled', true );
                $("#btnDelete").attr('disabled', true ); 
			}
		}
	}
	x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
	x.send();    
}

</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frminventoryissue" action="savetransferIssue" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include> 

        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Inventory Transfer Issue Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref. No.</label>
                    <input type="text" id="txtrefno" name="txtrefno" style="width:125px;" value='<s:property value="txtrefno"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                    <input type="text" id="docno" name="docno" style="width:125px;" value='<s:property value="docno"/>' tabindex="-1" readonly/>
                </div>
            </div>

            <div style="display: flex; gap: 15px; align-items: flex-start;">
                
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Inventory Transfer From</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Type</label>
                        <select id="cmbreftype" name="cmbreftype" style="width:125px;" onchange="set()" value='<s:property value="cmbreftype"/>'>
                            <option value="">--select--</option>
                            <option value="IBT">Branch Transfer</option>
                            <option value="ILT">Location Transfer</option>
                        </select>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Branch</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" id="txtfrmbranch" name="txtfrmbranch" placeholder="Press F3" value='<s:property value="txtfrmbranch"/>'/>
                        </div>
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:80px;">Location</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" id="txtfrmlocation" name="txtfrmlocation" placeholder="Press F3" onkeydown="getLocation(event,1);" value='<s:property value="txtfrmlocation"/>'/>
                            <svg class="magnifier-icon" onclick="$('#txtfrmlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                    </div>
                </div>

                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Inventory Transfer To</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Branch</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" id="txttobranch" name="txttobranch" placeholder="Press F3" onkeydown="getBranch(event,2);" value='<s:property value="txttobranch"/>'/>
                            <svg class="magnifier-icon" onclick="$('#txttobranch').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                    </div>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Location</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" id="txttolocation" name="txttolocation" placeholder="Press F3" onkeydown="getLocation(event,2);" value='<s:property value="txttolocation"/>'/>
                            <svg class="magnifier-icon" onclick="$('#txttolocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                    </div>
                    
                    <div class="field-row" style="margin-bottom:0;">
                        <label class="lbl-right" style="width:80px;">Remarks</label>
                        <input type="text" id="txtremark" name="txtremark" style="flex:1;" value='<s:property value="txtremark"/>' />
                    </div>
                </div>

            </div>

            <div class="middle-panel" style="margin-top: 15px;">
                <span class="middle-panel-title">Issue Grid</span>
                <div id="InvTransIssueGrid" class="grid-container" style="border: none;">
                    <jsp:include page="InvTransIssueGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>' />   
                <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>' />
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
                <input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
                <input type="hidden" name="txtnettotal" id="txtnettotal" value='<s:property value="txtnettotal"/>'>
                <input type="hidden" id="orderValue" name="orderValue" value='<s:property value="orderValue"/>'/>
                <input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
                <input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
                <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
                <input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
                <input type="hidden" id="refmasterdocno" name="refmasterdocno" value='<s:property value="refmasterdocno"/>'/>
                <input type="hidden" id="gridlength" name="gridlength"/>
                <input type="hidden" id="servgridlen" name="servgridlen" value='<s:property value="servgridlen"/>'/>
                <input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
                <input type="hidden" id="branchfrmid" name="branchfrmid" value='<s:property value="branchfrmid"/>'/>
                <input type="hidden" id="locationfrmid" name="locationfrmid" value='<s:property value="locationfrmid"/>'/>
                <input type="hidden" id="branchtoid" name="branchtoid" value='<s:property value="branchtoid"/>'/>
                <input type="hidden" id="locationtoid" name="locationtoid" value='<s:property value="locationtoid"/>'/>
                <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
            </div>

        </div>
    </form>
	
    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="branchwindow"><div></div><div></div></div>	
    <div id="locationwindow"><div></div><div></div></div>
    <div id="sidesearchwndow"><div></div><div></div></div> 
</div>
</body>
</html>