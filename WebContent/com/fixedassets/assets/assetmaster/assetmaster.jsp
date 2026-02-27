<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>GatewayERP(i)</title>
	
	 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>

html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    overflow-y: auto;
    font-family: 'Segoe UI', sans-serif;
    background: #eef1f5;
    color: #2d3748;
}

body::-webkit-scrollbar {
    width: 8px;
}

body::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 10px;
}

body::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}


#mainBG {
    background: #ffffff;
    border-radius: 14px;
    padding: 18px 25px 25px 25px;
    margin: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.06);
}

#mainBG > br {
    display: none;
}


.page-title {
    font-size: 22px;
    font-weight: 600;
    margin: 10px 0 15px 0; 
    color: #2d3748;
}


.toolbar {
    display: flex;
    gap: 10px;
    margin-bottom: 18px;
}

.toolbar button {
    background: #f1f3f6;
    border: none;
    padding: 7px 16px;
    border-radius: 20px;
    font-size: 13px;
    cursor: pointer;
    transition: 0.2s ease;
}

.toolbar button:hover {
    background: #e2e6ea;
}

.section-card {
    background: #f5f7fa;
    border-radius: 14px;
    padding: 18px;
    margin-bottom: 20px;
}

.section-title {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 18px;
    padding-left: 10px;
    border-left: 4px solid #1e88e5;
    color: #2d3748;
}


.two-column {
    display: flex;
    gap: 20px;
}

.section-half {
    flex: 1;
}


.form-row {
    display: grid;
    grid-template-columns: 140px 1fr 140px 1fr;
    gap: 15px;
    margin-bottom: 14px;
    align-items: center;
}

.form-row.single {
    grid-template-columns: 140px 1fr;
}

input[type="text"],
select {
    height: 34px;
    border: 1px solid #d8dee9;
    border-radius: 8px;
    padding: 6px 12px;
    background: #ffffff;
    font-size: 14px;
    box-sizing: border-box;
    transition: 0.2s ease;
}

input[type="text"]:focus,
select:focus {
    border-color: #1e88e5;
    outline: none;
    box-shadow: 0 0 0 2px rgba(30,136,229,0.15);
}

label {
    font-weight: 600;
    font-size: 13px;
    color: #4a5568;
}



.table-section {
    margin-top: 25px;
}

.table-title {
    font-weight: 600;
    margin-bottom: 10px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e3e8ef;
}

.cr-table th {
    background: #f1f3f6;
    padding: 10px;
    font-size: 13px;
    text-align: left;
    font-weight: 600;
}

.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #edf2f7;
    font-size: 13px;
}

.cr-table tr:last-child td {
    border-bottom: none;
}


input[type="checkbox"] {
    transform: scale(1.05);
    margin-right: 6px;
}



@media (max-width: 1024px) {

    .two-column {
        flex-direction: column;
    }

    .form-row {
        grid-template-columns: 140px 1fr;
    }

}
</style>
</head>

<script type="text/javascript">

$(document).ready(function () {
	 //alert(document.getElementById("deleted").value);
  	 $("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
  	 $("#purchasedate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});  
  	 
	 $("#warexpdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});  

	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountDetailsWindow').jqxWindow('close');
	 
	 $('#fixaccountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#fixaccountDetailsWindow').jqxWindow('close');
	 
	// $("#btnEdit").attr('disabled', true );
	 
	    $('#supplieraccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#accountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp');
		          }
	  }); 
	    
	    $('#masterdate').on('change', function (event) {
	  	  
	        var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	      	 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
	        funDateInPeriod(maindate);
	      	 }
	       });
	    
	    $('#fixedassetaccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		        
		  	    $('#fixaccountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent1('depaccountsDetailsSearch.jsp?value='+1);
		          }
	  }); 
	    $('#accdepraccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#fixaccountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent1('depaccountsDetailsSearch.jsp?value='+2);
		          }
	  }); 
	    $('#depraccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#fixaccountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent1('depaccountsDetailsSearch.jsp?value='+3);
		          }
	  }); 
	 
		  $('#purchasedate').on('change', function (event) {
		      	 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
			   var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));     // out date
			  var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate')); //del date
			  
			   if(purchsedate>masterdate){
			   document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
			   $('#purchasedate').jqxDateTimeInput('focus'); 
			   return false;
			  }   
			
			   else{
			  
			   document.getElementById("errormsg").innerText="";  
			   }
			  }
		
		       });
  	 
});


