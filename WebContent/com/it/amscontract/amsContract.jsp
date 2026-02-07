<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>

<%

String mod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();

String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname").toString();
String clientdet = request.getParameter("clientdet")==null?"0":request.getParameter("clientdet").toString();
String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
String refno = request.getParameter("refno")==null?"0":request.getParameter("refno").toString();
String enqdocno = request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").toString();
String curid = request.getParameter("curid")==null?"0":request.getParameter("curid").toString();
String address = request.getParameter("address")==null?"0":request.getParameter("address").toString();
String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile").toString();
String contactperson = request.getParameter("contactperson")==null?"0":request.getParameter("contactperson").toString();
String cptrno = request.getParameter("cptrno")==null?"0":request.getParameter("cptrno").toString();
String telno = request.getParameter("telno")==null?"0":request.getParameter("telno").toString();
String email = request.getParameter("email")==null?"0":request.getParameter("email").toString();
String salesman = request.getParameter("salesman")==null?"0":request.getParameter("salesman").toString();
String salesmandocno = request.getParameter("salesmandocno")==null?"0":request.getParameter("salesmandocno").toString();
String enqtype = request.getParameter("enqtype")==null?"0":request.getParameter("enqtype").toString();
String cmbreftype = request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype").toString();
String noofmonths = request.getParameter("noofmonths")==null?"0":request.getParameter("noofmonths").toString();
String amount = request.getParameter("amount")==null?"0":request.getParameter("amount").toString();
String billfrequency = request.getParameter("billfrequency")==null?"0":request.getParameter("billfrequency").toString();
String extrahrsrate = request.getParameter("extrahrsrate")==null?"0":request.getParameter("extrahrsrate").toString();
String supporthrs = request.getParameter("supporthrs")==null?"0":request.getParameter("supporthrs").toString();
String carryforwards = request.getParameter("carryforwards")==null?"0":request.getParameter("carryforwards").toString();
String cfmaxper = request.getParameter("cfmaxper")==null?"0":request.getParameter("cfmaxper").toString();
String cfminper = request.getParameter("cfminper")==null?"0":request.getParameter("cfminper").toString();
String taxper = request.getParameter("taxper")==null?"0":request.getParameter("taxper").toString();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String partnerclient = request.getParameter("partnerclient")==null?"0":request.getParameter("partnerclient").toString();

System.out.println("docno==="+docno);

