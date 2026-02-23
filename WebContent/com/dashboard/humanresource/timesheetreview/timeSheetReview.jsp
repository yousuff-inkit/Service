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

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}


.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}


.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
input[type="text"],
select {
    width: 100%;
    height: 28px !important;   /* Slightly smaller */
    padding: 6px 10px;
    font-size: 13px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    box-sizing: border-box;
    background-color: #ffffff;
}

</style>


<script type="text/javascript">

	$(document).ready(function () {
		 $('#branchlabel').hide();$('#branchdiv').hide();
		 
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true, value: null});
		
     	 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
  		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost ID Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#txtemployeeid').dblclick(function(){
			 $('#txtorgridclick').val('1');
		  	 employeeSearchContent("employeeDetailsSearch.jsp");
	     });
		 
		 $('#txtprojecttype').dblclick(function(){
			 $('#txtorgridclick').val('1');
			 costTypeSearchContent("costTypeSearchGrid.jsp");
	     });
		 
		 $('#txtprojectidname').dblclick(function(){
			 if($('#txtprojecttypeid').val()==''){
	   			 	$.messager.alert('Message','Cost Type is Mandatory.','warning');
	   			 	return 0;
	   		 }
			 $('#txtorgridclick').val('1');
			 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtprojecttypeid').val());
	     });
		 
		 document.getElementById("rdsummary").checked=true;reportTypeChange();
		 document.getElementById("chckorderbydate").checked=true;document.getElementById("hidchckorderbydate").value = 1;
		 $('#chckorderbydate').attr('disabled', true);
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if($('#hidcmbyear').val()){
						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
						funreload(event);
					  }
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
	
	function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbempcategory").html(optionspayrollcategory);
				
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	 $('#txtorgridclick').val('1');
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
	 }
	 
	 function getProjectType(event){
	        var x= event.keyCode;
	        if(x==114){
	        	 $('#txtorgridclick').val('1');
				costTypeSearchContent("costTypeSearchGrid.jsp");
	        }
	        else{}
		 }
	 
	 function getProjectId(event){
	        var x= event.keyCode;
	        if(x==114){
	        	if($('#txtprojecttypeid').val()==''){
	   			 	$.messager.alert('Message','Cost Type is Mandatory.','warning');
	   			 	return 0;
	   		     }
	        	 $('#txtorgridclick').val('1');
				 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtprojecttypeid').val());
	        }
	        else{}
		 }

	 function orderbycheck(){
		 if(document.getElementById("chckorderbydate").checked==true){
			 document.getElementById("hidchckorderbydate").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbydate").value = 0;
		 }
		 
		 if(document.getElementById("chckorderbyemployee").checked==true){
			 document.getElementById("hidchckorderbyemployee").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbyemployee").value = 0;
		 }
		 
		 if(document.getElementById("chckorderbycosttype").checked==true){
			 document.getElementById("hidchckorderbycosttype").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbycosttype").value = 0;
		 }
		 
		 if(document.getElementById("chckorderbycostid").checked==true){
			 document.getElementById("hidchckorderbycostid").value = 1;
		 }
		 else {
			 document.getElementById("hidchckorderbycostid").value = 0;
		 }
	 }
	 
	 function  funClearInfo(){
			$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#cmbempcategory').val('');
			$('#date').val(null);$('#hiddate').val('');$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		    $('#txtprojecttype').val('');$('#txtprojecttypeid').val('');$('#txtprojectidname').val('');$('#txtprojectid').val('');
		    document.getElementById("rdsummary").checked=true;document.getElementById("chckorderbydate").checked=true;document.getElementById("hidchckorderbydate").value = 1;
			document.getElementById("chckorderbyemployee").checked=false;document.getElementById("hidchckorderbyemployee").value = 0;document.getElementById("chckorderbycosttype").checked=false;
			document.getElementById("hidchckorderbycosttype").value = 0;document.getElementById("chckorderbycostid").checked=false;document.getElementById("hidchckorderbycostid").value = 0;
			$('#chckorderbydate').attr('disabled', true);reportTypeChange();
		    $("#timeSheetReviewGridID").jqxGrid('clear');$("#timeSheetReviewGridID").jqxGrid('addrow', null, {});
		    
		    if (document.getElementById("txtemployeeid").value == "") {
		        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
		        $('#txtemployeename').attr('placeholder', 'Employee Name');
		    }
		    
		    if (document.getElementById("txtprojecttype").value == "") {
		        $('#txtprojecttype').attr('placeholder', 'Press F3 to Search'); 
		    }
		    
		    if (document.getElementById("txtprojectidname").value == "") {
		        $('#txtprojectidname').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		 }
	
	function funreload(event){
		 //var branchval = document.getElementById("cmbbranch").value;
		 var year = $('#cmbyear').val();
		 var month = $('#cmbmonth').val();
		 var date = $('#date').val();
		 var category = $('#cmbempcategory').val();
		 var employee = $('#txtemployeedocno').val();
		 var projecttype = $('#txtprojecttypeid').val();
		 var projectid = $('#txtprojectid').val();
		 var orderbydate = $('#hidchckorderbydate').val();
		 var orderbyemployee = $('#hidchckorderbyemployee').val();
		 var orderbycosttype = $('#hidchckorderbycosttype').val();
		 var orderbycostid = $('#hidchckorderbycostid').val();
		 
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	 $("#timeSheetReviewDetailsDiv").load("timeSheetReviewGrid.jsp?rpttype=1&year="+year+'&month='+month+'&date='+date+'&category='+category+'&employee='+employee+'&projecttype='+projecttype+'&projectid='+projectid+'&orderbydate='+orderbydate+'&orderbyemployee='+orderbyemployee+'&orderbycosttype='+orderbycosttype+'&orderbycostid='+orderbycostid+'&check=1');
		 } else {
			 $("#timeSheetReviewDetailsDiv").load("timeSheetReviewGrid.jsp?rpttype=2&year="+year+'&month='+month+'&date='+date+'&category='+category+'&employee='+employee+'&projecttype='+projecttype+'&projectid='+projectid+'&orderbydate='+orderbydate+'&orderbyemployee='+orderbyemployee+'&orderbycosttype='+orderbycosttype+'&orderbycostid='+orderbycostid+'&check=1');
		 }
	}
	
	function saveGridData(date,empdocno,costtype,costcode,normalhrs,overtimehrs,holidayovertimehrs,rowno,intime,outtime,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if($('#mode').val()=='E') {
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				    });
				} else if($('#mode').val()=='D') {
					$.messager.alert('Message', '  Record Successfully Deleted ', function(r){
				    });
				}
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?date="+date+"&empdocno="+empdocno+"&costtype="+costtype+"&costcode="+costcode+"&normalhrs="+normalhrs+"&overtimehrs="+overtimehrs+"&holidayovertimehrs="+holidayovertimehrs+"&rowno="+rowno+"&mode="+mode+"&intime="+intime+"&outtime="+outtime,true);
	x.send();
	}
	
	function recheckGridData(year,month,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if($('#mode').val()=='A') {
					$.messager.alert('Message', '  Record Successfully Updated ', function(r){
				    });
				} 
				
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveDataReCheck.jsp?year="+year+"&month="+month+"&mode="+mode,true);
	x.send();
	}
	
	
	
	function funExportBtn(){
		JSONToCSVCon(data1, 'TimeSheetReview', true);
	} 
	
	function funRestrictDate(){
		  var date = $('#date').jqxDateTimeInput('val');
		  
		  if(date!=''){
			  if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
					 $.messager.alert('Message','Year and Month are Mandatory.','warning');
					 $("#date").jqxDateTimeInput('val', null);
		             return 0;
			  }
		  }
		  var day = date.split(".");
		  var restrictedDate = new Date(new Date($('#cmbyear').val(),(parseInt($('#cmbmonth').val())-1),day[0]));
		  $("#date").jqxDateTimeInput('val', restrictedDate);
	}
	
	function funChangeDate(){
		$("#date").jqxDateTimeInput('val', null);
	}
	
	function reportTypeChange(){
		if(document.getElementById("rdsummary").checked==true){
			$('#txtprojecttype').attr('disabled', true);
			$('#txtprojectidname').attr('disabled', true);
			$('#btnRecheck').attr('disabled', false);
			$('#btnConfirmed').attr('disabled', false);
			$('#btnUnConfirmed').attr('disabled', false);
			document.getElementById("chckorderbycosttype").checked=false;
			document.getElementById("hidchckorderbycosttype").value = 0;
			$('#chckorderbycosttype').attr('disabled', true);
			document.getElementById("chckorderbycostid").checked=false;
			document.getElementById("hidchckorderbycostid").value = 0;
			$('#chckorderbycostid').attr('disabled', true);
			$('#txtprojecttype').val('');$('#txtprojecttypeid').val('');$('#txtprojectidname').val('');$('#txtprojectid').val('');
			if (document.getElementById("txtprojecttype").value == "") {
		        $('#txtprojecttype').attr('placeholder', 'Press F3 to Search'); 
		    }
		    
		    if (document.getElementById("txtprojectidname").value == "") {
		        $('#txtprojectidname').attr('placeholder', 'Press F3 to Search'); 
		    }
		} else {
			$('#txtprojecttype').attr('disabled', false);
			$('#txtprojectidname').attr('disabled', false);
			$('#btnRecheck').attr('disabled', true);
			$('#btnConfirmed').attr('disabled', true);
			$('#btnUnConfirmed').attr('disabled', true);
			document.getElementById("chckorderbycosttype").checked=false;
			document.getElementById("hidchckorderbycosttype").value = 0;
			$('#chckorderbycosttype').attr('disabled', false);
			document.getElementById("chckorderbycostid").checked=false;
			document.getElementById("hidchckorderbycostid").value = 0;
			$('#chckorderbycostid').attr('disabled', false);
		}
	}
	
	function funReCheck(){
		if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.alert('Message','Year and Month are Mandatory.','warning');
            return 0;
	    }
		
		$.messager.confirm('Confirm', 'Do you want to Re-Check?', function(r){
				if (r){
					 $('#mode').val('A');
					 var year = $('#cmbyear').val();
					 var month = $('#cmbmonth').val();
	     		 	 var mode = $('#mode').val();
	     		 
	     		 	 $("#overlay, #PleaseWait").show();
	     		     recheckGridData(year,month,mode);	
				   }
			});
	}
	
	function funUnconfirm(){
		if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.alert('Message','Year and Month are Mandatory.','warning');
            return 0;
	    }
		
		$.messager.confirm('Confirm', 'Do you want to Un-Confirm?', function(r){
				if (r){
					 $('#mode').val('A');
					 var year = $('#cmbyear').val();
					 var month = $('#cmbmonth').val();
	     		 	 var mode = $('#mode').val();
	     		 
	     		 	 $("#overlay, #PleaseWait").show();
	     		 	 unConfirmData(year,month,mode);	
				   }
			});
	}
	
	function unConfirmData(year,month,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				if($('#mode').val()=='A') {
					if(items==0){
						$.messager.alert('Message', '  Record Successfully Unconfirmed ', function(r){});
					}else if(items==1){
						$.messager.alert('Message', '  Record Not Updated ', function(r){});
					}else if(items==2){
						$.messager.alert('Message', '  Record Not Updated, Payroll Processed Already ', function(r){});
					}
					
				} 
				
			  $('#mode').val('');
		      funreload(event); 
		  }
		}
			
	x.open("GET","unConfirmData.jsp?year="+year+"&month="+month+"&mode="+mode,true);
	x.send();
	}
	
	
	function funNotify(){
		
		var gridrows = $("#timeSheetReviewGridID").jqxGrid('getrows');
		if(parseInt($('#txtgridconfirmed').val())==gridrows.length){
		 	$.messager.alert('Message','Already Confirmed.','warning');
		 	return 0;
		 }
		
		if(parseInt($('#txtgridconfirm').val())!=0){
		 	$.messager.alert('Message','Time Sheet should be Entered for All Employees.','warning');
		 	return 0;
		 }
		
		$.messager.confirm('Confirm', 'Do you want to Confirm?', function(r){
	 		if (r){
	 				
	 			/* Summary Grid Confirming*/
  			 	var rows = $("#timeSheetReviewGridID").jqxGrid('getrows');
  			 	var length=0;
  					 for(var i=0 ; i < rows.length ; i++){
  						var chk=rows[i].empdocno;
  						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  							newTextBox = $(document.createElement("input"))
  						    .attr("type", "dil")
  						    .attr("id", "test"+length)
  						    .attr("name", "test"+length)
  							.attr("hidden", "true");
  							length=length+1;
  								
  					newTextBox.val(rows[i].empdocno+"::"+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "date")+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "hrs")+":: "+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "othrs")+":: "+$('#timeSheetReviewGridID').jqxGrid('getcelltext', i, "hothrs"));
  				    newTextBox.appendTo('form');
  				 }
  				}
  	 		 	$('#gridlength').val(length);
  			 	/* Summary Grid Confirming Ends*/
	 		
			 $('#mode').val('E');
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardTimeSheetReview").submit();
			 
	 		 }
	 		});
	}
	
	function setValues(){
		getYear();
		
		document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 $('#mode').val('');$('#gridlength').val('');
			 funreload(event);
		 }
	}
	function funExportBtn(){
		JSONToCSVCon(tsexceldata, 'Time Sheet Review', true);
		 }
	
