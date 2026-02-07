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

 <style type="text/css">
.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>


<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	      $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#ptypewindow').jqxWindow('close');
	     
	});

	function funExportBtn(){
		
		 JSONToCSVCon(padata, 'Product Availability', true);
				 }
	
	
	function funreload(event){

		var branchid=document.getElementById("cmbbranch").value;
		var uptodate=$('#uptodate').jqxDateTimeInput('val');	 
	
		$("#overlay, #PleaseWait").show();
		$("#subgridiv").load("subgrid.jsp?uptodate="+uptodate+"&branchid="+branchid+"&id=1");
			 
		}
	
	function funClearData(){
		$('#propertydet').jqxGrid('clear');
		$('#pagrid').jqxGrid('clear');
	}
	
</script>
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
		<tr>
	 
	 <td align="right"><label class="branch">&nbsp;</label></td>
     <td align="left"><div hidden="true" id="uptodate" name="uptodate" value='<s:property value="uptodate"/>' ></div></td></tr> 
	 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2"><div id="subgridiv"><jsp:include page="subgrid.jsp"></jsp:include></div></td></tr>
	<tr><td colspan="2" align="center"><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td>
			 <input type="hidden" name="hidbrandid" id="hidbrandid">
			</td></tr>
			  
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="propertydiv"><jsp:include page="propertyAvailabilityGrid.jsp"></jsp:include></div></td> 
		</tr>
		   
	</table>
</tr>
</table>
<div id="ptypewindow">
<div></div>
</div>


</div>
</div>
</body>
</html>