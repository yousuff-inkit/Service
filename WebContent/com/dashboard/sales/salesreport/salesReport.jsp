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
</style>
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
.myButtonss {
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
.myButtonss:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtonss:active {
	position:relative;
	top:1px;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {

		
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		   
		 $('#searchWindow').jqxWindow({ width: '60%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#searchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	   
	     
	 		 
	     
	});
		

	function funreload(event){
		 var fromdate = $('#fromdate').jqxDateTimeInput('val');
		 var todate = $('#todate').jqxDateTimeInput('val');
		 
		 if(fromdate>todate) {
				$.messager.alert('Message','Not a Valid Period,From Date is greater than to Date.','warning');
				return;
         }
		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
				return;
		 	}
		 	var branchval = document.getElementById("cmbbranch").value;
      	  	var summarytype = $('#cmbsummarytype').val();
      	  	var hidsalesman=document.getElementById("hidsalesman").value;
      	  	var hidpassdate=document.getElementById("hidpassdate").value;
      	  	var hidaccno=document.getElementById("hidaccno").value;
			var hideptid=document.getElementById("hideptid").value;
			var hidbrandid=document.getElementById("hidbrandid").value;
			var hidproductid=document.getElementById("hidproductid").value;
			
			/* alert("salesReportGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate
   					+'&summarytype='+summarytype+"&hidsalesman="+hidsalesman+"&hidpassdate="+hidpassdate+"&hidaccno="+hidaccno+"&hideptid="+hideptid
   				  	+"&hidbrandid="+hidbrandid+"&hidproductid="+hidproductid+"&check=1"); */
			$("#overlay, #PleaseWait").show();
   		  $("#salesReportGridDiv").load("salesReportGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate
   					+'&summarytype='+summarytype+"&hidsalesman="+hidsalesman+"&hidpassdate="+hidpassdate+"&hidaccno="+hidaccno+"&hideptid="+hideptid
   				  	+"&hidbrandid="+hidbrandid+"&hidproductid="+hidproductid+"&check=1");
	}
	
	function funExportBtn(){
	    JSONToCSVConvertor(dataexcel, 'SalesReport', true);
	} 
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	
	function searchContent(url) {
	    $('#searchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#searchWindow').jqxWindow('setContent', data);
		$('#searchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccount(){
	 	 searchContent('accountSearch.jsp?id=4');
	}
	
	function getSalesman(){
		searchContent('salesmanSearch.jsp?id=1');
	}
	
	function getDate(){
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
	    var todate=$('#todate').jqxDateTimeInput('val');
		
		searchContent('dateSearch.jsp?id=3&fromdate='+fromdate+'&todate='+todate);
	}
	
	function getDepartment(){
		searchContent('departmentSearch.jsp');
	}
	
	function getBrand(){
		searchContent('brandSearch.jsp?id=2');
	}
	
	function getProduct(){
		var brandid=$('#hidbrandid').val().trim();
		searchContent('productSearch.jsp?brandid='+brandid);
	}
	
function setSearch(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="sacc"){
			getAccount();
		}
		else if(value=="sdat"){
			getDate();
		}
		else if(value=="sslm"){
			getSalesman();
		}
		else if(value=="sbrd"){
			getBrand();
		}
		else if(value=="sprd"){
			getProduct();
		}
	    else if(value=="sdpt"){
			getDepartment();
		}
		else{}
	}
	
	function setRemove(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="sslm"){
			document.getElementById("searchdetails").value="";
			document.getElementById("salesman").value="";
			document.getElementById("hidsalesman").value="";
			if(document.getElementById("hiddate").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hiddate").value; 
			} if(document.getElementById("accno").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("accno").value; 
			} if(document.getElementById("hidept").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
			} if(document.getElementById("hidbrand").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidbrand").value; 
			} if(document.getElementById("hidproduct").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidproduct").value; 
			} 
			 
		} else if(value=="sdat"){
			document.getElementById("searchdetails").value="";
			document.getElementById("hiddate").value="";
			if(document.getElementById("salesman").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
			} if(document.getElementById("accno").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("accno").value; 
			} if(document.getElementById("hidept").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
			} if(document.getElementById("hidbrand").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidbrand").value; 
			} if(document.getElementById("hidproduct").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidproduct").value; 
			}
		} else if(value=="sacc"){
			document.getElementById("searchdetails").value="";
			document.getElementById("accno").value="";
			document.getElementById("hidaccno").value="";
			if(document.getElementById("salesman").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
			} if(document.getElementById("hiddate").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hiddate").value; 
			} if(document.getElementById("hidept").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
			} if(document.getElementById("hidbrand").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidbrand").value; 
			} if(document.getElementById("hidproduct").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidproduct").value; 
			}
		} else if(value=="sdpt"){
			document.getElementById("searchdetails").value="";
			document.getElementById("hidept").value="";
			document.getElementById("hideptid").value="";
			if(document.getElementById("salesman").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
			} if(document.getElementById("hiddate").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hiddate").value; 
			} if(document.getElementById("accno").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("accno").value; 
			} if(document.getElementById("hidbrand").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidbrand").value; 
			} if(document.getElementById("hidproduct").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidproduct").value; 
			}
		} else if(value=="sbrd"){
			document.getElementById("searchdetails").value="";
			document.getElementById("hidbrd").value="";
			document.getElementById("hidbrandid").value="";
			if(document.getElementById("salesman").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
			} if(document.getElementById("hiddate").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hiddate").value; 
			} if(document.getElementById("accno").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("accno").value; 
			} if(document.getElementById("hidproduct").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidproduct").value; 
			} if(document.getElementById("hidept").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
			}
		} else if(value=="sprd"){
			document.getElementById("searchdetails").value="";
			document.getElementById("hidprd").value="";
			document.getElementById("hidproductid").value="";
			if(document.getElementById("salesman").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
			} if(document.getElementById("hiddate").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hiddate").value; 
			} if(document.getElementById("accno").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("accno").value; 
			} if(document.getElementById("hidept").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
			} if(document.getElementById("hidbrand").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("hidbrand").value; 
			}
		}
	}
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
			
		document.getElementById("searchdetails").value="";
		document.getElementById("searchby").value="";
		document.getElementById("salesman").value="";
		document.getElementById("hidsalesman").value="";
		document.getElementById("hiddate").value="";
		document.getElementById("accno").value="";
		document.getElementById("hidaccno").value="";
		document.getElementById("hidept").value="";
		document.getElementById("hideptid").value="";
		document.getElementById("hidbrand").value="";
		document.getElementById("hidbrandid").value="";
		document.getElementById("hidproduct").value="";
		document.getElementById("hidproductid").value="";
		
	}
	
	function funPrintbtn(){
    	   
		var summarytype=document.getElementById("cmbsummarytype").value;
    	var passdate=document.getElementById("hidpassdate").value;
    	 var Fromdate = $('#fromdate').jqxDateTimeInput('val');
    	 var todate = $('#todate').jqxDateTimeInput('val');
    	var Accno=document.getElementById("hidaccno").value;
    	var salesman=document.getElementById("hidsalesman").value;
    	var productid=document.getElementById("hidproductid").value;
    	var brandid=document.getElementById("hidbrandid").value;
    	var ptid=document.getElementById("hideptid").value;
    	
		//alert(summarytype+passdate+Fromdate+todate+Accno+salesman+productid+brandid+ptid);
		
	        var url=document.URL;
	        var reurl=url.split("salesReport.jsp");
	       // $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printsalesreport1?summarytype="+summarytype+'&passdate='+passdate+'&fromdate='+Fromdate+'&todate='+todate+'&Accno='+Accno+'&salesman='+salesman+'&productid='+productid+'&brandid='+brandid+'&ptid='+ptid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	    
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
	<tr>
		<td align="right"><label class="branch">From</label></td>
		<td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
		<td align="right"><label class="branch">To</label></td>
	    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr>
	<td align="right" width="30%"><label class="branch">Summary</label></td>
	    <td align="left">
	    	<select id="cmbsummarytype" name="cmbsummarytype" style="width:50%;" value='<s:property value="cmbsummarytype"/>'>
			<option value="acc">Account</option><option value="slm">Salesman</option>
			<option value="dat">Date</option><option value="dpt">Department</option>
			<option value="brd">Brand</option><option value="prd">Product</option>
	    </td></tr>
	  <tr>
	    <td align="right" ><label class="branch">Search By</label></td>
	    <td>
	    <table width="100%" cellspacing="0" cellpadding="0"><tr><td align="left">
		    <select name="searchby" id="searchby" style="width:83%;">
		    <option value="">--Select--</option><option value="sacc">Account</option>
		    <option value="sslm">Salesman</option><option value="sdat">Date</option>
		    <option value="sdpt">Department</option><option value="sbrd">Brand</option>
		    <option value="sprd">Product</option></select>
		</td>
	    <td><button type="button" name="btnadditem" id="additem" class="myButtons1" onClick="setSearch();">+</button></td>
	    <td><button type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons1" onclick="setRemove();">-</button></td>
	  </tr>
	  </table></td></tr>
  <tr>
    <td colspan="4" align="center"><textarea id="searchdetails" style="height:140px;width:230px;font: 10px Tahoma;resize:none" name="searchdetails" readonly="readonly"><s:property value="searchdetails"></s:property></textarea>
    </td>
  </tr>
	<tr><td colspan="1"><left><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></left></td>
	<td><right><input type="button" name="print" id="print" value="Print" class="myButtons" onclick="funPrintbtn();"></right></td>
	
	
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">
			<input type="hidden" name="salesman" id="salesman">
			<input type="hidden" name="hidsalesman" id="hidsalesman">
			
			<input type="hidden" name="hiddate" id="hiddate">
			<input type="hidden" name="hidpassdate" id="hidpassdate">
			
			<input type="hidden" name="hidept" id="hidept">
			<input type="hidden" name="hideptid" id="hideptid">
			
			<input type="hidden" name="hidbrand" id="hidbrand">
			<input type="hidden" name="hidbrandid" id="hidbrandid">
			
			<input type="hidden" name="hidproduct" id="hidproduct">
			<input type="hidden" name="hidproductid" id="hidproductid">
			
			<input type="hidden" name="accno" id="accno">
			<input type="hidden" name="hidaccno" id="hidaccno">
			
			
			
	</td></tr>  
	</table><br/><br/><br/>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="salesReportGridDiv"><jsp:include page="salesReportGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</td>
</tr>
</table>
</div>

<div id="searchWindow">
	<div></div>
</div>

</div>
</body>
</html>