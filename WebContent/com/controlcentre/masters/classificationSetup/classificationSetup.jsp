<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();
%>
<head>
<meta charset="ISO-8859-1">
<title>GatewayERP(i) SpecMaster</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function () {
		$("#specDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	
		/* document.getElementById("formdet").innerText="classificationSetup(CST)";
		document.getElementById("formdetail").value="classificationSetup";
		document.getElementById("formdetailcode").value="CST";
		window.parent.formCode.value="CST";
		window.parent.formName.value="classificationSetup"; */
	});
	
	function funFocus()
 	 {
 		// document.getElementById("txtclient_name").focus();  
 		
 	 }
		function funReadOnly(){
			$('#frmSpecMaster input').prop('readonly', true );
			$('#jqxspecMasterGrid').jqxGrid({ disabled: false});
			$('#frmSpecMaster textarea').attr('readonly', true );
			$('#frmSpecMaster select').attr('disabled', true);
			$('#specDate').jqxDateTimeInput({ disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmSpecMaster input').attr('readonly', false );	
			$('#frmSpecMaster textarea').attr('readonly', false );
			$('#frmSpecMaster select').attr('disabled', false);
			$('#specDate').jqxDateTimeInput({ disabled: true});
			$('#docno').attr('readonly', true);
			if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {
				$('#jqxspecMasterGrid').jqxGrid({ disabled: true});
				$('#specDate').jqxDateTimeInput({ disabled: false});
				$('#specDate').val(new Date());
			}
		}
		
		function funSearchLoad(){
			 changeContent('classificationSetupSearch.jsp','$(window)'); 
		}
		
		$(function(){
	      $('#frmSpecMaster').validate({
	                   rules: { name:{"required":true}},
	                   messages: {
	    	             name: {required:" *required"}
	                 }
	        });
	    });
		
		function disfields()
		 {
			 $('#docno').attr('readonly', true);
			 $('#name').attr('readonly', false );
			 if ($("#mode").val() == "view") {
		    	$('#name').attr('readonly', true );
			 }
		 }
		
		function setValues() {
			    /* document.getElementById("formdetail").value="classificationSetup";
		   		document.getElementById("formdetailcode").value="CST";   */
			if($('#hidspecDate').val()!=''){
				$("#specDate").jqxDateTimeInput('val', $('#hidspecDate').val());
			}
	      	if($('#msg').val()!=""){
	 		   $.messager.alert('Message',$('#msg').val());
	 		  }
	      	/*  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	 */
		}
	
		function funNotify() {
			/* alert(document.getElementById("name").value);
			if(document.getElementById("name").value==''){
				document.getElementById("errormsg").innerText="Name is Mandatory.";
				return false;
			}
			document.getElementById("errormsg").innerText=""; */
			return 1; 
		}
</script>
</head>
<body onload="setValues();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmSpecMaster" action="saveSpecMaster" autocomplete="OFF">
			<jsp:include page="../../../../header.jsp"></jsp:include><br />
			<fieldset>
				<legend>Classification Setup</legend>
				<table width="100%">
					<tr>
						<td width="11%" align="right">Date</td>
    					<td colspan="2"><div id='specDate' name='specDate' value='<s:property value="specDate"/>'></div>
                     	<input type="hidden" id="hidspecDate" name="hidspecDate" value='<s:property value="hidspecDate"/>'/></td>
						<td width="33%">Doc No&nbsp;<input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfocus="disfields();"/></td>
					</tr>
					<tr>
    					<td align="right">Name</td>     
    					<td><input type="text" id="name" name="name" style=" width:100%;" value='<s:property value="name"/>' onfocus="disfields(); ">
  					</tr>   
				</table>
			</fieldset>
			<br/>
				<div  id="specdiv" >
					<jsp:include page="classificationSetupGrid.jsp"></jsp:include>
				</div>
			<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
			<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
			<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>' />
		</form>
	</div>
</body>
</html>
