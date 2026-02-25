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
	
	/* $('#loadsalikdata').hide();
	  $('#loadtrafficdata').hide(); */
	  pChange();
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#grpinfowindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Group' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#grpinfowindow').jqxWindow('close');
			
			$('#teaminfowindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Assign Team' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#teaminfowindow').jqxWindow('close');
			
	   		
			 $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#areainfowindow').jqxWindow('close');
			
	     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		  $('#clientsearch1').jqxWindow('close');
		  
		  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			
		  
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(todates).setMonth(todates.getMonth()-1)); 
	    
     $('#todate').jqxDateTimeInput('setDate', new Date());
    
	 
     $('#txtclient').dblclick(function(){
		   
    	 $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
		   		
		 });
	 
    
     
     
     $('#txtgrpmember').dblclick(function(){
		   
    	 var id=2;
    	 
    	 if(id==1){
 			
			 assgnid=document.getElementById("sergroupid").value;
   	    }
       
		  $('#teaminfowindow').jqxWindow('open');
		 
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
		   		
		 });
     
     
    
     //-----------------------------------------------------------------------
      $('#txtsergroup').dblclick(function(){
		   
    	 var id=1;
    	 $('#grpinfowindow').jqxWindow('open');
	      //grpSearchContent('servicegrpsearch.jsp');
    	 grpSearchContent('servicegrpsearch.jsp?id='+id);
		   		
		 });
     
     
     $('#txtsergrpemp').dblclick(function(){
		   
    	 var id=1;
    	 
    	 if(id==1){
 			
			 assgnid=document.getElementById("sergroupid").value;
   	    }
       
		  $('#teaminfowindow').jqxWindow('open');
		 
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
		   		
		 });
     
     
     $('#txtassignarea').dblclick(function(){
		   
    	 $('#areainfowindow').jqxWindow('open');
	        areaSearchContent('area.jsp');
		   		
		 });
    
    //---------------------------------------------------------------------------
	  
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

	function funExportBtn(){   
	  	 $("#serschedulediv").excelexportjs({    
				containerid: "serschedulediv",    
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxloaddataGrid", 
				columns: getColumns("jqxloaddataGrid") ,     
				worksheetName: "Service Update"
			});     
	  }