function getaccountdetails1(value){
	
	  if($('#mode').val()=="A" || $('#mode').val()=="E" )
    {
	 var x= event.keyCode;
	 if(x==114){
	  $('#fixaccountDetailsWindow').jqxWindow('open');
	
	 accountSearchContent1('depaccountsDetailsSearch.jsp?value='+value);    }
	 else{
		 }
    }
	 }  
	 
	 
function getaccountdetails(event){
	
	  if($('#mode').val()=="A" || $('#mode').val()=="E" )
  {
	 var x= event.keyCode;
	 if(x==114){
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 accountSearchContent('accountsDetailsSearch.jsp');    }
	 else{
		 }
  }
	 }  
	 
	 
function accountSearchContent1(url) {

    $.get(url).done(function (data) {

  $('#fixaccountDetailsWindow').jqxWindow('setContent', data);

	}); 
	}
	 
function accountSearchContent(url) {

       $.get(url).done(function (data) {

     $('#accountDetailsWindow').jqxWindow('setContent', data);

	}); 
 	}

function funReset(){


}


function funReadOnly(){ 	 
	
	 
	$('#frmassetmastrer input').attr('readonly',true);   
	$('#frmassetmastrer select').attr('disabled',true);  
	$('#warexpdate').jqxDateTimeInput({ disabled: true});
	$('#masterdate').jqxDateTimeInput({ disabled: true});
	$('#purchasedate').jqxDateTimeInput({ disabled: true});
	$('#subgriddis').attr('disabled',true); 
	$('#opening').attr('disabled',true); 
	
	//subgriddis opening
	
}
function funRemoveReadOnly(){
	$('#frmassetmastrer input').attr('readonly',false);  
	$('#frmassetmastrer select').attr('disabled',false); 
	$('#subgriddis').attr('disabled',false); 
	$('#opening').attr('disabled',false); 
	$('#accumdepr').attr('disabled',true); 
	$('#docno').attr('readonly',true);  
	$('#warexpdate').jqxDateTimeInput({ disabled: false});
	$('#masterdate').jqxDateTimeInput({ disabled: false});
	$('#purchasedate').jqxDateTimeInput({ disabled: false});
	
	$('#fixedassetaccId').attr('readonly',true);  
	$('#accdepraccId').attr('readonly',true);  
	$('#depraccId').attr('readonly',true);  
	
	$('#fixedassetaccName').attr('readonly',true);  
	$('#accdepraccIdName').attr('readonly',true);  
	$('#accdepraccIdName').attr('readonly',true); 
	 // accdepraccId depraccId
	
	 $('#supplieraccId').attr('readonly',true);  
	 $('#supplieraccName').attr('readonly',true);  
	   
	
	if ($("#mode").val() == "A") {
		
		
		$('#subdetail').hide();
		$('#freespace').show();
		$('#accumdepr').attr('disabled',true); 
		
		
		 $('#warexpdate').val(new Date());
		 $('#masterdate').val(new Date());
		 $('#purchasedate').val(new Date());
	     $("#jqxsubdetails").jqxGrid('clear');
	    $("#jqxsubdetails").jqxGrid('addrow', null, {});
	    $("#jqxsubdetails").jqxGrid('addrow', null, {});
	    $("#jqxsubdetails").jqxGrid('addrow', null, {});
	    
		document.getElementById("masteredit").value="";
	   }
	
	
	if($('#mode').val()=='E')
	{
				if(document.getElementById("openingval").value==1)
				{
				document.getElementById("opening").checked =true;
				$('#accumdepr').attr('disabled',false); 
				$('#accumdepr').attr('readonly',false);
					
				
				}
			else
				{
				document.getElementById("opening").checked =false;
				$('#accumdepr').attr('disabled',true); 
				
				}
				
				var rows = $('#jqxsubdetails').jqxGrid('getrows');
		         var rowlength= rows.length;
		         if (rowlength == 0) {
		             
		             $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		             $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		             $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		             }	
		         else
		        	 {
		        	 $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		        	 }
				
			funchkforedit(document.getElementById("srno").value);	
				
				
				
	}
	
	
	if($('#mode').val()=='D')
		{
		
		$('#frmassetmastrer input').attr('readonly',false);  
		$('#frmassetmastrer select').attr('disabled',false); 
		$('#warexpdate').jqxDateTimeInput({ disabled: false});
		$('#masterdate').jqxDateTimeInput({ disabled: false});
		$('#purchasedate').jqxDateTimeInput({ disabled: false});
		$('#accumdepr').attr('disabled',false); 
		
		funchkfordel(document.getElementById("srno").value);	
		funReadOnly();
		exit();
	

	
       }
function funchkfordel(srno)
{


	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0)
				{
				$.messager.alert('Message',' Transaction Already Exists','warning');  
return 0;
	
				
				}
			else
				{
				$('#frmassetmastrer').submit(); 
				
				
				}
		  
			
			
			
		} else {
			
		}
	}
	x.open("GET", "geteditcasechk.jsp?srno="+document.getElementById("srno").value, true);
	x.send();
	
	}
	


}

