<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
     
$(document).ready(function (){
	/* Date */
 	$("#jqxdate").jqxDateTimeInput({ width: '80%', height: '15px', formatString:"dd.MM.yyyy"});
 	$('#jqxdate').on('change', function (event) {
		  
		    var maindate = $('#jqxdate').jqxDateTimeInput('getDate');
		  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
		    funDateInPeriodchk(maindate);
		  	 }
		   });
	$('#ownersearchwindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Owner Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#ownersearchwindow').jqxWindow('close');
	$('#areainfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#areainfowindow').jqxWindow('close');
	$('#ptytypesearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Property Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#ptytypesearchwindow').jqxWindow('close');
	$('#unittypesearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Unit Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#unittypesearchwindow').jqxWindow('close');
	
	
	$('#usearchwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#usearchwindow').jqxWindow('close');
	
	 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	   $('#refnosearchwindow').jqxWindow('close'); 
 	$('#owner').dblclick(function(){
 		 refsearchContent1('ormainsearch.jsp');
	});
 	$('#txtarea').dblclick(function(){
		$('#areainfowindow').jqxWindow('open');
		areaSearchContent('area.jsp?getarea=0');
	});
 	$('#propertytype').dblclick(function(){
		$('#ptytypesearchwindow').jqxWindow('open');
		getPropertyType('propertytypesearch.jsp?');
	});
 	$('#unittype').dblclick(function(){
		$('#unittypesearchwindow').jqxWindow('open');
		getUnitType('unittypesearch.jsp?docno='+$("#hidpropertytype").val());
	});
 	
 	$('#unitof').dblclick(function(){
		 
		getof('building.jsp');
	});
 	
 	
 	
 	
 
}); 

function getunitof(event){
	 var x= event.keyCode;
	 if(x==114){
			getof('building.jsp');
	 } else{}
}



function getof(url) {

	$('#usearchwindow').jqxWindow('open');

	  $.get(url).done(function (data) {
	//alert(data);
	$('#usearchwindow').jqxWindow('setContent', data);

	}); 
	}	
function getOwner(event){
	refsearchContent1('ormainsearch.jsp');
}


function refsearchContent1(url) {

$('#refnosearchwindow').jqxWindow('open');

  $.get(url).done(function (data) {
//alert(data);
$('#refnosearchwindow').jqxWindow('setContent', data);

}); 
}	

function ownerSearchContent(url) {
	 $.get(url).done(function (data) {
	 $('#ownersearchwindow').jqxWindow('setContent', data);
	 }); 
}
function getunit(event){
	 var x= event.keyCode;
	 if(x==114){
	  		$('#unittypesearchwindow').jqxWindow('open');
	  		getUnitType('unittypesearch.jsp?docno='+$("#hidpropertytype").val());
          
	 } else{}
}
function getUnitType(url){
	 $.get(url).done(function (data) {
		 $('#unittypesearchwindow').jqxWindow('setContent', data);
	 	 });
}

function getProperty(event){
	 var x= event.keyCode;
	 if(x==114){
		 $('#ptytypesearchwindow').jqxWindow('open');
		 getPropertyType('propertytypesearch.jsp?');
	 
         
	 } else{}
}

 


function getPropertyType(url){
	 $.get(url).done(function (data) {
		 $('#ptytypesearchwindow').jqxWindow('setContent', data);
	 	 });
}



function getareas(event){
	 var x= event.keyCode;
	 if(x==114){
	  		$('#areainfowindow').jqxWindow('open');
          areaSearchContent('area.jsp?getarea=0');  	 
          
	 } else{}
}
       
function areaSearchContent(url) {
 	 $.get(url).done(function (data) {
	 $
	 ('#areainfowindow').jqxWindow('setContent', data);
 	 }); 
}

