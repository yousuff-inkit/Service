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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
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

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
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

/* Page height fix */
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

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	 $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
     $('#accountSearchwindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 
	 
	   $('#account').dblclick(function(){
	    
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
	    		 
	  });   
	  
});

function funExportBtn(){
	 
	 JSONToCSVCon(datas, 'Sales Invoice Audit', true);
	   
	   
	 }

function getaccountdetails(event){
	 var x= event.keyCode;
  	
 
		
	 if(x==114){
	  $('#accountSearchwindow').jqxWindow('open');
	
	 accountSearchContent('accountsDetailsSearch.jsp?');    }
	 else{
		 }
		 
	 }  
	  function accountSearchContent(url) {
 
         $.get(url).done(function (data) {
 
       $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
   	}
function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var statusselect=$("#statusselect").val();
	 var type=$("#type").val();
	 var acno=$("#acno").val();
	 var aa="yes";
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("salesinvoiceauditGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno+"&type="+type+"&aa="+aa);
	
		   }
	}

function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("account").value="";
	document.getElementById("accname").value="";
	document.getElementById("type").value="1"; 
	
	 if (document.getElementById("account").value == "") {
			
		 
	        $('#account').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  
		
	}
function funAudit(event){
	var docnos = $('#docnos').val();
 
		
	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 saveGridData(docnos);	
	     	}
	 });
}

function saveGridData(docnos){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;

		 if(parseInt(items)>0)
			 {
			 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
				$('#docnos').val('');
				dis();
		      funreload(event); 
		      
			 }
		 else
			 {
			 $.messager.alert('Message', '  Not Updated ', function(r){
			  });
			 }
			
			
	  }
	}
		
x.open("GET","saveData.jsp?docnos="+docnos,true);
x.send();
}

function typechg()
{
	 $("#invlist").jqxGrid('Clear');
	 $("#invlist").jqxGrid("addrow", null, {});
	
	
	}
function dis(){
    $("#btnaudit").attr('disabled', true); 
}

</script>
</head>
<body onload="getBranch();dis();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Fixed Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <!-- Date Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">From</td>
                            <td>
                                <div id="fromdate"
                                     value='<s:property value="fromdate"/>'>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">To</td>
                            <td>
                                <div id="todate"
                                     value='<s:property value="todate"/>'>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text"
                                       name="account"
                                       id="account"
                                       readonly
                                       placeholder="Press F3 To Search"
                                       value='<s:property value="account"/>'
                                       onkeydown="getaccountdetails(event);" />
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>
                                <input type="text"
                                       id="accname"
                                       name="accname"
                                       readonly
                                       value='<s:property value="accname"/>' />
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="type"
                                        name="type"
                                        onchange="typechg()">
                                    <option value="1">Cash Invoice</option>
                                    <option value="2">Credit Invoice</option>
                                </select>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Clear Button -->
                <button class="btn-submit"
                        type="button"
                        onclick="funcleardata();">
                    Clear
                </button>

                <!-- Audit Button -->
                <button class="btn-submit"
                        type="button"
                        onclick="funAudit(event);">
                    Audit
                </button>

                <!-- Extra Space Div -->
                <div id="paychaaaaa"
                     style="width:100%; height:150px;">
                </div>

                <!-- Hidden Fields -->
                <input type="hidden"
                       id="acno"
                       name="acno"
                       value='<s:property value="acno"/>'>

                <input type="hidden"
                       id="docnos"
                       name="docnos"
                       value='<s:property value="docnos"/>'>

                <input type="hidden"
                       id="statusselect"
                       name="statusselect"
                       value='<s:property value="statusselect"/>'>

            </div>
        </div>
    </div>
</td>


<!-- ================= RIGHT GRID AREA ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="listdiv">
                    <jsp:include page="salesinvoiceauditGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

</div>

<!-- Popup -->
<div id="accountSearchwindow">
    <div></div>
</div>

</div>
</body>

</html>