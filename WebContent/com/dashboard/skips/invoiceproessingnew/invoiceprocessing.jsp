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
	document.getElementById("servchargechk").checked=true;
	document.getElementById("tfeechk").checked=true;
	document.getElementById("gfeechk").checked=true;  
	document.getElementById("servchargechk").disabled = true;
	document.getElementById("tfeechk").disabled = true;
	document.getElementById("gfeechk").disabled = true;  
	document.getElementById("hidservchargechk").value = 1;          
	document.getElementById("hidtfeechk").value = 1;
	document.getElementById("hidgfeechk").value = 1;    
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	$("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#todate').jqxDateTimeInput('setDate', new Date());
	var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
	
	$('#clientname').dblclick(function(){
		   $('#clientwindow').jqxWindow('open');
		   clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	});
});
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
	$("#invdiv").excelexportjs({
		containerid: "invdiv",
		datatype: 'json',
		dataset: null,
		gridId: "jqxInvoiceGrid",
		columns: getColumns("jqxInvoiceGrid"),  
		worksheetName: "InvoiceProcessing"  
	});			
}
function funreload(){
	$("#jqxInvoiceGrid").jqxGrid('clear'); 
	$("#jqxCountGrid").jqxGrid('clear');  
	var cldocno=$("#cldocno").val();
	var todate=$('#todate').jqxDateTimeInput('val');  
	var brhid=$('#cmbbranch').val();
	if(brhid=="a"){
		$.messager.alert('Message',"Please select a branch");  
	}else{
		$('#overlay,#PleaseWait').show();
		$("#countdiv").load("invoiceCount.jsp?todate="+todate+"&brhid="+brhid+"&cldocno="+cldocno+"&id=1");
	}  
}
function funClear(){
	$("#jqxCountGrid").jqxGrid('clear');  
	$("#jqxInvoiceGrid").jqxGrid('clear'); 
	$('#todate').jqxDateTimeInput('setDate', new Date());
	document.getElementById("cldocno").value="";
	document.getElementById("clientname").value="";
	$('#clientname').attr('placeholder', 'Press F3 TO Search'); 
}
function funNotify(validtotal,datechk){  
	    var rownos=$('#hidrowno').val();
	    if(rownos==""){  
			 $.messager.alert('Warning','Please select a document');
			 $("#overlay, #PleaseWait").hide();
			 return false;
		 }
	    if(parseFloat(datechk)>0){      
			 $.messager.alert('Warning','Revised documents should be invoiced separately!');  
			 $("#overlay, #PleaseWait").hide();
			 return false;
		 }
	    if(parseFloat(validtotal)>0){      
			 $.messager.alert('Warning','Total is zero, You cannot process invoice'); 
			 $("#overlay, #PleaseWait").hide();
			 return false;
		 }
	     var branch=$('#cmbbranch').val();  
		 if(branch=="a"){
			 $.messager.alert('Warning','Please select a branch');  
			 $("#overlay, #PleaseWait").hide();
			 return false;
		 }
		 var invdate=$('#invdate').val();
		 if(invdate==""){
			 $.messager.alert('Warning','Invoice date is madatory');  
			 $("#overlay, #PleaseWait").hide();
			 return false;
		 }
		document.getElementById("frminvprocessingnew").submit();              
	} 
  function funGenerate(){
	$('#jqxInvoiceGrid').jqxGrid('clearfilters', true);  
	var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');

	var selectedrows=$("#jqxInvoiceGrid").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});

	if(selectedrows.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select documents.');
		return false;
	}
	
	$.messager.confirm('Message', 'Do you want to Generate Invoice?', function(r){
	if(r==false) {
		return false; 
	} else {
		$("#overlay, #PleaseWait").show();
	
		var i=0;var temptrno="";           
		var j=0,validtotal=0,datval=0,datechk=0;
		var sertotal=0.0,tiptotal=0.0,gtetotal=0.0;
		for (i = 0; i < selectedrows.length; i++) {
		    if(i==0){      
				var srvdetmtrno= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
				if(document.getElementById("servchargechk").checked){
					sertotal= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "rpctotal");
					if(sertotal==0){  
						validtotal=1;
				    }
				}
				if(document.getElementById("tfeechk").checked){
					tiptotal= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "tftotal");
					if(tiptotal==0){   
						validtotal=1;
				    }
				}
				if(document.getElementById("gfeechk").checked){
					gtetotal= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "gftotal");   
					if(gtetotal==0){  
						validtotal=1;
				    }
				}
				temptrno=srvdetmtrno;   
			} else{    
				var srvdetmtrno= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
				if(document.getElementById("servchargechk").checked){
					sertotal= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "rpctotal");
					if(sertotal==0){  
						validtotal=1;
				    }
				}
				if(document.getElementById("tfeechk").checked){
					tiptotal= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "tftotal");
					if(tiptotal==0){  
						validtotal=1;
				    }
				}
				if(document.getElementById("gfeechk").checked){
					gtetotal= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "gftotal");   
					if(gtetotal==0){    
						validtotal=1;
				    }
				}
				temptrno=temptrno+","+srvdetmtrno;
			} 
		    var dtchk = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', selectedrows[i], "datval");
		    if(dtchk==1){   
		    	datval = 1;   
		    }
			temptrno1=temptrno+","; 
			j++; 
		}
		$('#hidrowno').val(temptrno1);
		if(datval==1 && i>1){      
			datechk=1;
		}
		funNotify(validtotal,datechk);  
	}
	});
	}  
  function setValues(){ 
		if($('#msg').val()!=""){
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   	 }
		funchange();
	 }
  function funchange(){   
	  if(document.getElementById("servchargechk").checked){
		  document.getElementById("hidservchargechk").value = 1; 
	  }else{
		  document.getElementById("hidservchargechk").value = 0; 
	  }
	  
	  if(document.getElementById("tfeechk").checked){
		  document.getElementById("hidtfeechk").value = 1; 
	  }else{
		  document.getElementById("hidtfeechk").value = 0; 
	  }
	  
	  if(document.getElementById("gfeechk").checked){
		  document.getElementById("hidgfeechk").value = 1; 
	  }else{
		  document.getElementById("hidgfeechk").value = 0;   
	  }
  } 
  function funLoadContracts(){
		var todate =  $('#todate').val();
		$.messager.confirm('Message', 'Do you want to load?', function(r){
		 			if(r==false) {
		 				return false; 
		 			} else {
		 				$("#overlay, #PleaseWait").show();    
		 				loadContracts(todate);     
		 			}
		});
  }
  function loadContracts(todate){            
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)>0){ 
							 funClear();
							 $("#overlay, #PleaseWait").hide();
							 $.messager.alert('Message','Successfully Loaded','success');
						}else{
							funClear(); 
							 $("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','Nothing to load','warning');      
						} 
				}  
		}  
	x.open("GET","loadcontracts.jsp?date="+todate,true);               
	x.send();
	}