function funReadOnly(){
	$('#frmpropertyMaster input').attr('readonly', true );
	$('#frmpropertyMaster input[type=radio]').attr('disabled', true);
	$('#frmpropertyMaster input[type=checkbox]').attr('disabled', true);
    $('#frmpropertyMaster select').attr('disabled', true); 
	$('#jqxdate').jqxDateTimeInput({disabled: true});
	
	$('#owner').attr('disabled', true );
	$('#txtarea').attr('disabled', true );
	$('#propertytype').attr('disabled', true );
	$('#unittype').attr('disabled', true );
 }
 
function funRemoveReadOnly(){
	
	$('#frmpropertyMaster input').attr('readonly', false );
	$('#frmpropertyMaster input[type=radio]').attr('disabled', false);
	$('#frmpropertyMaster input[type=checkbox]').attr('disabled', false);
	$('#frmpropertyMaster select').attr('disabled', false); 
	$('#jqxdate').jqxDateTimeInput({disabled: false});
	
	
	$('#unitof').attr('readonly', true );
	$('#docno').attr('readonly', true );
	$('#owner').attr('readonly', true );
	$('#txtarea').attr('readonly', true );
	$('#propertytype').attr('readonly', true );
	$('#unittype').attr('readonly', true );
	$('#owner').attr('disabled', false );
	$('#txtarea').attr('disabled', false );
	$('#propertytype').attr('disabled', false );
	$('#unittype').attr('disabled', false );
 }
 function funSearchLoad(){
	changeContent('propertyMasterSearch.jsp'); 
 }
function funFocus()
 {
 	$('#jqxdate').jqxDateTimeInput('focus'); 	    		
 }
 function setValues(){
	 if($('#hiddate').val()){
			$("#jqxdate").jqxDateTimeInput('val', $('#hiddate').val());
		}
	 if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	}
	 
	 
	 if(document.getElementById("masterdoc_no").value>0)
		 {
		 if(document.getElementById("hidchkmanagedproperty").value>0)
			 {
			 document.getElementById("chkmanagedproperty").checked=true;
			 }
		 
		 if($("#hidcmbaccgroup").val()!=null)
		     	
		     	
		 	{
		 	
		 	$("#cmbtranstype").val($("#hidcmbaccgroup").val());
		  
		 	}
		 
		 
		 if($("#hidparking").val()!=null)
		     	
		     	
		 	{
		 	
		 	$("#parking").val($("#hidparking").val());
		  
		 	}
		 
		 if($("#hidarm").val()!=null)
		     	
		     	
		 	{
		 	
		 	$("#arm").val($("#hidarm").val());
		  
		 	}
		 
		 
		 }
	 
	  
 
 }
 
 function  chkval()
 {
	 if(document.getElementById("chkmanagedproperty").checked==true)
		 {
		 document.getElementById("hidchkmanagedproperty").value=1;
		 }
	 else
		 {
		 document.getElementById("hidchkmanagedproperty").value=0;
		 }
	 
     
	 
 }
 
 
 
 
 function getcmbtranstype(){ 
	 
		
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	       
	      items=items.split('####');
	           var docno=items[0].split(",");
	           var type=items[1].split(",");
	        
	           var optionstype = '<option value="0">--select--</option>';

	
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	            
	            $("select#cmbtranstype").html(optionstype); 	
	            
	            if($("#hidcmbaccgroup").val()!=null)
	            	
	            	
            	{
            	
            	$("#cmbtranstype").val($("#hidcmbaccgroup").val());
             
            	}
	         
	  
	    }
	       }
	   x.open("GET","getTranstype.jsp?",true);
		x.send();
	        
	      
	        }
 function funDateInPeriodchk(value){
	 
	    var currentDate = new Date(new Date());
	 
	     if(value>currentDate){
	     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
	    
	     return 0;
	    } 
	    
	    document.getElementById("errormsg").innerText="";
	   
	     return 1;
	 }

