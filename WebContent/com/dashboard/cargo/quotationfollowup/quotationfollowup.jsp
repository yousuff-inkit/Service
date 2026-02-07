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
.showdet{
   font-size:8pt;   
   color:blue;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	       $('#Searchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#Searchwindow').jqxWindow('close');
 
	$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
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
	 
 
			 
		   $('#docnosss').dblclick(function(){
		    
		    	
		    		
			  	    $('#Searchwindow').jqxWindow('open');
			  	
			  	  SearchContent('mainsearch.jsp?');
		    		 
		  });  
		   
});
 
function  funcleardata(){
	$('#jqxEstimation').jqxGrid('clear'); 
	$('#orderlistgrid').jqxGrid('clear'); 
	document.getElementById("reqdocno").value="";
	document.getElementById("docnosss").value="";
    $('#docnosss').attr('placeholder', 'Press F3 TO Search'); 
    document.getElementById("showdet").innerHTML="";    
}
 
function getdetails(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#Searchwindow').jqxWindow('open');
	
	  SearchContent('mainsearch.jsp?');    }
	 else{
		 }
		 
	 }  
	  function SearchContent(url) {

        $.get(url).done(function (data) {

      $('#Searchwindow').jqxWindow('setContent', data);

	}); 
  	}
 
function funExportBtn(){
	JSONToCSVCon(datas,'Quotation Followup ', true);
	 }
	 
function funreload(event){
	$('#jqxEstimation').jqxGrid('clear'); 
	document.getElementById("showdet").innerHTML=""; 
	//document.getElementById("cmbinfo").value=1;
	 var cmbinfo = document.getElementById("cmbinfo").value;
	disitems(cmbinfo);
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
		   
		   	   
		   
     var fromdate=$("#fromdate").val();
	 var todate=$("#todate").val();  
	 
 
	 
	 var statusselect="";
	 
	 var reqdocno=$("#reqdocno").val();
	  
	  //$("#duedetailsgrid").jqxGrid('clear');
	   $("#overlay, #PleaseWait").show();
	 
	  $("#listdiv").load("mainGrid.jsp?barchval="+barchval+"&fromdate1="+fromdate+"&todate1="+todate+"&statusselect="+statusselect+"&reqdocno="+reqdocno+"&load="+$("#cmbgridfilter").val()+"&cmbinfo="+cmbinfo);
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
			var optionsbranch = '';
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
function disitems(val){
	//alert("val===="+val);
	if(val=="1"){
		$('#itemsdetails').hide();
		 $('#cmbinfo').attr("disabled",false);
		 $('#remarks').attr("disabled",false);
		 $('#remarks').attr("readonly",false);
		 $('#Update').attr("disabled",false);
		 $('#refno').attr("readonly",false);
		 $('#refno').attr("disabled",false);
		 $('#jbnos').attr("readonly",true);
		 $('#jbnos').attr("disabled",true);
		 document.getElementById("remarks").value="";
		 document.getElementById("refno").value="";
		 document.getElementById("jbnos").value=""; 
		 $('#date').val(new Date());
		 $('#date').jqxDateTimeInput({ disabled: false});
	}else if(val=="2"){
		 $('#itemsdetails').show();
		 reloads();
		 $('#cmbinfo').attr("disabled",false);
		 $('#refno').attr("disabled",false);
		 $('#remarks').attr("disabled",false);
		 $('#remarks').attr("readonly",false);
		 $('#Update').attr("disabled",false);
		 $('#jbnos').attr("readonly",false);
		 $('#jbnos').attr("disabled",false);
		 $('#refno').attr("readonly",false);
		 document.getElementById("remarks").value="";
		 document.getElementById("refno").value="";
		 document.getElementById("jbnos").value=""; 
		 $('#date').val(new Date());
		 $('#date').jqxDateTimeInput({ disabled: false});
		
		}
	else if(val=="3")
	{
		$('#itemsdetails').hide();
	 $('#cmbinfo').attr("disabled",false);
	 $('#refno').attr("disabled",true);
	 $('#remarks').attr("disabled",false);
	 $('#remarks').attr("readonly",false);
	 $('#Update').attr("disabled",false);
	 $('#jbnos').attr("readonly",true);
	 $('#jbnos').attr("disabled",true);
	 $('#refno').attr("readonly",true);
	 document.getElementById("remarks").value="";
	 document.getElementById("refno").value="";
	 document.getElementById("jbnos").value=""; 
	 $('#date').val(new Date());
	 $('#date').jqxDateTimeInput({ disabled: false});
	 
	}
 
	
	else
	{
		$('#itemsdetails').hide();
		 $('#cmbinfo').attr("disabled",true);
		 
		 $('#remarks').attr("disabled",true);
		 $('#remarks').attr("readonly",true);
		 $('#Update').attr("disabled",true);
		 $('#refno').attr("disabled",true);
		 $('#refno').attr("readonly",true);
		 $('#jbnos').attr("readonly",true);
		 $('#jbnos').attr("disabled",true);
		 document.getElementById("jbnos").value=""; 
		 document.getElementById("remarks").value="";
		 document.getElementById("refno").value="";

		 document.getElementById("cmbinfo").value="1";
		 $('#date').val(new Date());
		 $('#date').jqxDateTimeInput({ disabled: true});
	}
}
function funupdate(){    
	 var docno = document.getElementById("masterdocno").value;
	 var branchids = document.getElementById("brhid").value;
	 var remarks = document.getElementById("remarks").value;
	 var cmbinfo = document.getElementById("cmbinfo").value;
	 var refno = document.getElementById("refno").value;
	 var enqdetdocno = document.getElementById("enqdetdocno").value;
	 var hdqty = document.getElementById("hidqty").value;
	 var hdotqty = document.getElementById("hidoutqty").value;
	 var jobs = document.getElementById("jbnos").value;
	 var calcqty=parseFloat(hdqty)-parseFloat(hdotqty);
	 //alert("===cmbinfo==="+cmbinfo);
	 if(calcqty==0){
		 $.messager.alert('Message','OUT OF STOCK ','warning'); 
		 return false;
	 }      
	 if(cmbinfo==1 || cmbinfo==2){
		 var rows = $("#jqxEstimation").jqxGrid('selectedrowindexes');
		 var length=rows.length;
		 if(length==0){  
		    	$.messager.alert('Message','Choose a document','warning'); 
		    	return false;   
		 }
	 }       
	 var folldate =$('#date').val();
	 $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){                   
			if (r){
					var x=new XMLHttpRequest();
					x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200){
							var items=x.responseText.split('###');                    
							if(parseInt(items[0])>0){
								  disitems(0);
								  console.log("in=1="+parseInt(cmbinfo));
								  if((parseInt(cmbinfo)==1) || (parseInt(cmbinfo)==2)){ 
									  funSave(parseInt(items[1]),parseInt(items[2]),cmbinfo);                                           
									 // $.messager.alert('Message', 'Sub job no - '+parseInt(items[2])+' Successfully Created ','info');
									  //funreload(event);          
								  }else{
									  $.messager.alert('Message', ' Successfully Updated ','info');      
									  funreload(event);  
								  }
							}else{
								 $.messager.alert('Message', ' Not Updated '); 
							}        
							}
					}
					x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&refno="+refno+"&enqdetdocno="+enqdetdocno+"&jobs="+jobs,true);
					x.send();  
			} 
	  });   	
}   
   