function funchkforedit(srno)
    {
	

	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
					document.getElementById("masteredit").value="master";
					
					 //supplieraccId  totalpuchvalue opening accumdepr  fixedassetaccId accdepraccId depraccId
					 $('#supplieraccId').attr('disabled',true); 
					 $('#totalpuchvalue').attr('disabled',true); 
					 $('#opening').attr('disabled',true); 
					 $('#accumdepr').attr('disabled',true); 
					 $('#fixedassetaccId').attr('disabled',true); 
					 $('#accdepraccId').attr('disabled',true); 
					 $('#depraccId').attr('disabled',true); 
					 
					 
					 
					}
				else
					{
					document.getElementById("masteredit").value="do";
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "geteditcasechk.jsp?srno="+srno, true);
		x.send();
	
	
	}


function funNotify(){	
	var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriod(maindate);
	   if(validdate==0){
	   return 0; 
	   }
	   	   
			 var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));    
			 var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate')); 
					  
			 if(purchsedate>masterdate){
			 document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
			 $('#purchasedate').jqxDateTimeInput('focus'); 
			 return false;
					     }   
			
	      else {
	              document.getElementById("errormsg").innerText="";  
			  }
			 
		if($('#mode').val()=='E')
			{
			if(document.getElementById("masteredit").value=="master")
				{
			
		 $('#supplieraccId').attr('disabled',false); 
		 $('#totalpuchvalue').attr('disabled',false); 
		 $('#opening').attr('disabled',false); 
		 $('#accumdepr').attr('disabled',false); 
		 $('#fixedassetaccId').attr('disabled',false); 
		 $('#accdepraccId').attr('disabled',false); 
		 $('#depraccId').attr('disabled',false); 
				}
			
			else
				{
				
				 if(document.getElementById("supplieraccId").value=="")
				 {
			    	document.getElementById("errormsg").innerText="Search Supplier Account";  
			    	document.getElementById("supplieraccId").focus();
			    	return 0;
				 }
			 
					
			 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
			 {
		    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
		    	document.getElementById("totalpuchvalue").focus();
		    	return 0;
			 }
		 
		 
			
			 if(document.getElementById("openingval").value==1)
				{
				 
				 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
				 {
				 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
				 document.getElementById("accumdepr").focus();
			    	return 0;
					
				 }
				 var total= document.getElementById("totalpuchvalue").value;
				 var accdepn=document.getElementById("accumdepr").value;
				 if(parseFloat(accdepn)>parseFloat(total))
					  {
					 
					 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
				      	//document.getElementById("accumdepr").value="";
				    	document.getElementById("accumdepr").focus();
				    	return 0;
					 
					 
					 } 
				}
			 
			 
			 if(document.getElementById("depper").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Enter Depreciation %";  
		    	document.getElementById("depper").focus();
		    	return 0;
			 }
		 
			 
			  
			 
			 
			 if(document.getElementById("fixedassetaccId").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
		    	 document.getElementById("fixedassetaccId").focus();
		    	return 0;
			 }
			 
			 
			 if(document.getElementById("accdepraccId").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
		    	 document.getElementById("accdepraccId").focus();
		    	return 0;
			 }
			 if(document.getElementById("depraccId").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Search Depreciation Account";  
		    	 document.getElementById("depraccId").focus();
		    	return 0;
			 }
			 
				
				}
			
			
			
			
			
			
			}
	   
	
	 //supplieraccId fixedassetaccId
	if($('#mode').val()=='A')
	 {
	 if(document.getElementById("supplieraccId").value=="")
		 {
	    	document.getElementById("errormsg").innerText="Search Supplier Account";  
	    	document.getElementById("supplieraccId").focus();
	    	return 0;
		 }
	 
			
	 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
	 {
    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
    	document.getElementById("totalpuchvalue").focus();
    	return 0;
	 }
 
 
	
	 if(document.getElementById("openingval").value==1)
		{
		 
		 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
		 {
		 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
		 document.getElementById("accumdepr").focus();
	    	return 0;
			
		 }
		 
		 var total= document.getElementById("totalpuchvalue").value;
		 var accdepn=document.getElementById("accumdepr").value;
		 if(parseFloat(accdepn)>parseFloat(total))
			  {
			 
			 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
		      	//document.getElementById("accumdepr").value="";
		    	document.getElementById("accumdepr").focus();
		    	return 0;
			 
			 
			 } 
		 
		 
		}
	 
	
 
	 if(document.getElementById("depper").value=="")
	 {
    	document.getElementById("errormsg").innerText="Enter Depreciation %";  
    	document.getElementById("depper").focus();
    	return 0;
	 }
 
	 
		
	 
	 if(document.getElementById("fixedassetaccId").value=="")
	 {
    	document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
    	 document.getElementById("fixedassetaccId").focus();
    	return 0;
	 }
	 
	 
	 if(document.getElementById("accdepraccId").value=="")
	 {
    	document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
    	 document.getElementById("accdepraccId").focus();
    	return 0;
	 }
	 if(document.getElementById("depraccId").value=="")
	 {
    	document.getElementById("errormsg").innerText="Search Depreciation Account";  
    	 document.getElementById("depraccId").focus();
    	return 0;
	 }
	 
	 }
	 //supplieraccId fixedassetaccId
	 
	
	 var rows = $("#jqxsubdetails").jqxGrid('getrows');
	    $('#gridval').val(rows.length);
	  
	   for(var i=0 ; i < rows.length ; i++){
	
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "paytest"+i)
	       .attr("name", "paytest"+i)
	       .attr("hidden", "true"); 
	 
	   newTextBox.val(rows[i].sr_no+"::"+rows[i].desc1+" :: "+rows[i].qty+" :: ");
	
	   newTextBox.appendTo('form');
	   }
	
	
