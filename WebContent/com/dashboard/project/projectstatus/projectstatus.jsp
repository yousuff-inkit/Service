
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
</style>

<script type="text/javascript">

$(document).ready(function () {

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

/* 
	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
 */	
 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
	 $('#clientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#clientsearch').jqxWindow('close');  
	  $('#assigngrpwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#assigngrpwindow').jqxWindow('close'); 
	 
	 
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
	 
	 $('#client_name').dblclick(function(){
		   	
		   	 $('#clientsearch').jqxWindow('open');
			 clientSearchContent('clientSearch.jsp?', $('#clientsearch'));
		   		
		 });
	 
	 $('#txtassigngroup').dblclick(function(){
		   
		  
		   	 $('#assigngrpwindow').jqxWindow('open');
		   	assigngrpSearchContent('assignGrpSearch.jsp?', $('#assigngrpwindow'));
		   		
		 }); 
	 
	   
	  
});
function assigngrpSearchContent(url) {
    
    $.get(url).done(function (data) {

    $('#assigngrpwindow').jqxWindow('setContent', data);

}); 
}

 function getassigngrp(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch').jqxWindow('open');
	 clientSearchContent('clientSearch.jsp?', $('#clientsearch'));    }
	 else{
		 }
	 }  
     function clientSearchContent(url) {
               $.get(url).done(function (data) {
  
	           $('#clientsearch').jqxWindow('setContent', data);

    	}); 
         	} 
     
         	 $('#txtassigngroup').dblclick(function(){
      		   
     		   	if($('#mode').val()!= "view")
     		   		{
     		   	 $('#assigngrpwindow').jqxWindow('open');
     		   	assigngrpSearchContent('assignGrpSearch.jsp?', $('#assigngrpwindow'));
     		   		}
     		 });

function funExportBtn(){
    

	// JSONToCSVCon(projectstatusexcel, 'Project Status', true);

    $("#loadgriddata").excelexportjs({
			containerid: "loadgriddata",   
			datatype: 'json',
			dataset: null,
			gridId: "jqxloaddataGrid",
			columns: getColumns("jqxloaddataGrid") ,   
			worksheetName:"Project Status"  
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
	 	 
	  
		   var barchval = document.getElementById("cmbbranch").value;
	 var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var rds;
	
	 if (document.getElementById('radio_amc').checked) {
			
		 rds=$("#radio_amc").val();
		  
		} 
	 else{
		 rds=$("#radio_sjob").val();
	 }
	 var clientid=$('#clientid').val();
	 var asgngrpid=$('#assigngrpid').val();
	 $("#Countgrid").load("Countgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&rds="+rds+"&clientid="+clientid+"&asgngrpid="+asgngrpid);
	
	
	  
	}



	

	
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%" height="100%" style="table-layout:fixed;">
<tr height="100%">

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

<!-- ===== Fixed Heading ===== -->
<div class="sidebar-fixed-top">
    <div class="filter-card">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>
</div>

<!-- ===== Scrollable Section ===== -->
<div class="sidebar-scroll-content">

    <!-- Main Filters -->
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

            <tr>
                <td class="label-cell">Client</td>
                <td>
                    <input type="text"
                           id="client_name"
                           name="client_name"
                           class="filter-input"
                           placeholder="Press F3 for Search"
                           onkeydown="getclinfo(event);"
                           value='<s:property value="client_name"/>'/>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Assign Group</td>
                <td>
                    <input type="text"
                           id="txtassigngroup"
                           name="txtassigngroup"
                           class="filter-input"
                           placeholder="Press F3 for Search"
                           onkeydown="getassigngrp(event);"
                           value='<s:property value="txtassigngroup"/>'/>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Category</td>
                <td>
                    <div class="radio-row">
                        <label>
                            <input type="radio"
                                   name="category"
                                   value="AMC"
                                   checked="checked"> AMC
                        </label>

                        <label>
                            <input type="radio"
                                   name="category"
                                   value="SJOB"> SJOB
                        </label>
                    </div>
                </td>
            </tr>

        </table>
    </div>

    <!-- Count Grid Section -->
    <div class="filter-card">
        <div id="Countgrid">
            <jsp:include page="Countgrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields -->
    <input type="hidden" id="clientid" name="clientid"
           value='<s:property value="clientid"/>'/>

    <input type="hidden" id="assigngrpid" name="assigngrpid"
           value='<s:property value="assigngrpid"/>'/>

    <input type="hidden" id="acno" name="acno"
           value='<s:property value="acno"/>'/>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT SIDE ================= -->
<td width="80%" valign="top">

<div class="grid-container">

    <div class="filter-card">
        <div id="loadgriddata">
            <jsp:include page="gridDetails.jsp"></jsp:include>
        </div>
    </div>

</div>

</td>

</tr>
</table>

</div>

<!-- ================= POPUPS ================= -->
<div id="clientsearch"><div></div></div>
<div id="assigngrpwindow"><div></div></div>

</div>
</body>
</html>