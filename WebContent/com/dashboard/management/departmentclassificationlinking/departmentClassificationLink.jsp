
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
<script type="text/javascript" src="../../js/dashboard.js"></script> 


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






<script type="text/javascript">

$(document).ready(function () {
	$('#orderlist').show();
		$('#delete').hide();
	 $('#orderlistdetails').hide();
	 document.getElementById('rsumm').checked=true;

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Department Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#deptno').dblclick(function(){  		  
			  $('#accountDetailsWindow').jqxWindow('open');
			 commenSearchContent('departmentClassificationLinkSearch.jsp');
	 		    
	 		   
		  }); 
	 });
	 
	 
     
	  
function  getacc(event){
	 var x= event.keyCode;
	 if(x==114){
	
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 commenSearchContent('departmentClassificationLinkSearch.jsp');
	 }
	 }   
function commenSearchContent(url) {
	 
		 $.get(url).done(function (data) {
			 
			 $('#accountDetailsWindow').jqxWindow('open');
		$('#accountDetailsWindow').jqxWindow('setContent', data);

	}); 
	} 	


 
/* function funExportBtn(){
	  
	if(document.getElementById('rsumm').checked) {
	  
	JSONToCSVCon(rdatasex, 'NI Puchase Reports', true);
	}
	else if (document.getElementById('rdet').checked) {
		JSONToCSVCon(putdatasex, 'NI Puchase detailed Reports', true);
	}
} */
function funreload(event)
{

	 var accdocno=$("#accdocno").val(); 
	 var branch=$("#cmbbranch").val(); 
	 $("#overlay, #PleaseWait").show();
	 if(document.getElementById('rsumm').checked) {
		 $('#orderlistdetails').hide();
		 $('#deptlbl').show();
		 $('#deptno').show();
		 $('#deptname').show();
		 $('#listdiv').load("departmentClassificationLinkGrid.jsp?barchval="+branch);
		 $('#orderlist').show();
		 
	 } else if (document.getElementById('rdet').checked) {
		 	$('#orderlist').hide();
		  	$('#update').hide();
		  	$('#delete').show();
		  	$("#listdetdiv").load("departmentClassificationLinkingGridDV.jsp?barchval="+branch);
		   	$('#orderlistdetails').show();
	 }		   
}
	
	
function funClearInfo()
{
	  $("#deptdocno").val(''); 
	  
	 $("#deptno").val(''); 
	 $("#deptname").val('');   
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
		 $('#update').show();
		 $('#delete').hide();
		 
		 $('#deptlbl').show();
		 $('#deptno').show();
		 $('#deptname').show();
		 $('#clear').show();
		 
		  
		}
	 else if (document.getElementById('rdet').checked) {
		 /*  $('#orderlist').hide(); */
		 $('#update').hide();
		 $('#deptlbl').hide();
		 $('#deptno').hide();
		 $('#deptname').hide();
		 $('#clear').hide();
		 $('#delete').show();
		 $('#orderlist').jqxGrid('clearselection');
		}
	 }
	 
	 
	 function deletedata(){
		 var selectedrows = $("#orderlistdetails").jqxGrid('getselectedrowindexes');
			var list = new Array();
			for(var i=0 ; i < selectedrows.length; i++){
				var docno=$("#orderlistdetails").jqxGrid('getcellvalue',selectedrows[i],'rowno');
				list.push(docno);
			}
			
			$.messager.confirm('Confirm','Are you sure you want to delete record?',function(r){
			    if (r){
			    	ajaxcall1(list);
			    }
			    
			});
			
	 }
	 
	 function ajaxcall1(list){
			$.post('deletedata.jsp',{'list':JSON.stringify(list)},function(data,status){
				if(data>=1){
					$.messager.alert('Message','Successfully Deleted');
					const delayInMilliseconds = 1500;
					setTimeout(() => {}, delayInMilliseconds);
					const syntheticEvent = new Event('click'); 
					funreload(syntheticEvent);
				} 
			})
			
			
		}
	 
	 
		function savedata()
		{
			var deptno= document.getElementById('deptno').value;
			var selectedrows = $("#orderlist").jqxGrid('getselectedrowindexes');
			var list = new Array();
			
			for(var i=0 ; i < selectedrows.length; i++){
				var docno=$("#orderlist").jqxGrid('getcellvalue',selectedrows[i],'mid');
				list.push(docno+"::"+deptno+"::");
			}
			if(deptno==""|| deptno==null){
				$.messager.alert('Message','Please select the department');
			}else if(selectedrows.length<=0){
				$.messager.alert('Message','Please select the corresponding values');
			}
			else{
				$.messager.confirm('Confirm','Are you sure you want to update record?',function(r){
				    if (r){
				    	ajaxcall2(list);
				    }
				});
				
			}
			
			
			
		}
		
		function ajaxcall2(list){
			 var list= JSON.stringify(list)
			var branch = $('#cmbbranch').val();
			$.post('savedata.jsp',{'list':JSON.stringify(list)},function(data,status){
				if(data>=1){
					$.messager.alert('Message','Successfully Updated');
					 $('#orderlist').jqxGrid('clearfilters'); 
					 $('#orderlist').jqxGrid('clearselection');
				} else{
					$.messager.alert('Message','Already Exists');
				}
			})
		}
		
			 	
		
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">  
<div class='hidden-scrollbar'>                               
<table width="100%" >
<tr>
<td width="20%" valign="top">
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td  width="20%">&nbsp;</td><td  width="80%">&nbsp;</td></tr>
    <tr><td colspan="2" align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch">Update</label>&nbsp;&nbsp;
	<input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch">Delete/View</label></td></tr>
   	
   	<tr><td align="right"><label class="branch" id="deptlbl">Department</label></td>
	<td align="left"><input type="text" id="deptno" name="deptno" style="width:88%;height:20px;" placeholder="Press F3 To search" onclick="getacc(event);" readonly="readonly" value='<s:property value="deptno"/>' tabindex="-1" onkeydown="getacc(event);"/></td></tr> 
	<tr><td>&nbsp;</td> 
	<td><input type="text" id="deptname" name="deptname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="deptname"/>' tabindex="-1"/>
     </td></tr>
 
 <tr><td colspan="2">&nbsp;</td></tr>  
 
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="update" id="update"  value="Update" onclick="savedata();"></td></tr>
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="delete" id="delete"  value="Delete" onclick="deletedata();"></td></tr>
 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td>
	
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 50px;"></div></td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
 	<tr><td colspan="2">&nbsp;</td></tr> 
 	<tr><td colspan="2">&nbsp;</td></tr> 
 	<tr><td colspan="2">&nbsp;</td></tr> 	
	</table>
	</fieldset>
	
	<input type="hidden" id="dcldocno" name="dcldocno" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="dcldocno"/>' tabindex="-1"/>
	 
</td>

	<td width="80%">
	
	
	<table width="100%">
		<tr>
			  <td><div id="listdiv"><jsp:include page="departmentClassificationLinkGrid.jsp"></jsp:include></div></td> 
		</tr>
		  <tr><td><div id="listdetdiv">
				 <jsp:include page="departmentClassificationLinkingGridDV.jsp"></jsp:include> 
				</div></td></tr> 
	</table>
	</td>
</tr>
</table>

</div>
 
<div id="accountDetailsWindow">
	<div></div> 
</div>


</div>
</body>
</html>