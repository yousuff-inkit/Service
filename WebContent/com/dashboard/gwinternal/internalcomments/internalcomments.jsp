<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

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
		document.getElementById('rsumm').checked=true;
		$('#btnDelete').hide();
		$("#branchlabel").hide();
		$("#branchdiv").hide(); 
		 $("#companylistdDiv").hide();
		 $("#companylistDiv").show();
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#companylistwindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Company List' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#companylistwindow').jqxWindow('close');
	   
	    $('#txtname').dblclick(function(){   
	    	 $('#companylistwindow').jqxWindow('open');
		     indSearchContent('getCompany.jsp');  		
			 });
	});
	
	
	
	function funExportBtn(){
		
		$("#companylistDiv").excelexportjs({
			containerid: "companylistDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "companylistGridID", 
			columns: getColumns("companylistGridID") ,   
			worksheetName:"Internal Comments"
			});	
	}
	
	
	function funreload(event)
	{
		 console.log("reload");
		 var accdocno=$("#accdocno").val(); 
		 $("#overlay, #PleaseWait").show();
		 if(document.getElementById('rsumm').checked) {
			
			 $('#txtname').show();
			 $('#comment').show();
			 $("#lblcomment").show();
			 $("#lblname").show();
			 $('#btnDelete').hide();
			 $("#clear").show();
			 $('#btnSave').show(); 
			 $('#txtname').attr("disabled", false);
			 $("#comment").attr("disabled", false);
			 $("#companylistdDiv").hide();
			 $("#companylistDiv").show();
			 $("#companylistDiv").load("internalcommentsGrid.jsp?check=1");
		 } else if (document.getElementById('rdet').checked) {
			 $('#btnDelete').show();
			 $('#btnSave').hide();
			 $('#txtname').val("");
			 $('#comment').val("");
			 $('#txtname').hide();
			 $('#comment').hide();
			 $("#lblcomment").hide();
			 $("#lblname").hide();
			 $("#clear").hide();
			 $("#companylistDiv").hide();
			 $("#companylistdDiv").show();
			 $("#companylistdDiv").load("internalcommentsdGrid.jsp?check=1"); 
		 }		   
	}
	
	function getUpdate(event){
		 var docno = $('#docno').val();
		 var cldocno=$('#cldocno').val();
		 var comment=$('#comment').val();
		if(cldocno==''){
			 $.messager.alert('Message','Enter Company name','warning');
			 return 0;
		 }
		if(comment==''){
			 $.messager.alert('Message','Enter a Comment','warning');
			 return 0;
		 }
		
	    $.messager.confirm('Message', 'Do you want to save the record?', function(r){
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 
			    
	     		 saveGridData(docno,cldocno,comment); 	
	     	}
	 });
}
		
		
		
		
		function getDelete(event){
			 var selectedrows = $("#companylistdGridID").jqxGrid('getselectedrowindexes');
			 var list = new Array();
			 for(var i=0 ; i < selectedrows.length; i++){
					var docno=$("#companylistdGridID").jqxGrid('getcellvalue',selectedrows[i],'doc_no');
					list.push(docno);
				}
			if(selectedrows<0){
				 $.messager.alert('Message','Select a Comment','warning');
				 return 0;
			 }
			
		    $.messager.confirm('Message', 'Do you want to delete the comment?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 deleteGridData(list); 	
		     	}
		 });
	}
	

	function saveGridData(docno, cldocno, comment) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				if (items > 0) {
					$.messager.alert('Message', '  Record Successfully Saved ',
							function(r) {
							});
					$('#docno').val('');
					$('#cldocno').val('');
		            $("#txtname").val('');
		            $("#comment").val('');
				} else {
					$.messager.alert('Message', '  Not Saved ', function(r) {
					});
				}
				 $('#companylistGridID').jqxGrid('clearfilters'); 
				funreload(event);
			}
		}
		x.open("GET", "saveData.jsp?docno=" + docno + "&cldocno=" + cldocno
				+ "&comment=" + comment, true);
		x.send();
	}

	function deleteGridData(list) {
		$.post('deleteData.jsp',{'list':JSON.stringify(list)},function(data,status){
			if(data>=1){
				$.messager.alert('Message','Successfully Deleted');
				const delayInMilliseconds = 500;
				setTimeout(() => {}, delayInMilliseconds);
				const syntheticEvent = new Event('click'); 
				funreload(syntheticEvent);
				 $('#companylistdGridID').jqxGrid('clearfilters'); 
				 $('#companylistdGridID').jqxGrid('clearselection');
			} else {
				$.messager.alert('Message', '  Not Deleted ', function(r) {
				});
			}
		});	
		funreload(event);
	}

	function funClearInfo() {
		$('#txtname').val('');
		$('#docno').val('');
		$('#comment').val('');
		$('#cldocno').val('');
	}

	function getCompany(event) {
		var x = event.keyCode;
		if (x == 114) {
			$('#companylistwindow').jqxWindow('open');
			indSearchContent('getCompany.jsp');
		}
	}

	function indSearchContent(url) {
		//alert(url);
		$.get(url).done(function(data) {
			//alert(data);
			$('#companylistwindow').jqxWindow('setContent', data);

		});
	}
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="23%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
 	<tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled"  value="rsumm"><label for="rsumm" class="branch">Add/Update</label>&nbsp;&nbsp;
	<input type="radio" id="rdet" name="stkled"  value="rdet"><label for="rdet" class="branch">Delete</label></td></tr> 
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<!-- <tr><td colspan="2">&nbsp;</td></tr> -->
		
    <tr><td align="right"><label class="branch" id="lblname">Name</label></td>
	<td align="left"><input type="text" id="txtname" name="txtname" style="width:100%;height:20px;" onKeyDown="getCompany(event);" readonly placeholder="Press F3 to Search" value='<s:property value="txtname"/>' /></td></tr>
	 <tr >
	      <td align="right" style="vertical-align:top"><label class="branch" id="lblcomment" >Comment</label></td>
	      <td > <textarea id="comment" name="comment" rows="5" maxlength="500"  style="width:100%;resize:none;font-family:Tahoma; font-size:11px;" value='<s:property value="comment"/>' ></textarea>
	      <!-- <input style="height:19px;" type="text" name="comment" id="comment"   >
	    -->
   
      <input type="hidden" id="txtcomment" name="txtcomment" value='<s:property value="txtcomment"/>'>
	  <input type="hidden" id="compid" name="compid" value='<s:property value="compid"/>'></td>
	      
	 </tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnDelete" name="btnDelete" onclick="getDelete(event);">Delete</button>
	<button class="myButton" type="button" id="btnSave" name="btnSave" onclick="getUpdate(event);">Save</button></td></tr>
	  <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2"><input type="hidden" name="txtselecteddocs" id="txtselecteddocs"  value='<s:property value="txtselecteddocs"/>'>
	<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>' style="width:100%;height:20px;"/>
		<input type="hidden" id="docno" name="docno"  value='<s:property value="docno"/>' style="width:100%;height:20px;"/>
		<input type="hidden" id="cldocno" name="cldocno"  value='<s:property value="cldocno"/>' style="width:100%;height:20px;"/>
		<input type="hidden" id="brhid" name="brhid"/> 
	</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>  
	</table>
	</fieldset>
</td>
<td width="80%" style="vertical-align:top">
	<table width="100%">
		<tr>
			  <td><div id="companylistDiv"><jsp:include page="internalcommentsGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr>
			  <td><div id="companylistdDiv"><jsp:include page="internalcommentsdGrid.jsp"></jsp:include></div></td>
		</tr>
		
	</table>
</tr>
</table>
</div>
<div id="companylistwindow">
   <div ></div>
</div> 
</div>
</body>
</html>