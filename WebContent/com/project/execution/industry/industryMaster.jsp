<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
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
$(document).ready(function() {
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 // $('#btnEdit').attr('disabled', true);
	  $('#btnSearch').attr('disabled', true);
});

	 function funReadOnly(){
			$('#frmINDUSTRY input').attr('readonly', true );
			$('#frmINDUSTRY select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			
	 }
	 
	 function funRemoveReadOnly(){  
			$('#frmINDUSTRY input').attr('readonly', false );
			$('#frmINDUSTRY select').attr('disabled', false);
			$('#date').jqxDateTimeInput({disabled: false});
			if ($("#mode").val() == "A") {
				$('#date').val(new Date());
			}  
			
			$('#docno').attr('readonly', true);
	 }
	 
	 function funSearchLoad(){
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){
		  var names = document.getElementById("txtname").value;
		  if(names==''){  
			    document.getElementById("errormsg").innerText="Please Enter Name";       
		    	return 0;
		  }
		  return 1;
		} 

	  function setValues(){
		  var docVal1 = document.getElementById("docno").value;
	      	if(docVal1>0)
	      		{
	         $("#inddiv").load("industryGrid.jsp?docno="+docVal1);   
	      		}  
	      	if($('#msg').val()!=""){
	      		$.messager.alert('Message',$('#msg').val());
	      		}  
		}   
	        
	  function funPrintBtn() {
	    }
	  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;  
  height: 530px;  
}
</style>    
     
</head>
<body onload="setValues();">   
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmINDUSTRY" action="saveINDUSTRY" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'> 
<br/>
<table width="100%">
<tr><td>  
<fieldset>
<table width="100%">  
<tr>  
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>  
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddte"/>'/></td>
    
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno"  value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>      
  <tr>   
       <td align="right">Name</td>
     <td width="14%"><input type="text" id="txtname" name="txtname" style="width:490px;" value='<s:property value="txtname"/>'/></td>
     <td hidden="true" align="right">Remarks</td>
     <td  hidden="true" width="14%"><input type="text" id="txtremarks" name="txtremarks" style="width:490px;"   value='<s:property value="txtremarks"/>'/></td>
      </tr>     
    </table>   
</fieldset><br/>              
</td>               
</tr></table>   
<table width="100%">   
  <tr>
    <td>
    <div id="inddiv"><jsp:include page="industryGrid.jsp"></jsp:include></div>
  </td>
  </tr>    
</table>
<input type="hidden" id="mode" name="mode"/>  
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>'/>
</div>
</form>
  
	
</div>
</body>
</html>
