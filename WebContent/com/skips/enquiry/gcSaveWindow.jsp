 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
  <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" /> 
</style>
	<script type="text/javascript">
     function funsaveGC(){
    	 var grpcmp = $("#gc_grpcmp").val();  
		 if(grpcmp=="0" || grpcmp==""){  
			$.messager.alert('Message','Please enter group company!!','warning');  
			return 0;  
		 }else{
			$.messager.confirm('Message', 'Do you want to save changes?', function(r){  
				if(r==false) {
					return false; 
				} else {
					saveGCDetails(grpcmp);       
				}
			}); 
		 }
     }
	 function saveGCDetails(grpcmp) {  
		    var process = "GC";
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0){
						$('#groupcompanysavewindow').jqxWindow('close');
				 		$.messager.alert('Message','Successfully Saved','success');    
				 	}
				 	else{
				 		$('#groupcompanysavewindow').jqxWindow('close');   
				 		$.messager.alert('Message','Not Saved','warning'); 
				 	}
				} else {  
				}
			}
			x.open("GET", "saveData.jsp?grpcmp="+encodeURIComponent(grpcmp)+"&process="+process);        
			x.send();
		}  

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
	   <td align="right" width="10%">Group Company</td>  
	   <td align="left" width="45%"><input type="text" id="gc_grpcmp" name="gc_grpcmp" style="width: 90%;" value='<s:property value="gc_grpcmp"/>'></td>
	   <td align="right" width="5%"><input type="button" name="btnsavegcc" id="btnsavegcc" class="myButton" value="Save" onclick="funsaveGC();"></td>
  </tr>
</table>
  </div>
</body>
</html>