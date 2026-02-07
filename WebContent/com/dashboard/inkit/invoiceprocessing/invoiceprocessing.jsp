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
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  $("body").prepend("<div id='PleaseWaitSub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");
	  $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#clientsearch1').jqxWindow('close');
	  $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	  $("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
		   funDateInPeriod(invdate); 
	 });
     $('#txtclient').dblclick(function(){
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		 });
     
     var dt = new Date();
     $('#todate').jqxDateTimeInput('setDate', new Date(dt.getFullYear(), dt.getMonth()+1, 0)); 
});
function funresetdate(){  
	var dt = $("#todate").jqxDateTimeInput('getDate');
	console.log("dt"+dt);
    $('#todate').jqxDateTimeInput('setDate', new Date(dt.getFullYear(), dt.getMonth()+1, 0)); 
}
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
	  	$("#profinvdiv").excelexportjs({
			containerid: "profinvdiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "jqxpinvGrid", 
			columns: getColumns("jqxpinvGrid") ,     
			worksheetName:"InvoiceProcessing"
			});
   }  
	
   function funNotify(){
	   console.log("IN");
	   var branch=$('#cmbbranch').val();  
	   if(branch=="a"){
			 $.messager.alert('Warning','Please select a Branch');
			 return false;
	   }
	   var todate = $("#todate").val();
	   var date = $("#invdate").val();
	   var pono = $("#txtpono").val();
	   var description = $("#txtdesc").val(); 
	   var clacno = $("#hidclacno").val();
	   var client = $("#hidrefname").val(); 
	   var clientid = $("#hidclientid").val();
	   var interstate = $("#hiddeninterstate").val();    
	   var docno = $("#hiddocno").val();   
	   if(pono=="0" || pono==""){ 
			$.messager.alert('Warning','Please enter PO No');
			return false;
		}
	   if(date=="0" || date==""){ 
			$.messager.alert('Warning','Please select Inv. Date');  
			return false;
		}
	   $('#jqxpinvGrid').jqxGrid('clearfilters', true);  
	   var rows = $("#jqxpinvGrid").jqxGrid('getrows');

		var selectedrows=$("#jqxpinvGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
			$.messager.alert('Warning','Select documents.');
			return false;
		}
		
		$.messager.confirm('Message', 'Do you want to Generate Invoice?', function(r){  
		if(r==false) {
			return false; 
		} else {
			$("#overlay, #PleaseWait").show();
			var i=0;  
			var gridarray=new Array();   
			for (i = 0; i < selectedrows.length; i++) {              
				gridarray.push(i+" :: "+description+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'invtotal')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'clacno')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'rowno')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'inctax')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'incomeacno')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'client')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'nontax')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'voc_no')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+" :: "+$('#jqxpinvGrid').jqxGrid('getcellvalue',selectedrows[i],'costtype'));
			}     
			saveData(gridarray, date, pono, description, branch, todate);              
		}
		});
		}
