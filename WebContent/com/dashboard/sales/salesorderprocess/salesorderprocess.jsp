 
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


 
.myButton1 {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #637aad), color-stop(1, #5972a7));
	background:-moz-linear-gradient(top, #637aad 5%, #5972a7 100%);
	background:-webkit-linear-gradient(top, #637aad 5%, #5972a7 100%);
	background:-o-linear-gradient(top, #637aad 5%, #5972a7 100%);
	background:-ms-linear-gradient(top, #637aad 5%, #5972a7 100%);
	background:linear-gradient(to bottom, #637aad 5%, #5972a7 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#637aad', endColorstr='#5972a7',GradientType=0);
	background-color:#637aad;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Verdana;
	font-size:11px;
	padding:1px 4px;
	text-decoration:none;
}
.myButton1:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5972a7), color-stop(1, #637aad));
	background:-moz-linear-gradient(top, #5972a7 5%, #637aad 100%);
	background:-webkit-linear-gradient(top, #5972a7 5%, #637aad 100%);
	background:-o-linear-gradient(top, #5972a7 5%, #637aad 100%);
	background:-ms-linear-gradient(top, #5972a7 5%, #637aad 100%);
	background:linear-gradient(to bottom, #5972a7 5%, #637aad 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5972a7', endColorstr='#637aad',GradientType=0);
	background-color:#5972a7;
}
.myButton1:active {
	position:relative;
	top:1px;
}
   


</style>

<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#refnosearchwindow').jqxWindow('close'); 

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
	   $("#enquirylist").jqxGrid('exportdata', 'xls', 'Sales Order Process');
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
	  $("#listdiv").load("salesorderlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	
		   }
	}
function getBranch1() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var branchIdItems  = items[0].split(",");
			var branchItems = items[1].split(",");
			var optionsbranch = '<option value="a" selected>All</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
						+ branchItems[i] + '</option>';
			}
			$("select#cmbbranch1").html(optionsbranch);
			/* if ($('#hidcmbbranch').val() != null) {
				$('#cmbbranch').val($('#hidcmbbranch').val());
			} */
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getBranch.jsp", true);
	x.send();
}

function searchGrid()
{
	 var barchval = document.getElementById("cmbbranch1").value;
	 var masterdoc_no = document.getElementById("masterdoc_no").value;
	 var type = document.getElementById("type").value;
	 var clientid = document.getElementById("clientid").value;
    var id=1;
 
	  $('#create').attr('disabled', false);
	  $("#detaildiv").load("detailgrid.jsp?barchval="+barchval+"&masterdoc_no="+masterdoc_no+"&type="+type+"&clientid="+clientid+"&id="+id);
 
 
	
	}
function refinfoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#refnosearchwindow').jqxWindow('open');
		$('#refnosearchwindow').jqxWindow('setContent', data);

	}); 
	} 
	
	function quotecreate()
	{

		var rows = $("#duedetailsgrid").jqxGrid('getrows');
		var list = new Array();
		 
	   for(var i=0 ; i < rows.length ; i++){
	 
		   
		   
		   list.push(rows[i].rdocno+"::"+rows[i].prodoc+"::"+rows[i].qty+"::"+rows[i].stock+"::"+rows[i].costperunit+"::"+rows[i].sellingprice+"::"+rows[i].discount+"::"+
				   rows[i].netsellingprice+"::"+rows[i].rfqmaindoc+"::"+rows[i].vendordoc+"::"+rows[i].rfqprice+"::"+rows[i].margin+"::"+rows[i].netamount+"::"+rows[i].sqoute+"::"+rows[i].refdocno);
			
			 
	   }
			 
	  ajaxcall(list);
		
		
		 
	}
	function ajaxcall(list)

	{
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 var items= x.responseText;
				 	var itemval=items.trim();
				 	 	  if(itemval>0)
								  {
				 	 		  
				 	 		 var checkval="open"; 
				 	 		 
				 	 		 var masterdoc_no=document.getElementById("masterdoc_no").value; 
				 	 		 var branchvals=document.getElementById("branchvals").value; 
				 	 		 
				 	 		
				 	 		 
				               var url=document.URL;
				  		     var reurl=url.split("/com/");
				  		     var path1='com/sales and marketing/marketing/quotation/quotation.jsp';
				          	var path= path1+"?masterdoc_no="+masterdoc_no+"&checkval="+checkval+"&branchvals="+branchvals;
				  			  
				  			   top.addTab( "Sales Quotation",reurl[0]+"/"+path);		
								
							 	   
								  }
				 	 	  else
				 	 		  {
				 	 		  
				 	 		 $.messager.alert('Message', 'Not Generated');
				 	 		  }
 
				}
			else
				{
				
				}   
		}
 
		   
		  x.open("GET","savedata.jsp?list="+list); 
		x.send();
	}

function onhide()
{
	  $('#cmbbranch1').attr('disabled', true);
	  $('#searchgrid').attr('disabled', true);
	  $('#create').attr('disabled', true);
	
 
	
	
	
	
	
	
}	
</script>
</head>
<body onload="getBranch();getBranch1();onhide();">
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
 
 	 <tr><td colspan="2">&nbsp;</td></tr> 
	 <tr><td colspan="2">&nbsp;</td></tr>  
  <tr><td width="6%" align="right"><label class="branch" id="branchlabel">&nbsp;</label></td>
		<td width="94%"><select hidden="true"  id="cmbbranch1" name="cmbbranch1" style="width: 50%;" value='<s:property value="cmbbranch1"/>'>
      <option value="">--Select--</option></select> &nbsp;&nbsp;&nbsp;<input type="hidden" class="myButton1" hidden="true"  id="searchgrid" value="Search" onclick="searchGrid()">
      <input type="hidden" id="hidcmbbranch1" name="hidcmbbranch1" value='<s:property value="hidcmbbranch1"/>' /></td></tr> 
 <tr><td colspan="2" align="center"></td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td colspan="2">&nbsp;</td></tr> 
  <tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="hidden" hidden="true" class="myButton" id="create" value="Generate " onclick="quotecreate()"></td></tr> 

 <tr><td colspan="2">&nbsp;</td></tr> 
<!--  <tr><td colspan="2">&nbsp;</td></tr -->

	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 170px;"></div></td>
	</tr>	
	</table>
	</fieldset>
  
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="salesorderlistGrid.jsp"></jsp:include></div></td>
		</tr>
			 
		<tr>
		<td   ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>
 
	</table>
</tr>
</table>
 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
  <input type="hidden" id="type" name="type" value='<s:property value="type"/>' />
   <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>' /> 
     <input type="hidden" id="branchvals" name="branchvals" value='<s:property value="branchvals"/>' /> 
  
  
</div>
<div id="refnosearchwindow">
   <div ></div>
</div> 
</div>
</body>
</html>