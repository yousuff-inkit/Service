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
		 $("#branchlabel").hide();$("#branchdiv").hide();
		 $('#btnSubmit').attr('disabled', true);$('#btnCalculate').attr('disabled', true);
		 
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true, value: null});
		
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
  		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost ID Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
  		 
		 $('#schserchinfowindow').jqxWindow({ width: '90%', height: '60%',  maxHeight: '70%' ,maxWidth: '95%' ,title: 'Time-Sheet Fill' , position: { x: 70, y: 100 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#schserchinfowindow').jqxWindow('close');
			
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 9999; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 9999;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
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
	
	function schSearchContent(url) {
	    $('#schserchinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#schserchinfowindow').jqxWindow('setContent', data);
		$('#schserchinfowindow').jqxWindow('bringToFront');
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
	
	 function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
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

	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');
		$('#date').val(null);$('#hiddate').val('');$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');$('#txtemployeecostperhour').val('');
	    $('#txtprojecttype').val('');$('#txtprojecttypeid').val('');$('#txtprojectidname').val('');$('#txtprojectid').val('');$('#txtfillbtnclick').val('0');
	    
	    $("#timeSheetDetailsGridID").jqxGrid('clear');$("#timeSheetDetailsGridID").jqxGrid('addrow', null, {});
	    
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
	
	function funFillGrid(){
		if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='') {
			 $.messager.alert('Message','Year and Month are Mandatory.','warning');
          return 0;
		 }
		 $('#txtfillbtnclick').val('1');
		 schSearchContent('timeSheetFillSearch.jsp');
	}
	
	function funreload(event){
		 
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		 $("#overlay, #PleaseWait").show();
		 
		 $("#timeSheetDetailsGridID").jqxGrid('clear');
		 $("#timeSheetDetailsGridID").jqxGrid('addrow', null, {"date": ""+$('#date').jqxDateTimeInput('val')+"","empid": ""+$('#txtemployeeid').val()+"","empname": ""+$('#txtemployeename').val()+"","costtype": ""+$('#txtprojecttypeid').val()+"","costgroup": ""+$('#txtprojecttype').val()+"","costcodename": ""+$('#txtprojectidname').val()+"","costcode": ""+$('#txtprojectid').val()+"","hrs": "","empdocno": ""+$('#txtemployeedocno').val(),"costperhour": ""+$('#txtemployeecostperhour').val()+""});
		 
		 $("#overlay, #PleaseWait").hide();
	}
	
	function funNotify(){	
		
		if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Year is Mandatory.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Month is Mandatory.','warning');
			 return 0;
		 } 
		
		   var rows = $('#timeSheetDetailsGridID').jqxGrid('getrows');
	       var rowlength= rows.length;
		   if(rowlength==0 || (rowlength==1 && ((rows[0].hrs=="" && rows[0].othrs=="" && rows[0].hothrs=="") || (typeof(rows[0].hrs) == "undefined" && typeof(rows[0].othrs) == "undefined" && typeof(rows[0].hothrs) == "undefined")))){
				$.messager.alert('Message','Enter Details & Save Again. ','warning');
				return 0;
		   } 
		  
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 				
	 			/* Time Sheet Grid  Saving*/
			 	var rows = $("#timeSheetDetailsGridID").jqxGrid('getrows');
			 	var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						 
						if(i!=(rows.length-1)){
							var chkhrs=rows[i].hrs;var chkothrs=rows[i].othrs;var chkhothrs=rows[i].hothrs;
							if(typeof(chkhrs) == "undefined" || typeof(chkhrs) == "NaN" || chkhrs == "" || chkhrs == null){
								if(typeof(chkothrs) == "undefined" || typeof(chkothrs) == "NaN" || chkothrs == "" || chkothrs == null){
									if(typeof(chkhothrs) == "undefined" || typeof(chkhothrs) == "NaN" || chkhothrs == "" || chkhothrs == null){
									 $.messager.alert('Message','Please Enter Hour Details for '+rows[i].empid+' - '+rows[i].empname,'warning');
									 return 0;
									}
								}
							}
						} else if(i==(rows.length-1)){
							var chkhrs=rows[i].hrs;var chkothrs=rows[i].othrs;var chkhothrs=rows[i].hothrs;var chkdate=rows[i].date;var chkempid=rows[i].empdocno;
							if(typeof(chkhrs) == "undefined" || typeof(chkhrs) == "NaN" || chkhrs == "" || chkhrs == null){
								if(typeof(chkothrs) == "undefined" || typeof(chkothrs) == "NaN" || chkothrs == "" || chkothrs == null){
									if(typeof(chkhothrs) == "undefined" || typeof(chkhothrs) == "NaN" || chkhothrs == "" || chkhothrs == null){
										if(typeof(chkdate) == "undefined" || typeof(chkdate) == "NaN" || chkdate == "" || chkdate == null){
											if(typeof(chkempid) == "undefined" || typeof(chkempid) == "NaN" || chkempid == "" || chkempid == null){
												    var rowid = $("#timeSheetDetailsGridID").jqxGrid('getrowid', (rows.length-1));
									                $("#timeSheetDetailsGridID").jqxGrid('deleterow', rowid);
											}
										}
									}
								}
							}
						}
							
						if((typeof(chkhrs) != "undefined" && typeof(chkhrs) != "NaN" && chkhrs != "" && chkhrs != null) || (typeof(chkothrs) != "undefined" && typeof(chkothrs) != "NaN" && chkothrs != "" && chkothrs != null) || (typeof(chkhothrs) != "undefined" && typeof(chkhothrs) != "NaN" && chkhothrs != "" && chkhothrs != null)){
						
							var chkdate=rows[i].date;
							if(typeof(chkdate) == "undefined" || typeof(chkdate) == "NaN" || chkdate == "" || chkdate == null){
								 $.messager.alert('Message','Date is Mandatory for '+rows[i].empid+' - '+rows[i].empname,'warning');
								 return 0;
							} 
							if(typeof(chkdate) != "undefined" && typeof(chkdate) != "NaN" && chkdate != "" && chkdate != null) {
								
								var chkempid=rows[i].empdocno;
								if(typeof(chkempid) == "undefined" || typeof(chkempid) == "NaN" || chkempid == "" || chkempid == null){
									 $.messager.alert('Message','Employee is Mandatory for the Detail Dated '+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "date"),'warning');
									 return 0;
								} 
								if(typeof(chkempid) != "undefined" && typeof(chkempid) != "NaN" && chkempid != "" && chkempid != null) {
									
									var chkcosttype=rows[i].costtype;
									if(typeof(chkcosttype) == "undefined" || typeof(chkcosttype) == "NaN" || chkcosttype == "" || chkcosttype == null){
										$.messager.alert('Message','Costtype is Mandatory for '+rows[i].empid+' - '+rows[i].empname,'warning');
										 return 0;
									} 
									if(typeof(chkcosttype) != "undefined" && typeof(chkcosttype) != "NaN" && chkcosttype != "" && chkcosttype != null) {
										
										var chkcostcode=rows[i].costcode;
										if(typeof(chkcostcode) == "undefined" || typeof(chkcostcode) == "NaN" || chkcostcode == "" || chkcostcode == null){
											$.messager.alert('Message','Cost Id is Mandatory for '+rows[i].empid+' - '+rows[i].empname,'warning');
											 return 0;
										} 
										if(typeof(chkcostcode) != "undefined" && typeof(chkcostcode) != "NaN" && chkcostcode != "" && chkcostcode != null) {
											
											newTextBox = $(document.createElement("input"))
										    .attr("type", "dil")
										    .attr("id", "test"+length)
										    .attr("name", "test"+length)
											.attr("hidden", "true");
											length=length+1;
											
								       		newTextBox.val(rows[i].empdocno+"::"+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "date")+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "hrs")+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "othrs")+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "hothrs")+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "intime")+":: "+$('#timeSheetDetailsGridID').jqxGrid('getcelltext', i, "outtime")+":: "+rows[i].costperhour);
								       		newTextBox.appendTo('form');
								       }
							       }
						       }
					       }
				      }
				}
	 		 	$('#gridlength').val(length);
			 	/* Time Sheet Grid  Saving Ends*/
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardTimeSheet").submit();
			 
	 		 }
	 		});
		 
		return 1;
	}
	
	function setValues(){
		getYear();
		
		document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 $('#gridlength').val('');
		 }
	}
	
	function funExportBtn(){
		JSONToCSVCon(data1, 'TimeSheet', true);
	} 
	
