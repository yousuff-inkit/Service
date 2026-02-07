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
 <script type="text/javascript" src="../../../js/ajaxfileupload.js"></script>    
<style>
form label.error {
  color:red;
  font-weight:bold;
}
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
#calcshowlbl{
   color:blue;
}
.tooltip { 
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
}

.tooltip .tooltiptext { 
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  position: absolute;
  z-index: 1;
  top: 100%;
  left: 50%;
  margin-left: -60px;
}

.tooltip .tooltiptext::after {
  content: "";
  position: absolute;
  bottom: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: transparent transparent black transparent;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
}
#statusval{
color: blue;
}
</style> 
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();   
String contrno =request.getParameter("contrno")==null || request.getParameter("contrno")==""?"0":request.getParameter("contrno").toString();  

String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String enqdocno =request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").toString();
String vocno =request.getParameter("vocno")==null?"0":request.getParameter("vocno").toString();
String mail=request.getParameter("mail")==null?"0":request.getParameter("mail").toString();
String mob=request.getParameter("mob")==null?"0":request.getParameter("mob").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String telno=request.getParameter("telno")==null?"0":request.getParameter("telno").toString();
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
String salid=request.getParameter("salid")==null?"0":request.getParameter("salid").toString();
String salesman=request.getParameter("salesman")==null?"":request.getParameter("salesman").toString(); 
String mod=request.getParameter("mod")==null?"":request.getParameter("mod").toString();
String qottrno=request.getParameter("qottrno")==null?"":request.getParameter("qottrno").toString(); 
String qotrevno=request.getParameter("qotrevno")==null?"":request.getParameter("qotrevno").toString();    

