<jsp:include page="../../../../includeso.jsp"></jsp:include>    
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
		fungroup();
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#Searchwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 	   $('#Searchwindow').jqxWindow('close');
		   
		    
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     $('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			   if(todates<fromdates){      
				 $.messager.alert('Message','To Date Less Than From Date','warning');
			        return false;  
			  }     
		 });
		$('#fromdate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			   if(fromdates>todates){  
				 $.messager.alert('Message','From Date Greater Than To Date','warning');
			        return false;  
			   }   
		 });   
		  $('#client').dblclick(function(){
			    
		    	
	    		
		  	    $('#Searchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('clientsearch.jsp?');
	    		 
	  });   
	   
	});
	function getclientdetails(event){
		 var x= event.keyCode;
	  	
	 
			
		 if(x==114){
		  $('#Searchwindow').jqxWindow('open');
		
		 accountSearchContent('clientsearch.jsp?');    }
		 else{
			 }
			 
		 }  
		  function accountSearchContent(url) {
	 
	         $.get(url).done(function (data) {
	 
	       $('#Searchwindow').jqxWindow('setContent', data);

		}); 
	   	}
		  function getCategory() {
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('####');
						var categoryItems = items[0].split(",");
						var categoryIdItems = items[1].split(",");
						var optionscategory = '<option value="">--Select--</option>';
						for (var i = 0; i < categoryItems.length; i++) {
							optionscategory += '<option value="' + categoryIdItems[i] + '">'
									+ categoryItems[i] + '</option>';
						}
						$("select#cmbcategory").html(optionscategory);
						if ($('#hidcmbcategory').val() != null) {
							$('#cmbcategory').val($('#hidcmbcategory').val());
						}
					} else {
					}
				}
				x.open("GET", "getCategory.jsp", true);
				x.send();
			}
		  function getsalesman() {
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('####');
						var salesmanItems = items[0].split(",");
						var salesmanIdItems = items[1].split(",");
						var optionssalesman = '<option value="">--Select--</option>';
						for (var i = 0; i < salesmanItems.length; i++) {
							optionssalesman += '<option value="' + salesmanIdItems[i] + '">'
									+ salesmanItems[i] + '</option>';
						}
						$("select#salesman").html(optionscategory);
						if ($('#hidsalesman').val() != null) {
							$('#salesman').val($('#hidsalesman').val());
						}
					} else {
					}
				}
				x.open("GET", "getsalesman.jsp", true);
				x.send();
			}
			function getsalesman() {
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						items = items.split('####');
						var salesagentItems = items[0].split(",");
						var salesagentIdItems = items[1].split(",");
						var optionssalesagent = '<option value="">--Select--</option>';
						for (var i = 0; i < salesagentItems.length; i++) {
							optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
									+ salesagentItems[i] + '</option>';
						}
						$("select#cmbsalesperson").html(optionssalesagent);
						if ($('#hidcmbsalesperson').val() != null) {
							$('#cmbsalesperson').val($('#hidcmbsalesperson').val());
						}
					} else {
					}
				}
				x.open("GET", "getsalesman.jsp", true);
				x.send();
			}
			
			function fungroup(){
		 		
		 		var groupby=document.getElementById("groupby").value;
				 	if(groupby=="client" ||groupby=="salesman" || groupby=="category")
						{
						$('#salesReportGridDiv').hide();
						$('#groupbydiv').show();
						
						}
		 			else{
		 				$('#salesReportGridDiv').show();
						$('#groupbydiv').hide();
						}
		 	 }
			
	function funreload(event){
		
		 var fromdate = $('#fromdate').jqxDateTimeInput('val');   
		 var todate = $('#todate').jqxDateTimeInput('val');
		 var cldocno=$('#cldocno').val();
		 var category = $('#cmbcategory').val();
		 var salesman = $('#cmbsalesperson').val();
		 var groupby = $('#groupby').val();
				
		$("#overlay, #PleaseWait").show();
   		 $("#salesReportGridDiv").load('consolidatedSalesGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&category='+category+'&salesman='+salesman+'&groupby='+groupby+'&check=1');
   	
   		 if(groupby=="client" || groupby=="category" || groupby=="salesman") {
			
			 $("#groupbydiv").load("groupbyGrid.jsp?fromdate="+fromdate+"&todate="+todate+'&cldocno='+cldocno+'&category='+category+'&salesman='+salesman+'&groupby='+groupby+'&check=1');

		 }

		else{
			
		}
   	 }
	
	function funExportBtn(){
		//alert($("#groupby").val());
		if($("#groupby").val()!=""){
			$("#groupbydiv").excelexportjs({
				containerid: "groupbydiv",   
				datatype: 'json',
				dataset: null,
				gridId: "groupbyGrid",
				columns: getColumns("groupbyGrid") ,   
				worksheetName:"Consolidated Sales Report"
			});
			
		}else{
			$("#salesReportGridDiv").excelexportjs({
				containerid: "salesReportGridDiv",   
				datatype: 'json',
				dataset: null,
				gridId: "salesReportGrid",
				columns: getColumns("salesReportGrid") ,   
				worksheetName:"Consolidated Sales Report"       
			});
		}
	}
	
</script>
</head>
<body onload="getBranch();getCategory();getsalesman();">
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
<td align="right"><label class="branch">Client</label></td>
    <td  ><input type="text" name="client" id="client" value='<s:property value="client"/>' readonly="readonly" placeholder="Press F3 To Search"   style="height:20px;width:70%;" onKeyDown="getclientdetails(event);" > 
 <input type="hidden" name="cldocno" id="cldocno" style="width:70%;" value='<s:property value="cldocno"/>' ></td>
  </tr>
 <tr><td align="right"><label class="branch">Category</label></td>
	 <td><select id="cmbcategory" name="cmbcategory" style="width:80%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Sales Man</label></td>
	   <td><select id="cmbsalesperson" name="cmbsalesperson" style="width:80%;" value='<s:property value="cmbsalesperson"/>'>
       <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/></td></tr>
	      <tr>
	   <td align="right"><label class="branch">Group By</label></td>
	 <td width="14%"><select id="groupby" name="groupby" onchange="fungroup();" style="width:68%;height:20px;"  value='<s:property value="txtsumtype"/>'>
	 <option value="">--Select--</option>
	 <option value='client'>Client</option>
	 <option value='category'>Category</option>
	 <option value='salesman'>Salesman</option>
      
      </select>
	  </tr> 
	    </table>
	<br/><br/><br/>
	<br/><br/><br/>
	<br/><br/><br/>
	<br/><br/></br>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr> <td><div id="salesReportGridDiv"><jsp:include page="consolidatedSalesGrid.jsp"></jsp:include></div></td></tr>
		<tr>
			  <td><div id="groupbydiv"  ><jsp:include page="groupbyGrid.jsp"></jsp:include></div></td>
			 
		</tr>
	</table>
</td>
</tr>
</table>
</div>
<div id="Searchwindow">  
   <div ></div>
</div> 


</div>
</body>
</html>