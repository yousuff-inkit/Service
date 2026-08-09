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
String mod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();

String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String ref_type=request.getParameter("ref_type")==null?"0":request.getParameter("ref_type").toString();
String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
String reftrno=request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();

String pertel=request.getParameter("pertel")==null?"0":request.getParameter("pertel").toString();
String per_mob=request.getParameter("per_mob")==null?"0":request.getParameter("per_mob").toString();
String mail1=request.getParameter("mail1")==null?"0":request.getParameter("mail1").toString();
String salname=request.getParameter("salname")==null?"0":request.getParameter("salname").toString();
String salid=request.getParameter("salid")==null?"0":request.getParameter("salid").toString();
String contrtype=request.getParameter("contrtype")==null?"0":request.getParameter("contrtype").toString();
String surtrnof=request.getParameter("surtrno")==null?"0":request.getParameter("surtrno").toString();
String esttrnof=request.getParameter("esttrno")==null?"0":request.getParameter("esttrno").toString();
String cpersonid=request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String cperson=request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
String cpersondet=request.getParameter("cpersondet")==null?"0":request.getParameter("cpersondet").toString();
String sjobtype=request.getParameter("sjobtype")==null?"0":request.getParameter("sjobtype").toString();
String clienttaxper=request.getParameter("clienttaxper")==null?"0":request.getParameter("clienttaxper").toString();

System.out.println("ref_type=="+ref_type);
%>

