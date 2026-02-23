<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
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
    height: 28px !important;  
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

	     $('#txtclientname').dblclick(function(){
	    	 
			  accountsSearchContent('clientAccountDetailsSearch.jsp');
		 });
	     
	     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
     $("#fromdate").jqxDateTimeInput({ width: '109px', height: '22px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '109px', height: '22px',formatString:"dd.MM.yyyy"});
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
	 
	 
	 
	   
	  
});

function funExportBtn(){   
	$("#loadgriddata").excelexportjs({
		containerid: "loadgriddata", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxloaddataGrid", 
		columns: getColumns("jqxloaddataGrid") , 
		worksheetName:"Job Wise Division1"
		});
	$("#subgriddata").excelexportjs({
		containerid: "subgriddata", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxsubdivGrid", 
		columns: getColumns("jqxsubdivGrid") ,        
		worksheetName:"Job Wise Division2"   
		});
	   }

function funreload(event){
	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	   if(fromdates>todates){
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   return false;
	  }
		   var barchval = document.getElementById("cmbbranch").value;
	 var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var rds=$('#ctype').val();
	 var clientid=$('#txtclientaccountdocno').val();   
	 
	 $("#overlay, #PleaseWait").show();
	 $("#loadgriddata").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&rds="+rds+"&clientid="+clientid+"&id="+1);
	}

function getClientAccount(event){
	var rds=$('#ctype').val();
	if(rds=='ALL'){
		
	}
    var x= event.keyCode;
    if(x==114){
  	  accountsSearchContent('clientAccountDetailsSearch.jsp');
    }
    else{}
    }
function accountsSearchContent(url) {
	
 $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}
		function  funClearData(){
			 $('#txtclientname').val('');
			 $('#txtclientaccountdocno').val('');
			 $('#acno').val('');
			 $('#trno').val('');
			 $('#jqxloaddataGrid').jqxGrid('clear');
			 $('#jqxsubdivGrid').jqxGrid('clear');
			 $('#txtclientname').val('Press F3 To Search');
		}
		function funUpdate(){        
			var rows = $("#jqxsubdivGrid").jqxGrid('getrows');

			var selectedrows=$("#jqxsubdivGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});

			if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select documents.');
			return false;
			}
			
			$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			if(r==false)
			{
			return false; 
			}
			else
			{
			$("#overlay, #PleaseWait").show();

			var i=0;
			var temptrno="",temptrno1="";               
			var j=0;
			for (i = 0; i < selectedrows.length; i++) {   
			if(i==0){
			var srvdetmtrno= $('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no")+"###"+$('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "budget");
			temptrno=srvdetmtrno;
			}
			else{
			var srvdetmtrno= $('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "doc_no")+"###"+$('#jqxsubdivGrid').jqxGrid('getcellvalue', selectedrows[i], "budget");             
			temptrno=temptrno+","+srvdetmtrno;        
			}
			temptrno1=temptrno+",";
			j++; 
			
			}
			$('#trno').val(temptrno1);   

			subgriddata($('#trno').val());	          
			}
			});
			}      
		function subgriddata(trno){    
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
		 if (x.readyState==4 && x.status==200)
		  {
		   var items=x.responseText;
		    if(parseInt(items)>=1)
		     {
		      $.messager.alert('Message', ' Successfully Saved ');
		      $("#jqxsubdivGrid").jqxGrid('clear');    
			  $('#trno').val("");   
			  funreload(event); 
		}    
		else
		{
		$.messager.alert('Message', ' Not Saved ');  
		}
		} 
		}  
		x.open("GET","subData.jsp?trno="+encodeURIComponent(trno)+"&docno="+$("#docno").val(),true);
		x.send();     
		}		
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- LEFT SIDEBAR -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- Fixed Top (Heading) -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- Scrollable Filter Area -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
            <table class="filter-table">

                <tr>
                    <td class="label-cell">From</td>
                    <td>
                        <div id="fromdate" name="fromdate"
                             value='<s:property value="fromdate"/>'></div>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">To</td>
                    <td>
                        <div id="todate" name="todate"
                             value='<s:property value="todate"/>'></div>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="ctype" name="ctype" onchange="funundesable();">
                            <option value="ALL">ALL</option>
                            <option value="AMC">AMC</option>
                            <option value="SJOB">SJOB</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Client</td>
                    <td>
                        <input type="text"
                               id="txtclientname"
                               name="txtclientname"
                               placeholder="Press F3 to Search"
                               readonly="readonly"
                               value='<s:property value="txtclientname"/>'
                               onkeydown="getClientAccount(event);" />
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input type="hidden"
                               id="txtclientaccountdocno"
                               name="txtclientaccountdocno"
                               value='<s:property value="txtclientaccountdocno"/>' />
                    </td>
                </tr>

            </table>
        </div>

        <!-- Buttons -->
        <button class="btn-submit"
                type="button"
                id="btnupdate"
                onclick="funUpdate();">
            Update
        </button>

        <button class="btn-submit"
                type="button"
                onclick="funClearData();">
            Clear
        </button>

    </div>

</div>
</div>

<input type="hidden" id="docno" name="docno"
       value='<s:property value="docno"/>'>

</td>

<!-- RIGHT GRID AREA -->
<td width="80%" valign="top">

    <table width="100%">
        <tr>
            <td>
                <div id="loadgriddata">
                    <jsp:include page="gridDetails.jsp"></jsp:include>
                </div>
            </td>
        </tr>

        <tr>
            <td>
                <div id="subgriddata">
                    <jsp:include page="subdivisionGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>

<!-- Popup -->
<div id="accountDetailsWindow">
    <div></div>
</div>

</div>
</body>
</html>