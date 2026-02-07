<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
 
select{
    height:15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	 var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	 $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	 
	 $('#docWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#docWindow').jqxWindow('close');
     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	 $('#accountSearchwindow').jqxWindow('close');
	 
	 $('#account').dblclick(function(){
 		
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	  accountSearchContent('accountsDetailsSearch.jsp?');
 		 
	});   
	$('#invdocno').dblclick(function(){
		
		    $('#docWindow').jqxWindow('open');
		  docSearchContent('docnoSearch.jsp?');
	}); 
	 
});


function funreload(event)
{
	
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 if(fromdates>todates){
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   return false;
	  } 
	 else{
		 var barchval = document.getElementById("cmbbranch").value;
	     var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var statusselect="All";
		 var acno=$("#acno").val();
		 var invdocnomaster=$("#invdocnomaster").val();
		 var load="yes";
		
		 //alert("fun reload");
		 
		 $("#overlay, #PleaseWait").show();
	 	 $("#listdivsumm").load("salessuminvoicelistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno+"&invdocnomaster="+invdocnomaster+"&load="+load+"&id=1");
	 }
}
	
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	
	function getaccountdetails(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountSearchwindow').jqxWindow('open');
		
		 accountSearchContent('accountsDetailsSearch.jsp?');    }
		 else{
			 }
			 
		 }  
	function accountSearchContent(url) {
	         $.get(url).done(function (data) {
	       $('#accountSearchwindow').jqxWindow('setContent', data);
		}); 
	   	}
		  
	function getaccountdetail(event){
		 var x= event.keyCode;
			 if(x==114){
			  $('#docWindow').jqxWindow('open');
				  docSearchContent('docnoSearch.jsp?'); 
				  }
				 else{
					 }
		 } 
	function docSearchContent(url) {
				 
		 $.get(url).done(function (data) {
	     $('#docWindow').jqxWindow('setContent', data);
		  }); 
	}
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('select').find('option').prop("selected", false);
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	    
	    $('#account').attr('placeholder', 'Press F3 TO Search'); 
        $('#invdocno').attr('placeholder', 'Press F3 TO Search'); 
	
	}
	
	function funDispatchData(){
		var selectedrows=$('#invlist').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		document.getElementById("printdocno").value="";
		for(var i=0;i<selectedrows.length;i++){
			if(i==0){
				document.getElementById("printdocno").value+=$('#invlist').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
			else{
				document.getElementById("printdocno").value+=":"+$('#invlist').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
			
			 	var items= x.responseText;
			 	if(parseInt(items)>0){
			 		$.messager.alert('Message','Record Successfully Dispatched','warning');   
			 	}
			 	else{
			 		$.messager.alert('Message','Not Dispatched','warning');
			 	}
			
			 	 
			 	funreload(event);
				
			 	 
	    }
		}
	     x.open("GET","dispatchData.jsp?invno="+document.getElementById("printdocno").value,true);
	    x.send();
	   

	}
	
	function funPrintData(){
		var selectedrows=$('#invlist').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		document.getElementById("printdocno").value="";
		for(var i=0;i<selectedrows.length;i++){
			if(i==0){
				document.getElementById("printdocnonew").value+=$('#invlist').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
			else{
				document.getElementById("printdocnonew").value+=":"+$('#invlist').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
		}
		var dtype="BIIL";
		var url=document.URL;
	    var reurl=url.split("salesinvoicesummarylist.jsp");
	    //alert(reurl[0]+"printsummaryjasper?printdocno="+document.getElementById("printdocnonew").value+"&dtype="+dtype);
	    var win= window.open(reurl[0]+"printsummaryjasper?printdocno="+document.getElementById("printdocnonew").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
   	 	win.focus();
   	 	document.getElementById("printdocnonew").value="";
	}
	
	function funExportBtn(){
		alert("inside Export");
		JSONToCSVConvertor(clockexportdata, 'Job Clock In List', true);
		 }
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	
	function funinv(docno,paymode)
	{
		 var barchval = document.getElementById("cmbbranch").value;
		if(barchval=="a" || barchval=="")
			{
			  $.messager.alert('Message','Branch is mandatory  ','warning');   
				 
			   return false;
			}
		
		
	   var url=document.URL;
		var reurl=url.split("com/");
		var mod="view";
		if(paymode=="CREDIT"){
			window.parent.formName.value="Credit Invoice";
			var detName= "Credit Invoice";
			var path1='com/sales and marketing/Sales/invoice/saveSalesInvoicecr';
		}
		if(paymode=="CASH"){
			window.parent.formName.value="Cash Invoice";
			var detName= "Cash Invoice";
			var path1='com/sales and marketing/Sales/invoice/saveSalesInvoice';
		}
		window.parent.formCode.value="INV";
	
		// var path1='com/sales and marketing/Sales/invoice/creditinvoice.jsp';
		
		    var path= path1+"?mode="+mod+"&masterdoc_no="+docno;  

		top.addTab( detName,reurl[0]+""+path);
		searchDAO
	}
	/* setValues(); */
	</script>
	
</head>
<body onload="getBranch();">
<form id="invoicelist" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%" align="center">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
		
		 <tr>
		   <td width="30%" align="right"><label class="branch">From Date</label></td><td width="70%"><div id="fromdate"></div></td></tr>
		 <tr>
		   <td align="right"><label class="branch">To Date</label></td>
		   <td><div id="todate"></div></td>
		 </tr>
		
		<tr>
			<td align="right"><label class="branch">Account</label></td>
    		<td  ><input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetails(event);" >  </td>
    	</tr>
 		<tr> 
 			<td>&nbsp;</td><td> <input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  readonly="readonly"  style="height:20px;width:100%;"></td>
 		</tr>
 	    <tr>
			<td align="right"><label class="branch">DOCNO</label></td>  
			<td><input type="text" name="invdocno" id="invdocno" value='<s:property value="invdocno"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetail(event);" >  </td>
		</tr>
		
		<tr >
			<td colspan="2" style="border-top:2px solid #DCDDDE;">
			<div style="text-align:center;">
				<input type="button" name="btndispatch" id="btndispatch" value="Dispatch" class="myButtons" onclick="funDispatchData();"> &nbsp;&nbsp;
				<input type="button" name="btnprint" id="btnprint" value="Print" class="myButtons" onclick="funPrintData();">
			</div>
		    </td>
		</tr>	
		<tr >
			<td colspan="2" style="border-top:2px solid #DCDDDE;">
			<div style="text-align:center;">
				<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
			</div>
		    </td>
		</tr>	
		<tr >
			<td colspan="2">
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			</td>
		</tr>
		
		<tr colspan="2"><td>&nbsp;</td></tr>		
	</table>
			
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdivsumm"><jsp:include page="salessuminvoicelistGrid.jsp"></jsp:include></div></td>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
			  <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
    		  <input type="hidden" id="invdocnomaster" name="invdocnomaster" value='<s:property value="invdocnomaster"/>'> 
    		  <input type="hidden" id="printdocno" name="printdocno" value='<s:property value="printdocno"/>'>
			  <input type="hidden" id="printdocnonew" name="printdocnonew" value='<s:property value="printdocnonew"/>'>
		</tr>
	</table>
</tr>
</table>
</div>

</div>
</form>
<div id="accountSearchwindow">  
   <div ></div>
</div> 
<div id="docWindow">
   <div ></div>
</div>	
	
</body>
</html>