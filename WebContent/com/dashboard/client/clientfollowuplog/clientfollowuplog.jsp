
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
<style>

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
	
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	  
	$("#cmbbranch").attr('hidden',true); 
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
	 
	 $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
	 
});

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
	

var fromdate= $("#fromdate").val();
var todate= $("#todate").val(); 
var cldocno=$("#cldocno").val();
var test ="10"; 

$("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate+"&cldocno="+cldocno+'&check=1');



  //$("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+'&check=1');
 }

	
	}
	
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	//$('#gridlength').val(""); 
}

function getclinfo(event){
	 var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
	else{}
} 

function clientSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('setContent', data);
}); 
} 
	
function funExportBtn(){
	   /* JSONToCSVConvertor(clientexceldata, 'Client Followup Log List', true); */
	$("#fleetdiv").excelexportjs({
		containerid: "fleetdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxFleetGrid", 
		columns: getColumns("jqxFleetGrid") , 
		worksheetName:"Client Followup Log List"
		});
	   }
	 
	  function  funcleardata()
	  {
		  $("#userdetails").jqxGrid('clear');
		    $("#userdetails").jqxGrid('addrow', null, {});
	  	document.getElementById("cldocno").value="";
	    	document.getElementById("clientname").value="";
	   	
	  	
	  	 if (document.getElementById("clientname").value == "") {
	  			
	  		 
	  	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	  	    }
	  		  		
	  	}

	  function  funPrint()
	  {
		 var client=$('#clientname').val();
		  if(client==''){
				 $.messager.alert('Message','Please Select a Client.','warning');
				 return 0;
			 }
	   			
		 	    if ($("#cldocno").val()!="") {
			        var url=document.URL;
			        var reurl=url.split("clientfollowuplog.jsp");
			        var win= window.open(reurl[0]+"printclientfollowup?&cldocno="+document.getElementById("cldocno").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
			     }
			    else {
					$.messager.alert('Message','Please Select a Client.','warning');
					return;
				}
			   }
	  
	
	 
</script>
</head>
<body onload="getBranch();hiddenbrh()">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

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

                <div class="filter-card">
                    <table class="filter-table">

                        <!-- From Date -->
                        <tr>
                            <td class="label-cell">From</td>
                            <td>
                                <div id="fromdate"
                                     name="fromdate"
                                     value='<s:property value="fromdate"/>'>
                                </div>
                            </td>
                        </tr>

                        <!-- To Date -->
                        <tr>
                            <td class="label-cell">To</td>
                            <td>
                                <div id="todate"
                                     name="todate"
                                     value='<s:property value="todate"/>'>
                                </div>
                            </td>
                        </tr>

                        <!-- Client -->
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text"
                                       name="clientname"
                                       id="clientname"
                                       placeholder="Press F3 To Search"
                                       readonly
                                       onkeydown="getclinfo(event);"
                                       value='<s:property value="clientname"/>' />
                            </td>
                        </tr>

                        <!-- Sub Grid -->
                        <tr>
                            <td colspan="2">
                                <div id="Readygrid">
                                    <jsp:include page="subgrid.jsp"></jsp:include>
                                </div>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Buttons -->
                <button class="btn-submit"
                        type="button"
                        onclick="funcleardata();">
                    Clear
                </button>

                <button class="btn-submit"
                        type="button"
                        onclick="funPrint();">
                    Print
                </button>

                <!-- Hidden Field -->
                <input type="hidden"
                       name="cldocno"
                       id="cldocno"
                       value='<s:property value="cldocno"/>' />

            </div>
        </div>
    </div>
</td>


<!-- ================= RIGHT GRID AREA ================= -->
<td width="80%">

    <div>
        <table width="100%" id="grid1">
            <tr>
                <td>
                    <label name="user" id="user"></label>
                </td>
            </tr>

            <tr>
                <td>
                    <div id="fleetdiv">
                        <jsp:include page="detailsgrid.jsp"></jsp:include>
                    </div>
                </td>
            </tr>
        </table>
    </div>

</td>

</tr>
</table>

</div>

<div id="clientwindow">
    <div></div>
</div>

</div>

</body>
</html>
