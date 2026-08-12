<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<s:head/>

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
    $("#date_accountmaster").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });

   

});
function funFocus(){

}
 function funReset() {

} 
function funReadOnly() {
	$('#frmAccountmaster input').attr('readonly', true);
	
		$('#localcurrency').attr('disabled', true);
		$('#ageingdetails').attr('disabled', true);
		$('#interbranch').attr('disabled', true);
		$('#category1').attr('disabled', true);
		$('#category2').attr('disabled', true);
		$('#category3').attr('disabled', true);
		$('#frmAccountmaster select').attr('disabled', true);
	
	
	
		 delvalueChange();
	
}
function funRemoveReadOnly() {
	$('#frmAccountmaster input').attr('readonly', true);
	$('#localcurrency').attr('disabled', true);
	$('#ageingdetails').attr('disabled', true);
	$('#interbranch').attr('disabled', false);
	$('#category1').attr('disabled', false);
	$('#category2').attr('disabled', false);
	$('#category3').attr('disabled', false);
	
	 if ($("#mode").val() =="A") {
		 $('#date_accountmaster').val(new Date());
		 document.getElementById("interbranch").checked = false;
		 $('#frmAccountmaster select').attr('disabled', true);
		 
		 var disother=document.getElementById("otherdis").value; 
		 //alert(""+disother);
				 if(disother==1)
			 {
					 $("table#main input").prop("disabled", false);
					 $("table#main input").prop("readonly", false);
					 $("table#main select").prop("disabled", false);
					 $('#category1').attr('disabled', false);
					 $('#category2').attr('disabled', true);
					 $('#category3').attr('disabled', true);
						 $("table#sub input").prop("readonly", true);
						
						 $("table#trans input").prop("readonly", true);
				$('#interbranch').attr('disabled', true);
			 }
		 if(disother==2)
		 {
			 $("table#sub input").prop("disabled", false);
			 $("table#sub input").prop("readonly", false);
			 $("table#sub select").prop("disabled", false);
			 $('#subaccgpname').attr('readonly', true);
			 $('#category2').attr('disabled', false);
		 $('#category1').attr('disabled', true);
			$('#category3').attr('disabled', true);

			 $("table#trans input").prop("readonly", true);
			
			 $("table#main input").prop("readonly", true);
			$('#interbranch').attr('disabled', true);
		 }
		 if(disother==3)
		 {
			 $("table#trans input").prop("disabled", false);
			 $("table#trans input").prop("readonly", false);
			 $("table#trans select").prop("disabled", false);
			 $('#transcaccgpname').attr('readonly', true);
			 
			 $('#category3').attr('disabled', false);
		    $('#category1').attr('disabled', true);
			$('#category2').attr('disabled', true);
			 $("table#sub input").prop("readonly", true);
		
	
			 $("table#main input").prop("readonly", true);
			$('#interbranch').attr('disabled', false);
		 }
		 
	 }
	 if ($("#mode").val() =="E") {
		
		 $('#frmAccountmaster input').attr('readonly', false);
		 $('#frmAccountmaster select').attr('readonly', false);
		
		 var disother=document.getElementById("otherdis").value; 
		 //alert(""+disother);
				 if(disother==1)
			 {
					 $("table#main input").prop("disabled", false);
					 $("table#main select").prop("disabled", false);
					 $('#category1').attr('disabled', false);
					 $('#category2').attr('disabled', true);
						$('#category3').attr('disabled', true);
						 $("table#sub input").prop("readonly", true);
						
						 $("table#trans input").prop("readonly", true);
				$('#interbranch').attr('disabled', true);
			 }
		 if(disother==2)
		 {
			 $("table#sub input").prop("disabled", false);
			 $("table#sub select").prop("disabled", false);
			 $('#subaccgpname').attr('readonly', true);
			 $('#category2').attr('disabled', false);
		 $('#category1').attr('disabled', true);
			$('#category3').attr('disabled', true);

			 $("table#trans input").prop("readonly", true);
			
			 $("table#main input").prop("readonly", true);
			$('#interbranch').attr('disabled', true);
		 }
		 if(disother==3)
		 {
			 $("table#trans input").prop("disabled", false);
			 $("table#trans select").prop("disabled", false);
			 $('#transcaccgpname').attr('readonly', true);
			 
			 $('#category3').attr('disabled', false);
		    $('#category1').attr('disabled', true);
			$('#category2').attr('disabled', true);
			 $("table#sub input").prop("readonly", true);
		
	
			 $("table#main input").prop("readonly", true);
			$('#interbranch').attr('disabled', false);
		 }
		 
	 }
	 if ($("#mode").val() =="D") {
			$('#frmAccountmaster input').attr('readonly', false);
			
			$('#localcurrency').attr('disabled', false);
			$('#ageingdetails').attr('disabled', false);
			$('#interbranch').attr('disabled', false);
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
			 $("table#trans input").prop("disabled", false);
			 $("table#trans select").prop("disabled", false);
			 $("table#main input").prop("disabled", false);
			 $("table#main select").prop("disabled", false);
			 $("table#sub input").prop("disabled", false);
			 $("table#sub select").prop("disabled", false);
			$('#frmAccountmaster select').attr('disabled', false);
	 }
	
	$('#docno').attr('readonly', true);
}
function funSearchLoad(){
	
	changeContent('masterSearch.jsp', $('#window')); 
 }