</script>
</head>
<body onload="getBranch();setValues();getYear();getPayrollCategory();orderbycheck();">

<form id="frmDashboardTimeSheetReview"
      action="saveDashboardTimeSheetReview"
      method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
<div class="master-container">
<div class="sidebar-filters">

<!-- Heading -->
<div class="sidebar-fixed-top">
<div class="filter-card">
<jsp:include page="../../heading.jsp"></jsp:include>
</div>
</div>

<!-- Scrollable Content -->
<div class="sidebar-scroll-content">

<!-- Period Section -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Year</td>
<td>
<select id="cmbyear" name="cmbyear">
<option value="">--Select--</option>
</select>
<input type="hidden" id="hidcmbyear" name="hidcmbyear"
value='<s:property value="hidcmbyear"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Month</td>
<td>
<select id="cmbmonth" name="cmbmonth">
<option value="">--Select--</option>
<option value="01">January</option>
<option value="02">February</option>
<option value="03">March</option>
<option value="04">April</option>
<option value="05">May</option>
<option value="06">June</option>
<option value="07">July</option>
<option value="08">August</option>
<option value="09">September</option>
<option value="10">October</option>
<option value="11">November</option>
<option value="12">December</option>
</select>
<input type="hidden" id="hidcmbmonth" name="hidcmbmonth"
value='<s:property value="hidcmbmonth"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Date</td>
<td>
<div id="date"
onchange="funRestrictDate();"
value='<s:property value="date"/>'></div>
<input type="hidden" id="hiddate" name="hiddate"
value='<s:property value="hiddate"/>'/>
</td>
</tr>

