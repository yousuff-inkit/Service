0 
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
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
 
		 $('#customerDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#customerDetailsWindow').jqxWindow('close'); 
		 
		 $('#DetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#DetailsWindow').jqxWindow('close'); 
		 
  
	
		 $("#updatdata").attr('disabled', true );
	       $('#txtclient').dblclick(function(){
	 
		    	 
			  	  accountSearchContent('clientINgridsearch.jsp?');
		    		 
		  });
	       
	       
	       
	       
	       $('#jobno').dblclick(function(){
	    		 
		    	 
			  	   SearchContent('costunitsearch.jsp?');
		    		 
		  });
	       
	       
	   	  
	      
});

function getjobno(event){
	 var x= event.keyCode;
	 if(x==114){
	 
		 SearchContent('costunitsearch.jsp?');    }
	 else{
		 }
		 
	 }  
	 
function SearchContent(url) {
    //alert(url);
     $('#DetailsWindow').jqxWindow('open');
       $.get(url).done(function (data) {
//alert(data);
     $('#DetailsWindow').jqxWindow('setContent', data);

	}); 
 	}  	
	 
 
function getaccountdetails(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	 
 	 accountSearchContent('clientINgridsearch.jsp?');    }
 	 else{
 		 }
 		 
 	 }  
	  function accountSearchContent(url) {
       //alert(url);
        $('#customerDetailsWindow').jqxWindow('open');
          $.get(url).done(function (data) {
//alert(data);
        $('#customerDetailsWindow').jqxWindow('setContent', data);

	}); 
    	}  	

function funExportBtn(){
	
	 }

 
function funreload(event)
{
	 $("#updatdata").attr('disabled', true );
	
	 var barchval = document.getElementById("cmbbranch").value;
   	 var cldocno= document.getElementById("cldocno").value;
  	 var docnoss= document.getElementById("jobno").value;
   
	 var aa="yes";
	  
	   $("#overlay, #PleaseWait").show(); 
	   $("#prdgrid").jqxGrid('clear');
 	  $("#listdiv").load("listGrid.jsp?barchval="+barchval+"&aa="+aa+"&cldocno="+cldocno+"&docnoss="+docnoss);
 
 	 
	}
	
 
  
  function funCalculates()
  {
	  
		  
  }
  
  
  
  
	function hidebranch() 
	{
	 
		  
		 
	}

	function fundisable(){
		

		
		 
		 }
	

	function funClearData(){
		
		 document.getElementById("txtclient").value="";
		 document.getElementById("txtclientdet").value="";
		 document.getElementById("jobno").value="";
		 document.getElementById("cldocno").value="";
		 document.getElementById("costtr_no").value="";
		 
		     
		 
		 }
	
	
	function funupdates()
	{
		
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		 	  
		     
		   	if(r==false)
		   	  {
		   		
		   	  }
		   	else
		   		{
		
		var listss = new Array();
		var selectedrows=$("#prdgrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
			  for(var i=0 ; i < selectedrows.length ; i++){
				 listss.push($("#prdgrid").jqxGrid('getcellvalue',selectedrows[i],'rowno')+"::"+$("#prdgrid").jqxGrid('getcellvalue',selectedrows[i],'issueqty')+"::"+$("#prdgrid").jqxGrid('getcellvalue',selectedrows[i],'psrno')); 
					  }
			   save(listss);
	            }
		    });
		
		  }
		  function save(listss){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200) 
						{
						 var items= x.responseText;
						 	var itemval=items.trim();
						 
		      if(parseInt(itemval)==1)
		      	{
						 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
							     
						     });
						    
						 	funreload(event);
				 
						}
					else
						{
						$.messager.alert('Message', '  Not Updated ', function(r){
						     
					     });
						}  
				}
				}  
			x.open("GET","savedata.jsp?list="+listss+"&masterdocno="+document.getElementById("masterdocno").value);
				x.send();
			}

		 
	
	
	 </script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

<!-- ===== Fixed Heading ===== -->
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
                <td class="label-cell">Job No</td>
                <td>
                    <input type="text"
                           id="jobno"
                           name="jobno"
                           class="filter-input"
                           value='<s:property value="jobno"/>'
                           readonly
                           placeholder="Press F3 To Search"
                           onkeydown="getjobno(event);">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Client</td>
                <td>
                    <input type="text"
                           id="txtclient"
                           name="txtclient"
                           class="filter-input"
                           value='<s:property value="txtclient"/>'
                           readonly
                           placeholder="Press F3 To Search"
                           onkeydown="getaccountdetails(event);">
                </td>
            </tr>

            <tr>
                <td></td>
                <td>
                    <input type="text"
                           id="txtclientdet"
                           name="txtclientdet"
                           class="filter-input"
                           value='<s:property value="txtclientdet"/>'
                           readonly>
                </td>
            </tr>

        </table>
    </div>

    <!-- ===== Button Section ===== -->
    <div class="button-group">

        <button type="button"
                class="btn-submit"
                onclick="funClearData();">
            Clear
        </button>

        <button type="button"
                class="btn-submit"
                onclick="funupdates();">
            Approve
        </button>

    </div>

    <!-- Hidden Fields -->
    <input type="hidden" id="costtr_no" name="costtr_no"
           value='<s:property value="costtr_no"/>'>

    <input type="hidden" id="cldocno" name="cldocno"
           value='<s:property value="cldocno"/>'>

    <input type="hidden" id="masterdocno" name="masterdocno"
           value='<s:property value="masterdocno"/>'>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT SIDE ================= -->
<td width="80%" valign="top">

<div class="grid-container">

    <div class="filter-card">
        <div id="listdiv">
            <jsp:include page="listGrid.jsp"></jsp:include>
        </div>
    </div>

    <div class="filter-card">
        <div id="sublistdiv">
            <jsp:include page="sublistGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</td>

</tr>
</table>

<!-- ================= POPUPS ================= -->
<div id="customerDetailsWindow"><div></div></div>
<div id="DetailsWindow"><div></div></div>

</div>
</div>
</body>
</html>