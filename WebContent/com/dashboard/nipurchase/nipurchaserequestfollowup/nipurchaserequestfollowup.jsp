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

<style type="text/css">

.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	    $("#nipurchaseorderdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	    
	    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		  		  
		$('#typesearchwindow').jqxWindow({ width : '25%', height : '58%',maxHeight : '70%',maxWidth : '45%',title : ' Search',position : { x : 700, y : 87 },theme : 'energyblue',showCloseButton : true,keyboardCloseKey : 27});
		$('#typesearchwindow').jqxWindow('close');
	
		$('#txtvendor').dblclick(function(){
			$('#accountSearchwindow').jqxWindow('open');
	  		accountSearchContent('accountsDetailsGrid.jsp?');
  		});   
	
		$('#txtproducttype').dblclick(function(){
			typeFormSearchContent('typeFormSearchGrid.jsp'); 
		});  
		
		$('#btnloaddetail').attr('disabled', true);
		$('#txtproducttype').attr('disabled', true);
	});
	
	function getaccountdetails(event){
		var x= event.keyCode;
	 	if(x==114){
	    	$('#accountSearchwindow').jqxWindow('open');
	 		accountSearchContent('accountsDetailsGrid.jsp?');    
	 	}
	}  
	
	function accountSearchContent(url) {
		$.get(url).done(function (data) {
	        $('#accountSearchwindow').jqxWindow('setContent', data);
		}); 
	}
	  
	function getRatevaluenw(curr){
		var docdate=$('#nipurchaseorderdate').val();
	    var x=new XMLHttpRequest();
	    x.onreadystatechange=function(){
	    	if (x.readyState==4 && x.status==200) {
				var items= x.responseText;
				funRoundRate(items,"currate"); 
	        }
	    }
		x.open("GET","getRateTo.jsp?curr="+curr+"&date="+docdate,true);
		x.send();
	}
	
	function getProdType(event){
		var x= event.keyCode;
		if(x==114){
			typeFormSearchContent('typeFormSearchGrid.jsp');  	 
		}
	}
	
	function typeFormSearchContent(url) {
		$('#typesearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#typesearchwindow').jqxWindow('setContent', data);
			$('#typesearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function disable(){		
		$("#descdetailsGrid").jqxGrid('clear');
		$("#descdetailsGrid").jqxGrid({ disabled: true});
	}
	
	function funreload(event){
		disable();
		var branchval = document.getElementById("cmbbranch").value;
		
		if(branchval=='a'){
			$.messager.alert('Warning','Select a Branch');
			return false;
		}
		
		$("#overlay, #PleaseWait").show();  
		$("#masterDiv").load("nipurchaserequestfollowupGrid.jsp?branchval="+branchval+"&check=1");
		$("#nettotal").val('');
	}
	
	function funLoadDetails(){
		var selectedrows=$("#jqxNiPuReqGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
			$.messager.alert('Warning','Select documents.');
			return false;
		}
		
		var docno="";
		var brhid="";
		for (i = 0; i < selectedrows.length; i++) {
			docno += $('#jqxNiPuReqGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+',';		
			brhid = $('#jqxNiPuReqGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');		
		}     
		
		docno = docno.substring(0,docno.length - 1);
		
		$("#detailDiv").load('nipurchaserequestfollowupSubGrid.jsp?nidoc='+docno);
		$("#brhid").val(brhid);
		$("#nettotal").val('');
	}

	function funCreateOrder(){	
		var nettotal= document.getElementById("nettotal").value;
		if(nettotal=="" || parseFloat(nettotal)==0){
			$.messager.alert('Warning','Net Amount Empty');
			return 0;
		}
		
		var docdate=$('#nipurchaseorderdate').val();
		var desc=$('#txtdesc').val();
		var accdocno=$('#accdocno').val();
		var curr=$('#cmbcurr').val();
		var currate=$('#currate').val();
		var producttype=$('#hideproducttype').val();
		var nettotal=$('#nettotal').val();
		var brhid=$('#brhid').val();
		
		$('#descdetailsGrid').jqxGrid('clearfilters');
		var rows = $("#descdetailsGrid").jqxGrid('getrows');
		var gridarray = new Array();
		var reqrefnoarr = [];
		
	    for(var i=0 ; i < rows.length ; i++){
	    	gridarray.push(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "
	    			+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].refrow+"::");
	    	
	    	reqrefnoarr.push(rows[i].voc_no);
		}   
	    
	    var reqrefno = reqrefnoarr.filter(function(itm, i, reqrefnoarr) {
		    return i == reqrefnoarr.indexOf(itm);
		});
		
	    $.messager.confirm('Message', 'Do you want to Create NI Purchase Order?', function(r){  
			if(r==false) {
				return false; 
			} else {
				$("#overlay, #PleaseWait").show();
				
				saveData(docdate,desc,accdocno,curr,currate,producttype,nettotal,reqrefno,brhid,gridarray); 		            	
			}
		});
	    
	}
			    			
	function saveData(docdate,desc,accdocno,curr,currate,producttype,nettotal,reqrefno,brhid,gridarray){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
			    var items= x.responseText;
			    var itemval=items.trim();
			    if(parseInt(itemval.split('#')[0])>0){
			    	$.messager.alert('Message', '  NI Purchase Order-'+itemval.split('#')[1]+' Successfully Created ');
			    	funreload();
			    }else{
			    	$.messager.alert('Message', '  Not Updated  ');

			    }  
			}
		}  
		x.open("GET","saveNiPurchaseOrder.jsp?docdate="+docdate+"&desc="+desc+"&accdocno="+accdocno+"&curr="+curr+"&currate="+currate
				+"&producttype="+producttype+"&nettotal="+nettotal+"&reqrefno="+reqrefno+"&brhid="+brhid+"&gridarray="+gridarray);
		x.send();
	}
	
