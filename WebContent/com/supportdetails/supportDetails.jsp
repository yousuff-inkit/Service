<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		// $('#btnPrint').attr('disabled', true );$('#btnExcel').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#issueDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#issueTime").jqxDateTimeInput({ width: '50%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
		 
		 $('#employeeDetailsWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsWindow').jqxWindow('close'); 
		 
		 $('#userDetailsWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#userDetailsWindow').jqxWindow('close');
		 
		 $('#supportDetailsWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Support Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#supportDetailsWindow').jqxWindow('close');
		 
		 getCompany();getIssueCategory();
	});
	
	function EmployeeSearchContent(url) {
		$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function UserSearchContent(url) {
		$('#userDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsWindow').jqxWindow('setContent', data);
		$('#userDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function SupportSearchContent(url) {
		$('#supportDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#supportDetailsWindow').jqxWindow('setContent', data);
		$('#supportDetailsWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getCompany() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var companyItems = items[0].split(",");
  				var companyIdItems = items[1].split(",");
  				var optionstype = '<option value="">--Select--</option>';
  				for (var i = 0; i < companyItems.length; i++) {
  					optionstype += '<option value="' + companyIdItems[i] + '">'
  							+ companyItems[i] + '</option>';
  				}
  				$("select#cmbcompany").html(optionstype);
  				if ($('#hidcmbcompany').val() != null) {
  					$('#cmbcompany').val($('#hidcmbcompany').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCompany.jsp", true);
  		x.send();
  	}
	
	function getIssueCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var IssueNameItems = items[0].split(",");
  				var IssueIdItems = items[1].split(",");
  				var optionsproject = '<option value="">--Select--</option>';
  				for (var i = 0; i < IssueNameItems.length; i++) {
  					optionsproject += '<option value="' + IssueIdItems[i] + '">'
  							+ IssueNameItems[i] + '</option>';
  				}
  				$("select#cmbissuecategory").html(optionsproject);
  				if ($('#hidcmbissuecategory').val() != null) {
  					$('#cmbissuecategory').val($('#hidcmbissuecategory').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getIssueCategory.jsp", true);
  		x.send();
  	}
	
	function funSearchdblclick(){
		 $('#txtempname').dblclick(function(){
			  EmployeeSearchContent(<%=contextPath+"/"%>+"com/supportdetails/employeeDetailsSearchGrid.jsp");
			  });  
		 
		  $('#txtusername').dblclick(function(){
			  var company=$('#cmbcompany').val();
			  if(company==""){
	 				 document.getElementById("errormsg").innerText="Choose Company and Search User.";
	 				 return 0;
	 			 }
			  UserSearchContent(<%=contextPath+"/"%>+"com/supportdetails/userDetailsSearchGrid.jsp?company="+company);
			  });
		  
		  $('#txtsupportname').dblclick(function(){
			  SupportSearchContent(<%=contextPath+"/"%>+"com/supportdetails/supportDetailsSearchGrid.jsp");
			  });
		 
	}
	 
	
	 function funReadOnly(){
			$('#frmSupportDetails input').attr('readonly', true );
			$('#frmSupportDetails select').attr('disabled', true);
			$('#issueDate').jqxDateTimeInput({disabled: true});
			$('#issueTime').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmSupportDetails input').attr('readonly', false );
			$('#frmSupportDetails select').attr('disabled', false);
			$('#txtusername').attr('readonly', true );
			$('#txtempname').attr('readonly', true );
			$('#txtsupportname').attr('readonly', true );
			$('#issueDate').jqxDateTimeInput({disabled: false});
			$('#issueTime').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#issueDate').val(new Date());
				$('#issueTime').val(null);
			}
			
	 }
	 
	 function funSearchLoad(){
	     changeContent('esdMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#issueDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmSupportDetails').validate({
	                rules: {
	                cmbcompany:"required",
	                txtusername:"required",
	                txtempname:"required",
	                txtsupportname:"required",
	                txtissuedescription:{"required":true,maxlength:400},
	                txtremarks:{"required":true,maxlength:400}
	                 },
	                 messages: {
	                 cmbcompany:" *",
	                 txtusername:" *",
	                 txtempname:" *",
	                 txtsupportname:" *",
	                 txtissuedescription:{required:" *",maxlength:"    Max 400 chars"},
	                 txtremarks:{required:" *",maxlength:"    Max 400 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		  
		  /* Validation */
	    	
		  	 user=document.getElementById("txtusername").value;
			 if(user==""){
				 document.getElementById("errormsg").innerText="User Name is Mandatory.";
				 return 0;
			 }

		     employee=document.getElementById("txtempname").value;
			 if(employee==""){
				 document.getElementById("errormsg").innerText="Action Name is Mandatory.";
				 return 0;
			 }
			 
			 support=document.getElementById("txtsupportname").value;
			 if(support==""){
				 document.getElementById("errormsg").innerText="Support Name is Mandatory.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
			 
	    /* Validation Ends*/
				 
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidissueDate').val()){
				 $("#issueDate").jqxDateTimeInput('val', $('#hidissueDate').val());
			  }
		  
		  if($('#hidissueTime').val()){
				 $("#issueTime").jqxDateTimeInput('val', $('#hidissueTime').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("cmbstatus").value=document.getElementById("hidcmbstatus").value;
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		}
	  
	  function getUserName(event){
          var x= event.keyCode;
          if(x==114){
        	  var company=$('#cmbcompany').val();
			  if(company==""){
	 				 document.getElementById("errormsg").innerText="Choose Company and Search User.";
	 				 return 0;
	 			 }
			  UserSearchContent(<%=contextPath+"/"%>+"com/supportdetails/userDetailsSearchGrid.jsp?company="+company);
          }
          else{
           }
          }
	  
	  function getEmployeeName(event){
          var x= event.keyCode;
          if(x==114){
			  EmployeeSearchContent(<%=contextPath+"/"%>+"com/supportdetails/employeeDetailsSearchGrid.jsp");
          }
          else{
           }
          }
	  
	  function getSupportName(event){
          var x= event.keyCode;
          if(x==114){
        	  SupportSearchContent(<%=contextPath+"/"%>+"com/supportdetails/supportDetailsSearchGrid.jsp");
          }
          else{
           }
          }
	  
	  /* function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveCashPayment");
			     $("#docno").prop("disabled", false);
				
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();
						}
					   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    } */
	  
	  function clearUser(){
		  $("#txtuserid").val('');$("#txtusername").val('');
	  }
	  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSupportDetails" action="saveSupportDetails" method="post" autocomplete="off">
<jsp:include page="../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="12%"><div id="issueDate" name="issueDate"  value='<s:property value="issueDate"/>'></div>
    <input type="hidden" id="hidissueDate" name="hidissueDate" value='<s:property value="hidissueDate"/>'/></td>
    <td width="7%" align="right">Time</td>
    <td width="9%"><div id="issueTime" name="issueTime"></div>
    <input type="hidden" id="hidissueTime" name="hidissueTime" value='<s:property value="hidissueTime"/>'/></td>
    <td width="7%" align="right">Company Name</td>
    <td width="16%"><select id="cmbcompany" name="cmbcompany" style="width:73%;" onchange="clearUser();" value='<s:property value="cmbcompany"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbcompany" name="hidcmbcompany" value='<s:property value="hidcmbcompany"/>'/></td>
    <td width="5%" align="right">User Name</td>
    <td width="14%"><input type="text" id="txtusername" name="txtusername" style="width:91%;" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getUserName(event);" value='<s:property value="txtusername"/>'/>
    <input type="hidden" id="txtuserid" name="txtuserid" value='<s:property value="txtuserid"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="18%"><input type="text" id="docno" name="txtsupportdetailsdocno" style="width:60%;" value='<s:property value="txtsupportdetailsdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Issue Category</td>
    <td><select id="cmbissuecategory" name="cmbissuecategory" style="width:80%;" value='<s:property value="cmbissuecategory"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbissuecategory" name="hidcmbissuecategory" value='<s:property value="hidcmbissuecategory"/>'/></td>
    <td align="right">Issue Description</td>
    <td colspan="5"><input type="text" id="txtissuedescription" name="txtissuedescription" style="width:98%;" value='<s:property value="txtissuedescription"/>'/></td>
    <td align="right">Action Taken</td>
    <td><input type="text" id="txtempname" name="txtempname" style="width:90%;" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getEmployeeName(event);" value='<s:property value="txtempname"/>'/>
    <input type="hidden" id="txtempid" name="txtempid" value='<s:property value="txtempid"/>'/></td>
  </tr>
  <tr>
    <td align="right">Remarks</td>
    <td colspan="5"><input type="text" id="txtremarks" name="txtremarks" style="width:93%;" value='<s:property value="txtremarks"/>'/></td>
     <td align="right">Support</td>
    <td><input type="text" id="txtsupportname" name="txtsupportname" style="width:91%;" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getSupportName(event);" value='<s:property value="txtsupportname"/>'/>
    <input type="hidden" id="txtsupportid" name="txtsupportid" value='<s:property value="txtsupportid"/>'/></td>
    <td align="right">Status</td>
    <td><select id="cmbstatus" name="cmbstatus" value='<s:property value="cmbstatus"/>'>
      <option value="">--Select--</option>
      <option value=1>Open</option>
      <option value=2>Pending</option>
      <option value=0>Closed</option></select>
      <input type="hidden" id="hidcmbstatus" name="hidcmbstatus" value='<s:property value="hidcmbstatus"/>'/></td>
  </tr>
</table>
</fieldset>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>
	
<div id="employeeDetailsWindow">
	<div></div><div></div>
</div>  
				
<div id="userDetailsWindow">
	<div></div><div></div>
</div>  

<div id="supportDetailsWindow">
	<div></div><div></div>
</div>  
	
</div>
</body>
</html>