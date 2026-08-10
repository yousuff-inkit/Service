
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
    height: 28px !important;  
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
	
	/* $('#loadsalikdata').hide();
	  $('#loadtrafficdata').hide(); */
	  pChange();
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#grpinfowindow').jqxWindow('close');
			
			$('#teaminfowindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#teaminfowindow').jqxWindow('close');
			  
			$('#assigninfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Method' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#assigninfowindow').jqxWindow('close');
			
			 $('#siteinfowindow').jqxWindow({ width: '25%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#siteinfowindow').jqxWindow('close');
			  
			  $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#areainfowindow').jqxWindow('close');
			
			  
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#adate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	 $("#atime").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"HH:mm",showCalendarButton: false});
	
	 
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
     $('#adate').jqxDateTimeInput('setDate', new Date());
     $('#atime').jqxDateTimeInput('setDate', new Date());
	/*  $('#todate').on('change', function (event) {
			
		   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(todates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 }); */
	 
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
     $('#txtgroup').dblclick(function(){
		   
    	 $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp');
		   		
		 });
     
     $('#txtsite').dblclick(function(){
		   
    	 $('#siteinfowindow').jqxWindow('open');
	      siteSearchContent('servicesitesearch.jsp');
		   		
		 });
     
     
     $('#txtgrpmember').dblclick(function(){
		   
    	 var assgnid=document.getElementById("groupid").value;
		  $('#teaminfowindow').jqxWindow('open');
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid);
		   		
		 });
     
     
     $('#txtassign').dblclick(function(){
		   
    	 $('#assigninfowindow').jqxWindow('open');
		  assignSearchContent('assignmodesearch.jsp');
		   		
		 });
	  
     $('#txtassignarea').dblclick(function(){
		   
    	 $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
		   		
		 });
	  
});


function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch1').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
	 else{
		 }
	 } 
     function clientSearchContent(url) {
           
               $.get(url).done(function (data) {
  
	           $('#clientsearch1').jqxWindow('setContent', data);

    	}); 
         	}

     function funExportBtn(){
			
    	   //$("#jqxprojectwiseGrid").jqxGrid('exportdata', 'xls', 'ProjectWise Balance Report');
    	   
    	   //JSONToCSVCon(exceldata,'Service Scheduler',true);
    	   $("#serschedulediv").excelexportjs({
				containerid: "serschedulediv",   
				datatype: 'json',
				dataset: null,
				gridId: "jqxloaddataGrid",
				columns: getColumns("jqxloaddataGrid") ,   
				worksheetName:"Service Scheduler"       
			});

    }
     
     
     function getsite(event){
    	 var x= event.keyCode;
		 if(x==114){
		  $('#siteinfowindow').jqxWindow('open');
	      siteSearchContent('servicesitesearch.jsp');
		 }
	   	 }
	   	 
	function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#siteinfowindow').jqxWindow('setContent', data);

	          	}); 
		}

    function getareas(event){
   	 var x= event.keyCode;
   	 if(x==114){
		  $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
	     	 }
    }
	     	 
	function areaSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#areainfowindow').jqxWindow('setContent', data);

	            	}); 
	  	}

function funreload()
{

	 var clientid=$('#clientid').val();
	 var date=$('#todate').val();
	 var barchval = document.getElementById("cmbbranch").value;
     var dtype="0";
     var id=1;
   // $("#overlay, #PleaseWait").show();
   var isprior=document.getElementById("isprior").value;
   
    if(id>0){
    	//$("#serschedulediv").load("serScheduleDetails.jsp?clientid="+clientid+"&date="+date+"&barchval="+barchval+"&dtype="+dtype+"&id="+id+"&isprior="+isprior);
    	countload(id);
    }
     
	}
	
	
