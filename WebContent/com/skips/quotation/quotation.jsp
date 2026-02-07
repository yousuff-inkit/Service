<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../includes.jsp"></jsp:include>     
<style>
form label.error {
  color:red;
  font-weight:bold;
}
#calcshowlbl{
   color:blue;
}
#statusval{
color: blue;
}
</style> 
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String qottrno =request.getParameter("qottrno")==null?"0":request.getParameter("qottrno").toString();  

String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String enqdocno =request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").toString();
String vocno =request.getParameter("vocno")==null?"0":request.getParameter("vocno").toString();
String mail=request.getParameter("mail")==null?"0":request.getParameter("mail").toString();
String mob=request.getParameter("mob")==null?"0":request.getParameter("mob").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String telno=request.getParameter("telno")==null?"0":request.getParameter("telno").toString();
String source=request.getParameter("source")==null?"0":request.getParameter("source").toString();
String sourceid=request.getParameter("sourceid")==null?"0":request.getParameter("sourceid").toString();
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
String salid=request.getParameter("salid")==null?"0":request.getParameter("salid").toString();
String salesman=request.getParameter("salesman")==null?"":request.getParameter("salesman").toString(); 
String mod=request.getParameter("mod")==null?"":request.getParameter("mod").toString(); 
String cperson=request.getParameter("cperson")==null?"":request.getParameter("cperson").toString(); 
String cpersonid=request.getParameter("cpersonid")==null?"":request.getParameter("cpersonid").toString();  
String designation=request.getParameter("designation")==null?"":request.getParameter("designation").toString();  
String grpname=request.getParameter("grpname")==null?"":request.getParameter("grpname").toString();    
%>
<script type="text/javascript">
var modes='<%=modes%>';
var qottrno='<%=qottrno%>';  
var mod1='<%=mod%>';
var enqdocno='<%=enqdocno%>';
var brhid='<%=brhid%>';  
 $(document).ready(function () { 
   	 $("#quoteDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 
     $('#enqsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Enquiry Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#enqsearch').jqxWindow('close');
     $('#salesManDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#salesManDetailsWindow').jqxWindow('close');
     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
     $('#sourcesearchwndow').jqxWindow('close');
     $('#cpinfowindow').jqxWindow({ width: '35%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#cpinfowindow').jqxWindow('close');
     $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#areainfowindow').jqxWindow('close');
 	 $('#skipinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Skip Size Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#skipinfowindow').jqxWindow('close');
 	 $('#wasteinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Waste Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#wasteinfowindow').jqxWindow('close');
 	 $('#surveytypewindow').jqxWindow({ width: '35%', height: '45%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 300, y: 87 }, keyboardCloseKey: 27});
	 $('#surveytypewindow').jqxWindow('close');
	 $('#specinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Spec Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#specinfowindow').jqxWindow('close');
	 $('#otherdetailsinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#otherdetailsinfowindow').jqxWindow('close');
 	 $('#othercontractsinfowindow').jqxWindow({ width: '80%', height: '58%',  maxHeight: '85%' ,maxWidth: '90%' ,title: ' Other Contracts ' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#othercontractsinfowindow').jqxWindow('close');  
	 $('#pendingquotesinfowindow').jqxWindow({ width: '90%', height: '58%',  maxHeight: '85%' ,maxWidth: '95%' ,title: ' Pending Quotes ' , position: { x: 100, y: 60 }, keyboardCloseKey: 27});
	 $('#pendingquotesinfowindow').jqxWindow('close');   
	 $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#printWindow').jqxWindow('close');
 	 $('#contactinfowindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '65%' , title: 'Contact Person Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#contactinfowindow').jqxWindow('close');
	 $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'SalesMan Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#Salesagentinfowindow').jqxWindow('close');
     $('#txtenquiry').dblclick(function(){  
    	$('#enqsearch').jqxWindow('open');  
	       enquirySearchContent('enquirysearch.jsp?', $('#enqsearch'));         
       });
       $('#txtcperson').dblclick(function(){
    	     var enqdoc=document.getElementById("txtenquiry").value;
    		 var cldocno=document.getElementById("hidcldocno").value;  
    		 if(enqdoc==""){      
    				document.getElementById("errormsg").innerText="Please select enquiry first";  
    				return 0;
    		 }
	     	$('#contactinfowindow').jqxWindow('open');    
	     	contactSearchContent('Searchcontact.jsp?cldocno='+cldocno, $('#contactinfowindow'));           
        });
       $('#txtsalesman').dblclick(function(){
 		  $('#Salesagentinfowindow').jqxWindow('open');
 	      salesagentSearchContent('SearchSalesman.jsp?');   
	   });  
   });  
 function getsalesAgent(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#Salesagentinfowindow').jqxWindow('open');
  salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); }
 	 else{
 		 }
 	 }

function salesagentSearchContent(url) {
             $.get(url).done(function (data) {  
           $('#Salesagentinfowindow').jqxWindow('setContent', data);
   	}); 
}
 function getcontact(event){
	 var enqdoc=document.getElementById("txtenquiry").value;
	 var cldocno=document.getElementById("hidcldocno").value;  
	 if(enqdoc==""){      
			document.getElementById("errormsg").innerText="Please select enquiry first";  
			return 0;
	 }  
  	 var x= event.keyCode;
  	 if(x==114){
	  	  $('#contactinfowindow').jqxWindow('open');
	      contactSearchContent('Searchcontact.jsp?cldocno='+cldocno); 
	 } else{
  		 }
  }
  function contactSearchContent(url) {
      $.get(url).done(function (data) {
       $('#contactinfowindow').jqxWindow('setContent', data);

     }); 
  }
  function funPrintBtn() {      
	  var docVal1 = document.getElementById("masterdoc_no").value;
      if(docVal1=="" || docVal1=="0") {    
    		$.messager.alert('Message','Select a Document....!','warning');
			return 0;
     }else{
         var multioption=$("#multioptionprintconfig").val();  
         console.log("IN PRINT = "+multioption);
         if(parseInt(multioption)==1){       
        	 console.log("IN PRINT = "+multioption);
        	 quotePrintContent('printVoucherWindow.jsp');    
    	 }else{
    		 console.log("IN PRINT = "+multioption);
    	     var url=document.URL;
    	     var reurl=url.split("com/");   
    	     $("#docno").prop("disabled", false);  
    	     console.log(reurl[0]);  
    	     var win= window.open(reurl[0]+"printQuotationSkip?docno="+document.getElementById("masterdoc_no").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    		 win.focus();  
    	 }
     }
  }  
  function quotePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
  }
          function brandinfoSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#brandsearchwndow').jqxWindow('open');
      		$('#brandsearchwndow').jqxWindow('setContent', data);
      
      	}); 
      	} 
          function modelinfoSearchContent(url) {
           	 //alert(url);
           		 $.get(url).done(function (data) {
           			 
           			 $('#modelsearchwndow').jqxWindow('open');
           		$('#modelsearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	} 
          function sourceinfoSearchContent(url) {
            	 //alert(url);
            		 $.get(url).done(function (data) {
            			 
            			 $('#sourcesearchwndow').jqxWindow('open');
            		$('#sourcesearchwndow').jqxWindow('setContent', data);
            
            	}); 
            	} 
    
	       function text()
	       {
	    	   var url=document.URL;
	      
			var reurl=url.split("com/");
	       top.addTab("Client",reurl[0]+"com/controlcentre/masters/client/clientMaster.jsp");
	     
	       }
    function funReset(){
		//$('#frmQuotation')[0].reset(); 
	}
	function funReadOnly(){ 
		$('#frmQuotation input').prop('readonly', true );
		$('#frmQuotation textarea').attr('readonly', true );
		$('#frmQuotation select').attr('disabled', true);
		$("#siteGrid").jqxGrid({ 'disabled': true});
		$('#quoteDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxQuote").jqxGrid({ disabled: true});
	    $("#revbtn").attr('disabled', true );
	    $('#txtenquiry').attr('disabled', true);
	    $('#txtcperson').attr('disabled', true);
	    $("#btnothercontracts").attr('disabled', true );
	    $("#btnpendingquotes").attr('disabled', true );
	    if(mod1=="A") {
		    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			funCreateBtn();  
		}
	    if(modes=="view") {       
			document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
			Setviewmode(qottrno);  
		}
	}  
	function funRemoveReadOnly(){  
		$('#frmQuotation input').attr('readonly', false );
		$('#frmQuotation textarea').attr('readonly', false );
		$('#frmQuotation select').attr('disabled', false);
		$('#txtgroupcompanies').attr('readonly', true); 
		$('#txtsource').attr('readonly', true);
		$('#txtenquiry').attr('readonly', true);
		$('#txtclient').attr('readonly', true);
		$('#txtsalesman').attr('readonly', true);
		$('#txtdesig').attr('readonly', true);
		$('#txtsource').attr('readonly', true);  
		$('#txtmail').attr('readonly', true);
		$('#txtaddress').attr('readonly', true);
		$('#txtmob').attr('readonly', true);
		$('#txttele').attr('readonly', true);  
		$("#siteGrid").jqxGrid({ disabled: false});
		$('#quoteDate').jqxDateTimeInput({ disabled: false}); 
		$("#jqxQuote").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		$("#revbtn").attr('disabled', true );
		$("#btnothercontracts").attr('disabled', false );
		$("#btnpendingquotes").attr('disabled', false );
		$('#txtenquiry').attr('disabled', false);
		$('#txtcperson').attr('disabled', false);  
		$('#txtrevise').attr('readonly', true);  
		$('#txtcperson').attr('readonly', true);   
		getmultilineconfig();
		document.getElementById('statusval').innerHTML="";    
		if ($("#mode").val() == "A") {
			 $('#quoteDate').val(new Date());
		     $("#jqxQuote").jqxGrid('clear');
		     $("#jqxQuote").jqxGrid('addrow', null, {});
		     $("#siteGrid").jqxGrid('clear');
			 $("#siteGrid").jqxGrid('addrow', null, {});
			 document.getElementById('calcshowlbl').innerHTML="";
		}
		
		if ($("#mode").val() == "E") {
			   $("#jqxQuote").jqxGrid('addrow', null, {}); 
			   var cldocno = $('#hidcldocno').val();  
	           if(cldocno=="" || cldocno=="0"){  
		        	$('#txtmail').attr('readonly', false);
		       		$('#txtmob').attr('readonly', false);
		       		$('#txttele').attr('readonly', false);  
		            $('#txtcperson').attr('readonly', false);
	           }else{
	        	    $('#txtmail').attr('readonly', true);
		       		$('#txtmob').attr('readonly', true);
		       		$('#txttele').attr('readonly', true);  
		            $('#txtcperson').attr('readonly', true);    
	           }
		}
		if (mod1 == "A") {
			 document.getElementById("txtsalesman").value='<%=salesman%>';
			 document.getElementById("txtsalesmandocno").value='<%=salid%>';  
		     document.getElementById("txtenquiry").value='<%=vocno%>';
	         document.getElementById("hidenqdocno").value='<%=enqdocno%>';
	         document.getElementById("txtclient").value='<%=client%>';
	         document.getElementById("hidcldocno").value='<%=cldocno%>';
	         document.getElementById("txtsource").value='<%=source%>';
	         document.getElementById("sourceid").value='<%=sourceid%>';
			 document.getElementById("txtmail").value='<%=mail%>';
			 document.getElementById("txtaddress").value='<%=address%>';
			 document.getElementById("txtmob").value='<%=mob%>';
			 document.getElementById("txttele").value='<%=telno%>';
			 document.getElementById("txtcperson").value='<%=cperson%>'; 
			 document.getElementById("hidcpersonid").value='<%=cpersonid%>'; 
			 document.getElementById("txtdesig").value='<%=designation%>';
			 document.getElementById("txtgroupcompanies").value='<%=grpname%>';   
			 var indexVal2 = '<%=enqdocno%>';  
	         $("#quotdiv").load("quoteDetails.jsp?enqdocno="+indexVal2+"&id="+1);  
	         $("#sitediv").load("siteGrid.jsp?enqdocno="+indexVal2+"&id="+1); 
	  }
	}
	function Setviewmode(qottrno){ 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			 	var items= x.responseText;
			 	items=items.split('###');
			
			 	$('#quoteDate').jqxDateTimeInput({ disabled: false});
			 	document.getElementById("txttele").value=items[0];
			 	document.getElementById("masterdoc_no").value=items[1];
	            document.getElementById("docno").value=items[2];
	             
	      	    $('#quoteDate').val(items[3]);
			    document.getElementById("txtdesc").value=items[4];
			    document.getElementById("hidcldocno").value=items[5];
		        document.getElementById("txtclient").value=items[6];
			    document.getElementById("txtaddress").value=items[7]; 
			    document.getElementById("txtmob").value=items[8];
			    document.getElementById("txtmail").value=items[9];
			    document.getElementById("cmbbillingmethod").value=items[10];
			    document.getElementById("hidcmbbillingmethod").value=items[10];
			    document.getElementById("sourceid").value=items[11];
			    document.getElementById("txtsource").value=items[12];
			    document.getElementById("txtenquiry").value=items[13];
			    document.getElementById("hidenqdocno").value=items[14];
			    document.getElementById("txtsalesmandocno").value=items[15];
			    document.getElementById("txtsalesman").value=items[16];
			    document.getElementById("txtgroupcompanies").value=items[17];    
			    document.getElementById("cmbpayterm").value=items[18];    
			    document.getElementById("hidcmbpayterm").value=items[18];    
			    document.getElementById("txtrevise").value=items[19];  
			    
			    $('#quoteDate').jqxDateTimeInput({ disabled: false});  
			    document.getElementById("frmQuotation").submit(); 
			 }else {}
	     }
	     x.open("GET","setViewMode.jsp?masterdoc="+qottrno,true);
	     x.send();
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
   function getsertype(rowBoundIndex)
    {
  
 	  $('#surveytypewindow').jqxWindow('open');
 	
 	  refsearchContent('sertypeSearch.jsp?rowBoundIndex1='+rowBoundIndex);  
 
}  
 function getskiptype(rowBoundIndex){
	 
 	  $('#skipinfowindow').jqxWindow('open');
 
    // $('#accountWindow').jqxWindow('focus');
           skipSearchContent('getskiptype.jsp?rowBoundIndex='+rowBoundIndex);
        	 }
 function skipSearchContent(url) {
	//  alert(url);
	  	 $.get(url).done(function (data) {
	 		 //alert(data);
	 $('#skipinfowindow').jqxWindow('setContent', data);

	                	}); 
	      	}
	 function getwastetype(rowBoundIndex){
	 	  $('#wasteinfowindow').jqxWindow('open');
	           wasteSearchContent('getwastetype.jsp?rowBoundIndex='+rowBoundIndex);
	 }
	 function wasteSearchContent(url) {
		      	 $.get(url).done(function (data) {
		      	 $('#wasteinfowindow').jqxWindow('setContent', data);
	             }); 
	 }
    function getspec(rowBoundIndex){
	  $('#specinfowindow').jqxWindow('open');
          specSearchContent('getSpec.jsp?rowBoundIndex='+rowBoundIndex);
	}
	function specSearchContent(url) {
		      	 $.get(url).done(function (data) {
		      	 $('#specinfowindow').jqxWindow('setContent', data);
	            }); 
	}
	function getOtherDetails(rowBoundIndex,type){  
		  $('#otherdetailsinfowindow').jqxWindow('open');  
		  otherdetailsSearchContent('getOtherDetails.jsp?rowBoundIndex='+rowBoundIndex+'&type='+encodeURIComponent(type)); 
	}
	function otherdetailsSearchContent(url) {   
			      	 $.get(url).done(function (data) {
			      	 $('#otherdetailsinfowindow').jqxWindow('setContent', data);
		            }); 
	}
 	  function refsearchContent(url) {
    
       $.get(url).done(function (data) {

     $('#surveytypewindow').jqxWindow('setContent', data);

 	}); 
 	}
	
	function getSource(event){
		 var x= event.keyCode;
    	 if(x==114){
    		 $('#sourcesearchwndow').jqxWindow('open');
    		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));   
    	}
    	 else{
    		 
    	 }
	}
	       
	    function salesmanSearchContent(url) {
	   		$('#salesManDetailsWindow').jqxWindow('open');
	   		$.get(url).done(function (data) {
	   		$('#salesManDetailsWindow').jqxWindow('setContent', data);
	   		$('#salesManDetailsWindow').jqxWindow('bringToFront');
	   	}); 
	   	} 
	    
	    function getsalinfo(event){
	        var x= event.keyCode;
	        if(x==114){
	        	salesmanSearchContent('salesManDetailsSearch.jsp');
	        }
	        else{}
	        }
	
	 function getEnquiry(){ 
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#enqsearch').jqxWindow('open');
    	 enquirySearchContent('enquirysearch.jsp?', $('#enqsearch'));    }  
    	 else{
    		 }
       }   
	  function enquirySearchContent(url) { 
	          $.get(url).done(function (data) {
		           $('#enqsearch').jqxWindow('setContent', data);
          	  }); 
	  } 
	  
	  function getOtherContracts(){
		  console.log("IN OTHERS");
		    var valid2=document.getElementById("hidcldocno").value;  
			if(valid2=="" || valid2=="0") {   
				document.getElementById("errormsg").innerText="Please select a client";   
				return 0;
			 }else{
				 document.getElementById("errormsg").innerText="";
			     $('#othercontractsinfowindow').jqxWindow('open');
			     othercontractsSearchContent('othercontractsGrid.jsp?cldocno='+valid2);       
			}
	       }   
		  function othercontractsSearchContent(url) {   
		          $.get(url).done(function (data) {
			           $('#othercontractsinfowindow').jqxWindow('setContent', data);
	          	  }); 
		  }
		  
	  function getpendingQuotes(){
			    var valid2=document.getElementById("hidcldocno").value;  
				if(valid2=="" || valid2=="0") {   
					document.getElementById("errormsg").innerText="Please select a client";   
					return 0;
				 }else{
					 document.getElementById("errormsg").innerText="";
				     $('#pendingquotesinfowindow').jqxWindow('open');
				     pendingquotesSearchContent('pendingquotesGrid.jsp?cldocno='+valid2);           
				}
		       }   
	   function pendingquotesSearchContent(url) {   
			          $.get(url).done(function (data) {
				           $('#pendingquotesinfowindow').jqxWindow('setContent', data);
		          	  }); 
			  }      	  
	       
	function funNotify(){	
		// alert($('#docno').val()+"===="+$('#masterdoc_no').val());
		//  0; 
		if($("#docno").val()!='' && $('#masterdoc_no').val()==''){
				$('#masterdoc_no').val($('#docno').val());
		}	
			
		$('#quoteDate').jqxDateTimeInput({ disabled: false});
		var invmethod=$('#cmbinvmethod').val();    
		var cmbbillingmethod=document.getElementById("cmbbillingmethod").value;   
		if(cmbbillingmethod=="") {
			document.getElementById("errormsg").innerText="Please Select Billing Method";  
			return 0;
		 }else{
			 document.getElementById("errormsg").innerText="";
		}
		
		var cmbpayterm=document.getElementById("cmbpayterm").value;   
		if(cmbpayterm=="") {
			document.getElementById("errormsg").innerText="Please Select Pay Term";    
			return 0;
		 }else{
			 document.getElementById("errormsg").innerText="";
		}
		
		var valid2=document.getElementById("txtenquiry").value;
		if(valid2=="") {
			document.getElementById("errormsg").innerText="Please Select Enquiry";
			return 0;
		 }else{
			 document.getElementById("errormsg").innerText="";
		}
		var validenqrows2 = $("#jqxQuote").jqxGrid('getrows');   
		var valid2=0;  
		for(var l=0 ; l < validenqrows2.length ; l++){   
			if(validenqrows2[l].site!="" && typeof(validenqrows2[l].site)!="undefined" && typeof(validenqrows2[l].site)!="NaN" && validenqrows2[l].site!=null){ 
				valid2++;
			}
		}
		console.log("valid2="+valid2);
		if(valid2>1){  
			var multilineconfig=$("#multilineconfig").val();  
			console.log("multilineconfig="+multilineconfig);
			if(parseInt(multilineconfig)==1){
				document.getElementById("errormsg").innerText="You can't add more than one line in quote details!!!";  
				return 0;
			}
		}  
		var validenqrows = $("#jqxQuote").jqxGrid('getrows');   
		var valid=0,valid1=0;  
		for(var k=0 ; k < validenqrows.length ; k++){     
 			if(validenqrows[k].site!="" && typeof(validenqrows[k].site)!="undefined" && typeof(validenqrows[k].site)!="NaN" && validenqrows[k].site!=null){  
 				 valid=1;
 				 if(validenqrows[k].skipdoc=="0" || validenqrows[k].skipdoc=="" || typeof(validenqrows[k].skipdoc)=="undefined" || typeof(validenqrows[k].skipdoc)=="NaN" || validenqrows[k].skipdoc==null){  
									 valid1=1;
									 console.log(1);
									 document.getElementById("errormsg").innerText="Please select skip size";       
									 return 0;    
				 }
				 if(validenqrows[k].wastedoc=="0" || validenqrows[k].wastedoc=="" || typeof(validenqrows[k].wastedoc)=="undefined" || typeof(validenqrows[k].wastedoc)=="NaN" || validenqrows[k].wastedoc==null){  
									 valid1=1;
									 console.log(2);
									 document.getElementById("errormsg").innerText="Please select waste type";       
									 return 0; 
				 }
				 if(validenqrows[k].specid=="0" || validenqrows[k].specid=="" || typeof(validenqrows[k].specid)=="undefined" || typeof(validenqrows[k].specid)=="NaN" || validenqrows[k].specid==null){  
									 valid1=1;
									 console.log(3);
									 document.getElementById("errormsg").innerText="Please select spec";          
									 return 0; 
				 }
				 if(validenqrows[k].nos=="" || typeof(validenqrows[k].nos)=="undefined" || typeof(validenqrows[k].nos)=="NaN" || validenqrows[k].nos==null){  
									 valid1=1;
									 console.log(4);
									 document.getElementById("errormsg").innerText="Please enter qty";         
									 return 0; 
				 }
				 if(validenqrows[k].days=="" || typeof(validenqrows[k].days)=="undefined" || typeof(validenqrows[k].days)=="NaN" || validenqrows[k].days==null){  
									 valid1=1;
									 console.log(5);  
									 document.getElementById("errormsg").innerText="Please enter nos";                  
									 return 0; 
				 }
				 if(validenqrows[k].ownershipid=="0" || validenqrows[k].ownershipid=="" || typeof(validenqrows[k].ownershipid)=="undefined" || typeof(validenqrows[k].ownershipid)=="NaN" || validenqrows[k].ownershipid==null){  
									 valid1=1;
									 console.log(6);
									 document.getElementById("errormsg").innerText="Please select ownership";           
									 return 0;    
				 }  
				 if(validenqrows[k].servicetermid=="0" || validenqrows[k].servicetermid=="" || typeof(validenqrows[k].servicetermid)=="undefined" || typeof(validenqrows[k].servicetermid)=="NaN" || validenqrows[k].servicetermid==null){  
									 valid1=1;
									 console.log(7);
									 document.getElementById("errormsg").innerText="Please select service term";           
									 return 0; 
				 }
				 if(validenqrows[k].collectionid=="0" || validenqrows[k].collectionid=="" || typeof(validenqrows[k].collectionid)=="undefined" || typeof(validenqrows[k].collectionid)=="NaN" || validenqrows[k].collectionid==null){  
									 valid1=1;
									 console.log(8);
									 document.getElementById("errormsg").innerText="Please select collection";          
									 return 0; 
				 }
				 if(validenqrows[k].rate=="" || typeof(validenqrows[k].rate)=="undefined" || typeof(validenqrows[k].rate)=="NaN" || validenqrows[k].rate==null){  
									 valid1=1;
									 document.getElementById("errormsg").innerText="Please enter rate";       
									 return 0; 
				 }
				 if(validenqrows[k].tippingmethod!="ACTUAL" && (validenqrows[k].tippingfee=="" || typeof(validenqrows[k].tippingfee)=="undefined" || typeof(validenqrows[k].tippingfee)=="NaN" || validenqrows[k].tippingfee==null)){     
									 valid1=1;
									 console.log(9);
									 document.getElementById("errormsg").innerText="Please enter tipping fee";       
									 return 0; 
				 }
				 if((validenqrows[k].ownership!="CLIENT SKIP" && validenqrows[k].ctype!="TRIP BASIS")&&(validenqrows[k].rent=="" || typeof(validenqrows[k].rent)=="undefined" || typeof(validenqrows[k].rent)=="NaN" || validenqrows[k].rent==null)){  
									 valid1=1;  
									 document.getElementById("errormsg").innerText="Please select skip rent";       
									 return 0; 
				 }  
				/*  if(validenqrows[k].securityval=="" || typeof(validenqrows[k].securityval)=="undefined" || typeof(validenqrows[k].securityval)=="NaN" || validenqrows[k].securityval==null){  
									 valid1=1;
									 console.log(10);
				 } */
				 if(validenqrows[k].tippingmethodid=="0" || validenqrows[k].tippingmethodid=="" || typeof(validenqrows[k].tippingmethodid)=="undefined" || typeof(validenqrows[k].tippingmethodid)=="NaN" || validenqrows[k].tippingmethodid==null){  
									 valid1=1;
									 console.log(11);
									 document.getElementById("errormsg").innerText="Please select tipping method";       
									 return 0; 
				 }
				/*  if((validenqrows[k].tippingfee!="0" && validenqrows[k].tippingfee!="") && (validenqrows[k].tippingsecurity=="" || typeof(validenqrows[k].tippingsecurity)=="undefined" || typeof(validenqrows[k].tippingsecurity)=="NaN" || validenqrows[k].tippingsecurity==null)){  
									 valid1=1;
									 console.log(12);
				 }  */      
				 if(validenqrows[k].ctypeid=="0" || validenqrows[k].ctypeid=="" || typeof(validenqrows[k].ctypeid)=="undefined" || typeof(validenqrows[k].ctypeid)=="NaN" || validenqrows[k].ctypeid==null){  
									 valid1=1;
									 console.log(14);		
									 document.getElementById("errormsg").innerText="Please select ctype";       
									 return 0; 
				 }else{
					 if(invmethod=="1"){     
						 if(validenqrows[k].ctype!="RENT"){     
							 valid2=1;
							 console.log(16);     		
						 }
					 }
				 }
				 if(validenqrows[k].addrate=="" || typeof(validenqrows[k].addrate)=="undefined" || typeof(validenqrows[k].addrate)=="NaN" || validenqrows[k].addrate==null){  
									 valid1=1;
									 console.log(15);  
									 document.getElementById("errormsg").innerText="Please enter add rate";              
									 return 0; 
				}  
			}    
		 }        
		 
		 if(valid==0){
			 document.getElementById("errormsg").innerText="Please enter data in quote details";    
			 return 0;  
		 }
		 if(valid1==1){
			 document.getElementById("errormsg").innerText="Please fill data in all columns of quote details";       
			 return 0;  
		 }
		 
	     var quotlen=0,sitellen=0; 
	 	 var rows = $("#jqxQuote").jqxGrid('getrows');   
		 for(var i=0 ; i < rows.length ; i++){  
			   if(rows[i].site!="") {
				    var restricted=0;
				    if(rows[i].restricted){
				    	restricted=1;
				    }else{
				    	restricted=0;
				    }   
				    newTextBox = $(document.createElement("input"))   
				       .attr("type", "dil")
				       .attr("id", "enqtest"+i)
				       .attr("name", "enqtest"+i)
				       .attr("hidden", "true"); 
				    newTextBox.val(rows[i].site+" :: "+rows[i].skipdoc+" :: "+rows[i].nos+" :: "+rows[i].wastedoc+" :: "+rows[i].ownershipid+" :: "+rows[i].servicebyid+" :: "+rows[i].servicetermid+" :: "+rows[i].days+" :: "+rows[i].specid+" :: "+rows[i].collectionid+" :: "+rows[i].rate+" :: "+rows[i].tippingfee+" :: "+rows[i].foc+" :: "+rows[i].rent+" :: "+rows[i].securityval+" :: "+rows[i].tippingmethodid+" :: "+rows[i].tippingsecurity+" :: "+restricted+" :: "+rows[i].tariffrate+" :: "+rows[i].rowno+" :: "+rows[i].gatefee+" :: "+rows[i].addrate+" :: "+rows[i].ctypeid+" :: ");
				    newTextBox.appendTo('form');   
				   quotlen++;
			   }	     
		   }     
		   var rowssitegrid = $("#siteGrid").jqxGrid('getrows');
		   for(var i=0 ; i < rowssitegrid.length ; i++){
			   if(rowssitegrid[i].site!="") {
				    newTextBox = $(document.createElement("input"))
				       .attr("type", "dil")
				       .attr("id", "sitetest"+i)
				       .attr("name", "sitetest"+i)
				       .attr("hidden", "true"); 
				 
				   newTextBox.val(rowssitegrid[i].site+" :: "+rowssitegrid[i].remarks+" :: "+rowssitegrid[i].areaid+" :: "+rowssitegrid[i].surid+" :: "+rowssitegrid[i].route+" :: "+rowssitegrid[i].gpsx+" :: "+rowssitegrid[i].gpsy+" :: "+rowssitegrid[i].description+" :: ");    
				   newTextBox.appendTo('form');  
				   sitellen++;
				}
		   }
		   $('#enqgridlenght').val(quotlen); 
		   $('#siteGridlength').val(sitellen);    
		return 1;
	} 

	function funChkButton() {
		//frmEnquiryfrn.submit();
	}

	function funSearchLoad(){
		 changeContent('masterSearch.jsp');  
	}

	function funFocus(){  
	   $('#quoteDate').jqxDateTimeInput('focus');  
	}
	
	function setValues() {
		  document.getElementById("formdetail").value="Quotation";
	   	  document.getElementById("formdetailcode").value="QOT";
	   	 /* alert($("#docno").val());
	        
	        alert($('#masterdoc_no').val());
	       if($("#docno").val()!='' && $('#masterdoc_no').val()==''){
					$('#masterdoc_no').val($('#docno').val());
			}  */
		  if($('#hidquoteDate').val()!="" && $('#hidquoteDate').val()!=null){
			  $("#quoteDate").jqxDateTimeInput('val', $('#hidquoteDate').val());
		  }
		  if($('#hidcmbbillingmethod').val()!=""){
			  $("#cmbbillingmethod").val($('#hidcmbbillingmethod').val());
	      } 
		  if($('#hidcmbpayterm').val()!=""){
			  $("#cmbpayterm").val($('#hidcmbpayterm').val());   
		  }
  	      var docVal1 = document.getElementById("masterdoc_no").value;
      	  if(docVal1>0) {
		    var indexVal2 = document.getElementById("masterdoc_no").value;
		    var txtrevise = document.getElementById("txtrevise").value;
            $("#quotdiv").load("quoteDetails.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);  
            $("#sitediv").load("siteGrid.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);   
            $("#btnothercontracts").attr('disabled', false );        
    		$("#btnpendingquotes").attr('disabled', false );
      	  }  
      	  if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
      	  funDtype();
		  getapprcount();
		  apprCheck();
      	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
      	  
      	  enquiryAlert();
	}
	function getPayterms() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim()+'">'   
					+ process[i] + '</option>';
					
				}
				$("select#cmbpayterm").html(optionsbranch);
				if(parseInt($('#hidcmbpayterm').val())>0) { 
					$('#cmbpayterm').val($('#hidcmbpayterm').val());  
				} 
			} else {}
		}
		x.open("GET","getPayterms.jsp?billingmethod="+$("#cmbbillingmethod").val(), true);
		x.send();
	}
	
	function getTariffRate(skipdoc,ownership,noofvisit,tripsinmonth,rowindex){ 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			 	var items= x.responseText;
			 	$('#jqxQuote').jqxGrid('setcellvalue', rowindex, "rate",items);  
			 	$('#jqxQuote').jqxGrid('setcellvalue', rowindex, "tariffrate",items);
			 	$('#jqxQuote').jqxGrid('setcellvalue', rowindex, "addrate",items);
			 	funGetValues1(); 
			 	getTotals()
			 }else {}
	     }
	     x.open("GET","getTariffRate.jsp?ownership="+encodeURIComponent(ownership)+"&noofvisit="+noofvisit+"&skipdoc="+skipdoc+"&tripsinmonth="+tripsinmonth,true);       
	     x.send();
    }
	
    function enquiryAlert(){
    	  var docVal1 = document.getElementById("masterdoc_no").value;
    	var x = new XMLHttpRequest();
    	x.onreadystatechange = function() {
    		if(x.readyState == 4 && x.status == 200){
    			
    			var items = x.responseText.trim();
    			if(docVal1 >0){
        			document.getElementById("statusval").innerHTML="Last Modified :"+items;

    			}else{
        			document.getElementById("statusval").innerHTML=" ";

    			}
    		}
    		
    	}
    	x.open("GET", "quotStatus.jsp?docno="+docVal1);
		x.send();
    }
	
	
	function getTariffFee(tippingmethod,skipsize,wastetype,rowindex){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			 	var items= x.responseText;
			 	if(tippingmethod=="FIXED"){  
			 		$('#jqxQuote').jqxGrid('setcellvalue', rowindex, "tippingfee",items);
			 		 funGetValues1();
			 		 getTotals()
			 	}         
			 }else {}
	     }
	     x.open("GET","getTariffFee.jsp?skipsize="+skipsize+"&wastetype="+wastetype,true);       
	     x.send();
    }
	function funSendmail(){ 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim().split("####");
				var email="";
				var cldocno="";
				var msg="";      
				var client="";
				var subject="Quotation";    
				//console.log(items[0]+"="+items[1]+"="+items[2]);  
				if(items!=""){
					 msg=items[0];
				     email=items[1];
				     cldocno=items[2];
				     //client=items[3];    
				}
				var brchid="<%= session.getAttribute("BRANCHID").toString() %>";    
				var userid="<%= session.getAttribute("USERID").toString() %>";     
		   		var contrctno=document.getElementById("masterdoc_no").value;    
		   		console.log(items[0]+"="+items[1]+"="+items[2]); 
		   		var frmdet="QOT";        
		   		var dtype="QOT";        
		   		var fname="Quotation";  
		   		//console.log(msg+"="+email+"="+cldocno);   
		   		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+document.getElementById("brchName").value+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet+"&subject="+encodeURIComponent(subject)+"&msg="+encodeURIComponent(msg),"E-Mail","menubar=0,resizable=1,width=900,height=950"); 
			}
		}      
		x.open("GET","sendMail.jsp?trno="+$('#masterdoc_no').val(),true);           
		x.send();        
	}  
	 function editstatuscheck(){    
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.split("####");  	
					if(parseInt(items[0])>0) {  
						 $("#btnEdit").attr('disabled', true ); 
						 $("#btnDelete").attr('disabled', true ); 
						 $("#revbtn").attr('disabled', true );
					 }else{
						 $("#btnEdit").attr('disabled', false ); 
						 $("#btnDelete").attr('disabled', false );      
						 $("#revbtn").attr('disabled', false );
					 }
				     if(parseInt(items[1])>0 || parseInt(items[0])>0){       
						 $("#btnEdit").attr('disabled', true );  
					 }else{
						 $("#btnEdit").attr('disabled', false ); 
					 }
					} else {  
					}    
			}
			x.open("GET", "getEditStat.jsp?enqdocno="+$('#hidenqdocno').val()+"&masterdoc="+$('#masterdoc_no').val(), true);                  
			x.send();
		}  
		function funrevise(){ 
			var docVal1 = document.getElementById("masterdoc_no").value;
	      	if(docVal1=="" || docVal1=="0") {    
	      		$.messager.alert('Message','Select a Document....!','warning');
				return;
	      	}
			if(document.getElementById("revbtn").value=='Save'){
				funrevisesave();     
			} 
			document.getElementById("formdetailcode").value="QOT"; 
			document.getElementById("mode").value='R';
			$("#siteGrid").jqxGrid({ disabled: false});
			$("#jqxQuote").jqxGrid({ disabled: false});
			$('#txtcperson').attr('disabled', false); 
			$('#cmbbillingmethod').attr('disabled', false);
			$('#cmbpayterm').attr('disabled', false); 
			$('#txtdesc').attr('readonly', false); 
			$('#quoteDate').jqxDateTimeInput({ disabled: false});   
			$("#revbtn").attr('value', 'Save');            	   
		}  
		function funrevisesave(){    
			 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)  {		     	   
		     		return false; 
		     	}else{	
		     		   $("#overlay, #PleaseWait").show();     
			     	   var temp=funNotify();  
					   if(temp>0){
						    $('#txtenquiry').attr('disabled', false);  
							document.getElementById("frmQuotation").submit(); 
					   }
		     	}  
		    }); 
		  }
		
	 function getmultilineconfig(){    
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.split("####");    	
						$("#multilineconfig").val(items[0]);   
						$("#multioptionprintconfig").val(items[1]);       
					} else {  
				    }    
				}
				x.open("GET", "getMultilineConfig.jsp", true);                        
				x.send();
	  }     		