<script type="text/javascript">
var modes='<%=modes%>';
var mod1='<%=mod%>';
var mastertrno='<%=mastertrno%>';

	$(document).ready(function() {
		
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
	  $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	  $("#stdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
	  $("#enddate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
	  $("#finsdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", enableBrowserBoundsDetection:true, theme: 'energyblue' });
	  $("#serdate").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy" ,enableBrowserBoundsDetection:true, theme: 'energyblue'});
      
      /* force internal alignment AFTER render */
      setTimeout(function () {
          $("#date, #stdate, #enddate, #finsdate, #serdate").find("input").css({
              "margin-top": "0px",
              "line-height": "24px",
              "font-size": "12px", 
              "font-family": "Arial, sans-serif", 
              "padding": "0 6px", 
              "box-sizing":"border-box"
          });
          $("#date, #stdate, #enddate, #finsdate, #serdate").find(".jqx-action-button").css({
              "top": "0px",
              "height": "24px"
          });
      }, 0);

      $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
	  $('#clientsearch1').jqxWindow('close');
	  $('#cpinfowindow').jqxWindow({ width: '35%', height: '62%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	  $('#cpinfowindow').jqxWindow('close');
	  $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	  $('#areainfowindow').jqxWindow('close');
	  $('#siteinfowindow').jqxWindow({ width: '25%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
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
	  $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#printWindow').jqxWindow('close');
	 
	  refChange();getsjobtype();getconfig();
	  
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
	       }
	       else{
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
	 } else{
		 document.getElementById("islegaldoc").value=0;
		 $('#temp1').attr('disabled', true);
		 $('#temp2').attr('disabled', true);
	 }
}
	
function setValues(){
	var docno=$("#masterdoc_no").val();
	var islegaldoc=$("#islegaldoc").val();
	var chkincltax=$("#chkincltax").val();
	var chkserv=$("#chkserv").val();
	
	if(islegaldoc>0){
		document.getElementById("chklegaldoc").checked=true;
		legChange();
	}
	if(chkincltax>0){
		document.getElementById("chkincltax").checked=true;
	}
	if(chkserv>0){
		document.getElementById("chkserv").checked=true;
		$('#chkserv').attr('disabled', true);
		var chkinv=$("#chkinv").val();
		if(chkinv>0){
			document.getElementById("chkinv").checked=true;
		}
		funsercheck();
	}
	
	if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	}
	
	if($('#hidcmbsrvctype').val()!="") {  
	    $('#cmbsrvctype').val($('#hidcmbsrvctype').val());
	}
	if($('#hidcmbpaytype').val()!="") {  
	    $('#cmbpaytype').val($('#hidcmbpaytype').val());
	}
	if($('#hidcmbreftype').val()!="") {  
	    $('#cmbreftype').val($('#hidcmbreftype').val());
	}
	if($('#hidcmbprog').val()!="") {  
	    $('#cmbprog').val($('#hidcmbprog').val());
	}
	
	if(docno>0){
		$("#schediv").load("serviceScheduleGrid.jsp?docno="+docno);
		$("#sitediv").load("siteGrid.jsp?docno="+docno);
		$("#paydiv").load("paymentGrid.jsp?docno="+docno);
		$("#serdiv").load("serviceGrid.jsp?docno="+docno);
	}
	funSetlabel();funchkforedit();
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
	x.open("GET", "linkchk.jsp?docno="+document.getElementById("masterdoc_no").value, true);
	x.send();
}

function funSearchLoad(){
	 changeContent('Mastersearch.jsp'); 
} 

function cvalChnge(){
	if($("#mode").val()=="E"){
		document.getElementById("cvalchnge").value=1;
		$("#editval").val(1);
		document.getElementById("errormsg").innerText="Contract value Changed,Payment details should be changed";
	}
}
	
function funPrintBtn() {
    if (($("#mode").val() == "view") && $("#docno").val()!="") {
        $("#docno").prop("disabled", false);
        $("#masterdoc_no").prop("disabled", false);
        $("#formdetailcode").prop("disabled", false);
        
        var docno=$('#docno').val();
        var trno=$('#masterdoc_no').val();
        var dtype=$('#formdetailcode').val();
        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
        var url=document.URL;
        var reurl=url.split("com/"); 
        
        PrintContent('firestonePrintVoucher.jsp');
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return;
    }
}

function PrintContent(url) {
    $('#printWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#printWindow').jqxWindow('setContent', data);
    }); 
} 
	  
function daycheck(){
    var aid=0;
    if(document.getElementById("mon").checked){ aid=aid+0+","; }
    if(document.getElementById("tue").checked){ aid=aid+1+","; }
    if(document.getElementById("wed").checked){ aid=aid+2+","; }
    if(document.getElementById("thu").checked){ aid=aid+3+","; }
    if(document.getElementById("fri").checked){ aid=aid+4+","; }
    if(document.getElementById("sat").checked){ aid=aid+5+","; }
    if(document.getElementById("sun").checked){ aid=aid+6+","; }
    document.getElementById("cmbsrvday").value=aid;
}
	  
function schSearch(){
    $('#schserchinfowindow').jqxWindow('open');
    schSearchContent('scheduleSearch.jsp');
}
	  
function funsercheck(){
    var chkserv=document.getElementById("chkserv").value;
    if(chkserv==1){
        $('#btnsearch').show();
        $('#chkinv').show();
        $('#chklblinv').show();
        $('#srvcinterval').attr('disabled', true);
        $('#serdueafter').attr('disabled', true);
        $('#cmbsrvctype').attr('disabled', true);
        $('#btnSchAdd').hide();
        $('#servscGrid').jqxGrid('showcolumn','site');
        $('#servscGrid').jqxGrid('showcolumn','service');
        $('#servscGrid').jqxGrid('showcolumn','value');
        $('#servscGrid').jqxGrid('showcolumn','site');
        $('#servscGrid').jqxGrid('showcolumn','days');
    } else {
        $('#chkinv').hide();
        $('#chklblinv').hide();
        $('#btnSchAdd').show();
        $('#srvcinterval').attr('disabled', false);
        $('#serdueafter').attr('disabled', false);
        $('#cmbsrvctype').attr('disabled', false);
        $('#btnsearch').hide();
        $('#servscGrid').jqxGrid('hidecolumn','service');
        $('#servscGrid').jqxGrid('hidecolumn','value');
        $('#servscGrid').jqxGrid('hidecolumn','days');
    }
}

function funcmbprog(){
    var cmbprog=document.getElementById("cmbprog").value;
    if(cmbprog==2) {
        $('#txtprogperiod').attr('readonly', false);
        $('#txtprogper').attr('readonly', false);
    } else {
        $('#txtprogperiod').val(0);
        $('#txtprogper').val(0);
        $('#txtprogperiod').attr('readonly', true);
        $('#txtprogper').attr('readonly', true);
    }
}
	 
function chkprogressive() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)>0) {
                $('#prog').show();
            } else {
                $('#prog').hide();
            }
        }
    }
    x.open("GET","checkprogressive.jsp?",true);
    x.send();
}  
 
