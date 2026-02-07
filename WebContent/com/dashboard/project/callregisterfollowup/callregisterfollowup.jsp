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
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width: '105px', height: '19px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '105px', height: '19px',formatString:"dd.MM.yyyy"});
	$("#followupdate").jqxDateTimeInput({ width: '105px', height: '19px',formatString:"dd.MM.yyyy"});         
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	$('#todate').on('change', function (event) {
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		   if(fromdates<todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   return false;
		  }   
	 }); 	  
});

function funExportBtn(){
		$("#calldetaildiv").excelexportjs({
			containerid: "calldetaildiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "callDetailgrid", 
			columns: getColumns("callDetailgrid") , 
			worksheetName:"Call Register Followup"
			});
    }
function funreload(){
     var id=1;
     var complid=$('#complid').val();
	 var userid=$('#userid').val();
	 var ctype=$('#ctype').val();
	 var fromdate=$('#fromdate').val();
	 var todate=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
	 $("#callDetailgrid").jqxGrid('clear'); 
	 $("#overlay, #PleaseWait").show();
     $("#calldetaildiv").load("callregisterDetailGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&complid="+complid+"&userid="+userid+"&ctype="+ctype);
	}
 function flwupgridload(){     
	     var docno=$('#docno').val();   
	     var barchval=$('#brhid').val();    
	     $("#flwupDiv").load("callregisterfollowupGrid.jsp?barchval="+barchval+"&docno="+docno+"&id="+id);
	 }
      function funClear(){
		   $("#callDetailgrid").jqxGrid('clear'); 
		   $("#crmfollowupGrid").jqxGrid('clear');
		   document.getElementById("txtremarks").value="";   
		   document.getElementById("cmbprocess").value=""; 
		   $("#followupdate").val(new Date());       
	   }
      function funUpdate(event){
  		var date =  $('#followupdate').val();
  		var branchid = $('#brhid').val();            
  		var remarks = $('#txtremarks').val();
  		var docno = $('#docno').val();
  		var bibid = $('#cmbprocess').val();     
  		if(bibid==''){
  			 $.messager.alert('Message','Choose a Process.','warning');
  			 return 0;
  		 }

  		 if(docno=='')
  			{
  			 $.messager.alert('Message','Please select a document','warning');      
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
  		     		saveGridData(date,branchid,docno,remarks);	
  		     	}
  		});
  	}
  	function saveGridData(date,branchid,docno,remarks){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
				var items=x.responseText;
				if(parseInt(items)=="1")
				{	
				$('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtremarks').val('');
				flwupgridload();   
				$.messager.alert('Message', '  Record Successfully Updated ');
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
			
	x.open("GET","saveData.jsp?date="+date+"&branchid="+branchid+"&docno="+docno+"&remarks="+encodeURIComponent(remarks),true);    
	x.send();
	}   
</script>
</head>
<body onload="getBranch();" >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" >
<tr>
<td width="20%" style=" vertical-align: top;">
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		 <tr><td colspan="2"></td></tr>
         <tr><td width="20%" align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td></tr>
         <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td></tr>
         <tr><td colspan="2">&nbsp;</td></tr>
	     <tr><td colspan="2">&nbsp;</td></tr>
	     <tr><td colspan="2">&nbsp;</td></tr> 
		 <tr><td align="right"><label class="branch">Process</label></td>
		 <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:100%;" name="cmbprocess"  value='<s:property value="cmbprocess"/>'>
		 <option value="">--Select--</option><option value="1">Follow Up</option></select></td></tr>    
		 <tr><td align="right"><label class="branch">Date</label></td>              
	     <td align="left"><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td></tr>
	     <tr><td align="right"><label class="branch">Remarks</label></td>
		 <td align="left"><textarea id="txtremarks" name="txtremarks" style="width:100%;height:50px;" value='<s:property value="txtremarks"/>'></textarea></td></tr>
		 <tr><td colspan="2"></td></tr>   
		 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button></td></tr>
	     <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClear();"></td></tr>
	     <tr><td colspan="2">&nbsp;</td></tr>
	     <tr><td colspan="2">&nbsp;</td></tr> 
	     <tr><td colspan="2">&nbsp;</td></tr> 
	     <tr><td colspan="2">&nbsp;</td></tr> 
	     <tr><td colspan="2">&nbsp;</td></tr> 
	     <tr><td colspan="2">&nbsp;</td></tr> 
	     <tr><td>
               <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'>
               <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>    
         </td></tr>
	 </table>
	</fieldset>
</td>
<td width="80" style=" vertical-align: top;">
	<table width="100%">     
		<tr><td><div id="calldetaildiv"><jsp:include page="callregisterDetailGrid.jsp"></jsp:include></div></td></tr>
	    <tr><td><div id="flwupDiv"><jsp:include page="callregisterfollowupGrid.jsp"></jsp:include></div></td></tr>      
	</table>
	</td>
</tr>
</table>
</div>
</div>
</body>
</html>