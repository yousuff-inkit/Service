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

.account {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.accname {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}

</style>
<script type="text/javascript">
    
	var selectedBox = null;
	
	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $('#searchWindow').jqxWindow({ width: '60%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#searchWindow').jqxWindow('close');
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#cmbchoose').val('4');$('#txtnoofdays').attr('readonly', true );$('#txtnoofdays').val('');
 		 
	     $("#overlay, #PleaseWait").show();
	});
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function getGridColumnCalculation(fromdate,todate,frequencytype,noofdays,summarytype,hidsalesman,hidcatid,hideptid,hicashid,hicreditid){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  			      var frequencyType=items[0];
		          var difference=items[1];
		          var columns=items[2];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else{
		        	  
		        	  var branchval = document.getElementById("cmbbranch").value;
		     		  var check=1;
		        	  $("#overlay, #PleaseWait").show();
		     		 
		     		  $("#analysisDiv").load("salesAnalysisReportGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&frequencytype='+frequencytype+'&noofdays='+noofdays+'&summarytype='+summarytype+"&hidsalesman="+hidsalesman+"&hidcatid="+hidcatid+"&hideptid="+hideptid+"&hicashid="+hicashid+"&hicreditid="+hicreditid+'&check='+check);
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate+"&frequencytype="+frequencytype+"&noofdays="+noofdays, true);
		x.send();
}
	
	function noOfDays(){
		if($('#cmbchoose').val()==1){
			$('#txtnoofdays').attr('readonly', false );$('#txtnoofdays').val('0');			
		}else{
			$('#txtnoofdays').attr('readonly', true );$('#txtnoofdays').val('');
		}
	}
	
	 function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var frequencytype = $('#cmbchoose').val();
		 var noofdays = $('#txtnoofdays').val();
		 var hidsalesman=document.getElementById("hidsalesman").value;
		 var hidcatid=document.getElementById("hidcatid").value;
		 var hideptid=document.getElementById("hideptid").value;
		 var hicashid=document.getElementById("hicashid").value;
		 var hicreditid=document.getElementById("hicreditid").value;
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
        }
		 if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
				return;
		 	}
		 var summarytype = $('#cmbsummarytype').val();
		 getGridColumnCalculation(fromdate,todate,frequencytype,noofdays,summarytype,hidsalesman,hidcatid,hideptid,hicashid,hicreditid);
	 }
	 
	 function  funClearInfo(){
	        $('#cmbbranch').val('a');
			$('#fromdate').val(new Date());
			var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
		    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
		    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
		    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
			$('#todate').val(new Date());
			$('#cmbchoose').val('4');
			$('#txtnoofdays').val('');
			$('#txtnoofdays').attr('readonly', true );
			
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
			document.getElementById("hicash").value="";
			document.getElementById("hicashid").value="";
			document.getElementById("hicredit").value="";
			document.getElementById("hicreditid").value="";
		}
		
		function funExportBtn(){
			var summary=$('#cmbsummarytype').val();
			if(summary=='slm'){
				summary="SALESMAN";
			}else if(summary=='dpt'){
				summary="DEPARTMENT";
			} else if(summary=='ctg'){
				summary="CATEGORY";
			}else if(summary=='csh'){
			summary="TYPE";
		    }
			
		  if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'Sales Analysis Report  -   '+summary, true);
		 } else {
			$("#analysisGrid").jqxTreeGrid('exportData', 'xls');
		 } 
		}
		function setSearch(){
			
			var value=$('#searchby').val().trim();
			
			if(value=="sslm"){
				getSalesman();
			}
			else if(value=="sdpt"){
				getDepartment();
			}
			else if(value=="sctg"){
				getCategory();
			}
			else if(value=="scsh"){
				getCash();
			}
			
			else{}
		}
		function setRemove(){
			
			var value=$('#searchby').val().trim();
			
			if(value=="sslm"){
				document.getElementById("searchdetails").value="";
				document.getElementById("salesman").value="";
				document.getElementById("hidsalesman").value="";
				if(document.getElementById("hidept").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
				} if(document.getElementById("hidcat").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidcat").value; 
				} if(document.getElementById("hicash").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicash").value; 
				} if(document.getElementById("hicredit").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicredit").value; 
				} 
				 
			} else if(value=="sdpt"){
				document.getElementById("searchdetails").value="";
				document.getElementById("hidept").value="";
				document.getElementById("hideptid").value="";
				if(document.getElementById("salesman").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
				} if(document.getElementById("hidcat").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidcat").value; 
				}  if(document.getElementById("hicash").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicash").value; 
				} if(document.getElementById("hicredit").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicredit").value; 
				} 
			}
			else if(value=="sctg"){
				document.getElementById("searchdetails").value="";
				document.getElementById("hidcat").value="";
				document.getElementById("hidcatid").value="";
				if(document.getElementById("salesman").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
				} 
				if(document.getElementById("hidept").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
				} if(document.getElementById("hicash").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicash").value; 
				} if(document.getElementById("hicredit").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicredit").value; 
				} 
			}
			else if(value=="scsh"){
				document.getElementById("searchdetails").value="";
				document.getElementById("hicash").value="";
				document.getElementById("hicashid").value="";
				if(document.getElementById("salesman").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
				} 
				if(document.getElementById("hidept").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
				} if(document.getElementById("hidcat").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidcat").value; 
				} if(document.getElementById("hicredit").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicredit").value; 
				} 
			}
			else if(value=="scdt"){
				document.getElementById("searchdetails").value="";
				document.getElementById("hicredit").value="";
				document.getElementById("hicreditid").value="";
				if(document.getElementById("salesman").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("salesman").value; 
				} 
				if(document.getElementById("hidept").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidept").value; 
				} if(document.getElementById("hicash").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hicash").value; 
				} if(document.getElementById("hidcat").value!=""){
					   document.getElementById("searchdetails").value+=document.getElementById("hidcat").value; 
				} 
			}
		}
		function getSalesman(){
			searchContent('salesmanSearch.jsp?id=1');
		}
		function getDepartment(){
			searchContent('departmentSearch.jsp');
		}
		function getCategory(){
			searchContent('categorySearch.jsp');
		}
		function getCash(){
			searchContent('cashSearch.jsp');
		}
		
		function searchContent(url) {
		    $('#searchWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#searchWindow').jqxWindow('setContent', data);
			$('#searchWindow').jqxWindow('bringToFront');
		}); 
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
     <tr><td align="right" width="32%"><label class="branch">From</label></td>
         <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
     </tr> 
     <tr><td align="right"><label class="branch">To</label></td>
         <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
     </tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	 
	<tr><td colspan="2"><table width="100%">
	<tr>
      <td align="right"><label class="branch">Type</label></td>
      <td><select id="cmbchoose" name="cmbchoose" style="width:50%;" onchange="noOfDays();" value='<s:property value="cmbchoose"/>'>
      <option value="2">Monthly</option><option value="3">Quarterly</option><option value="4">Yearly</option></select>&nbsp;&nbsp;
      <input type="hidden" id="txtnoofdays" name="txtnoofdays" style="width:50%;height:20px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtnoofdays"/>'/>
      </td>
    </tr>
	<tr>
	<td align="right" width="30%"><label class="branch">Summary</label></td>
	    <td align="left">
	    	<select id="cmbsummarytype" name="cmbsummarytype" style="width:50%;" value='<s:property value="cmbsummarytype"/>'>
			<option value="slm">Salesman</option>
			<option value="dpt">Department</option>
			<option value="ctg">Category</option>
			<option value="csh">TYPE</option>
			
	    </td></tr>
	    
	    <tr>
	    <td align="right" ><label class="branch">Search By</label></td>
	    <td>
	    <table width="100%" cellspacing="0" cellpadding="0">
	    <tr><td align="left">
		    <select name="searchby" id="searchby" style="width:83%;">
		    <option value="">--Select--</option>
		    <option value="sslm">Salesman</option>
		    <option value="sdpt">Department</option>
		    <option value="sctg">Category</option>
		    <option value="scsh">Type</option></select>
		    
		</td>
	    <td><button type="button" name="btnadditem" id="additem" class="myButtons1" onClick="setSearch();">+</button></td>
	    <td><button type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons1" onclick="setRemove();">-</button></td>
	  </tr>
	  
	  </table></td></tr>
	  <tr>
    <td colspan="4" align="center"><textarea id="searchdetails" style="height:140px;width:230px;font: 10px Tahoma;resize:none" name="searchdetails" readonly="readonly"><s:property value="searchdetails"></s:property></textarea>
    </td>
  </tr>
   
   
    </table></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	
			<input type="hidden" name="salesman" id="salesman">
			<input type="hidden" name="hidsalesman" id="hidsalesman">
			
			<input type="hidden" name="hidcat" id="hidcat">
			<input type="hidden" name="hidcatid" id="hidcatid">
			
			<input type="hidden" name="hidept" id="hidept">
			<input type="hidden" name="hideptid" id="hideptid">
			
			<input type="hidden" name="hicash" id="hicash">
			<input type="hidden" name="hicashid" id="hicashid">
			
			<input type="hidden" name="hicredit" id="hicredit">
			<input type="hidden" name="hicreditid" id="hicreditid">
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		 <tr>
		    <td><div id="analysisDiv"><jsp:include page="salesAnalysisReportGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td></tr>
</table>
<div id="searchWindow">
	<div></div>
</div>
</div>

</div> 
</body>
</html>