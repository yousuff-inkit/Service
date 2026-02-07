<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

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
</style>

<script type="text/javascript">

	$(document).ready(function () {
		$("#branchlabel").hide();
		$("#branchdiv").hide(); 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 	 
	     $('#indinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Industry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#indinfowindow').jqxWindow('close');
		  $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	  //   document.getElementById("rdtobecopied").checked=true;
	     
	   
	     $('#indcode').dblclick(function(){
			   
	    	 $('#indinfowindow').jqxWindow('open');
		        indSearchContent('getIndustry.jsp');
			   		
			 });
	});
	
	
	
	function funExportBtn(){
		
		$("#companylistDiv").excelexportjs({
			containerid: "companylistDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "companylistGridID", 
			columns: getColumns("companylistGridID") ,   
			worksheetName:"Company List"
			});	
	}
	
	
	function funreload(event){
		     
			 
			  $("#companylistGridID").jqxGrid('clear');
			  $("#companylistGridID").jqxGrid('addrow', null, {});
			  
				 $("#overlay, #PleaseWait").show();
			 	 $("#companylistDiv").load("companylistGrid.jsp?check=1");
				 
						 
		}
	
	function getUpdate(event){
		 var docno = $('#docno').val();
		 var company=$('#txtname').val();
		 var indcode=$('#indcode').val();
		 var date=$('#txtdate').val();

		if(company==''){
			 $.messager.alert('Message','Enter Company name','warning');
			 return 0;
		 }
		if(indcode==''){
			 $.messager.alert('Message','Select an Industry','warning');
			 return 0;
		 }
		if(date==''){
			 $.messager.alert('Message','Select an Date','warning');
			 return 0;
		 }
		
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 
				    
		     		 saveGridData(docno,company,indcode,date); 	
		     	}
		 });
	}
	
	function saveGridData(docno,company,indcode,date){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
if(items>0)
	{
	$.messager.alert('Message', '  Record Successfully Saved ', function(r){ });

	}
	else
		{
		$.messager.alert('Message', '  Not Saved ', function(r){ });

		}
			 
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&company="+company+"&indcode="+encodeURIComponent(indcode)+"&date="+encodeURIComponent(date),true);
	x.send();
	}
	
	function funClearInfo(){
		 $('#txtname').val('');
		 $('#docno').val('');
		 $('#indcode').val('');
		 $('#txtind').val('');
		 $('#indsrno').val('');

		 $("#companylistGridID").jqxGrid('clear');
		 $("#companylistGridID").jqxGrid('addrow', null, {});
		
		
		
		}
	 function getIndustry(event){
    	 var x= event.keyCode;
    	 if(x==114){
		  $('#indinfowindow').jqxWindow('open');
	        indSearchContent('getIndustry.jsp');
	     	 }
     }
	     	 
	function indSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#indinfowindow').jqxWindow('setContent', data);

	            	}); 
	  	}

</script>

</head>
<body >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="23%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		
    <tr><td align="right"><label class="branch">Name</label></td>
	<td align="left"><input type="text" id="txtname" name="txtname" style="width:100%;height:20px;"  value='<s:property value="txtname"/>' /></td></tr>
	 <tr >
	      <td align="right"><label class="branch">Industry </label></td>
	      <td ><input style="height:19px;" type="text" name="indcode" id="indcode" value='<s:property value="indcode"/>' onKeyDown="getIndustry(event);" readonly placeholder="Press F3 to Search">
      <input type="hidden" id="txtind" name="txtind" value='<s:property value="txtind"/>'>
	  <input type="hidden" id="indsrno" name="indsrno" value='<s:property value="indsrno"/>'></td>
	      
	      </tr>
	
	<tr >
	      <%-- <td align="right"><label class="branch">Date </label></td>
	      <td ><input style="height:19px;" type="text" name="txtdate" id="txtdate" value='<s:property value="txtdate"/>'> --%>
     <%--  <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'> --%>
      <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='txtdate' name='txtdate' value='<s:property value="txtdate"/>'></div>
	      </tr>
	<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2">&nbsp;</td></tr>
		
   
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;&nbsp;&nbsp;
	<button class="myButton" type="button" id="btnSave" name="btnSave" onclick="getUpdate(event);">Save</button></td></tr>
	<tr><td colspan="2"><input type="hidden" name="txtselecteddocs" id="txtselecteddocs" style="width:100%;height:20px;" value='<s:property value="txtselecteddocs"/>'>
	<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>' style="width:100%;height:20px;"/>
		<input type="hidden" id="docno" name="docno"  value='<s:property value="docno"/>' style="width:100%;height:20px;"/>
		
	</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>  
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="companylistDiv"><jsp:include page="companylistGrid.jsp"></jsp:include></div></td>
		</tr>
		
	</table>
</tr>
</table>
</div>

<div id="clientDetailsWindow">
	<div></div>
</div>
<div id="indinfowindow">
   <div ></div>
</div>
</div> 
</body>
</html>