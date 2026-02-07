<%@page import="com.controlcentre.settings.clientdocuments.ClsClientdocumentsDAO"%>
<%ClsClientdocumentsDAO DAO= new ClsClientdocumentsDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	      document.getElementById("formdet").innerText="Client Documents(CRMD)";
 		  document.getElementById("formdetail").value="Client Documents";
 		  document.getElementById("formdetailcode").value="CRMD";
 		  window.parent.formCode.value="CRMD";
		  window.parent.formName.value="Client Documents";
	 });
	 function funSearchLoad(){
			changeContent('clientdocumentSearch.jsp', $('#window')); 
		 } 
	function funReadOnly() {
		$('#frmclientDocuments input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			readonly : true
		});
		//setValues();
	}
	function funRemoveReadOnly() {
		$('#frmclientDocuments input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$('#jqxclientdocSearch').jqxGrid({ disabled: true});
		}
	}
	function setValues() {
		funSetlabel();
		if($('#datehidden').val()){
			$("#date").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		
	}  
	
	  function funFocus(){
	    	 $('#date').jqxDateTimeInput('focus');
	     }
	  
	  function funNotify(){
		 
		   var documentname=document.getElementById("txtdocument").value;
		    if(documentname==""){
		    	document.getElementById("errormsg").innerText=" Enter Document!";
				document.getElementById("txtdocument").focus();  
				return 0;
		    }
  		return 1;
	} 
	      </script>  
 
</head>
<body onLoad="setValues();">
<form id="frmclientDocuments" action="saveClientDocuments" method="post" autocomplete="off">

	<jsp:include page="../../../../header.jsp" />
	
		<fieldset><legend>Documents</legend>
	<table width="100%">
		<tr><td width="6%" align="right">Date</td>
			<td align="left"><div id="date" name="date"></div>
		  	</td>
			<td width="40%" align="right">Doc No.</td>
			<td >
			<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true"  tabindex="-1">
			</td>
	    </tr>
		<tr><td align="right">Document</td>
			<td><input type="text" name="txtdocument" id="txtdocument"  value='<s:property value="txtdocument"/>'  style="width:100%"></td>
			<td><div align="right">Remarks</div></td>
             <td><input type="text" name="remarks" id="remarks" value='<s:property value="remarks"/>'  style="width:90%"></td>
		</tr>
				
	</table>
	
	</fieldset><br/>
	<div class="row">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
    			<div class="crmddiv"><jsp:include page="clientdocumentsGrid.jsp"></jsp:include></div>
    		</div>
    	</div> 
	   <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
		<input type="hidden" id="chkstatus" name="chkstatus"  value='<s:property value="chkstatus"/>'/>
	    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
	</form>
	<br/>
</body>
</html>