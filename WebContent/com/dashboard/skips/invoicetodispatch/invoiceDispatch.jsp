<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<style type="text/css">
.myButtons {
  display: inline-block;
  margin-right:4px;
  margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	 getbankname();             
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>"); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	  document.getElementById("contractchk").checked=true;   
	 $('#contractDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Contract Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#contractDetailsWindow').jqxWindow('close');
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1));  
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	  $('#txtcontract').dblclick(function(){   
		  contractSearchContent('contractDetailsSearchGrid.jsp');   
		});
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function contractSearchContent(url) {
	 	$('#contractDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	function getContract(event){  
	    var x= event.keyCode;
	    if(x==114){
  		    contractSearchContent('contractDetailsSearchGrid.jsp');      
	    }
	    else{}
	    }
	
 
	 function funExportBtn(){
		 $("#notInvoicedDiv").excelexportjs({
				containerid: "notInvoicedDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "rentalInvoiceGrid", 
				columns: getColumns("rentalInvoiceGrid") ,   
				worksheetName:"Invoices to be dispatched"  
				});
	 }

	function  funClearData(){
		 $('#txtclientname').val('');$('#txtcldocno').val('');$('#todate').val(new Date());
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		 $('#fromdate').val(onemounth);
         $('#todate').val(new Date());
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		 }
		 $("#rentalInvoiceGrid").jqxGrid('clear'); 
		 $('#printdocno').val('');
		 $('#hiddocno').val('');  
		 document.getElementById("selectedlbl").innerHTML="";
		 $('#hidvocno').val('');
		 $('#hidbrhid').val('');   
	 }
	
	function funreload(event){
		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		  var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		  if(fromdates>todates){
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		       return false;
		  }else{
			   var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
			   if(docdateval==0){
					$('#todate').jqxDateTimeInput('focus');
					return false;
		        }
				 var branchval = document.getElementById("cmbbranch").value;
				 var fromdate = $('#fromdate').val();
				 var todate = $('#todate').val();
				 var cldocno = $('#txtcldocno').val();
				 var contrno = $('#contrno').val();
				 var contractchk=0;
				 if(document.getElementById("contractchk").checked){
					 contractchk=1;  
				 }
				 $("#overlay, #PleaseWait").show(); 
				 $("#notInvoicedDiv").load("InvoiceGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&contrno='+contrno+'&contractchk='+contractchk);    
	      }
	 }
	
	 function funPrint(){    
		    $('#rentalInvoiceGrid').jqxGrid('clearfilters', true);    
			var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
			if(selectedrows.length==0){
				$.messager.alert('Warning','Please select valid invoice');
				return false;
			}
			document.getElementById("printdocno").value="";
			for(var i=0;i<selectedrows.length;i++){
				if(i==0){
					document.getElementById("printdocno").value+=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
				}
				else{
					document.getElementById("printdocno").value+=":"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
				}
			}  
	        var bankdocno = $("#cmbprintbankname").val();     
	      	     var url=document.URL;  
	      	     var reurl=url.split("com/");   
	      	     $("#docno").prop("disabled", false);  
	      	     console.log(reurl[0]);  
	      	     var win= window.open(reurl[0]+"printmultipageInvoice?docno="+document.getElementById("printdocno").value+"&branch="+document.getElementById("hidbrhid").value+"&bankdocno="+bankdocno+"&header=2","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      		 win.focus();  
	      
	    } 
	
	function funDispatchData(){
		$('#rentalInvoiceGrid').jqxGrid('clearfilters', true);    
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		document.getElementById("printdocno").value="";
		for(var i=0;i<selectedrows.length;i++){
			if(i==0){
				document.getElementById("printdocno").value+=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
			else{
				document.getElementById("printdocno").value+=":"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
		}
		$.messager.confirm('Message', 'Do you want to dispatch invoices?', function(r){  
			if(r==false) {
				return false; 
			} else {
				dispatchData(document.getElementById("printdocno").value);  
			}
		});  	
	}
	function dispatchData(printdocno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	if(parseInt(items)>0){
			 		$.messager.alert('Message','Record Successfully Dispatched','warning');   
			 	}
			 	else{
			 		$.messager.alert('Message','Not Dispatched','warning');
			 	}
			 	funreload(event);
	    }
		}
	     x.open("GET","dispatchData.jsp?invno="+encodeURIComponent(printdocno),true);   
	    x.send(); 
	}
	function funsendemail(){
		var docno=$('#hiddocno').val();
		if(docno=="" || docno=="0"){    
			$.messager.alert('Warning','Please select valid invoice');  
			return false;
		}
		$.messager.confirm('Message', 'Do you want to send mail?', function(r){  
			if(r==false) {
				return false; 
			} else {
				sendemail();
			}
		});  
	}
	function sendemail(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim().split("####");
				var email="";
				var cldocno="";
				var msg="";      
				var client="";
				var subject="";    
				//console.log(items[0]+"="+items[1]+"="+items[2]);  
				if(items!=""){
					 msg=items[0];
				     email=items[1];
				     cldocno=items[2];
				     subject=items[3];   
				}
				var brchid=document.getElementById("hidbrhid").value;
				var userid="<%= session.getAttribute("USERID").toString() %>";       
		   		var contrctno=document.getElementById("hiddocno").value;       
		   		//console.log(items[1]+"="+items[2]+"="+items[3]+"="+items[0]);     
		   		var frmdet="SINV";        
		   		var dtype="SINV";        
		   		var fname="Invoice";  
		   		var reftype="INVD"; 
		   		var cc="invoice@mrskips.net";    
		   		console.log("=IN Email=");   
		   		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&cc="+encodeURIComponent(cc)+"&docno="+contrctno+"&brchid="+brchid+"&frmname="+fname+"&reftype="+reftype+"&recipient="+email+"&cldocno="+cldocno+"&client="+encodeURIComponent(client)+"&userid="+userid+"&dtype="+frmdet+"&subject="+encodeURIComponent(subject)+"&msg="+encodeURIComponent(msg),"E-Mail","menubar=0,resizable=1,width=900,height=950");
		   	}
		}      
		x.open("GET","sendMail.jsp?docno="+$('#hiddocno').val(),true);                
		x.send();   
	}

	function funSendingEmail(){
		var bankdocno = $("#cmbprintbankname").val();
		$('#rentalInvoiceGrid').jqxGrid('clearfilters', true);  
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		document.getElementById("printdocno").value="";
		var val=0;  
		for(var i=0;i<selectedrows.length;i++){
			var email=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'email'); 
			if(email=="" || email=="0"){
				val=1;
				break;   
			}
			if(i==0){
				document.getElementById("printdocno").value+=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
			else{
				document.getElementById("printdocno").value+=":"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
		}
		if(val>0){  
			$.messager.alert('Warning','Selected documents have Invalid email address');      
			return false;
		}
		$.messager.confirm('Message', 'Do you want to send mail?', function(r){  
			if(r==false) {
				return false; 
			} else {
				$("#overlay, #PleaseWait").show();
				   
		 		$.ajaxFileUpload ({    
		 			
		    	    	  url: "printManualInvoiceJasper.action?printdocno="+document.getElementById("printdocno").value+"&bankdocno="+bankdocno+"&allbranch=1",  
		    	    	  type:'POST',		  
		    	          secureuri:false,//false  
		    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
		    	          dataType: 'string',// json      
		    	          success: function (data, status) {  
		    	             if(status=='success'){
		    	            	 funreload(event);
								$("#overlay, #PleaseWait").hide();
								$.messager.alert('Message','E-Mail Send Successfully');
		    	              }
		    	             if(status=='error'){
		    	            	 funreload(event);   
		    	            	 $("#overlay, #PleaseWait").hide();
		    	            	 $.messager.alert('Message','E-Mail Sending failed');
		    	             }
		    	             
		    	              //$("#testImg").attr("src",data.message);
		    	              if(typeof(data.error) != 'undefined')  
		    	              {  
		    	                  if(data.error != '')  
		    	                  {  
		    	                      alert(data.error);  
		    	                  }else  
		    	                  {  
		    	                      alert(data.message);  
		    	                  }  
		    	              }  
		    	          },  
		    	           error: function (data, status, e)
		    	          {  
		    	              alert(e);  
		    	          }  
		    	      }) 
		    	     return false;
			}
		});  	
	}
	
	function funsendContractemail(){ 
		var bankdocno = $("#cmbprintbankname").val();
		$('#rentalInvoiceGrid').jqxGrid('clearfilters', true);  
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		document.getElementById("printdocno").value="";
		var val=0;
		for(var i=0;i<selectedrows.length;i++){
			var email=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'email'); 
			if(email=="" || email=="0"){
				val=1;
				break;   
			}
			if(i==0){
				document.getElementById("printdocno").value+=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
			else{
				document.getElementById("printdocno").value+=":"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
		}
		if(val>0){  
			$.messager.alert('Warning','Selected documents have Invalid email address');      
			return false;
		}
		$.messager.confirm('Message', 'Do you want to send mail?', function(r){  
			if(r==false) {
				return false; 
			} else {
				$("#overlay, #PleaseWait").show();
				   
		 		$.ajaxFileUpload ({    
		 			
		    	    	  url: "printManualInvoiceContractJasper.action?printdocno="+document.getElementById("printdocno").value+"&bankdocno="+bankdocno+"&allbranch=1",  
		    	    	  type:'POST',		  
		    	          secureuri:false,//false  
		    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
		    	          dataType: 'string',// json      
		    	          success: function (data, status) {  
		    	             if(status=='success'){
		    	            	 funreload(event);
								$("#overlay, #PleaseWait").hide();
								$.messager.alert('Message','E-Mail Send Successfully');
		    	              }
		    	             if(status=='error'){
		    	            	 funreload(event);   
		    	            	 $("#overlay, #PleaseWait").hide();
		    	            	 $.messager.alert('Message','E-Mail Sending failed');
		    	             }
		    	             
		    	              //$("#testImg").attr("src",data.message);
		    	              if(typeof(data.error) != 'undefined')  
		    	              {  
		    	                  if(data.error != '')  
		    	                  {  
		    	                      alert(data.error);  
		    	                  }else  
		    	                  {  
		    	                      alert(data.message);  
		    	                  }  
		    	              }  
		    	          },  
		    	           error: function (data, status, e)
		    	          {  
		    	              alert(e);  
		    	          }  
		    	      }) 
		    	     return false;
			}
		});  	
	}
	
	function getbankname() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var banknameItems = items[0].split(",");
				var bankIdItems = items[1].split(",");
				
				var optionsbanknames = '<option value="">--Select--</option>';  
				for (var i = 0; i < banknameItems.length; i++) {
					optionsbanknames += '<option value="' + bankIdItems[i] + '">'
							+ banknameItems[i] + '</option>';
				}
				$("select#cmbprintbankname").html(optionsbanknames);
				
			} else {
			}
		}
		x.open("GET", "getBankName.jsp", true);
		x.send();
	}
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
    <tr><td align="right"><label class="branch">Contract No</label></td>
	<td align="left"><input type="text" id="txtcontract" name="txtcontract" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getContract(event);" value='<s:property value="txtcontract"/>'/>
    <input type="hidden" id="contrno" name="contrno" value='<s:property value="contrno"/>'/></td></tr> 
     <tr> <td align="right"><input type="checkbox" id="contractchk" name="contractchk"/></td>  
     <td align="left"><label class="branch">Order By Contract</label></td> </tr>    
	<tr><td colspan="2">&nbsp;</td></tr>  
	<tr><td colspan="2" align="center"><label class="branch" id="selectedlbl"></label></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
    <tr><td width="20%" align="right"><label class="branch">Bank</label></td>    
        <td colspan="2"><select id="cmbprintbankname" name="cmbprintbankname" style="width:65%;" value='<s:property value="cmbprintbankname"/>'>
                        <option value="0">--Select--</option></select></td>
    </tr>        
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
	<input type="button" class="myButtons" name="print" id="print"  value="Print" onclick="funPrint();"> 
	<input type="button" class="myButtons" name="dispatch" id="dispatch"  value="Dispatch" onclick="funDispatchData();">
	</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="btnmail" id="btnmail" value="Send Mail" onclick="funsendemail();"></td></tr>  
		<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="btnmail" id="btnmail" value="Send Mail Contract Wise" onclick="funsendContractemail();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="notInvoicedDiv"><jsp:include page="InvoiceGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="contractDetailsWindow">
	<div></div><div></div>
</div>
<input type="hidden" name="printdocno" id="printdocno">
<input type="hidden" name="hiddocno" id="hiddocno">
<input type="hidden" name="hidbrhid" id="hidbrhid"> 
<input type="hidden" name="hidvocno" id="hidvocno"> 
<input type="hidden" name="msgs" id="msgs" value='<s:property value="msgs"/>'/>  
</div> 
</body>
</html>