return 1;
}


function funChkButton() {
	
	//frmEnquiry.submit();
}


function funFocus(){
	
	$('#masterdate').jqxDateTimeInput('focus'); 
	
}

function setValues() {
	
	  // main
	if($('#hidmasterdate').val()){
		$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
	}
	  // purchase
	if($('#hidpurchasedate').val()){
		$("#purchasedate").jqxDateTimeInput('val', $('#hidpurchasedate').val());
	}
	  // main
	if($('#hidwarexpdate').val()){
		$("#warexpdate").jqxDateTimeInput('val', $('#hidwarexpdate').val());
	}
	var docnos=document.getElementById("docno").value;
	  if(parseInt(docnos)>0)
	 {
		  if(document.getElementById("subgriddisval").value==1)
			{
		
		    $("#subdetail").load("subdetails.jsp?docno="+docnos);
			}
		  
	 }
	  
 	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
 	
 	  funSetlabel();  
 	  funsetdatas();
}

function funsetdatas()
{
	if(document.getElementById("subgriddisval").value==1)
	{
		document.getElementById("subgriddis").checked=true;
		$('#subdetail').show();
		$('#freespace').hide();
	}
	else
		{
		document.getElementById("subgriddis").checked=false;
		$('#subdetail').hide();
		$('#freespace').show();
		}
	
	if(document.getElementById("openingval").value==1)
		{
		document.getElementById("opening").checked =true;
		
		if($('#mode').val()!='view')
			{
		$('#accumdepr').attr('disabled',false); 
		$('#accumdepr').attr('readonly',false);
			}
		
		}
	else
		{
		document.getElementById("opening").checked =false;
		$('#accumdepr').attr('disabled',true); 
		
		}
	
	
	if($('#assetGroupval').val()!=""){
		$("#assetGroup").val($('#assetGroupval').val());
	}
	
	if($('#locationval').val()!=""){
		$("#location").val($('#location').val());
	}
	
	
	
	}


