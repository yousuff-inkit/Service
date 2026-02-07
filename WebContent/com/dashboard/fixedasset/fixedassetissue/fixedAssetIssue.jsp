<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	$("#issueddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	/*  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
 */	
 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
 
 $('#groupDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 $('#groupDetailsWindow').jqxWindow('close');
 $('#accountDetailsWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Account Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 $('#accountDetailsWindow').jqxWindow('close');
 
 fundisable();
 
 
 $('#txtgroup').dblclick(function(){
	  groupSearchContent('groupSearchGrid.jsp');
 });
 $('#txtaccount').dblclick(function(){
	 if(document.getElementById("txtisssueto").value=="emp") //com/search/costunit/costCodeSearchGrid.jsp
		{
		 accountSearchContent('accountSearch.jsp?check=1');
		 }
	 else{
		    var dtype=$('#txtisssueto').val();
	  		accountSearchContent('amcSjobSearch.jsp?dtype='+dtype);
	 }
});
 
});



function getGroup(event){
    var x= event.keyCode;
    if(x==114){
    	groupSearchContent('groupSearchGrid.jsp');
    }
    else{}
    }
    
function getAccount(event){
	
  var x= event.keyCode;
    if(x==114){
    	
    	if(document.getElementById("txtisssueto").value=="emp") //com/search/costunit/costCodeSearchGrid.jsp
    	{
    	 accountSearchContent('accountSearch.jsp?check=1'); 	
    	}
     else{
    	 	var dtype=$('#txtisssueto').val();
	  		accountSearchContent('amcSjobSearch.jsp?dtype='+dtype);
     }
    }
    else{} 
    }
    
function accountSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}    
    


function groupSearchContent(url) {
    $('#groupDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#groupDetailsWindow').jqxWindow('setContent', data);
	$('#groupDetailsWindow').jqxWindow('bringToFront');
}); 
}
function funreload(event)
{
	 var issue_stat="0";
	 if($("#issue_ret").val()=="issue"){
		 issue_stat="0";
	 }
	 if($("#issue_ret").val()=="ret"){
		 issue_stat="1";
	 }
	 var groupno=$('#txtgroupno').val();
	  $("#faIssue").load("fixedAssetIssueGrid.jsp?issue_stat="+issue_stat+"&check=1"+"&groupno="+groupno);
	  fundisable();
	}
	
function fundisable(){
			$("#txtisssueto").attr("disabled",true);
			$("#txtaccount").attr("disabled",true);
			$('#issueddate').val(new Date());
			$('#issueddate').jqxDateTimeInput({disabled: true});
			$("#save").attr("disabled",true);
	
}	
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	}
	function funExportBtn(){
		// $("#faListGrid").jqxGrid('exportdata', 'xls', 'Fixed Asset List');
	
		
	}
	function getclr(){
		    
		$('#txtgroup').val("");
		$('#txtgroupno').val("");
		//$('#txtisssueto').val("");
		$('#txtaccount').val("");
		$('#hidaccount').val("");
	}
	function getAccountClear(){
		$('#txtaccount').val("");
		$('#hidaccount').val("");
	}	
	
	
	function funsave()
	{
		
		 
		 if($('#issue_ret').val()=="") 
		 {
			 $.messager.alert('Message','Select Issue/Return ','warning');   
			 return 0;
		 }
		 
	      if($('#txtisssueto').val()=="") 
	 	 {
	 		 $.messager.alert('Message','Select Issue To','warning');   
	 		 return 0;
	 	 }
	      
	      if($('#hidaccount').val()=="") 
		 	 {
		 		 $.messager.alert('Message','Select Account','warning');   
		 		 return 0;
		 	 }
	       
	     var groupno=document.getElementById("txtgroupno").value;
		 var issue_ret=document.getElementById("issue_ret").value;
		 var issue_to=document.getElementById("txtisssueto").value;
		 var userid=<%=session.getAttribute("USERID")%>;
		 var hidssetno=$('#hidfixmsrno').val();
		 var hidaccount=$('#hidaccount').val();
		 var issueddate=$('#issueddate').val();
			 
		  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savedata(groupno,issue_ret,issue_to,hidssetno,hidaccount,issueddate,userid);	
		     	}
			     });
		
		
		
	}
	function savedata(groupno,issue_ret,issue_to,hiassetno,hidaccount,issueddate,userid)
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
	     			
				var items=x.responseText;
				 if(items==1){
				 /* document.getElementById("txtdocname").value="";
				 document.getElementById("txtdesc").value="";
				 document.getElementById("txtnote").value=""; */
				
				 
				  
				  $.messager.alert('Message', '  Record Successfully Saved', function(r){
					 $("#overlaysub, #PleaseWaitsub").show();
					  
			 		 
				     
			     });
				funreload(event); 
				 fundisable();
				 }
				}
		}
			
	x.open("GET","savedata.jsp?groupno="+groupno+"&issue_ret="+issue_ret+"&issue_to="+issue_to+"&hiassetno="+hiassetno+"&hidaccount="+hidaccount+"&issueddate="+issueddate+"&userid="+userid,true);

	x.send();
			
	}

	</script>