function funreload()
{
	
     var id=1;
  
   
    if(id>0){
    	
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
		 var chkfromdate = $('#hidchckfromdate').val();
		 var fromdate = $('#fromdate').val();
		 var barchval = document.getElementById("cmbbranch").value;
		 var isprior=document.getElementById("isprior").value;
		 var bttnview=document.getElementById("bttnview").value;
		 var grp=document.getElementById("sergroupid").value;
		 var emp=document.getElementById("grpserempid").value;
		 var mem=document.getElementById("grpsermemberid").value;
		 var area=document.getElementById("txtareaid").value;
		
		 
		    $("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			//$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			
		 
$("#serCountgrid").load("serCountgrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&isprior="+isprior+"&grp="+grp+"&emp="+emp+"&mem="+mem+"&area="+area+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate+"&bttnview="+bttnview);
		
		
		 
	 }
	 
	 
	 function getgrpcode(event,id){
		 
		 var x= event.keyCode;
		 if(x==114){
		  $('#grpinfowindow').jqxWindow('open');
	      grpSearchContent('servicegrpsearch.jsp?id='+id);
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
		
	function getteam(event,id){
		 var x= event.keyCode;
		 if(x==114){
			 var assgnid;
			 if(id==1){
				 assgnid=document.getElementById("sergroupid").value;
       	    }
		  $('#teaminfowindow').jqxWindow('open');
	    teamSearchContent('servicegrptoearch.jsp?assgnid='+assgnid+'&id='+id);
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
	   
	   function funClear(){
			$("#jqxloaddataGrid").jqxGrid('clear'); 
			$("#jqxSerCount").jqxGrid('clear');
			//$("#jqxloaddataGrid").jqxGrid('addrow', null, {});
			disablebtn();
		   document.getElementById("txtclient").value="";
		   document.getElementById("clientid").value="0";
		   
		   document.getElementById("txtsergroup").value="";
		   document.getElementById("sergroupid").value="0";
		   
		   document.getElementById("txtsergrpemp").value="";
		   document.getElementById("grpsermemberid").value="0";
		   document.getElementById("grpserempid").value="0";
		   
		   document.getElementById("txtassignarea").value="";
		   document.getElementById("txtareaid").value="0";
		   
		   $("#txtclient").attr("placeholder", "press F3 for Search");
		   $("#txtsergroup").attr("placeholder", "press F3 for Search");
		   $("#txtsergrpemp").attr("placeholder", "press F3 for Search");
		   $("#txtassignarea").attr("placeholder", "press F3 for Search");
		   document.getElementById("txtper").value="";
		   document.getElementById("rect").value="";
		   document.getElementById("txtdesc").value="";
		   document.getElementById("test").innerText="";
	   }
	   
	   
		  function funPrintBtn() {
				
			   
			    
	  }
		  function fromdatecheck(){
				 if(document.getElementById("chckfromdate").checked){
					 document.getElementById("hidchckfromdate").value = 1;
					 $('#fromdate').jqxDateTimeInput({ disabled: false});
				 }
				 else{
					 document.getElementById("hidchckfromdate").value = 0;
					 $('#fromdate').jqxDateTimeInput({ disabled: true});
				 }
			 }
		  function disablebtn()
			{
			  funselect();
				 $('#btnsave').attr("disabled",true);
				 $('#btnattach').attr("disabled",true);
				 $('#btnconfirm').attr("disabled",true);
				
			}
	function attach(){
		var fcode="SRVE";
		var fname="Sevice Report";
		 var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("srdocno").value+"&brchid="+document.getElementById("srbrhid").value+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				  myWindow.focus();
		
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
	      x.open("GET","checkview.jsp?",true);
	     x.send();
	    
	   }
	function save(event){   
		 var btnaction = event.target.id;
		var msg="Save";
		if(btnaction=="btnconfirm")
			{
			msg="Confirm";
			}
		 var txtsrtrno=$('#txtsrtrno').val();
		 var txtsrdocno =  $('#txtsrdocno').val();
		 var txtxper=$('#txtper').val();
		 var rect =  $('#rect').val();
		 var txtdesc = $('#txtdesc').val();
		 var rectval=0;
		if(txtxper==''){
			 $.messager.alert('Message','Please Enter Percentage','warning');
			 return 0;
		 }
		
		 if(rect>0){
			 if(txtdesc==''){
				 $.messager.alert('Message','Please Enter Description','warning');   
				 return 0;
			 }
			 rectval=1; 
		 }
		
		var txtcustomerdocno=document.getElementById("txtcustomerdocno").value;
			var txtcustomeracno=document.getElementById("txtcustomeracno").value;

			var cmbcontracttype=document.getElementById("cmbcontracttype").value;
			var txtcontracttrno=document.getElementById("txtcontracttrno").value;
			
			var txtsiteid=document.getElementById("txtsiteid").value;
			var txtareaid=document.getElementById("txtareaid").value;
			var txtscheduleno=document.getElementById("txtscheduleno").value;
			var servicetype=document.getElementById("servicetype").value;
		   $.messager.confirm('Confirm', 'Do you want to '+msg+' ? ', function(r){
	 			if (r){
	 				
	 			  		saveGridData(txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,txtsiteid,txtareaid,txtscheduleno,servicetype,txtxper,txtdesc,rectval,txtsrtrno,txtsrdocno,btnaction,msg);
						
						}
			 			
			 	 		});
		
		 
	}
	
		
	function saveGridData(txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,txtsiteid,txtareaid,txtscheduleno,servicetype,txtxper,txtdesc,rectval,txtsrtrno,txtsrdocno,btnaction,msg){
var msg12="Saved";
		if(msg=="Confirm")
	{
			msg12="Confirmed";
	}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)==1)  
				{	
					 var rowindex=document.getElementById("rowindex").value;
		             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "gridrow",1);
		             $('#jqxloaddataGrid').jqxGrid('setcellvalue', rowindex, "workper",parseFloat($('#txtper').val()));
					 
				//	funselect();
					disablebtn();
					/*  document.getElementById("txtper").value="";
					   document.getElementById("rect").value="";
					   document.getElementById("txtdesc").value="";
					   document.getElementById("test").innerText="";
						$("#jqxSerCount").jqxGrid('clear');
						$("#jqxloaddataGrid").jqxGrid('clear'); */
				$.messager.alert('Message', msg12+' Successfully ');
			
				}
				else
				{
				$.messager.alert('Message', ' Not '+msg12);
				}
				}
		}
   x.open("GET","saveData.jsp?txtcustomerdocno="+txtcustomerdocno+"&txtcustomeracno="+txtcustomeracno+"&cmbcontracttype="+cmbcontracttype
		   +"&txtcontracttrno="+txtcontracttrno+"&txtsiteid="+txtsiteid+"&txtareaid="+txtareaid+"&txtscheduleno="+txtscheduleno
		   +"&servicetype="+servicetype+"&txtxper="+txtxper+"&txtdesc="+txtdesc+"&rectval="+rectval+"&txtsrtrno="+txtsrtrno+"&txtsrdocno="+txtsrdocno+"&btnaction="+btnaction,true);		
	x.send();
			
	}
	//msg=='Confirm'?'Not Confirmed ':'Not Saved '
			//msg=='Confirm'?'Confirmed Successfully ':'Saved Successfully '
					
					
					
	function funselect(){
		var rect =  $('#rect').val();
		if(rect=="1")
			{
			$('#txtdesc').attr("disabled",false);
			}
		else{
			document.getElementById("txtdesc").value ="";
			$('#txtdesc').attr("disabled",true);
		}
	}
	
	
</script>
</head>
<body onload="getBranch();disablebtn();fromdatecheck();serviceview();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%" valign="top">

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

<!-- Filter Section -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">
<input type="checkbox" id="chckfromdate" name="chckfromdate"
       onchange="fromdatecheck();"
       onclick="$(this).attr('value', this.checked ? 1 : 0)">
<input type="hidden" id="hidchckfromdate" name="hidchckfromdate"
       value='<s:property value="hidchckfromdate"/>'/>
From
</td>
<td>
<div id="fromdate" value='<s:property value="fromdate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">Upto</td>
<td>
<div id="todate" value='<s:property value="todate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">Client</td>
<td style="display:flex; gap:5px;">
<input type="text" id="txtclient" name="txtclient"
       class="filter-input"
       value='<s:property value="txtclient"/>'
       onkeydown="getclinfo(event);"
       readonly placeholder="Press F3 to Search">
<input type="hidden" id="clientid" name="clientid"
       value='<s:property value="clientid"/>'>
<button type="button" class="bicon" onclick="funClear()">
<img src="<%=contextPath%>/icons/clear.png">
</button>
</td>
</tr>

<tr>
<td class="label-cell">Assign Group</td>
<td>
<input type="text" id="txtsergroup" name="txtsergroup"
       class="filter-input"
       value='<s:property value="txtsergroup"/>'
       onkeydown="getgrpcode(event,1);"
       readonly placeholder="Press F3 to Search">
<input type="hidden" id="sergroupid" name="sergroupid"
       value='<s:property value="sergroupid"/>'>
</td>
</tr>

<tr>
<td class="label-cell">Group Member</td>
<td>
<input type="text" id="txtsergrpemp" name="txtsergrpemp"
       class="filter-input"
       value='<s:property value="txtsergrpemp"/>'
       onkeydown="getteam(event,1);"
       readonly placeholder="Press F3 to Search">
<input type="hidden" id="grpsermemberid" name="grpsermemberid"
       value='<s:property value="grpsermemberid"/>'>
<input type="hidden" id="grpserempid" name="grpserempid"
       value='<s:property value="grpserempid"/>'>
</td>
</tr>

<tr>
<td class="label-cell">Area</td>
<td>
<input type="text" id="txtassignarea" name="txtassignarea"
       class="filter-input"
       value='<s:property value="txtassignarea"/>'
       onkeydown="getareas(event);"
       readonly placeholder="Press F3 to Search">
<input type="hidden" id="txtareaid" name="txtareaid"
       value='<s:property value="txtareaid"/>'>
</td>
</tr>

<tr>
<td class="label-cell">Priority</td>
<td>
<input type="checkbox" id="priority" name="priority"
       onchange="pChange();">
<button type="button" class="icon" id="btnPrint"
        hidden title="Print current Document"
        onclick="funPrintBtn()">
<img src="<%=contextPath%>/icons/print_new.png">
</button>
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
<td class="label-cell">Percentage</td>
<td>
<input type="text" id="txtper" name="txtper"
       class="filter-input"
       value='<s:property value="txtper"/>'>
</td>
</tr>

<tr>
<td class="label-cell">Rectification</td>
<td>
<select id="rect" name="rect" class="filter-input"
        onchange="funselect();">
<option value="">--SELECT--</option>
<option value="1">YES</option>
<option value="0">NO</option>
</select>
</td>
</tr>

<tr>
<td class="label-cell">Description</td>
<td>
<input type="text" id="txtdesc" name="txtdesc"
       class="filter-input"
       value='<s:property value="txtdesc"/>'>
</td>
</tr>

</table>
</div>


<div class="button-group">
<button type="button" class="btn-submit"
        onclick="save(event);">Save</button>

<button type="button" class="btn-submit"
        onclick="attach();">Attach</button>

<button type="button" class="btn-submit"
        onclick="save(event);">Confirm</button>
</div>


<input type="hidden" id="assignid" name="assignid">
<input type="hidden" id="trno" name="trno">
<input type="hidden" id="srno" name="srno">
<input type="hidden" id="dtype" name="dtype">
<input type="hidden" id="isprior" name="isprior">
<input type="hidden" id="rowindex" name="rowindex">
<input type="hidden" id="srdocno" name="srdocno">
<input type="hidden" id="srbrhid" name="srbrhid">
<input type="hidden" id="txtcustomerdocno" name="txtcustomerdocno">
<input type="hidden" id="txtcustomeracno" name="txtcustomeracno">
<input type="hidden" id="cmbcontracttype" name="cmbcontracttype">
<input type="hidden" id="txtcontracttrno" name="txtcontracttrno">
<input type="hidden" id="txtsiteid" name="txtsiteid">
<input type="hidden" id="txtscheduleno" name="txtscheduleno">
<input type="hidden" id="servicetype" name="servicetype">
<input type="hidden" id="txtsrtrno" name="txtsrtrno">
<input type="hidden" id="txtsrdocno" name="txtsrdocno">
<input type="hidden" id="bttnview" name="bttnview">

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
<div id="areainfowindow"><div></div></div>

</div>
</body>
</html>