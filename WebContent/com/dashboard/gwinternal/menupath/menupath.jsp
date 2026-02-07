<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html P0UBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MENU PATH</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 
<script type="text/javascript">
$(document).ready(function () {
	$("#branchlabel").hide();
	$("#branchdiv").hide();
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        });  

function funExportBtn(){
	$("#mnpDiv").excelexportjs({
		containerid: "mnpDiv", 
		datatype: 'json', 
		dataset: null,   
		gridId: "jqxmnpGrid", 
		columns: getColumns("jqxmnpGrid") ,   
		worksheetName:"menupath"
		});

	
}   
function funreload(event){
	$("#mnpdiv").load("menugrid.jsp?id=1");
}
function funsave(rowid){
	var mno = $("#jqxmnpGrid").jqxGrid('getcellvalue',rowid,'mno'); 
	var menuname = $("#jqxmnpGrid").jqxGrid('getcellvalue',rowid,'menuname');
	var pmenu = $("#jqxmnpGrid").jqxGrid('getcellvalue',rowid,'pmenu');
	var path = $("#jqxmnpGrid").jqxGrid('getcellvalue',rowid,'path'); 
	var printpath1 = $("#jqxmnpGrid").jqxGrid('getcellvalue',rowid,'printpath1'); 
	var printpath2 = $("#jqxmnpGrid").jqxGrid('getcellvalue',rowid,'printpath2'); 
	var gate = $("#jqxmnpGrid").jqxGrid('getcellvalue',rowid,'gate'); 
	
	 $.messager.confirm('Confirm', 'Do you want to update ?', function(r){
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		save(mno,menuname,pmenu,path,printpath1,printpath2,gate);	
	     	}
	 });
	
	
}



function save(mno,menuname,pmenu,path,printpath1,printpath2,gate){      
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
			var items=x.responseText;
		if(parseFloat(items)>0){
			$.messager.alert('Message', '  Record Successfully Saved ', function(r){
		    });
		}else{
			$.messager.alert('Message', ' Not Saved ', function(r){
		    });
			
		}
			
	   }
	}
	x.open("GET", "saveData.jsp?mno="+mno+"&menuname="+menuname+"&pmenu="+pmenu+"&path="+path+"&printpath1="+printpath1+"&printpath2="+printpath2+"&gate="+gate, true);
	x.send();
}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">  
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
	<tr><td>&nbsp;</td></tr>	 
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr>
	 <tr><td>&nbsp;</td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="mnpdiv">
				<jsp:include page="menugrid.jsp"></jsp:include> 
			</div>
		
		</td> </tr>
	</table>
</tr>
</table>

</div>
 
</div>


</body>
</html>