function saveData(gridarray, date, pono, description, branch, todate){                    
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200){     
    		var items=x.responseText.trim().split('###');          
    		if(parseInt(items[0])>0){  
					 $.messager.alert('Message','SRS - '+items[1]+' Successfully generated','success');
					 $("#overlay, #PleaseWait").hide();    
					 funClear();       
				}else{ 
					$.messager.alert('Message','Not generated','warning');     
				    $("#overlay, #PleaseWait").hide();                         
				} 
    	 } 
    }       
    x.open("GET","savedata.jsp?podate="+date+'&pono='+pono+'&todate='+todate+'&brhid='+branch+'&gridarray='+encodeURIComponent(gridarray)+'&description='+encodeURIComponent(description),true);                                                                                                 
    x.send();               
  }  
	   function funClear(){  
		    $("#jqxInvCount").jqxGrid('clear'); 
		    $("#jqxpinvGrid").jqxGrid('clear'); 
		    document.getElementById("txtclient").value="";
		    document.getElementById("clientid").value="0";
		    $("#txtclient").attr("placeholder", "press F3 for Search");  
		    document.getElementById("txtpono").value=""; 
		    document.getElementById("txtdesc").value="";  
	   }
	   
	   function funreload()  {
	   	 var clientid=$('#clientid').val();
	   	 var date=$('#todate').val();
	   	 var barchval = document.getElementById("cmbbranch").value;
	        var dtype="0";
	        var id=1;
	       // alert(barchval);
			 if(barchval=="a"){
				 $.messager.alert('Warning','Select a Branch');
				 return false;
			 }
	       if(id>0){
	       	countload(id);
	       }
	        
	   	}
	   
		 function countload(id){
			 var clientid=$('#clientid').val();
			 var date=$('#todate').val();
			 var barchval = document.getElementById("cmbbranch").value;
			 $("#jqxpinvGrid").jqxGrid('clear'); 
			 $("#jqxInvCount").jqxGrid('clear');  
				
			 $("#jqxpinvGrid").jqxGrid('addrow', null, {});
			 $("#overlay, #PleaseWaitSub").show();
			 $("#invCountgrid").load("invCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id);
		 }
	
</script>
</head>
<body onload="getBranch();"> 
<form id="frmdinvoice" action=savedInvoice method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
		<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
	  <tr><td width="27%"  align="right" ><label class="branch">Upto Date</label></td><td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>' onchange="funresetdate();"></div>  
                    </td></tr>
                    
	    <tr>
	      <td align="right"><label class="branch">Client</label></td>
	      <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
      <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
							<img alt="clear" src="<%=contextPath%>/icons/clear.png">
						</button></td>
	      </tr>
	
	</table>
	<table width="100%" >
	 <tr><td colspan="2" ><div id="invCountgrid"><jsp:include page="invCountgrid.jsp"></jsp:include>
	</div></td></tr>
	<tr><td colspan="2"></td></tr>
	 <tr><td width="27%"  align="right" ><label class="branch">Inv Date</label></td><td width="73%" align="left">
	 <div id='invdate' name='invdate' value='<s:property value="invdate"/>'></div>
                    </td></tr>
                    <tr>
	      <td align="right"><label class="branch">PO No</label></td>
	      <td ><input style="height:19px;width:200px" type="text" name="txtpono" id="txtpono" value='<s:property value="txtpono"/>'>  
						</td>
	      </tr> 
      <tr>
	      <td align="right"><label class="branch">Description</label></td>
	      <td ><input style="height:19px;width:200px" type="text" name="txtdesc" id="txtdesc" value='<s:property value="txtdesc"/>'>
						</td>
	      </tr> 
               <tr><td colspan="2">&nbsp;</td></tr>          
      <tr>
      <td colspan="2"><center><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();"></center></td>
	</tr>              
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	</table>

 </fieldset>
</td>
<td width="80%">

	<table width="100%">
		<tr><td><div id="profinvdiv">
				<jsp:include page="invoiceprocessingGrid.jsp"></jsp:include> 
			</div></td></tr>  
	</table>
</tr>
</table>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
              <input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'> 
			  <input type="hidden" name="formcode" id="formcode" value='<s:property value="formcode"/>'>
			  <input type="hidden" name="ptype" id="ptype" value='<s:property value="ptype"/>'>
			<input type="hidden" id="hiddeninterstate" name="hiddeninterstate" value='<s:property value="hiddeninterstate"/>'>	
			<input type="hidden" name="countdtype" id="countdtype" value='<s:property value="countdtype"/>'>	
			<input type="hidden" name="hidclacno" id="hidclacno" value='<s:property value="hidclacno"/>'> 
			<input type="hidden" name="hidrefname" id="hidrefname" value='<s:property value="hidrefname"/>'>
			<input type="hidden" name="hiddtype" id="hiddtype" value='<s:property value="hiddtype"/>'>
			<input type="hidden" name="hidtrno" id="hidtrno" value='<s:property value="hidtrno"/>'> 
			<input type="hidden" name="hidclientid" id="hidclientid" value='<s:property value="hidclientid"/>'> 
			<input type="hidden" name="hiddocno" id="hiddocno" value='<s:property value="hiddocno"/>'>    
			<input type="hidden" name="hidcontracttype" id="hidcontracttype" value='<s:property value="hidcontracttype"/>'>      
</div>
</form>
</body>
</html>