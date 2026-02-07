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


<style type="text/css">

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
.hidden-scrollbar {
    overflow: auto;
    
    height: 500px;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {
		disable();
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
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
				  }})
				  
			});         
	
  function funreload(event){
	  var barchval = document.getElementById("cmbbranch").value;
	  var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 $("#overlay, #PleaseWait").show();  
	//	 $("#dailycollDiv").load("dailycollectiongrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&check=1");
	     $("#dailyjobsDiv").load("dailyjobsgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&check=1");
	  //   $("#dailyprogressDiv").load("jobprogressgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&check=1");
	    // $('#btnprint').attr("disabled",false);
  }                
  function disable(){
		 $('#btnprint').attr("disabled",true);
	}        
 	   function setValues(){
			 if($('#msg').val()!=""){   
				 
	   		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
		}
	   
	    function funExportBtn(){
		  
		  // JSONToCSVCon(data, 'Sales & Collection Report', true);

	        $("#dailyjobsDiv").excelexportjs({
					containerid: "dailyjobsDiv",   
					datatype: 'json',
					dataset: null,
					gridId: "jqxjobsgrid",
					columns: getColumns("jqxjobsgrid") ,   
					worksheetName:"JobWise Target"  
				});   
		} 
	    /* function  funPrint(){
			        var url=document.URL;
				        var reurl=url.split("dailysalesreport.jsp");
				        var win= window.open(reurl[0]+"printdailysalesreport?todate="+$('#todate').val()+"&fromdate="+$('#fromdate').val()+"&branch="+document.getElementById("cmbbranch").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        win.focus();
		}  
	    function  funPrintSumm(){
	        var url=document.URL;
		        var reurl=url.split("dailysalesreport.jsp");
		        var win= window.open(reurl[0]+"printsummaryreport?todate="+$('#todate').val()+"&fromdate="+$('#fromdate').val()+"&branch="+document.getElementById("cmbbranch").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus();   
        }
	    function funPrintSetUp(){
	    	 if (document.getElementById('rsumm').checked){    
	    		 funPrintSumm(); 
	    	 }else{
	    		 funPrint(); 
	    	 }
	    } */
</script>                      
</head>      
<body onload="getBranch();setValues();">         
<form id="frmdailysales" action="saveDailySales" method="post" autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>    
<table width="100%" >   
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  > 
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
   <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>  
                     <tr><td colspan="2">      
	 <input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
    <input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext1"/>' />
	 </td></tr > 
	  <tr hidden="true"><td colspan="2" align="center"><input type="checkbox" id="rsumm" name="summ"  value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;   
	  </td></tr>
	  <tr  hidden="true"> <td colspan="2" align="center"><input type="button" name="btnprint" id="btnprint" class="myButton" value="print" style="width: 80px;" onclick="funPrintSetUp();"/></td></tr>             
	 <tr><td colspan="2"></td></tr>
	             
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
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2">
      </td></tr> 
	 </table>         
	</fieldset>
</td>   
<td width="80%" class='hidden-scrollbar'>           
	<table width="100%"> 
	
	<tr><td>
		 <fieldset>
<legend>Sales</legend>
		 <div id="dailyjobsDiv"><jsp:include page="dailyjobsgrid.jsp"></jsp:include></div></fieldset></td></tr>
	 
	</table>   
	</td>
</tr>  
</table>   
</div>
</div> 
</form>
</body>
</html>         