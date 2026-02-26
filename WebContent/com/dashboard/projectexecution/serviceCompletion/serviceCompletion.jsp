
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

<style>
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
	
	   //$("test").hide();
	   
	   $("#test").hide();
	 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     
     document.getElementById("rdp").checked="true";
     document.getElementById("isradio").value=1;
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
    
	  
});


function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
     function clientSearchContent(url) {
           
               $.get(url).done(function (data) {
  
	           $('#clientsearch1').jqxWindow('setContent', data);

    	}); 
         	}
	
	   
	   function funClear(){
		    $("#jqxpinvGrid").jqxGrid('clear');
		    $("#jqxInvCount").jqxGrid('clear');
		    $("#jqxpsrvDetGrid").jqxGrid('clear');
			$("#jqxpinvDetGrid").jqxGrid('clear'); 
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
	   }
	   
	   function setValues(){

			 if($('#msg').val()!=""){
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
		}
	   
	   
	   function funreload()
	   {

	   	 var clientid=$('#clientid').val();
	   	 var date=$('#todate').val();
	   	 var barchval = document.getElementById("cmbbranch").value;
	        var dtype="0";
	        var id=1;
	        hidcolumn(0);
			$("#test").hide();
				
			var isradio=document.getElementById("isradio").value;
			
			if(!(isradio==1 || isradio==2 )){
				 $.messager.alert('Message','Select Report Type');
				 return 0;
			}
			
	       if(id>0){
	       	countload(id);
	       }
	        
	   	}
	   
		 function countload(id){
			 
			 var clientid=$('#clientid').val();
			 var date=$('#todate').val();
			 var barchval = document.getElementById("cmbbranch").value;
			 var isradio =document.getElementById("isradio").value;
			 
			    $("#jqxpinvGrid").jqxGrid('clear'); 
				$("#jqxpinvDetGrid").jqxGrid('clear');
				$("#jqxpsrvDetGrid").jqxGrid('clear'); 
				
				   $("#jqxpinvGrid").jqxGrid('addrow', null, {});
				   $("#overlay, #PleaseWait").show();
				   $("#invCountgrid").load("invCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isradio="+isradio);

		 }
		 function getProcess() {
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('####');
						
						var srno  = items[0].split(",");
						var process = items[1].split(",");
						var optionsbranch = '<option value="" selected>-- Select -- </option>';
						for (var i = 0; i < process.length; i++) {
							optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
									+ process[i] + '</option>';
						}
						$("select#cmbprocess").html(optionsbranch);
						
					} else {}
				}
				x.open("GET","getProcess.jsp", true);
				x.send();
			}
		 
		 function funNotify(){
				
			 var dtype=$('#dtype').val();
		     var trno=$('#trno').val();
		     var docno=$('#docno').val();
		     var brch=$('#brch').val();
		     var prtype=$('#cmbpaytype').val();
		     
			saveGridData(dtype,trno,docno,brch,prtype);
		}

		 function saveGridData(dtype,trno,docno,brch,prtype){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();
						if(parseInt(items)=="1")
						{
						$.messager.alert('Message', ' '+dtype+ ' - '+docno+' completed Successfully ');
						
						$('#dtype').val('');
            		     $('#trno').val('');
            		     $('#docno').val('');
            		     $('#brch').val('');
						 
						}
						else
							{
							$.messager.alert('Message', '  Not Updated  ');
							}
						
				  }
				}
			
					
			x.open("GET","saveData.jsp?docno="+docno+"&dtype="+dtype+"&process="+prtype+"&trnos="+trno+"&brhid="+brch,true);
			x.send();
	}	
		 
		 
		 function hidcolumn(iserv){
			 
			 if(iserv>0){
			    	$('#jqxpsrvDetGrid').jqxGrid('showcolumn','amt');
			    	$('#jqxpsrvDetGrid').jqxGrid('showcolumn','invno');
			    }
			    else{
			    	$('#jqxpsrvDetGrid').jqxGrid('hidecolumn','amt');
			    	$('#jqxpsrvDetGrid').jqxGrid('hidecolumn','invno');
			    }
			 
		 }
		 
		 function workper(){
			 var rowlen = $("#jqxpsrvDetGrid").jqxGrid('getrows');
        	 if(rowlen.length>0){
     
        	 var aid=0;
        	 var workper=0;
        	 for(var i=0 ; i < rowlen.length; i++){
        		 
        		 workper =parseFloat(workper) + parseFloat($('#jqxpsrvDetGrid').jqxGrid('getcellvalue', i, "workper"));
        	
       
      		}
        	 aid=workper/rowlen.length;
        	 if(aid==100){
        		 $("#test").show();
        	 }
        	 else{
        		 $("#test").hide();
        	 }
       
		 }
        	 
		 } 	 
		 
		 function stacheck(){
			 
			 if(document.getElementById("rdp").checked==true){
				 
				 document.getElementById("isradio").value=1;
			 }
			 if(document.getElementById("rdc").checked==true){
				 
				 document.getElementById("isradio").value=2;
			 }
			
		 }
		 
		 function funExportBtn(){    
			$("#profinvdiv").excelexportjs({    
				containerid: "profinvdiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxpinvGrid", 
				columns: getColumns("jqxpinvGrid") ,       
				worksheetName:"Contract Status Check"
			});
		}	       
		 
	     /*function funExportBtn(){
				JSONToCSVCon(perdata1,'Contract Status Check',true);
		  	   JSONToCSVCon(perdata2,'Contract Status Check',true);
		  	   JSONToCSVCon(perdata3,'Contract Status Check',true); 
		  }*/
		  
