<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {  
		
		 $("#tenancyContractDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#periodFromDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#periodToDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 	$('#tenancyContractDate').on('change', function (event) {
				  
			    var maindate = $('#tenancyContractDate').jqxDateTimeInput('getDate');
			  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
			    funDateInPeriodchk(maindate);
			  	 }
			   });
		 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#refnosearchwindow').jqxWindow('close'); 
			 $('#refnosearchwindow1').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			   $('#refnosearchwindow1').jqxWindow('close'); 
			   $('#salespersonwindow').jqxWindow({
					width : '25%',
					height : '58%',
					maxHeight : '70%',
					maxWidth : '45%',
					title : '  Search',
					position : {
						x : 500,
						y : 87
					},
					 
					showCloseButton : true,
					keyboardCloseKey : 27
				});
				$('#salespersonwindow').jqxWindow('close');
	 	$('#txtproperty').dblclick(function(){
	 		 refsearchContent1('pmainsearch.jsp');
		});
	 	
		$('#txttenant').dblclick(function(){
	 		 refsearchContent2('tmainsearch.jsp');
		});
	});
	
	function salespersonSearchContent(url) {
		$('#salespersonwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#salespersonwindow').jqxWindow('setContent', data);
			$('#salespersonwindow').jqxWindow('bringToFront');
		});
		}

	function getTenant(event){
		refsearchContent1('tmainsearch.jsp');
	}

	function refsearchContent2(url) {

		$('#refnosearchwindow1').jqxWindow('open');

		  $.get(url).done(function (data) {
		//alert(data);
		$('#refnosearchwindow1').jqxWindow('setContent', data);

		}); 
		}	
	
	function getProperty(event){
		refsearchContent1('pmainsearch.jsp');
	}


	function refsearchContent1(url) {

	$('#refnosearchwindow').jqxWindow('open');

	  $.get(url).done(function (data) {
	//alert(data);
	$('#refnosearchwindow').jqxWindow('setContent', data);

	}); 
	}	
	 function funReadOnly(){
			$('#frmTenancyContract input').attr('readonly', true );
			$('#frmTenancyContract select').attr('disabled', true);
			$('#tenancyContractDate').jqxDateTimeInput({disabled: true});
			$('#periodFromDate').jqxDateTimeInput({disabled: true});
			$('#periodToDate').jqxDateTimeInput({disabled: true});
			
			$("#termsOfContractGridId").jqxGrid({ disabled: true});
			$("#agentGridId").jqxGrid({ disabled: true});
			$("#paymentDistributionGridId").jqxGrid({ disabled: true});
	 }
	 function funRemoveReadOnly(){
			$('#frmTenancyContract input').attr('readonly', false );
			$('#frmTenancyContract select').attr('disabled', false);
			
			$('#txttenant').attr('readonly', true );
			$('#txtproperty').attr('readonly', true );
			$('#tenancyContractDate').jqxDateTimeInput({disabled: false});
			$('#periodFromDate').jqxDateTimeInput({disabled: false});
			$('#periodToDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#termsOfContractGridId").jqxGrid({ disabled: false}); 
			$("#agentGridId").jqxGrid({ disabled: false});
			$("#paymentDistributionGridId").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "E") {
   			  //  $("#termsOfContractGridId").jqxGrid('addrow', null, {});
   			    $("#agentGridId").jqxGrid('addrow', null, {});
   			    $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
   				$('#periodToDate').jqxDateTimeInput({disabled: true});
			}
			 
			
			if ($("#mode").val() == "A") {
				$('#tenancyContractDate').val(new Date());
				$('#periodFromDate').val(new Date());
				$('#periodToDate').val(new Date());
				$('#txtnotificationperiod').val('60');
				$('#txtcontractperiod').val('1');
				
				$('#periodToDate').jqxDateTimeInput({disabled: true});  
				
				$("#termsOfContractGridId").jqxGrid('clear');
				$("#termsOfContractGridId").jqxGrid('addrow', null, {});
				$("#agentGridId").jqxGrid('clear');
				$("#agentGridId").jqxGrid('addrow', null, {});
				$("#paymentDistributionGridId").jqxGrid('clear');
				$("#paymentDistributionGridId").jqxGrid('addrow', null, {});
				
				
				 $('#termsOfContractDiv').load("termsOfContractGrid.jsp?load=1") ;
			}
			
	 }
	 
	 function funSearchLoad(){
	  changeContent('masterSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#tenancyContractDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function funPrintBtn(){
		 if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			 var url=document.URL;
			 var reurl;
			 if( url.indexOf('saveTenancyContract') >= 0){
				 reurl=url.split("saveTenancyContract");
			 }else {
				 reurl=url.split("tenancyContract.jsp");
			 }
			 $("#docno").prop("disabled", false);                
			 var dtype=$('#formdetailcode').val();
			 var brhid='<%=session.getAttribute("BRANCHID").toString()%>';
			 var win= window.open(reurl[0]+"printTenancyContract?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			 win.focus();
		 
		 }
		 else {
   	      $.messager.alert('Message','Select a Document....!','warning');
   	      return false;
   	     }
	 }
	 
	 
		 function funDateInPeriodchk(value){
		 
		 
			 var currentDate = new Date(new Date());
		 
		     if(value>currentDate){
		     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
		    
		     return 0;
		    } 
		    
		    document.getElementById("errormsg").innerText="";
		   
		     return 1;
		 }
	   
		 
		 function funchk(){	
			 
			 var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();	
						 
						if(parseInt(items)>0)
							
							{
							
							 document.getElementById("errormsg").innerText="Property not available";
							    
						     return 0;
							 
							 
							 
							}
						else
							{
							save();
							}
					  
						
						
						
					} else {
					}
				}
				x.open("GET", "checkdate.jsp?fromdate="+document.getElementById("periodFromDate").value+"&txtpropertydocno="+document.getElementById("txtpropertydocno").value, true);
				x.send();   
			 
			 
		 }
		 
		 
		 
	  function funNotify(){	
			var maindate = $('#tenancyContractDate').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriodchk(maindate);
			   
			  
			   
			   if(validdate==0){
			   return 0; 
			   }
		  
			   
			   
			   var type = document.getElementById("cmbtenancytype").value;
				 var txttenant = document.getElementById("txttenant").value;
				 var txtproperty = document.getElementById("txtproperty").value;
				 var cmbcontractperiod = document.getElementById("cmbcontractperiod").value;
				 

	if(type=="")
	{
	document.getElementById("errormsg").innerText="Type is required ";
	 
	return 0;
	}
				 

	if(txttenant=="")
	{
	document.getElementById("errormsg").innerText="Tenant is required ";
	 
	return 0;
	}
	if(txtproperty=="")
	{
	document.getElementById("errormsg").innerText="Property is required ";
	 
	return 0;
	}
		 
	if(cmbcontractperiod=="")
	{
	document.getElementById("errormsg").innerText="Contract Period is required ";
	 
	return 0;
	}
		
	if(document.getElementById("mode").value=="A")
		{
		funchk();
		}
	else
		{
		save();
		}
	

	
	  }
	  
	  
	  
	  function save()
	  {
	   
	var rows = $("#termsOfContractGridId").jqxGrid('getrows');
	$('#termgridlength').val(rows.length); 
	for(var i=0 ; i < rows.length ; i++){ 
		newTextBox = $(document.createElement("input"))
		.attr("type", "dil")
		.attr("id", "term"+i) 
		.attr("name", "term"+i)
		.attr("hidden", "true");
		var aa=0;
		newTextBox.val(rows[i].docno+"::"+rows[i].amount+"::"+rows[i].docno+"::"+aa+"::");    
		newTextBox.appendTo('form');
	}

	var rows = $("#agentGridId").jqxGrid('getrows');
	$('#agentgridlength').val(rows.length);
	for(var i=0 ; i < rows.length ; i++){ 
		newTextBox = $(document.createElement("input"))
		.attr("type", "dil")
		.attr("id", "agent"+i)
		.attr("name", "agent"+i)
		.attr("hidden", "true");
		var aa=0;
		newTextBox.val(rows[i].salid+"::"+rows[i].commperc+"::"+rows[i].commamount+"::"+aa+"::");
		newTextBox.appendTo('form');
	}
	   
	   var rows = $("#paymentDistributionGridId").jqxGrid('getrows');
	   
	     $('#paymentgridlength').val(rows.length);
	    
	   for(var i=0 ; i < rows.length ; i++){ 
	  	  
	  	 
	    newTextBox = $(document.createElement("input"))   
	       .attr("type", "dil")
	       .attr("id", "payment"+i)
	       .attr("name", "payment"+i)
	       .attr("hidden", "true");
	 var aa=0;
	   newTextBox.val(rows[i].description+"::"+$('#paymentDistributionGridId').jqxGrid('getcellText', i, "date")+"::"+rows[i].amount+"::"+rows[i].notes+"::"+rows[i].chqno+"::"+rows[i].paidto+"::"+rows[i].paymentmethod+"::"+rows[i].bankaccount+"::"+aa+"::");
	   newTextBox.appendTo('form');
	   }
	   
	   
	   
	
		  
		  $('#periodToDate').jqxDateTimeInput({disabled: false});
	         document.getElementById("frmTenancyContract").submit();
		} 
	  
	  
	  function setValues(){
		  
	
		  
		  if($('#hidtenancyContractDate').val()){
				 $("#tenancyContractDate").jqxDateTimeInput('val', $('#hidtenancyContractDate').val());
			  }

		  if($('#hidperiodFromDate').val()){
				 $("#periodFromDate").jqxDateTimeInput('val', $('#hidperiodFromDate').val());
			  }
		  
		  if($('#hidPeriodToDate').val()){
				 $("#periodToDate").jqxDateTimeInput('val', $('#hidPeriodToDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		     
	         if($('#hidcmbtenancytype').val()!="")
				  {
				  
				  
				  $('#cmbtenancytype').val($('#hidcmbtenancytype').val());   
				  
				  }

		     
	         if($('#hidcmbcontractperiod').val()!="")
				  {
				  
				  
				  $('#cmbcontractperiod').val($('#hidcmbcontractperiod').val());   
				  
				  }

		     
	       

		  
		  
			 if(document.getElementById("masterdoc_no").value>0)
			 {
	     /*  document.getElementById("cmbtenancytype").value=document.getElementById("hidcmbtenancytype").value;
		  
		  document.getElementById("cmbcontractperiod").value=document.getElementById("hidcmbcontractperiod").value; */
		  funchkforedit();
		  $('#termsOfContractDiv').load("termsOfContractGrid.jsp?docno="+document.getElementById("masterdoc_no").value) ;
		  $('#agentDiv').load("agentGrid.jsp?docno="+document.getElementById("masterdoc_no").value) ;
		  $('#paymentDistributionDiv').load("paymentDistributionGrid.jsp?docno="+document.getElementById("masterdoc_no").value) ;
		  
		 
			 }
			 
			 
		  
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		}  
		function funInsEndDate(){
			 
			if($('#mode').val()=="view")
				{
				return 0;
				}
			
			
			
		  	   var inststartday= $('#periodFromDate').jqxDateTimeInput('getDate');
		  	   
		  	   if(inststartday==null){
				 	document.getElementById("errormsg").innerText="Period From is Mandatory.";
				 	return 0;
			   }
	/* 	  		$('#periodToDate').jqxDateTimeInput({disabled: false});
		  	   if(inststartday>($('#periodToDate').jqxDateTimeInput('getDate'))){
				 	document.getElementById("errormsg").innerText="  Date Should be less than   Date.";
					$('#periodToDate').jqxDateTimeInput({disabled: true});
				 	return 0;
			   }
		  		$('#periodToDate').jqxDateTimeInput({disabled: true}); */
		  	   document.getElementById("errormsg").innerText="";
			  	   
			   var startdate = $('#periodFromDate').jqxDateTimeInput('getText');
			   var installno = document.getElementById("txtcontractperiod").value;
			   var frequency = document.getElementById("cmbcontractperiod").value;
			   getEndDate(frequency,installno,startdate);
	 }
		function getEndDate(frequency,installno,startdate){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				$('#periodToDate').jqxDateTimeInput({disabled: false});
	  			    $('#periodToDate').val(items);
	  				 $('#periodToDate').jqxDateTimeInput({disabled: true});
	  		}
	  		}
	  		x.open("GET", "getEndDate.jsp?frequency="+frequency+'&installno='+installno+'&startdate='+startdate, true);
	  		x.send();
	    }
		
		function isNumber(evt) {
			
			
		 
		    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57) && iKeyCode==110)
		    	{
		 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
		       
		        return false;
		    	}
		    document.getElementById("errormsg").innerText="";  
		    return true;
		}
		
		
		 
		function funchkforedit()
	    {
		

		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					 
					if(parseInt(items)>0)
						
						{
						
						 $("#btnEdit").attr('disabled', true );
						 $("#btnDelete").attr('disabled', true ); 
						 
						 
						 
						}
					else
						{
						 
						}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();    
		
		
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
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmTenancyContract" action="saveTenancyContract" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include><br/>

<!-- <div  class='hidden-scrollbar'> -->
<fieldset>
<table width="100%"> 
  <tr>
    <td width="7%" align="right">Date</td> 
    <td width="12%"><div id="tenancyContractDate" name="tenancyContractDate" value='<s:property value="tenancyContractDate"/>'></div>
    <input type="hidden" id="hidtenancyContractDate" name="hidtenancyContractDate" value='<s:property value="hidtenancyContractDate"/>'/></td>
    <td colspan="2" align="right">Type</td>
    <td colspan="3"><select id="cmbtenancytype" name="cmbtenancytype" style="width:27%;" value='<s:property value="cmbtenancytype"/>'>
    <option value="">--Select--</option><option value="1">Residence</option><option value="2">Commercial</option></select>
    <input type="hidden" id="hidcmbtenancytype" name="hidcmbtenancytype" value='<s:property value="hidcmbtenancytype"/>'/></td>
    <td width="9%" align="right">Doc No</td>
    <td width="19%"><input type="text" id="docno" name="docno" style="width:60%;" value='<s:property value="docno"/>' tabindex="-1"/></td> 
  </tr>
  <tr>
    <td align="right">Tenant</td> 
    <td colspan="4"><input type="text" id="txttenant" name="txttenant" style="width:92%;" placeholder="Press F3 to Search" value='<s:property value="txttenant"/>'  onkeydown="getTenant(event);"/>
    <input type="hidden" id="txttenantdocno" name="txttenantdocno" value='<s:property value="txttenantdocno"/>'/></td>
    <td width="6%" align="right">Property</td>
    <td colspan="3"><input type="text" id="txtproperty" name="txtproperty" style="width:50%;" placeholder="Press F3 to Search" value='<s:property value="txtproperty"/>'  onkeydown="getProperty(event);"/>
    <input type="hidden" id="txtpropertydocno" name="txtpropertydocno" value='<s:property value="txtpropertydocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Contract Period</td>
    <td><select id="cmbcontractperiod" name="cmbcontractperiod" style="width:90%;" onchange="funInsEndDate()" value='<s:property value="cmbcontractperiod"/>'>
     <option value="">--Select--</option><option value="1">Years</option><option value="2">Months</option></select>
    <input type="hidden" id="hidcmbcontractperiod" name="hidcmbcontractperiod" value='<s:property value="hidcmbcontractperiod"/>'/></td>
    <td width="14%"><input type="text" id="txtcontractperiod" name="txtcontractperiod" style="width:50%;text-align: center;" onkeypress="isNumber(evt);" onblur="funInsEndDate()" value='<s:property value="txtcontractperiod"/>'/></td>
    <td width="6%" align="right">Period From </td> 
    <td width="13%"><div id="periodFromDate" name="periodFromDate"  onchange="funInsEndDate()"  value='<s:property value="periodFromDate"/>'></div>
    <input type="hidden" id="hidperiodFromDate" name="hidperiodFromDate" value='<s:property value="hidperiodFromDate"/>'/></td>
    <td align="right">To</td>
    <td width="14%"><div id="periodToDate" name="periodToDate" value='<s:property value="periodToDate"/>'></div>
    <input type="hidden" id="hidPeriodToDate" name="hidPeriodToDate" value='<s:property value="hidPeriodToDate"/>'/></td>
    <td align="right">Notification Period</td>
    <td><input type="text" id="txtnotificationperiod" name="txtnotificationperiod" onkeypress="isNumber(evt);"  style="width:60%;text-align: center;" value='<s:property value="txtnotificationperiod"/>'/></td>
  </tr>
</table>
</fieldset>
<table width="100%">
<tr>
<td width="50%">
<fieldset>
<legend>Terms of Contract</legend> 
<div id="termsOfContractDiv"><jsp:include page="termsOfContractGrid.jsp"></jsp:include></div>
</fieldset> 
</td> 
<td width="50%">
 
<fieldset>
<legend>&nbsp;</legend> 
<div id="agentDiv"><jsp:include page="agentGrid.jsp"></jsp:include></div>
</fieldset> 
</td>
</tr>
</table>
<fieldset> 
<legend>Payment Distribution</legend>
<div id="paymentDistributionDiv"><jsp:include page="paymentDistributionGrid.jsp"></jsp:include></div>
</fieldset>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/> 
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/> 
 
 <input type="hidden" id="termgridlength" name="termgridlength"  value='<s:property value="termgridlength"/>'/>
 <input type="hidden" id="agentgridlength" name="agentgridlength"  value='<s:property value="agentgridlength"/>'/>
 <input type="hidden" id="paymentgridlength" name="paymentgridlength"  value='<s:property value="paymentgridlength"/>'/>
 
   
</form>
	<div id="refnosearchwindow1"><div></div></div>
	<div id="refnosearchwindow"><div></div></div>
		<div id="salespersonwindow"><div></div></div>
	
  </div> 
</body>
</html>