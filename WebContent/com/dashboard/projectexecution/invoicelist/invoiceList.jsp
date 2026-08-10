
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
	 
	 $("#frmdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	

	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#frmdate').jqxDateTimeInput('setDate',onemounth);
     
	 
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
     
     $('#contractwindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#contractwindow').jqxWindow('close');
	  
	  
	  $('#txtcontract').dblclick(function(){
	  	    $('#contractwindow').jqxWindow('open');
	   
	  	//  contractSearchContent('contractMastersearch.jsp');
	  	  contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
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

     function funExportBtn(){
 		
	  	   //JSONToCSVCon(invoicelistexcel,'Invoice List',true);
		   $("#profinvdiv").excelexportjs({  
    			containerid: "profinvdiv", 
    			datatype: 'json', 
    			dataset: null, 
    			gridId: "jqxpinvGrid", 
    			columns: getColumns("jqxpinvGrid") , 
    			worksheetName:"Invoice List"
    			});
	  }

/* function funreload()
{

	 var clientid=$('#clientid').val();
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
    var id=1;
	 $("#profinvdiv").load("invoiceprocessingGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id);
} */
	
	
	   
	   function funClear(){
		   
		   $("#jqxpinvGrid").jqxGrid('clear'); 
			$("#jqxInvCount").jqxGrid('clear');
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   
		   document.getElementById("txtcontract").value="";
		   $("#txtcontract").attr("placeholder", "press F3 for Search");
		   
	   }
	   
	   
	   function funreload()
	   {

	   	 var clientid=$('#clientid').val();
	   	 var date=$('#todate').val();
	   	 var barchval = document.getElementById("cmbbranch").value;
	     	
	        var dtype="0";
	        var id=1;
			
	       if(id>0){
	       	countload(id);
	       }
	        
	   	}
	   
		 function countload(id){
			 
			 var clientid=$('#clientid').val();
			 var date=$('#todate').val();
			 var frmdate=$('#frmdate').val();
			 var barchval = document.getElementById("cmbbranch").value;
			 var contract=document.getElementById("txtcontract").value;
			 
			    $("#jqxpinvGrid").jqxGrid('clear'); 
				$("#jqxInvCount").jqxGrid('clear');
				
				
				 $("#invCountgrid").load("invCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&contract="+contract+"&frmdate="+frmdate);
			
			
			 
		 }
		 
		 function getcontract(event){

				var x= event.keyCode;
			 	 if(x==114){
			 		 $('#contractwindow').jqxWindow('open');
			 		// changeContent('contractMastersearch.jsp');  
			 		 contractSearchContent('contractMastersearch.jsp?', $('#contractwindow'));
			    	 }
			 	 else{
			 		 
			 		 }
			 	 }
			    	 
			function contractSearchContent(url) {
				 $.get(url).done(function (data) {
				$('#contractwindow').jqxWindow('setContent', data);
			           	}); 
			 	}
		
 function gettaxconfig(){
					
				 document.getElementById("hidtaxconfig").value=0; 
						var x=new XMLHttpRequest();
						x.onreadystatechange=function(){
						if (x.readyState==4 && x.status==200)
							{
							 	var res= x.responseText;
							 	if(res>0){
							 		
							 		document.getElementById("hidtaxconfig").value=1; 
									  }
								}
						       else
							  {}
					     }
					      x.open("GET",'taxconfig.jsp',true);
					     x.send();
					    
					   } 
	
</script>
</head>
<body onload="getBranch();gettaxconfig();">

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

<!-- ===== Scrollable Filters ===== -->
<div class="sidebar-scroll-content">

<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">From Date</td>
<td>
    <div id="frmdate"
         value='<s:property value="frmdate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">To Date</td>
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
    <input type="hidden"
           id="clientid"
           name="clientid"
           value='<s:property value="clientid"/>'>
</td>
</tr>

<tr>
<td class="label-cell">Contract No</td>
<td>
    <input type="text"
           id="txtcontract"
           name="txtcontract"
           class="filter-input"
           placeholder="Press F3 To Search"
           onkeydown="getcontract(event);"
           readonly
           value='<s:property value="txtcontract"/>'>
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

<!-- Hidden Fields -->
<input type="hidden" name="invgridlength" id="invgridlength"
       value='<s:property value="invgridlength"/>'>

<input type="hidden" name="trno" id="trno"
       value='<s:property value="trno"/>'>

<input type="hidden" name="hidtaxconfig" id="hidtaxconfig"
       value='<s:property value="hidtaxconfig"/>'>

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

</div>

</td>

</tr>
</table>

</div>

<!-- Popups -->
<div id="clientsearch1"><div></div></div>
<div id="contractwindow"><div></div></div>

</div>
</form>
</body>
</html>