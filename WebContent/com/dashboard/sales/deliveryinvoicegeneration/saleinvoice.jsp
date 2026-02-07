 
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

	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
	     
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#refnosearchwindow').jqxWindow('close'); 
			
			 $('#locationwindow').jqxWindow({
					width : '25%',
					height : '58%',
					maxHeight : '70%',
					maxWidth : '45%',
					title : 'Location Search',
					position : {
						x : 420,
						y : 87
					},
					theme : 'energyblue',
					showCloseButton : true,
					keyboardCloseKey : 27
				});
				$('#locationwindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
	 
	 
	 $("#duedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 
	 
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
	 
	 
	 $('#date').on('change', function (event) {
			
		   var date=new Date($('#date').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var duedate=new Date($('#duedate').jqxDateTimeInput('getDate')); 
		 	 
		   if(date>duedate){
			   
			   $.messager.alert('Message','Due Date Less Than  Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 $('#duedate').on('change', function (event) {
			
		   var date=new Date($('#date').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var duedate=new Date($('#duedate').jqxDateTimeInput('getDate')); 
		 	 
		   if(date>duedate){
			   
			   $.messager.alert('Message','Due Date Less Than  Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 
	 
	 $('#txtlocation').dblclick(function(){
		 var barchval = document.getElementById("cmbbranch").value;
		  
		   		$('#locationwindow').jqxWindow('open');
		   		locationSearchContent('locationSearch.jsp?barchval='+barchval);  
		   		 
		 });
	 
	   $('#account').dblclick(function(){
	    
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
	    		 
	  });  
	  
});





function getLocation(event){
	 var x= event.keyCode;
	 if(x==114){
		 var barchval = document.getElementById("cmbbranch").value;
		locationSearchContent('locationSearch.jsp?barchval='+barchval);  	 }
	 else{
		 }
    	 }
function locationSearchContent(url) {
	$('#locationwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#locationwindow').jqxWindow('setContent', data);
		$('#locationwindow').jqxWindow('bringToFront');
	});
}	 
function funExportBtn(){
	 ///  $("#enquirylist").jqxGrid('exportdata', 'xls', 'Sales Order Process');
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
	 var acno= $("#acno").val();
 
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("listGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&acno="+acno);
	  $("#duedetailsgrid").jqxGrid('clear');
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
	
function funupdates()
{

   if(document.getElementById("focvalidate").value==1)
{
	funval();
}
else
{  
	funupdate();
   }   

}




function funval()
{
	
	
	
	if(document.getElementById("locationid").value=="")
	{
  $.messager.alert('Message',' Location Is Mandatory','warning');   
  return 0;
	}

	
	
	
	 var selectedrows = $("#duedetailsgrid").jqxGrid('selectedrowindexes');
	  selectedrows = selectedrows.sort(function(a,b){return a - b});
	 // alert(selectedrows.length);
	  
		if(selectedrows.length=="0")
			{
		  $.messager.alert('Message','Select Items To be Processed ','warning');   
		  return 0;
			}

		
		
		
 
	var lists = new Array();
	 
   for(var i=0 ; i < selectedrows.length ; i++){ 
	   lists.push($("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'rowno')+"::"+$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"+$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'foc')+"::");
	   
/* 		   
	   list.push(rows[i].rowno+"::"+rows[i].qty+"::"+rows[i].foc+"::");
		 */
		 
   }
		 
  ajaxcalls(lists);
	
	
	
}

function ajaxcalls(lists)

{
	
	
	
	
	
	
	 var masterdoc_no=document.getElementById("masterdoc_no").value; 
 		 var branchvals=document.getElementById("branchvals").value; 
 
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		   {
            var itemss= x.responseText.trim();
            
          
            
            var item = itemss.split('::');
            
            
            
            var chkfoc=item[0];
            var maxfoc=item[1];
            var maxpart_no=item[2];
              
            if(chkfoc=='22')
			  {
               
	 	 		  $.messager.alert('Message', 'ERROR!!','warning');   
	 			  return 0;
            	
			  }
            else if(chkfoc>0)
							  {
			 	 		         
			 	 		//  $.messager.alert('Message', 'Product ID :' +maxpart_no+ ' Allowed Foc  :' +maxfoc,'warning');   
			 			//  return 0;
            	 funupdate();
			 	 		  	 
			    
							  }else
								  {
								  
								  funupdate();
								  
								  }
			 	 	 

			}
		else
			{
			
			}     
	}

	   
	  x.open("GET","validatesavedata.jsp?list="+lists+"&masterdoc_no="+masterdoc_no+"&branchvals="+branchvals+"&date="+$("#date").val()+"&refnos="+document.getElementById("refnos").value+"&description="+document.getElementById("description").value+"&locationid="+document.getElementById("locationid").value); 
	x.send();
}



function funupdate()

{  
	 var dates=new Date($('#date').jqxDateTimeInput('getDate'));
	  var dtchk=funDateInPeriod(dates);
	  if(dtchk==0){
		  return 0;
	  }
	  var duedates=new Date($('#duedate').jqxDateTimeInput('getDate'));  
	   if(dates>duedates){
		   $.messager.alert('Message','Due Date Less Than  Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	
	
	      var date=dates; 
	      
 		 var duedate=duedates; 
 	 
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		   {
            var itemss= x.responseText.trim();
            
     
        
            if(parseInt(itemss)==1)
    	  {
        	 funsavedatats();
    	  }
          else if(parseInt(itemss)==0)
    	  {
        	  $.messager.alert('Message', 'ERROR!!','warning');   
 			  return 0;
    	  }  
          else  
        	  {
        	  $.messager.alert('Message', 'Due Date Should Not Be  More Than ' +itemss+ ' days of  Date' ,'warning');   
 			  return 0;
        	  }
 
			 	 	 

			}
		else
			{
			
			}     
	}

	   
	  x.open("GET","validatedate.jsp?date="+date+"&duedate="+duedate); 
	x.send();
}

	 	 
	 	 
}
	
	
	
	function funsavedatats()
	{

		
		
		 
		
		
		if(document.getElementById("locationid").value=="")
		{
	  $.messager.alert('Message',' Location Is Mandatory','warning');   
	  return 0;
		}

		
		
		
		 var selectedrows = $("#duedetailsgrid").jqxGrid('selectedrowindexes');
		  selectedrows = selectedrows.sort(function(a,b){return a - b});
		 // alert(selectedrows.length);
		  
			if(selectedrows.length=="0")
				{
			  $.messager.alert('Message','Select Items To be Processed','warning');   
			  return 0;
				}
			  $('#updatdata').attr('disabled', true);
			 $("#overlay, #PleaseWait").show();
			
			
			
			
			
	 
		var list = new Array();
		 
	    for(var i=0 ; i < selectedrows.length ; i++){ 
		   list.push($("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'rowno')+"::"+$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"
				   +$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'foc')+"::"+$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'unitprice')+"::"
				   +$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'nettotal')+"::"+$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'taxper')+"::"
				   +$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'taxamount')+"::"+$("#duedetailsgrid").jqxGrid('getcellvalue',selectedrows[i],'taxperamt'));
			 
	   	}
			 
	
	  
	  

		
	    ajaxcall(list);
		 
	}
	
	

	
	
	function ajaxcall(list)

	{
		
		
		  var list1 = new Array();
		  var rows1 = $("#sidelistgrid1").jqxGrid('getrows');   
		  
		    for(var i=0 ; i < rows1.length ; i++){ 
		    	list1.push($("#sidelistgrid1").jqxGrid('getcellvalue',i,'nos')+"::"+$("#sidelistgrid1").jqxGrid('getcellvalue',i,'type'));
					 
			   	}
					
		
		 var masterdoc_no=document.getElementById("masterdoc_no").value; 
	 		 var branchvals=document.getElementById("branchvals").value; 
	 
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
				 	 		 
				 	 		 $.messager.alert('Message', 'Successfully Generated Doc No :'+itemval);
				 	 		funreload(event);
				 	 		
				 	 		$("#txtlocation").val('');
				 	 		$("#refnos").val('');
				 	 		$("#description").val('');
				 	 		$("#date").val(new Date());
				 	 		
				 	 		
				 	 		$("#duedate").val(new Date());
				 	 		
				 	 		$("#sidelistgrid1").jqxGrid('clear');
				 	 		
				 	 		 disitems();
				 	 		
				           /*     var url=document.URL;
				  		     var reurl=url.split("/com/");
				  		     var path1='com/sales and marketing/marketing/quotation/quotation.jsp';
				          	var path= path1+"?masterdoc_no="+masterdoc_no+"&checkval="+checkval+"&branchvals="+branchvals;
				  			  
				  			   top.addTab( "Sales Quotation",reurl[0]+"/"+path);		
								 */
							 	   
								  }
				 	 	  else
				 	 		  {
				 	 		  
				 	 		 $.messager.alert('Message', 'Not Generated');
				 	 		  $('#updatdata').attr('disabled', false);
				 	 		 $("#overlay, #PleaseWait").hide();
				 	 		  }
 
				}
			else
				{
				
				}     
		}
 
		   
		  x.open("GET","savedata.jsp?list="+list+"&masterdoc_no="+masterdoc_no+"&branchvals="+branchvals+"&date="+$("#date").val()+"&duedate="+$("#duedate").val()+"&refnos="+document.getElementById("refnos").value+"&description="+document.getElementById("description").value.replace(/ /g,"%20")+"&locationid="+document.getElementById("locationid").value+"&list1="+list1); 
		x.send();
	}

