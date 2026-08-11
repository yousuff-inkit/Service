<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
 
<script type="text/javascript">

$(document).ready(function () { 
	$('#btnSearch').attr('disabled', true);
	 $("#ptmdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	 
      		document.getElementById("formdet").innerText="Tax Type Master(TTM)";
    		document.getElementById("formdetail").value="Tax Type Master";
    		document.getElementById("formdetailcode").value="TTM";
    		window.parent.formCode.value="TTM";
    		window.parent.formName.value="Tax Type Master";
    		
  });
	
	function funFocus(){
		document.getElementById("ptmtype").focus();
	}
	
	function funReadOnly() {
		$('#frmptm input').attr('readonly', true);
		$('#ptmdate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmptm input').attr('readonly', false);
		$('#ptmdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#ptmdate').val()){
			$("#ptmdate").jqxDateTimeInput('val', $('#ptmdate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	    
	function funNotify(){
		alert(document.getElementById("ptmtype").value);
		if(document.getElementById("ptmtype").value==''){
			document.getElementById("errormsg").innerText="Tax Type is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  

</script>

<style>
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

#frmptm input[type="text"] {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    box-shadow: none !important;
    outline: none;
    width: 100%;
}

#frmptm input[type="text"]:focus {
    border-color: #007bff;
}

#frmptm input[readonly],
#frmptm input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.jqx-datetimeinput-input {
    height: 24px !important;
    line-height: 24px !important;
    margin-top: 0px !important;
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
    font-family: Arial, sans-serif !important;
    padding: 0 6px !important;
}
.jqx-action-button {
    height: 24px !important;
    top: 0px !important;
}
.jqx-widget-content {
    box-sizing: border-box !important;
}

.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

.modern-ui .middle-panel {
    border: 1px solid #c5d3e0;
    padding: 20px 10px 10px 10px;
    background: #ffffff;
    position: relative;
    border-radius: 4px;
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title {
    position: absolute;
    top: -12px;
    left: 10px;
    background: #ffffff;
    padding: 0 8px;
    color: #0056b3;
    font-weight: bold;
    font-size: 14px;
    border-left: 3px solid #0056b3;
    z-index: 2;
    line-height: normal;
}

.modern-ui .field-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 0;
    flex-wrap: nowrap;
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    flex-shrink: 0;
}
</style>
</head>
<!-- onload="setValues();" -->
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmptm" action="saveptmAction" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui">

        <!-- Tax Type Details Panel -->
        <div class="middle-panel">
            <span class="middle-panel-title">Tax Type Details</span>

            <div class="field-row">
                <label class="lbl-right" style="width:50px;">Date</label>
                <div style="width:150px; flex-shrink:0;">
                    <div id="ptmdate" name="ptmdate" value='<s:property value="ptmdate"/>'></div>
                </div>

                <label class="lbl-right" style="width:70px; margin-left:15px;">Doc No.</label>
                <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:150px; flex-shrink:0;">

                <label class="lbl-right" style="width:50px; margin-left:15px;">Type</label>
                <input type="text" name="ptmtype" id="ptmtype" placeholder="Tax Type" value='<s:property value="ptmtype"/>' style="flex:1; min-width:0;">

                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' />
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
            </div>
        </div>

        <!-- Grid -->
        <div class="middle-panel">
            <span class="middle-panel-title">Tax Types</span>
            <div id="grpgrid" class="grid-container">
                <jsp:include page="typeGrid.jsp"></jsp:include>
            </div>
        </div>

        <input type="hidden" name="hidfgmdate" id="hidfgmdate" value='<s:property value="hidfgmdate"/>'/>

    </div>
</form>
</div>
</body>
</html>