function funSave(jobno,jobvoc,cmbinfo){ 
	 console.log("in=3=");  
	 $('#jqxEstimation').jqxGrid('clearfilters', true);
	 var rows = $("#jqxEstimation").jqxGrid('selectedrowindexes');
	 var length=rows.length;
	 var gridarray=new Array();
	 for(var i = 0; i < rows.length; i++){
		  	        gridarray[i]=($('#enqdetdocno').val()+"::"+$('#masterdocno').val()+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'srvdocno')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'curid')
		  	        +"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'rate')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'price')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'qty')
		  	        +"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'unitid')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'total')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'basetotal')
		  	        +"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'billing')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'vndid')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'costprice')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'margin')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'marginper')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'doc_no')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'out_qty')+"::");
	 }
	 saveData(gridarray,jobno,jobvoc,cmbinfo);         
}
function saveData(gridarray,jobno,jobvoc,cmbinfo){
	console.log("in=4=");  
	var x=new XMLHttpRequest();   
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText.trim();
			if(parseInt(items)>0)     
			{ 
				$.messager.alert('Message', 'Sub job no - '+jobvoc+' Successfully Created ','info');   
				console.log("in=4=");           
				$('#jqxEstimation').jqxGrid('clear');    
				 funreload(event);  
			}
			else
			{
				$.messager.alert('Message', '  Not Created  ','warning');   
			}  
		}
	}
	x.open("GET","estmSave.jsp?gridarray="+gridarray+"&docno="+$('#masterdocno').val()+"&enqdocno="+$('#enqdetdocno').val()+"&jobno="+jobno+"&cmbinfo="+cmbinfo,true);            
	x.send();  
}
function reloads(){
	 $("#srvtype").load('ServiceTypeSearch.jsp?modeid='+document.getElementById("modeid").value+'&smodeid='+document.getElementById("smodeid").value+'&shipid='+document.getElementById("shipid").value);
	 $("#curtype").load('currencySearch.jsp');
	 $("#vuom").load('unitSearch.jsp');
	 $("#vbill").load('billing.jsp');
}
function funAdd(){
	 //alert("===in add=====");
	
	 var service=document.getElementById("srvtype").value;
	 var hdsrvdoc=document.getElementById("hidsrvdoc").value;
	 var curncy=document.getElementById("curtype").value;
	 //alert("currency===="+curncy);
	 var hdcurid=document.getElementById("hidcurid").value;
	
	 var hdrate=document.getElementById("hidrate").value;
	 var price=document.getElementById("vprice").value;
	 var qty=document.getElementById("vqty").value;
	 var uom=document.getElementById("vuom").value;
	 var unitid=document.getElementById("hidunitid").value;
	 var blng=document.getElementById("vbill").value;
	 var costprice=document.getElementById("vcostprice").value;
	 var outqty=document.getElementById("hidoutqty").value;
	 var qotdoc=document.getElementById("hidqotdoc").value;
	 //alert("==service===="+service+"===currency===="+curncy);
	if((typeof(service)==='undefined') || (typeof(curncy)==='undefined') || (price=="") || (qty=="") || (typeof(uom)==='undefined') || (typeof(blng)==='undefined') || (costprice=="")){
		
	 if(typeof(service)==='undefined'){
			
			$.messager.alert('Message', '  Service type is Mandatory  ','warning');   
			return false;
		}
	 if(typeof(curncy)==='undefined'){
			
			$.messager.alert('Message', '  Currency is Mandatory  ','warning'); 
			return false;
		}
	 if(price==""){
		    $.messager.alert('Message', '  Price is Mandatory  ','warning');			
			return false;
		}
	 if(qty==""){
			
			$.messager.alert('Message', '  Quantity is Mandatory  ','warning');
			return false;
		}
	 if(typeof(uom)==='undefined'){
			
			$.messager.alert('Message', '  UOM is Mandatory  ','warning');
			return false;
		}
	 if(typeof(blng)==='undefined'){
			
			$.messager.alert('Message', '  Billing is Mandatory  ','warning');
			return false;
		}
	 if(costprice==""){
			
			$.messager.alert('Message', '  CostPrice is Mandatory  ','warning');
			return false;
		}
	 
	
	
	}
	else{  
	
	
		
		 $("#jqxEstimation").jqxGrid('addrow', null, {});
		 var rows1 = $("#jqxEstimation").jqxGrid('getrows');
		 var rowlength= parseInt(rows1.length)-1;
		   $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "sertype" ,service);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "srvdocno" ,hdsrvdoc);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "currency" ,curncy);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "rate" ,hdrate);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "curid" ,hdcurid);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "price" ,price);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "qty" ,qty);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "uom" ,uom);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "unitid" ,unitid);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "vndid" ,"0");
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "billing" ,blng);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "costprice" ,costprice);
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "doc_no" ,"0");
	         $('#jqxEstimation').jqxGrid('setcellvalue', rowlength, "out_qty" ,"0");
	         $("#jqxInput").jqxInput('clear');
	         $("#jqxInputcur").jqxInput('clear');
	         $("#jqxInputunit").jqxInput('clear');
	         $("#jqxInputbill").jqxInput('clear');
	         reloads();
	         document.getElementById("srvtype").value="";
			 document.getElementById("hidsrvdoc").value="";
			 document.getElementById("curtype").value="";
			 document.getElementById("hidcurid").value="";
			 document.getElementById("hidrate").value="";
			 document.getElementById("vprice").value="";
			 document.getElementById("vqty").value="";
			 document.getElementById("vuom").value="";
			 document.getElementById("hidunitid").value="";
			 document.getElementById("vcostprice").value=""; 
			 document.getElementById("vbill").value="";
			 document.getElementById("hidbillid").value="";
			 document.getElementById("hidoutqty").value="";
			 document.getElementById("hidqotdoc").value="";
	        //$("#srvtype").focus();
	        document.getElementById("jqxInput").focus();
	
	}
}
function validateser(){
	 
	 var tst1=document.getElementById("hidsrvdoc").value;
	// alert("===on validate==="+tst1);
	 if (tst1==""){
		 //document.getElementById("errormsg").innerText="Selected Service Type Not Valid";
		 $.messager.alert('Message', '  Selected Service Type Not Valid  ','warning');
		 document.getElementById("jqxInput").focus();
	 }else{
		
	 }
	
}
function validatecur(){
	 var tst2=document.getElementById("hidcurid").value;
	 if (tst2==""){
		// document.getElementById("errormsg").innerText="Selected Currency Not Valid";
		 $.messager.alert('Message', '  Selected Currency Not Valid  ','warning');
		 document.getElementById("jqxInputcur").focus();
	 }else{
		
	 } 
}
function validateuom(){
	 var tst3=document.getElementById("hidunitid").value;
	 if (tst3==""){
		 //document.getElementById("errormsg").innerText="Selected Unit Not Valid";
		 $.messager.alert('Message', '  Selected Unit Not Valid  ','warning');
		 document.getElementById("jqxInputunit").focus();
	 }else{
		 
	 } 
}
function validatebill(){
	 var tst4=document.getElementById("hidbillid").value;
	 if (tst4==""){
		 //document.getElementById("errormsg").innerText="Selected Billing Not Valid";
		 $.messager.alert('Message', '  Selected Billing Not Valid  ','warning');
		 document.getElementById("jqxInputbill").focus();
	 }else{
		 
	 } 
}
</script>
</head>
<body onload="getBranch();getinfo();disitems(0);">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 
</tr> 
     
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                    <tr>
    <td width="30%" align="right"><label class="branch">Type</label></td>
    <td width="70%" align="left"><select id="cmbgridfilter" name="cmbgridfilter" onchange="funClear();" value='<s:property value="cmbgridfilter"/>'>
    <option value="1">Pending</option>
    <option value="2">All</option>
    </select></td>
    </tr>
                        <tr><td colspan="2">&nbsp;</td>
    <tr><td colspan="2" align="center"><input type="button" hidden="true" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr> 
             <tr><td colspan="2">&nbsp;</td></tr> 
    	             
    	                    
    	               <tr><td colspan="2"><label  class="showdet" id="showdet"></label> </td></tr> 
    	               <tr><td colspan="2">&nbsp;</td></tr>    
    <tr> <td  align="right"><label class="branch">Process</label></td><td align="left">
    <select name="cmbinfo" id="cmbinfo" style="width:70%;" value='<s:property value="cmbinfo"/>' onchange="disitems(this.value)" > </select></td></tr>
     <tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div> </td></tr>
       <tr><td align="right"><label class="branch">Ref NO</label></td><td align="left"><input type="text" id="refno" style="height:20px;width:88%;" name="refno"  value='<s:property value="refno"/>'> </td></tr>
    <tr><td align="right"><!-- <label class="branch">Jobs</label> --></td><td align="left"><input type="hidden" id="jbnos" style="height:20px;width:88%;" name="jbnos" placeholder="Enter No of Jobs"   value='<s:property value="jbnos"/>'> </td></tr>
    <tr><td align="right"><label class="branch">Remarks</label></td><td align="left"><input type="text" id="remarks" style="height:20px;width:88%;" name="remarks"  value='<s:property value="remarks"/>'> </td></tr>
    <tr><td  align="center" colspan="2"><input type="Button" name="Update" id="Update" class="myButton" value="Update" onclick="funupdate()"> </td> </tr>
    	<tr><td colspan="2">&nbsp;</td></tr> 
    	   <tr><td colspan="2">&nbsp;</td></tr> 
    	   
       <tr><td colspan="2">&nbsp;</td></tr> 
    	<input type="hidden" name="docnosss" id="docnosss" value='<s:property value="docnosss"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getdetails(event);" >
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height:90px;"></div></td>
	</tr>	
	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
      <input type="hidden" id="brhid" name="brhid" value='<s:property value="brhid"/>'>
      
        <input type="hidden" id="reftype" name="reftype" value='<s:property value="reftype"/>'>
           <input type="hidden" id="reqdocno" name="reqdocno" value='<s:property value="reqdocno"/>'>
      
        <input type="hidden" id="enqdetdocno" name="enqdetdocno" value='<s:property value="enqdetdocno"/>'>

      <input type="hidden" id="hidqty" name="hidqty" value='<s:property value="hidqty"/>'>
           <input type="hidden" id="hidoutqty" name="hidoutqty" value='<s:property value="hidoutqty"/>'>
   
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="listdiv"><jsp:include page="mainGrid.jsp"></jsp:include></div></td></tr>
	    <tr><td>
	    <fieldset id="itemsdetails">
	    <table width="100%">