function fundisgrid()
{
				if(document.getElementById("subgriddis").checked == true)
					{
					$('#subdetail').show();
					$('#freespace').hide();
					
					
					document.getElementById("subgriddisval").value=1;
					
					}
				else
					{
				$('#subdetail').hide();
				$('#freespace').show();
				
				document.getElementById("subgriddisval").value=0;
					}
				
				
				
	
	}
	
	function funopening()
	{
		
		if(document.getElementById("opening").checked == true)
		{
			document.getElementById("openingval").value=1;
			$('#accumdepr').attr('disabled',false); 	
			$('#accumdepr').attr('readonly',false); 
		}
		
		else
			{
			document.getElementById("openingval").value=0;
			document.getElementById("accumdepr").value="";
			$('#accumdepr').attr('disabled',true); 	
			$('#accumdepr').attr('readonly',false);
			
			}
		 
		
		
	}
	
	
	function funSearchLoad(){
		changeContent('mastersearch.jsp', $('#window'));
	}
	
	
	function getAssetgp() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				items = items.split('***');
				var branchItems = items[0].split(",");
				var branchIdItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i] + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#assetGroup").html(optionsbranch);
				
				if ($('#assetGroupval').val() != null) {
					$('#assetGroup').val($('#assetGroupval').val());
				}
			/* 	if($('#assetGroupval').val()!=""){
					$("#assetGroup").val($('#assetGroupval').val());
				}	 */
			
			} else {
			}
		}
		x.open("GET", "getAssetgp.jsp", true);
		x.send();
	}

	function getloc() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				items = items.split('***');
				var branchItems1 = items[0].split(",");
				var branchIdItems1 = items[1].split(",");
				var optionsbranch1 = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems1.length; i++) {
					optionsbranch1 += '<option value="' + branchIdItems1[i] + '">'
							+ branchItems1[i] + '</option>';
				}
				$("select#location").html(optionsbranch1);
				
				if ($('#locationval').val() != null) {
					$('#location').val($('#locationval').val());
				}
			/* 	if($('#assetGroupval').val()!=""){
					$("#assetGroup").val($('#assetGroupval').val());
				}	 */
			
			} else {
			}
		}
		x.open("GET", "getLocatons.jsp", true);
		x.send();
	}

	
	function isNumber(evt) {
	    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	     {
	    	
	    	document.getElementById("errormsg").innerText="Enter Numbers Only";  

	        return false;
	     }
	    document.getElementById("errormsg").innerText="";  

	    return true;
	}
	
	
	function funcalculatedep()
	{
		
		 if ($("#mode").val() == "A" )
			 {
		 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
		 {
	    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
	    	document.getElementById("lifetimeyear").value="";
	    	document.getElementById("totalpuchvalue").focus();
	    	return 0;
		 }
		 else
		 {
		 document.getElementById("errormsg").innerText="";
		 }
			 }
		 
		 
			if($('#mode').val()=='E')
			{
				if(document.getElementById("masteredit").value=="master")
					{
					 
					}
				
				else
					{
					
							 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
							 {
						    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
						    	document.getElementById("lifetimeyear").value="";
						    	document.getElementById("totalpuchvalue").focus();
						    	return 0;
							 }
							 else
							 {
							 document.getElementById("errormsg").innerText="";
							 }
					
					}
			
			
			}
		 
		 
		 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
			 
			
			 
		var year=document.getElementById("lifetimeyear").value;
		var depval=((1/parseFloat(year))*100);
		
		funRoundAmt(depval,"depper");
		 }
		
	}
	
	function funcalcuyear()
	{
		
		 if ($("#mode").val() == "A" )
		 {
	 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
	 {
    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
      	document.getElementById("depper").value="";
    	document.getElementById("totalpuchvalue").focus();
    	return 0;
	 }
	 else
	 {
	 document.getElementById("errormsg").innerText="";
	 }
 
		 }
		 
		 
		 
			if($('#mode').val()=='E')
			{
				if(document.getElementById("masteredit").value=="master")
					{
					 
					}
				
				else
					{
					         
					 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
					 {
				    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
				      	document.getElementById("depper").value="";
				    	document.getElementById("totalpuchvalue").focus();
				    	return 0;
					 }
					 else
					 {
					 document.getElementById("errormsg").innerText="";
					 }
					
					
					}
				
			}
		 
		 
		 
		 
		 
		
		 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
				var dep=document.getElementById("depper").value;
				var yearval=(100/parseFloat(dep));
				
				funRoundAmt(yearval,"lifetimeyear");
				
				 }
	}
	function funchktotal()
	{
		
		 if ($("#mode").val() == "A" )
		 {
			 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
			 {
		    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
		      	//document.getElementById("accumdepr").value="";
		    	document.getElementById("totalpuchvalue").focus();
		    	return 0;
			 }
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			 
			var total= document.getElementById("totalpuchvalue").value;
			 var accdepn=document.getElementById("accumdepr").value;
			 if(parseFloat(accdepn)>parseFloat(total))
				  {
				 
				 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
			      	//document.getElementById("accumdepr").value="";
			    	document.getElementById("accumdepr").focus();
			    	return 0;
				 
				 
				 }
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
	 
 
		 }
		 
		 
			if($('#mode').val()=='E')
			{
				if(document.getElementById("masteredit").value=="master")
					{
				
					}
				else
					{
									 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
									 {
								    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
								      	//document.getElementById("accumdepr").value="";
								    	document.getElementById("totalpuchvalue").focus();
								    	return 0;
									 }
									 else
										 {
										 document.getElementById("errormsg").innerText="";
										 }
									
					 
						var total= document.getElementById("totalpuchvalue").value;
						 var accdepn=document.getElementById("accumdepr").value;
						 if(parseFloat(accdepn)>parseFloat(total))
							  {
							 
							 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
						      	//document.getElementById("accumdepr").value="";
						    	document.getElementById("accumdepr").focus();
						    	return 0;
							 
							 
							 }
						 else
							 {
							 document.getElementById("errormsg").innerText="";
							 }
					
					}
			}
		 
		 
		 
		 
		 
		 
		 
		 

	}
	
	
	
	function funchkaccum()
	{
		
		 if ($("#mode").val() == "A" )
		 {
			 
			 
			 if(document.getElementById("openingval").value==1)
				{
				 
					 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
					 {
					 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
					 document.getElementById("accumdepr").focus();
				    	return 0;
						
					 }
					 
					 var total= document.getElementById("totalpuchvalue").value;
					 var accdepn=document.getElementById("accumdepr").value;
					 if(parseFloat(accdepn)>parseFloat(total))
						  {
						 
						    document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
					      	//document.getElementById("accumdepr").value="";
					    	document.getElementById("totalpuchvalue").focus();
					    	return 0;
						 
						 
						 } 
					 else
						 {
						 document.getElementById("errormsg").innerText="";
						 }
 
		     }
		 }
			 
			 if($('#mode').val()=='E')
				{
					if(document.getElementById("masteredit").value=="master")
						{
					
						}
					else
						{
						if(document.getElementById("openingval").value==1)
						{
						 
							 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
							 {
							 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
							 document.getElementById("accumdepr").focus();
						    	return 0;
								
							 }
							 
							 var total= document.getElementById("totalpuchvalue").value;
							 var accdepn=document.getElementById("accumdepr").value;
							 if(parseFloat(accdepn)>parseFloat(total))
								  {
								 
								    document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
							      	//document.getElementById("accumdepr").value="";
							    	document.getElementById("totalpuchvalue").focus();
							    	return 0;
								 
								 
								 } 
							 else
								 {
								 document.getElementById("errormsg").innerText="";
								 }
		 
				     }
						
						}
				}
			 
		 
		
	}
	
	
	
	
	
	
	
	 // accumdepr Accum.Depreciation
	

