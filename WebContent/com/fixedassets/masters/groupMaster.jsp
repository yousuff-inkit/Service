<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style type="text/css">

html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    overflow-y: auto;
    font-family: 'Segoe UI', sans-serif;
    background: #eef1f5;
    color: #2d3748;
}


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
    padding: 18px 25px 25px 25px; 
    margin: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.06);
}


#mainBG > br {
    display: none;
}


.page-title {
    font-size: 22px;
    font-weight: 600;
    margin: 10px 0 15px 0; 
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

.primary-btn {
    background: #1e88e5;
    color: #ffffff;
    text-align: center;
}

.primary-btn:hover {
    background: #1565c0;
}

.primary-btn:active {
    transform: scale(0.98);
}
</style>
<script type="text/javascript">

$(document).ready(function () {     
	 $("#fgmdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	
	 //$('#jqxgroupgrid').jqxGrid({ disabled: true}); 
	 
	 $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountWindow').jqxWindow('close');
		
      		 $('#txtaccno').dblclick(function(){
		  	    $('#accountWindow').jqxWindow('open');
			    var url=document.URL;
			    var reurl=url.split("com/");
				  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp');
      		 }); 
      		document.getElementById("formdet").innerText="Group Master(FGM)";
    		document.getElementById("formdetail").value="Group Master";
    		document.getElementById("formdetailcode").value="FGM";
    		window.parent.formCode.value="FGM";
    		window.parent.formName.value="Group Master";
    		
  });
	
	function funFocus(){
		document.getElementById("fgmcode").focus();
	}
	
	function funReadOnly() {
		$('#frmgrp input').attr('readonly', true);
		$('#fgmdate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmgrp input').attr('readonly', false);
		$('#fgmdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#hidfgmdate').val()){
			$("#fgmdate").jqxDateTimeInput('val', $('#hidfgmdate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	$(function(){
	    $('#frmgrp').validate({
	             rules: {
	             salesmanid: {required:true,maxlength:4},
	             salesmanname: {required:true,maxlength:40},
	             txtaccname:{required:true},
	             telephone:{required:true,digits:true,minlength:12,maxlength:12},
	             salesmanmail:{email:true}
	             },
	             messages: {
	              salesmanid:{required:" *",maxlength:"Max 4 Chars."},
	              salesmanname:{required:" *",maxlength:"Max 40 Chars."},
	              txtaccname:{required:" *"},
	              telephone:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	              salesmanmail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("fgmname").value==''){
			document.getElementById("errormsg").innerText="Group Name is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function funSearchLoad(){
		changeContent('salesmanSearch.jsp'); 
	 }
 
</script>
</head>
<!-- onload="setValues();" -->
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmgrp" action="saveActiongrp" method="post" autocomplete="off">

<jsp:include page="../../../header.jsp" />

<!-- ================= TOP HEADER ================= -->
<div style="display:flex; align-items:center; width:100%; margin-bottom:15px;">

    <div class="page-title" style="margin:0;">
        Group Details
    </div>

    <div style="margin-left:auto; display:flex; align-items:center; gap:8px;">
        <label style="font-weight:600;">Doc No :</label>
        <input type="text"
               id="docno"
               name="docno"
               value='<s:property value="docno"/>'
               readonly
               tabindex="-1"
               style="width:160px;" />
    </div>

</div>

<!-- ================= GROUP DETAILS CARD ================= -->
<div class="section-card">

    <div class="form-row">

        <label>Date</label>
        <div>
            <div id="fgmdate"
                 name="fgmdate"
                 value='<s:property value="fgmdate"/>'></div>
        </div>

        <label>Code</label>
        <input type="text"
               name="fgmcode"
               id="fgmcode"
               placeholder="Group Code"
               value='<s:property value="fgmcode"/>'
               style="width:160px;" />

    </div>

    <div class="form-row single">

        <label>Name</label>
        <input type="text"
               name="fgmname"
               id="fgmname"
               placeholder="Group Name"
               value='<s:property value="fgmname"/>'
               style="width:300px;" />

    </div>

</div>

<!-- ================= GRID SECTION ================= -->
<div class="section-card">

    <div class="section-title">Group List</div>

    <div id="grpgrid">
        <jsp:include page="groupGrid.jsp"></jsp:include>
    </div>

</div>

<!-- ================= HIDDEN FIELDS ================= -->
<input type="hidden" name="hidfgmdate" id="hidfgmdate"
       value='<s:property value="hidfgmdate"/>'/>

<input type="hidden" name="mode" id="mode"
       value='<s:property value="mode"/>'/>

<input type="hidden" name="deleted" id="deleted"
       value='<s:property value="deleted"/>'/>

<input type="hidden" id="msg" name="msg"
       value='<s:property value="msg"/>'/>

</form>

</div>

<!-- WINDOWS -->
<div id="jqxSalesmanSearch1"></div>

<div id="accountWindow">
    <div></div>
    <div></div>
</div>

</body>
</html>