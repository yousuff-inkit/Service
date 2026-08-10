
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

	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#invdate').jqxDateTimeInput('setDate', "");
    
	  $('#invdate').on('change', function (event) {
			
		   var invdate=new Date($('#invdate').jqxDateTimeInput('getDate'));
		   var curdate=new Date(); 
		   invdate.setHours(0,0,0,0);
		   curdate.setHours(0,0,0,0);
		   if(invdate>curdate){
			   
			   $.messager.alert('Message','Future Date Not Allowed','warning');   
			   $('#invdate').jqxDateTimeInput('setDate', new Date());
			 
		   return false;
		  }   
	 });
	 
	 
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

     function funExportBtn(){
       
  	   JSONToCSVCon(perdata,'ProformaInvoice',true);
  	 
      }



function funreload()
{

	 var clientid=$('#clientid').val();
	 
	 
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
    var id=1;
	 $("#profinvdiv").load("proformaInvoiceGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id);
	}
	
	
	
function funNotify(){
	
	 var invdate=$('#invdate').val();
	 
	 if(invdate==""){
		 $.messager.alert('Warning','Invoice Date is Madatory');
		 return false;
	 }
	
	var z=0;
			    var rows = $("#jqxproinvGrid").jqxGrid('getrows');                    
	if(rows.length>0 && (rows[0].tr_no=="undefined" || rows[0].tr_no==null || rows[0].tr_no=="")){
		return false;
	}
			    var selectedRecords = new Array();
                var selectedrows=$("#jqxproinvGrid").jqxGrid('selectedrowindexes');
    
	if(selectedrows.length==0){
		$.messager.alert('Warning','Select a document');
		return false;
	}
	   $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
 			if (r){
 				
 				var i=0;
                $('#invgridlength').val(selectedrows.length);
			    for (i = 0; i < rows.length; i++) {
					for(var j=0;j<selectedrows.length;j++){
						if(selectedrows[j]==i){
							
							//alert("Inside"+z);
							//selectedRecords[j]=$("#rentalInvoiceGrid").jqxGrid('getrowdata', selectedrows[j]);
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "prinv"+z)
						    .attr("name", "prinv"+z)
						    .attr("hidden","true");
							
						newTextBox.val(rows[i].tr_no+"::"+rows[i].doc_no+"::"+rows[i].dtype+"::"+rows[i].refdtype+"::"+rows[i].sdate
								+"::"+rows[i].edate+"::"+rows[i].cval+"::"+rows[i].duedate+"::"+rows[i].lfee+"::"+rows[i].clientid
								+"::"+rows[i].cpersonid+"::"+rows[i].brch+"::"+rows[i].clacno+"::"+rows[i].client);
						
						newTextBox.appendTo('form');
						z++;
						//alert("ddddd"+$("#testinvoice"+z).val());
						}
					}
					if(i==rows.length-1){
						
						 document.getElementById("mode").value="A";
						  document.getElementById("formcode").value="PINV";
						 
						 $("#overlay, #PleaseWait").show();
						 document.getElementById("frmprofinvoice").submit();
					}
		}
			 
		 			}
		 	 		});
	
}
	   
	   function funClear(){
			$("#jqxproinvGrid").jqxGrid('clear'); 
			$("#jqxproinvGrid").jqxGrid('addrow', null, {});
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
  document.getElementById("txtdesc").value="";
	   }
	   
	   function setValues(){

			 if($('#msg').val()!=""){
 document.getElementById("txtclient").value="";
				   document.getElementById("clientid").value="0";
				   $("#txtclient").attr("placeholder", "press F3 for Search");
				 document.getElementById("txtdesc").value="";
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
		}
	
	
</script>
</head>
<body onload="getBranch();setValues();">

<form id="frmprofinvoice" action="saveproformaInvoice" method="post">

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
                <td class="label-cell">Upto Date</td>
                <td>
                    <div id="todate"
                         value='<s:property value="todate"/>'></div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Client</td>
                <td style="display:flex; gap:5px;">
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
                            title="Clear"
                            onclick="funClear();">
                        <img alt="clear"
                             src="<%=contextPath%>/icons/clear.png">
                    </button>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Inv Date</td>
                <td>
                    <div id="invdate"
                         value='<s:property value="invdate"/>'></div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Description</td>
                <td>
                    <input type="text"
                           id="txtdesc"
                           name="txtdesc"
                           class="filter-input"
                           value='<s:property value="txtdesc"/>'>
                </td>
            </tr>

        </table>
    </div>

    <!-- ===== Button Section ===== -->
    <div class="button-group">
        <button type="button"
                class="btn-submit"
                id="btninvoicesave"
                onclick="funNotify();">
            Generate
        </button>
    </div>

    <!-- Hidden Field -->
    <input type="hidden" id="clientid"
           name="clientid"
           value='<s:property value="clientid"/>'/>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT SIDE ================= -->
<td width="80%" valign="top">

<div class="grid-container">
    <div class="filter-card">
        <div id="profinvdiv">
            <jsp:include page="proformaInvoiceGrid.jsp"></jsp:include>
        </div>
    </div>
</div>

</td>

</tr>
</table>

</div>

<!-- ================= POPUP ================= -->
<div id="clientsearch1">
    <div></div>
</div>

<!-- Hidden Fields -->
<input type="hidden" name="invgridlength" id="invgridlength"
       value='<s:property value="invgridlength"/>'>

<input type="hidden" name="mode" id="mode"
       value='<s:property value="mode"/>'>

<input type="hidden" name="msg" id="msg"
       value='<s:property value="msg"/>'>

<input type="hidden" name="formcode" id="formcode"
       value='<s:property value="formcode"/>'>

</div>
</form>
</body>
</html>