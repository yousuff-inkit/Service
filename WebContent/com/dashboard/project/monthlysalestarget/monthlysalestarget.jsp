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
<style>
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">
$(document).ready(function () {
	  document.getElementById('rsumm').checked=true;
	  document.getElementById('differentiater').value=1;            
	  $('#msrbrhDiv1').show();
	  $('#msrsmDiv2').hide();
	  $('#bhhider').show();
	  $('#smhider').hide();
	$('#branchlabel').hide();  
	$('#branchdiv').hide(); 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
   $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
   getYear();
}); 
function funreload(event){    
	 if(document.getElementById('rsumm').checked) {
		 $("#msrbrhDiv").load("msrBranchGrid.jsp?check="+1);  
		}
   else if(document.getElementById('rdet').checked) {    
	 $("#msrsmDiv").load("msrSalesmanGrid.jsp?check="+1);          
  }   
}        

 function setValues(){
		 if($('#msg').val()!=""){   
			 
 		  $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
 		  }
	}
 function funExportBtn(){
	 if(document.getElementById('rsumm').checked) {
		 $("#msrbrhDiv").excelexportjs({
			 containerid: "msrbrhDiv", 
			 datatype: 'json', 
			 dataset: null, 
			 gridId: "jqxmqrSubGrid", 
			 columns: getColumns("jqxmqrSubGrid") , 
			 worksheetName:"Monthly Sales Target - Branch"
			 });
		}
   else if(document.getElementById('rdet').checked) {    
	 $("#msrsmDiv").excelexportjs({
		 containerid: "msrsmDiv", 
		 datatype: 'json', 
		 dataset: null, 
		 gridId: "jqxmqrsalesmanGrid", 
		 columns: getColumns("jqxmqrsalesmanGrid") , 
		 worksheetName:"Monthly Sales Target - Salesman"
		 });
  }   
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
				if ($('#hidcmbyear').val() != null) {
					$('#cmbyear').val($('#hidcmbyear').val());
				}
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
  function getBranchs() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';  
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}  
				$("select#cmbbranchs").html(optionsbranch);
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","getBranch.jsp", true);   
		x.send();
	}
  function funSave(){
       var salid=$('#cmbsalesman').val();   
  	 var year=$('#cmbyear').val();     
  	 var month=$('#cmbmonth').val();
  	 var targetval=$('#targetval').val();
  	 var branch=$('#cmbbranchs').val();  
  	 var rowno=$('#rowno').val();
  	 var differentiater=document.getElementById('differentiater').value;
  	 var percentval=$('#percentval').val();
  	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else {
		     		 $("#overlay, #PleaseWait").show();
		     		 funSaveData(rowno,year,month,targetval,branch,differentiater,salid,percentval);	   
		     	}
		 });
  }
  function funSaveData(rowno,year,month,targetval,branch,differentiater,salid,percentval){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText;     
		   if(parseInt(items)>=1)
			{
			   $.messager.alert('Message', ' Successfully Saved', function(r){
				});  
			     $('#cmbyear').val('');     
		    	 $('#cmbmonth').val('');   
		    	 $('#targetval').val('');
		    	 $('#cmbbranch').val('');
		    	 $('#rowno').val('');
		    	 $('#jqxmqrSubGrid').jqxGrid('clear');
		    	 $('#jqxmqrsalesmanGrid').jqxGrid('clear'); 
			   funreload();      
			} 
			else
			{
				$.messager.alert('Message', ' Not Saved', function(r){                   
				});
			}
		}                
		}      
		x.open("GET","saveData.jsp?rowno="+rowno+"&year="+year+"&salid="+salid+"&month="+month+"&targetval="+targetval+"&branch="+branch+"&differentiater="+differentiater+"&percentval="+percentval,true);                                               
		x.send();
	}
  function funClearData(){
 	 $('#cmbyear').val('');     
	 $('#cmbmonth').val('');
	 $('#targetval').val('');
	 $('#cmbbranch').val('');
	 $('#rowno').val('');
	 $('#percentval').val('');
	 $('#jqxmqrSubGrid').jqxGrid('clear'); 
	 $('#jqxmqrsalesmanGrid').jqxGrid('clear'); 
  }
