 
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
		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#monthdate").jqxDateTimeInput({ width: '170px', height: '15px',formatString:"MMMM.yyyy"});
    	$("#hidmonthdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	    
	    $('#contractDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#contractDetailsWindow').jqxWindow('close');
		
	    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	    var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
        $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));

        $('#todate').on('change', function (event) {
			
	    	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 	 
			if(fromdates>todates){
	    		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
			    return false;
		  }   
	 	});
        
        var dt = new Date();
        $('#monthdate').jqxDateTimeInput('setDate', new Date(dt.getFullYear(), dt.getMonth()+1, 0)); 
        

        $('#txtcontract').dblclick(function(){
		 	contractSearchContent('contractDetailsSearch.jsp?type=1');
      	});
      	
      	$('#txtcontractvocno').dblclick(function(){
		 	contractSearchContent('contractDetailsSearch.jsp?type=2');
      	});
});

	function contractSearchContent(url) {
	    $('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getContract(event,type){
        var x= event.keyCode;
        if(x==114){
 		 	contractSearchContent('contractDetailsSearch.jsp?type='+type);
        }
    }
	
	function funClearInfo(){

   	 	 $('#cmbbranch').val('a');
   	 	 $('#fromdate').val(new Date());
   	 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 
		 document.getElementById("txtcontract").value="";
		 document.getElementById("txtcontracttrno").value="";
		 $("#amsSupHrsGrid").jqxGrid('clear');
		 
		 if (document.getElementById("txtcontract").value == "") {
		        $('#txtcontract').attr('placeholder', 'Press F3 to Search'); 
		  }
	}
	
	function funreload(event){
		var branch=$('#cmbbranch').val();  
		/* if(branch=="a"){
			 $.messager.alert('Warning','Please select a Branch');
			 return false;
		} */
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 	 
		 if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   	   return false;
		  }
		  
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var contract= $("#txtcontracttrno").val();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#amsSupHrsDiv").load("amssupportedhrsreportGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&contract="+contract+"&check=1");
		 
	}
	
	function funExportBtn(){
		$("#amsSupHrsDiv").excelexportjs({  
       		containerid: "amsSupHrsDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "amsSupHrsGrid", 
       		columns: getColumns("amsSupHrsGrid") , 
       		worksheetName:"AMS Supported Hours Report"
       	}); 
	}
 
	function updateHrsSupported(){
		
		var monthdate = new Date($('#monthdate').jqxDateTimeInput('getDate'));
		$("#hidmonthdate").jqxDateTimeInput('setDate', new Date(monthdate));
		var todate = $("#hidmonthdate").val();
		
		var docno=$("#hidcontractdocno").val();
		
		if(docno==""){
			$.messager.alert('Warning','Select Contract');
			return false;
		}
		
		var supporthrs=$("#supporthrs").val();
		if(supporthrs.trim()=="" || !$.isNumeric(supporthrs)){
			$.messager.alert('Warning','Enter Hours');
			return false;
		}
		
		var brhid=$("#hidbrhid").val()
		
		$.messager.confirm('Message', 'Save ?', function(r){  
			if(r==false) {
				return false; 
			} else {
				$("#overlay, #PleaseWait").show();
				
				saveHrsSupported(docno, brhid, todate, supporthrs);              
			}
		});
	}

	function saveHrsSupported(docno, brhid, todate, supporthrs){
		 var x=new XMLHttpRequest();
		    x.onreadystatechange=function(){
		    if (x.readyState==4 && x.status==200){     
		    		var items=x.responseText.trim();
		    		
		    		var period=items.split('#')[0]
		    		var invoiced=items.split('#')[1]
		    		var val=items.split('#')[2]
		    		
		    		if(parseInt(period)==0){  
						$.messager.alert('Message','Contract not available for this period','warning');
						$("#overlay, #PleaseWait").hide();   
					
		    		}else if(parseInt(invoiced)>0){  
						$.messager.alert('Message','Contract Invoiced','warning');
						$("#overlay, #PleaseWait").hide();   
					
		    		}else if(parseInt(val)>0){  
						$.messager.alert('Message','Saved Successfully','success');
						$("#overlay, #PleaseWait").hide();   
						funreload();
					
		    		}else{ 
						$.messager.alert('Message','Not saved','warning');     
						$("#overlay, #PleaseWait").hide();                         
					} 
		    	 } 
		    }       
		    x.open("GET","updateSupHrs.jsp?docno="+docno+"&brhid="+brhid+"&todate="+todate+"&supporthrs="+supporthrs,true);                                                                                                 
		    x.send();               
	}
	
</script>

</head>
<body onload="getBranch();" >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">From</label></td>
	<td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td></tr>
    <tr><td align="right"><label class="branch">To</label></td>
	<td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td></tr>
 	<tr><td width="20%" align="right"><label class="branch">Contract No</label></td>
    <td><input type="text" id="txtcontract" name="txtcontract" style="width:90%;height:20px;" onKeyDown="getContract(event,'1');" readonly placeholder="Press F3 to Search" value='<s:property value="txtcontract"/>' />
    <input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'/></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
   
    
    <tr><td align="right"><label class="branch">Month</label></td>
		<td align="left"><div id='monthdate' name='monthdate' value='<s:property value="monthdate"/>'></div></td>
		<td hidden align="left"><div id='hidmonthdate' name='hidmonthdate' value='<s:property value="hidmonthdate"/>'></div></td>
	</tr>
	
	 <tr><td align="right"><label class="branch">Contract No</label></td>
	 <td><input type="text" id="txtcontractvocno" name="txtcontractvocno" style="width:90%;height:20px;" onKeyDown="getContract(event,'2');" readonly placeholder="Press F3 to Search" value='<s:property value="txtcontractvocno"/>' />
    <input type="hidden" id="hidcontractdocno" name="hidcontractdocno" value='<s:property value="hidcontractdocno"/>'/>
    <input type="hidden" id="hidbrhid" name="hidbrhid" value='<s:property value="hidbrhid"/>'/></td></tr>
   
	 <tr><td align="right"><label class="branch"></label></td>
	 <td><input type="text" id="txtcontractdet" name="txtcontractdet" style="width:90%;height:20px;" readonly  value='<s:property value="txtcontractdet"/>' /></td></tr>
   
    <tr><td align="right"><label class="branch">Hours</label></td>
		<td align="left"><input type="text" id='supporthrs' name='supporthrs' style="width:90%;height:20px;"  onblur="funRoundAmt(this.value,this.id);" value='<s:property value="supporthrs"/>'/></td>
	</tr>
	
	  <tr><td colspan="2" align="center"><input type="button" class="myButton" name="btnsuphrssave" id="btnsuphrssave"  value="Save" onclick="updateHrsSupported();"></td></tr>
   
    <tr><td colspan="2">&nbsp;</td></tr>     
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr>
   </table>             
</fieldset>
</td>
<td width="80%">
		<table width="100%">
		<tr>
			<td><div id="amsSupHrsDiv"><jsp:include page="amssupportedhrsreportGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</td>
</tr>
</table>
</div>

<div id="contractDetailsWindow">
	<div></div><div></div>
</div>

</div>
</body>
</html>