function fundisable(){
	
	
	if (document.getElementById('category1').checked) {
		$('#frmAccountmaster input').attr('readonly', false);
		 $("table#sub input").prop("disabled", true);
		 $("table#sub select").prop("disabled", true);
		 $("table#trans input").prop("disabled", true);
		 $("table#trans select").prop("disabled", true);
		 $("table#main input").prop("disabled", false);
		 $("table#main select").prop("disabled", false);
		 document.getElementById('subaccgpname').value="";
		 document.getElementById('subacccode').value="";
		 document.getElementById('subaccname').value="";
		 document.getElementById('transcaccgpname').value="";
		 document.getElementById('transacccode').value="";
		 document.getElementById('transaccname').value="";
		 $('#docno').attr('readonly', true);
		// radiotick for tick 
		
		
		 document.getElementById('otherdis').value=1;
		 document.getElementById('radiotick').value=1;
		
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 
		 document.getElementById('maindel').value=1;
		 
		 document.getElementById('main_account').value="mainacc";
		 
		
		
		
		}
	else if (document.getElementById('category2').checked) {
		$('#frmAccountmaster input').attr('readonly', false);
		 $("table#main input").prop("disabled", true);
		 $("table#main select").prop("disabled", true);
		 $("table#trans input").prop("disabled", true);
		 $("table#trans select").prop("disabled", true);
		 $("table#sub input").prop("disabled", false);
		 $("table#sub select").prop("disabled", false);
		 $('#subaccgpname').attr('readonly', true);
		 $('#docno').attr('readonly', true);
		 document.getElementById('mainacccode').value="";
		 document.getElementById('mainacconame').value="";
		 document.getElementById('transcaccgpname').value="";
		 document.getElementById('transacccode').value="";
		 document.getElementById('transaccname').value="";
		 document.getElementById('otherdis').value=2;
		 document.getElementById('radiotick').value=2;
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 document.getElementById('maindel').value=2;
		 
		 document.getElementById('sub_account').value="subacc";
		 
		}
	else if (document.getElementById('category3').checked) {
		$('#frmAccountmaster input').attr('readonly', false);
		$("table#main input").prop("disabled", true);
		 $("table#main select").prop("disabled", true);
		 $("table#sub input").prop("disabled", true);
		 $("table#sub select").prop("disabled", true);
		 $("table#trans input").prop("disabled", false);
		 $("table#trans select").prop("disabled", false);
		 $('#transcaccgpname').attr('readonly', true);
		 document.getElementById('mainacccode').value="";
		 document.getElementById('mainacconame').value="";
		 document.getElementById('subaccgpname').value="";
		 document.getElementById('subacccode').value="";
		 document.getElementById('subaccname').value="";
		 document.getElementById('otherdis').value=3;
			document.getElementById('radiotick').value=3;
			 $('#docno').attr('readonly', true);	
			 document.getElementById('radiosaveval').value=1;
			 document.getElementById("errormsg").innerText=""; 
			 document.getElementById('maindel').value=3;
			 
			 document.getElementById('tran_account').value="tranacc";
			 
		}
	

	 }
	 
function funhidden(){
	
	
	
	 if (document.getElementById('interbranch').checked) {
		 document.getElementById('intertick').value=1;
		 
		$("#branch").prop("hidden", false);
	}
	else {
		document.getElementById('intertick').value="";
		$("#branch").prop("hidden", true);
	} 
}

