<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    overflow-y: auto;
    font-family: 'Segoe UI', sans-serif;
    background: #eef1f5;
    color: #2d3748;
}

/* Thin modern scrollbar */
body::-webkit-scrollbar {
    width: 8px;
}

body::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 10px;
}

body::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}
#mainBG {
    background: #ffffff;
    border-radius: 14px;
    padding: 18px 25px 25px 25px; /* Reduced top padding */
    margin: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.06);
}

/* Remove unwanted gap after header include */
#mainBG > br {
    display: none;
}

.page-title {
    font-size: 22px;
    font-weight: 600;
    margin: 10px 0 15px 0; /* Reduced spacing */
    color: #2d3748;
}


.toolbar {
    display: flex;
    gap: 10px;
    margin-bottom: 18px;
}

.toolbar button {
    background: #f1f3f6;
    border: none;
    padding: 7px 16px;
    border-radius: 20px;
    font-size: 13px;
    cursor: pointer;
    transition: 0.2s ease;
}

.toolbar button:hover {
    background: #e2e6ea;
}


.section-card {
    background: #f5f7fa;
    border-radius: 14px;
    padding: 18px;
    margin-bottom: 20px;
}

.section-title {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 18px;
    padding-left: 10px;
    border-left: 4px solid #1e88e5;
    color: #2d3748;
}

.two-column {
    display: flex;
    gap: 20px;
}

.section-half {
    flex: 1;
}

.form-row {
    display: grid;
    grid-template-columns: 140px 1fr 140px 1fr;
    gap: 15px;
    margin-bottom: 14px;
    align-items: center;
}

.form-row.single {
    grid-template-columns: 140px 1fr;
}


input[type="text"],
select {
    height: 34px;
    border: 1px solid #d8dee9;
    border-radius: 8px;
    padding: 6px 12px;
    background: #ffffff;
    font-size: 14px;
    box-sizing: border-box;
    transition: 0.2s ease;
}

input[type="text"]:focus,
select:focus {
    border-color: #1e88e5;
    outline: none;
    box-shadow: 0 0 0 2px rgba(30,136,229,0.15);
}

label {
    font-weight: 600;
    font-size: 13px;
    color: #4a5568;
}

.table-section {
    margin-top: 25px;
}

.table-title {
    font-weight: 600;
    margin-bottom: 10px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e3e8ef;
}

.cr-table th {
    background: #f1f3f6;
    padding: 10px;
    font-size: 13px;
    text-align: left;
    font-weight: 600;
}

.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #edf2f7;
    font-size: 13px;
}

.cr-table tr:last-child td {
    border-bottom: none;
}


input[type="checkbox"] {
    transform: scale(1.05);
    margin-right: 6px;
}

@media (max-width: 1024px) {

    .two-column {
        flex-direction: column;
    }

    .form-row {
        grid-template-columns: 140px 1fr;
    }

}
</style>
<script type="text/javascript">
$(document).ready(function () {  
    //Date
    
      $("#date_province").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
	   document.getElementById("formdet").innerText="Province(PRV)";
		 document.getElementById("formdetail").value="Province";
		 document.getElementById("formdetailcode").value="PRV";
		 window.parent.formCode.value="PRV";
		 window.parent.formName.value="Province";
    });
        function funReadOnly(){
	       $('#frmProvince input').attr('readonly', true );
	       $('#frmProvince select').attr('disabled', true );
	        $('#date_province').jqxDateTimeInput({ disabled: true}); 
        }
        function funRemoveReadOnly(){
	       $('#frmProvince input').attr('readonly', false );
	       $('#frmProvince select').attr('disabled', false );
	       $('#docno').attr('readonly', true );
	       $('#date_province').jqxDateTimeInput({ disabled: false}); 
	      
        }
      
        function funSearchLoad(){
			changeContent('ProvinceSearch.jsp', $('#window')); 
		 }
        function getBranch()
        {
 
        }
       
        function setValues(){
        	
       	 if($('#msg').val()!=""){
    		   $.messager.alert('Message',$('#msg').val());
    		  }

        }
        function funFocus()
        {
        	//document.getElementById("cmbbranchname").focus();
        		
        }
 
         function funNotify(){
        return 1;
    	}
         function checkLocCode(value){
        	 
         }
</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmProvince" action="saveActionProvince" autocomplete="off">

<jsp:include page="../../../../header.jsp" />

<div class="content-wrapper">

<div class="section-title">Province Details</div>

<!-- Row 1 -->
<div class="form-row">
    <label>Date</label>
    <div id="date_province"
         name="date_province"
         value='<s:property value="date_province"/>'>
    </div>

    <label>Doc No</label>
    <input type="text"
           name="docno"
           id="docno"
           value='<s:property value="docno"/>'
           readonly="readonly"
           tabindex="-1"
           style="width:120px;">
</div>

<!-- Row 2 -->
<div class="form-row">
    <label>Code</label>
    <input type="text"
           id="txtprovincecode"
           name="txtprovincecode"
           value='<s:property value="txtprovincecode"/>'
           style="width:120px;"
           onblur="checkcompid(this.value);">

    <label>Name</label>
    <input type="text"
           id="txtprovincename"
           name="txtprovincename"
           value='<s:property value="txtprovincename"/>'
           style="width:240px;">
</div>

<!-- Hidden Fields -->
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="hidcmbbranchname" name="hidcmbbranchname" value='<s:property value="hidcmbbranchname"/>'>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>

</form>

</div>
</body>
</html>