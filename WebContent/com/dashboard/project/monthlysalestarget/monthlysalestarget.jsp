<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>  
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">
$(document).ready(function () {
	  document.getElementById('rsumm').checked=true;
	  document.getElementById('differentiater').value=1;            
	  $('#msrbrhDiv1').show();
	  $('#msrsmDiv2').hide();
	  $('#bhhider').show();
	  $('#smhider').hide();
	$('#branchlabel').hide();  
	$('#branchdiv').hide(); 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
   $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
   getYear();
}); 
function funreload(event){    
	 if(document.getElementById('rsumm').checked) {
		 $("#msrbrhDiv").load("msrBranchGrid.jsp?check="+1);  
		}
   else if(document.getElementById('rdet').checked) {    
	 $("#msrsmDiv").load("msrSalesmanGrid.jsp?check="+1);          
  }   
}        

 function setValues(){
		 if($('#msg').val()!=""){   
			 
 		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
 		  }
	}
 function funExportBtn(){
	 if(document.getElementById('rsumm').checked) {
		 $("#msrbrhDiv").excelexportjs({
			 containerid: "msrbrhDiv", 
			 datatype: 'json', 
			 dataset: null, 
			 gridId: "jqxmqrSubGrid", 
			 columns: getColumns("jqxmqrSubGrid") , 
			 worksheetName:"Monthly Sales Target - Branch"
			 });
		}
   else if(document.getElementById('rdet').checked) {    
	 $("#msrsmDiv").excelexportjs({
		 containerid: "msrsmDiv", 
		 datatype: 'json', 
		 dataset: null, 
		 gridId: "jqxmqrsalesmanGrid", 
		 columns: getColumns("jqxmqrsalesmanGrid") , 
		 worksheetName:"Monthly Sales Target - Salesman"
		 });
  }   
	}    
  function getYear() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbyear").html(optionsyear);
				if ($('#hidcmbyear').val() != null) {
					$('#cmbyear').val($('#hidcmbyear').val());
				}
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
  function getBranchs() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';  
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}  
				$("select#cmbbranchs").html(optionsbranch);
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","getBranch.jsp", true);   
		x.send();
	}
  function funSave(){
       var salid=$('#cmbsalesman').val();   
  	 var year=$('#cmbyear').val();     
  	 var month=$('#cmbmonth').val();
  	 var targetval=$('#targetval').val();
  	 var branch=$('#cmbbranchs').val();  
  	 var rowno=$('#rowno').val();
  	 var differentiater=document.getElementById('differentiater').value;
  	 var percentval=$('#percentval').val();
  	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		 $("#overlay, #PleaseWait").show();
		     		 funSaveData(rowno,year,month,targetval,branch,differentiater,salid,percentval);	   
		     	}
		 });
  }
  function funSaveData(rowno,year,month,targetval,branch,differentiater,salid,percentval){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText;     
		   if(parseInt(items)>=1)
			{
			   $.messager.alert('Message', ' Successfully Saved', function(r){
				});  
			     $('#cmbyear').val('');     
		    	 $('#cmbmonth').val('');   
		    	 $('#targetval').val('');
		    	 $('#cmbbranch').val('');
		    	 $('#rowno').val('');
		    	 $('#jqxmqrSubGrid').jqxGrid('clear');
		    	 $('#jqxmqrsalesmanGrid').jqxGrid('clear'); 
			   funreload();      
			} 
			else
			{
				$.messager.alert('Message', ' Not Saved', function(r){                   
				});
			}
		}                
		}      
		x.open("GET","saveData.jsp?rowno="+rowno+"&year="+year+"&salid="+salid+"&month="+month+"&targetval="+targetval+"&branch="+branch+"&differentiater="+differentiater+"&percentval="+percentval,true);                                               
		x.send();
	}
  function funClearData(){
 	 $('#cmbyear').val('');     
	 $('#cmbmonth').val('');
	 $('#targetval').val('');
	 $('#cmbbranch').val('');
	 $('#rowno').val('');
	 $('#percentval').val('');
	 $('#jqxmqrSubGrid').jqxGrid('clear'); 
	 $('#jqxmqrsalesmanGrid').jqxGrid('clear'); 
  }