function getconfig() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            if (items[0]==1) {
                $('#cmbprocess').hide();
                $('#lblThresholdLimit').hide();
                $('#lbltype').hide();
                $('#txtthresholdlimit').hide();
                $('#lblPartLimitPerc').hide();
                $('#txtpartlimitperc').hide();
                $('#chklegaldoc').hide();
                $('#chklegaldoc1').hide();
                $('#temp1').hide();
                $('#temp2').hide();
                $('#lblincentive').hide();
                $('#incentive').hide();
                $('#lblslsincetive').hide();
                $('#salesincentive').hide();
                $('#lblbudget').hide();
                $('#txtbudget').hide();
            } else {
                $('#cmbprocess').show();
                $('#lblThresholdLimit').show();
                $('#lbltype').show();
                $('#txtthresholdlimit').show();
                $('#lblPartLimitPerc').show();
                $('#txtpartlimitperc').show();
                $('#chklegaldoc').show();
                $('#chklegaldoc1').show();
                $('#temp1').show();
                $('#temp2').show();
                $('#lblincentive').show();
                $('#incentive').show();
                $('#lblslsincetive').show();
                $('#salesincentive').show();
                $('#lblbudget').show();
                $('#txtbudget').show();
            }
        } 
    }
    x.open("GET", "getconfig.jsp", true);
    x.send();
}	
</script>
</head>