%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">

	var mod1='<%=mod%>';
	
	$(document).ready(function() {
				
		 $("#jqxIenqDate").jqxDateTimeInput({ width: '100px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxIfrmDate").jqxDateTimeInput({ width: '100px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxItoDate").jqxDateTimeInput({ width: '100px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#clientinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Client Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
   	     $('#clientinfowindow').jqxWindow('close');
   	     
   	     $('#cpinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#cpinfowindow').jqxWindow('close');
		    
 		 $('#salesManDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#salesManDetailsWindow').jqxWindow('close');
		
		 $('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#enquirywindow').jqxWindow('close'); 
		
	     $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 	 $('#areainfowindow').jqxWindow('close');
	 	$('#serviceteamwindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Team Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#serviceteamwindow').jqxWindow('close');
	
 		 $("#jqxcontractDetails").jqxGrid({ disabled: true});

 		 $('#jqxIenqDate').on('change', function (event) {   
 			  getTaxper(); 
 		 });
 		 
 		 $('#txtclientname').dblclick(function(){
 		      clientSearchContent('clientINgridsearch.jsp');
		 });
        
		$('#txtcontactperson').dblclick(function(){
  		   var clientid=document.getElementById("clientid").value;
  		   if(clientid==""){
  			  document.getElementById("errormsg").innerText="Client is Mandatory.";
  			  if (document.getElementById("txtcontactperson").value == "") {
		        $('#txtcontactperson').attr('placeholder', 'Press F3 to Search'); 
		      }
  			  return 0;
  		   }
  		   document.getElementById("errormsg").innerText=" ";
  	       cpSearchContent('contactPersonDetailsSearch.jsp?clientdocno='+clientid);  
		});
  	  
		$('#txtsalesman').dblclick(function(){
  	  	  salesmanSearchContent('salesManDetailsSearch.jsp'); 
  	    });
		
		$('#txtrefno').dblclick(function(){
 			var clientid=document.getElementById("clientid").value;
 			var reftype=document.getElementById("cmbreftype").value;
 			
 		 	if(clientid>0 || reftype=='ENQ'){
 		 		document.getElementById("errormsg").innerText="";
 		 	}else{
 		 		document.getElementById("errormsg").innerText="Select a client";
 		 		return 0;
 		 	} 
 	 		 
 	 		if($('#mode').val()!= "view"){
 	 		 	changeContent('enqMastersearch.jsp'); 
 	   		}
		});
	   
	    getCurrencyIds($("#jqxIenqDate").val());
    });
	 	 
	function strToDate(dateStr) {
		  var parts = dateStr.split(".")
		  return new Date(parts[2], parts[1] - 1, parts[0])
	}
	
	function clientSearchContent(url) {
	    $('#clientinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#clientinfowindow').jqxWindow('setContent', data);
			$('#clientinfowindow').jqxWindow('bringToFront');
		}); 
	}
	
	function cpSearchContent(url) {
	    $('#cpinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#cpinfowindow').jqxWindow('setContent', data);
			$('#cpinfowindow').jqxWindow('bringToFront');
		}); 
	}
	
	function getEnquiry(event){
	 	var clientid=document.getElementById("clientid").value;
	 	var reftype=document.getElementById("cmbreftype").value;

		 if(clientid>0 || reftype=='ENQ'){
		 	document.getElementById("errormsg").innerText="";
		 }
		 else{
		 	document.getElementById("errormsg").innerText="Select a client";
		 	return 0;
		 } 

		var x= event.keyCode;
		if(x==114){
			changeContent('enqMastersearch.jsp');  	
		}		 	 
	}
			    	 
	function enquirySearchContent(url) {
		$.get(url).done(function (data) {
			$('#enquirywindow').jqxWindow('setContent', data);
		}); 
	}
	function getserviceteam(rowBoundIndex){
		 
		  $('#serviceteamwindow').jqxWindow('open');

	//$('#accountWindow').jqxWindow('focus');
	    serviceteamContent('serviceteam.jsp?rowBoundIndex='+rowBoundIndex);
	 	 }
	 	 
	function serviceteamContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#serviceteamwindow').jqxWindow('setContent', data);

	        	}); 
		}
	function funReadOnly(){
		$('#frmAmsContract input').attr('readonly', true );
		$('#frmAmsContract textarea').attr('readonly', true );
		$('#cmbcurr').attr('disabled', true);
		$('#txtclientname').attr('disabled', true);
		$('#txtcontactperson').attr('disabled', true);
		$('#txtremarks').attr('readonly', false );
		$('#jqxIenqDate').jqxDateTimeInput({disabled: true});
		$('#jqxIfrmDate').jqxDateTimeInput({disabled: true});
		$('#jqxItoDate').jqxDateTimeInput({disabled: true});

		if(mod1=="A"){
			document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			funCreateBtn();
		}
	}
		
	function funRemoveReadOnly(){
		
		$('#frmAmsContract input').attr('readonly', false );
		$('#frmAmsContract select').attr('disabled', false);
		$('#frmAmsContract textarea').attr('readonly', false );
		
		$('#cmbcurr').attr('disabled', false);
		$('#txtclientname').attr('disabled', false);
		$('#txtcontactperson').attr('disabled', false);
		$('#txtclientname').attr('readonly', true );
		$('#jqxIenqDate').jqxDateTimeInput({disabled: false});
		$('#jqxIfrmDate').jqxDateTimeInput({disabled: false});
		$('#jqxItoDate').jqxDateTimeInput({disabled: false});
		
		refChange();
		carryforwardsChange();
		
		$('#docno').attr('readonly', true);
		$('#txtenqtype').attr('readonly', true);
		
		$("#jqxcontractDetails").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
			//getCurrencyIds($("#jqxIenqDate").val());
			$('#jqxIenqDate').val(new Date());
			$('#jqxIfrmDate').val(new Date());
			$('#jqxItoDate').val(new Date());
			$("#jqxcontractDetails").jqxGrid('clear');
			$("#jqxcontractDetails").jqxGrid('addrow', null, {});
			
			if(mod1=="A"){
				document.getElementById("txtclientname").value= '<%=clientname%>';
		        document.getElementById("txtclientdet").value= '<%=clientdet%>';
		        document.getElementById("clientid").value= '<%=clientid%>';		        
		        document.getElementById("txtrefno").value= '<%=refno%>';
		        document.getElementById("txtaddress").value= '<%=address%>';
		        document.getElementById("txtmobile").value= '<%=mobile%>';
		        document.getElementById("txtcontactperson").value= '<%=contactperson%>';
		        document.getElementById("cptrno").value= '<%=cptrno%>';		        
		        document.getElementById("txttelno").value= '<%=telno%>';
			    document.getElementById("txtemail").value= '<%=email%>';
		        document.getElementById("txtsalesman").value= '<%=salesman%>';
		        document.getElementById("txtsalesmandocno").value= '<%=salesmandocno%>';
		        document.getElementById("txtenqtype").value= '<%=enqtype%>';
				document.getElementById("cmbreftype").value= '<%=cmbreftype%>';
				document.getElementById("clientcurid").value= '<%=curid%>';
				document.getElementById("txtnoofmonths").value= '<%=noofmonths%>';
				document.getElementById("txtamount").value= '<%=amount%>';
				document.getElementById("cmbbillfrequency").value= '<%=billfrequency%>';
				document.getElementById("txtextrahrsrate").value= '<%=extrahrsrate%>';
				document.getElementById("txtsupporthrs").value= '<%=supporthrs%>';
				document.getElementById("cmbcarryforwards").value= '<%=carryforwards%>';
				document.getElementById("txtcfmaxper").value= '<%=cfmaxper%>';
				document.getElementById("txtcfminper").value= '<%=cfminper%>';
				document.getElementById("txttaxper").value= '<%=taxper%>';
				document.getElementById("txtpartnerclient").value= '<%=partnerclient%>';
				$("#contractDiv").load('amsContractGrid.jsp?docno='+'<%=docno%>');
				refChange();
			}
		}
	}

	function funSearchLoad(){
		changeContent('masterSearch.jsp'); 
	 }
		
	function funChkButton() {
			/* funReset(); */
	}
	 
	function funFocus(){
	    	$('#jqxIenqDate').jqxDateTimeInput('focus'); 	    		
	}
	 
	function funNotify(){
		
		var valid1=document.getElementById("txtclientname").value;
		 var msgid=0;

		if(valid1=="")
			{
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}
		
		var rowssitegrid = $("#jqxcontractDetails").jqxGrid('getrows');
	    $('#gridlength').val(rowssitegrid.length);
	  
	   for(var i=0 ; i < rowssitegrid.length ; i++){
		  
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "sitetest"+i)
	       .attr("name", "sitetest"+i)
	       .attr("hidden", "true"); 
	    
	    if($('#jqxcontractDetails').jqxGrid('iscolumnvisible', 'serviceteam'))
		 {
	    if((rowssitegrid[i].site!="undefined" && rowssitegrid[i].site!=null && rowssitegrid[i].site!="" ))
   	{
   	if(rowssitegrid[i].steamid=="undefined" || rowssitegrid[i].steamid==null || rowssitegrid[i].steamid=="")
   		{
   	msgid++;
   	break;
   		}
   	}
}
	    
	    if(rowssitegrid[i].site!="")
		{
	   		newTextBox.val(rowssitegrid[i].site+" :: "+rowssitegrid[i].remarks+" :: "+rowssitegrid[i].areaid+" :: "+rowssitegrid[i].surid+" :: "+rowssitegrid[i].steamid+" :: ");
		}
	   newTextBox.appendTo('form');
			   
	   }   
	   if($('#jqxcontractDetails').jqxGrid('iscolumnvisible', 'serviceteam'))
		 {

if(msgid>0)
{
document.getElementById("errormsg").innerText="Service Team Is Mandatory In Site Details";
	return 0;
}
else{
	 document.getElementById("errormsg").innerText="";
}
}
		return 1;
	}
	        
	function setValues() {
		var clientid=document.getElementById("clientid").value;
    	if(parseInt(clientid)==0){
    		 document.getElementById("custid").checked=true;
             $('#txtclientname').hide(); 
 		}
		
    	if(parseInt(clientid)>0){
    		 document.getElementById("custid").checked=false;
          	  $('#txtclientname').show();
    	}
    	
		if($('#hidjqxIenqDate').val()){
    		$("#jqxIenqDate").jqxDateTimeInput('val', strToDate($('#hidjqxIenqDate').val()));
    	}
    
	    if($('#hidjqxIfrmDate').val()){
    		$("#jqxIfrmDate").jqxDateTimeInput('val', strToDate($('#hidjqxIfrmDate').val()));
    	}
    	
		if($('#hidjqxItoDate').val()){
    		$("#jqxItoDate").jqxDateTimeInput('val', strToDate($('#hidjqxItoDate').val()));
    	}
		
		if($('#clientcurid').val()){
    		$("#cmbcurr").val($('#clientcurid').val());
    	}
		
		if($('#hidcmbreftype').val()){
    		$("#cmbreftype").val($('#hidcmbreftype').val());
    	}

		if($('#hidbillfrequency').val()){
    		$("#cmbbillfrequency").val($('#hidbillfrequency').val());
    	}
		
		if($('#hidcarryforwards').val()){
    		$("#cmbcarryforwards").val($('#hidcarryforwards').val());
    	}
		
    	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		}
 	  
 	    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 	    funSetlabel();
	  	   
	  	var maindoc=document.getElementById("masterdoc_no").value;
	  	if(maindoc>0) {
	   		$("#contractDiv").load('amsContractGrid.jsp?docno='+maindoc);
	  	}
	  	  
	}
	  
	function getclient(event){
        var x= event.keyCode;
        if(x==114){
        	clientSearchContent('clientINgridsearch.jsp');
        }
    }
	 
	function getcontactperson(event){
		var x= event.keyCode;
		if(x==114){
			var clientid=document.getElementById("clientid").value;
			if(clientid==""){
				document.getElementById("errormsg").innerText="Client is Mandatory.";
				if (document.getElementById("txtcontactperson").value == "") {
					$('#txtcontactperson').attr('placeholder', 'Press F3 to Search'); 
				}
				return 0;
			}
			document.getElementById("errormsg").innerText="";
			cpSearchContent('contactPersonDetailsSearch.jsp?clientdocno='+clientid);
		}
    }
	 
	function refChange(){
		var reftype=$('#cmbreftype').val();

		if(reftype=='DIR'){
			  $('#txtrefno').attr('disabled', true);
			  $('#txtclientname').attr('disabled', false);			  
		}else if(reftype=='ENQ'){
			  $('#txtrefno').attr('disabled', false);
			  $('#txtrefno').attr('readonly', true);
			  $('#txtclientname').attr('disabled', true);	
		}
	}
	 
	function getdesig(rowBoundIndex){
		desigSearchContent('designationSearch.jsp?rowBoundIndex='+rowBoundIndex);
	}
	 
	function setChange(){
		var chkval=0;
		chkval=$('#custid').val();
		if(parseInt(chkval)==1){
			$('#txtclientname').hide();
			document.getElementById('txtclientdet').readOnly =false;
			document.getElementById('txtcontactperson').removeAttribute('placeholder');
			document.getElementById("clientid").value="0";
		}else{
			$('#txtclientname').show();
			document.getElementById("txtcontactperson").setAttribute("placeholder","Press F3 To Search");
		}
	}
		
	function getsalinfo(event){
	    var x= event.keyCode;
	    if(x==114){
	    	salesmanSearchContent('salesManDetailsSearch.jsp');
	    }
	}
		
	function salesmanSearchContent(url) {
	   	$('#salesManDetailsWindow').jqxWindow('open');
	   	$.get(url).done(function (data) {
	   		$('#salesManDetailsWindow').jqxWindow('setContent', data);
	   		$('#salesManDetailsWindow').jqxWindow('bringToFront');
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
	
	function getCurrencyIds(a){  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
		    items= x.responseText;
		    items=items.split('####');
		    var curidItems=items[0];
		    var curcodeItems=items[1];
		    var currateItems=items[2];
		    var multiItems=items[3];
		    var optionscurr = '';
		          
		    if(curcodeItems.indexOf(",")>=0){
		        var currencyid=curidItems.split(",");
		        var currencycode=curcodeItems.split(",");
		        multiItems.split(",");
		         
		        for ( var i = 0; i < currencycode.length; i++) {
					optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		        }
		        
		        $("select#cmbcurr").html(optionscurr);
		           
		        if ($('#clientcurid').val() != null && $('#clientcurid').val() != "") {
					$('#cmbcurr').val($('#clientcurid').val()) ;
					funrate();
		        } 
		       	
		       	if(document.getElementById("docno").value=="") {
					funRoundRate(currateItems,"clientcurrate");
					funCalculateClientRate(null);
		       	}					        	          
		    }else{
		         optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
		          
		        $("select#cmbcurr").html(optionscurr);
		          
		        if ($('#clientcurid').val() != null && $('#clientcurid').val() != "") {
					$('#cmbcurr').val($('#clientcurid').val()) ;
					funrate();
		        } 
				
		        if(document.getElementById("docno").value==""){  
					funRoundRate(currateItems,"clientcurrate");
					funCalculateClientRate(null);
		   		}
		    }
		}
		}
		x.open("GET", "getCurrencyId.jsp?date="+a,true);
		x.send();		        	      
	}				        
		
	function funrate() {      
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items= x.responseText;
				funRoundRate(items,"clientcurrate"); 
				funCalculateClientRate(null);	
			}
		}
		x.open("GET","getRateFrom.jsp?curr="+$('#cmbcurr').val(),true);  
		x.send();
	}
						
	function funCalculateClientRate(rowindex){
		var clientrate=$.isNumeric($("#clientcurrate").val())?parseFloat($("#clientcurrate").val()):0;
		if(rowindex!=null){
			
		}else{
			
		}
	}
	
	function funCalToDate(){
		var date=$('#jqxIfrmDate').val();
		var months=$("#txtnoofmonths").val();
		
		if(date!=null && date.trim()!='' && $.isNumeric(months)){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items= x.responseText;
				$('#jqxItoDate').val(strToDate(items));
			}
		}
		x.open("GET","getToDate.jsp?date="+date+"&months="+months,true);  
		x.send();
		}
	}
		
	function carryforwardsChange(){
		if($("#cmbcarryforwards").val()==='1'){
			$('#txtcfmaxper').attr('disabled', false );
			$('#txtcfminper').attr('disabled', false );
		}else{
			$('#txtcfmaxper').val(0);
			$('#txtcfminper').val(0);
			$('#txtcfmaxper').attr('disabled', true);
			$('#txtcfminper').attr('disabled', true);
		}
		
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
	
	function getTaxper(){
		var date=$('#jqxIenqDate').val();
		var cldocno=$("#clientid").val();
		
		if(!$.isNumeric(cldocno) || $('#mode').val()== "view"){
			return false
		}
		
		var x = new XMLHttpRequest();
	    x.onreadystatechange = function(){
	    	if (x.readyState == 4 && x.status == 200) {
		    	var items = x.responseText.trim();
		    	$('#txttaxper').val(items);
	    	}
	   }
	   x.open("GET", "getTaxper.jsp?date="+date+"&cldocno="+cldocno, true);
	   x.send();
	}
	function reqdata(){
		
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
<div id="mainBG" class="homeContent" data-type="background" >

<form id="frmAmsContract" action="saveamscontract" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset style="background-color: #ECF8E0;">
<table width="100%" >
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="2%"><div id="jqxIenqDate" style="width:40%;" name="jqxIenqDate" value='<s:property value="jqxIenqDate"/>'></div>
    <input type="hidden" id="hidjqxIenqDate" name="hidjqxIenqDate" value='<s:property value="hidjqxIenqDate"/>'/>
    
  	<td hidden="true"width="5%" align="right"> New Client<input type="checkbox" id="custid" name="custid" onchange="setChange();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /></td></td>

    <td colspan="3"></td>
    <td width="1%" align="right" colspan="2">Ref. No.</td>
    <td width="5%"><select id="cmbreftype" name="cmbreftype" style="width:70%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
<!--       <option value="DIR">DIR</option>
 -->   
    <option value="ENQ">ENQ</option>
      </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
    </td>
    <td width="4%"><input type="text" id="txtrefno" name="txtrefno"  onKeyDown="getEnquiry(event);" style="width:100%;"  value='<s:property value="txtrefno" />'/></td>
	<td width="1%" align="right">Type</td>
	<td width="4%"><input type="text" id="txtenqtype" name="txtenqtype" style="width:100%;" value='<s:property value="txtenqtype" />'/></td>
	
    <td width="5%" align="right" colspan="2">Doc No.</td>
    <td width="8%"><input type="text" id="docno" name="docno" readonly style="width:60%;" value='<s:property value="docno"/>' tabindex="-1"/>
    </td>
  </tr>
  
  <tr>
    <td align="right">Client</td></td>
    <td width="2%" ><input type="text" id="txtclientname" readonly placeholder="Press F3 to Search" name="txtclientname" style="width:90%;" onkeydown="getclient(event);"  value='<s:property value="txtclientname"/>'/>
    <td colspan="4" width="10%"><input type="text" id="txtclientdet"  name="txtclientdet" style="width:89%;" value='<s:property value="txtclientdet"/>'/>
    	<input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
    </td>
   
    <td width="1%" align="right">Address</td> 
    <td colspan="4" ><input type="text" id="txtaddress" name="txtaddress" style="width:100%;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();"></td>
	<td align="right">Curr</td>        
	<td align="left"><select name="cmbcurr" id="cmbcurr" style="width:100%;" value='<s:property value="cmbcurr"/>'  onchange="funrate();">  
	      <option value="-1" >--Select--</option>
	    </select>  
		<input type="hidden" id="clientcurid" name="clientcurid"  value='<s:property value="clientcurid"/>'/>    
	</td>   
	
	<td width="5%">Rate &nbsp; <input type="text" style="width:48%;text-align: right;"  name="clientcurrate" id="clientcurrate" onchange="funCalculateClientRate(null);" value='<s:property value="clientcurrate"/>'></td>
  </tr>
  
  <tr>
    <td align="right">Contact Person</td>
    <td colspan="5" width="10%"><input type="text" id="txtcontactperson" name="txtcontactperson"  placeholder="Press F3 to Search" style="width:92%;" onKeyDown="getcontactperson(event);" value='<s:property value="txtcontactperson"/>'/>
    	<input type="hidden" id="cptrno" name="cptrno"  value='<s:property value="cptrno"/>'/></td>
    
    <td width="1%" align="right">Salesman</td>
   	<td  colspan="4"><input type="text" id="txtsalesman" name="txtsalesman" style="width:100%;" placeholder="Press F3 To Search" value='<s:property value="txtsalesman"/>' onKeyDown="getsalinfo(event);" onfocus="disfields();">
   		<input type="hidden" id="txtsalesmandocno" name="txtsalesmandocno" value='<s:property value="txtsalesmandocno"/>'></td>
    <td align="right" width="1%" colspan="2">MOB</td>
    <td  width="6%"><input type="text" id="txtmobile" name="txtmobile" style="width:60%;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();">
  </tr>
  
  <tr>
    <td align="right">Partner Client</td>
    <td colspan="5" width="10%"><input type="text" id="txtpartnerclient" name="txtpartnerclient" style="width:92%;" value='<s:property value="txtpartnerclient"/>'/></td>
    
    <td width="1%" align=right >Email</td>
    <td colspan="4"><input type="text" id="txtemail" name="txtemail" style="width: 100%;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();"></td>
    <td align="right" width="1%" colspan="2">Tel</td>
    <td  width="6%"><input type="text" id="txttelno" name="txttelno" style="width: 60%;" value='<s:property value="txttelno"/>' onfocus="reqdata();disfields();"></td>
 </tr>
  
  <tr>
   	<td width="3%" align="right">From</td>
    <td width="2%"><div id="jqxIfrmDate" style="width:40%;" name="jqxIfrmDate"  onchange="funCalToDate();" value='<s:property value="jqxIfrmDate"/>'></div>
    	<input type="hidden" id="hidjqxIfrmDate" name="hidjqxIfrmDate" value='<s:property value="hidjqxIfrmDate"/>'/>
    </td>
    
    <td width="3%" align="right">No of Months</td>
    <td width="2%"><input type="text" id="txtnoofmonths" name="txtnoofmonths" style="width:100%"  onblur="funCalToDate();" value='<s:property value="txtnoofmonths"/>'/>
    </td>
    
    <td width="3%" align="right">To</td>
    <td><div id="jqxItoDate" style="width:40%;" name="jqxItoDate" value='<s:property value="jqxItoDate"/>'></div>
    	<input type="hidden" id="hidjqxItoDate" name="hidjqxItoDate" value='<s:property value="hidjqxItoDate"/>'/> 
    </td>
    
    <td width="1%" align="right" >Amount/Month</td>
    <td width="1%"><input type="text" id="txtamount" name="txtamount" style="width: 80%;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamount"/>'></td>
    
    <td width="1%" align="right">Billing Frequency</td>
    <td width="1%"  colspan="2"><select id="cmbbillfrequency" name="cmbbillfrequency" style="width:100%;" value='<s:property value="cmbbillfrequency"/>'>
      <option value="1">Monthly</option><option value="2">Quarterly</option>
      </select>
      <input type="hidden" id="hidbillfrequency" name="hidbillfrequency" value='<s:property value="hidbillfrequency"/>'/>
      </td>
    
    <td width="1%" colspan="2" align="right">Extra Hrs Rate</td>
    <td width="1%" colspan="2"><input type="text" id="txtextrahrsrate" name="txtextrahrsrate" style="width: 60%;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtextrahrsrate"/>'></td>
 </tr>
 
 <tr>
    <td width="3%" align="right">Support Hrs/Month</td>
    <td width="2%"><input type="text" id="txtsupporthrs" name="txtsupporthrs" style="width:60%;text-align: right;" value='<s:property value="txtsupporthrs"/>'/>
    </td>
    
    <td width="1%" align="right">Carry Forwards</td>
    <td width="1%"  colspan="2"><select id="cmbcarryforwards" name="cmbcarryforwards" style="width:100%;" onchange="carryforwardsChange();" value='<s:property value="cmbcarryforwards"/>'>
      <option value="1">Yes</option><option value="0">No</option>
      </select>
      <input type="hidden" id="hidcarryforwards" name="hidcarryforwards" value='<s:property value="hidcarryforwards"/>'/>
     </td>
      
    <td width="1%" align="right" colspan="2">CF Max %</td>
    <td width="1%"><input type="text" id="txtcfmaxper" name="txtcfmaxper" style="width: 80%;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtcfmaxper"/>'></td>
    
    
    <td width="1%" align="right">CF Min %</td>
    <td width="1%" colspan="2"><input type="text" id="txtcfminper" name="txtcfminper" style="width: 100%;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtcfminper"/>'></td>
 
    <td width="1%" colspan="2" align="right">Tax Per</td>
    <td width="1%" colspan="2"><input type="text" id="txttaxper" name="txttaxper" style="width: 60%;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txttaxper"/>'></td>
 </tr>
  
</table>
</fieldset>


<fieldset style="background: #F6FFE1;"><legend>Site Details</legend>
<div id="contractDiv"><jsp:include page="amsContractGrid.jsp"></jsp:include></div>
</fieldset>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
<input type="hidden" id="enquiryid" name="enquiryid" value='<s:property value="enquiryid"/>'/>

</div>
</form>

<div id="clientinfowindow">
   <div></div>
</div>
   
<div id="cpinfowindow">
   <div></div>
</div>

<div id="salesManDetailsWindow">
   <div ></div>
</div>

<div id="enquirywindow">
   <div ></div>
</div>

<div id="areainfowindow">
   <div ></div>
</div>
 <div id="serviceteamwindow">
   <div ></div>
   </div>
</div>
</body>
</html>