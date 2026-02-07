<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
   	<%@page import="com.controlcentre.masters.dumpmaster.route.ClsRouteDAO"%>
   		<%ClsRouteDAO ClsRouteDAO= new ClsRouteDAO();%> 
<script type="text/javascript">
 
$(document).ready(function ()

		{     
	
	  $('#dumpsearchwndow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Dump Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	     $('#dumpsearchwndow').jqxWindow('close');
	     $('#driversearchwndow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Driver Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	     $('#driversearchwndow').jqxWindow('close');
	     $('#helpersearchwndow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Helper Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	     $('#helpersearchwndow').jqxWindow('close');
	     $('#vehiclesearchwndow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Vehicle Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	     $('#vehiclesearchwndow').jqxWindow('close');
	  
	     $('#vehgrpsearchwndow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Vehicle Group Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	     $('#vehgrpsearchwndow').jqxWindow('close');
	     $('#areasearchwndow').jqxWindow({ width: '60%', height: '70%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Area Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	     $('#areasearchwndow').jqxWindow('close');
	   
	    document.getElementById("formdet").innerText="Route (RTE)";
		document.getElementById("formdetail").value="Route ";
		document.getElementById("formdetailcode").value="RTE";
		window.parent.formCode.value="RTE";
		window.parent.formName.value="Route ";
		 $('#txtvehgrp').attr('disabled', true);
	        $('#txtdump').attr('disabled', true);
	        $('#txtdriver').attr('disabled', true);
	        $('#txthelper').attr('disabled', true);
	        $('#txtvehicle').attr('disabled', true);
	        $('#txtarea').attr('disabled', true);
	        $('#txthelper2').attr('disabled', true);


		 $('#txtdump').dblclick(function(){
		    	$('#dumpsearchwndow').jqxWindow('open');
				 dumpinfoSearchContent('searchDump.jsp?', $('#dumpsearchwndow'));  
		   });
		 $('#txtvehgrp').dblclick(function(){
		    	$('#vehgrpsearchwndow').jqxWindow('open');
				 vehgrpinfoSearchContent('searchVehgrp.jsp?', $('#vehgrpsearchwndow'));  
		   });
		 $('#txtarea').dblclick(function(){
		    	$('#areasearchwndow').jqxWindow('open');
				 areainfoSearchContent('searchArea.jsp?', $('#areasearchwndow'));  
		   });
		 $('#txtdriver').dblclick(function(){
		    	$('#driversearchwndow').jqxWindow('open');
				 driverinfoSearchContent('searchDriver.jsp?', $('#driversearchwndow'));  
		   }); 
		 $('#txthelper').dblclick(function(){
		    	$('#helpersearchwndow').jqxWindow('open');
				 helperinfoSearchContent('searchHelper.jsp?count=0', $('#helpersearchwndow'));  
		   }); 
		 $('#txthelper2').dblclick(function(){
		    	$('#helpersearchwndow').jqxWindow('open');
				 helperinfoSearchContent('searchHelper.jsp?count=1', $('#helpersearchwndow'));  
		   }); 
		 $('#txtvehicle').dblclick(function(){
			 var vehgrpid = document.getElementById('vehgrpid').value;
		    	$('#vehiclesearchwndow').jqxWindow('open');
				 vehicleinfoSearchContent('searchVehicle.jsp?vehgrpids='+vehgrpid, $('#vehiclesearchwndow'));  
		   });

		
			var data='<%=ClsRouteDAO.searchDetails()%>'; 
		var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'int' },
  						{name : 'name', type: 'String'  },
                       	{name : 'code', type: 'String'  },
                       	{name : 'gname',type:'String'},
                        {name : 'vehgrpid', type: 'String'  },
                     	{name : 'dump',type:'String'},
                        {name : 'dumpid', type: 'String'  },
                     	{name : 'area',type:'String'},
                        {name : 'areaid', type: 'String'  },
                        {name : 'driver',type:'String'},
                        {name : 'driverid', type: 'String'  },
                        {name : 'helper',type:'String'},
                        {name : 'helperid', type: 'String'  },
                        {name : 'helper2',type:'String'},
                        {name : 'helperid2', type: 'String'  },
                        {name : 'vehicle',type:'String'},
                        {name : 'vehicleid', type: 'String'  },
                     	



                       	
                         ],
                         localdata: data,
             
             
             pager: function (pagenum, pagesize, oldpagenum) 
             {
                 // callback called when a page or page size is changed.
             }
         };
         
         var dataAdapter = new $.jqx.dataAdapter(source,
         		 {
             		loadError: function (xhr, status, error) 
             		{
	                   // alert(error);    
	                 }
		         }		
         ); 
         $("#jqxRouteSearch1").jqxGrid(
                 {
                 	width: '100%',
                 	height:310,
                     source: dataAdapter,
                     showfilterrow: true,
                     filterable: true,
                     selectionmode: 'singlerow',
                     sortable: true,
                     altrows:true,
                     enabletooltips:true,
                     //Add row method
                     columns: [
     					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%' },
     					{ text: 'code', filtertype: 'input', datafield: 'code', width: '5%' },
     					{ text: 'name', filtertype: 'input', datafield: 'name'},
     					{ text: 'Vehicle Group', filtertype: 'input', datafield: 'gname', width: '12%',editable:false },
     					{ text: 'Vehicle Group Id', filtertype: 'input', datafield: 'vehgrpid', width: '30%',hidden:'true' },
     					{ text: 'Dumping Site', filtertype: 'input', datafield: 'dump', width: '12%',editable:false },
     					{ text: 'Dump Id ', filtertype: 'input', datafield: 'dumpid', width: '30%',hidden:'true' },
     					{ text: 'Area', filtertype: 'input', datafield: 'area', width: '12%',editable:false},
     					{ text: 'Area Id', filtertype: 'input', datafield: 'areaid', width: '30%',hidden:'true' },
     					{ text: 'Driver Name', filtertype: 'input', datafield: 'driver', width: '12%',editable:false },
     					{ text: 'Driver Id ', filtertype: 'input', datafield: 'driverid', width: '30%',hidden:'true' },
     					{ text: 'Helper', filtertype: 'input', datafield: 'helper', width: '12%',editable:false },
     					{ text: 'Helper Id ', filtertype: 'input', datafield: 'helperid', width: '30%',hidden:'true' },
     					{ text: 'Helper2', filtertype: 'input', datafield: 'helper2', width: '12%',editable:false },
     					{ text: 'Helper Id 2', filtertype: 'input', datafield: 'helperid2', width: '30%',hidden:'true' },
     					
     					{ text: 'Vehicle ', filtertype: 'input', datafield: 'vehicle', width: '12%',editable:false },
     					{ text: 'Vehicle Id ', filtertype: 'input', datafield: 'vehicleid', width: '30%',hidden:'true' },
     				
     					
     	              ]
                 });

         $('#jqxRouteSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		                document.getElementById("docno").value= $('#jqxRouteSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("txtcode").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("txtname").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		                document.getElementById("txtvehgrp").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "gname");
		                document.getElementById("vehgrpid").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "vehgrpid");
		                document.getElementById("txtdump").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "dump");
		                document.getElementById("dumpid").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "dumpid");
		                document.getElementById("txtarea").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "area");
		                document.getElementById("areaid").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "areaid");
		                document.getElementById("txtdriver").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "driver");
		                document.getElementById("driverid").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "driverid");
		                document.getElementById("txthelper").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "helper");
		                document.getElementById("helperid").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "helperid");
		                document.getElementById("txthelper2").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "helper2");
		                document.getElementById("helperid2").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "helperid2");
		                document.getElementById("txtvehicle").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "vehicle");
		                document.getElementById("vehicleid").value = $("#jqxRouteSearch1").jqxGrid('getcellvalue', rowindex1, "vehicleid");
		                //alert("restricted0===="+restricted);
		                var restricted=restrictEdit();
		               // alert("restricted1===="+restricted);
		                if(restricted=="0"){
		                	$("#btnDelete").attr('disabled', true );
		                }else{
		                	$("#btnDelete").attr('disabled', false );
		                }
		                
		          }); 
      		
      		
      });
    

    function funFocus()
     {
	  document.getElementById("txtcode").focus();
     }

	
	function funReadOnly() {
		$('#frmRoute input').attr('readonly', true);
		$('#frmRoute select').attr('disabled', true);
        $('#txtvehgrp').attr('disabled', true);
        $('#txtdump').attr('disabled', true);       
        $('#txtdriver').attr('disabled', true);
        $('#txthelper').attr('disabled', true);
        $('#txthelper2').attr('disabled', true);
        $('#txtvehicle').attr('disabled', true);
        $('#txtarea').attr('disabled', true);

	}
	
	function funRemoveReadOnly() {
		$('#frmRoute input').attr('readonly', false);
		$('#frmRoute select').attr('disabled', false);
		 $('#txtvehgrp').attr('disabled', false);
	        $('#txtdump').attr('disabled', false);
	        $('#txtarea').attr('disabled', false);
	        $('#txtvehgrp').attr('readonly', true);
	        $('#txtdump').attr('readonly', true);
	        $('#txtarea').attr('readonly', true);
	        $('#txtdriver').attr('disabled', false);
	        $('#txthelper').attr('disabled', false);
	        $('#txthelper2').attr('disabled', false);
	        $('#txtvehicle').attr('disabled', false);
	      

	}
	
	function setValues()
	     {
			if($('#msg').val()!="")
			     {
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	      }
	
	$(function(){
	    $('#frmRoute').validate({
	             rules: {
	             txtcode: {required:true,maxlength:10},
	             txtname: {required:true,maxlength:200},
	             txtvehgrp:{required:true},
	             txtdump:{required:true},
	             txtarea:{required:true},
	             txtdriver:{required:true},
	             txthelper:{required:true},
	             txtvehicle:{required:true},

	            
	             },
	             messages: {
	              txtcode:{required:" *",maxlength:"Max 10 Chars."},
	              txtname:{required:" *",maxlength:"Max 200 Chars."},
	              txtvehgrp:{required:" *"},
	              txtdump:{required:" *"},
	              txtdriver:{required:" *"},
	              txthelper:{required:" *"},
	              txtvehicle:{required:" *"},
	              txtarea:{required:" *"},

	             
	             }
	    });});

	function getDump(event){
		 var x= event.keyCode;
    	 if(x==114){
    		 $('#dumpsearchwndow').jqxWindow('open');
    		 dumpinfoSearchContent('searchDump.jsp?', $('#dumpsearchwndow'));   
    	}
    	 else{
    		 
    	 }
	}
	function dumpinfoSearchContent(url) {
   	 //alert(url);
   		 $.get(url).done(function (data) {
   			 
   			 $('#dumpsearchwndow').jqxWindow('open');
   		$('#dumpsearchwndow').jqxWindow('setContent', data);
   
   	}); 
   	
   	}
	
	function getDriver(event){
		 var x= event.keyCode;
   	 if(x==114){
   		 $('#driversearchwndow').jqxWindow('open');
   		 driverinfoSearchContent('searchDriver.jsp?', $('#driversearchwndow'));   
   	}
   	 else{
   		 
   	 }
	}
	function driverinfoSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#driversearchwndow').jqxWindow('open');
  		$('#driversearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	
  	}
	
	function getHelper(event){
		 var x= event.keyCode;
   	 if(x==114){
   		 $('#helpersearchwndow').jqxWindow('open');
   		 helperinfoSearchContent('searchHelper.jsp?', $('#helpersearchwndow'));   
   	}
   	 else{
   		 
   	 }
	}
	function helperinfoSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#helpersearchwndow').jqxWindow('open');
  		$('#helpersearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	
  	}
	
	function getVehicle(event){
		 var x= event.keyCode;
		  
   	 if(x==114){
   		 $('#vehiclesearchwndow').jqxWindow('open');
   		 vehicleinfoSearchContent('searchVehicle.jsp?vehgrpids='+vehgrpid, $('#vehiclesearchwndow'));   
   	}
   	 else{
   		 
   	 }
	}
	function vehicleinfoSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#vehiclesearchwndow').jqxWindow('open');
  		$('#vehiclesearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	
  	}
	
	function getVehgrp(event){
		 var x= event.keyCode;
   	 if(x==114){
   		 $('#vehgrpsearchwndow').jqxWindow('open');
   		 vehgrpinfoSearchContent('searchVehgrp.jsp?', $('#vehgrpsearchwndow'));   
   	}
   	 else{
   		 
   	 }
	}
	
	function vehgrpinfoSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#vehgrpsearchwndow').jqxWindow('open');
  		$('#vehgrpsearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	}
	
	function getArea(event){
		 var x= event.keyCode;
   	 if(x==114){
   		 $('#areasearchwndow').jqxWindow('open');
   		 areainfoSearchContent('searchArea.jsp?', $('#areasearchwndow'));   
   	}
   	 else{
   		 
   	 }
	}
	
	function areainfoSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  			 $('#areasearchwndow').jqxWindow('open');
  		$('#areasearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	} 
	    
	function funNotify(){
		if(document.getElementById("txtcode").value==''){
			document.getElementById("errormsg").innerText="Code is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		/* return 1; */
		var retval  = restrictEdit();  
		if($("#mode").val()!="A"){
		   if(retval==0){     
		   		document.getElementById("errormsg").innerText="Please End Active Trip!";         
		   }else{
		 		document.getElementById("errormsg").innerText="";
		   } 
		  // alert($("#mode").val()+"retval==="+retval);
		}else{
			retval=1;
		}
		return retval;
	}
	
	function restrictEdit(){
        var retval = 1; 
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;  
						if(parseInt(items)>0){
							retval = 0;
							
						} else {
							retval = 1; 
							
						}
					}else {  
					}    
			}
			x.open("GET", "restrictEdit.jsp?driver="+$('#driverid').val()+"&vehicle="+$('#vehicleid').val(), false);                  
			x.send();
			 
		return retval; 
}
	
	function funChkButton() {
		  /* funReset(); */
		  }
		  
	/*function funSearchLoad(){
		changeContent('RouteSearch.jsp'); 
	 }*/
	function funExcelBtn(){
		 $("#jqxRouteSearch1").excelexportjs({
				containerid: "jqxRouteSearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxRouteSearch1",
				columns: getColumns("jqxRouteSearch1") ,
				worksheetName:"Route Details"
			}); 	   }
	
 
</script>
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRoute" action="saveRoute" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Route Details</legend>
<table width="100%">
  <tr>
   <td align="right">Code</td>
    <td><input type="text" name="txtcode" id="txtcode" placeholder="Code" value='<s:property value="txtcode"/>' ></td>
    <td width="11%" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="txtname" id="txtname"  placeholder="Name" style="width:80%;" value='<s:property value="txtname"/>' ></td>
    <td width="11%" align="right">Vehicle group</td>
 <td width="33%"><input type="text" id="txtvehgrp" name="txtvehgrp"  style="width:80%;"  placeholder="Press F3 To Search" onKeyDown="getVehgrp(event);" value='<s:property value="txtvehgrp"/>'>
   </tr>
   <tr>
    <td width="11%" align="right">Dumping site</td>
 <td width="33%"><input type="text" id="txtdump" name="txtdump" style="width:80%;"  placeholder="Press F3 To Search" onKeyDown="getDump(event);" value='<s:property value="txtdump"/>'>
    <td width="11%" align="right">Area</td>
 <td width="33%"><input type="text" id="txtarea" name="txtarea" style="width:80%;"  placeholder="Press F3 To Search" onKeyDown="getArea(event);" value='<s:property value="txtarea"/>'>
    
    </tr>
    <tr>
    <td width="11%" align="right">Driver Name</td>
    <td width="33%"><input type="text" id="txtdriver" name="txtdriver" style="width:80%;"  placeholder="Press F3 To Search" onKeyDown="getDriver(event);" value='<s:property value="txtdriver"/>'>
    <td width="11%" align="right">Helper</td>
    <td width="33%"><input type="text" id="txthelper" name="txthelper" style="width:80%;"  placeholder="Press F3 To Search" onKeyDown="getHelper(event);"  value='<s:property value="txthelper"/>'>
    
    </tr>
     <tr>
    <td width="11%" align="right">Helper2</td>
    <td width="33%"><input type="text" id="txthelper2" name="txthelper2" style="width:80%;"  placeholder="Press F3 To Search" onKeyDown="getHelper(event);"  value='<s:property value="txthelper2"/>'>
    <td width="11%" align="right">RegNo</td>
    <td width="33%"><input type="text" id="txtvehicle" name="txtvehicle" style="width:80%;"  placeholder="Press F3 To Search" onKeyDown="getVehicle(event);" value='<s:property value="txtvehicle"/>'>
    
    </tr>
 
</table>
</fieldset>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="dumpid" id="dumpid" value='<s:property value="dumpid"/>'/>
<input type="hidden" name="vehgrpid" id="vehgrpid" value='<s:property value="vehgrpid"/>'/>
<input type="hidden" name="areaid" id="areaid" value='<s:property value="areaid"/>'/>
<input type="hidden" name="driverid" id="driverid" value='<s:property value="driverid"/>'/>
<input type="hidden" name="helperid" id="helperid" value='<s:property value="helperid"/>'/>
<input type="hidden" name="vehicleid" id="vehicleid" value='<s:property value="vehicleid"/>'/>
<input type="hidden" name="helperid2" id="helperid2" value='<s:property value="helperid2"/>'/>

</form>
<div id="dumpsearchwndow">
   <div ></div>
   </div>
   <div id="driversearchwndow">
   <div ></div>
   </div><div id="helpersearchwndow">
   <div ></div>
   </div><div id="vehiclesearchwndow">
   <div ></div>
   </div>
   <div id="vehgrpsearchwndow">
   <div ></div>
   </div>
   <div id="areasearchwndow">
   <div ></div>
   </div>
</div>
<br/>
	<div id="jqxRouteSearch1"></div></div>
	
 		
	  
	
</body>
</html>