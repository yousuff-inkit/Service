<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <jsp:include page="../../../includes.jsp"></jsp:include> 
<% String contextPath=request.getContextPath();%>
<link rel="stylesheet" type="text/css" href="../../../css/body.css">  
<script type="text/javascript">
     $(document).ready(function () { 
    	 refChange(); 
    	$('#btnEdit').click(function(){
    		$("#jqxManualInvoice").jqxGrid("addrow", null, {}); 
    	});
 	    $("#date").jqxDateTimeInput({ width: '110%', height: '24px',formatString:"dd.MM.yyyy"});  
		$("#fromdate").jqxDateTimeInput({ width: '110%', height: '24px',formatString:"dd.MM.yyyy"});
        $("#todate").jqxDateTimeInput({ width: '110%', height: '24px',formatString:"dd.MM.yyyy"});
        $('#accountwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	$('#accountwindow').jqxWindow('close');
    	$('#contractnowindow').jqxWindow({ width: '60%', height: '57%',  maxHeight: '57%' ,maxWidth: '60%' , title: 'Contract Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#contractnowindow').jqxWindow('close');
        $('#clientwindow').jqxWindow({ width: '60%', height: '57%',  maxHeight: '57%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#clientwindow').jqxWindow('close');
        $('#printWindow').jqxWindow({width: '51%', height: '24%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
   	    $('#printWindow').jqxWindow('close');  
    	/* $('#date').on('change', function (event) {  
   					var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));  
   					if(docdateval==0){
   						$('#date').jqxDateTimeInput('focus');
   						return false;
   					}
   		}); */   
    	 $('#txtcontract').dblclick(function(){  
    	    	$('#contractnowindow').jqxWindow('open');
    	    	contractSearchContent('contractsearch.jsp?', $('#contractnowindow')); 
    	  });
    	 $('#txtclient').dblclick(function(){
    		    var reftype=$("#cmbreftype").val();     
    		    if(reftype=="DIR"){     
    		    	$('#clientwindow').jqxWindow('open');     
        	 	    clientSearchContent('clientsearch.jsp?', $('#clientwindow'));	
    		    }
    	});
     });
     function getclient(){
    	 var reftype=$("#cmbreftype").val();     
		 if(reftype=="DIR"){  
	       	 var x= event.keyCode;
	       	 if(x==114){
	       	   $('#clientwindow').jqxWindow('open');
	       	   clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }  
	       	 else{
	       		 }
		 }  
     }   
     function clientSearchContent(url) {       
    	          $.get(url).done(function (data) {
    		           $('#clientwindow').jqxWindow('setContent', data);
             	  }); 
     }
     function getContract(){ 
       	 var x= event.keyCode;
       	 if(x==114){
       	   $('#contractnowindow').jqxWindow('open');
       	   contractSearchContent('contractsearch.jsp?', $('#contractnowindow'));    }  
       	 else{
       		 }
     }   
     function contractSearchContent(url) { 
    	          $.get(url).done(function (data) {
    		           $('#contractnowindow').jqxWindow('setContent', data);
             	  }); 
     }
     function accountSearchContent(url) {
    	      $.get(url).done(function (data) {
    	    $('#accountwindow').jqxWindow('setContent', data);
    	}); 
    	}
    function funReset(){
    	
    	/* $("#invoiceDiv").load("invoiceGrid.jsp"); */
	}
	function funReadOnly(){
		$('#frmSkipInvoice input').attr('readonly', true );
		$('#frmSkipInvoice select').attr('disabled', true);
		$('#frmSkipInvoice textarea').attr('readonly', true );
	    $('#date').jqxDateTimeInput({ disabled: true});
	    $("#fromdate").jqxDateTimeInput({ disabled: true});
        $("#todate").jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		$('#frmSkipInvoice input').attr('readonly', false );
		$('#frmSkipInvoice select').attr('disabled', false);
		$('#frmSkipInvoice textarea').attr('readonly', false );
		$('#date').jqxDateTimeInput({ disabled: false});
		$("#fromdate").jqxDateTimeInput({ disabled: false});
        $("#todate").jqxDateTimeInput({ disabled: false});
        refChange(); 
		$('#docno').attr('readonly', true);
		$('#txtcontract').prop('readonly', true);
		$('#txtclient').prop('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$("#invoiceDiv").load("invoiceGrid.jsp");
 			$('#fromdate').jqxDateTimeInput('setDate',new Date());
			$('#todate').jqxDateTimeInput('setDate',new Date());
			$('#date').jqxDateTimeInput('setDate',new Date());
 		}
		if(document.getElementById("mode").value=="E"){  
			$('#cmbreftype').prop('disabled',true);
		}
		if($('#mode').val()=='A' || $('#mode').val()=='E'){
			/* var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#date').jqxDateTimeInput('focus');
					return false;
				} */ 
		}
	}  

	
	function funNotify(){ 
		var reftype=$("#cmbreftype").val();
		var cnttrno=$("#hidcntrno").val();
		if(reftype=="AMC"){
			if(cnttrno==""){     
				document.getElementById("errormsg").innerText="Please select a contract";  
				return 0;  
			}else{
				document.getElementById("errormsg").innerText="";
			}
		}
	//Month Close Validation
		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return 0;
		}
	/*	var fromdateval=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
		if(fromdateval==0){
			$('#fromdate').jqxDateTimeInput('focus');
			return 0;
		}
		var todateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
		if(todateval==0){
			$('#todate').jqxDateTimeInput('focus');
			return 0;
		}
	*/	
		//From Date and todate validation
		if($('#fromdate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Invoice From Date is Mandatory";
			return 0;
		}
		if($('#todate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Invoice To Date is Mandatory";
			return 0;
		}
	
		var rows = $("#jqxManualInvoice").jqxGrid('getrows');
		var gridlength=0;
		if(rows[0].idno=="undefined" || rows[0].idno==null || rows[0].idno==""){
		
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
			return 0;
		}
		
		if(rows[0].total=="undefined" || rows[0].total==null || rows[0].total==""){
			
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
			return 0;
		}
		
		if(!((rows[0].idno=="undefined") && (rows[0].idno==null) && (rows[0].idno==""))){
    	
    		var j=0;
    		for(var i=0 ; i < rows.length ; i++){
			
			  if(rows[i].idno!="undefined" && rows[i].idno!=null && rows[i].idno!=""){	
					
			  if(rows[i].total!="undefined" && rows[i].total!=null && rows[i].total!=""){
				    newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+j)
				    .attr("name", "test"+j)
				    .attr("hidden", "true");   
					
					gridlength++;j++;  
					newTextBox.val(rows[i].idno+" :: "+rows[i].account+" :: "+rows[i].description+" :: "+rows[i].qty+" :: "+rows[i].rate+" :: "+rows[i].total+" :: "+rows[i].taxper+" :: "+rows[i].taxamt+" :: "+rows[i].nettotal+" :: "+rows[i].rowno);		
					newTextBox.appendTo('form');
					}
				}
			
			}
			$('#gridlength').val(gridlength);
    	}
    		$('#cmbagmttype').prop('disabled',false); 
		return 1;
     } 
	function setValues(){
	  if($('#deleted').val()!=''){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Deleted Invoice";
	  }
 	  if($('#hiddate').val()!= null && $('#hiddate').val()!= ""){
			$("#date").jqxDateTimeInput('val', $('#hiddate').val());
		} 
		if($('#hidfromdate').val()!= null  && $('#hidfromdate').val()!= ""){
			$("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
		}
		if($('#hidtodate').val()!= null && $('#hidtodate').val()!= ""){
			$("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
		}
		if ($('#hidcmbreftype').val() != null  && $('#hidcmbreftype').val()!= "") {    
			$('#cmbreftype').val($('#hidcmbreftype').val());
		}
		if(document.getElementById("masterdoc_no").value>0){
			var docno1=document.getElementById("masterdoc_no").value;  
			document.getElementById("brchName").disabled=false;
			$("#invoiceDiv").load("invoiceGrid.jsp?docno="+docno1+"&branch="+document.getElementById("brchName").value);
			document.getElementById("brchName").disabled=true;
 		}
		 if($('#msg').val()!=""){
    		   $.messager.alert('Message',$('#msg').val());
    		  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 refChange(); 
	}
	 function funChkButton() {
			/* funReset(); */
		}
	
	function funSearchLoad(){
			changeContent('invMainSearch.jsp', $('#window'));
	}
			
    function funFocus(){
		   document.getElementById("cmbreftype").focus(); 	    		
	 }
    function funSendmail(){
 	}
    function refChange(){
		 var reftype=$('#cmbreftype').val();
		 if(reftype=='DIR'){
			  $('#txtcontract').attr('disabled', true);
		 }
		 else{
			  $('#txtcontract').attr('disabled', false);  
		 }
		}
    function funPrintBtn() {      
  	  var docVal1 = document.getElementById("masterdoc_no").value;
        if(docVal1=="" || docVal1=="0") {    
      		$.messager.alert('Message','Select a Document....!','warning');
  			return 0;
       }else{
    	     invoicePrintContent('printVoucherWindow.jsp'); 
       }
    } 
    function invoicePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
  }
</script>  
<style>
.hidden-scrollbar {
overflow: hidden;
height: 530px;
}
.icons {
	width: 3em;
	height: 3em;
	border: none;
	background-color: #E0ECF8;
}
</style>
</head>
<body onload="funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSkipInvoice" action="saveSkipInvoice" autocomplete="off">
	<script>
			window.parent.formName.value="Invoice";
			window.parent.formCode.value="SINV";    
	</script>
	<jsp:include page="../../../header.jsp" />
	<br/> 
<div class='hidden-scrollbar'>
<fieldset>
    <legend>Document Details</legend>  
<table width="100%">  
  <tr>
      <td width="5%" align="right">Ref Type</td>
      <td  width="17%"><select id="cmbreftype" name="cmbreftype" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
	      <option value="DIR">DIR</option>  
	      <option value="AMC">Contract</option>    
	      </select><input type="text" id="txtcontract" name="txtcontract"  style="width: 66%;" placeholder="Press F3 To Search" value='<s:property value="txtcontract"/>' onKeyDown="getContract();">
		  <input type="hidden" id="hidcntrno" name="hidcntrno"  style="width: 70%;" value='<s:property value="hidcntrno"/>'>
		  <input type="hidden" id="hidcmbreftype" name="hidcmbreftype"  style="width: 70%;" value='<s:property value="hidcmbreftype"/>'>     
      </td> 
      <td  width="5%" align="right">Client</td>         
      <td width="40%" ><input type="text" id="txtclient" name="txtclient" style="width:97%;" placeholder="Press F3 To Search"  value='<s:property value="txtclient"/>' onKeyDown="getClient();">
		<input type="hidden" id="hidcldocno" name="hidcldocno" value='<s:property value="hidcldocno"/>'></td>  	
      <td  width="5%" align="right">Date</td>
      <td width="10%" align="left"><div id="date" name="date"></div>    
        <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'></td>
      <td width="10%" align="right">Doc No</td>
      <td width="8%" align="left"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
      <td width="5%" align="right">Remarks</td>     
      <td width="40%" colspan="5"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;" value='<s:property value="txtremarks"/>'></td>    
  </tr>
</table>
</fieldset>

<fieldset>
    <legend>Invoice Details</legend>  
<table width="100%" >
  <tr>
    <td width="5%" align="right">Period From</td>
    <td width="8%" align="left"><div id="fromdate" name="fromdate"></div>  
      <input type="hidden" name="hidfromdate" id="hidfromdate" value='<s:property value="hidfromdate"/>'></td>
    <td width="7%" align="right">Ledger Note</td>
    <td width="27%" align="left"><input type="text" name="ledgernote" style="width:97%;" id="ledgernote" value='<s:property value="ledgernote"/>'></td>
    <td width="9%" align="right">Period To</td>
    <td width="8%" align="left"><div id="todate" name="todate"></div>  
    <input type="hidden" name="hidtodate" id="hidtodate" value='<s:property value="hidtodate"/>'></td>
    <td width="6%" align="right">Invoice Note</td>
    <td width="29%" align="left"><input type="text" name="invoicenote" id="invoicenote" style="width:99%;" value='<s:property value="invoicenote"/>'></td>
  </tr>
</table>
</fieldset>
<input type="hidden" name="acno" id="acno" value='<s:property value="acno"/>'>
<input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
<fieldset>
<table width="100%">
  <tr>
     <td><div id="invoiceDiv">
     <jsp:include page="invoiceGrid.jsp"></jsp:include>
     </div></td> 
  </tr>
</table>

</fieldset>
</div>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'>    
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'>
<div id="accountwindow">
   <div ></div>
</div>
<div id="contractnowindow">
   <div ></div>
</div>
<div id="clientwindow">  
   <div ></div>
</div>
<div id="printWindow">
	<div></div><div></div></div>
</form>

</div>
</body>
</html>