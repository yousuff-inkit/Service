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

	$(document).ready(function() {
				
		 $("#jqxIenqDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#clientinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Client Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
   	     $('#clientinfowindow').jqxWindow('close');
   	     
   	     $('#cpinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#cpinfowindow').jqxWindow('close');
	     
	     $('#ownerinfowindow').jqxWindow({ width: '31%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Project Owner Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
   	     $('#ownerinfowindow').jqxWindow('close');
   	     
   	     $('#vendorinfowindow').jqxWindow({ width: '31%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Vendor Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#vendorinfowindow').jqxWindow('close');
	     
	     $('#specdetinfowindow').jqxWindow({ width: '40%', height: '68%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Specification Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#specdetinfowindow').jqxWindow('close');
		  
		 $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#areainfowindow').jqxWindow('close');
		  
		 $('#inspinfowindow').jqxWindow({ width: '31%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: ' Inspector Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#inspinfowindow').jqxWindow('close');
		  
		 $('#frequencyinfowindow').jqxWindow({ width: '25%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Frequency Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#frequencyinfowindow').jqxWindow('close'); 
		  
		 $('#typeinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Type Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	   	 $('#typeinfowindow').jqxWindow('close');
	   	  
	   	 $('#addressinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Address Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	 $('#addressinfowindow').jqxWindow('close');
	 	  
	 	 $('#tradeinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Trade Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	 $('#tradeinfowindow').jqxWindow('close');
		  
		 $('#procwindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Process Details' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#procwindow').jqxWindow('close');
		 
		 $('#inspdetailsinfowindow').jqxWindow({ width: '31%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: ' Inspector Details' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#inspdetailsinfowindow').jqxWindow('close');
		      
		 /*Menu-minimized window */ 
         $('#menuwindow').jqxWindow({width: '71%', height: '58%',  maxHeight: '70%' ,maxWidth: '71%' , title: 'Details',position: { x: 180, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#menuwindow').jqxWindow('close');
 		 
 		 
 		$('#salesManDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#salesManDetailsWindow').jqxWindow('close');
		 /* Time */
         /* $("#jqxTime").jqxDateTimeInput({ width: '23%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
         $("#jqxResponseTime").jqxDateTimeInput({ width: '50%', height: '17px', formatString: 'HH:mm', showCalendarButton: false }); */
         
         /* create jqxMenu */
        /*  $("#jqxMenuMore").jqxMenu({ width: '22%', height: '26px', autoSizeMainItems: true});
         $("#jqxMenuMore").jqxMenu('minimize');            
         $("#jqxMenuMore").css('visibility', 'visible'); */
 		 
 		$('#txtclientname').dblclick(function(){
 		      clientSearchContent('clientDetailsSearch.jsp');
			  });
 		
 		$('#txtprojectowner').dblclick(function(){
 		      ProjectOwnerSearchContent('projectOwnerDetailsSearch.jsp'); 
			  });
 		
 		$('#txtvendor').dblclick(function(){
 			   ProjectVendorSearchContent('projectVendorDetailsSearch.jsp?vendortype=0'); 
			  });
 		
 		$('#txtsubsupplier').dblclick(function(){
			   ProjectVendorSearchContent('projectVendorDetailsSearch.jsp?vendortype=1'); 
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
    });
	
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
	
	function ProjectOwnerSearchContent(url) {
	    $('#ownerinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ownerinfowindow').jqxWindow('setContent', data);
		$('#ownerinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function ProjectVendorSearchContent(url) {
	    $('#vendorinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vendorinfowindow').jqxWindow('setContent', data);
		$('#vendorinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function specdetSearchContent(url) {
	    $('#specdetinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#specdetinfowindow').jqxWindow('setContent', data);
		$('#specdetinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function areaSearchContent(url) {
	    $('#areainfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#areainfowindow').jqxWindow('setContent', data);
		$('#areainfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function inspdetSearchContent(url) {
	    $('#inspinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#inspinfowindow').jqxWindow('setContent', data);
		$('#inspinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function frequencySearchContent(url) {
	    $('#frequencyinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#frequencyinfowindow').jqxWindow('setContent', data);
		$('#frequencyinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function typeSearchContent(url) {
	    $('#typeinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#typeinfowindow').jqxWindow('setContent', data);
		$('#typeinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function addressSearchContent(url) {
	    $('#addressinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#addressinfowindow').jqxWindow('setContent', data);
		$('#addressinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function tradeSearchContent(url) {
	    $('#tradeinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#tradeinfowindow').jqxWindow('setContent', data);
		$('#tradeinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function procContent(url) {
	    $('#procwindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#procwindow').jqxWindow('setContent', data);
		$('#procwindow').jqxWindow('bringToFront');
	}); 
	}
	
	function inspdetailsSearchContent(url) {
	    $('#inspdetailsinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#inspdetailsinfowindow').jqxWindow('setContent', data);
		$('#inspdetailsinfowindow').jqxWindow('bringToFront');
	}); 
	}
		
	function menuContent(url) {
	 	 $.get(url).done(function (data){
		 $('#menuwindow').jqxWindow('open');
		 $('#menuwindow').jqxWindow('setContent', data);
		 $('#menuwindow').jqxWindow('bringToFront');
	  }); 
	} 
	
	function getEnqStatus() {
		 var formcode=document.getElementById("formdetailcode").value;
	     var statusid=document.getElementById("estatusid").value;
	     var docno=document.getElementById("docno").value;
	
		 var curprocessid,status;
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				items= x.responseText;
				items=items.split('####');
				curprocessid=items[0];
				status=items[1];
				document.getElementById("estatusid").value=curprocessid;
				document.getElementById("enqstatus").innerText=status;
				if(curprocessid!=0){
					getNxtprocess(curprocessid);
					funGridHide();
				}
				
			    $("#guidelinesDiv").load('guidelinesGrid.jsp?estatusid='+curprocessid);
				
				if($('#estatusid').val()==0){
					$('#selectprocess').attr("hidden", "true");
					$('#btnSave').attr('disabled', false);
					$('#btnCancel').attr('disabled', false);
				}
				else{
					$('#selectprocess').attr("disabled",false);
				}
				
				if($('#estatusid').val()>=1){
					
					$('#status').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					$('#btnCancel').attr('disabled', true);
				 	$('#btnEdit').attr('disabled', true);
				 	$('#btnPrint').attr('disabled', true);
				 	$('#btnDelete').attr('disabled', true);
				} else{
					$('#selectprocess').attr("disabled",false);
				}
				funGridHide();
			} else
			{
			}
	}
	x.open("GET","getEnqStatus.jsp?statusid="+statusid+"&dtype="+formcode+"&docno="+docno+"&formcode="+formcode,true);
	x.send();
   }
	
	function getNxtprocess(curprocessid) {
		var x=new XMLHttpRequest();
		var items,nxtprocIdItems,nxtprocItems;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					items= x.responseText;
			        items=items.split('####');
			        nxtprocIdItems=items[0].split(",");
			        nxtprocItems=items[1].split(",");
			        
			        var nxtprocoptions = '';  
		            for ( var i = 0; i < nxtprocItems.length; i++) {
		            	nxtprocoptions += '<option value="' + nxtprocIdItems[i] + '">' + nxtprocItems[i] + '</option>';
				        }
		            $("select#cmbselectprocess").html(nxtprocoptions);
		            $("select#hidcmbselectprocess").html(nxtprocoptions);
				}
			else {
				}
		}
		x.open("GET","getNxtProcess.jsp?curprocessid="+curprocessid,true);
		x.send();
	}
	
	/* function ajaxcallforcostestimate(cearray,enq_id){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			
			 
			    var gridlength=$('#cegridlenth').val(); 
			   
			    if(itemval=gridlength)
			    	{
			    //$.messager.alert('Message', '  Record Successfully Allocated ');
			    	$('#inspgridlenth').val(""); 
			    	 //funreload(event);
			   
			    	}
			}
		else
			{
			
			}
		}
		x.open("GET","saveceGrid.jsp?cearray="+cearray+"&enq_id="+enq_id,true);
		x.send();
	} */
	
	function ajaxcall(insp_id,priority,enq_id) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {
				    var items= x.responseText;
				 	var itemval=items.trim();
				    var gridlenght=$('#inspgridlenth').val(); 
				   
				    if(itemval=gridlenght) {
				    	//$.messager.alert('Message', '  Record Successfully Allocated ');
				    	$('#inspgridlenth').val(""); 
				    	 //funreload(event);
				    }
			} else {	
			}
		}
		x.open("GET","saveinspectorGrid.jsp?insp_id="+insp_id+"&priority="+priority+"&enq_id="+enq_id,true);
		x.send();
	}
	
	function fundetupdate() {
			var statusid=document.getElementById("cmbselectprocess").value;
			var remarks=document.getElementById("txtremarks").value;
			var docno=document.getElementById("docno").value;
			var inspgridlenth=document.getElementById("inspgridlenth").value;
			var estatusid=document.getElementById("estatusid").value;
		
		 	var x = new XMLHttpRequest();
		  	x.onreadystatechange = function() {
		   		if (x.readyState == 4 && x.status == 200) {
		    		var item=x.responseText.trim();
				    if(item>0) {
	   	
		    			if((estatusid!=4)||(estatusid!=5)){
		    				$.messager.alert('Message',"Updated Successfully");
		    			}
	   	
	   					getEnqStatus();
	   					funGridHide();    	
					    
	   					return true;
	   				} else	{
						$.messager.alert('Message',"Not Updated");
						return  false;
		 			}
		    
		   } else {
		   }
		  }
		  x.open("GET","nxtprocessupdate.jsp?statusid="+statusid+"&docno="+docno+"&remarks="+remarks+"&inspgridlenth="+inspgridlenth, true);
		  x.send();  
	}
	
	function funReadOnly(){
		$('#frmEnquiry input').attr('readonly', true );
		$('#frmEnquiry textarea').attr('readonly', true );
		$('#txtclientname').attr('disabled', true);
		$('#txtcontactperson').attr('disabled', true);
		$('#txtprojectowner').attr('disabled', true);
		$('#txtvendor').attr('disabled', true);
		$('#txtsubsupplier').attr('disabled', true);
		$('#txtremarks').attr('readonly', false );
		$('#txttempspecdocno').attr('readonly', false );
		$('#clientcurrate').attr('readonly', true );
		$('#jqxIenqDate').jqxDateTimeInput({disabled: true});
		/* $('#jqxTime').jqxDateTimeInput({disabled: true});
		$('#jqxResponseTime').jqxDateTimeInput({disabled: true}); */
		$("#jqxJobDetails").jqxGrid({ disabled: true});
	/* 	$("#jqxGuidelines").jqxGrid({ disabled: true}); */
		//$('#jqxFieldPersonDetails').jqxGrid({ disabled: true});
		/* $('#jqxCostEstimateGrid').jqxGrid({ disabled: true}); */
 	}
	function funRemoveReadOnly(){
		$('#frmEnquiry input').attr('readonly', false );
		$('#frmEnquiry select').attr('disabled', false);
		$('#frmEnquiry textarea').attr('readonly', false );
		
		$('#txtclientname').attr('disabled', false);
		$('#txtcontactperson').attr('disabled', false);
		$('#txtprojectowner').attr('disabled', false);
		$('#txtvendor').attr('disabled', false);
		$('#txtsubsupplier').attr('disabled', false);
		$('#txtclientname').attr('readonly', true );
		//$('#txtclientdet').attr('readonly', true );
		//$('#txtcontactperson').attr('readonly', true );
		$('#txttelnoarea').attr('readonly', true );
		$('#txtprojectowner').attr('readonly', true );
		$('#txtvendor').attr('readonly', true );
		$('#txtsubsupplier').attr('readonly', true );	
		$('#clientcurrate').attr('readonly', true );
		$('#jqxIenqDate').jqxDateTimeInput({disabled: false});
		/* $('#jqxTime').jqxDateTimeInput({disabled: false});
		$('#jqxResponseTime').jqxDateTimeInput({disabled: false}); */
		$('#docno').attr('readonly', true);
		$("#jqxJobDetails").jqxGrid({ disabled: false});
		/* $("#jqxGuidelines").jqxGrid({ disabled: false}); */
		//$('#jqxFieldPersonDetails').jqxGrid({ disabled: false});
		/* $('#jqxCostEstimateGrid').jqxGrid({ disabled: false}); */
		
		if ($("#mode").val() == "A") {
			$('#jqxIenqDate').val(new Date());
			/* $('#jqxTime').val(new Date());
			$('#jqxResponseTime').val(new Date()); */
			$("#jqxJobDetails").jqxGrid('clear');
			$("#jqxJobDetails").jqxGrid('addrow', null, {});
		/* 	$("#jqxGuidelines").jqxGrid('clear'); */
			/* $("#jqxCostEstimateGrid").jqxGrid('clear'); */
			/* document.getElementById("enqstatus").innerText="";
			getEnqStatus(); */
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
	 
	  /* $(function(){
	        $('#frmEnquiry').validate({
	                rules: {
	                txtfromaccid:"required"
	                 },
	                 messages: {
	                 txtfromaccid:" *"
	                 }
	        });}); */
	
	  function funNotify(){
	        	
	        	 /* Job Details Grid  Saving*/
				 var rows = $("#jqxJobDetails").jqxGrid('getrows');
				 var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].qty;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
					newTextBox.val(rows[i].serviceid+" :: "+rows[i].comodityid+" :: "+rows[i].tradeid+" :: "+rows[i].areaid+" :: "+rows[i].qty+" :: "+rows[i].description+" :: "+rows[i].startdate+" :: "+rows[i].enddate+":: "+rows[i].frequencyid+"");
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#jobdetgridlenth').val(length);
	 		   /* Job Details Grid  Saving Ends*/	 

	 		   return 1;
	 }
	        
	 function setValues() {
 			//getEnqStatus();
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
     			$("#jqxIenqDate").jqxDateTimeInput('val', $('#hidjqxIenqDate').val());
     		}
     	   
     		if($('#hidjqxTime').val()){
     			$("#jqxTime").jqxDateTimeInput('val', $('#hidjqxTime').val());
     		}
     		
     		if($('#hidjqxRe sponseTime').val()){
     			$("#jqxResponseTime").jqxDateTimeInput('val', $('#hidjqxResponseTime').val());
     		}

     		if($('#msg').val()!=""){
 			   $.messager.alert('Message',$('#msg').val());
 			  }
 		  
 		    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 		    funSetlabel();
	      	   
	      	var maindoc=document.getElementById("docno").value;
	      	if(maindoc>0) {
	       		var indexVal1 = document.getElementById("docno").value;
	       		$("#jobDetailsDiv").load('jobDetailsGrid.jsp?enqdocno='+indexVal1);
	      	}
	      	  
	      	// delvalueChange();
	      	/*document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; */
	      	
	      }
	  
	 function getclient(event){
         var x= event.keyCode;
         if(x==114){
        	 clientSearchContent('clientDetailsSearch.jsp');
         }
         else{
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
         else{
          }
         }
	 
	 function getProjectOwner(event){
         var x= event.keyCode;
         if(x==114){
        	 ProjectOwnerSearchContent('projectOwnerDetailsSearch.jsp');
         }
         else{
          }
         }
	 
	 function getProjectVendor(event){
         var x= event.keyCode;
         if(x==114){
        	 ProjectVendorSearchContent('projectVendorDetailsSearch.jsp?vendortype=0'); 
         }
         else{
          }
         }
	 
	 function getSubsupplier(event){
         var x= event.keyCode;
         if(x==114){
        	 ProjectVendorSearchContent('projectVendorDetailsSearch.jsp?vendortype=1'); 
         }
         else{
          }
         }
	 
	 function getspec(){
	         specdetSearchContent('specificationsDetailsSearch.jsp');  
	 }
	 
	 function getareas(){
	         areaSearchContent('areaDetailsSearch.jsp');
	 }
	 
	 function getinsp(){
	         inspdetSearchContent('inspectorDetailsSearch.jsp');  
	 }
	 
	 function getfrequency(){
	         frequencySearchContent('frequency.jsp');
	 }
	 
	 function processdetails(){
			 var edocno=document.getElementById("docno").value;
			 procContent('processdetails.jsp?edocno='+edocno); 
	 }
	
	function inspdetails(){
		 var edocno=document.getElementById("docno").value;
		 var estatusid=document.getElementById("estatusid").value;
		 if(estatusid<=2){
			    document.getElementById("errormsg").innerText="Inspector Details are Not Available.";
				return 0;
		 }
		 document.getElementById("errormsg").innerText="";
		 inspdetailsSearchContent('inspectorsDetailsGrid.jsp?enq_id='+edocno);
	   }
	
	function referencedetails(){
		  var docno=document.getElementById("docno").value;
		  var formcode=document.getElementById("formdetailcode").value;
          menuContent('referenceDetails.jsp?docno='+docno+'&formCode='+formcode); 
    }

	function communicationdetails(){
		  var docno=document.getElementById("docno").value;
		  var formcode=document.getElementById("formdetailcode").value;
	      menuContent('communicationDetails.jsp?docno='+docno+'&formCode='+formcode);         
	} 	

	function  funGridHide(){
		  var enq_id=document.getElementById("docno").value;
	      var estatusid=$('#estatusid').val();
		  if($('#estatusid').val()==2){
		       $('#FieldPerDiv').show();
		       $('#FieldPerDiv').load('FieldPersonnel.jsp?enq_id='+enq_id);
		       $('#selectprocesshidefieldperson').show();
		       $('#selectprocesshidefieldperson1').show();
		       $('#selectprocesshidenofieldperson').hide();
		       $('#selectprocesshidenofieldperson1').hide();
		  } else{
			   $('#FieldPerDiv').hide();
			   $('#selectprocesshidefieldperson').hide();
		       $('#selectprocesshidefieldperson1').hide();
		       $('#selectprocesshidenofieldperson').show();
		       $('#selectprocesshidenofieldperson1').show();
		  }
	
		  if(($('#estatusid').val()==4)||($('#estatusid').val()==5)){
			   /* $('#InspCostingDiv').load('InspectorCostGrid.jsp?enq_id='+enq_id); */
		       /* $('#CostingDiv').load('CostEstimateGrid.jsp?enq_id='+enq_id+'&estatusid='+estatusid);
		       $('#CostingDiv').show(); */
		       /* $('#InspCostingDiv').show(); */
		       /* $('#clcurrateDiv').show(); */
		  } else {
		       /* $('#clcurrateDiv').hide(); */
     		   /* $('#CostingDiv').hide(); */
		       /* $('#InspCostingDiv').hide(); */	  
	      }
     } 

	function funUpdate(){
	
		  var statusid=document.getElementById("cmbselectprocess").value;
		  var remarks=document.getElementById("txtremarks").value;
		  var docno=document.getElementById("docno").value;
		  var inspgridlenth=document.getElementById("inspgridlenth").value;
		  var estatusid=document.getElementById("estatusid").value;
		  if(remarks.trim()==""){
				document.getElementById("errormsg").innerText="Remarks is Mandatory in ";
				return 0;
		  }
      	  document.getElementById("errormsg").innerText="";
      	 
		  if(estatusid==2){
		
				var inspdata=$('#jqxFieldPersonDetails').jqxGrid('getcellvalue',0, "inspname");

				if(inspdata==null || inspdata==""){
					$.messager.confirm('Confirm', 'Do you want to continue without Field Personal Details?', function(r){
						if (r){
							getInspGrid();
							fundetupdate();
						} else {
							return 0;
						}
					});
				} else {
					getInspGrid();
					fundetupdate();
				}
		} else if((estatusid==4)||(estatusid==5)){
				if(parseInt($('#cmbselectprocess').val())==6){
					getCostingConfirmed($('#docno').val());
				} else {
					fundetupdate();
				}
		} else {
				fundetupdate();
		}
	 }
	
 	 function getInspGrid(){
		 
		 	 var enq_id=document.getElementById("docno").value;
		     var rows = $("#jqxFieldPersonDetails").jqxGrid('getrows');
		     $('#inspgridlenth').val(rows.length); 
		     
			   for(var i=0 ; i < rows.length ; i++){
					var saveval=i+1;
					 ajaxcall(rows[i].insp_id,rows[i].priority,enq_id);
			   }   
	 }
		
	 /*function getCostEstimateGrid(){
			 
		 var enq_id=document.getElementById("docno").value;
		 var estatusid=document.getElementById("estatusid").value;
		 
		 var rows = $("#jqxCostEstimateGrid").jqxGrid('getrows');
		 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].cefield_id;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+length)
				    .attr("name", "test"+length)
					.attr("hidden", "true");
					length=length+1;
					
			newTextBox.val(rows[i].nh+" :: "+rows[i].hh+" :: "+rows[i].th+" :: "+rows[i].e8h+" :: "+rows[i].h8h+" :: "+rows[i].t10h+" :: "+rows[i].h10h+" :: "+rows[i].e22dx8h+":: "+rows[i].e22hx8h+":: "+rows[i].t22dx10h+":: "+rows[i].t22hx10h+":: "+rows[i].ot8+":: "+rows[i].ot10+":: "+rows[i].hot8+":: "+rows[i].hot10+":: "+rows[i].magekm+":: "+rows[i].magemi+":: "+rows[i].perdium+":: "+rows[i].lodging+":: "+rows[i].carexp+":: "+rows[i].trainexp+":: "+rows[i].busexp+":: "+rows[i].taxiexp+":: "+rows[i].flightexp+":: "+rows[i].mealsexp+":: "+rows[i].tollexp+":: "+rows[i].fuelexp+":: "+rows[i].otherexp+":: "+rows[i].cefield_id+"");
			newTextBox.appendTo('form');
			 }
			}
 		 	$('#cegridlenth').val(length);
			
	 	   if(estatusid=4&&$('#cegridlenth').val()>0){
	 		  document.getElementById('frmEnquiry').submit();
	 	   }
		}*/
		
		function getCostingConfirmed(enquiryno){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==0){
	  					$.messager.alert('Message','Costing Need To Be Confirmed.','warning');
	  					 return 0;
	  				 } else {
	  					fundetupdate();
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getCostingConfirmed.jsp?enquiryno="+enquiryno, true);
		x.send();
	   }
		function setChange(){
			 var chkval=0;
			 chkval=$('#custid').val();
			 if(parseInt(chkval)==1){
				 $('#txtclientname').hide();
				 //('#frmEnquiryfrn input').attr('readonly', false );
				 //document.getElementById('txtclientname').removeAttribute('readonly');
				 document.getElementById('txtclientdet').readOnly =false;
				 document.getElementById('txtcontactperson').removeAttribute('placeholder');
				 document.getElementById("clientid").value="0";
			 }
			 else{
				 $('#txtclientname').show();
				 document.getElementById("txtcontactperson").setAttribute("placeholder","Press F3 To Search");
			 }
		 }
		
		function getsalinfo(event){
	        var x= event.keyCode;
	        if(x==114){
	        	salesmanSearchContent('salesManDetailsSearch.jsp');
	        }
	        else{}
	        }
		
		  function salesmanSearchContent(url) {
		   		$('#salesManDetailsWindow').jqxWindow('open');
		   		$.get(url).done(function (data) {
		   		$('#salesManDetailsWindow').jqxWindow('setContent', data);
		   		$('#salesManDetailsWindow').jqxWindow('bringToFront');
		   	}); 
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

<form id="frmEnquiry" action="saveenquiry" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset style="background-color: #ECF8E0;">
<table width="100%" >
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="30%"><div id="jqxIenqDate" style="width:40%;" name="jqxIenqDate" value='<s:property value="jqxIenqDate"/>'></div>
    <input type="hidden" id="hidjqxIenqDate" name="hidjqxIenqDate" value='<s:property value="hidjqxIenqDate"/>'/>
    
  <td width="5%" align="right"> New Client<input type="checkbox" id="custid" name="custid" onchange="setChange();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /></td></td>
   <%--  <td width="3%" align="right">Time</td>
    <td width="14%"><div id='jqxTime' name='jqxTime'  value='<s:property value="jqxTime"/>'></div>
                   <input type="hidden" id="hidjqxTime" name="hidjqxTime" value='<s:property value="hidjqxTime"/>'/></td> --%>
    <td width="7%" align="right">Ref. No.</td>
    <td width="19%"><input type="text" id="txtrefno" name="txtrefno" style="width:60%;"  value='<s:property value="txtrefno"/>'/></td>
    <%-- <td width="10%" align="right">Response Time</td>
    <td width="7%"><div id='jqxResponseTime' name='jqxResponseTime'  value='<s:property value="jqxResponseTime"/>'></div>
                   <input type="hidden" id="hidjqxResponseTime" name="hidjqxResponseTime" value='<s:property value="hidjqxResponseTime"/>'/></td> --%>
    <td width="5%" align="right">Doc No.</td>
    <td width="8%"><input type="text" id="docno" name="docno" readonly style="width:95%;" value='<s:property value="docno"/>' tabindex="-1"/>
    </td>
   <!--  <td width="8%" align="center"><div id='jqxMenuMore' title="More" align="center" style='visibility: hidden;'>
         <ul>
       	    <li><a href="#referencedetails" onclick="referencedetails();">Reference Details</a></li>
            <li><a href="#communicationdetails" onclick="communicationdetails();">Communication Details</a></li>
            <li><a href="#processdetails" onclick="processdetails();">Process Details</a></li>
            <li><a href="#inspdetails" onclick="inspdetails();">Inspector Details</a></li>               
         </ul>
     </div></td> -->
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><input type="text" id="txtclientname" readonly placeholder="Press F3 to Search" name="txtclientname" style="width:20%;" onkeydown="getclient(event);"  value='<s:property value="txtclientname"/>'/>
    <input type="text" id="txtclientdet"  name="txtclientdet" style="width:70%;" value='<s:property value="txtclientdet"/>'/>
   
    <input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
    <input type="hidden" id="clientcurid" name="clientcurid" value='<s:property value="clientcurid"/>'/>
     </td>
   
    <%-- <td colspan="5"><input type="text" id="txttelnoarea" name="txttelnoarea" readonly style="width:85%;" placeholder="Telephone No., Area" value='<s:property value="txttelnoarea"/>'/></td> --%>
   
  </tr>
  <tr>
   <td align="right">Contact Person</td>
    <td><input type="text" id="txtcontactperson" name="txtcontactperson"  placeholder="Press F3 to Search" style="width:90%;" onkeydown="getcontactperson(event);" value='<s:property value="txtcontactperson"/>'/>
    <input type="hidden" id="cptrno" name="cptrno"  value='<s:property value="cptrno"/>'/></td>
  <td width="2%" align="right">Address</td> 
    <td colspan="2"><input type="text" id="txtaddress" name="txtaddress" style="width:90%;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();"></td>
    <td width="4%" align="right">Salesman</td>
   <td width="10%"><input type="text" id="txtsalesman" name="txtsalesman" style="width:90%;" placeholder="Press F3 To Search" value='<s:property value="txtsalesman"/>' onKeyDown="getsalinfo(event);" onfocus="disfields();">
   <input type="hidden" id="txtsalesmandocno" name="sal_id" value='<s:property value="sal_id"/>'></td>
  </tr>
   <tr>
    <td align="right" width="1%">MOB</td>
    <td  width="6%"><input type="text" id="txtmobile" name="txtmobile" style="width:30%;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();"></td>
   <td width="2%" align="right">Tel</td>     
    <td width="6%"><input type="text" id="txttelno" name="txttelno" style="width: 90%;" value='<s:property value="txttelno"/>' onfocus="reqdata();disfields();"></td>
   <td width="4%" align="right" colspan="2">Email</td>
    <td ><input type="text" id="txtemail" name="txtemail" style="width: 90%;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();"></td>
  </tr>
  <%-- <tr>
    <td align="right">Project Owner</td>
    <td colspan="3"><input type="text" id="txtprojectowner" name="txtprojectowner" readonly style="width:90%;" placeholder="Press F3 to Search" onkeydown="getProjectOwner(event);"  value='<s:property value="txtprojectowner"/>'/>
    <input type="hidden" id="projectownerid" name="projectownerid" value='<s:property value="projectownerid"/>'/></td>
    <td align="right">Vendor</td>
    <td><input type="text" id="txtvendor" name="txtvendor" readonly style="width:100%;" placeholder="Press F3 to Search" onkeydown="getProjectVendor(event);" value='<s:property value="txtvendor"/>'/>
    <input type="hidden" id="vendorid" name="vendorid" value='<s:property value="vendorid"/>'/></td>
    <td align="right">Sub Supplier</td>
    <td colspan="4"><input type="text" id="txtsubsupplier" readonly name="txtsubsupplier" style="width:80%;" placeholder="Press F3 to Search" onkeydown="getSubsupplier(event);" value='<s:property value="txtsubsupplier"/>'/>
    <input type="hidden" id="subvendorid" name="subvendorid" value='<s:property value="subvendorid"/>'/></td> 
  </tr> --%>
</table>
</fieldset>

<fieldset style="background: #F6FFE1;"><legend>Job Details</legend>
<div id="jobDetailsDiv"><jsp:include page="jobDetailsGrid.jsp"></jsp:include></div>
</fieldset>

<%-- <table width="100%">
 <tr>
   <td width="70%"><div id="InspCostingDiv" hidden="true"><jsp:include page="InspectorCostGrid.jsp"></jsp:include></div></td>
 </tr>
 <tr>
   <td><div id="clcurrateDiv" hidden="true">Client Currency Rate&nbsp;&nbsp;&nbsp;<input type="text" id="clientcurrate" readonly name="clientcurrate" value='<s:property value="clientcurrate"/>'/></div></td>
 </tr>
 <tr>
   <td width="70%"><div id="CostingDiv" hidden="true"><fieldset style="background: #F1FFFD;"><legend>Costing</legend><jsp:include page="CostEstimateGrid.jsp"></jsp:include></fieldset></div>
 </tr>
</table>

<table width="100%">
  <tr>
    <td width="70%">
	    <div id="FieldPerDiv"><jsp:include page="FieldPersonnel.jsp"></jsp:include></div>
    	<fieldset style="background: #FFEEEE;"><legend>Guidelines</legend>
    		<div id="guidelinesDiv"><jsp:include page="guidelinesGrid.jsp"></jsp:include></div>
    	</fieldset>
    </td>
    <td width="30%">
    	<div id="selectprocess"><fieldset style="background: #F8E0F7;">
    		<table width="100%">
    			<tr id="selectprocesshidenofieldperson">
    				<td colspan="2">&nbsp;<br/><br/><br/></td>
    			</tr>
    			<tr id="selectprocesshidefieldperson">
    				<td colspan="2">&nbsp;<br/><br/><br/><br/><br/><br/></td>
    			</tr>
  				<tr>
    				<td width="12%" align="right">Remarks</td>
    				<td width="88%"><input type="text" id="txtremarks" name="txtremarks" style="width:100%;" value='<s:property value="txtremarks"/>'/></td>
  				</tr>
  				<tr>
    				<td align="right">Process</td>
    				<td><select id="cmbselectprocess" name="cmbselectprocess" style="width:50%;" value='<s:property value="cmbselectprocess"/>'>
      					<option value="">--Select--</option></select>
      					<input type="hidden" id="hidcmbselectprocess" name="hidcmbselectprocess" value='<s:property value="hidcmbselectprocess"/>'/></td>
  				</tr>
  				<tr>
    				<td colspan="2">&nbsp;</td>
  				</tr>
  				<tr>
    				<td colspan="2" align="center"><button class="myButton" type="button" id="btnNextProcess"  name="btnNextProcess" onclick="funUpdate();">Next Process</button></td>
  				</tr>
  				<tr id="selectprocesshidenofieldperson1">
    				<td colspan="2">&nbsp;<br/><br/><br/></td>
    			</tr>
    			<tr id="selectprocesshidefieldperson1">
    				<td colspan="2">&nbsp;<br/><br/><br/><br/><br/><br/><br/></td>
    			</tr>
			</table>
		</fieldset></div>
    </td>
  </tr>
</table>  --%>

<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
<input type="hidden" id="txttempspecdocno" name="txttempspecdocno" value='<s:property value="txttempspecdocno"/>'/>
<input type="hidden" id="jobdetgridlenth" name="jobdetgridlenth" value='<s:property value="jobdetgridlenth"/>'/>
<input type="hidden" id="inspgridlenth" name="inspgridlenth" value='<s:property value="inspgridlenth"/>'/>
<input type="hidden" id="cegridlenth" name="cegridlenth" value='<s:property value="cegridlenth"/>'/>

</div>
</form>

<div id="clientinfowindow">
   <div></div>
</div>
   
<div id="cpinfowindow">
   <div></div>
</div>

<div id="ownerinfowindow">
   <div></div>
</div>
   
<div id="vendorinfowindow">
   <div></div>
</div>
   
<div id="specdetinfowindow">
   <div></div>
</div>
   
<div id="areainfowindow">
   <div></div>
</div>
    
<div id="inspinfowindow">
   <div></div>
</div>

<div id="frequencyinfowindow">
   <div></div>
</div>

<div id="addressinfowindow">
   <div></div>
</div>

<div id="typeinfowindow">
   <div></div>
</div>

<div id="tradeinfowindow">
   <div></div>
</div>

<div id="procwindow">
   <div></div>
</div>

<div id="inspdetailsinfowindow">
   <div></div>
</div>

<div id="menuwindow">
   <div style="background-color: #E0ECF8;"></div>
</div> 
<div id="salesManDetailsWindow">
   <div ></div>
</div>
</div>
</body>
</html>