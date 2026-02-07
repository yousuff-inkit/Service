 
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<% String contextPath=request.getContextPath(); %>

<script type="text/javascript">
	$(document).ready(function () {    
	    $("#PortDate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
        });
       function funSearchLoad(){
		changeContent('portSearch.jsp', $('#window')); 
	 } 
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmPort input').attr('readonly', true);
		$('#frmPort textarea').attr('disabled', true );
		$('#PortDate').jqxDateTimeInput({
			readonly : true
		});
		setValues();
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmPort input').attr('readonly', false);
		$('#frmPort textarea').attr('disabled', false );
		$('#PortDate').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		
	}
/* 	function show_image(src, width, height, alt,position,norepeat) {
	    var img = document.createElement("img");
	    img.src = src;
	    img.width = width;
	    img.height = height;
	    img.alt = alt;
	    img.position=position;
	    img.repeat=norepeat;

	    // This next line will just add it to the <body> tag
	    document.body.appendChild(img);
	} */
	function setValues() {
		if($('#hidPortDate').val()){
			$("#PortDate").jqxDateTimeInput('val', $('#hidPortDate').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	 
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("port").focus();
	     }
	  
</script>  
 
</head>
<body onLoad="funReadOnly();setValues();" >
<form id="frmPort" action="savePort" method="get" autocomplete="off">
<script>
			 window.parent.formName.value="PORT";
			window.parent.formCode.value="PRT"; 
	</script>
	<%-- <jsp:include page="../../../../header.jsp" /> --%>
	<jsp:include page="../../../header.jsp" />
	<br/> 
	<table width="100%" >
	<tr><td>
	<fieldset><legend>Port Details</legend>
	<table width="100%" >
		<tr><td colspan=2 width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="PortDate" name="PortDate"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true"  tabindex="-1">
			</td>
		</tr>
		
		</table>
		<table width="100%" >
		<tr>
		<td width="6%" align="right">Port</td>
			<td width="20%"><input type="text" name="port" id="port" style="width: 70%;"  value='<s:property value="port"/>' ></td>
		<td align="right">Port Name</td>
			<td width="20%"><input type="text" name="portname" id="portname" style="width: 100%;"  value='<s:property value="portname"/>' ></td>
		<td align="right">Country</td>
			<td width="20%"><input type="text" name="country" id="country" style="width: 100%;"  value='<s:property value="country"/>' >	
			<input type="hidden" id="hidPortDate" name="hidPortDate" value='<s:property value="hidPortDate"/>'/></td>
		</tr>
		
		</table>
		</fieldset>
		</td></tr></table>
	
	
	
    	<table width="100%">
      <tr>
        <td width="3%">&nbsp;</td>
        <td width="42%">
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
</td>
        <td width="55%">&nbsp;</td>
      </tr>
    </table>
	</form>

<br/>

</body>
</html>