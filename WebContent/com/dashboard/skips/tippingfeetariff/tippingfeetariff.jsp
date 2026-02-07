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
   	     $('#wastetypeWindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Waste Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#wastetypeWindow').jqxWindow('close');
	 
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtskipsize').dblclick(function(){
			  skipsizeSearchContent('skiptypeSearch.jsp');
		 });
		 $('#txtwastetype').dblclick(function(){
			  wastetypeSearchContent('wastetypeSearch.jsp');
		 });
	 	   $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");

	});
	
	function skipsizeSearchContent(url) {
	    $('#skipsizeWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#skipsizeWindow').jqxWindow('setContent', data);
	}); 
	}
	function wastetypeSearchContent(url) {
	    $('#wastetypeWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#wastetypeWindow').jqxWindow('setContent', data);
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
     	  skipSearchContent('skiptypeSearch.jsp');
       }
       else{}
       }
	function getWastetype(event){
	       var x= event.keyCode;
	       if(x==114){
	     	  wastetypeSearchContent('wastetypeSearch.jsp');
	       }
	       else{}
	       }
	   
	
	
	

	
	function funreload(event){

		 var skipsize = $('#txtskipsize').val();
		 var wastetype = $('#txtwastetype').val();
		 var disposalfee = $('#txtdisposalfee').val();
		 var weight = $('#txtweight').val();

		 $("#overlay, #PleaseWait").show();
		 
		 $("#tippingfeetariffDiv").load("tippingfeeTariffGrid.jsp?check=1");
		}
	
	function funSave(event){
		var doc_no = $('#docno').val();
		
		var skipsize = $("#txtskipsize").val();
		var skipsizeid =  $('#txtskipsizeid').val();
		 var wastetype = $('#txtwastetype').val();
		 var wastetypeid = $('#txtwastetypeid').val();
		 var disposalfee = $('#txtdisposalfee').val();
		 var weight = $('#txtweight').val();
		 if(wastetype==""){
			 $.messager.alert('Message','Choose a Waste Type.','warning');
			 return 0;
		 }
		 
		if(skipsize==""){
			 $.messager.alert('Message','Choose a Skip Size.','warning');
			 return 0;
		 }
		
		
		
		
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(doc_no,wastetypeid,skipsizeid,disposalfee,weight);	
		     	}
		});
	}
	

	    
	function saveGridData(doc_no,wastetypeid,skipsizeid,disposalfee,weight)	{

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				$('#docno').val('');
				$('#txtskipsize').val('');
				$('#skipsizeid').val('');
				$('#txtwastetype').val('');
				$('#txtwastetypeid').val('');
				$('#txtdisposalfee').val('');
				$('#txtweight').val('');
				

				if (document.getElementById("txtskipsize").value == "") {
			        $('#txtskipsize').attr('placeholder', 'Press F3 to Search'); 
			    }
				if (document.getElementById("txtwastetype").value == "") {
			        $('#txtwastetype').attr('placeholder', 'Press F3 to Search'); 
			    }
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
		     	funreload();

				}
		}
			
	x.open("GET","saveData1.jsp?doc_no="+doc_no+"&wastetypeid="+wastetypeid+"&skipsizeid="+skipsizeid+"&disposalfee="+disposalfee+"&weight="+weight,true);
	x.send();
			
	}
	
	function funExportBtn(){
		$("#tippingfeetariffDiv").excelexportjs({
			containerid: "tippingfeetariffDiv",
			datatype: 'json',
			dataset: null,
			gridId: "tippingFeeTariff",
			columns: getColumns("tippingFeeTariff") ,
			worksheetName:"Tipping Fee Tariff"
		}); 
	}
	function funClear()
	{
		$("#tippingFeeTariff").jqxGrid('clear'); 
		$('#txtdisposalfee').val('');
		$('#txtweight').val('');
		$('#txtskipsize').val('');
		$('#txtskipsizeid').val('');
        $('#txtskipsize').attr('placeholder', 'Press F3 to Search'); 
		$('#txtwastetype').val('');
		$('#txtwastetypeid').val('');
        $('#txtwastetype').attr('placeholder', 'Press F3 to Search'); 
		$('#docno').val('');

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
    <tr><td width="10%" align="right"><label class="branch">Waste Type</label></td>
	 <td align="left"><input type="text" id="txtwastetype" name="txtwastetype" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtwastetype"/>' onkeydown="getWastetype(event);"/>
	 <input type="hidden" id="txtwastetypeid" name="txtwastetypeid" style="width:100%;height:20px;" value='<s:property value="txtwastetypeid"/>'/></td></tr>
	 <tr><td width="10%" align="right"><label class="branch">Skip Size</label></td>
	 <td align="left"><input type="text" id="txtskipsize" name="txtskipsize" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtskipsize"/>' onkeydown="getSkip(event);"/>
	 <input type="hidden" id="txtskipsizeid" name="txtskipsizeid" style="width:100%;height:20px;" value='<s:property value="txtskipsizeid"/>'/></td></tr>
	
	<tr><td align="right"><label class="branch">Disposal Fee</label></td>
	 <td align="left"><input type="text" id="txtdisposalfee" name="txtdisposalfee" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtdisposalfee"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Weight(KG)</label></td>
	 <td align="left"><input type="text" id="txtweight" name="txtweight" style="width:40%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtweight"/>'/></td></tr>
	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 	 <tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnadd" name="btnadd" onclick="funSave(event);">Save</button>
	 		 	<button class="myButton" type="button" id="btnclr" name="btnclr" onclick="funClear();">Clear</button>
	 	
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
	 <input type="hidden" id="docno" name="docno" style="width:100%;height:20px;" value='<s:property value="docno"/>'/>
     <input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/>
     <tr></tr>
	 	
	 
	 </table>
	</fieldset>
</td>
<td width="100%">
	<table width="100%">
		<tr><td><div id="tippingfeetariffDiv"><jsp:include page="tippingfeeTariffGrid.jsp"></jsp:include></div><br/></td></tr>
	</table>
</tr>
</table>
</div>

<div id="skipsizeWindow">
	<div></div>
</div>
<div id="wastetypeWindow">
	<div></div>
</div>
</div> 
</body>
</html>