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

 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#closedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
    
		function funExportBtn() {
			
			$("#loadgriddiv").excelexportjs({
						containerid: "loadgriddiv", 
						datatype: 'json', 
						dataset: null, 
						gridId: "jqxjobclosegrid", 
						columns: getColumns("jqxjobclosegrid") ,   
						worksheetName:"Job Close"
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
	 	 
	   var rds;
	   
	 
		
		 if (document.getElementById('radio_tobeclose').checked) {
				
			 rds=$("#radio_tobeclose").val();
			
			} 
		 else{
			 rds=$("#radio_closedlist").val();
		 }
		   var barchval = document.getElementById("cmbbranch").value;
		   var fromdate= $("#fromdate").val();
		   var todate= $("#todate").val();
		  
			
		   $("#overlay, #PleaseWait").show();
			
		   $("#loadgriddiv").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&rds="+rds+"&check=1");
		  
		  
	  
	}


function  funClearData(){
	 $('#remarks').val('');
	 $('#info').val('');
	 $('#doc').val('');
	 $('#dtyp').val('');
	 $('#trno').val('');
	
	 $('#jqxjobclosegrid').jqxGrid('clear');
	
	
	
}	

function funUpdate(event){
	
	var rdocno = $('#doc').val();
	var rdtype = $('#dtyp').val();
	var remarks = $('#remarks').val();
	var txtareainfo= $('#info').val();
	var trnos = $('#trno').val();
	var closedate = $('#closedate').val();
	
		if(txtareainfo==''){
		 $.messager.alert('Message','Please Choose a Document.','warning');
		 return 0;
	 }
	
	
	    $.messager.confirm('Message', 'Do you want to Close the job?', function(r){
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		saveGridData(rdocno,rdtype,remarks,trnos,closedate);
	     	}
	 });
}

function saveGridData(rdocno,rdtype,remarks,trnos,closedate){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim();
			if(parseInt(items)=="1")
			{
			$.messager.alert('Message', ' '+$('#dtyp').val()+ '-'+$('#doc').val()+' Closed Successfully ');
			$('#remarks').val('');
			 $('#info').val('');
			 $('#doc').val('');
			 $('#dtyp').val('');
			 $('#trno').val('');
			 $('#jqxjobclosegrid').jqxGrid('clear');
			}
			else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
			
	  }
	}
		
x.open("GET","saveData.jsp?docno="+rdocno+"&dtype="+rdtype+"&remarks="+remarks+"&trnos="+trnos+"&closedate="+closedate,true);
x.send();
}
function funRadio()
{
	 var rad;
		
	 if (document.getElementById('radio_tobeclose').checked) {
			
		 rad=$("#radio_tobeclose").val();
		 $('#info').val('');
			$('#remarks').val('');
		 $('#closedate').jqxDateTimeInput({ disabled: false});
		 $('#info').attr("disabled",false);
		 $('#remarks').attr("disabled",false);
		 $('#clear').attr("disabled",false);
		 $('#btnupdate').attr("disabled",false);
		 $("#jqxjobclosegrid").jqxGrid('clear');
		  
		} 
	 else{
		 rad=$("#radio_closedlist").val();
		 $('#info').val('');
			$('#remarks').val('');
			 $('#closedate').jqxDateTimeInput({ disabled: true});
		 $('#info').attr("disabled",true);
		 $('#remarks').attr("disabled",true);
		 $('#clear').attr("disabled",true);
		 $('#btnupdate').attr("disabled",true);
		 $("#jqxjobclosegrid").jqxGrid('clear');
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
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

<!-- ===== Fixed Header ===== -->
<div class="sidebar-fixed-top">
    <div class="filter-card">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>
</div>

<!-- ===== Scrollable Section ===== -->
<div class="sidebar-scroll-content">

    <!-- Date Filters -->
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
                <td class="label-cell">Category</td>
                <td class="radio-row">
                    <label>
                        <input type="radio"
                               id="radio_tobeclose"
                               name="category"
                               value="TC"
                               onclick="funRadio(this);"
                               checked> To Be Closed
                    </label>

                    <label>
                        <input type="radio"
                               id="radio_closedlist"
                               name="category"
                               value="CL"
                               onclick="funRadio(this);"> Closed List
                    </label>
                </td>
            </tr>

        </table>
    </div>

    <!-- Close Details -->
    <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Close On</td>
                <td>
                    <div id="closedate"
                         value='<s:property value="closedate"/>'></div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Info</td>
                <td>
                    <textarea id="info"
                              name="info"
                              class="filter-input"
                              style="height:80px; resize:none;"
                              readonly>
<s:property value="info"/>
                    </textarea>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Remarks</td>
                <td>
                    <input type="text"
                           id="remarks"
                           name="remarks"
                           class="filter-input"
                           value='<s:property value="remarks"/>'>
                </td>
            </tr>

        </table>
    </div>

    <!-- Buttons -->
    <div class="button-group">

        <button type="button"
                class="btn-submit"
                onclick="funClearData();">
            Clear
        </button>

        <button type="button"
                class="btn-submit"
                onclick="funUpdate(event);">
            Update
        </button>

    </div>

    <!-- Hidden Fields -->
    <input type="hidden" id="doc" name="doc"
           value='<s:property value="doc"/>'>

    <input type="hidden" id="dtyp" name="dtyp"
           value='<s:property value="dtyp"/>'>

    <input type="hidden" id="trno" name="trno"
           value='<s:property value="trno"/>'>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%" valign="top">

<div class="grid-container">
    <div class="filter-card">
        <div id="loadgriddiv">
            <jsp:include page="gridDetails.jsp"></jsp:include>
        </div>
    </div>
</div>

</td>

</tr>
</table>

</div>
</div>
</body>
</html>