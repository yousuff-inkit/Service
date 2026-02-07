<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Complaint</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript">
$(document).ready(function () {
	 document.getElementById('rdpending').checked=true;   
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    $("#cmbbranch").hide();
    $("#branchlabel").hide();
    $("#branchdiv").hide();
    getProcess();reportTypeChange();
     
});

function funreload(event){
	 $("#custcomp").jqxGrid('clear');
	 $("#overlay, #PleaseWait").show();
		 if(document.getElementById("rdpending").checked==true){
			 $("#custcompDiv").load("customercomplaintGrid.jsp?&type=1&check=1");
	 } else {
		 $("#custcompDiv").load("customercomplaintGrid.jsp?&type=2&check=1");
	 }
			
}

function getProcess() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbprocess").html(optionsbranch);
			
		} else {}
	}
	x.open("GET","getProcess.jsp", true);
	x.send();
}

function saveGridData(process,date,remarks,docno,processname,rdocno){
    //alert(date)
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
     			
			var items=x.responseText;
			if(items>0){
			$('#cmbprocess').val('');
			$('#date').val(new Date());
			$('#txtremarks').val('');
			 $("#documentDetailsGrid").jqxGrid('clear');
			 $("#custcomp").jqxGrid('clear');
				
			$.messager.alert('Message', '  Record Successfully Updated ', function(r){
		    });
			disable();
			}else{
				$.messager.alert('Message', '  Not Updated ', function(r){
	   });
     }
   }
}	
		
x.open("GET","saveData.jsp?process="+process+"&date="+date+"&remarks="+remarks+"&docno="+docno+"&processname="+processname+"&rdocno="+rdocno,true);
x.send();
		
}

function funUpdate(event){
	var process = $('#cmbprocess').val();
	var date =  $('#date').val();
	var remarks = $('#txtremarks').val();
	var docno = $('#docno').val();
	var processname = $("#cmbprocess option:selected").text().trim();
	var rdocno = $('#rdocno').val();
	
	if(process==''){
		 $.messager.alert('Message','Choose a Process.','warning');
		 return 0;
	 }

	 if(remarks==''){
		 $.messager.alert('Message','Please Enter Remarks.','warning');   
		 return 0;
	 }
	
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		saveGridData(process,date,remarks,docno,processname,rdocno);	
	     	}
	});
}
function reportTypeChange(){
	if(document.getElementById("rdpending").checked==true){
		$("#custcomp").jqxGrid('clear');
	    $("#documentDetailsGrid").jqxGrid('clear');
	    $('#txtremarks').attr('disabled', false);
		$('#date').attr('disabled', false);
		$('#cmbprocess').attr('disabled', false);
		$('#clear').attr('disabled', false);
		$('#btnupdate').attr('disabled', false);
		
	}	else if(document.getElementById("rdcompleted").checked==true){
		$("#custcomp").jqxGrid('clear');
		$("#documentDetailsGrid").jqxGrid('clear');
		$('#txtremarks').attr('disabled', true);
		$('#date').attr('disabled', true);
		$('#cmbprocess').attr('disabled', true);
		$('#clear').attr('disabled', true);
		$('#btnupdate').attr('disabled', true);
		
	}
}	

function funExportBtn(){
	if(document.getElementById("rdpending").checked==true){
		
	  $("#custcompDiv").excelexportjs({
		containerid: "custcompDiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "custcomp", 
		columns: getColumns("custcomp") ,   
		worksheetName:"Customer Complaint-Pending"
		});
	} else if(document.getElementById("rdcompleted").checked==true){
		  $("#custcompDiv").excelexportjs({
				containerid: "custcompDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "custcomp", 
				columns: getColumns("custcomp") ,   
				worksheetName:"Customer Complaint-Completed"
				});  
	  }
 }

function  funClearData(){  
	$('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');
	 $("#documentDetailsGrid").jqxGrid('clear');
	 $("#custcomp").jqxGrid('clear');
}
</script> 

<style type="text/css">
.rowgap{
 padding:20px;
 }
</style>

</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdpending" name="rdo" onchange="reportTypeChange();" value="rdpending"><label for="rdpending" class="branch">Pending</label></td>
       <td width="52%" align="center"><input type="radio" id="rdcompleted" name="rdo" onchange="reportTypeChange();" value="rdcompleted"><label for="rdcompleted" class="branch">Completed</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td align="right"><label class="branch">Process</label></td>
	 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:90%;" name="cmbprocess"  value='<s:property value="cmbprocess"/>'></select></td></tr>
     
       
     <tr><td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td></tr>
     <tr><td align="right"><label class="branch">Remarks</label></td>
	 <td align="left"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;height:20px;" value='<s:property value="txtremarks"/>'/></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	 <button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
      <tr><td><input type="hidden" name="rdocno" id="rdocno"  value='<s:property value="rdocno"/>'></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	 </table>
</fieldset>
 
</td>  
	<td width="80%">
	<table width="100%">
		<tr><td><div id="custcompDiv"><jsp:include page="customercomplaintGrid.jsp"></jsp:include> </div></td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td><div id="docdetailsDiv"><jsp:include page="FollowUpGrid.jsp"></jsp:include> </div></td></tr>
	
	</table>
	</td>
</tr>
</table>

</div>
</div>
</body>
</html>	
