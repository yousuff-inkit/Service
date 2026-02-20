
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
	
	$('#orderlist').show();
	 $('#orderlistdetails').hide();
	 document.getElementById('rsumm').checked=true;
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
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
	 
	 
     $('#acno').dblclick(function(){
 	 
  		  
		  $('#accountDetailsWindow').jqxWindow('open');
		 commenSearchContent('accountsDetailsSearch.jsp?');
 		    
 		   
	  }); 
	  
});
function  getacc(event){
	 var x= event.keyCode;
	 if(x==114){
	
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 commenSearchContent('accountsDetailsSearch.jsp?');
	 }
	 }   
	 
function funExportBtn(){
	  
	   if(document.getElementById('rsumm').checked) {
	  
	JSONToCSVCon(rdatasex, 'Ni Purchase Order Reports', true);
	   }
	   else if (document.getElementById('rdet').checked) {
		   JSONToCSVCon(rdatasdetailsex, 'Ni Purchase Order Details Reports', true);
	   }
	 }
function commenSearchContent(url) {
	 
		 $.get(url).done(function (data) {
			 
			 $('#accountDetailsWindow').jqxWindow('open');
		$('#accountDetailsWindow').jqxWindow('setContent', data);

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
		   
		   var fromdocno=$("#fromdocno").val();
		   var todocno=$("#todocno").val();   
		   var fromamount=$("#fromamount").val();  
		   var toamount=$("#toamount").val(); 
		   
		   if(fromdocno!="")
			   {
			   if(todocno=="")
				   {
				   
				   $.messager.alert('Message','Enter To Doc No ','warning');   
					 
				   return false;
				   
				   }
			   else if(parseInt(todocno)<parseInt(fromdocno))
				   {
				   
				   $.messager.alert('Message','To Doc No Less Than From Doc No','warning');   
					 
				   return false;
				   
				   }
			   
			   
			   
			   }
		   
		   if(fromamount!="")
		   {
		   if(toamount=="")
			   {
			   
			   $.messager.alert('Message','Enter To Amount ','warning');   
				 
			   return false;
			   
			   }
		   
		   else if(parseFloat(toamount)<parseFloat(fromamount))
		   {
		   
		   $.messager.alert('Message','To Amount Less Than From Amount  ','warning');   
			 
		   return false;
		   
		   }
		   
		   }
	   
		   

		   
		   
		   
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 
     var type=$("#statusselect").val();	
     
     
 // alert(type);
	 var accdocno=$("#accdocno").val(); 
	   $("#overlay, #PleaseWait").show();
	   if(document.getElementById('rsumm').checked) {
	  $("#listdiv").load("puchaseorderreportGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&fromdocno="
			  +fromdocno+"&todocno="+todocno+"&fromamount="+fromamount+"&toamount="+toamount+"&accdocno="+accdocno+"&type="+type);
	   }
	   else if (document.getElementById('rdet').checked) {
		   $("#listdetdiv").load("puchaseorderreportdetailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&fromdocno="
			  +fromdocno+"&todocno="+todocno+"&fromamount="+fromamount+"&toamount="+toamount+"&accdocno="+accdocno+"&type="+type);
	   }
		   }
	}
	
	
	
function funClearInfo()
{
	 
	 
	 
	  $("#fromdocno").val('');
	  $("#todocno").val('');   
	 $("#fromamount").val('');  
	 $("#toamount").val(''); 
	  $("#accdocno").val(''); 
	  
	 $("#acno").val(''); 
	 $("#accname").val(''); 
	 
	 
	  $("#fromdocno").attr('placeholder', 'From');
	  $("#todocno").attr('placeholder', 'To');
	  $("#fromamount").attr('placeholder', 'From');
	  $("#toamount").attr('placeholder', 'To');
	  
	  
	/*   $(this).attr('placeholder', '');
	  $(this).attr('placeholder', '');
	  $(this).attr('placeholder', ''); */
	  
	 
	 
}
	   
	
	
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	  // document.getElementById("errormsg").innerText=" Enter Numbers Only";  
 	   $.messager.alert('Message',' Enter Numbers Only  ','warning');   
        return false;
    	}
   // document.getElementById("errormsg").innerText="";  
    return true;
}

