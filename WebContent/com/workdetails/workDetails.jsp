<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnPrint').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		 $('#btnAttach').attr('disabled', true );
		 
		 $("#workDetailsDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#startDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#endDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#employeeDetailsWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsWindow').jqxWindow('close'); 
		 
		 $('#formDetailsWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Form Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#formDetailsWindow').jqxWindow('close'); 
		 
		 getWorkType();getProjects();
	});
	
	function EmployeeSearchContent(url) {
		$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function FormSearchContent(url) {
		$('#formDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#formDetailsWindow').jqxWindow('setContent', data);
		$('#formDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getWorkType() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var typeItems = items[0].split(",");
  				var typeIdItems = items[1].split(",");
  				var optionstype = '<option value="">--Select--</option>';
  				for (var i = 0; i < typeItems.length; i++) {
  					optionstype += '<option value="' + typeIdItems[i] + '">'
  							+ typeItems[i] + '</option>';
  				}
  				$("select#cmbcorrectiontype").html(optionstype);
  				if ($('#hidcmbcorrectiontype').val() != null) {
  					$('#cmbcorrectiontype').val($('#hidcmbcorrectiontype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getWorkType.jsp", true);
  		x.send();
  	}
	
	function getProjects() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var projectNameItems = items[0].split(",");
  				var projectIdItems = items[1].split(",");
  				var optionsproject = '<option value="">--Select--</option>';
  				for (var i = 0; i < projectNameItems.length; i++) {
  					optionsproject += '<option value="' + projectIdItems[i] + '">'
  							+ projectNameItems[i] + '</option>';
  				}
  				$("select#cmbproject").html(optionsproject);
  				if ($('#hidcmbproject').val() != null) {
  					$('#cmbproject').val($('#hidcmbproject').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getProjects.jsp", true);
  		x.send();
  	}
	
	function funSearchdblclick(){
		 $('#txtempname').dblclick(function(){
			  var project=$('#cmbproject').val();
			  if(project==""){
	 				 document.getElementById("errormsg").innerText="Choose Project and Search Employee.";
	 				 return 0;
	 			 }
			  EmployeeSearchContent(<%=contextPath+"/"%>+"com/workdetails/employeeDetailsSearchGrid.jsp?project="+project);
			  });  
		 
		  $('#txtformname').dblclick(function(){
			  var project=$('#cmbproject').val();
			  var formtype=$('#cmbformtype').val();
			  if(formtype=="0"){
	 				 document.getElementById("errormsg").innerText="Choose Form-type and Search Employee.";
	 				 return 0;
	 			 }
			  FormSearchContent(<%=contextPath+"/"%>+"com/workdetails/formDetailsSearchGrid.jsp?formType="+formtype+"&project="+project);
			  });
		 
	}
	 
	
	 function funReadOnly(){
			$('#frmWorkDetails input').attr('readonly', true );
			$('#frmWorkDetails select').attr('disabled', true);
			$('#workDetailsDate').jqxDateTimeInput({disabled: true});
			$('#startDate').jqxDateTimeInput({disabled: true});
			$('#endDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmWorkDetails input').attr('readonly', false );
			$('#frmWorkDetails select').attr('disabled', false);
			$('#txtempname').attr('readonly', true );
			$('#txtformname').attr('readonly', true );
			$('#workDetailsDate').jqxDateTimeInput({disabled: false});
			$('#startDate').jqxDateTimeInput({disabled: false});
			$('#endDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#workDetailsDate').val(new Date());
				$('#startDate').val(new Date());
				$('#endDate').val(new Date());
			}
			
	 }
	 
	 function funSearchLoad(){
	     changeContent('ewdMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#workDetailsDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmWorkDetails').validate({
	                rules: {
	                txtempname:"required",
	                cmbcorrectiontype:"required",
	                txtdetail:{"required":true,maxlength:400}
	                 },
	                 messages: {
	                 txtempname:" *",
	                 cmbcorrectiontype:" *",
	                 txtdetail:{required:" *",maxlength:"    Max 400 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		  
		  /* Validation */
	    		
		     employee=document.getElementById("txtempname").value;
			 if(employee==""){
				 document.getElementById("errormsg").innerText="Employee Name is Mandatory.";
				 return 0;
			 }
			 
			 form=document.getElementById("txtformname").value;
			 if(form==""){
				 document.getElementById("errormsg").innerText="Form Name is Mandatory.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
			 
	    /* Validation Ends*/
				 
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidworkDetailsDate').val()){
				 $("#workDetailsDate").jqxDateTimeInput('val', $('#hidworkDetailsDate').val());
			  }

		  if($('#hidstartDate').val()){
				 $("#startDate").jqxDateTimeInput('val', $('#hidstartDate').val());
			  }
		  
		  if($('#hidendDate').val()){
				 $("#endDate").jqxDateTimeInput('val', $('#hidendDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("cmbformtype").value=document.getElementById("hidcmbformtype").value;
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		}
	  
	  function getFormName(event){
          var x= event.keyCode;
          if(x==114){
        	  var project=$('#cmbproject').val();
			  var formtype=$('#cmbformtype').val();
			  if(formtype=="0"){
	 				 document.getElementById("errormsg").innerText="Choose Form-type and Search Employee.";
	 				 return 0;
	 			 }
			  FormSearchContent(<%=contextPath+"/"%>+"com/workdetails/formDetailsSearchGrid.jsp?formType="+formtype+"&project="+project);
          }
          else{
           }
          }
	  
	  function getEmployeeName(event){
          var x= event.keyCode;
          if(x==114){
        	  var project=$('#cmbproject').val();
	 			 if(project==""){
	 				 document.getElementById("errormsg").innerText="Choose Project and Search Employee.";
	 				 return 0;
	 			 }
			  EmployeeSearchContent(<%=contextPath+"/"%>+"com/workdetails/employeeDetailsSearchGrid.jsp?project="+project);
          }
          else{
           }
          }
	  
	  function newForm(){
	 		 if(document.getElementById("cmbcorrectiontype").value == 1){
	 			$('#txtformname').attr('readonly', false );
	 			$('#txtformname').attr('placeholder', ''); 
	 		 }
	 		 else{
	 			$('#txtformname').attr('readonly', true );
	 			
	 			if (document.getElementById("txtformname").value == "") {
	 		        $('#txtformname').attr('placeholder', 'Press F3 to Search'); 
	 		    }
	 		 }
	 	 }
	  
	  /* function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveCashPayment");
			     $("#docno").prop("disabled", false);
				
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();
						}
					   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    } */
	  
	  function clearEmployee(){
		  $("#txtempid").val('');$("#txtempname").val('');$("#cmbformtype").val('0');$("#txtformname").val('');
	  }
	    
     function clearForm(){
		  $("#txtformname").val('');
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
<form id="frmWorkDetails" action="saveWorkDetails" method="post" autocomplete="off">
<jsp:include page="../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Date</td>
    <td width="12%"><div id="workDetailsDate" name="workDetailsDate"  value='<s:property value="workDetailsDate"/>'></div>
    <input type="hidden" id="hidworkDetailsDate" name="hidworkDetailsDate" value='<s:property value="hidworkDetailsDate"/>'/></td>
    <td width="6%" align="right">Project</td>
    <td width="13%"><select id="cmbproject" name="cmbproject" style="width:71%;" onchange="clearEmployee();" value='<s:property value="cmbproject"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbproject" name="hidcmbproject" value='<s:property value="hidcmbproject"/>'/></td>
    <td width="7%" align="right">Employee Name</td>
    <td width="21%"><input type="text" id="txtempname" name="txtempname" style="width:90%;" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getEmployeeName(event);" value='<s:property value="txtempname"/>'/>
    <input type="hidden" id="txtempid" name="txtempid" value='<s:property value="txtempid"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="28%"><input type="text" id="docno" name="txtworkdetailsdocno" style="width:40%;" value='<s:property value="txtworkdetailsdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Type</td>
    <td><select id="cmbcorrectiontype" name="cmbcorrectiontype" style="width:71%;" onchange="newForm();" value='<s:property value="cmbcorrectiontype"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbcorrectiontype" name="hidcmbcorrectiontype" value='<s:property value="hidcmbcorrectiontype"/>'/></td>
    <td align="right">Form Type</td>
    <td><select id="cmbformtype" name="cmbformtype" style="width:71%;" onchange="clearForm();" value='<s:property value="cmbformtype"/>'>
      <option value="0">--Select--</option>
      <option value="1">Master Forms</option>
      <option value="2">Dash Board</option></select>
      <input type="hidden" id="hidcmbformtype" name="hidcmbformtype" value='<s:property value="hidcmbformtype"/>'/></td>
    <td align="right">Form Name</td>
    <td colspan="3"><input type="text" id="txtformname" name="txtformname" style="width:34%;" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getFormName(event);" value='<s:property value="txtformname"/>'/></td>
  </tr>
  <tr>
    <td align="right">Start Date</td>
    <td><div id="startDate" name="startDate"  value='<s:property value="startDate"/>'></div>
    <input type="hidden" id="hidstartDate" name="hidstartDate" value='<s:property value="hidstartDate"/>'/></td>
    <td colspan="2" align="right">&nbsp;</td>
    <td align="right">End Date</td>
    <td colspan="3"><div id="endDate" name="endDate"  value='<s:property value="endDate"/>'></div>
    <input type="hidden" id="hidendDate" name="hidendDate" value='<s:property value="hidendDate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="7"><input type="text" id="txtdetail" name="txtdetail" style="width:70%;" value='<s:property value="txtdetail"/>'/></td>
  </tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>
	
<div id="employeeDetailsWindow">
	<div></div><div></div>
</div>  
				
<div id="formDetailsWindow">
	<div></div><div></div>
</div>  
	
</div>
</body>
</html>