function funNotify(){
	 
		var maindate = $('#jqxdate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriodchk(maindate);
		   
		  
		   
		   if(validdate==0){
		   return 0; 
		   }
 
			 var propertyname = document.getElementById("propertyname").value;
			 var owner = document.getElementById("owner").name;
			 

if(owner=="")
{
document.getElementById("errormsg").innerText="Owner is required ";
 
return 0;
}
			 

if(propertyname=="")
{
document.getElementById("errormsg").innerText="Property Name	 is required ";
 
return 0;
}
	
		   
 
			$('#jqxdate').jqxDateTimeInput({ disabled: false});
 		return 1;
	} 
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
       
        return false;
    	}
    document.getElementById("errormsg").innerText="";  
    return true;
}
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();getcmbtranstype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpropertyMaster" action="saveptyMaster" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include><br/>
   
<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td> 

     
    <td width="15%"><div id="jqxdate" name="jqxdate" value='<s:property value="jqxdate"/>'></div>  
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td> 
    <td width="7%" align="right">Owner</td>
    <td width="20%"><input type="text" id="owner" name="owner" value='<s:property value="owner"/>' placeholder="Press F3 To Search" onkeydown="getOwner();"/>
    <input type="hidden" id="ownerid" name="ownerid" value='<s:property value="ownerid"/>'  >
    </td>
    <td width="5%" align="right">&nbsp;</td>
    <td width="25%">&nbsp;</td>
    <td width="6%" align="right">Doc No</td>
    <td width="17%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<fieldset>
<legend>Property details</legend>
<table width="100%">
  <tr>
  	<td width="9%" align="right">Property Name</td>
    <td width="21%"><input type="text" id="propertyname" name="propertyname" style="width:100%;" value='<s:property value="propertyname"/>' tabindex="-1"/></td>
    <td width="12%" align="right">Transaction Type</td>
    <td width="16%"><select id="cmbtranstype" name="cmbtranstype"  style="width:70%;" value='<s:property value="cmbtranstype"/>'>
      </select>
    <input type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup" value='<s:property value="hidcmbaccgroup"/>'/></td>
    <td width="15%" align="right"><input type="checkbox" id="chkmanagedproperty" name="chkmanagedproperty" onchange="chkval()" value='<s:property value="chkmanagedproperty"/>'>
    
    <input type="hidden" id="hidchkmanagedproperty" name="hidchkmanagedproperty" value='<s:property value="hidchkmanagedproperty"/>'>
    </td>
    <td width="27%">Managed Property</td>
  </tr>

   <tr>
     <td align="right">Address</td>
     <td align="right"><input type="text" name="propertyaddress" id="propertyaddress" value='<s:property value="propertyaddress"/>' style="width:100%;" ></td>
     <td align="right">Nearest Landmark</td>
     <td><input type="text" name="landmark" id="landmark" value='<s:property value="landmark"/>' style="width:100%;" ></td>
     <td align="right">Area</td>
     <td align="left"><input type="text" id="txtarea" name="txtarea" value='<s:property value="txtarea"/>' style="width:60%;" placeholder="press F3 to search" onKeyDown="getareas(event);"/>
	<input type="hidden" id="txtareadet" name="txtareadet" readonly style="width:68%;" value='<s:property value="txtareadet"/>'/>
 	<input type="hidden" id="txtareaid" name="txtareaid"  value='<s:property value="txtareaid"/>'/></td>
   </tr>
      <tr>
     <td align="right">Property Description</td>
     <td colspan="5"><input type="text" name="propertydesc" id="propertydesc" value='<s:property value="propertydesc"/>' style="width:97%;" ></td>
   </tr>