</script>
</head>
<body onload="getBranch();setValues();getYear();">

<form id="frmDashboardTimeSheet"
      action="saveDashboardTimeSheet"
      method="post">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Fixed Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Filters -->
            <div class="sidebar-scroll-content">

                <!-- Year & Month -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Year</td>
                            <td>
                                <select id="cmbyear"
                                        name="cmbyear"
                                        onchange="funChangeDate();">
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden"
                                       id="hidcmbyear"
                                       name="hidcmbyear"
                                       value='<s:property value="hidcmbyear"/>'/>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Month</td>
                            <td>
                                <select id="cmbmonth"
                                        name="cmbmonth"
                                        onchange="funChangeDate();">
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
                                <input type="hidden"
                                       id="hidcmbmonth"
                                       name="hidcmbmonth"
                                       value='<s:property value="hidcmbmonth"/>'/>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Date -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Date</td>
                            <td>
                                <div id="date"
                                     onchange="funRestrictDate();"
                                     value='<s:property value="date"/>'></div>
                                <input type="hidden"
                                       id="hiddate"
                                       name="hiddate"
                                       value='<s:property value="hiddate"/>'/>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Cost & Employee Section -->
                <div class="filter-card">
                    <table class="filter-table">

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
                                <input type="hidden"
                                       id="txtemployeecostperhour"
                                       name="txtemployeecostperhour"
                                       value='<s:property value="txtemployeecostperhour"/>'/>
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

                    </table>
                </div>

                <!-- Buttons -->
                <div style="text-align:center;">
                    <button type="button"
                            class="myButtons"
                            onclick="funClearInfo();">Clear</button>

                    <button type="button"
                            class="myButton"
                            onclick="funFillGrid();">Fill</button>

                    <button type="button"
                            class="mySaveButton"
                            onclick="funNotify();">Save</button>
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

                <input type="hidden" name="txtfillbtnclick" id="txtfillbtnclick"
                       value='<s:property value="txtfillbtnclick"/>'/>

            </div>
        </div>
    </div>
</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="timeSheetDetailsDiv">
                    <jsp:include page="timeSheetGrid.jsp"></jsp:include>
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
<div id="schserchinfowindow"><div></div></div>

</div>
</form>
</body>