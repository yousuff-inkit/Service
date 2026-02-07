<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script> 

<script type="text/javascript">

	$(document).ready(function () {
		 $('#skipsizeWindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Skip Size Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	     $('#skipsizeWindow').jqxWindow('close');
   	 
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtskipsize').dblclick(function(){
			  skipsizeSearchContent('skipsizeSearch.jsp');
		 });
	 	   $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");

	});
	
	function skipsizeSearchContent(url) {
	    $('#skipsizeWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#skipsizeWindow').jqxWindow('setContent', data);
	}); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	
	
  
	
	function getSkip(event){
       var x= event.keyCode;
       if(x==114){
     	  skipSearchContent('skipsizeSearch.jsp');
       }
       else{}
       }
	   
	
	
	

	
	function funreload(event){
		$('#cmbbranch').attr('hidden',true);

		 var branchval = document.getElementById("cmbbranch").value;
		 var skipsize = $('#txtskipsize').val();
		 var froms = $('#txtfrom').val();
		 var tos = $('#txtto').val();
		 var client = $('#txtclient').val();
		 var own = $('#txtown').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#skipTariffDiv").load("skipTariffGrid.jsp?check=1");
		}
	
	function funSave(event){
		var rowno = $('#txtrowno').val();
		
		var skipsize = $("#txtskipsize").val();
		var skipsizeid =  $('#txtskipsizeid').val();
		var froms = $('#txtfrom').val();
		var tos = $('#txtto').val();
		var client = $('#txtclient').val();
		var own = $('#txtown').val();
		
		if(skipsize==""){
			 $.messager.alert('Message','Choose a Skip Size.','warning');
			 return 0;
		 }
		if(froms > tos){
			 $.messager.alert('Message','From value can not be greater than To value','warning');
			 return 0;
		 }
		
		
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(rowno,skipsizeid,froms,tos,client,own);
		     	}
		     	
		});
	}
	

	    
	function saveGridData(rowno,skipsizeid,froms,tos,client,own)	{

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				$('#txtrowno').val('');
				$('#txtskipsize').val('');
				$('#skipsizeid').val('');
				$('#txtfrom').val('');
				$('#txtto').val('');
				$('#txtclient').val('');
				$('#txtown').val('');
				
				if (document.getElementById("txtskipsize").value == "") {
			        $('#txtskipsize').attr('placeholder', 'Press F3 to Search'); 
			    }
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
	     		funreload();

		}
		}
			
	x.open("GET","saveData.jsp?rowno="+rowno+"&skipsizeid="+skipsizeid+"&froms="+froms+"&tos="+tos+"&client="+client+"&own="+own,true);
	x.send();
			
	}
	
	function funExportBtn(){
		$("#skipTariffDiv").excelexportjs({
			containerid: "skipTariffDiv",
			datatype: 'json',
			dataset: null,
			gridId: "skipTariff",
			columns: getColumns("skipTariff") ,
			worksheetName:"skip Tariff"
		}); 
	}
	function funClearInfo(event)
	{
		$("#skipTariff").jqxGrid('clear'); 
		$('#txtskipsize').val('');
		$('#txtskipsizeid').val('');
        $('#txtskipsize').attr('placeholder', 'Press F3 to Search'); 
        $('#txtfrom').val('');
        $('#txtto').val('');
		$('#txtclient').val('');
        $('#txtown').val('');
		$('#txtrowno').val('');

     }
	
</script>
</head>
<body >
<div id="mainBG" class="homeContent"  data-type="background"> 
<div class='hidden-scrollbar' >
<table width="100%" >
<tr>
<td width="25%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2" width="10%">&nbsp;</td></tr>
    <tr><td width="10%" align="right"><label class="branch">Skip Size</label></td>
	 <td align="left"><input type="text" id="txtskipsize" name="txtskipsize" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtskipsize"/>' onkeydown="getSkip(event);"/>
	 <input type="hidden" id="txtskipsizeid" name="txtskipsizeid" style="width:100%;height:20px;" value='<s:property value="txtskipsizeid"/>'/></td></tr>
	<tr><td align="right"><label class="branch">From</label></td>
	 <td align="left"><input type="text" id="txtfrom" name="txtfrom" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtfrom"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">To</label></td>
	 <td align="left"><input type="text" id="txtto" name="txtto" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtto"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	 <td align="left"><input type="text" id="txtclient" name="txtclient" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtclient"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Own</label></td>
	 <td align="left"><input type="text" id="txtown" name="txtown" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtown"/>'/></td></tr>
	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnadd" name="btnadd" onclick="funSave(event);">Save</button>
	 	 <button class="myButton" type="button" id="btnclear" name="btnclear" onclick="funClearInfo(event);">Clear</button>
	 	 </td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>  
		            <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		              <tr><td colspan="2"> &nbsp;&nbsp; </td></tr> <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>  
		            <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		              <tr><td colspan="2"> &nbsp;&nbsp; </td></tr> <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>  
		            <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		              <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		       	 	 <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		       	    <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>  
		            <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>	
  	               <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
  	               <tr><td colspan="2"> &nbsp;&nbsp; </td></tr>
		           <tr><td colspan="2">  &nbsp;&nbsp;</td></tr> 
	 <tr><td colspan="2"><input type="hidden" id="txtacountno" name="txtacountno" style="width:100%;height:20px;" value='<s:property value="txtacountno"/>'/>
	 <input type="hidden" id="txtrowno" name="txtrowno" style="width:100%;height:20px;" value='<s:property value="txtrowno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <tr></tr>
	 	
	 
	 </table>
	</fieldset>
</td>
<td width="100%">
	<table width="100%">
		<tr><td><div id="skipTariffDiv"><jsp:include page="skipTariffGrid.jsp"></jsp:include></div><br/></td></tr>
	</table>
</tr>
</table>
</div>

<div id="skipsizeWindow">
	<div></div>
</div>
</div> 
</body>
</html>