</script>

<body onload="setValues();getAssetgp();getloc();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmassetmastrer" action="saveAssetmaster" autocomplete="OFF">

<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="page-title">Asset Master</div>

<div class="section-card">

<div class="form-row">
<label>Date</label>
<div>
<div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
<input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>
</div>

<label>Doc No</label>
<input type="text" id="refno" name="refno" value='<s:property value="refno"/>'/>

<label>Ref No</label>
<input type="text" id="docno" name="docno" value='<s:property value="docno"/>'/>
</div>

<div class="form-row">
<label>Asset Id</label>
<input type="text" id="assetid" name="assetid" value='<s:property value="assetid"/>'/>

<label>Name</label>
<input type="text" id="assetname" name="assetname" value='<s:property value="assetname"/>'/>
</div>

<div class="form-row single">
<label>Remarks</label>
<input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'/>
</div>

<div class="form-row">
<label>Asset Group</label>
<div>
<select id="assetGroup" name="assetGroup">
<option value="">--Select--</option>
</select>
<input type="hidden" id="assetGroupval" name="assetGroupval" value='<s:property value="assetGroupval"/>'/>
</div>

<label>Location</label>
<div>
<select id="location" name="location">
<option value="">--Select--</option>
</select>
<input type="hidden" id="locationval" name="locationval" value='<s:property value="locationval"/>'/>
</div>
</div>