function getHead() {
	
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var headItems = items[0].split(",");
			var headIdItems = items[1].split(",");
			var optionsauth = '';
			optionsauth += '<option value="">-- select -- </option>';
			for (var i = 0; i < headItems.length; i++) {
				optionsauth += '<option value="' + headIdItems[i] + '">'
						+ headItems[i] + '</option>';
			}
			$("select#mainaccgroup").html(optionsauth);
			
			 delvalueChange();
		} else {
		}
	}
	x.open("GET", "getMain.jsp", true);
	x.send();
	
}
function getMainac() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var mainacItems = items[0].split(",");
			var mainacIdItems = items[1].split(",");
			var optionsauth = '';
			optionsauth += '<option value=""> -- select --</option>';
			for (var i = 0; i < mainacItems.length; i++) {
				//alert(mainacIdItems[i]);
				optionsauth += '<option value="' + mainacIdItems[i] + '">'
						+ mainacItems[i] + '</option>';
			}
			//$("select#mainaccountgroup").html(optionsauth);
			$("select#subaccgroup").html(optionsauth);
			
			$("select#tansaccgroup").html(optionsauth);
			
			 delvalueChange();
		} 
		else {
		}
	}
	x.open("GET", "getSubTranAccmain.jsp", true);
	x.send();
	
}



function getAcgroup(value,check)
{

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	
		 	if (check==1)
		 		{
		 		
		 		 $('#subaccgpname').val(items) ;
		 		}		 		
		 	else if (check==2)
		 		{
		 	
		 		 $('#transcaccgpname').val(items) ;
		 		}
		 }
	       else
		  {
		  }
    }
     x.open("GET","disAcgroup.jsp?subaccountgroup="+value,true);
    x.send();
   
  }
function funChkButton(){

	
	
	//frmAccountmaster.submit();		
}

/* function checkden(tran)
{
	
	
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();

		
				if(parseInt(items)==255 || parseInt(items)==340)
					{
					
					document.getElementById("errormsg").innerText=" Transaction  ";
					return 0;
					}
				
				
				else{
				
					 
					 if ($("#mode").val() =="view") {
							$('#category1').attr('disabled', false);
							$('#category2').attr('disabled', false);
							$('#category3').attr('disabled', false);
						 $('#mainaccgroup').attr('disabled', false);
					 }
					  
					 
				$('#frmAccountmaster').submit();
					
				}
				
				
				//setValues();
			} else {
			}
		}
		x.open("GET", 'checkden.jsp?tran='+tran, true);
		x.send();
} */
function funNotify(){
	
	//alert(document.getElementById("tansaccgroup").value);
	

	
	
	 if ($("#mode").val() =="A") {
		 var radval=document.getElementById("radiosaveval").value; 
		
		 if(radval=="")
			 {
			 document.getElementById("errormsg").innerText=" *Select One Account";
			 return 0;
			 }
		 
		 var codeval=document.getElementById("codeval").value; 
		 if(codeval==1)
		 {
			 document.getElementById("errormsg").innerText="Account Code Already Exists";
		 return 0;
		 }
		 else{
			 document.getElementById("errormsg").innerText="";
			
			 }
	         }
	 if($("#mode").val() =="E")
		 {
		 var codeval=document.getElementById("codeval").value; 
		 if(codeval==1)
		 {
			 document.getElementById("errormsg").innerText="Account Code Already Exists";
		 return 0;
		 }
		 else{
			 document.getElementById("errormsg").innerText="";
			
			 }
		 }
	/* 	var tran=document.getElementById("tansaccgroup").value;
		
		if(parseInt(tran)>0)
			{
			//alert("-"+tran);
			checkden(tran);
			
			}
		
		else{ */
			
	
	 
	 if ($("#mode").val() =="view") {
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
		 $('#mainaccgroup').attr('disabled', false);
	  /*  } */
	 
		}
	  return 1;
		
			
}

