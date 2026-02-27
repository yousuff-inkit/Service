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
          $("#compaccdate1").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
          $("#compaccdate2").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
     document.getElementById("datediv").style.display="none";
     document.getElementById("formdet").innerText="Company(COM)";
	 document.getElementById("formdetail").value="Company";
	 document.getElementById("formdetailcode").value="COM";
	 window.parent.formCode.value="COM";
	 window.parent.formName.value="Company";
	 getTimezone();
      });
  
  function funFocus()
  {
  	document.getElementById("txtcompid").focus();
  		
  }
  
  $(function(){
      $('#frmCompany').validate({
               rules: {
               txtcompid:{
            	 required:true,
            	 maxlength:5
               } ,
              txtcompname:"required",
              cmbcurr:"required"/* ,
              txttel1:{
            	  required:true,
            	  digits:true,
            	  maxlength:12,
            	  minlength:12
              } */
              
               },
               messages: {
            	   txtcompid:{
            		   required:" *",
            		   maxlength:"max 5 chars"
            	   },
            	   txtcompname:" *",
            	   cmbcurr:" *"/* ,
            	   txttel1:{
            		   required:" *",
            		   digits:'Digits Only',
            		   maxlength:'Max 12 nos',
            		   minlength:'Min 12 nos'
            	   } */
               }
      });});
   function funNotify(){
  	 var date1 = $('#compaccdate1').jqxDateTimeInput('getDate');
		var date2 = $('#compaccdate2').jqxDateTimeInput('getDate');
  		if(date1>date2){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Accounting To Date cannot be less than From Date"
					$('#compaccdate1').jqxDateTimeInput('focus');
  			return 0;
  		}   
  		document.getElementById("errormsg").innerText="";
  		return 1;
	} 
   
   
  function funSearchLoad(){
		changeContent('companySearch.jsp', $('#window')); 
	 }
     function getCurrency()
	 {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var currItems=items[0].split(",");
		        var curridItems=items[1].split(",");
		        	var optionscurr = '<option value="">--Select--</option>';
		        for ( var i = 0; i < currItems.length; i++) {
		    	   optionscurr += '<option value="' + curridItems[i] + '">' + currItems[i] + '</option>';
		        }
		         $("select#cmbcurr").html(optionscurr);
		        // alert($('#hidcmbcurr').val());
			     $('#cmbcurr').val($('#hidcmbcurr').val()) ;
				   // alert($('#cmbcurr').val());
			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getCurrency.jsp",true);
	     x.send();
	    
        }
     
     
     
     function getTimezone()
	 {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var zoneItems=items[0].split(":::");
		        var zoneidItems=items[1].split(":::");
		        	var optionszone = '<option value="">--Select--</option>';
		        for ( var i = 0; i < zoneItems.length; i++) {
		    	   optionszone += '<option value="' + zoneidItems[i] + '">' + zoneItems[i] + '</option>';
		        }
		         $("select#cmbtimezone").html(optionszone);
		        // alert($('#hidcmbcurr').val());
		        if($('#hidcmbtimezone').val()!=""){
		        	$('#cmbtimezone').val($('#hidcmbtimezone').val()) ;	
		        }
			     
				   // alert($('#cmbcurr').val());
			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getTimezone.jsp",true);
	     x.send();
	    
        }
     
     //Ajax Method for checking Company Id Duplication
function checkcompid(value){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items=x.responseText;
		 	//alert(items.trim()!='undefine');
		 	if(items.trim()!='undefine'){
		 		document.getElementById("txtcompid").focus();
		 		document.getElementById("errormsg").innerText="Company ID Already Exists";
		 	}
		 	else{
		 		
		 		document.getElementById("errormsg").innerText="";
		 		
		 	}
		    }
	       else
		  {
		  }
     }
      x.open("GET","checkCompid.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
     x.send();
    
}
 
	function funReadOnly(){
		$('#frmCompany input').attr('readonly', true );
		$('#frmCompany select').attr('disabled', true );
		 $('#compaccdate1').jqxDateTimeInput({ disabled: true}); 
		 $('#compaccdate2').jqxDateTimeInput({ disabled: true});
	}
	function funRemoveReadOnly(){
		$('#frmCompany input').attr('readonly', false );
		$('#frmCompany select').attr('disabled', false );
		$('#compaccdate1').jqxDateTimeInput({ disabled: false}); 
		 $('#compaccdate2').jqxDateTimeInput({ disabled: false});
	}
	
    function setValues(){
    	
    		 if($('#msg').val()!=""){
        		   $.messager.alert('Message',$('#msg').val());
        		  }
    		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    			funSetlabel();
    	
    }
 </script> 