function pChange(){
	 if(document.getElementById("priority").checked){
		 
		 document.getElementById("isprior").value=1;
		
	 }
	 else{
		 document.getElementById("isprior").value=0;
		
	 }
	}

	 function countload(id){
		 
		 var clientid=$('#clientid').val();
		 var date=$('#todate').val();
		 var barchval = document.getElementById("cmbbranch").value;
		 var isprior=document.getElementById("isprior").value;
		 var site=document.getElementById("txtsite").value;
		 var area=document.getElementById("txtareaid").value;
		 var bttnview=document.getElementById("bttnview").value;
		 
		 $("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			//$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			//site=site.replace(' ', '%20').replace(' ', '%20').replace(' ', '%20');
		    site=site.replace(/ /g, "%20");
			 $("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior+"&site="+site+"&area="+area+"&bttnview="+bttnview);
	 }
	 
	 function getgrpcode(event){
		 
		 var x= event.keyCode;
		 if(x==114){
		  $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp');
	   	 }
		 else{
			 }
		 }
	   	 
	function grpSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#grpinfowindow').jqxWindow('setContent', data);

	          	}); 
		}
		
	function getteam(event){
		 var x= event.keyCode;
		 if(x==114){
		var assgnid=document.getElementById("groupid").value;
		  $('#teaminfowindow').jqxWindow('open');
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid);
	 	 }
		 else{
			 }
		 }
	 	 
	function teamSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#teaminfowindow').jqxWindow('setContent', data);

	        	}); 
		}	
	
	
      function getassign(event){
    	  
    	  var x= event.keyCode;
    	  
 		 if(x==114){
		  $('#assigninfowindow').jqxWindow('open');
		  
		  assignSearchContent('assignmodesearch.jsp');
		  
	 	 }
 		 else{
 			 }
 		 }
	 	 
	function assignSearchContent(url) {
		 $.get(url).done(function (data) {
			 
	$('#assigninfowindow').jqxWindow('setContent', data);

	        	}); 
		}
	
	
function save(){
		
	var groupid=document.getElementById("groupid").value;
    var grpmemberid=document.getElementById("grpmemberid").value;
    var grpempid=document.getElementById("grpempid").value;
    var assignid=document.getElementById("assignid").value;
    var trno=document.getElementById("trno").value;
    var srno=document.getElementById("srno").value;
    var clientid=document.getElementById("clientid").value;
    var dtype=document.getElementById("dtype").value;
    var brchid=document.getElementById("cmbbranch").value;
    var desc=document.getElementById("txtdesc").value;
    var rowindex=document.getElementById("rowindex").value;
    var pdate=$('#adate').val();
	 var ptime=$('#atime').val();
	 if($('#rowindex').val()== "")
		{
	    	$.messager.alert('Message',"select a document");
		
		return 0;
		}
    if($('#groupid').val()== "")
	{
    	$.messager.alert('Message',"select Assign Group");
	
	return 0;
	}
	
	if($('#grpmemberid').val()== "")
	{
		$.messager.alert('Message',"select Group Member");
	
	return 0;
	}
	
	if($('#assignid').val()== "")
	{
		$.messager.alert('Message',"Select Assign Method");
	//document.getElementById("errormsg").innerText="Select Assign Method";
	return 0;
	}
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	 items=items.split('###');
			 	 var res=items[0];
			 	 
			 	if(res>0){
					   $.messager.alert('Message',"Saved Successfully");
					   
					   var clientid=$('#clientid').val();
		    			 var date=$('#todate').val();
		    			 var barchval = document.getElementById("cmbbranch").value;
			             var dtype=document.getElementById("dtype").value;
			             var rowindex=document.getElementById("rowindex").value;
			             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "gridrow",1);
			             
			             
			             document.getElementById("groupid").value="";
			             document.getElementById("grpmemberid").value="";
			            document.getElementById("grpempid").value="";
			             document.getElementById("assignid").value="";
			            document.getElementById("trno").value="";
			             document.getElementById("srno").value="";
			            document.getElementById("dtype").value="";
			             document.getElementById("txtgroup").value="";
			             document.getElementById("txtgrpmember").value="";
			             document.getElementById("txtassign").value="";
			             document.getElementById("txtdesc").value="";
			             $("#txtgroup").attr("placeholder", "press F3 for Search");
			             $("#txtgrpmember").attr("placeholder", "press F3 for Search");
			             $("#txtassign").attr("placeholder", "press F3 for Search");
			            /* $('#adate').val("");
			         	$('#atime').val(""); */
			         	$('#adate').jqxDateTimeInput('setDate', new Date());
			            $('#atime').jqxDateTimeInput('setDate', new Date());
			         
			   		 var isprior=document.getElementById("isprior").value;
			   		 var id=1;
			   			 $("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior);
			             
			             
		    		//$("#serschedulediv").load("serScheduleDetails.jsp?clientid"+clientid+"&date="+date+"&barchval="+barchval+"&dtype="+dtype);
		    		
		    		
					  }
			 	else{
			 		$.messager.alert('Message',"Not Updated");
			 	}
			 	 
				}
		       else
			  {}
	     }
	      x.open("GET","saveSchedule.jsp?groupid="+groupid+"&grpmemberid="+grpmemberid+"&grpempid="+grpempid+"&assignid="+assignid+"&trno="+trno+"&srno="+srno+"&clientid="+clientid+"&dtype="+dtype+"&brchid="+brchid+"&desc="+desc+"&pdate="+pdate+"&ptime="+ptime,true);
	     x.send();
	    
	   }