function onhide()
{
	  $('#cmbbranch1').attr('disabled', true);
	  $('#searchgrid').attr('disabled', true);
	  $('#create').attr('disabled', true);
	
 
	
	
	
	
	
	
}	
function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("account").value="";
	document.getElementById("accname").value="";
 
	
 
	document.getElementById("statusselect").value="All";
	
	
	
	 if (document.getElementById("account").value == "") {
			
		 
	        $('#account').attr('placeholder', 'Press F3 TO Search'); 
	    }
	  
		
	}
	
	
function disitems() {
	
	  
	 $("#txtlocation").attr("disabled",true); 
	 $("#refnos").attr("disabled",true); 
	 $("#description").attr("disabled",true); 
	 $("#updatdata").attr("disabled",true); 
	 $('#date').jqxDateTimeInput({disabled: true});
	 $('#duedate').jqxDateTimeInput({disabled: true});
	 $("#sidelistgrid1").jqxGrid({ disabled: true});
	 
	 
}




</script>
</head>
<body onload="getBranch();disitems(); ">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		  
 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
 
 <tr>
<td align="right"><label class="branch">Customer</label></td>
    <td  ><input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:100%;" onKeyDown="getaccountdetails(event);" >  </td></tr>
 
   <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>

 
    <tr><td colspan="2"> 
    <fieldset>
    <table width="100%">
    
    
    
     <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div></td></tr>
   
      
           <tr><td  align="right" ><label class="branch">Due Date</label></td><td align="left"><div id='duedate' name='duedate' value='<s:property value="duedate"/>'></div></td></tr>
   
      
      
        <tr><td  align="right" ><label class="branch">Location</label></td> 
      
  <td ><input type="text" id="txtlocation" name="txtlocation" style="height:20px;width:100%;"  readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
      <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td></tr>
     <tr><td  align="right" ><label class="branch">Ref No</label></td><td align="left"><input type="text" name="refnos"   style="height:20px;width:100%;" id="refnos" value='<s:property value="refnos"/>'  > </td></tr>
        <tr><td  align="right" ><label class="branch">Description</label></td><td align="left"><input type="text" name="description" style="height:20px;width:100%;" id="description" value='<s:property value="description"/>'  > </td></tr>
    
    
     <tr><td colspan="2"><div id="sidelistdiv"><jsp:include page="sublistGrid.jsp"></jsp:include></div></td></tr> 
        <tr><td colspan="2" align="center"><input type="button" class="myButton" name="updatdata" id="updatdata"  value="Update" onclick="funupdate()"></td></tr>
     
    </table>
    
    
    
    
    
    </fieldset>
    
    
    
    </td></tr> 

 
 
