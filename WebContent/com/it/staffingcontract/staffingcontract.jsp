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
		 $('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#enquirywindow').jqxWindow('close'); 
	     $('#desiginfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Designation Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#desiginfowindow').jqxWindow('close');
		
		 $('#clientinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Client Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
   	     $('#clientinfowindow').jqxWindow('close');
   	     
   	     $('#cpinfowindow').jqxWindow({ width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#cpinfowindow').jqxWindow('close');
		 
	     $('#specdetinfowindow').jqxWindow({ width: '40%', height: '68%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Specification Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#specdetinfowindow').jqxWindow('close');
		
		 $('#employeeowindow').jqxWindow({ width: '40%', height: '68%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Employee Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#employeeowindow').jqxWindow('close');
	   
 		$('#salesManDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#salesManDetailsWindow').jqxWindow('close');
		 $("#jqxcontractDetails").jqxGrid({ disabled: true});

		 $('#jqxIenqDate').on('change', function (event) {   
			  getTaxper(); 
		 });
		 
 		$('#txtclientname').dblclick(function(){
 		      clientSearchContent('clientINgridsearch.jsp');
			  });
         $('#txtrefno').dblclick(function(){
	 		 
 			var clientid=document.getElementById("clientid").value;
 			var reftype=document.getElementById("cmbreftype").value;
 			
 		 	if(clientid>0 || reftype=='ENQ'){
 		 		
 		 		document.getElementById("errormsg").innerText="";
 		 		
 		 	}
 		 	else{
 		 		document.getElementById("errormsg").innerText="Select a client";
 		 		
 		 		return 0;
 		 	} 
 	 		 
 	 		if($('#mode').val()!= "view")
 	   		{
 	 		 changeContent('enqMastersearch.jsp'); 
 	   		}
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
	   
	    getCurrencyIds($("#jqxIenqDate").val());
    });
	
	function getspec(){
	    specdetSearchContent('specificationsDetailsSearch.jsp');  
	 }
	 
	 function getEmployee(){
	    employeeSearchContent('employeeDetailsSearch.jsp');  
	 }
	 
	function specdetSearchContent(url) {
	    $('#specdetinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#specdetinfowindow').jqxWindow('setContent', data);
		$('#specdetinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function employeeSearchContent(url) {
	    $('#employeeowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeowindow').jqxWindow('setContent', data);
		$('#employeeowindow').jqxWindow('bringToFront');
	}); 
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
	
		function desigSearchContent(url) {
	    $('#desiginfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#desiginfowindow').jqxWindow('setContent', data);
		$('#desiginfowindow').jqxWindow('bringToFront');
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
			 	 else{
			 		 }
			 	 }
			    	 
		function enquirySearchContent(url) {
				 $.get(url).done(function (data) {
				$('#enquirywindow').jqxWindow('setContent', data);
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
	
		function funReadOnly(){
		$('#frmStaffingContract input').attr('readonly', true );
		$('#frmStaffingContract textarea').attr('readonly', true );
		$('#cmbcurr').attr('disabled', true);
		$('#txtclientname').attr('disabled', true);
		$('#txtcontactperson').attr('disabled', true);
		$('#txtprojectowner').attr('disabled', true);
		$('#txtvendor').attr('disabled', true);
		$('#txtsubsupplier').attr('disabled', true);
		$('#txtremarks').attr('readonly', false );
		$('#txttempspecdocno').attr('readonly', false );
		$('#jqxIenqDate').jqxDateTimeInput({disabled: true});
		$('#jqxIfrmDate').jqxDateTimeInput({disabled: true});
		$('#jqxItoDate').jqxDateTimeInput({disabled: true});

		if(mod1=="A"){
			document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			funCreateBtn();
		}

		/* $('#jqxTime').jqxDateTimeInput({disabled: true});
		$('#jqxResponseTime').jqxDateTimeInput({disabled: true}); */
		$("#jqxcontractDetails").jqxGrid({ disabled: true});
	/* 	$("#jqxGuidelines").jqxGrid({ disabled: true}); */
		//$('#jqxFieldPersonDetails').jqxGrid({ disabled: true});
		/* $('#jqxCostEstimateGrid').jqxGrid({ disabled: true}); */
 	}
		
		function funRemoveReadOnly(){
		
		$('#frmStaffingContract input').attr('readonly', false );
		$('#frmStaffingContract select').attr('disabled', false);
		$('#frmStaffingContract textarea').attr('readonly', false );
		
		$('#cmbcurr').attr('disabled', false);
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
		$('#jqxIenqDate').jqxDateTimeInput({disabled: false});
		$('#jqxIfrmDate').jqxDateTimeInput({disabled: false});
		$('#jqxItoDate').jqxDateTimeInput({disabled: false});
		refChange();
		
		/* $('#jqxTime').jqxDateTimeInput({disabled: false});
		$('#jqxResponseTime').jqxDateTimeInput({disabled: false}); */
		$('#docno').attr('readonly', true);
		$('#txtenqtype').attr('readonly', true);
		
		$("#jqxcontractDetails").jqxGrid({ disabled: false});
		/* $("#jqxGuidelines").jqxGrid({ disabled: false}); */
		//$('#jqxFieldPersonDetails').jqxGrid({ disabled: false});
		/* $('#jqxCostEstimateGrid').jqxGrid({ disabled: false}); */
		
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
				
				//funrate();
		        
				$("#contractDiv").load('staffingContractGrid.jsp?reftype=ENQ&refno='+'<%=enqdocno%>');
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
	 
	  /* $(function(){
	        $('#frmStaffingContract').validate({
	                rules: {
	                txtfromaccid:"required"
	                 },
	                 messages: {
	                 txtfromaccid:" *"
	                 }
	        });}); */
	
		function funNotify(){
	        	 /* Job Details Grid  Saving*/
				 var rows = $("#jqxcontractDetails").jqxGrid('getrows');
				 var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var types="";
						var costtype="";
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
							if (rows[i].type =="Hourly") {
							   	types=1;
								}
							else if (rows[i].type =="Daily") {
							   	types=2;
								}
							else if (rows[i].type =="Monthly") {
							   	types=3;
							}
								
							if (rows[i].costtype =="Hourly") {
							   	costtype=1;
								}
							else if (rows[i].costtype =="Daily") {
							   	costtype=2;
								}
							else if (rows[i].costtype =="Monthly") {
							   	costtype=3;
							}
							
							
					newTextBox.val(rows[i].desigid+" :: "+types+" :: "+rows[i].rate+" :: "+rows[i].cost+" :: "+rows[i].rowno+" :: "+rows[i].rdocno+" :: "+rows[i].serviceid+" :: "+rows[i].tradeid+" :: "+rows[i].comodityid+" :: "+rows[i].empid+" :: "+rows[i].clientbillrate+" :: "+costtype+" :: "+rows[i].clientcost+" :: ");
					
					newTextBox.appendTo('form');
					}
		 		 $('#gridlength').val(length);
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
     	
		    if($('#hidjqxIfrmDate').val()){
     			$("#jqxIfrmDate").jqxDateTimeInput('val', $('#hidjqxIfrmDate').val());
     		}
     		
			if($('#hidjqxItoDate').val()){
     			$("#jqxItoDate").jqxDateTimeInput('val', $('#hidjqxItoDate').val());
     		}
			
			if($('#clientcurid').val()){
     			$("#cmbcurr").val($('#clientcurid').val());
     		}
			
			if($('#hidcmbreftype').val()){
     			$("#cmbreftype").val($('#hidcmbreftype').val());
     		}
			
			if($('#hidpholiday').val()){
     			$("#cmbpholiday").val($('#hidpholiday').val());
     		}

     		if($('#msg').val()!=""){
 			   $.messager.alert('Message',$('#msg').val());
 			}
 		  
 		    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 		    funSetlabel();
	      	   
	      	var maindoc=document.getElementById("masterdoc_no").value;
	      	if(maindoc>0) {
	       		$("#contractDiv").load('staffingContractGrid.jsp?docno='+maindoc);
	      	}
	      	  
	      	// delvalueChange();
	      	/*document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; */
	      }
	  
	    function getclient(event){
         var x= event.keyCode;
         if(x==114){
        	 clientSearchContent('clientINgridsearch.jsp');
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
				 //('#frmStaffingContractfrn input').attr('readonly', false );
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
			
		function getCurrencyIds(a){  
					        	   var x=new XMLHttpRequest();
					        	   x.onreadystatechange=function(){
					        	   if (x.readyState==4 && x.status==200)
					        	    {
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
					        	        	
								        	if(document.getElementById("docno").value=="")  
								        		{
													funRoundRate(currateItems,"clientcurrate");
													funCalculateClientRate(null);
								        		}
									        					        	          
					        	       }
					        	   
					        	          else{
					        	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
					        	           
					        	          $("select#cmbcurr").html(optionscurr);
					        	           
					        	             if ($('#clientcurid').val() != null && $('#clientcurid').val() != "") {
												$('#cmbcurr').val($('#clientcurid').val()) ;
												funrate();
					        	             } 
					        	         	if(document.getElementById("docno").value=="")
							        		{
							        		  
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
				var billrate=$('#jqxcontractDetails').jqxGrid('getcellvalue', rowindex, "rate");
				var cost=$('#jqxcontractDetails').jqxGrid('getcellvalue', rowindex, "cost");
				
				var clientbillrate=(billrate*clientrate).toFixed(2);
				var clientcost=(cost*clientrate).toFixed(2);
				
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowindex, "clientbillrate",clientbillrate);
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowindex, "clientcost",clientcost);
			}else{
				var rows = $("#jqxcontractDetails").jqxGrid('getrows');
				for(var i=0 ; i < rows.length ; i++){
					var billrate=$('#jqxcontractDetails').jqxGrid('getcellvalue', i, "rate");
					var cost=$('#jqxcontractDetails').jqxGrid('getcellvalue', i, "cost");
				
					var clientbillrate=(billrate*clientrate).toFixed(2);
					var clientcost=(cost*clientrate).toFixed(2);
				
					$('#jqxcontractDetails').jqxGrid('setcellvalue', i, "clientbillrate",clientbillrate);
					$('#jqxcontractDetails').jqxGrid('setcellvalue', i, "clientcost",clientcost);
				}
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

<form id="frmStaffingContract" action="savestaffingcontract" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset style="background-color: #ECF8E0;">
<table width="100%" >
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="2%"><div id="jqxIenqDate" style="width:40%;" name="jqxIenqDate" value='<s:property value="jqxIenqDate"/>'></div>
    <input type="hidden" id="hidjqxIenqDate" name="hidjqxIenqDate" value='<s:property value="hidjqxIenqDate"/>'/>
    
  <td hidden="true"width="5%" align="right"> New Client<input type="checkbox" id="custid" name="custid" onchange="setChange();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /></td></td>
   <%--  <td width="3%" align="right">Time</td>
    <td width="14%"><div id='jqxTime' name='jqxTime'  value='<s:property value="jqxTime"/>'></div>
                   <input type="hidden" id="hidjqxTime" name="hidjqxTime" value='<s:property value="hidjqxTime"/>'/></td> --%>
    <td colspan="5"></td>
    <td width="1%" align="right" colspan="2">Ref. No.</td>
    <td width="5%"><select id="cmbreftype" name="cmbreftype" style="width:70%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
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
    <td colspan="6" width="15%"><input type="text" id="txtclientdet"  name="txtclientdet" style="width:97.5%;" value='<s:property value="txtclientdet"/>'/>
   
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
	
	    <td width="5%">Rate &nbsp; <input type="text" style="width:48%;"  name="clientcurrate" id="clientcurrate" onchange="funCalculateClientRate(null);" value='<s:property value="clientcurrate"/>'></td>
	 
  </tr>
  <tr>
   <td align="right">Contact Person</td>
    <td colspan="7" width="15%"><input type="text" id="txtcontactperson" name="txtcontactperson"  placeholder="Press F3 to Search" style="width:98%;" onKeyDown="getcontactperson(event);" value='<s:property value="txtcontactperson"/>'/>
    <input type="hidden" id="cptrno" name="cptrno"  value='<s:property value="cptrno"/>'/></td>
    
    <td width="1%" align="right">Salesman</td>
   <td  colspan="4"><input type="text" id="txtsalesman" name="txtsalesman" style="width:100%;" placeholder="Press F3 To Search" value='<s:property value="txtsalesman"/>' onKeyDown="getsalinfo(event);" onfocus="disfields();">
   <input type="hidden" id="txtsalesmandocno" name="txtsalesmandocno" value='<s:property value="txtsalesmandocno"/>'></td>
     <td align="right" width="1%" colspan="2">MOB</td>
    <td  width="6%"><input type="text" id="txtmobile" name="txtmobile" style="width:60%;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();">
   
  </tr>
   <tr>
   <td width="2%" align="right">From</td>
    <td width="2%"><div id="jqxIfrmDate" style="width:40%;" name="jqxIfrmDate" value='<s:property value="jqxIfrmDate"/>'></div></td>
    
     <td width="0.7%" align="right">To</td>
     <td width="2%"><div id="jqxItoDate" style="width:40%;" name="jqxItoDate" value='<s:property value="jqxItoDate"/>'></div>
    <input type="hidden" id="hidjqxIfrmDate" name="hidjqxIfrmDate" value='<s:property value="hidjqxIfrmDate"/>'/>
    <input type="hidden" id="hidjqxItoDate" name="hidjqxItoDate" value='<s:property value="hidjqxItoDate"/>'/> 
     </td>
     
    <td width="3%" align="right">Public Holiday</td>
    <td width="3%"><select id="cmbpholiday" name="cmbpholiday" style="width:100%;" value='<s:property value="cmbpholiday"/>'>
      <option value="1">Yes</option>
      <option value="0">No</option>
      </select>
      <input type="hidden" id="hidpholiday" name="hidpholiday" value='<s:property value="hidpholiday"/>'/>
     </td>
    
    <td width="2%" align="right">Tax Per</td>
    <td width="2%"><input type="text" id="txttaxper" name="txttaxper" style="width: 80%;text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txttaxper"/>'></td>
    
    
   <td width="1%" align=right >Email</td>
    <td colspan="4"><input type="text" id="txtemail" name="txtemail" style="width: 100%;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();"></td>
 <td align="right" width="1%" colspan="2">Tel</td>
    <td  width="6%"><input type="text" id="txttelno" name="txttelno" style="width: 60%;" value='<s:property value="txttelno"/>' onfocus="reqdata();disfields();"></td>
 </tr>
  
</table>
</fieldset>


<fieldset style="background: #F6FFE1;"><legend>Contract</legend>
<div id="contractDiv"><jsp:include page="staffingContractGrid.jsp"></jsp:include></div>
</fieldset>


<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
<input type="hidden" id="txttempspecdocno" name="txttempspecdocno" value='<s:property value="txttempspecdocno"/>'/>
<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
<input type="hidden" id="inspgridlenth" name="inspgridlenth" value='<s:property value="inspgridlenth"/>'/>
<input type="hidden" id="cegridlenth" name="cegridlenth" value='<s:property value="cegridlenth"/>'/>
<input type="hidden" id="enquiryid" name="enquiryid" value='<s:property value="enquiryid"/>'/>

</div>
</form>

<div id="clientinfowindow">
   <div></div>
</div>
   
<div id="cpinfowindow">
   <div></div>
</div>


<div id="desiginfowindow">
   <div></div>
</div>
    

<div id="enquirywindow">
   <div ></div>
   </div>

<div id="specdetinfowindow">
   <div></div>
</div> 

<div id="employeeowindow">
   <div></div>
</div> 


<div id="salesManDetailsWindow">
   <div ></div>
</div>
</div>
</body>
</html>