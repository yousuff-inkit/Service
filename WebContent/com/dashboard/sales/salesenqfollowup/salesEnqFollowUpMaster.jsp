 
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

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
.branch1 {
	color: black;
	 
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  
});

function funExportBtn(){
	   $("#enquirylist").jqxGrid('exportdata', 'xls', 'Sales Enquiry List');
	 }


function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("salesEnqFollwUpGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	
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
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}


function funupdate()
{
	 if(document.getElementById("cmbinfo").value=="")
	 {
		 $.messager.alert('Message','Select Process ','warning');   
		 return 0;
	 }
	 if($('#remarks').val()=="")
	 {
		 $.messager.alert('Message','Enter Remarks ','warning');   
		 return 0;
	 }
	 var remarkss = document.getElementById("remarks").value;
	 var nmax = remarkss.length;
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Remarks cannot contain more than 200 characters ','warning');   
   	
			return false; 
   	   } 
       var docno = document.getElementById("docno").value;
 	   var branchids = document.getElementById("branchids").value;
 	   var remarks = document.getElementById("remarks").value;
 	   var cmbinfo = document.getElementById("cmbinfo").value;
       var specno=document.getElementById("specno").value;
       var prodoc=document.getElementById("prodoc").value;
 	   var folldate =  $('#date').val();
 	 
 	   var cmbval = document.getElementById("cmbinfo");
 	   var cmbText = cmbval.options[cmbval.selectedIndex].text; 
	   $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	   if(r==false)
	   {
	     		return false; 
	   }
	   else{
	     		 savegriddata(docno,branchids,remarks,cmbinfo,folldate,cmbText,specno,prodoc);	
	     	}
	});
}
function savegriddata(docno,branchids,remarks,cmbinfo,folldate,cmbText,specno,prodoc)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			 var items=x.responseText;
			 if(parseInt(items)==1)
				 {
				   	$.messager.alert('Message', ' Successfully Updated ');
				  	funreload(event); 
					// $("#listdiv").load("salesqotfolowupGrid.jsp?docno="+docno);
					 $("#duedetailsgrid").jqxGrid('clear');
					 disitems();
				 }
			 else
				 {
				 $.messager.alert('Message', ' Not Updated ');
				 }
			}   
	}
		
x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&cmbText="+cmbText+"&specno="+specno+"&prodoc="+prodoc,true);

x.send();
		
}

function disitems()
{
	
	
	document.getElementById("cmbinfo").value="";
	document.getElementById("remarks").value="";
	 
	 $('#date').val(new Date());
	 $('#date').jqxDateTimeInput({ disabled: true});
	
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#Update').attr("disabled",true);
 
	
	 
	
}

</script>
</head>
<body onload="getBranch(); getProcess();disitems()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
 
	<%--  	<tr ><td align="right" > <label class="branch">Status</label></td> <td ><select id="statusselect" name="statusselect" style="width:70%;">
	<option value="All">All</option>
	<option value="PED">Pending</option>
		<option value="ORD">Sales Order</option>   
		
	
	 </select> </td></tr> --%>
	 
	 <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2">&nbsp;</td></tr> 
  
	 	 	 <tr ><td colspan="2" >
  <fieldset  style=background-color:#f5deb3;">  
	 <table width="100%" >
	 		<tr> <td  align="right"><label class="branch1">Process</label></td><td align="left">
 <select name="cmbinfo" id="cmbinfo" style="width:70%;" name="cmbinfo"  value='<s:property value="cmbinfo"/>'  >
       

</select></td></tr>

<tr><td  align="right" ><label class="branch1">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   </td></tr>

	 <tr><td align="right"><label class="branch1">Remarks </label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
 
	<tr><td  align="center" colspan="2"><input type="Button" name="Update" id="Update" class="myButton" value="Update" onclick="funupdate()">
 
	</td> </tr>

</table>	
	 	
	 	</fieldset></td></tr>

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
  
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="salesEnqFollwUpGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr>
		<td   ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>
	</table>
</tr>
</table>
	  <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
   <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'> 
   
    <input type="hidden" id="branchids" name="branchids" value='<s:property value="branchids"/>'> 
    <input type="hidden" id="specno" name="specno" value='<s:property value="specno"/>'>
    <input type="hidden" id="prodoc" name="prodoc" value='<s:property value="prodoc"/>'>
</div>
<div id="clinfowindow">
   <div ></div>
</div> 
</div>
</body>
</html>