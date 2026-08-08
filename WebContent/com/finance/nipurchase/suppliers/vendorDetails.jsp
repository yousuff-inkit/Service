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

<script type="text/javascript">
     
	$(document).ready(function () {
	  	 /* Date */
	 	 $("#jqxVendorDate").jqxDateTimeInput({ width: '80%', height: '15px', formatString:"dd.MM.yyyy"});
	 	 $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	  	 $('#areainfowindow').jqxWindow('close');
   	  	 $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	  	 $('#activityinfowindow').jqxWindow('close');
   	 	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	     $('#brandsearchwndow').jqxWindow('close'); 
		 getCurrencyIds();getCategory();getGroup();getTypeAllowed();getType();
		 
		  $('#txtarea').dblclick(function(){
			  if ($("#mode").val() == "A" || $("#mode").val() == "E") {
    		  $('#areainfowindow').jqxWindow('open');
			  areaSearchContent('area.jsp');
			  }
		  });
	});  
	
	function getGroup() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var groupItems = items[0].split(",");
  				var groupIdItems = items[1].split(",");
  				var optionsgroup = '<option value="">--Select--</option>';
  				for (var i = 0; i < groupItems.length; i++) {
  					optionsgroup += '<option value="' + groupIdItems[i] + '">'
  							+ groupItems[i] + '</option>';
  				}
  				$("select#cmbaccgroup").html(optionsgroup);
  				if ($('#hidcmbaccgroup').val() != null) {
  					$('#cmbaccgroup').val($('#hidcmbaccgroup').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getGroup.jsp", true);
  		x.send();
  	} 
	
	function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var categoryItems = items[0].split(",");
  				var categoryIdItems = items[1].split(",");
  				var optionscategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < categoryItems.length; i++) {
  					optionscategory += '<option value="' + categoryIdItems[i] + '">'
  							+ categoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionscategory);
  				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
  			} else {
  			}
  			
  		}
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
	
	function getType() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var typeItems = items[0].split(",");
  				var typeIdItems = items[1].split(",");
  				var optionstype ;
  				for (var i = 0; i < typeItems.length; i++) {
  					optionstype += '<option value="' + typeIdItems[i] + '">'
  							+ typeItems[i] + '</option>';
  				}
  				$("select#cmbtype").html(optionstype);
  				if ($('#hidcmbtype').val() != null) {
  					$('#cmbtype').val($('#hidcmbtype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getType.jsp", true);
  		x.send();
  	}
	
	function getTypeAllowed(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    if(parseInt(items)==1) {
  			    	$('#typeallowed').val(1);
  			    	document.getElementById("lbltypeentity").style.display = 'inline-block';
  			    	document.getElementById("lbltrnnoentity").style.display = 'inline-block';
  			    	$('#cmbtype').attr('hidden', false);
  			    	$('#txtregisteredtrnno').attr('hidden', false);
  			    } else {
  			    	$('#typeallowed').val(0);
  			    	document.getElementById("lbltypeentity").style.display = 'none';
  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
  			    	$('#cmbtype').attr('hidden', true);
  			    	$('#txtregisteredtrnno').attr('hidden', true);
  			    }
  			    
  		}
  		}
  		x.open("GET", "getTypeAllowed.jsp", true);
  		x.send();
 }
	
    function brandinfoSearchContent(url) {
    	 //alert(url);
    		 $.get(url).done(function (data) {
    			 
    			 $('#brandsearchwndow').jqxWindow('open');
    		$('#brandsearchwndow').jqxWindow('setContent', data);
    
    	}); 
    	} 
	
	
	function getCategoryAccountGroup(a) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    $('#hidcmbaccgroup').val(items);
  				
  				if ($('#hidcmbaccgroup').val() != null || $('#hidcmbaccgroup').val() != "") {
  					$('#cmbaccgroup').val($('#hidcmbaccgroup').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
  		x.send();
  	} 
      
	function getCurrencyIds(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('####');
		        var curidItems=items[0];
		        var curcodeItems=items[1];
		        var multiItems=items[2];
		        var optionscurr = '';
		        
		     if(curcodeItems.indexOf(",")>=0){
		        	var currencyid=curidItems.split(",");
		        	var currencycode=curcodeItems.split(",");
		        	multiItems.split(",");
		       
		       for ( var i = 0; i < currencycode.length; i++) {
		    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		        }
		      
		         $("select#cmbcurrency").html(optionscurr);
		         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
		       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
		         } 
				     
			   }
		
		       else{
		    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
		    	   
			    	 $("select#cmbcurrency").html(optionscurr);
			       
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         }
			      }
			}
	     }
	      x.open("GET", "getCurrencyId.jsp",true);
	     x.send();
	    
	   }
	   
	   function getVendorAlreadyExists(vendorname,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 document.getElementById("errormsg").innerText="Vendor Already Exists.";
  					 return 0;
  				 }else{
  					$('#cmbaccgroup').attr('disabled', false);
  					var rows = $("#brandgrid").jqxGrid('getrows');
  					$('#gridlenght').val(rows.length);
	 				    for(var i=0 ; i < rows.length ; i++)
	 				    {
	   				    		// var myvar = rows[i].tarif; 
	       		 	   			 newTextBox = $(document.createElement("input"))
	     			   			 .attr("type", "dil")
	       						 .attr("id", "desctest"+i)
	       					   	 .attr("name", "desctest"+i)
	       				 		 .attr("hidden", "true"); 
	   
	  					 		newTextBox.val(rows[i].doc_no+"::"+rows[i].desc1+" :: ");
	
									//alert(newTextBox.val()); 
	  							 newTextBox.appendTo('form');
	    
	   					}  			   
	   
	   
	   
				 		var rows = $("#vdrDetailsGrid").jqxGrid('getrows');
				 		
  			 		for(var i=0;i<rows.length;i++)
  					 {
	   
 								var cpersion= $.trim(rows[i].cpersion);
 
						 	 
		
		
										newTextBox = $(document.createElement("input"))
	      					   		 	.attr("type", "dil")
	       								.attr("id", "test"+i)
	         							.attr("name", "test"+i)
	       								.attr("hidden", "true");
	    
		   
		
								 		newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "
		  										 +rows[i].phone+" :: "+rows[i].extn+" :: "+rows[i].email+" :: "
		  										 +rows[i].area+" :: "+rows[i].areaid+" :: "+rows[i].activity_id+"");
 
								 		newTextBox.appendTo('form'); 
 

								
 
				 		}
						 $('#vdrgridlength').val(rows.length);   
		
  					$("#frmVendorDetails").submit();
  				 }
  			   
  		}
	}
	x.open("GET", "getVendorAlreadyExists.jsp?vendorname="+vendorname+"&docno="+docno+"&mode="+mode, true);
	x.send();
    }
	
	function getMobileNoAlreadyExists(mobileno,docno,mode){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();

  				if(parseInt(items)==1){
  					 $.messager.alert('Message','Mobile No. Already Exists.','warning');
  					 return 0;
  				 }
  		}
	}
	x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
	x.send();
	}
      
	 function funReadOnly(){
			$('#frmVendorDetails input').attr('readonly', true );
		    $('#frmVendorDetails select').attr('disabled', true); 
			$('#jqxVendorDate').jqxDateTimeInput({disabled: true});
			$("#brandgrid").jqxGrid({ disabled: true}); 
			$("#vdrDetailsGrid").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getCurrencyIds();getTypeAllowed();
		    
			$('#frmVendorDetails input').attr('readonly', false );
			$('#frmVendorDetails select').attr('disabled', false); 
			$('#jqxVendorDate').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#cmbaccgroup').attr('disabled', true);
			$('#docno').attr('readonly', true);
			
			 $("#brandgrid").jqxGrid({ disabled: false}); 
			 $("#vdrDetailsGrid").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "A") {
				$('#jqxVendorDate').val(new Date());
				 $("#brandgrid").jqxGrid('clear');
				  $("#brandgrid").jqxGrid('addrow', null, {});
				  $("#vdrDetailsGrid").jqxGrid('clear');
				  $("#vdrDetailsGrid").jqxGrid('addrow', null, {});
			}
	 }
	 function funNotify(){	
		 
		 if(parseInt($('#typeallowed').val())==1) {
			 var taxtype=document.getElementById("cmbtype").value;
			 if(taxtype.trim()==''){
				 document.getElementById("errormsg").innerText="Type is Mandatory.";
				 return 0;
			 }
			 
			 if($('#cmbtype').find('option:selected').text()=='Registered'){
				 var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
				 if(registeredtrnno.trim()==''){
					 document.getElementById("errormsg").innerText="TRN No. is Mandatory for Registered.";
					 return 0;
				 } 
			 }
		 }
		 var account=document.getElementById("cmbaccgroup").value;
		 if(account=="")
			{
			document.getElementById("errormsg").innerText=" Enter Account Group";
			document.getElementById("cmbaccgroup").focus();  
			return 0;
			}
			
		 
		 
		 vendorname=document.getElementById("txtvendorname").value;
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		 getVendorAlreadyExists(vendorname,docno,mode);
		} 
	 
	 function funSearchLoad(){
			changeContent('vndMainSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxVendorDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 
		 var maindoc=document.getElementById("docno").value;
		  if(maindoc>0)
			  {
	   			 var indexVal1 = document.getElementById("docno").value;
	 	 		 $("#venderDetails").load('vendermaingrid.jsp?cldocno='+indexVal1);
			  }
		  
		  
		 getCurrencyIds();
		 
		 if($('#hidjqxVendorDate').val()){
			 $("#jqxVendorDate").jqxDateTimeInput('val', $('#hidjqxVendorDate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		 if(document.getElementById("docno").value>0)
		 {
	 	 var indexval1 = document.getElementById("docno").value;   
	 	
	  		 $("#divbrand").load("brandgrid.jsp?rdocno="+indexval1); 
		 }
		 
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 /* Validations */
	 $(function(){
	        $('#frmVendorDetails').validate({
	                rules: {
	                txtvendorname:"required",
	                cmbcurrency:"required",
	                cmbcategory:"required",
	                cmbaccgroup:"required",
	                //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
	                 
	                 },
	                 messages: {
	                 txtvendorname:" *",
	                 cmbcurrency:" *",
	                 cmbcategory:" *",
	                 cmbaccgroup:" *",
	                 //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
	                 }
	        });});
	 
	 function getareas(event){
		 if ($("#mode").val() == "A" || $("#mode").val() == "E") {
      	 var x= event.keyCode;
      	 if(x==114){
      	  	$('#areainfowindow').jqxWindow('open');
            areaSearchContent('area.jsp');  	 
      	 }   
      	 }   
      }
             	 
	 function areaSearchContent(url) {
	 	$.get(url).done(function (data) {
	 		$('#areainfowindow').jqxWindow('setContent', data);
	    }); 
	 }
	 
	 function funExcelBtn(){
		    var url=document.URL;
		    var reurl=url.split("suppliers");
		    top.addTab("VendorList",reurl[0]+"suppliers/vendorList.jsp");
		}
	 
</script>



</head>
<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

#frmVendorDetails input[type="text"],
#frmVendorDetails input[type="email"],
#frmVendorDetails select,
.textbox { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
    width: 100%;
}

#frmVendorDetails input[type="text"]:focus,
#frmVendorDetails input[type="email"]:focus,
#frmVendorDetails select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmVendorDetails input[readonly],
#frmVendorDetails input:disabled,
#frmVendorDetails select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.myButton, .btn {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .btn:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.icon {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s;
}
.icon:hover {
    transform: scale(1.1);
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Grid Containers */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* CSS-only JQX Overrides for Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
    font-family: Arial, sans-serif !important;
    padding: 0 6px !important;
}
.jqx-action-button {
    height: 24px !important;
    top: 0px !important;
}
.jqx-widget-content {
    box-sizing: border-box !important;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap; /* Prevent wrapping */
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; /* Keep labels from squishing */
}

.modern-ui .input-search-container {
    position: relative;
    display: flex;
    flex-shrink: 0;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
    width: 100%;
    box-sizing: border-box;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }
</style>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVendorDetails" action="saveVendorDetails" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>
   
    <div class='modern-ui hidden-scrollbar'>
        
        <!-- General Info Panel -->
        <div class="middle-panel" style="background: #fdfdfd;">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:60px; flex-shrink:0;">Date</label>
                <div style="width: 120px; flex-shrink:0;">
                    <div id="jqxVendorDate" name="jqxVendorDate" value='<s:property value="jqxVendorDate"/>'></div>
                    <input type="hidden" id="hidjqxVendorDate" name="hidjqxVendorDate" value='<s:property value="hidjqxVendorDate"/>'/>
                </div>
                
                <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Code</label>
                <input type="text" id="txtcode" name="txtcode" tabindex="-1" value='<s:property value="txtcode"/>' style="width:80px; flex-shrink:0;"/>
                
                <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Name</label>
                <input type="text" id="txtvendorname" name="txtvendorname" value='<s:property value="txtvendorname"/>' style="flex:1; min-width:0;"/>
                
                <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Doc No</label>
                <input type="text" id="docno" name="txtvendordocno" tabindex="-1" value='<s:property value="txtvendordocno"/>' style="width:100px; flex-shrink:0;"/>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:60px; flex-shrink:0;">Currency</label>
                <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' style="width:120px; flex-shrink:0;">
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
                
                <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Category</label>
                <select id="cmbcategory" name="cmbcategory" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>' style="width:150px; flex-shrink:0;">
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
                
                <label class="lbl-right" id="lbltypeentity" style="width:40px; flex-shrink:0; margin-left: 15px;">Type</label>
                <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>' style="width:100px; flex-shrink:0;">
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                
                <label class="lbl-right" id="lbltrnnoentity" style="width:60px; flex-shrink:0; margin-left: 15px;">TRN No.</label>
                <input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" value='<s:property value="txtregisteredtrnno"/>' style="flex:1; min-width:0;"/>
            </div>
        </div>

        <!-- Account Info Panel -->
        <div class="middle-panel">
            <span class="middle-panel-title">Account Info</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px; flex-shrink:0;">Account Group</label>
                <select id="cmbaccgroup" name="cmbaccgroup" value='<s:property value="cmbaccgroup"/>' style="flex:1; min-width:0;">
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup" value='<s:property value="hidcmbaccgroup"/>'/>
                
                <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left: 15px;">Account</label>
                <input type="text" id="txtaccount" name="txtaccount" value='<s:property value="txtaccount"/>' tabindex="-1" style="width:120px; flex-shrink:0;"/>
                
                <label class="lbl-right" style="width:140px; flex-shrink:0; margin-left: 15px;">Credit Min(Days)</label>
                <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" value='<s:property value="txtcredit_period_min"/>' style="width:60px; flex-shrink:0; text-align: right;"/>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Max(Days)</label>
                <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" value='<s:property value="txtcredit_period_max"/>' style="width:60px; flex-shrink:0; text-align: right;"/>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Credit Limit</label>
                <input type="text" id="txtcredit_limit" name="txtcredit_limit" value='<s:property value="txtcredit_limit"/>' style="width:80px; flex-shrink:0; text-align: right;"/>
            </div>
        </div>

        <!-- Contact Info Panel -->
        <div class="middle-panel">
            <span class="middle-panel-title">Contact Info</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Address</label>
                <input type="text" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>' style="flex:2; min-width:0;"/>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Address 2</label>
                <input type="text" id="txtaddress1" name="txtaddress1" value='<s:property value="txtaddress1"/>' style="flex:1; min-width:0;"/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Tel</label>
                <input type="text" id="txttel" name="txttel" value='<s:property value="txttel"/>' style="width:150px; flex-shrink:0;"/>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Mob</label>
                <input type="text" id="txtmob" name="txtmob" onblur="getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtmob"/>' style="width:150px; flex-shrink:0;"/>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Office No.</label>
                <input type="text" id="txtoffice" name="txtoffice" value='<s:property value="txtoffice"/>' style="width:150px; flex-shrink:0;"/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Fax</label>
                <input type="text" id="txtfax" name="txtfax" value='<s:property value="txtfax"/>' style="width:150px; flex-shrink:0;"/>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Email</label>
                <input type="email" id="txtemail" name="txtemail" placeholder="someone@example.com" value='<s:property value="txtemail"/>' style="flex:1; min-width:0;"/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Contact Per.</label>
                <input type="text" id="txtcontact" name="txtcontact" value='<s:property value="txtcontact"/>' style="width:200px; flex-shrink:0;"/>
                
                <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Extn. No.</label>
                <input type="text" id="txtextno" name="txtextno" value='<s:property value="txtextno"/>' style="width:100px; flex-shrink:0;"/>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px; flex-shrink:0;">Area</label>
                <div class="input-search-container" style="flex:1; min-width:0;">
                    <input type="text" id="txtarea" name="txtarea" readonly placeholder="Press F3" value='<s:property value="txtarea"/>' onKeyDown="getareas(event);"/>
                    <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E'){ $('#areainfowindow').jqxWindow('open'); areaSearchContent('area.jsp'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" id="txtareadet" name="txtareadet" readonly value='<s:property value="txtareadet"/>' style="flex:1; min-width:0; margin-left: 8px;"/>
                <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'/>
            </div>
        </div>

        <!-- Grids -->
        <div class="middle-panel">
            <span class="middle-panel-title">Contact Person Details</span>
            <div id="venderDetails" class="grid-container"> 
                <jsp:include page="vendermaingrid.jsp"></jsp:include>
            </div>
            <input type="hidden" id="vdrgridlength" name="vdrgridlength"/>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Brand Details</span>
            <div id="divbrand" class="grid-container">
                <jsp:include page="brandgrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- Hidden Inputs -->
        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
            <input type="hidden" id="typeallowed" name="typeallowed" value='<s:property value="typeallowed"/>'/>
            <input type="hidden" id="gridlenght" name="gridlenght" value='<s:property value="gridlenght"/>'/>
        </div>

    </div>
</form>

<div id="areainfowindow"><div></div></div>
<div id="brandsearchwndow"><div></div></div>
<div id="activityinfowindow"><div></div></div>
<div id="countryinfowindow"><div></div></div>
  
</div>
</body>
</html>