</table>
</div>

<!-- Employee & Cost -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Category</td>
<td>
<select id="cmbempcategory"
name="cmbempcategory"></select>
</td>
</tr>

<tr>
<td class="label-cell">Employee</td>
<td>
<input type="text"
id="txtemployeeid"
name="txtemployeeid"
readonly
placeholder="Press F3 to Search"
onkeydown="getEmployeeId(event);"
value='<s:property value="txtemployeeid"/>'/>
<input type="hidden"
id="txtemployeedocno"
name="txtemployeedocno"
value='<s:property value="txtemployeedocno"/>'/>
</td>
</tr>

<tr>
<td></td>
<td>
<input type="text"
id="txtemployeename"
name="txtemployeename"
readonly
placeholder="Employee Name"
value='<s:property value="txtemployeename"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Cost Type</td>
<td>
<input type="text"
id="txtprojecttype"
name="txtprojecttype"
readonly
placeholder="Press F3 to Search"
onkeydown="getProjectType(event);"
value='<s:property value="txtprojecttype"/>'/>
<input type="hidden"
id="txtprojecttypeid"
name="txtprojecttypeid"
value='<s:property value="txtprojecttypeid"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Cost ID</td>
<td>
<input type="text"
id="txtprojectidname"
name="txtprojectidname"
readonly
placeholder="Press F3 to Search"
onkeydown="getProjectId(event);"
value='<s:property value="txtprojectidname"/>'/>
<input type="hidden"
id="txtprojectid"
name="txtprojectid"
value='<s:property value="txtprojectid"/>'/>
</td>
</tr>