function serviceview(){
	
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	 items=items.split('###');
			 	 var res=items[0];
			 	
			 	if(res>0){             
			            
			 		document.getElementById("bttnview").value="1";
			   			
		    		
					  }
			 	else{
			 		document.getElementById("bttnview").value="0";
			 	}
			 	 
				}
		       else
			  {}
	     }
	      x.open("GET","viewSchedule.jsp?",true);
	     x.send();
	    
	   }
	   
	   function funClear(){
			$("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   
		   document.getElementById("txtsite").value="";
		   document.getElementById("siteid").value="0";
		   $("#txtsite").attr("placeholder", "press F3 for Search");
		   
		   document.getElementById("txtassignarea").value="";
		   document.getElementById("txtareaid").value="0";
		   $("#txtassignarea").attr("placeholder", "press F3 for Search");
		   
	   }
		 
	   function  funPrint()
		  {
		   
			 var doccno=$('#doccno').val();
			 var clientid=$('#clientid').val();
			 var date=$('#todate').val();
			 var barchval = document.getElementById("cmbbranch").value;
			
			 var isprior=document.getElementById("isprior").value;
			 var site=document.getElementById("txtsite").value;
			 var area=document.getElementById("txtareaid").value;
			  if(doccno==''){
					 $.messager.alert('Message','Please Select a Row.','warning');
					 return 0;
				 }
		   			
			 	    if ($("#doccno").val()!="") {
				        var url=document.URL;
				        var reurl=url.split("serviceScheduler.jsp");
			
				        var win= window.open(reurl[0]+"printservicescheduler?branch="+barchval+"&docno="+document.getElementById("doccno").value+'&dtype='+$("#dtype").val()+'&srno='+$("#srno").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();
				     }
				    else {
						$.messager.alert('Message','Please Select a Client.','warning');
						return;
					}
				   }
	   function printcheck(){
			//alert("gfdyukgfy");
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					//alert("vguyewrtwyurtwy");
				 	var items= x.responseText.trim();
				 	//alert(items);
				 	document.getElementById("confvalue").value=items;
				   	
		      }
			}
		      x.open("GET","viewprint.jsp",true);
		     x.send();
		    
		   
	       }
	   function  funPrintbutton()
		  {
		  
			 var doccno=$('#doccno').val();
			 
			 var dtype=document.getElementById("dtyp").value;
			 //alert(dtype);
			 var barchval = document.getElementById("cmbbranch").value;
			
			
			 
			  if(doccno==''){
					 $.messager.alert('Message','Please Select a Row.','warning');
					 return 0;
				 }
		   			
			 	    if ($("#doccno").val()!="" && dtype=="AMC") {
				        var url=document.URL;
				        var reurl=url.split("serviceScheduler.jsp");
			
				        var win= window.open(reurl[0]+"printserviceschedulerAMC?branch="+barchval+"&docno="+document.getElementById("doccno").value+'&dtype='+$("#dtype").val()+'&srno='+$("#srno").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();
				     }
			 	     else if($("#doccno").val()!="" && dtype=="SJOB"){
			 	    	
			 	    	var url=document.URL;
				        var reurl=url.split("serviceScheduler.jsp");
			
				        var win= window.open(reurl[0]+"printserviceschedulerSjob?branch="+barchval+"&docno="+document.getElementById("doccno").value+'&dtype='+$("#dtype").val()+'&srno='+$("#srno").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				        
				        win.focus();
			 	    	
			 	    }
			 	     
			 	    else {
						$.messager.alert('Message','Please Select a Client.','warning');
						return;
					}
				   }
	   function configCheck()
      {
			 // alert("///");
			  
			 var confvalue=document.getElementById("confvalue").value;
			// alert("confvalue:"+confvalue);
			  
			  if(confvalue==1){
				  
				  funPrintbutton();
			  }
			  else
				  {
				  funPrint();
				  }
			  }
	
	
</script>
</head>
<body onload="getBranch();serviceview();printcheck();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">


<div class="sidebar-fixed-top">
    <div class="filter-card">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>
</div>

<div class="sidebar-scroll-content">

   
    <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Upto Date</td>
                <td>
                    <div id="todate"
                         value='<s:property value="todate"/>'></div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Client</td>
                <td style="display:flex; gap:5px;">
                    <input type="text"
                           id="txtclient"
                           name="txtclient"
                           class="filter-input"
                           value='<s:property value="txtclient"/>'
                           onkeydown="getclinfo(event);"
                           readonly
                           placeholder="Press F3 to Search">

                    <button type="button"
                            class="bicon"
                            onclick="funClear();">
                        <img src="<%=contextPath%>/icons/clear.png">
                    </button>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Site</td>
                <td>
                    <input type="text"
                           id="txtsite"
                           name="txtsite"
                           class="filter-input"
                           value='<s:property value="txtsite"/>'
                           onkeydown="getsite(event);"
                           readonly
                           placeholder="Press F3 to Search">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Area</td>
                <td>
                    <input type="text"
                           id="txtassignarea"
                           name="txtassignarea"
                           class="filter-input"
                           value='<s:property value="txtassignarea"/>'
                           onkeydown="getareas(event);"
                           readonly
                           placeholder="Press F3 to Search">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Priority</td>
                <td>
                    <input type="checkbox"
                           id="priority"
                           name="priority"
                           onchange="pChange();">
                </td>
            </tr>

        </table>
    </div>

  
    <div class="filter-card">
        <div id="serCountgrid">
            <jsp:include page="serCountgrid.jsp"></jsp:include>
        </div>
    </div>

   
    <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Assign Group</td>
                <td>
                    <input type="text"
                           id="txtgroup"
                           name="txtgroup"
                           class="filter-input"
                           value='<s:property value="txtgroup"/>'
                           onkeydown="getgrpcode(event);"
                           readonly
                           placeholder="Press F3 to Search">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Group Member</td>
                <td>
                    <input type="text"
                           id="txtgrpmember"
                           name="txtgrpmember"
                           class="filter-input"
                           value='<s:property value="txtgrpmember"/>'
                           onkeydown="getteam(event);"
                           readonly
                           placeholder="Press F3 to Search">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Assign Method</td>
                <td>
                    <input type="text"
                           id="txtassign"
                           name="txtassign"
                           class="filter-input"
                           value='<s:property value="txtassign"/>'
                           onkeydown="getassign(event);"
                           readonly
                           placeholder="Press F3 to Search">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Planned Date</td>
                <td>
                    <div id="adate"
                         value='<s:property value="adate"/>'></div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Planned Time</td>
                <td>
                    <div id="atime"
                         value='<s:property value="atime"/>'></div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Description</td>
                <td>
                    <input type="text"
                           id="txtdesc"
                           name="txtdesc"
                           class="filter-input"
                           value='<s:property value="txtdesc"/>'>
                </td>
            </tr>

        </table>
    </div>

   
    <div class="button-group">
        <button type="button"
                class="btn-submit"
                onclick="save();">
            Save
        </button>

        <button type="button"
                class="btn-submit"
                onclick="configCheck();">
            Print
        </button>
    </div>

    
    <input type="hidden" id="assignid" name="assignid">
    <input type="hidden" id="trno" name="trno">
    <input type="hidden" id="bttnview" name="bttnview">
    <input type="hidden" id="srno" name="srno">
    <input type="hidden" id="dtype" name="dtype">
    <input type="hidden" id="doccno" name="doccno">
    <input type="hidden" id="isprior" name="isprior">
    <input type="hidden" id="rowindex" name="rowindex">
    <input type="hidden" id="confvalue" name="confvalue">
    <input type="hidden" id="dtyp" name="dtyp">

</div>
</div>
</div>

</td>


<td width="80%" valign="top">

<div class="grid-container">
    <div class="filter-card">
        <div id="serschedulediv">
            <jsp:include page="serScheduleDetails.jsp"></jsp:include>
        </div>
    </div>
</div>

</td>

</tr>
</table>

</div>


<div id="clientsearch1"><div></div></div>
<div id="grpinfowindow"><div></div></div>
<div id="teaminfowindow"><div></div></div>
<div id="assigninfowindow"><div></div></div>
<div id="siteinfowindow"><div></div></div>
<div id="areainfowindow"><div></div></div>

</div>
</body>
</html>