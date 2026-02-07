<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () { 
		$("#hsndate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
		$('#btnSearch').attr('disabled', true);
		document.getElementById("formdet").innerText="HSNCode(HSN)";
		document.getElementById("formdetail").value="HSNCode";
		document.getElementById("formdetailcode").value="HSN";
		window.parent.formCode.value="HSN";
		window.parent.formName.value="HSNCode";
	});
	 
	 
	function funReadOnly() {
		$('#frmhsncode input').attr('readonly', true);
	 	$('#hsndate').jqxDateTimeInput({ disabled: true});
	}
	 
	 
	function funRemoveReadOnly() {
		$('#frmhsncode input').attr('readonly', false);
		$('#hsndate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
	}
	
	
	function setValues(){	
		if($('#msg').val()!=""){
			$.messager.alert('Message',$('#msg').val());
		}
		if($('#hsndate').val()){
			$("#hsndate").jqxDateTimeInput('val', $('#hsndate').val());
		}

	}
	
	
	function funFocus()
		    {
		    	document.getElementById("hscode").focus();
		    		
		    }
		    $(function(){
		        $('#frmhsncode').validate({
		                 rules: {
		                 hscode:{
		                	 required:true,
		                	 maxlength:8
		                 }
		                 },
		                 messages: {
		                  hscode:{
		                	  required:" *",
		                	  maxlength:"length of hs code should be 8 or less characters"
		                  }
		                 }
		        });});
	 
	function funNotify() {    	
		return 1;
	}
	 
	/* function funExcelBtn() {
		$("#jqxhsncodeGrid").jqxGrid('exportdata', 'xls', 'hscode');
	}  */ 
	
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmhsncode" action="savehsncodeAction"  autocomplete="off">

<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset>
<legend>HSN Code Details</legend>
				<table width="100%">
					<tr>
						<td width="9%" align="right">Date</td>
						<td width="16%"><div id="hsndate" name="hsndate" value='<s:property value="hsndate"/>'></div></td>
						<td width="4%" align="right">Doc No.</td>
						<td width="42%" align="left"><input type="text" name="docno"
							value='<s:property value="docno"/>' id="docno"
							readonly="readonly" tabindex="-1"></td>
					</tr>
					<tr>
						<td width="9%"  align="right">HS Code</td>
						<td width="45%" align="left"><input style="width:40%;" type="text" name="hscode"
							value='<s:property value="hscode"/>' id="hscode" ></td>
						<td align="right">Description</td>
						<td align="left"><input style="width:65%;" type="text" name="description"
							 value='<s:property value="description"/>'
							id="description"></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</fieldset>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="text" name="deleted"  hidden="hidden" id="deleted" value='<s:property value="deleted"/>'/>
		<input type="hidden" id="mode" hidden="hidden" name="mode"/>
		<input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'/>

	<table width="100%">
  <tr>
   <td>
   
   <div><jsp:include page="hsncodeGrid.jsp"></jsp:include></div> 
   </td>
  </tr>
</table>
</form>
</div>
</body>
</html>