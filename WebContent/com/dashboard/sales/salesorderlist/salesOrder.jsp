 
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
	 document.getElementById('rsumm').checked=true;
	  $('#listdivsumm').show();
	   $('#listdivdet').hide();
	   
		  $('#summs').show();
		  $('#btnopen').show();
		   $('#detial').hide();
		   $("#btnopen").attr('disabled', true );

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 $('#docWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#docWindow').jqxWindow('close');
		 $('#productDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#productDetailsWindow').jqxWindow('close');
	       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#accountSearchwindow').jqxWindow('close');
		   
		   
		   
		   
	       $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#ptypewindow').jqxWindow('close');
		   $('#brandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#brandwindow').jqxWindow('close');
		   $('#modelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#modelwindow').jqxWindow('close');
		   $('#submodelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#submodelwindow').jqxWindow('close');
		   $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');
		   $('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pcategorywindow').jqxWindow('close');
		   $('#pdeptwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pdeptwindow').jqxWindow('close');
		   $('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#psubcategorywindow').jqxWindow('close');
		
	     
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
	 
	 $('#txtpartno').dblclick(function(){
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
	 }); 
	 
	   $('#account').dblclick(function(){
	    
	    	
	    		
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp?');
	    		 
	  });   
	   
	   
	   $('#invdocno').dblclick(function(){
		    
	    	
   		
	  	    $('#docWindow').jqxWindow('open');
	  	
	  	  docSearchContent('docnoSearch.jsp?');
   		 
 }); 
	  
});
function docSearchContent(url) {
	 
    $.get(url).done(function (data) {

  $('#docWindow').jqxWindow('setContent', data);

}); 
	}
function getaccountdetail(event){
	 var x= event.keyCode;
 	

		
	 if(x==114){
	  $('#docWindow').jqxWindow('open');
	
	  docSearchContent('docnoSearch.jsp?');    }
	 else{
		 }
		 
	 }  
function funExportBtn(){
	if (document.getElementById('rsumm').checked) {
	 //  $("#stocklistgrid").jqxGrid('exportdata', 'xls', 'Strock List');
	 
		JSONToCSVCon(sumdatass, 'Sales Order', true);
	   
	   
	}
	 else if (document.getElementById('rdet').checked) {
		 
			//$("#stocklistgriddet").jqxGrid('exportdata', 'xls', 'Strock List');
			
			JSONToCSVCon(dat, 'Sales Order', true);
			
			
		}
	 }
function getPtype(){
	 
	  $('#ptypewindow').jqxWindow('open');
		$('#ptypewindow').jqxWindow('focus');
		typeSearchContent('typeSearch.jsp', $('#ptypewindow'));

}


function getPbrand(t){
	 
	  $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		brandSearchContent('brandSearch.jsp?id=2', $('#brandwindow'));

}


function getPcategory(){

	  $('#pcategorywindow').jqxWindow('open');
		$('#pcategorywindow').jqxWindow('focus');
		 categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
}

function getDept(){

	  $('#pdeptwindow').jqxWindow('open');
		$('#pdeptwindow').jqxWindow('focus');
		 deptSearchContent('deptSearch.jsp', $('#pdeptwindow'));
}


function getPsubcategory(){
	var catid=$('#hidcatid').val().trim();
	 $('#psubcategorywindow').jqxWindow('open');
		$('#psubcategorywindow').jqxWindow('focus');
		 subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));

}


function getProduct(){
	
	var brandid=$('#hidbrandid').val().trim();
	var catid=$('#hidcatid').val().trim();
	var subcatid=$('#hidsubcatid').val().trim();
	

		 productSearchContent('productSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, 'productwindow');

}


/* function getProduct(){
	
	 $('#productDetailsWindow').jqxWindow('open');
		$('#productDetailsWindow').jqxWindow('focus');
		 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));

}
 */

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
	 /* var statusselect="All"; */
	 var statusselect=$("#statusselect").val();
	 
	 var acno=$("#acno").val();
	 
	 var psrno=$("#psrno").val();
	 
	 var invdocnomaster=$("#invdocnomaster").val();
	var hidbrand=document.getElementById("hidbrandid").value;
	var hidtype=document.getElementById("hidtypeid").value;
	var hidproduct=document.getElementById("hidproductid").value;
	var hidcat=document.getElementById("hidcatid").value;
	var hidsubcat=document.getElementById("hidsubcatid").value;
	var hidept=document.getElementById("hideptid").value;
	var load="yes";
	   $("#overlay, #PleaseWait").show();
		if (document.getElementById('rsumm').checked) {
	  $("#listdivsumm").load("salessuminvoicelistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno+"&psrno="+psrno+"&invdocnomaster="+invdocnomaster
			  +"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&hidept="+hidept+"&load="+load);
		}
		
		else
			{
			  $("#listdivdet").load("salesdetinvoicelistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&acno="+acno+"&psrno="+psrno+"&invdocnomaster="+invdocnomaster
					  +"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&hidept="+hidept+"&load="+load);
			}
		   }
	}