</script>
</head>
<body onload="setValues();getPayterms();getmultilineconfig();" onmouseover="editstatuscheck();">           
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmQuotation" action="saveQuotationSkips" autocomplete="OFF">    

<jsp:include page="../../../header.jsp"></jsp:include><br/> 

<fieldset>
<!-- <legend>Customer Enquiry</legend>  -->  
<table width="100%">                          
  <tr>
     <td width="5%" align="right">Date</td>  
     <td width="13%"><div id='quoteDate' name='quoteDate' value='<s:property value="quoteDate"/>'></div>   
          <input type="hidden" id="hidquoteDate" name="hidquoteDate" value='<s:property value="hidquoteDate"/>'/>  
     </td>
     <td width="5%" align="right">Revision</td> 
     <td width="33%"><input type="text" id="txtrevise" name="txtrevise" style="width:30%;" value='<s:property value="txtrevise"/>'/>
     &nbsp;<input type="button" id="revbtn" class="myButton" onclick="funrevise();" value="Revise" ></td>  
     <td colspan="2"><label id="statusval" ></label></td>          
     <td width="5" align="right" >Doc No</td>   
     <td width="10%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
  <tr> 
    <td width="5%" align="right">Enquiry</td>       
    <td width="13%"><input type="text" id="txtenquiry" name="txtenquiry" style="width:90%;" placeholder="Press F3 To Search" value='<s:property value="txtenquiry"/>' onKeyDown="getEnquiry();">
		<input type="hidden" id="hidenqdocno" name="hidenqdocno"  style="width: 70%;" value='<s:property value="hidenqdocno"/>'></td>  
	<td  width="5%" align="right">Client</td>         
    <td width="33%" ><input type="text" id="txtclient" name="txtclient" style="width:97%;"  value='<s:property value="txtclient"/>'>
		<input type="hidden" id="hidcldocno" name="hidcldocno" value='<s:property value="hidcldocno"/>'></td>	
	<td  width="7%" align="right">Group Companies</td>             
    <td width="13%"><input type="text" id="txtgroupcompanies" name="txtgroupcompanies" style="width:90%;" value='<s:property value="txtgroupcompanies"/>'> </td>	
	<td width="5%" align="right" >Source</td> 
    <td width="10%" align="left" ><input type="text" id="txtsource" name="txtsource" value='<s:property value="txtsource"/>'></td>	
  </tr>       
 <tr> 
    <td width="5%" align="right">Contact Person</td>            
    <td width="13%"><input type="text" id="txtcperson" name="txtcperson" style="width:90%;" placeholder="Press F3 To Search" value='<s:property value="txtcperson"/>' onKeyDown="getcontact(event);">  
         <input type="hidden" id="hidcpersonid" name="hidcpersonid" value='<s:property value="hidcpersonid"/>'></td> 
    <td width="5%" align="right" >Email</td>  
    <td width="33%" align="left" ><input type="text" id="txtmail" name="txtmail" style="width:97%;" value='<s:property value="txtmail"/>'></td>   
	<td  width="5%" align="right">Mob</td>         
    <td width="13%"><input type="text" id="txtmob" name="txtmob" style="width:90%;" value='<s:property value="txtmob"/>'> </td>	
	<td width="5%" align="right" >Tel</td> 
    <td width="10%" align="left" ><input type="text" id="txttele" name="txttele" value='<s:property value="txttele"/>'></td>
  </tr>
 <tr>
   <td  width="5%" align="right">Designation</td>      
   <td width="13%"><input type="text" id="txtdesig" name="txtdesig" style="width:90%;"  value='<s:property value="txtdesig"/>' ></td>        
   <td width="5%" align="right">Address</td>           
   <td width="33%"><input type="text" id="txtaddress" name="txtaddress" style="width:97%;" value='<s:property value="txtaddress"/>'></td>
   <td width="5%" align="right" >Billing Method</td>    
   <td width="10%" align="left" ><select  id="cmbbillingmethod" name="cmbbillingmethod" onchange="getPayterms();getTotals();">     
      <option value="">--Select--</option><option value="1">Monthly</option><option value="2">Yearly</option><option value="3">Adhoc</option></select>
      <input type="hidden" id="hidcmbbillingmethod" name="hidcmbbillingmethod" value='<s:property value="hidcmbbillingmethod"/>'>     
   </td>  
    <td width="5%" align="right" >Pay Term</td>       
   <td width="10%" align="left" ><select  id="cmbpayterm" name="cmbpayterm" style="width:90%;"></select>   
      <input type="hidden" id="hidcmbpayterm" name="hidcmbpayterm" value='<s:property value="hidcmbpayterm"/>'>     
   </td>
  </tr>
  <tr>
   <td  width="5%" align="right">Salesman</td>  
   <td width="13%"><input type="text" id="txtsalesman" name="txtsalesman" style="width:90%;"  value='<s:property value="txtsalesman"/>' placeholder="Press F3 To Search" onKeyDown="getsalesAgent(event);">
     <input type="hidden" id="txtsalesmandocno" name="txtsalesmandocno" value='<s:property value="txtsalesmandocno"/>'></td> 
   <td width="5%" align="right">Description</td>       
   <td colspan="5"><input type="text" id="txtdesc" name="txtdesc" style="width:98.3%;" value='<s:property value="txtdesc"/>'></td>	
   </tr>  
 </table>  
  <table  width="100%" >
  <tr>
  </tr>