</script>
</head>
<body onload="getBranch();setValues();">

<form id="frmdinvoice" action="savedInvoice" method="post">

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

<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Upto Date</td>
<td>
    <div id="todate"
         value='<s:property value="todate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">Client</td>
<td>
    <div style="display:flex; gap:6px;">
        <input type="text"
               id="txtclient"
               name="txtclient"
               class="filter-input"
               value='<s:property value="txtclient"/>'
               onkeydown="getclinfo(event);"
               readonly
               placeholder="Press F3 to Search">
        <button type="button"
                class="bicon"
                onclick="funClear()">
            <img src="<%=contextPath%>/icons/clear.png">
        </button>
    </div>
    <input type="hidden" id="clientid"
           name="clientid"
           value='<s:property value="clientid"/>'>
</td>
</tr>

<tr>
<td class="label-cell">Status</td>
<td>
    <label>
        <input type="radio"
               id="rdp"
               name="rd"
               value="rdp"
               onclick="stacheck();">
        Progress
    </label>
    &nbsp;&nbsp;
    <label>
        <input type="radio"
               id="rdc"
               name="rd"
               value="rdc"
               onclick="stacheck();">
        Completed
    </label>
</td>
</tr>

</table>
</div>

<!-- Count Grid -->
<div class="filter-card">
<div id="invCountgrid">
    <jsp:include page="invCountgrid.jsp"></jsp:include>
</div>
</div>

<!-- Process Section -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Process</td>
<td>
    <select id="cmbpaytype"
            name="cmbpaytype"
            class="filter-input">
        <option value="3">Complete</option>
    </select>
</td>
</tr>

</table>
</div>

<!-- Update Button -->
<div class="button-group">
    <button type="button"
            class="btn-submit"
            id="btncmplete"
            onclick="funNotify();">
        Update
    </button>
</div>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT SIDE ================= -->
<td width="80%" valign="top">

<div class="grid-container">

<div class="filter-card">
    <div id="profinvdiv">
        <jsp:include page="serviceCompletionGrid.jsp"></jsp:include>
    </div>
</div>

<div style="display:flex; gap:15px;">
    <div style="flex:1;">
        <div id="profserdetdiv">
            <jsp:include page="serviceDetGrid.jsp"></jsp:include>
        </div>
    </div>
    <div style="flex:1;">
        <div id="profinvdetdiv">
            <jsp:include page="invDetGrid.jsp"></jsp:include>
        </div>
    </div>
</div>

</div>

</td>

</tr>
</table>

</div>

<!-- Popup -->
<div id="clientsearch1"><div></div></div>

<!-- Hidden Fields -->
<input type="hidden" name="invgridlength" id="invgridlength"
       value='<s:property value="invgridlength"/>'>
<input type="hidden" name="mode" id="mode"
       value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg"
       value='<s:property value="msg"/>'>
<input type="hidden" name="formcode" id="formcode"
       value='<s:property value="formcode"/>'>
<input type="hidden" name="ptype" id="ptype"
       value='<s:property value="ptype"/>'>
<input type="hidden" name="dtype" id="dtype"
       value='<s:property value="dtype"/>'>
<input type="hidden" name="trno" id="trno"
       value='<s:property value="trno"/>'>
<input type="hidden" name="docno" id="docno"
       value='<s:property value="docno"/>'>
<input type="hidden" name="brch" id="brch"
       value='<s:property value="brch"/>'>
<input type="hidden" name="isradio" id="isradio"
       value='<s:property value="isradio"/>'>

</div>
</form>
</body>
</html>