<!--  <tr><td colspan="2">&nbsp;</td></tr -->

 	
	</table>
	</fieldset>
  
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="listGrid.jsp"></jsp:include></div></td>
		</tr>
			 
		<tr>
		<td   ><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr>
 
	</table>
</tr>
</table>
 <input type="hidden" id="accname" name="accname" value='<s:property value="accname"/>'  readonly="readonly"  style="height:20px;width:100%;">
 <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
  <input type="hidden" id="type" name="type" value='<s:property value="type"/>' />
   <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>' /> 
     <input type="hidden" id="branchvals" name="branchvals" value='<s:property value="branchvals"/>' /> 
  <select hidden="true"  id="cmbbranch1" name="cmbbranch1" style="width: 50%;" value='<s:property value="cmbbranch1"/>'>
      <option value="">--Select--</option></select> &nbsp;&nbsp;&nbsp;<input type="hidden" class="myButton1" hidden="true"  id="searchgrid" value="Search" onclick="searchGrid()">
      <input type="hidden" id="hidcmbbranch1" name="hidcmbbranch1" value='<s:property value="hidcmbbranch1"/>' />

   
  
</div>
<div id="refnosearchwindow">
   <div ></div>
</div> 
<div id="accountSearchwindow">
   <div ></div>
</div>
<div id="locationwindow">
	<div></div>
</div>
</div>
</body>
</html>