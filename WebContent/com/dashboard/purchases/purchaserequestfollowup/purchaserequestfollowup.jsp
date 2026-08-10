 
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
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	       $('#Searchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		   $('#Searchwindow').jqxWindow('close');
 
		   $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	/*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	 
	  */
	 
			 
		   $('#docnosss').dblclick(function(){
		    
		    	
		    		
			  	    $('#Searchwindow').jqxWindow('open');
			  	
			  	  SearchContent('mainsearch.jsp?');
		    		 
		  });  
	  
});
 
 
 
function  funcleardata()
{
	document.getElementById("reqdocno").value="";
	document.getElementById("docnosss").value="";
    $('#docnosss').attr('placeholder', 'Press F3 TO Search'); 
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
	JSONToCSVCon(datasex,'Purchase Request Followup Mater', true);
	JSONToCSVCon(datas11ex,'Purchase Request Followup Details', true);
	 }

 
 
function funreload(event)
{
	disitems(0);
	/*   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   { */
	 var barchval = document.getElementById("cmbbranch").value;
		   
		   	   
		   
/*      var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val(); */
	 
	 var fromdate="";
	 var todate="";
	 
	 var statusselect="";
	 
	 var reqdocno=$("#reqdocno").val();
	  $("#ordersubgrid").jqxGrid('clear');
	  $("#duedetailsgrid").jqxGrid('clear');
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("mainGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&statusselect="+statusselect+"&reqdocno="+reqdocno);
	
		  /*  } */
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
 
 
function funupdate()
{
	var docno = document.getElementById("masterdocno").value;
	  
	 var branchids = document.getElementById("brhid").value;
	 var remarks = document.getElementById("remarks").value;
	 var cmbinfo = document.getElementById("cmbinfo").value;
      
	 var folldate =$('#date').val();
 
	 
	 
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			if(parseInt(items)>0)
				 {
				 
				  $.messager.alert('Message', ' Successfully Updated');
				  funreload(event);
				
				  
				  disitems(0);
				  
				 }
			 else
				 {
				 $.messager.alert('Message', ' Not Updated '); 
				 }
			 
			  
			
			 
			
			}
	}
		
x.open("GET","savedata.jsp?docno="+docno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate,true);

x.send();
		
}

function disitems(val)
{
	
	 
			if(val=="1")
				{
				
				 $('#cmbinfo').attr("disabled",false);
				 
				 $('#remarks').attr("disabled",false);
				 $('#remarks').attr("readonly",false);
				 $('#Update').attr("disabled",false);
			   
				 document.getElementById("remarks").value="";
	 
				 
				 $('#date').val(new Date());
				 $('#date').jqxDateTimeInput({ disabled: false});
				 
				}
		 
			
			else
			{
	 
				 $('#cmbinfo').attr("disabled",true);
				 
				 $('#remarks').attr("disabled",true);
				 $('#remarks').attr("readonly",true);
				 $('#Update').attr("disabled",true);
			   
				 document.getElementById("remarks").value="";
 
				 
				 $('#date').val(new Date());
				 $('#date').jqxDateTimeInput({ disabled: true});
				 
			
			}
		
			
	
}
 

</script>
</head>
<body onload="getBranch();getinfo();disitems(0);">

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

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <!-- Document Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Doc No</td>
                            <td>
                                <input type="text"
                                       id="docnosss"
                                       name="docnosss"
                                       readonly
                                       placeholder="Press F3 To Search"
                                       onkeydown="getdetails(event);"
                                       value='<s:property value="docnosss"/>'/>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Clear Button -->
                <button class="btn-submit"
                        type="button"
                        onclick="funcleardata();">
                    Clear
                </button>

                <!-- Process Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Process</td>
                            <td>
                                <select id="cmbinfo"
                                        name="cmbinfo">
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Date</td>
                            <td>
                                <div id="date"
                                     value='<s:property value="date"/>'>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td>
                                <input type="text"
                                       id="remarks"
                                       name="remarks"
                                       value='<s:property value="remarks"/>'/>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Update Button -->
                <button class="btn-submit"
                        type="button"
                        onclick="funupdate();">
                    Update
                </button>

                <!-- Hidden Fields -->
                <input type="hidden" id="acno" name="acno"
                       value='<s:property value="acno"/>'/>
                <input type="hidden" id="brhid" name="brhid"
                       value='<s:property value="brhid"/>'/>
                <input type="hidden" id="reftype" name="reftype"
                       value='<s:property value="reftype"/>'/>
                <input type="hidden" id="reqdocno" name="reqdocno"
                       value='<s:property value="reqdocno"/>'/>

            </div>
        </div>
    </div>
</td>


<!-- ================= RIGHT GRID AREA ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="listdiv">
                    <jsp:include page="mainGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>

        <tr>
            <td>
                <div id="listdiv1">
                    <jsp:include page="subGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>

        <tr>
            <td>
                <div id="detaildiv">
                    <jsp:include page="detailgrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

<!-- Global Hidden -->
<input type="hidden"
       id="masterdocno"
       name="masterdocno"
       value='<s:property value="masterdocno"/>'>

</div>

<!-- Popups -->
<div id="locationwindow"><div></div></div>
<div id="Searchwindow"><div></div></div>

</div>
</body>
</html>