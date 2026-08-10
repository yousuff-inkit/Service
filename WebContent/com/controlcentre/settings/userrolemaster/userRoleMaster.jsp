<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
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
/* Compact layout for User Role */
.compact-row {
    grid-template-columns: 100px 220px 100px 240px;
    gap: 12px;
}

/* Grid styling */
#userRoleDiv table {
    border-collapse: collapse;
    width: 100%;
    font-size: 13px;
}

#userRoleDiv th {
    background: #f1f3f6;
    padding: 10px;
    text-align: left;
    font-weight: 600;
}

#userRoleDiv td {
    padding: 10px;
    border-bottom: 1px solid #e5e9f2;
}

#userRoleDiv tr:hover {
    background: #f8fafc;
}
</style>
<script type="text/javascript">
      
		$(document).ready(function() {});
		
		function funReadOnly(){
			$('#frmUserRoleMaster input').attr('readonly', true );
			$("#jqxUserRole").jqxGrid({ disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmUserRoleMaster input').attr('readonly', false );
			$('#docno').attr('readonly', true);
			$("#jqxUserRole").jqxGrid({ disabled: false});
			
		    if ($("#mode").val() == "A") {
				$("#userRoleDiv").load("userRoleGrid.jsp");  
		    }
		    if ($("#mode").val() == "E") {
		    	$('#txtrolename').attr('readonly', true);  
		    }
		}
		
		function funSearchLoad(){
			 changeContent('rleMainSearch.jsp');  
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			document.getElementById("txtrolename").focus(); 	    		
		}
		
		function funNotify(){	
			/* User Role Grid Saving */
  	 		var rows = $("#jqxUserRole").jqxGrid('getrows');
  			 var length=0;
  			 for(var i=0 ; i < rows.length ; i++){
  				var chk=rows[i].mno;
  				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  					newTextBox = $(document.createElement("input"))
  				    .attr("type", "dil")
  				    .attr("id", "test"+length)
  				    .attr("name", "test"+length)
  					.attr("hidden", "true");
  					length=length+1;
  					
  				newTextBox.val(rows[i].mno+"::"+rows[i].menu_name+":: "+rows[i].add1+":: "+rows[i].edit+":: "+rows[i].del+":: "+rows[i].print+":: "+rows[i].attach+":: "+rows[i].excel+":: "+rows[i].email+":: "+rows[i].costing+":: "+rows[i].terms);
  				newTextBox.appendTo('form');
  				}
  			  }
  			$('#gridlength').val(length);
  			 /* User Role Grid Saving Ends*/ 
		    		
  			 return 1;
			} 
		  
		  function setValues(){
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			  
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			  var indexVal = document.getElementById("docno").value;
			  if(indexVal>0){
	          $("#userRoleDiv").load("userRoleGrid.jsp?roleid="+indexVal);
			  }
			  
			}
		
  </script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmUserRoleMaster"
      action="saveUserRoleMaster"
      method="post"
      autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="content-wrapper">

<!-- ================= USER ROLE CARD ================= -->
<div class="section-card">

    <!-- Title + Doc No -->
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">

        <div class="section-title" style="margin:0;">
            User Role Info
        </div>

        <div style="display:flex; align-items:center; gap:10px;">
            <label style="margin:0;">Doc No</label>
            <input type="text"
                   id="docno"
                   name="txtuserroledocno"
                   value='<s:property value="txtuserroledocno"/>'
                   tabindex="-1"
                   style="width:120px;">
        </div>

    </div>

    <!-- Compact Role + Email -->
    <div class="form-row compact-row">

        <label>Role</label>
        <input type="text"
               id="txtrolename"
               name="txtrolename"
               value='<s:property value="txtrolename"/>'
               style="width:200px;">

        <label>Email</label>
        <input type="text"
               id="txtemail"
               name="txtemail"
               placeholder="someone@example.com"
               value='<s:property value="txtemail"/>'
               style="width:220px;">

    </div>

</div>

<!-- ================= GRID SECTION ================= -->
<div class="section-card">

    <div id="userRoleDiv">
        <jsp:include page="userRoleGrid.jsp"></jsp:include>
    </div>

</div>

</div>

<!-- Hidden Fields -->
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>

</form>

<div id="roleDetailsWindow">
    <div></div>
</div>

</div>
</body>
</html>