function fundisable(){
	

	
	if (document.getElementById('rsumm').checked) {
		
		 $('#orderlist').show(); 
		   $('#orderlistdetails').hide();
		  
		}
	 else if (document.getElementById('rdet').checked) {
		 
		  $('#orderlist').hide(); 
		  $('#orderlistdetails').show();
		 
		}
	 }
</script>
</head>
<body onload="getBranch();">

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

                <!-- Date Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">From</td>
                            <td>
                                <div id="fromdate"
                                     value='<s:property value="fromdate"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">To</td>
                            <td>
                                <div id="todate"
                                     value='<s:property value="todate"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <input type="radio"
                                       id="rsumm"
                                       name="stkled"
                                       value="rsumm"
                                       onchange="fundisable();">
                                <label for="rsumm">Summary</label>

                                &nbsp;&nbsp;

                                <input type="radio"
                                       id="rdet"
                                       name="stkled"
                                       value="rdet"
                                       onchange="fundisable();">
                                <label for="rdet">Detail</label>
                            </td>
                        </tr>

                    </table>
                </div>


                <!-- Range Filters -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Doc No</td>
                            <td>
                                <div style="display:flex; gap:6px;">
                                    <input type="text"
                                           id="fromdocno"
                                           name="fromdocno"
                                           placeholder="From"
                                           onkeypress="return isNumber(event);"
                                           value='<s:property value="fromdocno"/>'/>

                                    <input type="text"
                                           id="todocno"
                                           name="todocno"
                                           placeholder="To"
                                           onkeypress="return isNumber(event);"
                                           value='<s:property value="todocno"/>'/>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Amount</td>
                            <td>
                                <div style="display:flex; gap:6px;">
                                    <input type="text"
                                           id="fromamount"
                                           name="fromamount"
                                           placeholder="From"
                                           style="text-align:right;"
                                           onblur="funRoundAmt(this.value,this.id);"
                                           onkeypress="return isNumber(event);"
                                           value='<s:property value="fromamount"/>'/>

                                    <input type="text"
                                           id="toamount"
                                           name="toamount"
                                           placeholder="To"
                                           style="text-align:right;"
                                           onblur="funRoundAmt(this.value,this.id);"
                                           onkeypress="return isNumber(event);"
                                           value='<s:property value="toamount"/>'/>
                                </div>
                            </td>
                        </tr>

                    </table>
                </div>


                <!-- Vendor Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Vendor</td>
                            <td>
                                <input type="text"
                                       id="acno"
                                       name="acno"
                                       placeholder="Press F3 To search"
                                       readonly
                                       onkeydown="getacc(event);"
                                       value='<s:property value="acno"/>'/>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>
                                <input type="text"
                                       id="accname"
                                       name="accname"
                                       readonly
                                       value='<s:property value="accname"/>'/>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="statusselect" name="statusselect">
                                    <option value="All">All</option>
                                    <option value="PED">Pending</option>
                                    <option value="INV">Invoiced</option>
                                </select>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Clear Button -->
                <button class="btn-submit"
                        type="button"
                        onclick="funClearInfo();">
                    Clear
                </button>

                <!-- Hidden Field -->
                <input type="hidden"
                       id="accdocno"
                       name="accdocno"
                       value='<s:property value="accdocno"/>'/>

            </div>
        </div>
    </div>
</td>


<!-- ================= RIGHT GRID ================= -->
<td width="80%">
    <table width="100%">

        <tr>
            <td>
                <div id="listdiv">
                    <jsp:include page="puchaseorderreportGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>

        <tr>
            <td>
                <div id="listdetdiv">
                    <jsp:include page="puchaseorderreportdetailsGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>

    </table>
</td>

</tr>
</table>

</div>

<!-- Popup -->
<div id="accountDetailsWindow">
    <div></div> 
</div>

</div>
</body>
</html>