</table>    
</fieldset>

<table width="100%">
  <tr>
    <td><fieldset><legend>Site Details</legend>
      <div id="sitediv"><jsp:include page="siteGrid.jsp"></jsp:include></div>   
    </fieldset></td>
   
  </tr>  
<tr>
<td>
 <fieldset><legend>Quote Details</legend>
 <input type="button" name="btnothercontracts" id="btnothercontracts" class="myButton" value="View Contracts"  onclick="getOtherContracts();">
 <input type="button" name="btnpendingquotes" id="btnpendingquotes" class="myButton" value="Pending Quotes"  onclick="getpendingQuotes();">    
<div id="quotdiv">
  <jsp:include page="quoteDetails.jsp"></jsp:include></div>   
  <table>
  <tr>
   <td colspan="2" width="90%" align="left"><label for="calclbl" id="calcshowlbl"></label></td>  
  </tr>
  </table>
</fieldset> </td>
</tr>
<tr>
<td>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="hidmode" name="hidmode" value='<s:property value="hidmode"/>' />   
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" name="enqdtype" id="enqdtype" value='<s:property value="enqdtype"/>' />
<input type="hidden" id="enqgridlenght" name="enqgridlenght" />
<input type="hidden" id="siteGridlength" name="siteGridlength" />   
<input type="hidden" name="gridval" id="gridval" value='<s:property value="gridval"/>' />
<input type="hidden" name="forradiochk" id="forradiochk" value='<s:property value="forradiochk"/>' />  
<input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
<input type="hidden" name="sourceid" id="sourceid" value='<s:property value="sourceid"/>'/>
<input type="hidden" name="cpersonid" id="cpersonid" value='<s:property value="cpersonid"/>'/>
<input type="hidden" name="fromdatesval" id="fromdatesval" value='<s:property value="fromdatesval"/>' />  
<input type="hidden" name="todateval" id="todateval" value='<s:property value="todateval"/>' /> 
<input type="hidden" id="sertypeids" name="sertypeids"  value='<s:property value="sertypeids"/>'/> 
<input type="hidden" id="enqstatus" name="enqstatus" value='<s:property value="enqstatus"/>' />