function maincheck()
{

	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";
 if(document.getElementById("mainacccode").value!=""){
	var code=document.getElementById("mainacccode").value;
	
	
	funtest(code);
	
	
}
 

 
else {} 
	
}
function subcheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";	
if(document.getElementById("subacccode").value!=""){
	var code=document.getElementById("subacccode").value;
	
	funtest(code);
	
	
}
else {}
	
}
function trancheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";
if(document.getElementById("transacccode").value!=""){
	var code=document.getElementById("transacccode").value;
	
	funtest(code);
	
	
}
else {}
	
}



   function funtest(code)
           {
	   var masterdoc=document.getElementById("docno").value;
	  
	var x=new XMLHttpRequest();
	
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 	
		 	
		 		 if(items!="")
		 		{
		 			document.getElementById("codeval").value=1;
		 			document.getElementById("errormsg").innerText="Account Code Already Exists";
		 			return  false;
		 			 
		 		}
		 		 else
		 			 {
		 			document.getElementById("codeval").value="";
		 			document.getElementById("errormsg").innerText="";
		 			return  true;
		 			 }
		 		
		 }
	       else
		  {
	    	   
		  }
    }
	x.open("GET", 'checkAcccode.jsp?code='+code+'&masterdoc='+masterdoc, true);
    x.send();
	}  
   function getbranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var headItems = items[0].split(",");
				var headIdItems = items[1].split(",");
				var optionsauth = '';
				for (var i = 0; i < headItems.length; i++) {
					optionsauth += '<option value="' + headIdItems[i] + '">'
							+ headItems[i] + '</option>';
				}
				$("select#branchone").html(optionsauth);
				if($('#interbr1').val()!="")
		 		{
		 		//alert("1");
		 		$('#branchone').val($('#interbr1').val());
		 		}
				//getSecbranch(second);
			} else {
			}
		}
		x.open("GET", "getbranch.jsp", true);
		x.send();
		
	}
   function getSecbranch(second)
   {
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var headItems = items[0].split(",");
				var headIdItems = items[1].split(",");
				var optionsauth = '';
				for (var i = 0; i < headItems.length; i++) {
					optionsauth += '<option value="' + headIdItems[i] + '">'
							+ headItems[i] + '</option>';
				}
				$("select#branchtwo").html(optionsauth);
				if($('#interbr2').val()!="")
				{
		 		//alert("2");
				$('#branchtwo').val($('#interbr2').val());
				}
				//setValues();
			} else {
			}
		}
		x.open("GET", 'secondBranch.jsp?second='+second, true);
		x.send();
   }
   function delvalueChange()
   {
 	
 	  if(document.getElementById("radiotick").value==1)
 		  {
 		 
 		  document.getElementById("category1").checked = true;
 		  }
 	  else if(document.getElementById("radiotick").value==2)
 		  {
 		  document.getElementById("category2").checked = true;
 		  }
 	 else if(document.getElementById("radiotick").value==3)
	  {
	  document.getElementById("category3").checked = true;
	  }
 	  
 	  if($('#checksetval').val()!="")
 	  {
 	 $('#mainaccgroup').val($('#checksetval').val());
 	  }
 
 	   if($('#subchecksetval').val()!="")
	  {
	 $('#subaccgroup').val($('#subchecksetval').val());
	  }
 	  if($('#tranchecksetval').val()!="")
	  {
	 $('#tansaccgroup').val($('#tranchecksetval').val());
	  }
 	
 	 if(document.getElementById("intertick").value==1)
	  {
	 
	  document.getElementById("interbranch").checked = true;
	  

	  }
 	 else
 		 {
 		document.getElementById("interbranch").checked = false;
 		  
 		 
 		 }
 
 
 	 
   }
   function funclear1()
   {
	   document.getElementById("subchecksetval").value=="";
	   document.getElementById("tranchecksetval").value=="";
	   
   }
   function funclear2()
   {
	   document.getElementById("checksetval").value=="";
	   document.getElementById("tranchecksetval").value=="";
	   
   }
   function funclear3()
   {
	   document.getElementById("checksetval").value=="";
	   document.getElementById("subchecksetval").value=="";
	   
   }

   
   
function setValues() {
	if($('#datehidden').val()){
		$("#date_accountmaster").jqxDateTimeInput('val', $('#datehidden').val());
	}

		if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	 delvalueChange();
}

function checkreq()
{
	
if(document.getElementById('radiotick').value==1)
	{
	

	if(document.getElementById("mainacconame").value=="")
		{ 
		
		
		 document.getElementById("errormsg").innerText=" *Enter Account Name";
		 return 0;
		
		}
	}
else  if(document.getElementById('radiotick').value==2)
{
     if(document.getElementById("subaccname").value=="")
	{
    	 
    	 document.getElementById("errormsg").innerText=" *Enter SubAccount Name";
    	 return 0;
	}
}
else  if(document.getElementById('radiotick').value==3)
{
    if(document.getElementById("transaccname").value=="")
	{ 
    	
    	document.getElementById("errormsg").innerText=" *Enter TraAccount Name";
    	return 0;
	}
}
else
	{
	 document.getElementById("errormsg").innerText="";
	}

}
function dismassge()
{
	document.getElementById("errormsg").innerText="";
	
	}
	