</script>

</head>
<body onload="getBranch();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<tr><td>&nbsp;</td></tr>
	
	<tr><td align="right"><label class="branch">Date</label></td>
	<td align="left"><div id="nipurchaseorderdate" name="nipurchaseorderdate"></td></tr>
   
	<tr><td align="right"><label class="branch">Vendor</label></td>
	<td align="left"><input type="text" id="txtvendor" name="txtvendor" style="width:90%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onKeyDown="getaccountdetails(event);"/></td></tr>
   
	<tr><td align="right" width="20%"><label class="branch">Bill Type</label></td>
	<td align="left"><input type="text" id="txtproducttype" name="txtproducttype" style="width:90%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" onKeyDown="getProdType(event);"/></td></tr>
	 
	<tr><td colspan="2">&nbsp;</td></tr>
	 
	<tr><td colspan="2" align="center"> <button class="myButton" type="button" id="btnloaddetail" name="btnloaddetail" onclick="funLoadDetails(event);">Load</button></td></tr>
	 
	<tr><td colspan="2">&nbsp;</td></tr>

	<tr><td align="right" width="20%"><label class="branch">Description</label></td>
	
	<td align="left"><input type="text" id="txtdesc" name="txtdesc" style="width:90%;height:20px;"/></td></tr>

	<tr><td colspan="2">&nbsp;</td></tr>
	 
	<tr><td colspan="2" align="center"> <button class="myButton" type="button" id="btncreateorder" name="btncreateorder" onclick="funCreateOrder(event);">Create NI Purchase Order</button></td></tr>
	   	
	<tr><td colspan="2">  	
		<input type="hidden" id="accdocno" name="accdocno"/>  
		<input type="hidden" id="cmbcurr" name="cmbcurr"/>  
		<input type="hidden" id="currate" name="currate"/>  
		<input type="hidden" id="hideproducttype" name="hideproducttype"/>  
		<input type="hidden" id="taxpers" name="taxpers"/>  
		<input type="hidden" id="nettotal" name="nettotal"/>  
		<input type="hidden" id="brhid" name="brhid"/>  
	</td></tr>
	   
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 </table>
	</fieldset>
</td>
<td width="80%" class='hidden-scrollbar'>
	<table width="100%" style=" vertical-align: top;">
		<tr><td><div id="masterDiv"><jsp:include page="nipurchaserequestfollowupGrid.jsp"></jsp:include></div><br/></td></tr>
	 	<tr><td><div id="detailDiv"><jsp:include page="nipurchaserequestfollowupSubGrid.jsp"></jsp:include></div></td></tr>
	</table>
	</td>
</tr>
</table>
</div>

	<div id="accountSearchwindow">
	   <div ></div>
	</div>
	<div id="typesearchwindow">
	   <div ></div>
	</div>

</div> 
</body>
</html>