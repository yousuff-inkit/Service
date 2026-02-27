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
	   document.getElementById("formdet").innerText="Location(LOC)";
		 document.getElementById("formdetail").value="Location";
		 document.getElementById("formdetailcode").value="LOC";
		 window.parent.formCode.value="LOC";
		 window.parent.formName.value="Location";
    });
        function funReadOnly(){
	       $('#frmLocation input').attr('readonly', true );
	       $('#frmLocation select').attr('disabled', true );
	       /* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
        }
        function funRemoveReadOnly(){
	       $('#frmLocation input').attr('readonly', false );
	       $('#frmLocation select').attr('disabled', false );
	       //$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
        }
      
        function funSearchLoad(){
			changeContent('locationSearch.jsp', $('#window')); 
		 }
        function getBranch()
        {
        	
        	var x=new XMLHttpRequest();
    		x.onreadystatechange=function(){
    		if (x.readyState==4 && x.status==200)
    			{
    			 	items= x.responseText;
    			 	//System.out.println(x.responseText);
    			 	items=items.split('***');
    			 	 var branchidItems=items[1].split(",");
    			 	var branchItems=items[0].split(",");
    		         var optionsbranch = '<option value="">--Select--</option>';
    		        for ( var i = 0; i < branchItems.length; i++) {
    		    	   optionsbranch += '<option value="' + branchidItems[i] + '">' + branchItems[i] + '</option>';
    		        }
    		        $("select#cmbbranchname").html(optionsbranch);
   			     $('#cmbbranchname').val($('#hidcmbbranchname').val()) ;

    			    }
    		       else
    			  {
    			  }
    	     }
    	      x.open("GET","getBranch.jsp",true);
    	     x.send();	
        }
        function setValues(){
        	
       	 if($('#msg').val()!=""){
    		   $.messager.alert('Message',$('#msg').val());
    		  }

        }
        function funFocus()
        {
        	document.getElementById("cmbbranchname").focus();
        		
        }
        $(function(){
            $('#frmLocation').validate({
                     rules: {
                   cmbbranchname: "required",
                    txtloccode:"required",
                    txtlocname:"required"/* ,
                    txttel1:{
                    	required:true,
                    	digits:true,
                    	minlength:12,
                    	maxlength:12
                    } */
                     },
                     messages: {
                      cmbbranchname: " *",
                      txtloccode:" *",
                      txtlocname:" *"/* ,
                      txttel1:{
                    	  required:" *",
                    	  digits:'Digits',
                    	  minlength:'Min 12',
                    	  maxlength:'Max 12'
                      } */
                     
                     }
            });});
         function funNotify(){
        return 1;
    	}
         function checkLocCode(value){
        	 var x=new XMLHttpRequest();
        		x.onreadystatechange=function(){
        		if (x.readyState==4 && x.status==200)
        			{
        			 	var items=x.responseText;
        			 	//alert(items.trim()!='undefine');
        			 	if(items.trim()!='undefine'){
        			 		document.getElementById("txtloccode").focus();
        			 		document.getElementById("errormsg").innerText="Location ID Already Exists";
        			 	}
        			 	else{
        			 		document.getElementById("txtlocname").focus();
        			 		document.getElementById("errormsg").innerText="";
        			 		
        			 	}
        			    }
        		       else
        			  {
        			  }
        	     }
        	      x.open("GET","checkLocCode.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
        	     x.send();
         }
</script>
</head>
<body onload="getBranch();funReadOnly();setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmLocation" action="saveActionLocation" autocomplete="off">

<jsp:include page="../../../../header.jsp" />

<div class="content-wrapper">

<div class="section-card">

<div class="section-title">Location Details</div>

<div class="form-row single">
    <label>Branch</label>
    <select id="cmbbranchname"
            name="cmbbranchname"
            style="width:320px;">
        <option></option>
    </select>
</div>

<div class="form-row">
    <label>Location</label>
    <input type="text"
           id="txtloccode"
           name="txtloccode"
           value='<s:property value="txtloccode"/>'
           style="width:150px;"
           onblur="checkLocCode(this.value);">

    <label>Name</label>
    <input type="text"
           id="txtlocname"
           name="txtlocname"
           value='<s:property value="txtlocname"/>'
           style="width:260px;">
</div>

<div class="form-row single">
    <label>Address</label>
    <input type="text"
           id="txtaddress"
           name="txtaddress"
           value='<s:property value="txtaddress"/>'
           style="width:350px;">
</div>

<div class="form-row single">
    <label>P.B.No</label>
    <input type="text"
           id="txtpbno"
           name="txtpbno"
           value='<s:property value="txtpbno"/>'
           style="width:200px;">
</div>

<div class="form-row">
    <label>Tel 1</label>
    <input type="text"
           id="txttel1"
           name="txttel1"
           value='<s:property value="txttel1"/>'
           style="width:180px;">

    <label>Tel 2</label>
    <input type="text"
           id="txttel2"
           name="txttel2"
           value='<s:property value="txttel2"/>'
           style="width:180px;">
</div>

<div class="form-row">
    <label>Fax 1</label>
    <input type="text"
           id="txtfax1"
           name="txtfax1"
           value='<s:property value="txtfax1"/>'
           style="width:180px;">

    <label>Fax 2</label>
    <input type="text"
           id="txtfax2"
           name="txtfax2"
           value='<s:property value="txtfax2"/>'
           style="width:180px;">
</div>

<div class="form-row single">
    <label>Email</label>
    <input type="text"
           id="txtemail1"
           name="txtemail1"
           value='<s:property value="txtemail1"/>'
           style="width:260px;">
</div>

<div class="form-row single">
    <label>Website</label>
    <input type="text"
           id="txtwebsite"
           name="txtwebsite"
           value='<s:property value="txtwebsite"/>'
           style="width:260px;">
</div>

</div>

</div>

<!-- Hidden Fields -->
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="hidcmbbranchname" name="hidcmbbranchname" value='<s:property value="hidcmbbranchname"/>'>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="mode" name="mode"/>

</form>

</div>
</body>
</html>