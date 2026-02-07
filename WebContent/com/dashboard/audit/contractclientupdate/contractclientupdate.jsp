<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
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

</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#contractDetailsWindow').jqxWindow({width: '40%', height: '50%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Contract Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#contractDetailsWindow').jqxWindow('close');
		 
		 $('#cpinfowindow').jqxWindow({ width: '35%', height: '62%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#cpinfowindow').jqxWindow('close');
		 
		 $('#serviceteamwindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Team Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#serviceteamwindow').jqxWindow('close');

		 $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#areainfowindow').jqxWindow('close');
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
	     $('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
			 
			   if(fromdates>todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   	   return false;
			  }   
		 });
	     
		 $('#txtclientname').dblclick(function(){
			 accountsSearchContent('clientAccountDetailsSearch.jsp');
	     });
		 
		 $('#txtcontract').dblclick(function(){
			 if($('#cmbcontracttype').val()=='ALL'){
				   $.messager.alert('Message','Choose a Contract Type.','warning');   
				   return false;
			 }
			 contractSearchContent('contractDetailsSearch.jsp?contracttype='+$('#cmbcontracttype').val());
	     });
		 
		 if($("#msg").val()=="Successfully Saved" || $("#msg").val()=="Not Saved") { 
			 $.messager.alert('Message',$('#msg').val());
		}
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function contractSearchContent(url) {
	    $('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function funExportBtn(){
		$("#cntDiv").excelexportjs({
			containerid: "cntDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "contractGridID", 
			columns: getColumns("contractGridID") ,     
			worksheetName:"Contract Client Update"
		});
	} 
	
	function getClientAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountsSearchContent('clientAccountDetailsSearch.jsp');
        }
    }
	
	function getContract(event){
        var x= event.keyCode;
        if(x==114){
        	if($('#cmbcontracttype').val()=='ALL'){
				   $.messager.alert('Message','Choose a Contract Type.','warning');   
				   return false;
			 }
			 contractSearchContent('contractDetailsSearch.jsp?contracttype='+$('#cmbcontracttype').val());
        }
    }
	
	function cpSearchContent(url) {
	 	 $.get(url).done(function (data) {
			$('#cpinfowindow').jqxWindow('setContent', data);
	     }); 
	}

	function getserviceteam(rowBoundIndex){
	    $('#serviceteamwindow').jqxWindow('open');
		serviceteamContent('serviceteam.jsp?rowBoundIndex='+rowBoundIndex);
	}
	
	function serviceteamContent(url) {
		$.get(url).done(function (data) {
			$('#serviceteamwindow').jqxWindow('setContent', data);
		}); 
	}
	
	function getareas(rowBoundIndex){
		$('#areainfowindow').jqxWindow('open');
		areaSearchContent('area.jsp?rowBoundIndex='+rowBoundIndex);
	}
	     	 
	function areaSearchContent(url) {
		 $.get(url).done(function (data) {
			$('#areainfowindow').jqxWindow('setContent', data);
	     }); 
	}

	function funreload(event){
		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
		 	 
		 if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		   	   return false;
		  }
		  
	     var branch = document.getElementById("cmbbranch").value;
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var contracttype=$('#cmbcontracttype').val();
		 var contract= $("#txtcontracttrno").val();
		 var clientid="";
		 
		 $("#overlay, #PleaseWait").show(); 
		 $("#cntDiv").load("contractGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&contracttype="+contracttype+"&contract="+contract+"&clientid="+clientid+"&id="+1);
	}
	
	function  funClearData(){
		 $('#cmbbranch').val('a');
   	     $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     $('#todate').val(new Date());
	     
		 $('#txtclientname').val('');
		 $('#txtclientaccountdocno').val('');
		 $('#cmbcontracttype').val('ALL');
		 $('#txtcontract').val('');
		 $('#txtcontracttrno').val('');
		 $('#txtselectedcontract').val('');
		 $('#txtselectedcontractdtype').val('');
		 
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		 if (document.getElementById("txtcontract").value == "") {
		        $('#txtcontract').attr('placeholder', 'Press F3 to Search'); 
		 }
		 $("#contractGridID").jqxGrid('clear'); 
	}
	
	function funClientUpdate(){   
		var cnttrno = $("#hidcnttrno").val(); 
		var acno = $("#acno").val(); 
		var cldocno = $("#txtclientaccountdocno").val();
		if(cnttrno=="" || cnttrno=="0"){
			 $.messager.alert('Message','Please select a document!','warning');     
		   	 return false;
		} 
		if(cldocno=="" || cldocno=="0"){
			 $.messager.alert('Message','Please select a client!','warning');        
		   	 return false;
		} 
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	if(r==false) {
			     		return false; 
			     	  } else {
			     		 $("#overlay, #PleaseWait").show();
			     		 saveData(cnttrno,cldocno,acno);
			     	}
			 });
	}
	function saveData(trno, cldocno,acno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
				var items = x.responseText.trim();  
				$("#overlay, #PleaseWait").hide();
				if(parseInt(items)>0){
					$.messager.alert('Message', ' Updated Successfully.', function(r){});
					funreload(event);
				} else {
					$.messager.alert('Message', ' Failed.', function(r){});
				}
		   }
	    }
		x.open("GET","saveData.jsp?trno="+trno+"&cldocno="+cldocno+"&acno="+acno,true);   
		x.send();      
	}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmcontractClientUpdate" method="post" autocomplete="off">
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
	<tr><td align="right"><label class="branch">Type</label></td>
    <td align="left"><select id="cmbcontracttype" name="cmbcontracttype" value='<s:property value="cmbcontracttype"/>'>
    <option value="ALL">ALL</option><option value="AMC">AMC</option><option value="SJOB">SJOB</option>
    </select></td></tr>
	<tr><td align="right"><label class="branch">Contract</label></td>
	<td align="left"><input type="text" id="txtcontract" name="txtcontract" style="width:96%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtcontract"/>' onkeydown="getContract(event);"/>
	<input type="hidden" id="txtcontracttrno" name="txtcontracttrno" value='<s:property value="txtcontracttrno"/>'/></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:96%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClientAccount(event);"/>
	<input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno" value='<s:property value="txtclientaccountdocno"/>'/>
	<input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'/></td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<button class="myButton" type="button" id="btnClientUpdate" name="btnClientUpdate" onclick="funClientUpdate();">Update</button></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;<input type="hidden" id="hidcnttrno" name="hidcnttrno"/>
		</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">  
	<tr><td><div id="cntDiv"><jsp:include page="contractGrid.jsp"></jsp:include></div></td></tr>
	</table> 
</tr>
</table>
</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="contractDetailsWindow">
	<div></div><div></div>
</div>
<div id="cpinfowindow">
   <div ></div>
</div>
<div id="serviceteamwindow">
   <div ></div>
</div>
<div id="areainfowindow">
   <div ></div>
</div>

</div> 
</body>
</html>