<input type="hidden" id="netamount" name="netamount"  value='<s:property value="netamount"/>'/>  
<input type="hidden" id="hidsurvey" name="hidsurvey"  value='<s:property value="hidsurvey"/>'/>
<input type="hidden" id="hidcmbenqbtype" name="hidcmbenqbtype"  value='<s:property value="hidcmbenqbtype"/>'/>
<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 

 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
 <input type="hidden" id="hidenqedit" name="hidenqedit"  value='<s:property value="hidenqedit"/>'/>  
 <input type="hidden" id="hidcmbsertype" name="hidcmbsertype"  value='<s:property value="hidcmbsertype"/>'/> 
 <input type="hidden" id="multilineconfig" name="multilineconfig"  value='<s:property value="multilineconfig"/>'/>  
 <input type="hidden" id="multioptionprintconfig" name="multioptionprintconfig"  value='<s:property value="multioptionprintconfig"/>'/>     
</td>
</tr>
</table>
</form>
<div id="sourcesearchwndow">
   <div ></div>
 </div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div>
<div id="enqsearch"> 
   <div ></div>
</div>
<div id="salesManDetailsWindow">
   <div ></div>
</div>
<div id="cpinfowindow">
   <div ></div>
   </div>
   <div id="areainfowindow">
   <div ></div>
   </div>
   <div id="skipinfowindow">
   <div ></div>
   </div>
   <div id="wasteinfowindow">
   <div ></div>
   </div>
    <div id="surveytypewindow">
   <div ></div>
   </div>
   <div id="otherdetailsinfowindow">
   <div ></div>
   </div>
    <div id="specinfowindow"> 
   <div ></div>
   </div>
   <div id="othercontractsinfowindow">   
   <div ></div>
   </div>
   <div id="pendingquotesinfowindow">   
   <div ></div>
   </div>
   <div id="contactinfowindow">
			<div></div>
		</div>
   <div id="printWindow">
	<div></div><div></div></div>
	<div id="Salesagentinfowindow">
   <div ></div>
   </div>
</div>  

</body>
</html>