String billingmethod=request.getParameter("billingmethod")==null?"0":request.getParameter("billingmethod").toString();
String type=request.getParameter("type")==null?"0":request.getParameter("type").toString();
String payterms=request.getParameter("payterms")==null?"0":request.getParameter("payterms").toString();
String startdt=request.getParameter("startdt")==null?"0":request.getParameter("startdt").toString();
String enddt=request.getParameter("enddt")==null?"0":request.getParameter("enddt").toString();
String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").toString(); 
String grpname=request.getParameter("grpname")==null?"0":request.getParameter("grpname").toString();
String description=request.getParameter("description")==null?"0":request.getParameter("description").toString();   
String frompresales=request.getParameter("frompresales")==null || request.getParameter("frompresales")==""?"0":request.getParameter("frompresales").toString();
String cperson=request.getParameter("cperson")==null?"":request.getParameter("cperson").toString(); 
String cpersonid=request.getParameter("cpersonid")==null?"":request.getParameter("cpersonid").toString();   
%>
<script type="text/javascript">
var modes='<%=modes%>';
var contrno='<%=contrno%>';  
var mod1='<%=mod%>';
var enqdocno='<%=enqdocno%>';
var brhid='<%=brhid%>';
 $(document).ready(function () {
	 $("#clconfirmlbl").hide();
	 $('#witheffectlbl').hide();
	 $('#witheffectDate').hide();
	 $("#witheffectDate").jqxDateTimeInput({ width: '110px', height: '20px', formatString:"dd.MM.yyyy"});   
   	 $("#quoteDate").jqxDateTimeInput({ width: '110px', height: '20px', formatString:"dd.MM.yyyy"});    
   	 $("#startDate").jqxDateTimeInput({ width: '110px', height: '20px', formatString:"dd.MM.yyyy"}); 
   	 $("#endDate").jqxDateTimeInput({ width: '110px', height: '20px', formatString:"dd.MM.yyyy"}); 
   	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 
     $('#clientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientsearch').jqxWindow('close');
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
	 $('#siteinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27}); 
	 $('#siteinfowindow').jqxWindow('close');   
	 $('#specinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Spec Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#specinfowindow').jqxWindow('close');
	 $('#otherdetailsinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#otherdetailsinfowindow').jqxWindow('close');
	 $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#printWindow').jqxWindow('close');
 	 $('#contactinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Contact Person Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#contactinfowindow').jqxWindow('close');    
	 
	 var endDates=new Date($('#endDate').jqxDateTimeInput('getDate'));  
     var onemonth=new Date(new Date(endDates).setFullYear(endDates.getFullYear()+1));    
     $('#endDate').jqxDateTimeInput('setDate', new Date(onemonth.setDate(endDates.getDate()-1)));	      
     refChange(); 
     funadvtypechange();
     
     $(".HeadIcons").mouseover(function(){  
 		editstatuscheck();
     });
     
     $('#txtenquiry').dblclick(function(){  
    	$('#enqsearch').jqxWindow('open');
	       enquirySearchContent('enquirysearch.jsp?', $('#enqsearch')); 
       });
      $('#txtclient').dblclick(function(){
    	  var type = $("#cmbreftype").val();  
		  if(type=="DIR"){     
	     	   $('#clientsearch').jqxWindow('open');     
	 	       clientSearchContent('clientsearch.jsp?', $('#clientsearch'));
		  }   
        });
      $('#txtcperson').dblclick(function(){ 
    	    var cldocno=document.getElementById("hidcldocno").value; 
	     	$('#contactinfowindow').jqxWindow('open');  
	     	contactSearchContent('Searchcontact.jsp?cldocno='+cldocno, $('#contactinfowindow'));         
      });
     });
/*	  function funPrintBtn() {
     console.log("IN");     
     var url=document.URL;
     
     var reurl=url.split("com/");   
     $("#docno").prop("disabled", false);  
     console.log(reurl[0]);  
     var win= window.open(reurl[0]+"printServiceContractSkip?docno="+document.getElementById("masterdoc_no").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
				
	} */ 
	function getcontact(event){
		 var cldocno=document.getElementById("hidcldocno").value; 
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
	
	
	function enquiryAlert(){
		var docVal1 = document.getElementById("masterdoc_no").value;  
	  	var x = new XMLHttpRequest();
	  	x.onreadystatechange = function() {
  		if(x.readyState == 4 && x.status == 200){   
  			var items = x.responseText.trim();
  			if(docVal1 >0){
      			document.getElementById("statusval").innerHTML="Last Modified "+items;
  			}else{
      			document.getElementById("statusval").innerHTML=" ";
  			}
  		}
  		
  	}
  	x.open("GET", "getSerStatus.jsp?docno="+docVal1);
	x.send();
  }
	
	
 function funPrintBtn() { 
	  var docVal1 = document.getElementById("masterdoc_no").value;
      if(docVal1=="" || docVal1=="0") {    
    		$.messager.alert('Message','Select a Document....!','warning');
			return 0;
     }else{
         var multioption=$("#multioptionprintconfig").val();
         if(parseInt(multioption)==1){ 
        	 quotePrintContent('printVoucherWindow.jsp');    
    	 }else{
    		 var preview = $("#hidpreview").val();  
    	     var url=document.URL;
    	     var reurl=url.split("com/");   
    	     $("#docno").prop("disabled", false);  
    	     var win= window.open(reurl[0]+"printServiceContractSkip?docno="+document.getElementById("masterdoc_no").value+"&branch="+document.getElementById("brchName").value+"&revisionno="+document.getElementById("txtrevise").value+"&preview="+preview+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    	     win.focus();  
    	     $("#hidpreview").val(0);  
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
	function getsite(rowBoundIndex){
		  $('#siteinfowindow').jqxWindow('open');  
	      siteSearchContent('siteSearch.jsp?rowBoundIndex='+rowBoundIndex+'&gridtextbox=2');
    }
	function siteSearchContent(url) {
		 $.get(url).done(function (data) {
	     $('#siteinfowindow').jqxWindow('setContent', data);
         }); 
	}    
    function cquesContent(url) {
 	 $.get(url).done(function (data) {
	 $('#closetquesinfowindow').jqxWindow('setContent', data);

               	}); 
     	}
 function getcontact(event){
	  	
		var clientid=document.getElementById("txtenquiry").value;
		var chkval=$('#custid').val();
		if((clientid=="") && !(parseInt(chkval)==1)){
			//alert("in contact");
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
		}
		var x= event.keyCode;
		 if(x==114){
	 	  $('#cpinfowindow').jqxWindow('open');
	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid); 
	        	 }
		 else{
			 }
		 }
	        	 
	function cpSearchContent(url) {
		 //alert(url);
	 	 $.get(url).done(function (data) {
				 //alert(data);
		$('#cpinfowindow').jqxWindow('setContent', data);

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
		//$('#frmContract')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmContract input').prop('readonly', true );
		$('#frmContract textarea').attr('readonly', true );
		$('#frmContract select').attr('disabled', true);
		$("#siteGrid").jqxGrid({ 'disabled': true});
		$('#quoteDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxQuote").jqxGrid({ disabled: true});
	    $("#jqxclientconfirmGrid").jqxGrid({ disabled: true});
	    $("#revbtn").attr('disabled', true );
	    $('#witheffectDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxtermsGrid").jqxGrid({ 'disabled': true}); 
	    
	    $("#txtcperson").attr('disabled', true );
	    $("#txtclient").attr('disabled', true );
	    $("#btntermsload").attr('disabled', true );     
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
			Setviewmode(contrno);    
		}
	}
	function funRemoveReadOnly(){
		document.getElementById("statusval").innerHTML=" ";
		document.getElementById("errormsg").innerText="";
		$('#frmContract input').attr('readonly', false );
		$('#frmContract textarea').attr('readonly', false );
		$('#frmContract select').attr('disabled', false);
		$('#txtgroupcompanies').attr('readonly', true);  
		$('#txtsource').attr('readonly', true);
		$('#txtenquiry').attr('readonly', true);
		$('#txtclient').attr('readonly', true);
		$('#txtsalesman').attr('readonly', true);
		$('#txtsource').attr('readonly', true);  
		$('#txtmail').attr('readonly', true);
		$('#txtaddress').attr('readonly', true);
		$('#txtmob').attr('readonly', true);
		$('#txttele').attr('readonly', true);  
		$("#siteGrid").jqxGrid({ disabled: false});
		$('#quoteDate').jqxDateTimeInput({ disabled: false}); 
		$("#jqxQuote").jqxGrid({ disabled: false});
		$("#jqxclientconfirmGrid").jqxGrid({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$("#revbtn").attr('disabled', true );
		$('#witheffectDate').jqxDateTimeInput({ disabled: true});
		$("#jqxtermsGrid").jqxGrid({ 'disabled': false});  
		$("#txtcperson").attr('disabled', false );
		$("#txtclient").attr('disabled', false );
		$("#btntermsload").attr('disabled', false );     
		refChange();
		funadvtypechange();
		getmultilineconfig();
		if ($("#mode").val() == "A") {
			 $('#quoteDate').val(new Date());
		     $("#jqxQuote").jqxGrid('clear');
		     $("#jqxQuote").jqxGrid('addrow', null, {});
		     $("#siteGrid").jqxGrid('clear');
			 $("#siteGrid").jqxGrid('addrow', null, {});
			 document.getElementById('calcshowlbl').innerHTML="";
			 fuchangetodate();  
		 }
		
		if ($("#mode").val() == "E") {   
			  $("#jqxQuote").jqxGrid('addrow', null, {});
		}
		if (mod1 == "A") { 
			 document.getElementById("txtsalesman").value='<%=salesman%>';
			 document.getElementById("txtsalesmandocno").value='<%=salid%>';  
		     document.getElementById("txtenquiry").value='<%=vocno%>';
	         document.getElementById("hidenqdocno").value='<%=enqdocno%>';
	         document.getElementById("txtclient").value='<%=client%>';
	         document.getElementById("hidcldocno").value='<%=cldocno%>';
			 document.getElementById("txtmail").value='<%=mail%>';
			 document.getElementById("txtaddress").value='<%=address%>';
			 document.getElementById("txtmob").value='<%=mob%>';
			 document.getElementById("txttele").value='<%=telno%>'; 
			 document.getElementById("txtgroupcompanies").value='<%=grpname%>';
			 document.getElementById("cmbbillingmethod").value='<%=billingmethod%>';
			 
			 document.getElementById("hidcmbpayterm").value='<%=payterms%>';   
			 getPayterms();
			 document.getElementById("cmbreftype").value='<%=reftype%>'; 
			 document.getElementById("txtcperson").value='<%=cperson%>'; 
			 document.getElementById("hidcpersonid").value='<%=cpersonid%>'; 
			 document.getElementById("cmbpayterm").value='<%=payterms%>';
			 document.getElementById("hidcnttrno").value='<%=contrno%>';  
		     var trno = $("#hidcnttrno").val();
		     funnoofmonthval();
		     if(parseInt(trno)>0){  
		    	 getOldContractDetails(trno);  
		     }
			 var frompresales='<%=frompresales%>'; 
			 if(parseInt(frompresales)==1){
				 var indexVal1 = '<%=qottrno%>'; 
				 var revisionno = '<%=qotrevno%>';   
		         $("#quotdiv").load("quoteDetails.jsp?enqdocno="+indexVal1+"&revisionno="+revisionno+"&id="+1);    
		         $("#sitediv").load("siteGrid.jsp?enqdocno="+indexVal1+"&revisionno="+revisionno+"&id="+1); 
			 }else{
				 document.getElementById("txtdesc").value='<%=description%>'; 
				 document.getElementById("cmbtype").value='<%=type%>'; 
		         var startdate='<%=startdt%>'.split('.');  
		         var endDate='<%=enddt%>'.split('.');
		         var quoteDate='<%=date%>'.split('.');
		         $('#startDate').jqxDateTimeInput('setDate',new Date(startdate[2],startdate[1]-1,startdate[0]));    
		         $('#endDate').jqxDateTimeInput('setDate',new Date(endDate[2],endDate[1]-1,endDate[0]));
		         $('#quoteDate').jqxDateTimeInput('setDate',new Date(quoteDate[2],quoteDate[1]-1,quoteDate[0]));
				 var indexVal2 = '<%=contrno%>';     
		         $("#quotdiv").load("quoteDetails.jsp?trno="+indexVal2+"&id="+2);  
		         $("#sitediv").load("siteGrid.jsp?trno="+indexVal2+"&id="+2);  
		         $("#clcondiv").load("clientConfirmGrid.jsp?trno="+indexVal2+"&id="+1); 
			 }
			 refChange();
	  }
	  $('#txtrevise').attr('readonly', true);
	}
	
	function Setviewmode(contrno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			 	var items= x.responseText;
			 	items=items.split('###');
			console.log("====="+items[1]);  
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
			    //document.getElementById("sourceid").value=items[11];
			    //document.getElementById("txtsource").value=items[12];
			    document.getElementById("txtenquiry").value=items[13];
			    document.getElementById("hidenqdocno").value=items[14];
			    document.getElementById("txtsalesmandocno").value=items[15];
			    document.getElementById("txtsalesman").value=items[16];
			    document.getElementById("txtgroupcompanies").value=items[17]; 
			    document.getElementById("startDate").value=items[18];  
			    document.getElementById("endDate").value=items[19]; 
			    document.getElementById("cmbpayterm").value=items[20]; 
			    document.getElementById("hidcmbpayterm").value=items[20];
			    $('#witheffectDate').val(items[21]);   
			    document.getElementById("txtrevise").value=items[22]; 
			    document.getElementById("cmbtype").value=items[23];
			    document.getElementById("hidcmbtype").value=items[23];
			    $('#quoteDate').jqxDateTimeInput({ disabled: false});  
			    document.getElementById("frmContract").submit();  
			 }else {}
	     }
	     x.open("GET","setViewMode.jsp?masterdoc="+contrno,true);  
	     x.send();
    }
	
	function getareas(rowBoundIndex){
  	  $('#areainfowindow').jqxWindow('open');
            areaSearchContent('area.jsp?rowBoundIndex='+rowBoundIndex);
    }
         	 
 function areaSearchContent(url) {
  //alert(url);
  	 $.get(url).done(function (data) {
 		 //alert(data);
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
	  function getClient(){
		     var type = $("#cmbreftype").val();  
		     if(type=="DIR"){   
		    	 var x= event.keyCode;
		    	 if(x==114){
			    	  $('#clientsearch').jqxWindow('open');
			    	  clientSearchContent('clientsearch.jsp?', $('#clientsearch'));    
		    	  }else{       
		    	  } 
		      }
	       }   
		  function clientSearchContent(url) { 
		          $.get(url).done(function (data) {
			           $('#clientsearch').jqxWindow('setContent', data);
	          	  }); 
		  }        
	       
	function funNotify(){
		 var stdate=new Date($('#startDate').jqxDateTimeInput('getDate'));
		 stdate.setHours(0,0,0,0);
		 var enddate=new Date($('#endDate').jqxDateTimeInput('getDate'));
		 enddate.setHours(0,0,0,0);
		 if(enddate<stdate){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="End Date Should not less than Start Date";  
			 return false;
		 } else if(stdate>enddate){ 
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Start Date Should not greater than End Date";  
			 return false;
		 }
		 else{
			 document.getElementById("errormsg").innerText="";
		 }      
		$('#quoteDate').jqxDateTimeInput({ disabled: false});
		
		 var reftype=$('#cmbreftype').val();
		 if(reftype=='ENQ'){
			 var valid2=document.getElementById("txtenquiry").value;
			 if(valid2=="") {
					document.getElementById("errormsg").innerText="Please Select Enquiry";
					return 0;
				 }else{
					 document.getElementById("errormsg").innerText="";
				}
		 } else{
			 var valid2=document.getElementById("txtclient").value;  
			 if(valid2=="") {
					document.getElementById("errormsg").innerText="Please Select client";  
					return 0;
				 }else{
					 document.getElementById("errormsg").innerText="";  
				}
		 }
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
		var invmethod=$('#cmbinvmethod').val();      
		var advinvvalue=$('#txtadvinvvalue').val();  
		var billingmethod=$('#cmbbillingmethod').val();
		/*if(invmethod=="1" && (billingmethod=="1" || billingmethod=="2")){ 
			if(advinvvalue=="0" || advinvvalue==""){  
				document.getElementById("errormsg").innerText="Please Enter No of months";      
				return 0;
			}else{
				 document.getElementById("errormsg").innerText=""; 
			} 
		} */ 
		 
		var rows1 = $("#jqxQuote").jqxGrid('getrows'); 
		var sitchek=0;
		for(var k=0;k<rows1.length;k++){  
			if((rows1[k].total!="" && typeof(rows1[k].total)!="undefined" && typeof(rows1[k].total)!="NaN"  && rows1[k].total!=null) || (rows1[k].skipdoc!="" && typeof(rows1[k].skipdoc)!="undefined" && typeof(rows1[k].skipdoc)!="NaN"  && rows1[k].skipdoc!=null)) {    
				if(rows1[k].site==""){    
					//console.log("site==="+rows1[k].site);    
					sitchek++;  
				}
			}
		}  
		if(sitchek>0){  
			document.getElementById("errormsg").innerText="Please select site in contract details";     
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
				document.getElementById("errormsg").innerText="You can't add more than one line in contract details!!!";  
				return 0;
			}
		}
		var validenqrows = $("#jqxQuote").jqxGrid('getrows');   
		var valid=0,valid1=0,valid2=0;  
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
		 if(valid2==1){
			 document.getElementById("errormsg").innerText="For adv invoice, please select ctype as rent";               
			 return 0;  
		 }
		
	     var quotlen=0,sitellen=0,crmlen=0,termslen=0; 
	 	 var rows = $("#jqxQuote").jqxGrid('getrows'); 
	 	 var rowssitegrid = $("#siteGrid").jqxGrid('getrows');
	 	 var rows1 = $("#jqxclientconfirmGrid").jqxGrid('getrows');   
	 	 console.log(rows.length+"=="+rowssitegrid.length);
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
				       .attr("id", "contrtest"+i)
				       .attr("name", "contrtest"+i)
				       .attr("hidden", "true"); 
				    newTextBox.val(rows[i].site+" :: "+rows[i].skipdoc+" :: "+rows[i].nos+" :: "+rows[i].wastedoc+" :: "+rows[i].ownershipid+" :: "+rows[i].servicebyid+" :: "+rows[i].servicetermid+" :: "+rows[i].days+" :: "+rows[i].specid+" :: "+rows[i].collectionid+" :: "+rows[i].rate+" :: "+rows[i].tippingfee+" :: "+rows[i].foc+" :: "+rows[i].rent+" :: "+rows[i].siteid+" :: "+rows[i].securityval+" :: "+rows[i].tippingmethodid+" :: "+rows[i].tippingsecurity+" :: "+restricted+" :: "+rows[i].tariffrate+" :: "+rows[i].rowno+" :: "+rows[i].gatefee+" :: "+rows[i].addrate+" :: "+rows[i].ctypeid+" :: ");
				    newTextBox.appendTo('form');  
				   quotlen++;
			   }	   
		   }       
		   for(var i=0 ; i < rowssitegrid.length ; i++){
			   if(rowssitegrid[i].site!="") {
				    newTextBox = $(document.createElement("input"))  
				       .attr("type", "dil")
				       .attr("id", "contrtestsitetest"+i)
				       .attr("name", "contrtestsitetest"+i)
				       .attr("hidden", "true"); 
				 
				   newTextBox.val(rowssitegrid[i].site+" :: "+rowssitegrid[i].remarks+" :: "+rowssitegrid[i].areaid+" :: "+rowssitegrid[i].surid+" :: "+rowssitegrid[i].route+" :: "+rowssitegrid[i].gpsx+" :: "+rowssitegrid[i].gpsy+" :: "+rowssitegrid[i].description+" :: ");  
				   newTextBox.appendTo('form'); 
				   sitellen++;
				}
		   }
		   for(var i=0 ; i < rows1.length ; i++){      
			   if(rows1[i].pono!="") {          
				    newTextBox = $(document.createElement("input"))    
				       .attr("type", "dil")
				       .attr("id", "cltest"+crmlen)
				       .attr("name", "cltest"+crmlen)   
				       .attr("hidden", "true"); 
				    var date = $('#jqxclientconfirmGrid').jqxGrid('getcelltext',i,'date');
				    var validupto = $('#jqxclientconfirmGrid').jqxGrid('getcelltext',i,'validupto');     
				    newTextBox.val(rows1[i].pono+" :: "+date+" :: "+rows1[i].amount+" :: "+validupto+" :: "+rows1[i].description+" :: "+rows1[i].rowno+" :: "+rows1[i].qty+" :: "+rows1[i].attach+" :: "+rows1[i].path+" :: ");           
				    newTextBox.appendTo('form');  
				    crmlen++;
			   } 	   
		   }
		   var rows2 = $("#jqxtermsGrid").jqxGrid('getrows');  
		   for(var i=0 ; i < rows2.length ; i++){      
			   if(rows2[i].terms!="") {             
				    newTextBox = $(document.createElement("input"))    
				       .attr("type", "dil")
				       .attr("id", "terms"+i)
				       .attr("name", "terms"+i)  
				       .attr("hidden", "true"); 
				    newTextBox.val(rows2[i].terms+" :: "+rows2[i].conditions);                  
				    newTextBox.appendTo('form');     
				    termslen++;
			   } 	   
		   }
		   $('#enqgridlenght').val(quotlen); 
		   $('#siteGridlength').val(sitellen);
		   $('#thirdgridlength').val(crmlen); 
		   $('#termsgridlength').val(termslen);   
		   var retval  = restrictEdit();  
		   if(retval==0){     
		   		document.getElementById("errormsg").innerText="You cannot change terminated contract!";         
		   }else{
		 		document.getElementById("errormsg").innerText="";
		   }   
		  return retval;
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
		  document.getElementById("formdetail").value="Service Contract";  
	   	  document.getElementById("formdetailcode").value="AMC";  
	   	  if($('#hidwitheffectDate').val()!="" && $('#hidwitheffectDate').val()!=null){
			 $("#witheffectDate").jqxDateTimeInput('val', $('#hidwitheffectDate').val());
		   }  
		  if($('#hidquoteDate').val()!="" && $('#hidquoteDate').val()!=null){
			  $("#quoteDate").jqxDateTimeInput('val', $('#hidquoteDate').val());
		   }
		  if($('#hidstartDate').val()!="" && $('#hidstartDate').val()!=null){
				$("#startDate").jqxDateTimeInput('val', $('#hidstartDate').val());
			   }
		  if($('#hidendDate').val()!="" && $('#hidendDate').val()!=null){
				$("#endDate").jqxDateTimeInput('val', $('#hidendDate').val());
			   }
		  if($('#hidcmbtype').val()!="" && $('#hidcmbtype').val()!=null){
				$("#cmbtype").val($('#hidcmbtype').val()); 
			   }
		  if($('#hidcmbbillingmethod').val()!=""){
				$("#cmbbillingmethod").val($('#hidcmbbillingmethod').val());
			   }  
		  if($('#hidcmbpayterm').val()!=""){
			  $("#cmbpayterm").val($('#hidcmbpayterm').val());   
		  }
		  if($('#hidcmbreftype').val()!=""){
			  $("#cmbreftype").val($('#hidcmbreftype').val());     
		  }
		  if($('#hidcmbinvmethod').val()!=""){
			  $("#cmbinvmethod").val($('#hidcmbinvmethod').val());        
		  }
		  
		  if($('#hidcmbadvtype').val()!=""){
			  $("#cmbadvtype").val($('#hidcmbadvtype').val());        
		  }
		  if($('#hidcmbinctipfee').val()!=""){
			  $("#cmbinctipfee").val($('#hidcmbinctipfee').val());        
		  }
		  if($('#hidcmbinvstart').val()!=""){
			  $("#cmbinvstart").val($('#hidcmbinvstart').val());            
		  }
		  
		  if($("#hidcmbcctype").val()!=""){
			  $("#cmbcctype").val($("#hidcmbcctype").val());
		  }
		  
		  var chkmerged = document.getElementById("hidchkmergedinv").value;
		  if(parseInt(chkmerged)==1){    
			  document.getElementById("chkmergedinv").checked = true;  
		  }else{
			  document.getElementById("chkmergedinv").checked = false;  
		  }   
		  
		  var chkmanualinv = document.getElementById("hidchkmanualinv").value;
		  if(parseInt(chkmanualinv)==1){    
			  document.getElementById("chkmanualinv").checked = true;  
		  }else{
			  document.getElementById("chkmanualinv").checked = false;     
		  }
		  
  	      var docVal1 = document.getElementById("masterdoc_no").value;
      	  if(docVal1>0) {
		    var indexVal2 = document.getElementById("masterdoc_no").value;
		    var txtrevise = document.getElementById("txtrevise").value;
            $("#quotdiv").load("quoteDetails.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);  
            $("#sitediv").load("siteGrid.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);   
            $("#clcondiv").load("clientConfirmGrid.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+1); 
            $("#termsdiv").load("termDetails.jsp?trno="+indexVal2+"&id="+1);    
      	  }  
      	  if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
      	  changeGridOptions();
      	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
      	  funadchange();
      	  funadvtypechange();
      	  editstatuscheck();
      	funDtype();
		getapprcount();
		apprCheck();
		enquiryAlert();
	}
	function changeGridOptions(){
		var type=$("#cmbtype").val();
		if(type=="2"){
			$("#clconfirmlbl").show(); 
		}else{
			$("#clconfirmlbl").hide();
		}
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
			 }else {}
	     }
	     x.open("GET","getTariffRate.jsp?ownership="+encodeURIComponent(ownership)+"&noofvisit="+noofvisit+"&skipdoc="+skipdoc+"&tripsinmonth="+tripsinmonth,true);       
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
			 	}  
			 }else {}
	     }
	     x.open("GET","getTariffFee.jsp?skipsize="+skipsize+"&wastetype="+wastetype,true);       
	     x.send();
    } 
	function refChange(){
		 var reftype=$('#cmbreftype').val();
		 if(reftype=='DIR'){
			  $('#txtenquiry').attr('disabled', true);
			  $('#txtclient').attr('placeholder', 'Press F3 to Search'); 
			  $("#siteGrid").jqxGrid({ 'disabled': false});
			  $("#jqxQuote").jqxGrid({ 'disabled': false});  
		 }
		 else{
			  $('#txtenquiry').attr('disabled', false); 
			  $('#txtclient').attr('placeholder', ''); 
			  $("#siteGrid").jqxGrid({ 'disabled': true});
			  $("#jqxQuote").jqxGrid({ 'disabled': true});    
		 }
		}
	function funnoofmonthval(){    
		 var billingmethod=$('#cmbbillingmethod').val();  
		 if(billingmethod=="1"){
			  $('#txtadvinvvalue').val(3); 
			  $('#cmbinvmethod').val(0);
		 }else if(billingmethod=="2"){
			  $('#txtadvinvvalue').val(12); 
			  $('#cmbinvmethod').val(1);     
		 }else{
			  $('#txtadvinvvalue').val(0);
			  $('#cmbinvmethod').val(2);      
		 }
	}
	
	function editstatuscheck(){ 
		    var revision=$("#txtrevise").val();
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.split("####");  	
						if(parseInt(items[0])>0) {  
							 $("#btnEdit").attr('disabled', true ); 
							 $("#btnDelete").attr('disabled', true ); 
							 $("#revbtn").attr('disabled', true ); 
							 $('#witheffectDate').jqxDateTimeInput({ disabled: true});
							 if(revision=="" || revision=="0"){ 
								 $('#witheffectlbl').hide();  
								 $('#witheffectDate').hide();
							 }
						 }else {
							 $("#btnEdit").attr('disabled', false );
							 $("#btnDelete").attr('disabled', false );
							 $("#revbtn").attr('disabled', false ); 
							 $('#witheffectlbl').show();
							 $('#witheffectDate').show();
							 $('#witheffectDate').jqxDateTimeInput({ disabled: false});
							 $('#txtdesc').attr('readonly', false);
							 $('#txtintremarks').attr('readonly', false);
							 $('#txtextremarks').attr('readonly', false);
						 }
						if(parseInt(items[1])>0 || parseInt(items[0])>0 || parseInt(items[4])==10){             
							 $("#btnEdit").attr('disabled', true );  
						}else{
							 $("#btnEdit").attr('disabled', false );   
						}
						if(parseInt(items[2])==0 || parseInt(items[0])>0 || parseInt(items[4])==10){              
							 $("#revbtn").attr('disabled', true ); 
							 $('#witheffectDate').jqxDateTimeInput({ disabled: true});
							 if(revision=="" || revision=="0"){ 
								 $('#witheffectlbl').hide();  
								 $('#witheffectDate').hide();   
							 }
						}else{
							 $("#revbtn").attr('disabled', false );
							 $('#witheffectlbl').show();
							 $('#witheffectDate').show();   
							 $('#witheffectDate').jqxDateTimeInput({ disabled: false});
							 if(items[3]!=null && items[3]!=""){  
								 $('#witheffectDate').val(new Date(items[3]));
							 }
							 $('#txtdesc').attr('readonly', false);
							 $('#txtintremarks').attr('readonly', false);
							 $('#txtextremarks').attr('readonly', false);
						}  
					}else {  
					}    
			}
			x.open("GET", "getEditStat.jsp?trno="+$('#masterdoc_no').val(), true);                  
			x.send();
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
	function funrevise(){ 
				var docVal1 = document.getElementById("masterdoc_no").value;
		      	if(docVal1=="" || docVal1=="0") {    
		      		$.messager.alert('Message','Select a Document....!','warning');
					return;
		      	}
				if(document.getElementById("revbtn").value=='Save'){
					funrevisesave();     
				} 
				document.getElementById("formdetailcode").value="AMC"; 
				document.getElementById("mode").value='R';
				$("#siteGrid").jqxGrid({ disabled: false});
				$("#jqxQuote").jqxGrid({ disabled: false}); 
				$('#cmbbillingmethod').attr('disabled', false);
				$('#cmbpayterm').attr('disabled', false);
				$('#cmbinvmethod').attr('disabled', false);
				$('#cmbadvtype').attr('disabled', false);
				$('#cmbinctipfee').attr('disabled', false); 
				$('#cmbtype').attr('disabled', false);
				$('#cmbcctype').attr('disabled', false);
				$("#revbtn").attr('value', 'Save');            	   
    }
	function funrevisesave(){ 
		         var witheffectdate = $("#witheffectDate").val(); 
		         if(witheffectdate=="" || witheffectdate==null) {    
			      		$.messager.alert('Message','Please select with effect date!','warning');
						return;
			     }
				 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	if(r==false)  {		     	   
			     		return false; 
			     	}else{	
			     		   $("#overlay, #PleaseWait").show();     
				     	   var temp=funNotify();  
						   if(temp>0){   
							   $('#frmContract select').attr('disabled', false); 
							   $('#frmContract input').attr('disabled', false);  
							   $('#frmContract textarea').attr('disabled', false); 
							   document.getElementById("frmContract").submit();  
						   }
			     	}  
			    }); 
	}  
	function funloadterms(){
		 var typeid=0;
		 var ctype= $('#jqxQuote').jqxGrid('getcellvalue', 0, "ctype");
		 var billingmethod=$('#cmbbillingmethod').val();
		 var ownership= $('#jqxQuote').jqxGrid('getcellvalue', 0, "ownership"); 
		 
		 if(ownership=="CLIENT SKIP" && billingmethod=="1"){      
			 typeid=2;
         }else if(ownership=="CLIENT SKIP" && billingmethod=="2"){
        	 typeid=3;
         }else if(ownership=="OWN SKIP" && billingmethod=="1"){
        	 typeid=1;
         }else if(ownership=="OWN SKIP" && billingmethod=="2"){
        	 typeid=4;
         }else if(billingmethod=="3"){     
        	 typeid=5;
         }else{
        	 typeid=0; 
         }    
		 
		 $("#termsdiv").load("termDetails.jsp?typeid="+typeid+"&id="+2);       
	}
	function fuchangetodate(){
		var billingtype=$("#cmbbillingmethod").val();
		
		if(billingtype=="1"){
			 var endDates=new Date();  
		     var onemonth=new Date(new Date(endDates).setFullYear(endDates.getFullYear()+5));    
		     $('#endDate').jqxDateTimeInput('setDate', new Date(onemonth));
		}else if(billingtype=="3"){  
			 var endDates=new Date();  
		     var onemonth=new Date(new Date(endDates).setDate(endDates.getDate()+7));    
		     $('#endDate').jqxDateTimeInput('setDate', new Date(onemonth));
		}else{
			 var endDates=new Date();  
		     var onemonth=new Date(new Date(endDates).setFullYear(endDates.getFullYear()+1));      
		     $('#endDate').jqxDateTimeInput('setDate', new Date(onemonth.setDate(endDates.getDate()-1)));
		}
	}
	function funchangemergedinvoice(){
		if(document.getElementById("chkmergedinv").checked){
			document.getElementById("hidchkmergedinv").value=1;
		}else{
			document.getElementById("hidchkmergedinv").value=0;
		}
	}
	function funchangemanualinvoice(){
		if(document.getElementById("chkmanualinv").checked){
			document.getElementById("hidchkmanualinv").value=1;
		}else{
			document.getElementById("hidchkmanualinv").value=0;
		}
	}
	function funadchange(){
		var advinvoice=document.getElementById("cmbinvmethod").value;
		if(advinvoice=="1" && $("#mode").val()!="view"){   
			$("#cmbadvtype").attr('disabled', false );     
		}else{
			$("#cmbadvtype").attr('disabled', true );      
		}
	}
	function funadvtypechange(){
		var advtype=document.getElementById("cmbadvtype").value;
		if(parseInt(advtype)==0){
			$("#txtadvinvvalue").val(12);   
		}else if(parseInt(advtype)==1){
			$("#txtadvinvvalue").val(6);   
		}else if(parseInt(advtype)==2){
			$("#txtadvinvvalue").val(3);   
		}else if(parseInt(advtype)==3){
			$("#txtadvinvvalue").val(1);
		}else { 
		}   
	}
	function getOldContractDetails(trno){  
		    var x = new XMLHttpRequest;
		    x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {  
					var items= x.responseText.split('###');  
					document.getElementById("txtgroupcompanies").value=items[0];
					document.getElementById("cmbadvtype").value=items[1];  
					document.getElementById("cmbinctipfee").value=items[2];
					document.getElementById("cmbinvstart").value=items[3];
					document.getElementById("txtcperson").value=items[4];  
					document.getElementById("hidcpersonid").value=items[5];
					document.getElementById("hidchkmergedinv").value=items[6];
					document.getElementById("txtrefno").value=items[7];
					document.getElementById("txtadvinvvalue").value=items[8];
					document.getElementById("cmbinvmethod").value=items[9];
					var chkmerged = document.getElementById("hidchkmergedinv").value;    
					if(parseInt(chkmerged)==1){      
						  document.getElementById("chkmergedinv").checked = true;  
					}else{
						  document.getElementById("chkmergedinv").checked = false;    
					}    
				} else {  
			    }    
			}
			x.open("GET", "getOldContractDetails.jsp?trno="+trno, true);                             
			x.send();
	}
	function funPreview(){  
		$("#hidpreview").val(1);    
		funPrintBtn();
	}
	function restrictEdit(){
		        var retval = 1; 
				if($("#mode").val()=="E" || $("#mode").val()=="R"){       
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
					x.open("GET", "restrictEdit.jsp?trno="+$('#masterdoc_no').val(), false);                  
					x.send();
					}
				return retval; 
	 }
</script>
</head>
<body onload="setValues();getPayterms();getmultilineconfig();">  <!--  onmouseover="editstatuscheck();"   -->           
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmContract" action="saveServiceContractSkips" autocomplete="OFF">            

<jsp:include page="../../../header.jsp"></jsp:include><br/>
<div  class='hidden-scrollbar'>
<fieldset>
<!-- <legend>Customer Enquiry</legend>  -->   
<table width="100%" border="0"> 
<tr>
<td align=right colspan="9"><label id="statusval" ></label></td>
</tr>                         
  <tr>
     <td width="7%" align="right">&nbsp;&nbsp;Date</td>   
     <td width="17%"><div id='quoteDate' name='quoteDate' value='<s:property value="quoteDate"/>'></div>     
          <input type="hidden" id="hidquoteDate" name="hidquoteDate" value='<s:property value="hidquoteDate"/>'/>
     </td>
     <td width="5%" align="right" ><label id="witheffectlbl">With effect</label></td>  
     <td width="8%"><div id='witheffectDate' name='witheffectDate' value='<s:property value="witheffectDate"/>'></div>         
          <input type="hidden" id="hidwitheffectDate" name="hidwitheffectDate" value='<s:property value="hidwitheffectDate"/>'/></td>   
       <td width="33%">Revision&nbsp;<input type="text" id="txtrevise" name="txtrevise" style="width:30%;" value='<s:property value="txtrevise"/>'/>
     &nbsp;<input type="button" id="revbtn" class="myButton" onclick="funrevise();" value="Revise" >
        <button type="button" class="icon tooltip" id="btnPrint" onclick="funPreview()">  
				 <img alt="printDocument" src="<%=contextPath%>/icons/print_new.png">
				 <span class="tooltiptext">Preview</span>  
		  </button></td>     
        <td width="5%" align="right">Ref No</td>    
       <td width="33%"><input type="text" id="txtrefno" name="txtrefno" style="width:50%;" value='<s:property value="txtrefno"/>'/></td> 
     <td width="5" align="right" >Doc No</td>   
     <td width="10%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
     </tr>
   <tr>
     <td width="7%" align="right">Ref Type</td>
     <td  width="17%"><select id="cmbreftype" name="cmbreftype" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>  
      <option value="ENQ">ENQ</option>
      </select><input type="text" id="txtenquiry" name="txtenquiry"  placeholder="Press F3 To Search" value='<s:property value="txtenquiry"/>' onKeyDown="getEnquiry();">
		<input type="hidden" id="hidenqdocno" name="hidenqdocno"  style="width: 70%;" value='<s:property value="hidenqdocno"/>'>
		<input type="hidden" id="hidcmbreftype" name="hidcmbreftype"  style="width: 70%;" value='<s:property value="hidcmbreftype"/>'>     
      </td>  
      <td  width="5%" align="right">Client</td>         
      <td width="13%" colspan="2"><input type="text" id="txtclient" name="txtclient" style="width:97%;" placeholder="Press F3 To Search"  value='<s:property value="txtclient"/>' onKeyDown="getClient();">
		<input type="hidden" id="hidcldocno" name="hidcldocno" value='<s:property value="hidcldocno"/>'></td>	
	  <td  width="7%" align="right">Group Companies</td>             
      <td width="33%"><input type="text" id="txtgroupcompanies" name="txtgroupcompanies" style="width:97%;" value='<s:property value="txtgroupcompanies"/>'> </td>
	  <td  width="5%" align="right">Salesman</td>  
      <td width="13%"><input type="text" id="txtsalesman" name="txtsalesman" value='<s:property value="txtsalesman"/>' >
        <input type="hidden" id="txtsalesmandocno" name="txtsalesmandocno" value='<s:property value="txtsalesmandocno"/>'></td> 
   </tr> 
 <tr> 
    <td width="7%" align="right">Contact Person</td>             
    <td width="17%"><input type="text" id="txtcperson" name="txtcperson" style="width:94%;" placeholder="Press F3 To Search" value='<s:property value="txtcperson"/>'>
    <input type="hidden" id="hidcpersonid" name="hidcpersonid" value='<s:property value="hidcpersonid"/>'></td> 
    <td width="5%" align="right">Address</td>         
    <td width="33%" colspan="2"><input type="text" id="txtaddress" name="txtaddress" style="width:97%;" value='<s:property value="txtaddress"/>'></td>
    <td width="5%" align="right" >Email</td>  
    <td width="13%" align="left" ><input type="text" id="txtmail" style="width:97%;" name="txtmail" value='<s:property value="txtmail"/>'></td>
	<td  width="6%" align="right"> Mob</td>         
    <td width="13%"><input type="text" id="txtmob" name="txtmob"  value='<s:property value="txtmob"/>'> </td>	
  </tr>
  <tr> 
    <td width="7%" align="right" >Tel</td>   
    <td width="17%" align="left" ><input type="text" id="txttele" name="txttele" style="width:94%;" value='<s:property value="txttele"/>'></td>
    <td width="38%" align="right" colspan="3">  
       <table width="100%">  
          <tr>
		       <td width="16.7%" align="right" >Start Date</td>      
		       <td width="25%" align="left" ><div id='startDate' name='startDate' value='<s:property value="startDate"/>'></div>   
		          <input type="hidden" id="hidstartDate" name="hidstartDate" value='<s:property value="hidstartDate"/>'/></td>	
		       <td width="25%" align="right" >End Date</td>   
		       <td width="25%" align="left" ><div id='endDate' name='endDate' value='<s:property value="endDate"/>'></div>   
		          <input type="hidden" id="hidendDate" name="hidendDate" value='<s:property value="hidendDate"/>'/></td> 
	      </tr>   
       </table>    
    </td> 
    <td width="18%" align="right" colspan="2">     
       <table width="100%">
          <tr>
               <td width="20%" align="right" >Type</td>      
		       <td width="30%" align="left" ><select id="cmbtype" name="cmbtype"  onchange="changeGridOptions();">   
			     <option value="1">Contract</option>     
			     <option value="2">LPO Based</option></select>   
			    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'></td>	
			   <td width="20%" align="right" >Billing Method</td>    
		       <td width="30%" align="left" ><select  id="cmbbillingmethod" name="cmbbillingmethod" style="width:99%;" onchange="funnoofmonthval();getPayterms();fuchangetodate();">       
			      <option value="">--Select--</option><option value="1">Monthly</option><option value="2">Yearly</option><option value="3">Adhoc</option></select>  
			      <input type="hidden" id="hidcmbbillingmethod" name="hidcmbbillingmethod" value='<s:property value="hidcmbbillingmethod"/>'></td>
          </tr>  
       </table>
    </td>
    <td  width="6%" align="right">Pay Term</td>         
    <td width="13%"><select  id="cmbpayterm" name="cmbpayterm" style="width:98%;"></select>               
       <input type="hidden" id="hidcmbpayterm" name="hidcmbpayterm"  value='<s:property value="hidcmbpayterm"/>'></td>                 	
  </tr>    
  <tr>  
     <td width="7%"  align="right"><input type="checkbox" id="chkmergedinv" name="chkmergedinv" onchange="funchangemergedinvoice()"> 
        <input type="hidden" id="hidchkmergedinv" name="hidchkmergedinv"  value='<s:property value="hidchkmergedinv"/>'> </td>
       <td width="17%" align="left">&nbsp;Merged Invoice&ensp;
       <input type="checkbox" id="chkmanualinv" name="chkmanualinv" onchange="funchangemanualinvoice()"> 
<input type="hidden" id="hidchkmanualinv" name="hidchkmanualinv" value='<s:property value="hidchkmanualinv"/>'>
&nbsp;Manual Invoice&nbsp;</td>    
    <td width="7%" align="right" >Adv Invoice</td>    
    <td width="15%" align="left" colspan="2"> <select id="cmbinvmethod" name="cmbinvmethod" onchange="funadchange();">        
       <option value="1">Yes</option><option value="0">No</option></select>  
      <input type="hidden" id="hidcmbinvmethod" name="hidcmbinvmethod" value='<s:property value="hidcmbinvmethod"/>'> 
      <input type="hidden" id="txtadvinvvalue" name="txtadvinvvalue" style="width:32%;" value='<s:property value="txtadvinvvalue"/>'>    
      &nbsp; &nbsp;<select  id="cmbadvtype" name="cmbadvtype" onchange="funadvtypechange();">             
       <option value="0">Yearly</option><option value="1">Half-Yearly </option><option value="2">Quarterly</option><option value="3">Monthly</option></select>  
      <input type="hidden" id="hidcmbadvtype" name="hidcmbadvtype" value='<s:property value="hidcmbadvtype"/>'>
      &nbsp; &nbsp; &nbsp; &nbsp;Including Tipping Fee &nbsp;<select  id="cmbinctipfee" name="cmbinctipfee">        
       <option value="0">No</option><option value="1">Yes</option></select>    
      <input type="hidden" id="hidcmbinctipfee" name="hidcmbinctipfee" value='<s:property value="hidcmbinctipfee"/>'> </td>                     
    <td width="7%" align="right" >Invoicing starts</td>      
    <td width="15%" align="left" colspan="3"> <select  id="cmbinvstart" name="cmbinvstart">          
       <option value="0">Contract start date</option><option value="1">Delivery date</option></select>      
       <input type="hidden" id="hidcmbinvstart" name="hidcmbinvstart" value='<s:property value="hidcmbinvstart"/>'>    
       &nbsp;&nbsp;&nbsp;Invoice Email&nbsp;<input type="text" id="txttobeinvoicedmail" style="width:40%;" name="txttobeinvoicedmail" value='<s:property value="txttobeinvoicedmail"/>'></td>
  </tr>       
   <tr>  
      <td  width="5%" align="right">Description</td>      
      <td colspan="8"><input type="text" id="txtdesc" name="txtdesc" style="width:99.5%;" value='<s:property value="txtdesc"/>'></td>
   </tr> 
   <tr>  
      <td width="5%" align="right">Ext.comments</td>          
      <td colspan="4"><input type="text" id="txtintremarks" name="txtintremarks" style="width:98%;" value='<s:property value="txtintremarks"/>'></td>
      <td width="5%" align="right">Int.comments</td>      
      <td colspan="4"><input type="text" id="txtextremarks" name="txtextremarks" style="width:98%;" value='<s:property value="txtextremarks"/>'></td>
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
 <fieldset><legend>Contract Details</legend>  
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
 <fieldset><legend>Terms</legend>        
 <input type="button" id="btntermsload" class="myButton" onclick="funloadterms();" value="Load" > 
<div id="termsdiv">
  <jsp:include page="termDetails.jsp"></jsp:include></div>          
</fieldset> </td>
</tr>
</table>
<table width="100%" id="clconfirmlbl">  
<tr>   
<td>
 <fieldset><legend>Client Confirmation</legend>  
 <table><tr><td  width="45%" align="left">Type</td><td><select id="cmbcctype" name="cmbcctype">   
     <option value="">--Select--</option>  
     <option value="1">Open</option>   
     <option value="2">QTY based</option>
     <option value="3">Period</option>   
     <option value="4">QTY + Period based</option></select>  
     <input type="hidden" id="hidcmbcctype" name="hidcmbcctype" value='<s:property value="hidcmbcctype"/>'></td></tr></table>      
<div id="clcondiv">
  <jsp:include page="clientConfirmGrid.jsp"></jsp:include></div>       
</fieldset> </td>
</tr>
</table>
<table width="100%">     
<tr>
<td>
<input type="hidden" id="hidcnttrno" name="hidcnttrno" value='<s:property value="hidcnttrno"/>' />         
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" name="enqdtype" id="enqdtype" value='<s:property value="enqdtype"/>' />
<input type="hidden" id="enqgridlenght" name="enqgridlenght" />
<input type="hidden" id="siteGridlength" name="siteGridlength" />  
<input type="hidden" id="thirdgridlength" name="thirdgridlength" /> 
<input type="hidden" name="gridval" id="gridval" value='<s:property value="gridval"/>' />
<input type="hidden" name="forradiochk" id="forradiochk" value='<s:property value="forradiochk"/>' />  
<input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
<input type="hidden" name="sourceid" id="sourceid" value='<s:property value="sourceid"/>'/>
<input type="hidden" name="cpersonid" id="cpersonid" value='<s:property value="cpersonid"/>'/>
<input type="hidden" name="fromdatesval" id="fromdatesval" value='<s:property value="fromdatesval"/>' />  
<input type="hidden" name="todateval" id="todateval" value='<s:property value="todateval"/>' /> 
<input type="hidden" id="sertypeids" name="sertypeids"  value='<s:property value="sertypeids"/>'/> 
<input type="hidden" id="enqstatus" name="enqstatus" value='<s:property value="enqstatus"/>' />
<input type="hidden" id="hidpreview" name="hidpreview"  value='<s:property value="hidpreview"/>'/>
<input type="hidden" id="netamount" name="netamount"  value='<s:property value="netamount"/>'/>  
<input type="hidden" id="hidsurvey" name="hidsurvey"  value='<s:property value="hidsurvey"/>'/>
<input type="hidden" id="hidcmbenqbtype" name="hidcmbenqbtype"  value='<s:property value="hidcmbenqbtype"/>'/>
<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 

 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
 <input type="hidden" id="hidenqedit" name="hidenqedit"  value='<s:property value="hidenqedit"/>'/>  
 <input type="hidden" id="hidcmbsertype" name="hidcmbsertype"  value='<s:property value="hidcmbsertype"/>'/> 
 <input type="hidden" id="multilineconfig" name="multilineconfig"  value='<s:property value="multilineconfig"/>'/>  
 <input type="hidden" id="multioptionprintconfig" name="multioptionprintconfig"  value='<s:property value="multioptionprintconfig"/>'/>  
 <input type="hidden" id="termsgridlength" name="termsgridlength"  value='<s:property value="termsgridlength"/>'/>  
</td>
</tr>
</table>
</div>
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
<div id="clientsearch">    
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
    <div id="closetquesinfowindow">
   <div ></div>
   </div>
   <div id="siteinfowindow">   
   <div ></div>
   </div>
      <div id="otherdetailsinfowindow">
   <div ></div>
   </div>
    <div id="specinfowindow"> 
   <div ></div>
   </div>
   <div id="contactinfowindow">
			<div></div>
		</div>
    <div id="printWindow">
	<div></div><div></div></div>
</div>  

</body>
</html>