</script>
</head>
<body onload="getBranch();setValues();">   
<form id="frminvprocessingnew" action=saveInvoiceProcessingnew method="post">           
	<div id="mainBG" class="homeContent" data-type="background"> 
		<div class='hidden-scrollbar'>
			<table width="100%" >
			<tr>
			<td width="20%" >
			    <fieldset style="background: #ECF8E0;">
					<table width="100%"  >
						<jsp:include page="../../heading.jsp"></jsp:include>
						<tr><td width="27%"  align="right" ><label class="branch">UpTo Date</label></td>
							<td width="73%" align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
							 <input type="hidden" name="cldocno" id="cldocno"> </td>  
						</tr>
						 <tr><td align="right"><label class="branch">Client</label></td><td align="left"><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' "  style="height:20px;width:90%;" value='<s:property value="clientname"/>'></td></tr>                 
				        <tr><td colspan="2"><center><input type="button" name="btnloadcontracts" id="btnloadcontracts" class="myButton" value="Load" onclick="funLoadContracts();"></center></td></tr>     
						<tr><td width="27%"  colspan="2"><div id="countdiv"><jsp:include page="invoiceCount.jsp"></jsp:include></div></td>  
						</tr>  
						<tr><td colspan="2"><input type="checkbox" name="servchargechk" id="servchargechk" onchange="funchange();"><label class="branch">Service Charge</label><input type="checkbox" name="tfeechk" id="tfeechk" onchange="funchange();"><label class="branch">Tipping Fee</label><input type="checkbox" name="gfeechk" id="gfeechk" onchange="funchange();"><label class="branch">Gate Fee</label></td></tr>
						 <tr><td width="27%"  align="right" ><label class="branch">Inv Date</label></td><td width="73%" align="left">
						 <div id='invdate' name='invdate'></div></td></tr>     
						<tr><td align="center" colspan="2"><input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funGenerate();">&nbsp;&nbsp;<input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClear();"></td></tr> 
						<tr><td colspan="2"><input type="hidden" name="hidrowno" id="hidrowno">
						<input type="hidden" name="advance" id="advance">  
						<input type="hidden" name="type" id="type">  
						<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>   
			            <input type="hidden" name="formcode" id="formcode" value='<s:property value="formcode"/>'>
			            <input type="hidden" name="hidservchargechk" id="hidservchargechk" value='<s:property value="hidservchargechk"/>'>    
			            <input type="hidden" name="hidtfeechk" id="hidtfeechk" value='<s:property value="hidtfeechk"/>'>  
			            <input type="hidden" name="hidgfeechk" id="hidgfeechk" value='<s:property value="hidgfeechk"/>'></td></tr>            
					</table>
				</fieldset>
			</td>
			<td width="40">
				<table width="100%">  
					<tr><td><div id="invdiv"><jsp:include page="invoiceGrid.jsp"></jsp:include></div></td></tr>
				</table>
			</td>
			</tr>
			</table>
		</div>
 <div id="clientwindow">
   <div></div>
</div>
</div>
</form>
</body>
</html>