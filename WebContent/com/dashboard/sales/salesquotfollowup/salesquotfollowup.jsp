 
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
  .iconss {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
.branch1 {
	color: black;
	 
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}

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
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
		   
	       $('#Searchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#Searchwindow').jqxWindow('close');
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
	 
	 
	 
	   $('#account').dblclick(function(){
	    
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
	    		 
	  });   
	   $('#quotdocno').dblclick(function(){
		    
	    	
   		
	  	    $('#Searchwindow').jqxWindow('open');
	  	
	  	  SearchContent('qotMastersearch.jsp?');
   		 
 });  
	  
});

function funExportBtn(){
	   $("#salqotlistgrid").jqxGrid('exportdata', 'xls', 'Sales Quotation Followup');
	 }

function getaccountdetails(event){
	 var x= event.keyCode;
  	
 
		
	 if(x==114){
	  $('#accountSearchwindow').jqxWindow('open');
	
	 accountSearchContent('accountsDetailsSearch.jsp?');    }
	 else{
		 }
		 
	 }  
	  function accountSearchContent(url) {
 
         $.get(url).done(function (data) {
 
       $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
   	}
	  
	  
	  function getdocdetails(event){
			 var x= event.keyCode;
		  	
		 
				
			 if(x==114){
			  $('#Searchwindow').jqxWindow('open');
			
			 SearchContent('qotMastersearch.jsp?');    }
			 else{
				 }
				 
			 }  
			  function SearchContent(url) {
		 
		         $.get(url).done(function (data) {
		 
		       $('#Searchwindow').jqxWindow('setContent', data);

			}); 
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
		   var ostk="";
		   if(document.getElementById("outofstock").checked==true)
			   {
			   
			     ostk="out";
			   }
		   else
		   {
			    
		   }
		   
		   
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var statusselect=$("#statusselect").val();
	 
	 var quotdocno=$("#quotdocno").val();
	 
	 
	 var acno=$("#acno").val();
	 
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("salesqotfolowupGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno+"&ostk="+ostk+"&quotdocno="+quotdocno);
	
		   }
	}

function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("account").value="";
	document.getElementById("accname").value="";
	document.getElementById("quotdocno").value="";
	document.getElementById("outofstock").checked=false;
 
	document.getElementById("statusselect").value="All";
	
	
	
	 if (document.getElementById("account").value == "") {
			
		 
	        $('#account').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("quotdocno").value == "") {
			
		 
	        $('#quotdocno').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  
		
	}
	
	
function getinfo() {
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
<body onload="getBranch();getinfo();">
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
 
   
  <tr><td colspan="2"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<label class="branch">Out Of Stock</label>&nbsp;<input type="checkbox" id="outofstock" > </td></tr>  
 <tr>
<td align="right"><label class="branch">Client</label></td>
    <td  ><input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetails(event);" >  </td></tr>
 <tr> <td>&nbsp;</td><td> <input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  readonly="readonly"  style="height:20px;width:100%;"></td></tr>


	<tr><td  > <label class="branch">Doc No</label></td><td><input type="text" name="quotdocno" id="quotdocno" value='<s:property value="quotdocno"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getdocdetails(event);" >  </td></tr> 
 	 	
	 	<tr><td colspan="2">&nbsp;</td></tr> 
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>

	 	
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
	 	
	 	</fieldset>
 
	 	<tr><td colspan="2">&nbsp;</td></tr> 
	 	<tr><td colspan="2">&nbsp;</td></tr> 
	 	<tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
	
	  <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
   <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'> 
   
    <input type="hidden" id="branchids" name="branchids" value='<s:property value="branchids"/>'> 
    <input type="hidden" id="specno" name="specno" value='<s:property value="specno"/>'>
    <input type="hidden" id="prodoc" name="prodoc" value='<s:property value="prodoc"/>'>
   
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="salesqotfolowupGrid.jsp"></jsp:include></div></td>
			 
		</tr>

<tr>
		<td   ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>

	</table>
</tr>
</table>

</div>
<div id="accountSearchwindow">
   <div ></div>
</div> 
<div id="Searchwindow">
   <div ></div>
</div> 


</div>
</body>
</html>