function fundisable(){  
		if(document.getElementById('rsumm').checked) {
			document.getElementById('differentiater').value=1;
				   $('#msrbrhDiv1').show();
				   $('#msrsmDiv2').hide();
				   $('#bhhider').show();
				   $('#smhider').hide();
				}
		 else if(document.getElementById('rdet').checked) {
			 document.getElementById('differentiater').value=2;        
			      $('#msrsmDiv2').show();   
				  $('#msrbrhDiv1').hide(); 
				  $('#bhhider').hide();                   
				  $('#smhider').show();
		  }
}
function getsalesman() {
var x = new XMLHttpRequest();
x.onreadystatechange = function() {
	if (x.readyState == 4 && x.status == 200) {
		var items = x.responseText;
	//alert(items);
		items = items.split('####');
		
		var branchIdItems  = items[0].split(",");
		var branchItems = items[1].split(",");
		var optionsbranch = '<option value="">--Select--</option>';  
		for (var i = 0; i < branchItems.length; i++) {
			optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
					+ branchItems[i] + '</option>';
		}  
		$("select#cmbsalesman").html(optionsbranch);
	} else {
		//alert("Error");
	}  
}
x.open("GET","getsalesman.jsp", true);   
x.send();
}
	</script>
</head>
<body onload="getBranchs();setValues();getsalesman();">

<form id="frmFAList" action="frmFAList" method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

<!-- ===== Fixed Header ===== -->
<div class="sidebar-fixed-top">
    <div class="filter-card">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>
</div>

<!-- ===== Scrollable Filters ===== -->
<div class="sidebar-scroll-content">

    <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td colspan="2" align="center">
                    <input type="radio" id="rsumm" name="stkled"
                           value="rsumm" onchange="fundisable();">
                    <label for="rsumm" class="branch">Branch</label>

                    &nbsp;&nbsp;

                    <input type="radio" id="rdet" name="stkled"
                           value="rdet" onchange="fundisable();">
                    <label for="rdet" class="branch">Salesman</label>
                </td>
            </tr>

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

            <tr id="bhhider">
                <td class="label-cell">Branch</td>
                <td>
                    <select id="cmbbranchs" name="cmbbranchs">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr id="smhider">
                <td class="label-cell">Salesman</td>
                <td>
                    <select id="cmbsalesman" name="cmbsalesman">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Target Value</td>
                <td>
                    <input type="text" id="targetval" name="targetval"
                           style="text-align:right;"
                           value='<s:property value="targetval"/>'/>
                </td>
            </tr>

            <tr>
                <td class="label-cell">GP%</td>
                <td>
                    <input type="text" id="percentval" name="percentval"
                           style="text-align:right;"
                           value='<s:property value="percentval"/>'/>
                </td>
            </tr>

        </table>
    </div>

    <!-- ===== Buttons ===== -->
    <div class="button-group">
        <button type="button"
                class="btn-submit"
                onclick="funClearData();">
            Clear
        </button>

        <button type="button"
                class="btn-submit"
                onclick="funSave();">
            Save
        </button>
    </div>

    <!-- Hidden Fields -->
    <input type="hidden" id="rowno" name="rowno"
           value='<s:property value="rowno"/>'/>
    <input type="hidden" id="differentiater" name="differentiater"
           value='<s:property value="differentiater"/>'/>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT SIDE ================= -->
<td width="80%" valign="top">

<table width="100%">
    <tr id="msrbrhDiv1">
        <td>
            <div id="msrbrhDiv">
                <jsp:include page="msrBranchGrid.jsp"></jsp:include>
            </div>
        </td>
    </tr>

    <tr id="msrsmDiv2">
        <td>
            <div id="msrsmDiv">
                <jsp:include page="msrSalesmanGrid.jsp"></jsp:include>
            </div>
        </td>
    </tr>
</table>

</td>

</tr>
</table>

</div>

<div id="assetwindow">
    <div></div>
</div>

</div>
</form>
</body>
</html>