</head>
<body onload="getCurrency();setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmCompany" action="saveActionCompany" autocomplete="off">

<jsp:include page="../../../../header.jsp" />

<div class="section-card">

    <div class="section-title">Company Details</div>

    <div class="form-row">
        <label>Company</label>
        <input type="text"
               id="txtcompid"
               name="txtcompid"
               value='<s:property value="txtcompid"/>'
               style="width:140px;"
               onblur="checkcompid(this.value);"/>

        <label>Name</label>
        <input type="text"
               id="txtcompname"
               name="txtcompname"
               value='<s:property value="txtcompname"/>'
               style="width:260px;" />
    </div>

    <div class="form-row single">
        <label>Address</label>
        <input type="text"
               id="txtaddress"
               name="txtaddress"
               value='<s:property value="txtaddress"/>'
               style="width:350px;" />
    </div>

    <div class="form-row single">
        <label>P.B.No</label>
        <input type="text"
               id="txtpbno"
               name="txtpbno"
               value='<s:property value="txtpbno"/>'
               style="width:180px;" />
    </div>

    <div class="form-row">
        <label>Tel 1</label>
        <input type="text"
               id="txttel1"
               name="txttel1"
               value='<s:property value="txttel1"/>'
               style="width:180px;" />

        <label>Tel 2</label>
        <input type="text"
               id="txttel2"
               name="txttel2"
               value='<s:property value="txttel2"/>'
               style="width:180px;" />
    </div>

    <div class="form-row">
        <label>Fax 1</label>
        <input type="text"
               id="txtfax1"
               name="txtfax1"
               value='<s:property value="txtfax1"/>'
               style="width:180px;" />

        <label>Fax 2</label>
        <input type="text"
               id="txtfax2"
               name="txtfax2"
               value='<s:property value="txtfax2"/>'
               style="width:180px;" />
    </div>

    <div class="form-row single">
        <label>Email</label>
        <input type="text"
               id="txtemail1"
               name="txtemail1"
               value='<s:property value="txtemail1"/>'
               style="width:260px;" />
    </div>

    <div class="form-row single">
        <label>Website</label>
        <input type="text"
               id="txtwebsite"
               name="txtwebsite"
               value='<s:property value="txtwebsite"/>'
               style="width:260px;" />
    </div>

</div>
<div class="section-card">

    <div class="section-title">Account Settings</div>

    <div class="form-row">
        <label>Account Period</label>
        <div>
            <div id="compaccdate1"
                 name="compaccdate1"
                 value='<s:property value="compaccdate1"/>'></div>
            <input type="hidden"
                   id="hidcompaccdate1"
                   name="hidcompaccdate1"
                   value='<s:property value="hidcompaccdate1"/>'/>
        </div>

        <label>To</label>
        <div>
            <div id="compaccdate2"
                 name="compaccdate2"
                 value='<s:property value="compaccdate2"/>'></div>
            <input type="hidden"
                   id="hidcompaccdate2"
                   name="hidcompaccdate2"
                   value='<s:property value="hidcompaccdate2"/>'/>
        </div>
    </div>

    <div class="form-row">
        <label>Currency</label>
        <select name="cmbcurr" id="cmbcurr" style="width:160px;">
            <option value="">--Select--</option>
        </select>

        <label>Time Zone</label>
        <select name="cmbtimezone"
                id="cmbtimezone"
                style="width:220px;">
            <option value="">--Select--</option>
        </select>
    </div>

    <div class="form-row single">
        <label></label>
        <div class="style1" id="datediv">
            <span>Please select a valid Date</span>
        </div>
    </div>

</div>

<input type="hidden" id="hidcmbcurr" name="hidcmbcurr"
       value='<s:property value="hidcmbcurr"/>'/>

<input type="hidden" id="msg" name="msg"
       value='<s:property value="msg"/>'/>

<input type="hidden" id="docno" name="docno"
       value='<s:property value="docno"/>'/>

<input type="hidden" name="deleted" id="deleted"
       value='<s:property value="deleted"/>' hidden="true"/>

<input type="hidden" name="hidcmbtimezone" id="hidcmbtimezone"
       value='<s:property value="hidcmbtimezone"/>' hidden="true"/>

<input type="hidden" id="mode" name="mode"/>

</form>
</div>

</body>
</html>