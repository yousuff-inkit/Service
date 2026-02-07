<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>

<script type="text/javascript">


$(document).ready(function () { 
    
    $("#nipurchaserequestdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $('#btnPrint').attr('disabled', true );
});   
    

function funReadOnly(){
	$('#frmNipurchaseRequest input').attr('readonly', true );
	$('#frmNipurchaseRequest select').attr('disabled', true );
	$('#nipurchaserequestdate').jqxDateTimeInput({ disabled: true});
	$("#descdetailsGrid").jqxGrid({ disabled: true});
	
	$('#productSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
    $('#productSearchwindow').jqxWindow('close');

}

function funRemoveReadOnly(){
	$('#frmNipurchaseRequest input').attr('readonly', false );
	$('#frmNipurchaseRequest select').attr('disabled', false );
     
    $('#nipurchaserequestdate').jqxDateTimeInput({ disabled: false});
	 
	$('#docno').attr('readonly', true);
	$("#descdetailsGrid").jqxGrid({ disabled: false});

	
	if ($("#mode").val() == "A") {
		$('#nipurchaserequestdate').val(new Date());
    	$("#descdetailsGrid").jqxGrid('clear');
		$("#descdetailsGrid").jqxGrid('addrow', null, {});
		$('#txtproducttype').attr('disabled', true);
			  document.getElementById("validates").value=0;
	}
	
	if($('#mode').val()=='E'){
	   $("#descdetailsGrid").jqxGrid('addrow', null, {});
	}
	
}

function funFocus(){
   	$('#nipurchaserequestdate').jqxDateTimeInput('focus'); 	    		
}

function funNotify(){	

	 var rows = $("#descdetailsGrid").jqxGrid('getrows');
	 $('#descgridlenght').val(rows.length);
  	 for(var i=0 ; i < rows.length ; i++){
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "desctest"+i)
	       .attr("name", "desctest"+i)
	       .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].description+" :: "+rows[i].qty+" :: ");
	
	   newTextBox.appendTo('form');
	  
	 }   
	
	return 1;
} 

function funChkButton() {

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}

function setValues() {
	if($('#hidnipurchaserequestdate').val()){
		$("#nipurchaserequestdate").jqxDateTimeInput('val', $('#hidnipurchaserequestdate').val());
	}
	
	var masterdoc_no=document.getElementById("masterdoc_no").value;
	if(parseInt(masterdoc_no)>0){   
	 	$("#descdetail").load('descgridDetails.jsp?nipurdoc='+masterdoc_no);
	 	funchkforedit(); 
	} 

	if($('#msg').val()!=""){
	    $.messager.alert('Message',$('#msg').val());
	} 
		
    combochange();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
} 
		
function funPrintBtn(){
   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") { 	  
	 	var url=document.URL;
        var reurl=url.split("saveActionNipurRequest");        
	    $("#docno").prop("disabled", false);                
	    var brhid=<%= session.getAttribute("BRANCHID").toString()%>
	  	var dtype=$('#formdetailcode').val();
		var win= window.open(reurl[0]+"printNiPurchaeRequest?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
		win.focus(); 
	} else {
		$.messager.alert('Message','Select a Document....!','warning');
			return false;
		}
}

function getproductdetails(event){
 	if($('#mode').val()!= "view"){
	 	 $('#productSearchwindow').jqxWindow('open');
	 	 productSearchContent('productSearchGrid.jsp');  
	 } 
}  
 	 
function productSearchContent(url) {
    $.get(url).done(function (data) {
     	$('#productSearchwindow').jqxWindow('setContent', data);
	}); 
}

function funchkforedit(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0){
				 $("#btnEdit").attr('disabled', true );
				 $("#btnDelete").attr('disabled', true ); 
			}else{
				 $("#btnEdit").attr('disabled', false);
				 $("#btnDelete").attr('disabled', false);
			}
		} 
	}
	x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
	x.send();    

}
		
</script>
</head>
<body onLoad="setValues();">


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNipurchaseRequest" action="saveActionNipurRequest" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<fieldset>
<table width="100%">
  <tr>
    <td width="4.8%" align="right">Date</td> 
    <td width="8%" align="left"><div id="nipurchaserequestdate" name="nipurchaserequestdate" value='<s:property value="nipurchaserequestdate"/>'></div>
    <input type="hidden" name="hidnipurchaserequestdate" id="hidnipurchaserequestdate" value='<s:property value="hidnipurchaserequestdate"/>'>
    </td>
    <td align="left"></td>
    <td width="5%" align="right">Doc No</td>
    <td width="13%" align="left"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly"></td>
	<td align="right" width="20.8%" ></td>
  </tr>
</table>

 <table width="100%">
  <tr>
  <td align="right"  width="4.7%">Requested By</td>
    <td colspan="4"  width="94%" align="left"><input type="text" name="requestedby" id="requestedby" value='<s:property value="requestedby"/>' style="width:30%;"></td>
    </tr>
    <tr>
    <td align="right"  width="4.7%">Remark</td>
    <td colspan="4"  width="94%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:73%;"></td></tr>
</table>

</fieldset>
 <br>
 
 <fieldset>
 
    <div id="descdetail" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>
     
</fieldset>

<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
<input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
<input type="hidden" id="validates" name="validates"  value='<s:property value="validates"/>'/>   
<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>

</form>

<div id="productSearchwindow">
	<div></div>
</div>

</div>
</body>
</html>