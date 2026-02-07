   
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

<script type="text/javascript">

$(document).ready(function () {
	$('#stockLedgerDiv').show();
	$('#stockLedgerDetDiv').hide();
	document.getElementById('rsumm').checked=true;
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-6)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
		if(fromdates>todates){
			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
		    return false;
		}   
	 });
	 
		 $('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#productDetailsWindow').jqxWindow('close');
		 
		 $('#locationDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#locationDetailsWindow').jqxWindow('close');
		
		 $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#ptypewindow').jqxWindow('close');
		 
		 $('#brandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#brandwindow').jqxWindow('close');
		   
		   $('#departmentwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#departmentwindow').jqxWindow('close');
		   
		   $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');
		   
		   $('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pcategorywindow').jqxWindow('close');
		   
		   $('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#psubcategorywindow').jqxWindow('close');
		   
		   $('#pvendorwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Vendor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pvendorwindow').jqxWindow('close');
		 $('#txtpartno').dblclick(function(){
			 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
		 }); 
		 $('#txtlocation').dblclick(function(){
			 locationSearchContent('locationSearch.jsp', $('#locationDetailsWindow'));
		 });
		 $('#vendor').dblclick(function(){
			 vendorSearchContent('vendorsearch.jsp', $('#pvendorwindow'));
		 });
});

function funExportBtn(){
	if (document.getElementById('rsumm').checked) {
	 //  $("#stocklistgrid").jqxGrid('exportdata', 'xls', 'Strock List');
	 
		//JSONToCSVCon(datass, 'Strock List', true);
	   $("#stockLedgerDiv").excelexportjs({  
       		containerid: "stockLedgerDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "stocklistgrid", 
       		columns: getColumns("stocklistgrid") , 
       		worksheetName:"Purchase Order Process"
       		}); 

	   
	}
	 else if (document.getElementById('rdet').checked) {
		 
			//$("#stocklistgriddet").jqxGrid('exportdata', 'xls', 'Strock List');
			
			JSONToCSVCon(dat, 'Strock List', true);
			
			
		}
	 }

function productSearchContent(url) {
    $('#productDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#productDetailsWindow').jqxWindow('setContent', data);
	$('#productDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getProduct(){
	
	 $('#productDetailsWindow').jqxWindow('open');
		$('#productDetailsWindow').jqxWindow('focus');
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));

}