</div>


<div class="two-column">

<div class="section-card section-half">
<div class="section-title">Purchase</div>

<div class="form-row single">
<label>Supplier</label>
<input type="text" id="supplieraccId" name="supplieraccId"
placeholder="Press F3 To Search"
value='<s:property value="supplieraccId"/>'
onkeydown="getaccountdetails(event)"/>

<input type="text" id="supplieraccName" name="supplieraccName"
value='<s:property value="supplieraccName"/>'/>

<input type="hidden" id="supaccdocno" name="supaccdocno" value='<s:property value="supaccdocno"/>'/>
<input type="hidden" id="supcmbcurrency" name="supcmbcurrency" value='<s:property value="supcmbcurrency"/>'/>
<input type="hidden" id="suprate" name="suprate" value='<s:property value="suprate"/>'/>
<input type="hidden" id="suphidcurrencytype" name="suphidcurrencytype" value='<s:property value="suphidcurrencytype"/>'/>
</div>

<div class="form-row">
<label>Purchase Ref No</label>
<input type="text" id="purchrefno" name="purchrefno" value='<s:property value="purchrefno"/>'/>

<label>Purchase Date</label>
<div>
<div id='purchasedate' name='purchasedate' value='<s:property value="purchasedate"/>'></div>
<input type="hidden" id="hidpurchasedate" name="hidpurchasedate" value='<s:property value="hidpurchasedate"/>'/>
</div>
</div>

<div class="form-row">
<label>No Of Items</label>
<input type="text" id="noofitems" name="noofitems"
value='<s:property value="noofitems"/>'
onkeypress="javascript:return isNumber (event);"/>

<label>Total Purchase Value</label>
<input type="text" id="totalpuchvalue" name="totalpuchvalue"
value='<s:property value="totalpuchvalue"/>'
style="text-align:right;"
onblur="funRoundAmt(this.value,this.id);funchkaccum();"
onkeypress="javascript:return isNumber (event);"/>
</div>