function fundisable(){  
		if(document.getElementById('rsumm').checked) {
			document.getElementById('differentiater').value=1;
				   $('#msrbrhDiv1').show();
				   $('#msrsmDiv2').hide();
				   $('#bhhider').show();
				   $('#smhider').hide();
				}
		 else if(document.getElementById('rdet').checked) {
			 document.getElementById('differentiater').value=2;        
			      $('#msrsmDiv2').show();   
				  $('#msrbrhDiv1').hide(); 
				  $('#bhhider').hide();                   
				  $('#smhider').show();
		  }
}
function getsalesman() {
var x = new XMLHttpRequest();
x.onreadystatechange = function() {
	if (x.readyState == 4 && x.status == 200) {
		var items = x.responseText;
	//alert(items);
		items = items.split('####');
		
		var branchIdItems  = items[0].split(",");
		var branchItems = items[1].split(",");
		var optionsbranch = '<option value="">--Select--</option>';  
		for (var i = 0; i < branchItems.length; i++) {
			optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
					+ branchItems[i] + '</option>';
		}  
		$("select#cmbsalesman").html(optionsbranch);
	} else {
		//alert("Error");
	}  
}
x.open("GET","getsalesman.jsp", true);   
x.send();
}
	</script>
</head>
<body onload="getBranchs();setValues();getsalesman();">
<form id="frmFAList" action="frmFAList" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

  <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Branch</label>&nbsp;&nbsp;
	 <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Salesman</label></td></tr>      
	 <tr>
    <td width="29%" align="right"><label class="branch">Year</label></td>
    <td width="71%"><select id="cmbyear" name="cmbyear" style="width:80%;" value='<s:property value="cmbyear"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Month</label></td>
    <td><select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
      <option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td>
  </tr> 
   <tr id="bhhider">
    <td width="29%" align="right"><label class="branch">Branch</label></td>   
    <td width="71%"><select id="cmbbranchs" name="cmbbranchs" style="width:80%;" value='<s:property value="cmbbranchs"/>'>
      <option value="">--Select--</option></select></td>
  </tr>  
   <tr id="smhider">       
    <td width="29%" align="right"><label class="branch">Salesman</label></td>   
    <td width="71%"><select id="cmbsalesman" name="cmbsalesman" style="width:80%;" value='<s:property value="cmbsalesman"/>'>  
      <option value="">--Select--</option></select></td>           
  </tr>   
  <tr>
    <td width="29%" align="right"><label class="branch">Target Value</label></td>
    <td width="71%"><input type="text" id="targetval" name="targetval" style="width:80%;height:20%;text-align:right" value='<s:property value="targetval"/>'/>
  </tr>  
  <tr>
    <td width="29%" align="right"><label class="branch">GP%</label></td>
    <td width="71%"><input type="text" id="percentval" name="percentval" style="width:80%;height:20%;text-align:right" value='<s:property value="percentval"/>'/>
  </tr>  
  <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnUpdate" name="btnUpdate" onclick="funSave();">Save</button></td></tr>
	<tr style="height:239px"><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">
     <input type="hidden" id="rowno" name="rowno" style="width:100%;height:20px;" value='<s:property value="rowno"/>'/>  
     <input type="hidden" id="differentiater" name="differentiater" style="width:100%;height:20px;" value='<s:property value="differentiater"/>'/>       
     </td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr id="msrbrhDiv1">    
			 <td>  <div id="msrbrhDiv"><jsp:include page="msrBranchGrid.jsp"></jsp:include></div> </td>
		</tr>
		<tr id="msrsmDiv2">
		     <td><div id="msrsmDiv"><jsp:include page="msrSalesmanGrid.jsp"></jsp:include></div><br/></td>
		</tr> 
	</table>
</tr>
</table>
</div>
<div id="assetwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>