</table>
</div>

<!-- Report Type -->
<div class="filter-card">
<div class="section-title">Report Type</div>
<div class="radio-row">
<label><input type="radio" name="rdo"
id="rdsummary"
onchange="reportTypeChange();"
value="rdsummary"> Summary</label>

<label><input type="radio" name="rdo"
id="rddetailed"
onchange="reportTypeChange();"
value="rddetailed"> Detail</label>
</div>
</div>

<!-- Order By -->
<div class="filter-card">
<div class="section-title">Order By</div>

<div class="checkbox-grid">
<label><input type="checkbox" id="chckorderbydate"
onchange="orderbycheck();"> Date</label>

<label><input type="checkbox" id="chckorderbyemployee"
onchange="orderbycheck();"> Employee</label>

<label><input type="checkbox" id="chckorderbycosttype"
onchange="orderbycheck();"> Cost Type</label>

<label><input type="checkbox" id="chckorderbycostid"
onchange="orderbycheck();"> Cost ID</label>
</div>

<input type="hidden" id="hidchckorderbydate" name="hidchckorderbydate"
value='<s:property value="hidchckorderbydate"/>'/>

<input type="hidden" id="hidchckorderbyemployee" name="hidchckorderbyemployee"
value='<s:property value="hidchckorderbyemployee"/>'/>

