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
     function funsaveCP(){
    	 var cldocno = $("#cmbclient").val(); 
    	 var gridarray=new Array();
		 var rows=$('#cpDetailsGrid').jqxGrid('getrows');
		 var val=0;
		 for(var i=0;i<rows.length;i++){
		    var chk=$('#cpDetailsGrid').jqxGrid('getcellvalue',i,'cpersion');
			if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				 gridarray.push(rows[i].cpersion+"::"+rows[i].mobile+" :: "+rows[i].phone+" :: "+rows[i].extn+" :: "
						   	+rows[i].email+" :: "+rows[i].areaid+" :: "+rows[i].activity_id+" :: "+rows[i].dep_id+"");      
				 val++;
			 }
		}
		if(val==0){
			$.messager.alert('Message','Please enter contact person details!!','warning');  
			return 0;  
		}else{
			$.messager.confirm('Message', 'Do you want to save changes?', function(r){  
				if(r==false) {
					return false; 
				} else {
					saveCPDetails(gridarray, cldocno);     
				}
			}); 
		}
     }
	 function saveCPDetails(gridarray, cldocno) {
		    var process = "CP"; 
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0){
						$('#contactpersonsavewindow').jqxWindow('close');
				 		$.messager.alert('Message','Successfully Saved','success');    
				 	}
				 	else{
				 		$('#contactpersonsavewindow').jqxWindow('close'); 
				 		$.messager.alert('Message','Not Saved','warning'); 
				 	}
				} else {
				}
			}
			x.open("GET", "saveData.jsp?cldocno="+cldocno+"&cparray="+encodeURIComponent(gridarray)+"&process="+process, true);   
			x.send();  
		}  

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table>
   <tr>
    <td colspan="2" align="center"><input type="button" name="btnsave" id="btnsave" class="myButton" value="Save" onclick="funsaveCP();"></td>
    <tr>
    </table>
    </td>
  </tr>
  <tr> <td colspan="8" align="right"> <div id="cpdiv"> <jsp:include  page="contactPeronGrid.jsp"></jsp:include> </div></td> </tr>
</table>
  </div>
</body>
</html>