</head>
<body >
<form id="frmFAIssue" action="frmFAIssue" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

  <tr>
     <tr><td align="right"><label class="branch">Issue/Return</label></td>
     <td align="left"><select id="issue_ret" name="issue_ret"  value='<s:property value="issue_ret"/>' onchange="getclr(event);">
     <option value="issue">Issue</option><option value="ret">Return</option>
     </select></td></tr>
      
  	<tr><td align="right"><label class="branch">Group</label></td> 
	<td align="left"><input type="text" id="txtgroup" name="txtgroup" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtgroup"/>' onkeydown="getGroup(event);"/>
		             <input type="hidden" id="txtgroupno" name="txtgroupno" style="width:60%;height:20px;" value='<s:property value="txtgroupno"/>'/></td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
  	<tr><td align="right"><label class="branch">Issue To</label></td>
     <td align="left"><select id="txtisssueto" name="txtisssueto"  value='<s:property value="txtisssueto"/>' onchange="getAccountClear(event);">
    <option value="emp">Employee</option><option value="amc">AMC</option><option value="sjob">SJOB</option>
     </select></td></tr>
    <tr>
	 <td align="right"><label class="branch">Date</label></td>
     <td align="left"><div id="issueddate" name="issueddate" value='<s:property value="issueddate"/>'></div></td></tr> 
	<tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccount" name="txtaccount" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtasset"/>'onkeydown="getAccount(event);"/>
		 <input type="hidden" id="hidaccount" name="hidaccount" style="width:60%;height:20px;" value='<s:property value="hidaccount"/>'/></td></tr>
 
    
 <%--   <tr><td align="right"><label class="branch">Asset</label></td> 
	<td align="left"><input type="text" id="txtasset" name="txtasset" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtasset"/>' onkeydown="getAsset(event);"/>
		 <input type="text" id="hiassetno" name="hiassetno" style="width:60%;height:20px;" value='<s:property value="hiassetno"/>'/></td></tr> --%>
		<tr><td  align="center" colspan="2"><input type="Button" name="save" id="save" class="myButton" value="save" onclick="funsave()"></td> </tr>
	<tr>
	<td colspan="2">&nbsp;
	<br><br><br><br><br><br>
	</td>
	</tr>	
	 <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	  <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	   <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td>
 <div id="faIssue"><jsp:include page="fixedAssetIssueGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="hidissustatus" id="hidissustatus" value='<s:property value="hidissustatus"/>'>
			  <input type="hidden" name="hidfixmsrno" id="hidfixmsrno" value='<s:property value="hidfixmsrno"/>'>
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="assetDetailsWindow">
	<div></div><div></div>
</div>
<div id="groupDetailsWindow">
	<div></div><div></div>
</div>
</div>
</form>
</body>
</html>