function locationSearchContent(url) {
    $('#locationDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#locationDetailsWindow').jqxWindow('setContent', data);
	$('#locationDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getLocation(){
	 $('#locationDetailsWindow').jqxWindow('open');
		$('#locationDetailsWindow').jqxWindow('focus');
		locationSearchContent('locationSearch.jsp', $('#locationDetailsWindow'));

}
function funreload(event)
{

	 branchid=document.getElementById("cmbbranch").value;
 	 hidbrand=document.getElementById("hidbrandid").value;
	 hidtype=document.getElementById("hidtypeid").value;
	 hidproduct=document.getElementById("hidproductid").value;
	 hidcat=document.getElementById("hidcatid").value;
	 hidsubcat=document.getElementById("hidsubcatid").value;
	 hidept=document.getElementById("hideptid").value;
	 hidcldocno=document.getElementById("hidvendorcldocno").value;
	 hidacno=document.getElementById("hidvendoracno").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();

	 var barchval = document.getElementById("cmbbranch").value;
     
	 var statusselect=$("#statusselect").val();
	 
	 var psrno=$("#psrno").val();
	 var locid=$("#locid").val();
	 
	if(hidcldocno==""){
	 	$.messager.alert('Message',' Vendor Is Mandatory','warning');   
	  	return 0;
	}
   
		if (document.getElementById('rsumm').checked) {
			
			  
			  $("#overlay, #PleaseWait").show();
			  var load="yes";
			  $("#stockLedgerDiv").load("stockGridSummary.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&locid="+locid+"&load="+load+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&hidcldocno="+hidcldocno+"&hidacno="+hidacno+"&fromdate="+fromdate+"&todate="+todate+"&type=1");
		}
		 else if (document.getElementById('rdet').checked) {
			 
			   $("#overlay, #PleaseWait").show();
			   var load="yes";
				  $("#stockLedgerDetDiv").load("stockGridDetail.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&load="+load);
			 
			}  
	  
	}

function  funcleardatass()
{
	// txtpartno  psrno   txtproductname   Press F3 to Search;
	 
	 document.getElementById('txtpartno').value="";
	 document.getElementById('txtproductname').value="";
	 document.getElementById('psrno').value="";
	 document.getElementById('rsumm').checked=true;
 
	 document.getElementById("cmbbranch").value="a";
	 
	 $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
	}
	
function fundisable(){
	

	
	if (document.getElementById('rsumm').checked) {
		
		  $('#stockLedgerDiv').show();
		   $('#stockLedgerDetDiv').hide();
		  
		}
	 else if (document.getElementById('rdet').checked) {
		 
		  $('#stockLedgerDiv').hide();
		  $('#stockLedgerDetDiv').show();
		 
		}
	 }
function funPrint(){
 var barchval = document.getElementById("cmbbranch").value;
 var branchid=document.getElementById("cmbbranch").value;
 var hidbrand=document.getElementById("hidbrandid").value;
 var hidtype=document.getElementById("hidtypeid").value;
 var hidproduct=document.getElementById("hidproductid").value;
 var hidcat=document.getElementById("hidcatid").value;
 var hidsubcat=document.getElementById("hidsubcatid").value;
 var hidept=document.getElementById("hideptid").value;
 var hidcldocno=document.getElementById("hidvendorcldocno").value;
 var hidacno=document.getElementById("hidvendoracno").value;
     
	 var statusselect=$("#statusselect").val();
	 
	 var psrno=$("#psrno").val();
	 var locid=$("#locid").val();
		var url=document.URL;
		var reurl=url.split("com");
		var path= "com/dashboard/procurment/productdetailsnew/productdetailsprint.action?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&locid="+locid+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&hidcldocno="+hidcldocno+"&hidacno="+hidacno+"&type=1";
		var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		win.focus();		
	 
	
}
function funClearData(){
		 document.getElementById('txtpartno').value="";
	 document.getElementById('txtproductname').value="";
	 document.getElementById('psrno').value="";
	 document.getElementById('rsumm').checked=true;
 
	 document.getElementById("cmbbranch").value="a";
	 
	 $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
	
	 document.getElementById("txtlocation").value="";
	 document.getElementById("locid").value="";
	 document.getElementById("vendor").value="";
	 document.getElementById("hidvendorcldocno").value="";
	 document.getElementById("hidvendoracno").value="";
	 document.getElementById("hidvendoraccount").value="";
	 document.getElementById("vendor").value="";
	
	 
	 document.getElementById("hidbrandid").value="";
	 document.getElementById("hidtypeid").value="";
	 document.getElementById("hidproductid").value="";
	 document.getElementById("hidcatid").value="";
	 document.getElementById("hidsubcatid").value=""; 
	 document.getElementById("hidbrand").value="";
	 document.getElementById("hidtype").value="";
	 document.getElementById("hidproduct").value="";
	 document.getElementById("hidcat").value="";
	 document.getElementById("hidsubcat").value="";
	 document.getElementById("prodsearchby").value="";
	 document.getElementById("searchdetails").value="";
	 document.getElementById("hideptid").value="";
	 document.getElementById("hidept").value="";
	 document.getElementById("hidvendoracno").value="";
	 document.getElementById("hidvendorcldocno").value="";
	 document.getElementById("cmbbranch").value="a";
	 //$("#partSearchdiv").load("partSearchGrid.jsp");
	
}

function setprodSearch(){
	var value=$('#prodsearchby').val().trim();

	if(value=="ptype"){
		getPtype();
	}
	else if(value=="pbrand"){
		getPbrand(2);
	}
	else if(value=="pdept"){
		getDept();
	}
	else if(value=="product"){
		getProduct();
	}
	else if(value=="pcategory"){
		getPcategory();
	}
	else if(value=="psubcategory"){
		getPsubcategory();
	}
	
	else if(value=="pvendor"){
		getPvendor();
	}
	
	else{
		
	}
}
function getPtype(){
	 
	  $('#ptypewindow').jqxWindow('open');
		$('#ptypewindow').jqxWindow('focus');
		typeSearchContent('typeSearch.jsp', $('#ptypewindow'));

}
function typeSearchContent(url) {
//alert(url);
  $.get(url).done(function (data) {
//alert(data);
$('#ptypewindow').jqxWindow('setContent', data);

}); 
}

function getPbrand(t){
	 
	  $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		brandSearchContent('brandSearch.jsp?id='+t, $('#brandwindow'));

}
function brandSearchContent(url) {
//alert(url);
  $.get(url).done(function (data) {
//alert(data);
$('#brandwindow').jqxWindow('setContent', data);

}); 
}
function getDept(){

	  $('#departmentwindow').jqxWindow('open');
		$('#departmentwindow').jqxWindow('focus');
		 deptSearchContent('deptSearch.jsp', $('#departmentwindow'));
}
function deptSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#departmentwindow').jqxWindow('setContent', data);

	}); 
	}
