   
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

$(document).ready(function () {
	$('#stockLedgerDiv').show();
	 $('#stockLedgerDetDiv').hide();
	 document.getElementById('rsumm').checked=true;
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


 
	/*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	 
	  */
	 
		 $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#productDetailsWindow').jqxWindow('close');
		 
		 $('#txtpartno').dblclick(function(){
			 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
		 }); 
});

function funExportBtn(){
	if (document.getElementById('rsumm').checked) {
	 //  $("#stocklistgrid").jqxGrid('exportdata', 'xls', 'Strock List');
	 
	        $("#stockLedgerDiv").excelexportjs({
			containerid: "stockLedgerDiv",   
			datatype: 'json',
			dataset: null,
			gridId: "stocklistgrid",
			columns: getColumns("stocklistgrid") ,   
			worksheetName:"Stock List Summary"  
		});
	   
	   
	}
	 else if (document.getElementById('rdet').checked) {
		 
			//$("#stocklistgriddet").jqxGrid('exportdata', 'xls', 'Strock List');
			
		 $("#stockLedgerDetDiv").excelexportjs({
				containerid: "stockLedgerDetDiv",   
				datatype: 'json',
				dataset: null,
				gridId: "stocklistgriddet",
				columns: getColumns("stocklistgriddet") ,   
				worksheetName:"Stock List Detail"  
			});			
			
		}
	 }

function productSearchContent(url) {
    $('#productDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#productDetailsWindow').jqxWindow('setContent', data);
	$('#productDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getProduct(){
	
	 $('#productDetailsWindow').jqxWindow('open');
		$('#productDetailsWindow').jqxWindow('focus');
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));

}
function funreload(event)
{

	 /*  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   { */
	 var barchval = document.getElementById("cmbbranch").value;
     
	 var statusselect=$("#statusselect").val();
	 
	 var psrno=$("#psrno").val();
	 
 
   
		if (document.getElementById('rsumm').checked) {
			
			   
			  
			  $("#overlay, #PleaseWait").show();
			  var load="yes";
			  $("#stockLedgerDiv").load("stockGridSummary.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&load="+load);
		}
		 else if (document.getElementById('rdet').checked) {
			 
			   $("#overlay, #PleaseWait").show();
			   var load="yes";
				  $("#stockLedgerDetDiv").load("stockGridDetail.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&load="+load);
			 
			}  
	  
	}

function  funcleardata()
{
	// txtpartno  psrno   txtproductname   Press F3 to Search;
	 
	 document.getElementById('txtpartno').value="";
	 document.getElementById('txtproductname').value="";
	 document.getElementById('psrno').value="";
	 document.getElementById('rsumm').checked=true;
 
	 document.getElementById("cmbbranch").value="a";
	 
	 $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
	}
	
function fundisable(){
	

	
	if (document.getElementById('rsumm').checked) {
		
		  $('#stockLedgerDiv').show();
		   $('#stockLedgerDetDiv').hide();
		  
		}
	 else if (document.getElementById('rdet').checked) {
		 
		  $('#stockLedgerDiv').hide();
		  $('#stockLedgerDetDiv').show();
		 
		}
	 }

</script>
</head>
<body onload="getBranch();">

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

                <!-- Summary / Detail Toggle -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <input type="radio"
                                       id="rsumm"
                                       name="stkled"
                                       value="rsumm"
                                       onchange="fundisable();">
                                <label for="rsumm">Summary</label>

                                &nbsp;&nbsp;

                                <input type="radio"
                                       id="rdet"
                                       name="stkled"
                                       value="rdet"
                                       onchange="fundisable();">
                                <label for="rdet">Detail</label>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Product Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Product</td>
                            <td>
                                <input type="text"
                                       id="txtpartno"
                                       name="txtpartno"
                                       readonly
                                       placeholder="Press F3 to Search"
                                       onkeydown="getProduct(event);"
                                       value='<s:property value="txtpartno"/>'/>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>
                                <input type="text"
                                       id="txtproductname"
                                       name="txtproductname"
                                       readonly
                                       tabindex="-1"
                                       value='<s:property value="txtproductname"/>'/>
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

                <!-- Hidden Fields -->
                <input type="hidden"
                       id="psrno"
                       name="psrno"
                       value='<s:property value="psrno"/>' />

                <input type="hidden"
                       id="statusselect"
                       name="statusselect"
                       value='<s:property value="statusselect"/>' />

                <input type="hidden"
                       id="acno"
                       name="acno"
                       value='<s:property value="acno"/>' />

            </div>
        </div>
    </div>
</td>


<!-- ================= RIGHT GRID AREA ================= -->
<td width="80%">
    <table width="100%">

        <tr>
            <td>
                <div id="stockLedgerDiv">
                    <jsp:include page="stockGridSummary.jsp"></jsp:include>
                </div>
            </td>
        </tr>

        <tr>
            <td>
                <div id="stockLedgerDetDiv">
                    <jsp:include page="stockGridDetail.jsp"></jsp:include>
                </div>
            </td>
        </tr>

    </table>
</td>

</tr>
</table>

</div>

<!-- Popup -->
<div id="productDetailsWindow">
    <div></div>
    <div></div>
</div>

</div>
</body>
</html>