function funExcelBtn(){
    var url=document.URL;
    var reurl=url.split("accountsmaster");
    top.addTab("ChartOfAccounts",reurl[0]+"accountsmaster/chartOfAccount.jsp");
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
       
        return false;
    	}
    document.getElementById("errormsg").innerText="";  
    return true;
}	

</script>



<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
========================================================= */
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

#frmAccountmaster input[type="text"],
#frmAccountmaster select,
.textbox { 
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

#frmAccountmaster input[type="text"]:focus,
#frmAccountmaster select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmAccountmaster input[readonly],
#frmAccountmaster input:disabled,
#frmAccountmaster select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.myButton, .btn {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .btn:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.icon {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s;
}
.icon:hover {
    transform: scale(1.1);
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* CSS-only JQX Overrides for Alignment */
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

/* Middle Section Panels */
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
    margin-bottom: 10px; 
    flex-wrap: nowrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; 
}

.radio-group {
    display: flex;
    align-items: center;
    gap: 6px;
    margin-right: 15px;
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
}
</style>
</head>

<body onload="getHead();getMainac();getbranch();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>
    
    <div class='modern-ui hidden-scrollbar'>
        <form id="frmAccountmaster" action="saveAccountmaster" method="post" autocomplete="off">
            
            <!-- Header Row -->
            <div class="middle-panel" style="background: #fdfdfd; padding-top: 15px;">
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:60px; flex-shrink:0;">Date</label>
                    <div style="width: 125px; flex-shrink:0;">
                        <div id="date_accountmaster" name="date_accountmaster" value='<s:property value="date_accountmaster"/>'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; flex-shrink:0; margin-left: auto;">Doc No.</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' style="width:150px; flex-shrink:0;">
                </div>
            </div>

            <!-- Two Column Layout for Main & Sub Accounts -->
            <div style="display: flex; gap: 15px; margin-bottom: 15px;">
                
                <!-- Main Account Panel -->
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">
                        <label class="radio-group">
                            <input type="radio" id="category1" name="category" value="mainaccount" onchange="fundisable();" style="margin:0;">
                            Main Account
                        </label>
                    </span>
                    
                    <table width="100%" id="main" style="border-collapse: separate; border-spacing: 0 10px;">
                        <tr>
                            <td align="right" width="100"><label class="lbl-right">Account Group</label></td>
                            <td>
                                <select name="mainaccgroup" id="mainaccgroup" style="width:100%;" value='<s:property value="mainaccgroup"/>' onchange="funclear1();">
                                    <option value="-1">--Select--</option>
                                </select>
                            </td> 
                        </tr>
                        <tr>
                            <td align="right"><label class="lbl-right">Account Code</label></td>
                            <td><input type="text" name="mainacccode" id="mainacccode" style="width:100%;" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" onkeypress="javascript:return isNumber(event);"></td>
                        </tr>
                        <tr>
                            <td align="right"><label class="lbl-right">Account Name</label></td>
                            <td>
                                <input type="text" name="mainacconame" id="mainacconame" style="width:100%;" value='<s:property value="mainacconame"/>' onblur="dismassge()">
                                <input type="hidden" name="main_account" id="main_account" value='<s:property value="main_account"/>' />
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Sub Account Panel -->
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">
                        <label class="radio-group">
                            <input type="radio" id="category2" name="category" value="subaccount" onchange="fundisable();" style="margin:0;">
                            Sub Account
                        </label>
                    </span>
                    
                    <table width="100%" id="sub" style="border-collapse: separate; border-spacing: 0 10px;"> 
                        <tr>
                            <td align="right" width="100"><label class="lbl-right">Main Group</label></td>
                            <td style="display:flex; gap:8px;">
                                <select name="subaccgroup" id="subaccgroup" style="flex:1;" onChange="getAcgroup(this.value,1);" onfocus="funclear2();" value='<s:property value="subaccgroup"/>'> 
                                    <option value="-1">--Select--</option>
                                </select>
                                <input type="text" id="subaccgpname" name="subaccgpname" style="flex:1;" value='<s:property value="subaccgpname"/>' />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><label class="lbl-right">Account Code</label></td>
                            <td><input type="text" name="subacccode" id="subacccode" style="width:100%;" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" onkeypress="javascript:return isNumber(event);"></td>
                        </tr>
                        <tr>
                            <td align="right"><label class="lbl-right">Account Name</label></td>
                            <td>
                                <input type="text" name="subaccname" id="subaccname" style="width:100%;" value='<s:property value="subaccname"/>' onblur="dismassge()" />
                                <input type="hidden" name="sub_account" id="sub_account" value='<s:property value="sub_account"/>' />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Transaction Account Panel -->
            <div class="middle-panel" style="margin-bottom: 15px;">
                <span class="middle-panel-title">
                    <label class="radio-group">
                        <input type="radio" id="category3" name="category" value="transaction" onchange="fundisable();" style="margin:0;">
                        Transaction
                    </label>
                </span>

                <div style="display:flex; gap:15px; margin-bottom: 10px;">
                    <div style="flex:1;">
                        <table width="100%" id="trans" style="border-collapse: separate; border-spacing: 0 10px;">
                            <tr>  
                                <td align="right" width="100"><label class="lbl-right">Main Group</label></td>
                                <td style="display:flex; gap:8px;">
                                    <select id="tansaccgroup" name="tansaccgroup" style="flex:1;" onChange="getAcgroup(this.value,2);" value='<s:property value="tansaccgroup"/>' onfocus="funclear3();">
                                        <option value="-1">--Select--</option>
                                    </select>
                                    <input type="text" name="transcaccgpname" id="transcaccgpname" style="flex:1;" value='<s:property value="transcaccgpname"/>'>
                                </td>   
                            </tr>
                            <tr>
                                <td align="right"><label class="lbl-right">Account Code</label></td>
                                <td><input type="text" name="transacccode" id="transacccode" style="width:100%;" value='<s:property value="transacccode"/>' onblur="trancheck(this.value)" onkeypress="javascript:return isNumber(event);"></td>
                            </tr>
                            <tr>
                                <td align="right"><label class="lbl-right">Account Name</label></td>
                                <td>
                                    <input type="text" name="transaccname" id="transaccname" style="width:100%;" value='<s:property value="transaccname"/>' onblur="dismassge()">
                                    <input type="hidden" name="tran_account" id="tran_account" value='<s:property value="tran_account"/>' />
                                </td>
                            </tr>  
                        </table>
                    </div>
                    
                    <!-- Inter Branch Section within Transaction Panel -->
                    <div style="flex:1; border-left: 1px dashed #c5d3e0; padding-left: 15px; display:flex; flex-direction:column; justify-content:center;">
                        <label style="display:flex; align-items:center; gap:8px; font-weight:bold; color:#253858; font-size:13px; margin-bottom:10px;">
                            <input type="checkbox" id="interbranch" name="interbranch" onchange="funhidden();" value="1" style="margin:0;">
                            Inter branch Account 
                        </label>
                        
                        <div id="branch" hidden="true" style="display:flex; align-items:center; gap:8px; margin-top:5px;">
                            <label class="lbl-right" style="width:50px;">Branch</label>
                            <select name="branchone" id="branchone" required="required" style="flex:1;" value='<s:property value="branchone"/>' onClick="getSecbranch(this.value)">
                                <option value="0">--Select--</option> 
                            </select> 
                            <span>--</span> 
                            <select name="branchtwo" id="branchtwo" required="required" style="flex:1;" value='<s:property value="branchtwo"/>'>
                                <option value="0">--Select--</option> 
                            </select>  
                        </div>
                        
                        <div hidden="true" style="margin-top: 20px;">
                            <label><input type="radio" name="data" value="debit" checked> Debit</label><br>
                            <label><input type="radio" name="data" value="Credit"> Credit</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hidden Inputs -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
                <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>'> 
                <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>'>
                <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>'>
                <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>'>
                <input type="hidden" id="intertick" name="intertick" value='<s:property value="intertick"/>'>
                <input type="hidden" id="interbr1" name="interbr1" value='<s:property value="interbr1"/>'>
                <input type="hidden" id="interbr2" name="interbr2" value='<s:property value="interbr2"/>'>
                <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>'>
                <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>'>
                <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>'>
            </div>
            
        </form>
    </div>
</div>
</body>
</html>