function getProduct(){
	
	var brandid=$('#hidbrandid').val().trim();
	var catid=$('#hidcatid').val().trim();
	var subcatid=$('#hidsubcatid').val().trim();
	
	 $('#productwindow').jqxWindow('open');
		$('#productwindow').jqxWindow('focus');
		 productSearchContent('prodSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, $('#productwindow'));

}
function productSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#productwindow').jqxWindow('setContent', data);

	}); 
	}
	
function getPcategory(){

	  $('#pcategorywindow').jqxWindow('open');
		$('#pcategorywindow').jqxWindow('focus');
		 categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
}
function categorySearchContent(url) {
//alert(url);
  $.get(url).done(function (data) {
//alert(data);
$('#pcategorywindow').jqxWindow('setContent', data);

}); 
}

function getPsubcategory(){
	var catid=$('#hidcatid').val().trim();
	 $('#psubcategorywindow').jqxWindow('open');
		$('#psubcategorywindow').jqxWindow('focus');
		 subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));

}
function subcategorySearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#psubcategorywindow').jqxWindow('setContent', data);

}); 
}

function getPvendor(){
	 $('#pvendorwindow').jqxWindow('open');
		$('#pvendorwindow').jqxWindow('focus');
		 pvendorsearchContent('vendorsearch.jsp', $('#pvendorwindow'));

}
function pvendorsearchContent(url) {
  //alert(url);
    $.get(url).done(function (data) {
//alert(data);
  $('#pvendorwindow').jqxWindow('setContent', data);

}); 
}

function getVendor(){
	 $('#pvendorwindow').jqxWindow('open');
		$('#pvendorwindow').jqxWindow('focus');
		vendorSearchContent('vendorsearch.jsp', $('#pvendorwindow'));

}
function vendorSearchContent(url) {
	$("#stocklistgrid").jqxGrid('clear');
   $('#pvendorwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#pvendorwindow').jqxWindow('setContent', data);
	$('#pvendorwindow').jqxWindow('bringToFront');
}); 
}
function funopen(docno){
	
		
		var url=document.URL;
		var reurl=url.split("com/");
		
		window.parent.formName.value="Purchase Order";
		window.parent.formCode.value="PO";
		
		var detName= "Purchase Order";
		var path= "com/Procurement/Purchase/PurchaseOrder/PurchaseOrder.jsp?mod=A"+"&venddocno="+document.getElementById("hidvendoracno").value+"&vendname="+document.getElementById("vendor").value.replace(/ /g,"%20")+"&vendaccount="+document.getElementById("hidvendoraccount").value+"&docno="+docno;
		top.addTab( detName,reurl[0]+""+path);
	
}
function funPurchaseorder()
{
	
	
	var cmbbranch=document.getElementById("cmbbranch").value;
	if(cmbbranch=="a" || cmbbranch=="")
	{
  $.messager.alert('Message',' Branch Is Mandatory','warning');   
  document.getElementById("cmbbranch").focus();
  return 0;
	}
	
	var vend=document.getElementById("hidvendorcldocno").value;
	if(vend=="")
	{
  $.messager.alert('Message',' Vendor Is Mandatory','warning');   
  return 0;
	}
	
	var selectedrows=$("#stocklistgrid").jqxGrid('selectedrowindexes');
	if(selectedrows.length==0){
		 $.messager.alert('Message',' Product Is Mandatory','warning');   
		  return 0;
			}
	
		
	$('#stocklistgrid').jqxGrid('clearfilters');
	var listss = new Array();
	var selectedrows=$("#stocklistgrid").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});
		  for(var i=0 ; i < selectedrows.length ; i++){
			 listss.push($("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'foc')
					 +"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'extfoc')
					 +"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'price')); 
				  }
		   save(listss);
            
	   
	
	  }
	  function save(listss){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200) 
					{
					 var items= x.responseText;
					 	var itemval=items.trim();
					 
	      if(parseInt(itemval)>0)
	      	{
				/* 	 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
						     
					     });
					     */
					 	funopen(itemval);
			 
					}
				else
					{
					/* $.messager.alert('Message', '  Not Updated ', function(r){
					     
				     }); */
					}  
			}
			}  
		x.open("GET","savedata.jsp?list="+listss+"&venddocno="+document.getElementById("hidvendoracno").value);
			x.send();
		}
	  
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="23%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	<tr><td align="right"><label class="branch">From</label></td>
	<td align="left"><div id="fromdate"></div></tr>
	
	<tr><td align="right"><label class="branch">To</label></td>
	<td align="left"><div id="todate"></div></tr>
 
	<tr><td align="right"><label class="branch">Location</label></td>
	<td align="left"><input type="text" id="txtlocation" name="txtlocation" style="width:90%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onKeyDown="getLocation(event);"/></td></tr>
	<td><input type="hidden" id="locid" name="locid" value='<s:property value="locid"/>' /> </td>
 
 <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;
	
	<tr><td align="right"><label class="branch">Vendor</label></td>
	<td align="left"><input type="text" id="vendor" name="vendor" style="width:90%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="vendor"/>' onKeyDown="getVendor(event);"/></td></tr>
	<td><input type="hidden" id="locid" name="locid" value='<s:property value="locid"/>' /> </td>
	
	 <input type="radio" hidden="true" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch"></label></td></tr>
	<td align="right"><label class="branch">Product</label></td>
	  <td  align="left"><select name="prodsearchby" id="prodsearchby" style="width:52%;">
		<option value="">--Select--</option>
    	<option value="ptype">TYPE</option>
    	<option value="pbrand">BRAND</option>
    	<option value="pdept">DEPARTMENT</option>  
    	<option value="pcategory">CATEGORY</option>
		<option value="psubcategory">SUB CATEGORY</option>
		<!-- <option value="pvendor">VENDOR</option> -->