function fundisable(){
	
	//funClearData();
	
	if (document.getElementById('rsumm').checked) {
		
 
		
		  $('#listdivsumm').show();
		   $('#listdivdet').hide();
		   
		   $('#btnopen').show();
		   
			  $('#summs').show();
			   $('#detial').hide();
		    
			 
		  
		}
	 else if (document.getElementById('rdet').checked) {
		 
		  $('#listdivsumm').hide();
		  $('#listdivdet').show();
		  $('#btnopen').hide();
 
		   
		  $('#summs').hide();
		   $('#detial').show();
	    
	 
		 
		}
	 }
function typeSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#ptypewindow').jqxWindow('setContent', data);

	}); 
	}
	function brandSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#brandwindow').jqxWindow('setContent', data);

	}); 
	}

	function modelSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#modelwindow').jqxWindow('setContent', data);

	}); 
	}

	function subModelSearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#submodelwindow').jqxWindow('setContent', data);

		}); 
		}

	function categorySearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#pcategorywindow').jqxWindow('setContent', data);

	}); 
	}

	function deptSearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#pdeptwindow').jqxWindow('setContent', data);

		}); 
		}

	function subcategorySearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#psubcategorywindow').jqxWindow('setContent', data);

	}); 
	}
function funClearData1(){
	document.getElementById("cmbbranch").value="a";
	 
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
	 
	 
 
	 
	 
	 
	 
	 
	 //$("#partSearchdiv").load("partSearchGrid.jsp");
	
}	function setprodSearch(){
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
	
	
	else{
		
	}
}
function setRemove(){
	
	var suitvalue="";
	var prodvalue=$('#prodsearchby').val().trim();
	
	if(prodvalue=="ptype"){
		 
		 document.getElementById("hidtypeid").value="";
		 document.getElementById("hidtype").value="";
		 
	}
	else if(prodvalue=="pbrand"){
		document.getElementById("hidbrandid").value="";
		document.getElementById("hidproduct").value="";
		
	}
	else if(prodvalue=="product"){
		document.getElementById("hidproductid").value="";
		document.getElementById("hidbrand").value="";
	}
	else if(prodvalue=="pcategory"){
		 document.getElementById("hidcatid").value="";
		 document.getElementById("hidcat").value="";
		 
	}
	else if(prodvalue=="psubcategory"){
		document.getElementById("hidsubcatid").value="";
		document.getElementById("hidsubcat").value="";
	}
	else if(prodvalue=="pdept"){
		document.getElementById("hideptid").value="";
		document.getElementById("hidept").value="";
	}
	
	/* if(suitvalue=="sbrand"){
		 document.getElementById("hidsbrandid").value="";
		 document.getElementById("hidsbrand").value="";
		 
	}
	else if(suitvalue=="smodel"){
		document.getElementById("hidsmodelid").value="";
		document.getElementById("hidsmodel").value="";
		
	}
	else if(suitvalue=="syom"){
		document.getElementById("hidyomid").value="";
		 document.getElementById("hidyom").value="";
		 
	}
	
	else if(suitvalue=="spec1"){
		document.getElementById("hidspec1id").value="";
		document.getElementById("hidspec1").value="";
		 
	}
	else if(suitvalue=="spec2"){
		document.getElementById("hidspec2id").value="";
		document.getElementById("hidspec2").value="";
		 
	}
	else if(suitvalue=="spec3"){
		document.getElementById("hidspec3id").value="";
		document.getElementById("hidspec3").value="";
	} */
	document.getElementById("searchdetails").value="";
	
/* 		if(document.getElementById("hidsbrand").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsbrand").value;	
	}
	if(document.getElementById("hidsmodel").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsmodel").value;	
	}
	if(document.getElementById("hidyom").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidyom").value;	
	}
	if(document.getElementById("hidspec1").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec1").value;	
	}
	if(document.getElementById("hidspec2").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec2").value;	
	}
	if(document.getElementById("hidspec3").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec3").value;	
	} */
	if(document.getElementById("hidbrand").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidbrand").value;	
	}
	if(document.getElementById("hidtype").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidtype").value;	
	}
	if(document.getElementById("hidcat").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidcat").value;	
	}
	if(document.getElementById("hidsubcat").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsubcat").value;	
	}
	if(document.getElementById("hidproduct").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidproduct").value;	
	}
	if(document.getElementById("hidept").value!=""){
		document.getElementById("searchdetails").value+="\n"+document.getElementById("hidept").value;	
	}
}