<body onLoad="setValues();funcmbprog();chkprogressive();getsjobtype();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmservicecontract" action="saveServicecontractpd" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Contract Summary</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date" />'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref No</label>
                    <input type="text" name="txtrefno" value='<s:property value="txtrefno" />' id="txtrefno" style="width:125px;">
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" value='<s:property value="docno" />' id="docno" style="width:125px;" tabindex="-1" readonly>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Client Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Client</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="txtclient" id="txtclient" placeholder="Press F3" onKeyDown="getclinfo(event);" value='<s:property value="txtclient" />'>
                        <svg class="magnifier-icon" onclick="$('#txtclient').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Client Details</label>
                    <input type="text" name="txtclientdet" id="txtclientdet" style="flex:1;" value='<s:property value="txtclientdet" />'>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Tele.</label>
                    <input type="text" name="txtmob1" id="txtmob1" style="width:125px;" value='<s:property value="txtmob1" />'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Mobile</label>
                    <input type="text" name="txtmob2" id="txtmob2" style="width:125px;" value='<s:property value="txtmob2" />'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Sales Man</label>
                    <input type="text" name="txtsalman" id="txtsalman" style="width:150px;" value='<s:property value="txtsalman" />'>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Mail</label>
                    <input type="text" name="txtemail" id="txtemail" style="flex:1;" value='<s:property value="txtemail" />'>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Contact Person</label>
                    <div class="input-search-container" style="width: 150px;">
                        <input type="text" name="txtcontact" id="txtcontact" placeholder="Press F3" onKeyDown="getcontact(event,0);" value='<s:property value="txtcontact" />'>
                        <svg class="magnifier-icon" onclick="$('#txtcontact').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Configuration</span>
                
                <div class="field-row">
                    <label id="lbltype" class="lbl-right" style="width:80px;">Type</label>
                    <select name="cmbprocess" id="cmbprocess" style="width:125px;" onchange="funcomprehensivetext();" value='<s:property value="cmbprocess"/>'></select>
                    <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' />
                    
                    <label id="lblThresholdLimit" class="lbl-right" style="width:100px; margin-left:15px;">Threshold Limit</label>
                    <input type="text" id="txtthresholdlimit" name="txtthresholdlimit" style="width:80px; text-align:right;" onkeypress="javascript:return isNumber (event,id)" value='<s:property value="txtthresholdlimit"/>'/>
                    
                    <label id="lblPartLimitPerc" class="lbl-right" style="width:80px; margin-left:15px;">Part Limit %</label>
                    <input type="text" id="txtpartlimitperc" name="txtpartlimitperc" style="width:80px; text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funmaxlength(this.value,this.id);" value='<s:property value="txtpartlimitperc"/>'/>
                </div>
                
                <div class="field-row">
                    <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; width:125px; margin-left: 15px;">
                        <input type="checkbox" name="chklegaldoc" id="chklegaldoc" onchange="legChange();" style="margin:0;"> 
                        <span id="chklegaldoc1" style="font-weight:bold; font-size:12px; color:#444;">Legal Fee</span>
                    </label>
                    <input type="text" id="temp1" name="temp1" style="width:80px;" value='<s:property value="temp1"/>'/>
                    <input type="text" id="temp2" name="temp2" style="width:80px; margin-left:5px;" value='<s:property value="temp2"/>' />
                    
                    <label id="lblincentive" class="lbl-right" style="width:80px; margin-left:15px;">Incentive</label>
                    <input type="text" name="incentive" id="incentive" style="width:80px;" value='<s:property value="incentive"/>'>
                    
                    <label id="lblslsincetive" class="lbl-right" style="width:100px; margin-left:15px;">Sales Incentive</label>
                    <input type="text" name="salesincentive" id="salesincentive" style="width:80px;" value='<s:property value="salesincentive"/>'>
                    
                    <label id="lblbudget" class="lbl-right" style="width:60px; margin-left:15px;">Budget</label>
                    <input type="text" id="txtbudget" name="txtbudget" style="width:80px; text-align:right;" value='<s:property value="txtbudget"/>'/>
                    
                    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left:auto;">Value Change</button>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label id="lblcontrct" class="lbl-right" style="width:80px;">Contract Value</label>
                    <input type="text" id="txtcntrval" name="txtcntrval" style="width:125px; text-align:right;" onKeyUp="cvalChnge();" onchange="funwarningopen();" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtcntrval"/>'/>
                    
                    <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; width:80px; margin-left:15px; font-weight:bold; font-size:12px; color:#444;">
                        <input type="checkbox" name="chkincltax" id="chkincltax" value='<s:property value="chkincltax" />' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="margin:0;"> Incl tax
                    </label>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref. Type</label>
                    <select id="cmbreftype" name="cmbreftype" style="width:100px;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
                        <option value="DIR">DIR</option>
                        <option value="SQOT">SQOT</option>
                        <option value="ENQ">ENQ</option>
                    </select>
                    
                    <div class="input-search-container" style="width: 125px; margin-left:5px;">
                        <input type="text" id="rrefno" name="rrefno" placeholder="Press F3" onKeyDown="getEnquiry(event);" value='<s:property value="rrefno"/>'/>
                        <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:60px; margin-left:auto;">St.Date</label>
                    <div style="width: 125px;">
                        <div id="stdate" name="stdate" value='<s:property value="stdate" />'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">End Date</label>
                    <div style="width: 125px;">
                        <div id="enddate" name="enddate" value='<s:property value="enddate" />'></div>
                    </div>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Site Details</span>
                <div id="sitediv" class="grid-container" style="border: none;">
                    <jsp:include page="siteGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Payment Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Installments</label>
                    <input type="text" name="installments" id="installments" style="width:80px;" value='<s:property value="installments"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Due After</label>
                    <input type="text" name="paydueafter" id="paydueafter" style="width:80px;" value='<s:property value="paydueafter"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Frequency</label>
                    <select name="cmbpaytype" id="cmbpaytype" style="width:100px;">
                        <option value="1">DAYS</option>
                        <option value="2">MONTHS</option>
                        <option value="3">YEAR</option>
                    </select>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">First Inst.On</label>
                    <div style="width: 125px;">
                        <div id="finsdate" name="finsdate" value='<s:property value="finsdate" />'></div>
                    </div>
                    
                    <button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funpay();" style="margin-left: 15px;">Fill</button>
                </div>
                
                <div class="field-row" id="prog">
                    <label class="lbl-right" style="width:80px;">Terms</label>
                    <select id="cmbprog" name="cmbprog" style="width:150px;" onchange="funcmbprog();" value='<s:property value="cmbprog"/>'>
                        <option value="">--Select--</option>
                        <option value="1">PROGRESSIVE</option>
                        <option value="2">PROGRESSIVE WITH RETENTION</option>
                    </select>
                    
                    <label class="lbl-right" style="width:120px; margin-left:15px;">Period(in months)</label>
                    <input type="text" id="txtprogperiod" name="txtprogperiod" style="width:80px;" value='<s:property value="txtprogperiod"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Percentage</label>
                    <input type="text" id="txtprogper" name="txtprogper" style="width:80px;" value='<s:property value="txtprogper"/>'/>
                </div>
                
                <div id="paydiv" class="grid-container" style="border: none; margin-top:10px;">
                    <jsp:include page="paymentGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Service Details</span>
                
                <div class="field-row" style="margin-bottom:10px;">
                    <label class="lbl-right" style="width:120px;">Special Instruction</label>
                    <input type="text" id="txtsplinstruct" name="txtsplinstruct" style="flex:1;" value='<s:property value="txtsplinstruct"/>'/>
                </div>
                
                <div id="serdiv" class="grid-container" style="border: none;">
                    <jsp:include page="serviceGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Service Scheduler</span>
                
                <div id="schserdiv" class="field-row" style="margin-bottom:10px;">
                    <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; font-weight:bold; font-size:12px; color:#444;">
                        <input type="checkbox" name="chkserv" id="chkserv" value='<s:property value="chkserv" />' onclick="$(this).attr('value', this.checked ? 1 : 0);funsercheck();" style="margin:0;"> Service 
                    </label>
                    
                    <label id="chklblinv" style="cursor: pointer; display: flex; align-items: center; gap: 5px; font-weight:bold; font-size:12px; color:#444; margin-left:15px;">
                        <input type="checkbox" name="chkinv" id="chkinv" value='<s:property value="chkinv" />' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="margin:0;"> To Be Invoiced
                    </label>
                    
                    <button class="myButton" type="button" id="btnsearch" name="btnsearch" onclick="schSearch();" style="margin-left: 15px;">Search</button>
                    
                    <label class="lbl-right" style="width:60px; margin-left:auto;">Interval</label>
                    <input type="text" name="srvcinterval" id="srvcinterval" style="width:80px;" value='<s:property value="srvcinterval"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Due After</label>
                    <input type="text" name="serdueafter" id="serdueafter" style="width:80px;" value='<s:property value="serdueafter"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Frequency</label>
                    <select name="cmbsrvctype" id="cmbsrvctype" style="width:100px;">
                        <option value="1">DAYS</option>
                        <option value="2">MONTHS</option>
                        <option value="3">YEAR</option>
                    </select>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Service Start On</label>
                    <div style="width: 125px;">
                        <div id="serdate" name="serdate" value='<s:property value="serdate" />'></div>
                    </div>
                    
                    <button class="myButton" type="button" id="btnSchAdd" name="btnSchAdd" onclick="funscheduler();" style="margin-left: 15px;">Fill</button>
                </div>
                
                <div id="schediv" class="grid-container" style="border: none;">
                    <jsp:include page="serviceScheduleGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="islegaldoc" name="islegaldoc" value='<s:property value="islegaldoc"/>'/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
                <input type="hidden" id="refmasterdoc_no" name="refmasterdoc_no" value='<s:property value="refmasterdoc_no"/>'/>
                <input type="hidden" id="cpersonid" name="cpersonid" value='<s:property value="cpersonid"/>'/>
                <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
                <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/>
                <input type="hidden" id="hidcmbsrvctype" name="hidcmbsrvctype" value='<s:property value="hidcmbsrvctype"/>'/>
                <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
                <input type="hidden" id="hidcmbprog" name="hidcmbprog" value='<s:property value="hidcmbprog"/>'/>
                <input type="hidden" id="rrefdoc_no" name="rrefdoc_no" value='<s:property value="rrefdoc_no"/>'/>
                <input type="hidden" id="serviceSchedulelen" name="serviceSchedulelen" value='<s:property value="serviceSchedulelen"/>'/>
                <input type="hidden" id="servicelen" name="servicelen" value='<s:property value="servicelen"/>'/>
                <input type="hidden" id="paymentlen" name="paymentlen" value='<s:property value="paymentlen"/>'/>
                <input type="hidden" id="sitelen" name="sitelen" value='<s:property value="sitelen"/>'/>
                <input type="hidden" id="isproformainv" name="isproformainv" value='<s:property value="isproformainv"/>'/>
                <input type="hidden" id="salid" name="salid" value='<s:property value="salid"/>'/>
                <input type="hidden" id="editval" name="editval" value='<s:property value="editval"/>'/>
                <input type="hidden" id="cvalchnge" name="cvalchnge" value='<s:property value="cvalchnge"/>'/>
                <input type="hidden" id="cmbsrvday" name="cmbsrvday" value='<s:property value="cmbsrvday"/>'/>
                <input type="hidden" id="hidsiteid" name="hidsiteid" value='<s:property value="hidsiteid"/>'/>
                <input type="hidden" id="hidcontredit" name="hidcontredit" value='<s:property value="hidcontredit"/>'/> 
                <input type="hidden" id="hidbrhid" name="hidbrhid" value='<s:property value="hidbrhid"/>'/>
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
            </div>

        </div>
    </form>

    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="clientsearch1"><div></div><div></div></div>
    <div id="areainfowindow"><div></div><div></div></div>
    <div id="grpinfowindow"><div></div><div></div></div>
    <div id="teaminfowindow"><div></div><div></div></div>
    <div id="sertypefowindow"><div></div><div></div></div>
    <div id="cpinfowindow"><div></div><div></div></div>
    <div id="siteinfowindow"><div></div><div></div></div>
    <div id="schserchinfowindow"><div></div><div></div></div>
    <div id="serviceteamwindow"><div></div><div></div></div>
    <div id="printWindow"><div></div><div></div></div>
</div>     
</body>
</html>