<tr>
<td width="6%" align="left" ><label class="branch">Service Type</label></td ><td width="8%"><div id="srvtype" onchange="validateser();"    onkeydown="return (event.keyCode!=13);"><jsp:include page="ServiceTypeSearch.jsp"></jsp:include></div>
         <input type="hidden" id="hidsrvdoc" name="hidsrvdoc" value='<s:property value="hidsrvdoc"/>'></td> 

<td width="3%" align="right"><label class="branch">Currency</label></td>
<td width="5%"><div id="curtype" onchange="validatecur();"    onkeydown="return (event.keyCode!=13);"><jsp:include page="currencySearch.jsp"></jsp:include></div>
<input type="hidden" id="hidcurid" name="hidcurid" value='<s:property value="hidcurid"/>'></td>
<td width="1%" align="right"><label class="branch">Rate</label></td>
<td width="7%"><input type="text" id="hidrate" name="hidrate" style="text-align:right;height:20;width:95%" value='<s:property value="hidrate"/>'></td>
<td width="2%" align="right"><label class="branch">Price</label></td>
<td width="6%"><input type="text" id="vprice" name="vprice" onkeypress="javascript:return isNumber1 (event);" style="width:95%;text-align:right;height:20;" value='<s:property value="vprice"/>'></td>
<td width="2%" align="right"><label class="branch">Quantity</label></td>
<td width="5%"><input type="text" id="vqty" name="vqty" onkeypress="javascript:return isNumber1 (event);" style="width:95%;text-align:right;height:20;" value='<s:property value="vqty"/>'></td>
<td width="1%" align="right"><label class="branch">UOM</label></td>
<td width="5%"><div id="vuom" onchange="validateuom();"   onkeydown="return (event.keyCode!=13);"><jsp:include page="unitSearch.jsp"></jsp:include></div>
<input type="hidden" id="hidunitid" name="hidunitid"  value='<s:property value="hidunitid"/>'></td>
<td width="2%" align="right"><label class="branch">Billing</label></td>
<td width="7%"><div id="vbill" onchange="validatebill();"   onkeydown="return (event.keyCode!=13);"><jsp:include page="billing.jsp"></jsp:include></div></td>
<td width="5%" align="right"><label class="branch">Cost Price</label></td>
<td width="7%"><input type="text" id="vcostprice" name="vcostprice" onkeypress="javascript:return isNumber1 (event);" style="width:95%;text-align:right;height:20;" value='<s:property value="vcostprice"/>'></td>
<tr>
<td align="right" colspan="7">
<input type="button" name="btnAdd" id="btnAdd" value="ADD" class="myButton" onclick="funAdd();">
</td></tr>
</table>

	    </fieldset>
	    </td></tr>
	    <tr><td><div id="estdiv"><jsp:include page="estmgrid.jsp"></jsp:include></div></td></tr>          
		<%-- <tr><td><div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div></td></tr> --%>
	</table>
</tr>
</table>
<input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'>
<input type="hidden" id="modeid" name="modeid"  value='<s:property value="modeid"/>'/>
<input type="hidden" id="smodeid" name="smodeid"  value='<s:property value="smodeid"/>'/>
<input type="hidden" id="shipid" name="shipid"  value='<s:property value="shipid"/>'/>
<input type="hidden" id="vuom" name="vuom"  value='<s:property value="vuom"/>'/>
<input type="hidden" id="vbill" name="vbill"  value='<s:property value="vbill"/>'/>
<input type="hidden" id="curtype" name="curtype"  value='<s:property value="curtype"/>'/>
<input type="hidden" id="srvtype" name="srvtype"  value='<s:property value="srvtype"/>'/>
<input type="hidden" id="hidbillid" name="hidbillid"  value='<s:property value="hidbillid"/>'/>
<input type="hidden" id="hidqotdoc" name="hidqotdoc"  value='<s:property value="hidqotdoc"/>'/>
<input type="hidden" id="hidoutqty" name="hidoutqty"  value='<s:property value="hidoutqty"/>'/>
</div>         
	  <div id="locationwindow">
	   <div ></div>
	</div>

<div id="Searchwindow">
   <div ></div>
</div> 
</div>
</body>
</html>