<div class="form-row">
<label>WNTY Exp Date</label>
<div>
<div id='warexpdate' name='warexpdate' value='<s:property value="warexpdate"/>'></div>
<input type="hidden" id="hidwarexpdate" name="hidwarexpdate" value='<s:property value="hidwarexpdate"/>'/>
</div>

<label>WNTY DocNo</label>
<input type="text" id="wntydocno" name="wntydocno" value='<s:property value="wntydocno"/>'/>
</div>

</div>

<div class="section-card section-half">
<div class="section-title">Sub Details</div>

<label>
<input type="checkbox" id="subgriddis" name="subgriddis" onchange="fundisgrid();">
Enable Sub Details
</label>

<input type="hidden" id="subgriddisval" name="subgriddisval"
value='<s:property value="subgriddisval"/>'/>

<div id="subdetail" hidden="true">
<jsp:include page="subdetails.jsp"></jsp:include>
</div>

</div>

</div>


<div class="two-column">

<div class="section-card section-half">
<div class="section-title">Depreciation Setup</div>

<label>
<input type="checkbox" id="opening" name="opening" onchange="funopening()">
Opening
</label>
<input type="hidden" id="openingval" name="openingval"
value='<s:property value="openingval"/>'/>

<div class="form-row">
<label>Accum.Depr</label>
<input type="text" id="accumdepr" name="accumdepr"
value='<s:property value="accumdepr"/>'
style="text-align:right;"
onblur="funRoundAmt(this.value,this.id);funchktotal();"
onkeypress="javascript:return isNumber (event);"/>

<label>Life Time (Year)</label>
<input type="text" id="lifetimeyear" name="lifetimeyear"
value='<s:property value="lifetimeyear"/>'
style="text-align:right;"
onblur="funRoundAmt(this.value,this.id);funcalculatedep();"
onkeypress="javascript:return isNumber (event);"/>
</div>

<div class="form-row">
<label>Depr %</label>
<input type="text" id="depper" name="depper"
value='<s:property value="depper"/>'
style="text-align:right;"
onblur="funRoundAmt(this.value,this.id);funcalcuyear();"
onkeypress="javascript:return isNumber (event);"/>
</div>

<div class="form-row single">
<label>Notes</label>
<input type="text" id="depnotes" name="depnotes"
value='<s:property value="depnotes"/>'/>
</div>

</div>

<div class="section-card section-half">
<div class="section-title">Accounts Mapping</div>

<div class="form-row single">
<label>Fixed Asset</label>
<input type="text" id="fixedassetaccId" name="fixedassetaccId"
placeholder="Press F3 To Search"
value='<s:property value="fixedassetaccId"/>'
onkeydown="getaccountdetails1(1)"/>
<input type="text" id="fixedassetaccName" name="fixedassetaccName"
value='<s:property value="fixedassetaccName"/>'/>
</div>

<div class="form-row single">
<label>Accu.Depr</label>
<input type="text" id="accdepraccId" name="accdepraccId"
placeholder="Press F3 To Search"
value='<s:property value="accdepraccId"/>'
onkeydown="getaccountdetails1(2)"/>
<input type="text" id="accdepraccName" name="accdepraccName"
value='<s:property value="accdepraccName"/>'/>
</div>

<div class="form-row single">
<label>Depreciation</label>
<input type="text" id="depraccId" name="depraccId"
placeholder="Press F3 To Search"
value='<s:property value="depraccId"/>'
onkeydown="getaccountdetails1(3)"/>
<input type="text" id="depraccName" name="depraccName"
value='<s:property value="depraccName"/>'/>
</div>

</div>

</div>

<input type="hidden" id="masteredit" name="masteredit" value='<s:property value="masteredit"/>'/>
<input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'/>
<input type="hidden" id="gridval" name="gridval" value='<s:property value="gridval"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>

<div id="accountDetailsWindow"><div></div></div>
<div id="fixaccountDetailsWindow"><div></div></div>

</form>
</div>
</body>
</html>