<input type="hidden" id="hidchckorderbycosttype" name="hidchckorderbycosttype"
value='<s:property value="hidchckorderbycosttype"/>'/>

<input type="hidden" id="hidchckorderbycostid" name="hidchckorderbycostid"
value='<s:property value="hidchckorderbycostid"/>'/>
</div>

<!-- Action Buttons -->
<div class="button-group">
<button type="button"
class="myButtons"
onclick="funClearInfo();">Clear</button>

<button type="button"
class="myButtonReCheck"
onclick="funReCheck();">Re-Check</button>

<button type="button"
class="myConfirmButton"
onclick="funNotify();">Confirm</button>

<button type="button"
class="myConfirmButton"
onclick="funUnconfirm();">Un-Confirm</button>
</div>

<!-- Hidden Fields -->
<input type="hidden" id="gridlength" name="gridlength"
value='<s:property value="gridlength"/>'/>

<input type="hidden" name="mode" id="mode"
value='<s:property value="mode"/>'/>

<input type="hidden" name="msg" id="msg"
value='<s:property value="msg"/>'/>

<input type="hidden" name="txtorgridclick" id="txtorgridclick"
value='<s:property value="txtorgridclick"/>'/>

<input type="hidden" name="txtgridconfirm" id="txtgridconfirm"
value='<s:property value="txtgridconfirm"/>'/>

<input type="hidden" name="txtgridconfirmed" id="txtgridconfirmed"
value='<s:property value="txtgridconfirmed"/>'/>

</div>
</div>
</div>
</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%">
<table width="100%">
<tr>
<td>
<div id="timeSheetReviewDetailsDiv">
<jsp:include page="timeSheetReviewGrid.jsp"></jsp:include>
</div>
</td>
</tr>
</table>
</td>

</tr>
</table>

</div>

<!-- Popups -->
<div id="employeeDetailsWindow"><div></div></div>
<div id="costTypeSearchGridWindow"><div></div></div>
<div id="costCodeSearchWindow"><div></div></div>

</div>
</form>
</body>