function  funcleardata()
{
	document.getElementById("acno").value="";
	document.getElementById("account").value="";
	document.getElementById("accname").value="";
 
	
	document.getElementById("txtpartno").value="";
	document.getElementById("psrno").value="";
	document.getElementById("txtproductname").value="";
	
	 
	document.getElementById("invdocno").value="";
	document.getElementById("invdocnomaster").value="";
	
	document.getElementById("statusselect").value="All";
	
	
	 
		 
	        $('#account').attr('placeholder', 'Press F3 TO Search'); 
	 	
		 
	        $('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
	        
	        
	        $('#invdocno').attr('placeholder', 'Press F3 TO Search'); 
	        
	        
	        funClearData1();    
	}
	
function productSearchContent(url) {
    $('#productwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#productwindow').jqxWindow('setContent', data);
	$('#productwindow').jqxWindow('bringToFront');
}); 
}
function funsor(docno)
{
	//alert("==docno==="+docno);
	 var barchval = document.getElementById("cmbbranch").value;
		if(barchval=="a" || barchval=="")
			{
			  $.messager.alert('Message','Branch is mandatory  ','warning');   
				 
			   return false;
			}
	
   var url=document.URL;
	var reurl=url.split("com/");
	var mod="view";
	window.parent.formName.value="Sales Order";
	window.parent.formCode.value="SOR";
	var detName= "Sales Order";
	 var path1='com/sales and marketing/marketing/salesorder/saveSalesOrder';

	    var path= path1+"?mode="+mod+"&masterdoc_no="+docno;  

	top.addTab( detName,reurl[0]+""+path);  
}
function funSetVal(event) {
	document.getElementById('statusselect').value=$("#statusselect1").val();
	
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
		
	 <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Summary</label>&nbsp;&nbsp;
	 <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Detail-(Product Wise)</label></td></tr>
	 <tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                       <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
   <tr><td colspan="2">&nbsp;</td></tr> 
	 	<tr><td align="right"> <label class="branch">Status</label></td> <td ><select  id="statusselect1" onchange="funSetVal(event);" name="statusselect1" style="width:70%;">
	<option value="All">All</option>
	<option value="PED">Pending</option>
	<option value="GRN">Executed</option>
	 
		  
		
	
	 </select> </td></tr> 
	 <tr>
<td align="right"><label class="branch">Account</label></td>
    <td  ><input type="text" name="account" id="account" value='<s:property value="account"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetails(event);" >  </td></tr>
 <tr> <td>&nbsp;</td><td> <input type="text" id="accname" name="accname" value='<s:property value="accname"/>'  readonly="readonly"  style="height:20px;width:100%;"></td></tr>
 
  
 	 <tr>
<td align="right"><label class="branch">DOCNO</label></td>  <td  ><input type="text" name="invdocno" id="invdocno" value='<s:property value="invdocno"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getaccountdetail(event);" >  </td></tr>
 
	 <input type="hidden" id="txtpartno" name="txtpartno"  style="width:80%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"
	  value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/> 
	<input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
	
	 <input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>
	
	
 
 
	<td><input type="hidden" id="txtproductname" name="txtproductname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/> 
	
 <tr><td colspan="2">
	  <div id="detial" > 
 
	  <table width="100%">
	  <tr>
	  <td align="right"><label class="branch">Product</label></td>
	  <td  align="left"><select name="prodsearchby" id="prodsearchby" style="width:52%;">
<option value="">--Select--</option>
    <option value="ptype">TYPE</option>
    <option value="pbrand">BRAND</option>
    <option value="pdept">DEPARTMENT</option>
    <option value="pcategory">CATEGORY</option>
    <option value="psubcategory">SUB CATEGORY</option>
    <option value="product">PRODUCT</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setprodSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  
	</tr> 
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="18"  readonly></textarea></td>
	  </tr>
	   </table>
	   </div>
	
	   
	   </td></tr>
   <tr><td colspan="2" align="center">   </td></tr>
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
    <tr><td colspan="2" align="center">   
	   
	   	  <div id="summs"  style="resize:none;font: 10px Tahoma;hight:20px" >
	   	 <br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;
	   	     	 <br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;
	   	     	  <br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;
	   	     	  
	   	     	   <br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;
	   	  </div></td></tr>
 
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
   
     <input type="hidden" id="invdocnomaster" name="invdocnomaster" value='<s:property value="invdocnomaster"/>'> 
</td>
<td width="80%">
	<%-- <table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="salesinvoicelistGrid.jsp"></jsp:include></div></td>
			 
		</tr>
	</table> --%>
	
	
	<table width="100%">
		<tr>
			 <td><div id="listdivsumm"><jsp:include page="salessuminvoicelistGrid.jsp"></jsp:include></div></td>
		</tr>
		    <tr><td><div id="listdivdet">
				 <jsp:include page="salesdetinvoicelistGrid.jsp"></jsp:include> 
				</div></td></tr> 
	</table>
	</td>
</tr>
</table>
     <input type="hidden" id="statusselect" name="statusselect" value="All"> 
		 <input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct">
			   

</div>
<div id="accountSearchwindow">  
   <div ></div>
</div> 
<div id="productDetailsWindow">
   <div ></div>
</div> 
<div id="docWindow">
   <div ></div>
</div> 
<div id="ptypewindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="submodelwindow">
<div></div>
</div>
<div id="productwindow">
<div></div>
</div>
<div id="pcategorywindow">
<div></div>
</div>
<div id="pdeptwindow">
<div></div>
</div>
<div id="psubcategorywindow">
<div></div>
</div>


</div>
</body>
</html>