<!--     <option value="product">PRODUCT</option>  -->
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setprodSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  </tr> 
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:90%;" rows="13"  readonly></textarea></td>
	  </tr>
	
	 <tr>

 
     <tr>
	<td align="left"><input type="hidden" id="txtpartno" name="txtpartno" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/></td></tr>
	<input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
	<tr><td>&nbsp;</td>
	<td><input type="hidden" id="txtproductname" name="txtproductname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/></td></tr> 
 
 
  
     
<tr><td colspan="2"  align="center" > <input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"> </td>
 <tr><td colspan="2" align="center"><button type="button" class="myButtons" id="btnprint" onclick="funPrint();">Print</button></td></tr> 
<tr><td colspan="2" align="center"><button type="button" class="myButton" id="btnpurchase" onclick="funPurchaseorder();">Purchase Order</button></td></tr>
<tr><td colspan="2">
			 <input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  <input type="hidden" name="hidvendoracno" id="hidvendoracno">
			  <input type="hidden" name="hidvendorcldocno" id="hidvendorcldocno">
			  <input type="hidden" name="hidvendoraccount" id="hidvendoraccount">
			  
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct">
			  <input type="hidden" name="hidvendor" id="hidvendor"></td>
	<td colspan="2" hidden><div id='paychaaaaa' style="width: 100% ; align:right; height: 60px;"></div></td>
	</tr>	
	</table>
	</fieldset>
	
	 <input type="hidden" id="statusselect" name="statusselect" value='<s:property value="statusselect"/>'>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
</td>
<td width="80%">
	
		<table width="100%">
		<tr>
			 <td><div id="stockLedgerDiv"><jsp:include page="stockGridSummary.jsp"></jsp:include></div></td>
		</tr>
		    <tr><td><div id="stockLedgerDetDiv">
				 <jsp:include page="stockGridDetail.jsp"></jsp:include> 
				</div></td></tr> 
	</table>
	
</tr>
</table>

</div>
 
<div id="productDetailsWindow">
	<div></div><div></div>
</div>
<div id="locationDetailsWindow">
	<div></div><div></div>
</div>
<div id="ptypewindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="departmentwindow">
<div></div>
</div>
<div id="productwindow">
<div></div>
</div>
<div id="pcategorywindow">
<div></div>
</div>
<div id="psubcategorywindow">
<div></div>
</div>
<div id="pvendorwindow">
<div></div>
</div>
</div>
</body>
</html>