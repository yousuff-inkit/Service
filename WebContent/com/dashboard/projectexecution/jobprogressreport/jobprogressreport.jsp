
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

</style>

<script type="text/javascript">

$(document).ready(function () {
	$('#loadgriddata').show();
	
	$('#sumloadgriddata').hide();
	
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

/* 
	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
 */	
 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
	 $('#clientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#clientsearch').jqxWindow('close');  
	 
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
	 
	 $('#client_name').dblclick(function(){
		   	
		   	 $('#clientsearch').jqxWindow('open');
			 clientSearchContent('clientSearch.jsp?', $('#clientsearch'));
		   		
		 });
	
	   
	  
});

     function clientSearchContent(url) {
               $.get(url).done(function (data) {
  
	           $('#clientsearch').jqxWindow('setContent', data);

    	}); 
         	} 
     
         	 

function funExportBtn(){
    

// 	JSONToCSVCon(projectstatusexcel, 'Project Status', true);


	    $("#loadgriddata").excelexportjs({
				containerid: "loadgriddata",   
				datatype: 'json',
				dataset: null,
				gridId: "jqxloaddataGrid",
				columns: getColumns("jqxloaddataGrid") ,   
				worksheetName:"Job Progress Report"  
			});   
	   }



function funsumm()
	{
	var summtype=document.getElementById("summtype").value;
		if(summtype=="sal" ||summtype=="daily"|| summtype=="weekly")
			{
			$('#loadgriddata').hide();
			
			$('#sumloadgriddata').show();
			
			}
		
		
		else
			{
			$('#loadgriddata').show();
			
			$('#sumloadgriddata').hide();
			}
		
		if(summtype=="sal"){
			
			$('#jqxsumloaddataGrid').jqxGrid('hidecolumn', 'jdate');
			$('#jqxsumloaddataGrid').jqxGrid('showcolumn', 'sal_name');
			$('#jqxsumloaddataGrid').jqxGrid('showcolumn', 'disper');
		}
		else{
			$('#jqxsumloaddataGrid').jqxGrid('showcolumn', 'jdate');
			$('#jqxsumloaddataGrid').jqxGrid('hidecolumn', 'sal_name');
			$('#jqxsumloaddataGrid').jqxGrid('hidecolumn', 'disper');
		}
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
	 	 
	  
		   var barchval = document.getElementById("cmbbranch").value;
	 var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var rds;
	 var type=document.getElementById("cmbjobtype").value;
	 var summtype=document.getElementById("summtype").value;
	 $("#overlay, #PleaseWait").show();
	 
	 if(summtype=="sal" ||summtype=="daily"|| summtype=="weekly" ) {
		
		 $("#sumloadgriddata").load("sumgridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&rds="+rds+"&summtype="+summtype+"&type="+type);
		 	
	 }
	 else
	 {
	 
	 $("#loadgriddata").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&type="+type+"&rds="+rds+"&summtype="+summtype);
	 
	 }	
	
	 
	  
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
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
   
<!--  		    <tr> -->
<!--                     <td  align="right"><label class="branch">Client</label></td> -->
<%--     				<td ><input type="text" name="client_name" id="client_name" style="width:70%;" placeholder="Press F3 for Search" onKeyDown="getclinfo(event);" value='<s:property value="client_name" />'></td> --%>
    
<!--                     </tr> -->
<%--                   <tr><td colspan="2" align="center"><textarea id="info" style="height:60px;width:200px;font-family:Tahoma;font-size:12px;resize:none" name="info"  readonly="readonly"  ><s:property value="info" ></s:property></textarea></td></tr>	 --%>
                   <tr>
                   		 <td align="right" ><label class="branch">Type</label></td>
					     <td align="left"><select id="cmbjobtype" name="cmbjobtype" style="width: 35%" value='<s:property value="cmbjobtype"/>'>
<!-- 					     <option value="">Select</option> -->
					     <option value="all">ALL</option>
					     <option value="full">FULL</option>
					     <option value="partial">PARTIAL</option>
					     </select></td></tr> 
					<tr>
					 <tr hidden="true">
                   		 <td align="right"><label class="branch">Summary</label></td>
					     <td align="left"><select id="summtype" name="summtype" onchange="funsumm();" value='<s:property value="summtype"/>'>
					     <option value="">Select</option>
					     <option value="job">Job wise</option>
					     <option value="sal">Salesman wise</option>
					     <option value="daily">Daily</option>
					     <option value="weekly">Weekly</option>
					     </select></td></tr> 
					<tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
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
       <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
	<input type="hidden" id="assigngrpid" name="assigngrpid" value='<s:property value="assigngrpid"/>'>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr>
		<td><div id="loadgriddata"><jsp:include page="gridDetails.jsp"></jsp:include> 
			</div></td></tr>
		<tr>
			  <td><div id="sumloadgriddata"  ><%-- <jsp:include page="sumgridDetails.jsp"></jsp:include> --%></div></td>
			 
		</tr>
	</table>
</tr>
</table>

</div>
  <div id="clientsearch">
   <div ></div>
</div>
<div id="assigngrpwindow">
   <div ></div>
</div>
</div>
</body>
</html>