</table><br/>
<table width="100%" border="0" cellspacing="1" cellpadding="1"> 
  <tr>
    <td width="9%" align="right">Type</td>
    <td width="14%"><input type="text" name="propertytype" id="propertytype" value='<s:property value="propertytype"/>' style="width:100%;" placeholder="Press F3 To Search" onkeydown="getProperty();">
    <input type="hidden" name="hidpropertytype" id="hidpropertytype" value='<s:property value="hidpropertytype"/>' >
    
    </td>
    <td width="9%" align="right">Unit Type</td>
    <td width="16%"><input type="text" name="unittype" id="unittype" value='<s:property value="unittype"/>' style="width:100%;" placeholder="Press F3 To Search" onkeydown="getUnit();" >
    
    <input type="hidden" name="hidunittype" id="hidunittype" value='<s:property value="hidunittype"/>' >
    </td>
    <td width="10%" align="right">Additional Rooms</td> 
    <td width="13%"> 
    <input type="hidden" name="hidarm" id="hidarm" value='<s:property value="hidarm"/>' style="width:50%;" >
    <select id="arm" name="arm">
    <option value="1">Yes</option>
    <option value="2">No</option>
    </select>
    
    
    </td>
    <td width="6%" align="right">No. of Rooms</td> 
    <td width="23%"><input type="text" name="roomsno" id="roomsno"  onkeypress="javascript:return isNumber (event);"  value='<s:property value="roomsno"/>' style="width:50%;" ></td>
  </tr>
  <tr>
    <td align="right">For</td>
    <td colspan="5"><input type="text" name="txtfor" id="txtfor" value='<s:property value="txtfor"/>' style="width:100%;" ></td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Unit  No </td>
    <td><input type="text" name="unitno" id="unitno" value='<s:property value="unitno"/>' style="width:100%;" ></td>
    <td align="right">Unit  of</td>
    <td><input type="text" name="unitof" id="unitof" value='<s:property value="unitof"/>' style="width:100%;" onkeydown="getunitof()" >  
    
    <input type="hidden" name="unitofid" id="unitofid" value='<s:property value="unitofid"/>' style="width:100%;" >
    </td>
    <td align="right">Parking</td>
      <input type="hidden" name="hidparking" id="hidparking" value='<s:property value="hidparking"/>' style="width:100%;" > 
    <td>    <select id="parking" name="parking">
    <option value="1">Yes</option>
    <option value="2">No</option>
    </select>
    </td>
    <td align="right">Parking No</td>
    <td><input type="text" name="parkingno" id="parkingno" value='<s:property value="parkingno"/>' style="width:100%;" ></td>
  </tr>
  <tr>
    <td height="30" align="right">Bay No </td>
    <td><input type="text" name="bayno" id="bayno" value='<s:property value="bayno"/>' style="width:100%;" ></td>
    <td align="right">Area  (sq.ft)</td> 
    <td>
   	<input type="text" id="txtareasqft" name="txtareasqft" style="width:60%;" value='<s:property value="txtareasqft"/>'>
	</td>
    <td align="right">Build  up Area</td>
    <td><input type="text" name="builduparea" id="builduparea" value='<s:property value="builduparea"/>' style="width:100%;" ></td>
    <td align="right">Yard</td>
    <td><input type="text" name="yard" id="yard" value='<s:property value="yard"/>' style="width:100%;" ></td>
  </tr>
  <tr>
    <td align="right">Electricity &amp; Water No</td>
    <td><input type="text" name="electricwaterno" id="electricwaterno" value='<s:property value="electricwaterno"/>' style="width:100%;" ></td>
    <td align="right">Gas Connection No</td>
    <td><input type="text" name="gasconnectionno" id="gasconnectionno" value='<s:property value="gasconnectionno"/>' style="width:100%;" ></td>
    <td align="right">AC Connection No</td>
    <td><input type="text" name="acconnectionno" id="acconnectionno" value='<s:property value="acconnectionno"/>' style="width:100%;" ></td>
    <td align="right">Premises No</td>
    <td><input type="text" name="premisesno" id="premisesno" value='<s:property value="premisesno"/>' style="width:100%;" ></td>
  </tr>
</table> 
</fieldset><br/>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>

<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>
<div id="ownersearchwindow">
   <div ></div>
</div>
<div id="areainfowindow">
   <div ></div>
</div>
<div id="ptytypesearchwindow">
   <div ></div>
</div>
<div id="unittypesearchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow"><div></div></div>
<div id="usearchwindow"><div></div></div>

</div>
</body>
</html>