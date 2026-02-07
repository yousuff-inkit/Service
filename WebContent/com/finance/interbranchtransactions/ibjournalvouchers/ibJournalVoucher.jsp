<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#jqxIbJournalVouchersDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#ibJournalVoucherGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#ibJournalVoucherGridWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#branchSearchWindow').jqxWindow('close');
 		 
 		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costTypeSearchGridWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
 		 
 		$('#jqxIbJournalVouchersDate').on('change', function (event) {
			 var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
			 funDateInPeriod(ibjournaldate);
		 });
 		
 		$('#txtdescription').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxIbJournalVoucher').jqxGrid('selectcell',0, 'branch');
			          $('#jqxIbJournalVoucher').jqxGrid('focus',0, 'branch');
			  }
		 });
		 
	});
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function AccountSearchContent(url) {
		$('#ibJournalVoucherGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ibJournalVoucherGridWindow').jqxWindow('setContent', data);
		$('#ibJournalVoucherGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );
					 $('#txtdrtotal').attr('readonly', true );$('#txtcrtotal').attr('readonly', true );
					 $("#jqxIbJournalVoucher").jqxGrid({ disabled: false});
					 $('#docno').attr('readonly', true);  
			    }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmIbJournalVoucher input').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: true});
			$("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
	 }
	 function funRemoveReadOnly(){
			$('#frmIbJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxIbJournalVoucher").jqxGrid({ disabled: false}); 
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbJournalVoucher input').attr('readonly', true );
			    $("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
				$("#jqxIbJournalVoucher").jqxGrid('clear');
				$("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		   changeContent('ijvMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxIbJournalVouchersDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmIbJournalVoucher').validate({
	                rules: {
	                   txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                   txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
			  /* Validation */
			  
			    var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(ibjournaldate);
				if(validdate==0){
				return 0;	
				}
				
				 valid=document.getElementById("txtvalidation").value;
				 if(valid==1){
					 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					 return 0;
				 }
			  
			    var drtot = document.getElementById("txtdrtotal").value;
		 		var crtot = document.getElementById("txtcrtotal").value;
		 		if(drtot>crtot || drtot<crtot){
		 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	            return 0;
		 		}
		 		
		 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
		 			  document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
		              return 0;
			 		}
		    	document.getElementById("errormsg").innerText="";
		    	/* Validation  Ends*/
		    	
		    	/* Ib Journal Voucher Grid Saving */
		    	 var rows = $("#jqxIbJournalVoucher").jqxGrid('getrows');
		    	 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].docno;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+i)
					    .attr("name", "test"+i)
					    .attr("hidden", "true");
						length=length+1;
						
					var amount,baseamount,id;
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 amount=rows[i].debit;
						 baseamount=rows[i].baseamount;
						 id=1;
					}
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 amount=rows[i].credit*-1;
						 baseamount=rows[i].baseamount*-1;
						 id=-1;
					}

					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].brhid);
					newTextBox.appendTo('form');
					}
				 }
				 $('#gridlength').val(length);
		 		/* Ib Journal Voucher Grid Saving Ends */
		    	
	    		return 1;
		} 
	  
	  function setValues(){
		 
			  if($('#hidjqxIbJournalVouchersDate').val()){
				 $("#jqxIbJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxIbJournalVouchersDate').val());
			  }
			  
			  if($('#hidmaindate').val()){
					 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
				  }
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
	         $("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal); 
			 }
			
		}
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				var url="";
		        var reurl="";
		        if ($("#msg").val().trim() == "") {
		        	url=document.URL;
		        	if( url.indexOf('saveIbJournalVoucher') >= 0){
		        		reurl=url.split("saveIbJournalVoucher");
		        	}else {
		        		reurl=url.split("ibJournalVoucher.jsp");
		        	}
		        }else if ($("#msg").val().trim() != "") {
		        	url=document.URL;
		        	reurl=url.split("saveIbJournalVoucher");
		        }
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function datechange(){
		  var date = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
			if(validdate==0){
				return 0;	
			}
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmIbJournalVoucher" action="saveIbJournalVoucher" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<table width="99%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="14%"><div id="jqxIbJournalVouchersDate" name="jqxIbJournalVouchersDate" onchange="datechange();" value='<s:property value="jqxIbJournalVouchersDate"/>'></div>
    <input type="hidden" id="hidjqxIbJournalVouchersDate" name="hidjqxIbJournalVouchersDate" value='<s:property value="hidjqxIbJournalVouchersDate"/>'/></td>
    <td width="5%" align="right">Ref. No.</td>
    <td width="14%"><input type="text" id="txtrefno" name="txtrefno" style="width:60%;" onblur="fungridfocus();" value='<s:property value="txtrefno"/>'/></td>
    <td width="7%" align="right">Description</td>
    <td width="23%"><input type="text" id="txtdescription" name="txtdescription" style="width:85%;" value='<s:property value="txtdescription"/>'/></td>
    <td width="11%" align="left"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
    <td width="7%" align="right">Doc No</td>
    <td width="14%"><input type="text" id="docno" name="txtibjournalvouchersdocno" style="width:60%;" value='<s:property value="txtibjournalvouchersdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td colspan="9"><div id="jqxJournalVoucherGrid"><jsp:include page="ibJournalVoucherGrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td align="right">Dr. Total</td>
    <td><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:65%;text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/></td>
    <td colspan="6" align="right">Cr. Total</td>
    <td><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:60%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
</div>
</form>

<div id="ibJournalVoucherGridWindow">
	<div></div><div></div>
</div>

<div id="branchSearchWindow">
				<div></div><div></div>
</div>

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 

</div>
</body>
</html>