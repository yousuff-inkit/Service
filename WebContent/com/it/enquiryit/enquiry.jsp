<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
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

	.hidden-scrollbar {
	  overflow: auto;
	  height: 530px;
	}
</style>
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String enqdocno =request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").toString();

String vocno =request.getParameter("vocno")==null?"0":request.getParameter("vocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();


String docno= request.getParameter("docno")==null?"0":request.getParameter("docno").toString();

String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String contrmode=request.getParameter("contrmode")==null?"0":request.getParameter("contrmode").toString();
String mail=request.getParameter("mail")==null?"0":request.getParameter("mail").toString();
String mob=request.getParameter("mob")==null?"0":request.getParameter("mob").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String remarks=request.getParameter("remarks")==null?"0":request.getParameter("remarks").toString();
String telno=request.getParameter("telno")==null?"0":request.getParameter("telno").toString();
String source=request.getParameter("source")==null?"0":request.getParameter("source").toString();
String sourceid=request.getParameter("sourceid")==null?"0":request.getParameter("sourceid").toString();
String cperson=request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
String cpersonid=request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String sal_name=request.getParameter("sal_name")==null?"0":request.getParameter("sal_name").toString();
String sal_id=request.getParameter("sal_id")==null?"0":request.getParameter("sal_id").toString();
String sjobtype=request.getParameter("sjobtype")==null?"0":request.getParameter("sjobtype").toString();
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
%>
<script type="text/javascript">
var modes='<%=modes%>';
var masterdoc='<%=docno%>';
var enqdocno='<%=enqdocno%>';
var brhid='<%=brhid%>';
 $(document).ready(function () {
	 Setenqstatus();
   	 $("#EnquiryDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 
     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientsearch1').jqxWindow('close');
     $('#salesManDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#salesManDetailsWindow').jqxWindow('close');
     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
     $('#sourcesearchwndow').jqxWindow('close');
     $('#cpinfowindow').jqxWindow({ width: '35%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#cpinfowindow').jqxWindow('close');
     $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#areainfowindow').jqxWindow('close');
 	 $('#surveytypewindow').jqxWindow({ width: '35%', height: '45%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 300, y: 87 }, keyboardCloseKey: 27});
	 $('#surveytypewindow').jqxWindow('close'); 
	 $('#serTypeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Service Type Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#serTypeDetailsWindow').jqxWindow('close');
	 $('#industryDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Industry Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#industryDetailsWindow').jqxWindow('close');
   

	$('#specdetinfowindow').jqxWindow({ width: '40%', height: '68%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Specification Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#specdetinfowindow').jqxWindow('close');
		  
	$('#areainfowindow2').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#areainfowindow2').jqxWindow('close');
		    		  
	$('#frequencyinfowindow').jqxWindow({ width: '25%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Frequency Search' , position: { x: 250, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#frequencyinfowindow').jqxWindow('close'); 
	 
	
	 $('#cmbclient').dblclick(function(){
	  	       	
    	/* $('#closetquesinfowindow').jqxWindow({ width: '100%', height: '100%',  maxHeight: '100%' ,maxWidth: '100%' ,title: 'Assign Team' , position: { x: 0, y: 0 }, keyboardCloseKey: 27});
    	$('#closetquesinfowindow').jqxWindow('close');
      	 */ 	
    	
    	
    	$('#clientsearch1').jqxWindow('open');
	   
	       clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1')); 
       });
    
    $('#txtsalesman').dblclick(function(){
  	  salesmanSearchContent('salesManDetailsSearch.jsp'); 
   });
    $('#cmbsertype').dblclick(function(){
    	  var id=1;
    	  sertypeSearchContent('sertypeSearchGridNew.jsp?id='+id); 
     });
    
    $('#cmbenqbtype').dblclick(function(){
  	  var id=1;
  	  industrySearchContent('industrySearchGrid.jsp?id='+id); 
   });
    
    $('#txtsource').dblclick(function(){
    	$('#sourcesearchwndow').jqxWindow('open');
		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));  
   });
    
    $('#txtcontact').dblclick(function(){
    	
    	var clientid=document.getElementById("cmbclient").value;
		var custid=$('#custid').val();
		if((clientid=="") && !(parseInt(custid)==1)){
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
		}
    	if(!(parseInt(custid)==1)){
    		$('#cpinfowindow').jqxWindow('open');
        	cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid, $('#cpinfowindow'));
    	}
    	  
   });
    
    if(document.getElementById("txtradio").value==1)
    	{
    	//document.getElementById("r2").checked = true;
    
		$("#cmbclient").hide();
		$("#btnnewclient").hide();
    	}
  
   if(document.getElementById("txtradio").value=="")
	   {
	
	   $("#cmbclient").hide();
		$("#btnnewclient").hide();
	   }
 		/* $("#r1").click(function() {
 			
			document.getElementById("r2").checked = false;
			
			$('#cmbclient').attr('readonly', false );
			$('#txtclientname').attr('readonly', false );
			$('#txtaddress').attr('readonly', false );
			$('#txtmobile').attr('readonly', false );
			$('#txtemail').attr('readonly', false );
			$('#txtRemarks').attr('readonly', false );
		
			 document.getElementById("errormsg").innerText=""; 
			 document.getElementById("txtradio").value="1";
			 
			$("#btnnewclient").hide();
			$("#cmbclient").hide();
 			
 			
		});
		$("#r2").click(function() { */
			
		//	document.getElementById("r1").checked = false;
		    $('#cmbenqbtype').attr('readonly', true );
			$('#cmbsertype').attr('readonly', true );
			$('#cmbclient').attr('readonly', true );
			$('#txtsalesman').attr('readonly', true );
			$('#txtclientname').attr('readonly', true );
			$('#txtaddress').attr('readonly', true );
			$('#txtmobile').attr('readonly', true );
			$('#txtemail').attr('readonly', true );
			$('#txtRemarks').attr('readonly', false );
			$("#cmbclient").show();
			$('#txtcontact').attr('placeholder', 'Press F3 to Search');
			$('#txtcontact').attr('readonly', true );
		//	$("#jqxEnquiry").jqxGrid({ disabled: false});
			 document.getElementById("txtradio").value="2";
			// $('#hidradio').val('AMC');
			   document.getElementById("errormsg").innerText="";
			$("#btnnewclient").show();
			
	//	}); 
			 $('#btnques').click(function(){
				 var qcheck=document.getElementById("cmbques").value;
				 var docno=document.getElementById("masterdoc_no").value; 
				 var customer=document.getElementById("txtclientname").value;
				 var cusid=document.getElementById("docno").value; 
  				 if(qcheck=='1'){
					 window.open("k_questype.jsp?docno="+docno+"&qcheck="+qcheck+"&customer="+customer+"&cusid="+cusid,null,"height=500,width=1000,status=yes,toolbar=no,left=350,top=100,enubar=no,location=no"); 
				 }
				 else if(qcheck=='2'){
					 window.open("c_questype.jsp?docno="+docno+"&qcheck="+qcheck+"&customer="+customer+"&cusid="+cusid,null,"height=500,width=1000,status=yes,toolbar=no,left=350,top=100,enubar=no,location=no");
				 }
		 });
			
	});
 
	function specdetSearchContent(url) {
	    $('#specdetinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#specdetinfowindow').jqxWindow('setContent', data);
		$('#specdetinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	function areaSearchContent2(url) {
	    $('#areainfowindow2').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#areainfowindow2').jqxWindow('setContent', data);
		$('#areainfowindow2').jqxWindow('bringToFront');
	}); 
	}
		
	function frequencySearchContent(url) {
	    $('#frequencyinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#frequencyinfowindow').jqxWindow('setContent', data);
		$('#frequencyinfowindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function getspec(){
	         specdetSearchContent('specificationsDetailsSearch.jsp');  
	 }
	 
	 function getareas2(){
	         areaSearchContent2('areaDetailsSearch.jsp');
	 }
	 
	 function getfrequency(){
	         frequencySearchContent('frequency.jsp');
	 } 
	 
 function sertypeSearchContent(url) {
	 $('#serTypeDetailsWindow').jqxWindow('open');
  		 $.get(url).done(function (data) { 			 
  		$('#serTypeDetailsWindow').jqxWindow('setContent', data);
  		$('#serTypeDetailsWindow').jqxWindow('bringToFront');
  
  	      }); 
  	} 
 function getservicetype(event){
     var x= event.keyCode;
     var id=1;
     if(x==114){
    	 sertypeSearchContent('sertypeSearchGridNew.jsp?id='+id);
     }
     else{}
     }
 
 function industrySearchContent(url) {
	 $('#industryDetailsWindow').jqxWindow('open');
  		 $.get(url).done(function (data) { 			 
  		$('#industryDetailsWindow').jqxWindow('setContent', data);
  		$('#industryDetailsWindow').jqxWindow('bringToFront');
  
  	      }); 
  	} 
 function getindustry(event){
     var x= event.keyCode;
     var id=1;
     if(x==114){
    	 sertypeSearchContent('industrySearchGrid.jsp?id='+id);
     }
     else{}
     }
 
 function cquesContent(url) {
 	 $.get(url).done(function (data) {
	$('#closetquesinfowindow').jqxWindow('setContent', data);

               	}); 
     	}
 function getcontact(event){
	  	
		var clientid=document.getElementById("cmbclient").value;
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
		//$('#frmEnquiryit')[0].reset(); 
	}
	function funReadOnly(){
		$('#btnques').attr('disabled', true);
		$('#frmEnquiryit input').prop('readonly', true );
		$('#frmEnquiryit textarea').attr('readonly', true );
		$('#frmEnquiryit select').attr('disabled', true);
		//$('#c1').attr('disabled', true);
		$('#c2').attr('disabled', true);
		$('#btnnewclient').attr('disabled', true);
		 $("#siteGrid").jqxGrid({ disabled: true});
	//	$('#r1').attr('disabled', true);
	//	$('#r2').attr('disabled', true);
		$('#EnquiryDate').jqxDateTimeInput({ disabled: true});
	   // $("#jqxEnquiry").jqxGrid({ disabled: true});
		$("#jqxJobDetails").jqxGrid({ disabled: true});
	    if(modes=="view")
		{
		
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		Setviewmode(enqdocno,brhid);
		 <%--  $('#docno').attr('disabled', false);
	 		 $('#masterdoc_no').attr('disabled', false);
	 		 $('#mode').attr('disabled', false);
	 		 $('#EnquiryDate').jqxDateTimeInput({ disabled: false}); 
		
		document.getElementById("masterdoc_no").value=masterdoc;
		document.getElementById("mode").value=modes;
		
		  document.getElementById("docno").value= '<%=vocno%>';
		  $('#EnquiryDate').jqxDateTimeInput('val','<%=date%>');
		  document.getElementById("txtaddress").value='<%=address%>'; 
          
          document.getElementById("cmbclient").value='<%=cldocno%>';
                   
          document.getElementById("txtclientname").value='<%=client%>';
          document.getElementById("hidradio").value='<%=contrmode%>';
          document.getElementById("txtemail").value='<%=mail%>';
          document.getElementById("txtmobile").value='<%=mob%>';
          document.getElementById("txtRemarks").value='<%=remarks%>';
          document.getElementById("txttelno").value='<%=telno%>';
          document.getElementById("txtsource").value='<%=source%>';
          document.getElementById("sourceid").value='<%=sourceid%>';
          document.getElementById("txtcontact").value='<%=cperson%>';
          document.getElementById("cpersonid").value='<%=cpersonid%>';
          document.getElementById("cmbprocess").value='<%=sjobtype%>';
          
          var rdo=document.getElementById("hidradio").value;
          var sjobtype='<%=sjobtype%>';
         
  		if(rdo=='AMC'){
  			document.getElementById("c1").checked=true;
  			
  		}
  		
  		if(rdo=='SJOB'){
  			document.getElementById("c2").checked=true;
  			if(sjobtype>0){
     			 document.getElementById("hidcmbprocess").value=sjobtype;
     			}
  		}
          
          document.getElementById("gridval").value=1;		
     
      	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
      	
          document.getElementById("frmEnquiryit").submit();
		// $("#activityDetailsDiv").load("activityDetailsGrid.jsp?trno="+docno);
		
		  $('#masterdoc_no').attr('disabled', false);
		   $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false); --%>
		   
		}

	}
	
	function funRemoveReadOnly(){
		getCurrencyIds();
		//$('#btnques').attr('disabled', false);
		$('#frmEnquiryit input').prop('readonly', false );
		
		$('#frmEnquiryit textarea').attr('readonly', false );
		$('#frmEnquiryit select').attr('disabled', false);
		//$('#c1').attr('disabled', false);
		$('#c2').attr('disabled', false);
		$('#btnnewclient').attr('disabled', false);
		$('#txtsource').attr('readonly', false);
		document.getElementById("txtsource").disabled=false;
		
		$('#txtmobile').attr('readonly', false);
		$('#txtemail').attr('readonly', false);
		
	//	$('#r1').attr('disabled', false);
	//	$('#r2').attr('disabled', false);
	 	$("#siteGrid").jqxGrid({ disabled: false});
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		$('#cmbprocess').attr('disabled', false);
		// $("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		
		$("#jqxJobDetails").jqxGrid({ disabled: false});
		
		
		if ($("#mode").val() == "A") {
			$("#jqxJobDetails").jqxGrid('clear');
			$("#jqxJobDetails").jqxGrid('addrow', null, {});
			// $("#btnques").attr('disabled', true );           
		//	$('#hidradio').val('AMC');
			//document.getElementById("c2").checked=true;
			//getsjobtype();
			 $('#EnquiryDate').val(new Date());
		    // $("#jqxEnquiry").jqxGrid('clear');
		   // $("#jqxEnquiry").jqxGrid('addrow', null, {});
		    $("#siteGrid").jqxGrid('clear');
			$("#siteGrid").jqxGrid('addrow', null, {});
		   }
		
		if ($("#mode").val() == "E") {
			document.getElementById("txtsource").disabled=false;
			//$('#txtsource select').attr('disabled', true);
			// $("#jqxEnquiry").jqxGrid('addrow', null, {});
			/* if(document.getElementById("txtradio").value==1)
				{
					
					$('#r2').attr('disabled', true);	
				}
				else
					{
					$('#r1').attr('disabled', true);
					} */
			
		}
	
		if(modes=="view")
		{
			document.getElementById("txtsource").disabled=true;
		}
		else{
			$('#txtclientname').attr('readonly', true );
		}
		setJobDiv();
	}
	function getareas(rowBoundIndex){
    	 
  	  $('#areainfowindow').jqxWindow('open');
  
     // $('#accountWindow').jqxWindow('focus');
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
 	
 	  function refsearchContent(url) {
    
       $.get(url).done(function (data) {

     $('#surveytypewindow').jqxWindow('setContent', data);

 	}); 
 	}
	function Setviewmode(enqdocno,brhid){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	 items=items.split('###');
			
			 	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
			 	document.getElementById("txttelno").value=items[0];
			 	 document.getElementById("masterdoc_no").value=items[1];
	              document.getElementById("docno").value=items[2];
	             
	      	       $('#EnquiryDate').val(items[3]) ;
			       document.getElementById("txtRemarks").value=items[4];
			       var chkcldoc=items[5];
			       
			     // 
			       
		              if(parseInt(chkcldoc)==0){
		            	  document.getElementById("custid").checked=true;
		            	  document.getElementById("custid").value=1;
		                  $('#cld').hide();
		                  //alert("chkcldoc=="+chkcldoc);
		              	//$('#txtclientname').prop('readonly', false);
		            	//$('#txtmobile').prop('readonly', false);
		            	//$('#txttelno').prop('readonly', false);
		            	//$('#txtemail').prop('readonly', false);
		                     document.getElementById('txtclientname').readOnly =false;
					  		 document.getElementById('txtmobile').readOnly =false;
					  		 document.getElementById('txttelno').readOnly =false;
					  		 document.getElementById('txtemail').readOnly =false;
					  		 document.getElementById('txtcontact').removeAttribute('placeholder');
		              }
		              if(parseInt(chkcldoc)>0){
		            	  document.getElementById("custid").checked=false;
		            	  document.getElementById("custid").value=0;
		            	  $('#cld').show();
		            	  document.getElementById("txtcontact").setAttribute("placeholder","Press F3 To Search");
		            	  document.getElementById('txtclientname').readOnly =true;
					  		 document.getElementById('txtmobile').readOnly =true;
					  		 document.getElementById('txttelno').readOnly =true;
					  		 document.getElementById('txtemail').readOnly =true;
		              }
			       document.getElementById("cmbclient").value=items[5];
		              document.getElementById("txtclientname").value=items[6];
			           document.getElementById("txtaddress").value=items[7]; 
			           document.getElementById("txtmobile").value=items[8];
			           document.getElementById("txtemail").value=items[9];
			           var cldocnval=items[10];
			           document.getElementById("sourceid").value=items[11];
			           document.getElementById("txtsource").value=items[12];
			              document.getElementById("txtcontact").value=items[13];
			              document.getElementById("cpersonid").value=items[14];
			              document.getElementById("hidradio").value=items[15];
			              
			              var rdo=document.getElementById("hidradio").value;
			              var sjobtype=items[16];
			              document.getElementById("hidsurvey").value=items[17];
			              document.getElementById("txtsalesmandocno").value=items[18];
			              document.getElementById("txtsalesman").value=items[19];
			              
			              document.getElementById("hidcmbenqbtype").value=items[20];
			              document.getElementById("cmbenqbtype").value=items[21];
			              document.getElementById("hidcmbsertype").value=items[22];
			              document.getElementById("cmbsertype").value=items[23];
			      	/* 	if(rdo=='AMC'){
			      			document.getElementById("c1").checked=true;
			      			
			      		} */
			      		if(rdo=='SJOB'){
			      			document.getElementById("c2").checked=true;
			      			if(sjobtype>0){
			         			 document.getElementById("hidcmbprocess").value=sjobtype;
			         			}
			      		}
			      
			        	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
			     	
			        	
			        	
			      	  var docVal1 = document.getElementById("masterdoc_no").value;
			      	  
			          	if(docVal1>0)
			          		{
			          		Setenqstatus();
			    		 var indexVal2 = document.getElementById("masterdoc_no").value;
			            // $("#enqdiv").load("enquiryDetails.jsp?enqrdocno="+indexVal2);
			             $("#sitediv").load("siteGrid.jsp?sitedocno="+indexVal2);
			             $("#jobDetailsDiv").load('jobDetailsGrid.jsp?enqdocno='+indexVal2);
			          		}
			         //document.getElementById("frmEnquiryit").submit();
			          	if(document.getElementById("hidenqedit").value=="1"){
			    			//alert("in");
			    		    $('#btnEdit').attr('disabled', true );
			    	  } else {
			    		    $('#btnEdit').attr('disabled', false );
			    	  } 
			 	 
				}
		       else
			  {}
	     }
	      x.open("GET","setViewMode.jsp?masterdoc="+enqdocno+"&brhid="+brhid,true);
	     x.send();
	    
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
	   
	 function getclinfo(event){
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#clientsearch1').jqxWindow('open');
    	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
    	 else{
    		 }
     } 
	       function clientSearchContent(url) {
                 
	                 $.get(url).done(function (data) {
        
		           $('#clientsearch1').jqxWindow('setContent', data);

          	}); 
	           	} 
	       
	       
	function funNotify(){	
		//$('#frmEnquiryit').validate();
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		
		var cmbtype=document.getElementById("cmbtype").value;
		if(cmbtype=="")
			{
			document.getElementById("errormsg").innerText=" Select Type ";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}
		var chkval=$('#custid').val();
		 if(parseInt(chkval)==1){
		
		
       var valid4=document.getElementById("txtmobile").value;
		
		if(valid4=="")
			{
			document.getElementById("errormsg").innerText=" Enter Mobile";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}	
		
		var valid3=document.getElementById("txtemail").value;
		
		if(valid3=="")
			{
			document.getElementById("errormsg").innerText=" Enter Email";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}	 
		 }
		var valid2=document.getElementById("txtclientname").value;
		
		if(valid2=="")
			{
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
			}
		else{
			 document.getElementById("errormsg").innerText="";
		}
		
		
		var fromval=document.getElementById("fromdatesval").value;
		if(parseInt(fromval)==1)
			{
			
			document.getElementById("errormsg").innerText="From Date Less Than Current Date";
			return 0;
			
			}
		var toval=document.getElementById("todateval").value;
		if(parseInt(toval)==1)
			{
			document.getElementById("errormsg").innerText="To Date Less Than From Date "; 
			return 0;
			
			}
		
		
	/* 	 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		   for(var i=0 ; i < rows.length ; i++){
		    if(parseInt(rows[i].brdid)>0)
  		  {
		        if(rows[i].hidfromdate==""||rows[i].hidfromdate=="0.00"||typeof(rows[i].hidfromdate)=="undefined"||typeof(rows[i].hidfromdate)=="NaN")
  		
				{
				document.getElementById("errormsg").innerText="Enter From Date";  
		    	return 0;
				}
	 	        
	 	       if(rows[i].hidtodate==""||rows[i].hidfromdate=="0.00"||typeof(rows[i].hidtodate)=="undefined"||typeof(rows[i].hidtodate)=="NaN")
				{
				document.getElementById("errormsg").innerText="Enter To Date";  
		    	return 0;
				}
  	       	} 
		   } */
		      
/* 	//site grid
	
		   var rowsite = $("#siteGrid").jqxGrid('getrows');
		
		        if(rowsite[0].site==""||rowsite[0].site=="0"||typeof(rowsite[0].site)=="undefined"||typeof(rowsite[0].site)=="NaN")
  		
				{
				document.getElementById("errormsg").innerText="Enter Site Details";  
		    	return 0;
				} */
	
	/* 	 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		    $('#enqgridlenght').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		    newTextBox = $(document.createElement("input"))  
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)
		       .attr("hidden", "true"); 
		   newTextBox.val(rows[i].descritpion+" :: "+rows[i].qty+" :: "+rows[i].remarks+" :: ");
		   newTextBox.appendTo('form');
		   }  */  
		   
		   
		   var rowssitegrid = $("#siteGrid").jqxGrid('getrows');
		    $('#siteGridlength').val(rowssitegrid.length);
		  
		   for(var i=0 ; i < rowssitegrid.length ; i++){
			  // alert("rowssitegrid[i].site=="+rowssitegrid[i].site);
			  
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "sitetest"+i)
		       .attr("name", "sitetest"+i)
		       .attr("hidden", "true"); 
		    if(rowssitegrid[i].site!="")
			{
		   newTextBox.val(rowssitegrid[i].site+" :: "+rowssitegrid[i].remarks+" :: "+rowssitegrid[i].areaid+" :: "+rowssitegrid[i].surid+" :: ");
			}
		   newTextBox.appendTo('form');
				   
		   }   
		   
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
						
				newTextBox.val(rows[i].serviceid+" :: "+rows[i].comodityid+" :: "+rows[i].tradeid+" :: "+rows[i].areaid+" :: "+rows[i].qty+" :: "+rows[i].rate+" :: "+rows[i].expyrs+" :: "+rows[i].refid+" :: "+rows[i].description+" :: "+rows[i].startdate+" :: "+rows[i].enddate+":: "+rows[i].frequencyid+"");
				newTextBox.appendTo('form');
			 }
		}
			 $('#jobdetgridlenth').val(length);
		
		return 1;
	} 

	function funChkButton() {
		
		//frmEnquiryit.submit();
	}

	function funSearchLoad(){
		 changeContent('enqMastersearch.jsp'); 
	}
	  $(function(){
        $('#frmEnquiryit').validate({
                rules: { 
                txtclientname:{"required":true},
                //txtmobile:{"required":true},
               // txttelno:{number:true,maxlength:15},
              //  txtemail:{"required":true},
              //  txtaddress: {maxlength:200},
                txtRemarks:{maxlength:1000}
                 },
                 messages: {
                 txtRemarks:{maxlength:" Max 1000 chars"},
                 txtclientname:{required:" *required"},
                // txtmobile:{required:" *"},
                 //txtemail:{required:" *"}
               //  txtaddress: {maxlength:" Max 200 chars"},
               //  txtmobile:{number:" Invalid MOB NO",maxlength:" Max 12 chars",minlength:" Minimum 12 chars" },
               //  txttelno:{number:" Invalid Tel No",maxlength:" Max 15 chars" },
              //   txtemail:" *Enter Valid Email",
              
                 }
        });
	  });  
    
    
		
	function funFocus(){
		 
	   /* 	$('#EnquiryDate').jqxDateTimeInput('focus');  */
	   
	   
/* 	   
		document.getElementById("r1").checked=1; */
	//	document.getElementById("r1").focus();
	   
	   
	}
	function reqdata()
	{
 		 /* if((document.getElementById("r1").checked=="")&&(document.getElementById("r2").checked==""))
 				 
         	
    		{ 
     	  
     	       document.getElementById("errormsg").innerText=" Select One Option";
     	      $('#frmEnquiryit input').attr('readonly', true );
     			$('#frmEnquiryit textarea').attr('readonly', true );
     			
     		
     	        return false;			            	              		          	  
   		}  
		 else 
	         	
 		{ 
			 document.getElementById("errormsg").innerText="";	
			 
			 $('#frmEnquiryit input').attr('readonly', false );
				$('#frmEnquiryit textarea').attr('readonly', false );
		}     */
}
	
	
	function chkChange()
    {
		/* if($('#txtradio').val()!="")
			{
  	  if(document.getElementById("txtradio").value==2)
  		  {
  		document.getElementById("r2").checked = true;
  		document.getElementById("r1").checked = false;  */
  	 	$("#cmbclient").show();
  		$("#btnnewclient").show(); 
  	    $('#frmEnquiryit input').attr('readonly', true );
		$('#frmEnquiryit textarea').attr('readonly', true );
        $('#docno').attr('readonly', true);
		
		/* 
		
  		  }
  	  else 
  		  {
  	
  		  document.getElementById("r1").checked = true;
  		 document.getElementById("r2").checked = false;
  		  $('#frmEnquiryit input').attr('readonly', true );
			$('#frmEnquiryit textarea').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			
  		  }
			}
		else{}
 
    
	     */
    } 
	
	
	 function disfields()
	 {
		 $('#docno').attr('readonly', true);
		// $('#cmbclient').attr('readonly', true );
		 var chkval=0;
		 chkval=$('#custid').val();
		// alert("chkval=="+chkval);
		 if(parseInt(chkval)==1){
			 
		 }
		 else{
			  $('#cmbenqbtype').attr('readonly', true );
			 $('#cmbsertype').attr('readonly', true );
				$('#txtclientname').attr('readonly', true );
		    	$('#txtaddress').attr('readonly', true );
		    	$('#txtmobile').attr('readonly', true );
		    	$('#txtemail').attr('readonly', true );
		    	$('#txttelno').attr('readonly', true );
		    	$('#txtcontact').attr('readonly', true );
		    	$('#txtsalesman').attr('readonly', true );
		    	if ($("#mode").val() == "view") {
			    	$('#txtclientname').attr('readonly', true );
			    	$('#txtaddress').attr('readonly', true );
			    	$('#txtmobile').attr('readonly', true );
			    	$('#txtemail').attr('readonly', true );
			    	$('#txtRemarks').attr('readonly', true ); 
			    	$('#txttelno').attr('readonly', true ); 
			    	
					} 
		 }
		/*  if( document.getElementById("r2").checked == true)
			 { */
			
		    	
		//	 }
			
	 }
	function setValues() {
		   
	  /*  if(document.getElementById("hidcmbques").value==1){
			  document.getElementById("cmbques").value=1; 
		   }
		   else if(document.getElementById("hidcmbques").value==2){
			   document.getElementById("cmbques").value=2; 
		   } */
		   var typetemp=$('#hidcmbtype').val();
		  // alert("typetemp=="+typetemp);
			document.getElementById("cmbtype").value=typetemp;
			setJobDiv();
			getCurrencyIds();
		   var chkcldoc=document.getElementById("cmbclient").value;
           if(parseInt(chkcldoc)==0){
         	  document.getElementById("custid").checked=true;
               $('#cld').hide();
              
           }
           if(parseInt(chkcldoc)>0){
         	  document.getElementById("custid").checked=false;
         	  $('#cld').show();
           } 
		  document.getElementById("formdetail").value="Enquiry";
	   		document.getElementById("formdetailcode").value="ENQ"; 
		if($('#hidEnquiryDate').val()){
			$("#EnquiryDate").jqxDateTimeInput('val', $('#hidEnquiryDate').val());
		}
		var rdo=document.getElementById("hidradio").value;
		
		/* if(rdo=='AMC'){
			document.getElementById("c1").checked=true;
			
		} */
		/* if(rdo=='SJOB'){
			document.getElementById("c2").checked=true;
			
		} */
		if(document.getElementById("hidenqedit").value=="1"){
			//alert("in");
		    $('#btnEdit').attr('disabled', true );
	  } else {
		    $('#btnEdit').attr('disabled', false );
	  } 
  	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
      		Setenqstatus();
		 var indexVal2 = document.getElementById("masterdoc_no").value;
        // $("#enqdiv").load("enquiryDetails.jsp?enqrdocno="+indexVal2);
         $("#sitediv").load("siteGrid.jsp?sitedocno="+indexVal2);
         $("#jobDetailsDiv").load('jobDetailsGrid.jsp?enqdocno='+indexVal2);
      	}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
      	
      	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
         	 
     	chkChange();
	}

	
	
    
    function funPrintBtn(){
 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 	  
 	   var url=document.URL;

        var reurl=url.split("saveEnquiry");
   
        $("#docno").prop("disabled", false);                
        
  
var win= window.open(reurl[0]+"printEnqnew?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
     
win.focus();
 	   } 
 	  
 	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     }
	    	
 	}
    function getsjobtype() {
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
				$("select#cmbprocess").html(optionsbranch);
				
				 if ($('#hidcmbprocess').val()>0) {
						$('#cmbprocess').val($('#hidcmbprocess').val());
						} 
			} else {}
		}
		x.open("GET","getsjobtype.jsp?processtype="+$('#hidradio').val(), true);
		x.send();
	} 
    function jobChange()
    {
    	
    	if(document.getElementById("c2").checked==true)
    		
    		{
    		 document.getElementById("hidradio").value="SJOB";
    		//$('#cmbprocess').attr('disabled', false);
    		}
    }
 function Setenqstatus()
 {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				//alert("items"+items);   
				if(parseInt(items)>0)
					{
					 $("#btnEdit").attr('disabled', true );
					 $("#btnques").attr('disabled', true );
					 $("#btnDelete").attr('disabled', true );    
					}
				else
					{
					  $("#btnques").attr('disabled', false );
					}
				
			} else {
			}
		}
		x.open("GET", "getEnqStat.jsp?masterdoc="+$('#masterdoc_no').val(), true);
		x.send();
	}
     
/*  function getenqbuildtype(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				 items=items.split('####');
		           var buildidItems=items[0];
		           var buildtypeItems=items[1];
		           var optionscurr = '';
		           for ( var i = 0; i < buildtypeItems.length; i++) {
		        	   optionscurr[i] += '<option value="' + buildidItems[i] + '">' + buildtypeItems[i] + '</option>';
			           }
			            $("select#cmbenqbtype").html(optionscurr);
			}else {  
			}     
		}    
		x.open("GET", "getenqbuildtypes.jsp", true);
		x.send();
	}    */
 /* function getenqbuildtype(){ 
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	      items=items.split('####');
	           var docno=items[0].split(",");
	           var type=items[1].split(",");
	           var optionstype = '<option value="" selected>-- Select -- </option>';
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	         //  alert("industrytype=="+$('#hidcmbenqbtype').val());
	            $("select#cmbenqbtype").html(optionstype); 	
	            if($('#hidcmbenqbtype').val()!="")
				  {
				  $('#cmbenqbtype').val($('#hidcmbenqbtype').val());   
				  }
	            else{
	            	
	            }
	    }
	       }
	   x.open("GET","getenqbuildtypes.jsp?",true);
		x.send();
	        } */
 
 /* function getServiceType(){ 
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	      items=items.split('####');
	           var docno=items[0].split(",");
	           var type=items[1].split(",");
	           var optionstype = '<option value="" selected>-- Select -- </option>';
	           for ( var i = 0; i < type.length; i++) {
	        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
		        }
	            $("select#cmbsertype").html(optionstype); 
	          //  alert("sertype=="+$('#hidcmbsertype').val());
	            if($('#hidcmbsertype').val()!="")
				  {
				  $('#cmbsertype').val($('#hidcmbsertype').val());   
				  }
	    }
	       }
	   x.open("GET","getservicetypes.jsp?",true);
		x.send();
	        } */
 
 function setChange(){
	 var chkval=0;
	 chkval=$('#custid').val();
	 if(parseInt(chkval)==1){
		 $('#cld').hide();
		 //('#frmEnquiryit input').attr('readonly', false );
		 //document.getElementById('txtclientname').removeAttribute('readonly');
		 document.getElementById('txtclientname').readOnly =false;
		 document.getElementById('txtmobile').readOnly =false;
		 document.getElementById('txttelno').readOnly =false;
		 document.getElementById('txtemail').readOnly =false;
		 document.getElementById('txtcontact').removeAttribute('placeholder');
		 document.getElementById("cmbclient").value="0";
	 }
	 else{
		 $('#cld').show();
		 document.getElementById("txtcontact").setAttribute("placeholder","Press F3 To Search");
	 }
 }
	  	  function getCurrencyIds(){
			  var dates=document.getElementById("EnquiryDate").value;
			   var x=new XMLHttpRequest();
			   x.onreadystatechange=function(){
			   if (x.readyState==4 && x.status==200)
			    {
			      items= x.responseText;
			     
			      items=items.split('####');
			           var curidItems=items[0].split(",");
			           var curcodeItems=items[1].split(",");
			           var currateItems=items[2].split(",");
			           var multiItems=items[3].split(",");
			           var optionscurr = '';
			          
			          //  curidItems.split(",");
			           // curcodeItems.split(",");
			           // currateItems.split(",");
			            for ( var i = 0; i < curcodeItems.length; i++) {
			           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
			           }
			            $("select#cmbcurrency").html(optionscurr);
			           
			        
			            if($('#hidcmbcurrency').val()!="")
						  {
					    	  // alert("currency=="+$('#hidcmbcurr').val());
						   document.getElementById("cmbcurrency").value=$('#hidcmbcurrency').val();
						    
						  
						  }
			   /*        else
			      {
			           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			           $("select#cmbcurr").html(optionscurr);
			          
			        //  $('#currate').val(currateItems) ;
			          
			          funRoundRate(currateItems,"currate");
			      
			          $('#currate').attr('readonly', true);
			       
			      } */
			    }
			       }
			   x.open("GET","getCurrencyId.jsp?date="+dates,true);
				x.send();
			        
			      
			}
	  	  
		  	function setJobDiv(){
		  		var cmbtype=$("#cmbtype").val();
		  		if(cmbtype=='4'){
		  			$("#jobDiv").show();	
		  		}else{
		  			$("#jobDiv").hide();	
		
		  			if ($("#mode").val() == "A") {
						$("#jqxJobDetails").jqxGrid('clear');
						$("#jqxJobDetails").jqxGrid('addrow', null, {});
					}
				}
		  	}
</script>
</head>
<body onload="setValues();getCurrencyIds();" onmouseover="Setenqstatus()"; style="">     
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEnquiryit" action="saveEnquiryit" autocomplete="OFF">

<jsp:include page="../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<legend>Customer Enquiry</legend>          <!-- EnquiryDate, docno,cmbclientb,txtclientname,txtaddress -->
<table width="100%" >                        
  <tr>
    <td width="4.5%" align="right">Date</td>
    <td width="20%" >
    <table width="100%" >  
    <tr>
    <td width="10%"><div id='EnquiryDate' name='EnquiryDate' style="width: 10%;" value='<s:property value="EnquiryDate"/>'></div></td>
    <td>New Client<input type="checkbox" id="custid" name="custid" style="width: 10%;" onchange="setChange();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /></td>
    </tr>
    </table> 
    <input type="hidden" style="width: 5%;" id="hidEnquiryDate" name="hidEnquiryDate" value='<s:property value="hidEnquiryDate"/>'/>
    </td>
    <!--  <td width="32%" align="right">User Name</td> -->
    <%-- <td width="33%"><input type="text" id="enquserName" name="enquserName" tabindex="-1" value="<%=session.getAttribute("USERNAME")%>"/></td> --%>
 
   <%--  <td width="10%" align="right">User Name : <label ><font size="2PX"><%=session.getAttribute("USERNAME")%></font></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td> --%>
    <td width="4.5%">&nbsp;</td> 
    <td width="10%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
    <td align="right" width="3.5%">Doc No&nbsp; 
    <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
    <td width="10%">&nbsp;</td>
  </tr>
       
  <%--  <tr>
    <td align="right">&nbsp;</td>
    <td colspan="2"><input type="radio" id="r1" name="genaral" value='<s:property value="0"/>'  >General</td>
    <td colspan="2"><input type="radio" id="r2" name="client" value='<s:property value="1"/>' >Client</td>
  </tr>  --%>
       
  <tr>
    <td align="right" width="2%">Client</td>     
    <td width="10%" id="cld"><input type="text" id="cmbclient" name="cmbclient" placeholder="Press F3 To Search" style="width: 60%;" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" onfocus="disfields();"></td>
	<td colspan="3"><input type="text" id="txtclientname" name="txtclientname"  style="width: 60%;" value='<s:property value="txtclientname"/>' onfocus="reqdata();disfields();">
	
	<button type="button" id="btnnewclient"  class="myButton" onclick="text();">Create new Client</button></td>
     <td align="right"  width="10%">Currency
    <select id="cmbcurrency" name="cmbcurrency" style="width:50%;" value='<s:property value="cmbcurrency"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <%-- <td><input type="text" id="txtcurrency" name="txtcurrency" style="width:11%;" value='<s:property value="txtcurrency"/>'/></td> --%>
  
  </tr>
 

  <tr>
  <td width="7%" align="right">Contact person</td>
    <td width="20%"><input type="text" id="txtcontact" name="txtcontact" style="width: 40%;" value='<s:property value="txtcontact"/>' onKeyDown="getcontact(event);"></td>
  <td width="2%" align="right">Address</td> 
    <td><input type="text" id="txtaddress" name="txtaddress" style="width:90%;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();"></td>
    <td width="4%" align="right">Salesman</td>
   <td width="10%"><input type="text" id="txtsalesman" name="sal_name" style="width:90%;" placeholder="Press F3 To Search" value='<s:property value="sal_name"/>' onKeyDown="getsalinfo(event);" onfocus="disfields();">
   <input type="hidden" id="txtsalesmandocno" name="sal_id" value='<s:property value="sal_id"/>'></td>
		
    
  </tr>
   
 
  <tr>
    <td align="right" width="1%">MOB</td>
    <td  width="6%"><input type="text" id="txtmobile" name="txtmobile" style="width:40%;" value='<s:property value="txtmobile"/>' ></td>
   <td width="2%" align="right">Tel</td>     
    <td width="6%"><input type="text" id="txttelno" name="txttelno" style="width: 60%;" value='<s:property value="txttelno"/>' ></td>
   <td width="4%" align="right">Email</td>
    <td ><input type="text" id="txtemail" name="txtemail" style="width: 90%;" value='<s:property value="txtemail"/>' ></td>
  </tr>
  
  <tr>
   <!--  <td align="right" width="1%">Contract Type</td>
  <td width="6%"><input type="radio" id="c2" name="cnt" checked='true' value="SJOB" onchange="getsjobtype();" onClick="getsjobtype();jobChange();" >SJOB</td> -->
   <%--  <td align="right">Type</td>
	  <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:62%;" name="cmbprocess" onchange="funtxtenable(value);"  value='<s:property value="cmbprocess"/>'></select>
	  <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' /> 
	  </td> --%>
	  <%-- <td align="right">Questionnaire Type</td>
	  <td align="left"><select name="cmbques" id="cmbques" style="width:62%;" name="cmbques" value='<s:property value="cmbques"/>'>
	  <option value="1">Kitchen</option><option value="2">Closet</option></select>
	  <input type="hidden" name="hidcmbques" id="hidcmbques" value='<s:property value="hidcmbques"/>' /> 
	  </td> --%>
  <td width="2%" align="right">Source</td>  
  <td align="left" width="6%"><input type="text" id="txtsource" name="txtsource" style="width:52%;" readonly placeholder="Press F3 To Search" onKeyDown="getSource(event);" value='<s:property value="txtsource"/>'></td>
 
 <td width="4%" align="right">Industry</td>
        <td width="6%"><input type="text" id="cmbenqbtype" name="cmbenqbtype" style="width:90%;" placeholder="Press F3 To Search" value='<s:property value="cmbenqbtype"/>' onKeyDown="getindustry(event);">
   <input type="hidden" id="hidcmbenqbtype" name="hidcmbenqbtype" value='<s:property value="hidcmbenqbtype"/>'></td>
 <td width="2%" align="right">Type</td>
 <td width="6%"><select id="cmbtype" name="cmbtype" style="width:93%;" value='<s:property value="cmbtype"/>' onchange="setJobDiv();">
      <option value="1">Licensing</option><option value="2">Project</option><option value="3">AMS</option><option value="4">Staffing</option></select>
      <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
  </tr>

  <tr>
  <td align="right" width="1%">Remarks</td> 
    <td colspan="3">
    <input type="text" id="txtRemarks" name="txtRemarks" style="width:97%;" value='<s:property value="txtRemarks"/>'onfocus="reqdata();disfields();">
    </td>
  
    <td width="2%" align="right">Service Type</td> 
    <td width="7%"><input type="text" id="cmbsertype" name="cmbsertype" style="width:90%;" placeholder="Press F3 To Search" value='<s:property value="cmbsertype"/>' onKeyDown="getservicetype(event);">
   <input type="hidden" id="hidcmbsertype" name="hidcmbsertype" value='<s:property value="hidcmbsertype"/>'></td>
      
  
    <%-- <td><button type="button" id="btnques"  class="myButton" >Questionnaire</button></td> --%>
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
<td><fieldset style="background: #F6FFE1;display:none" id="jobDiv"><legend>Job Details</legend>
<div id="jobDetailsDiv"><jsp:include page="jobDetailsGrid.jsp"></jsp:include></div>
</fieldset></td>
</tr> 
</table>

</div>
<%-- <fieldset>
<div id="enqdiv">
<jsp:include page="enquiryDetails.jsp"></jsp:include></div>
</fieldset> --%>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />

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
<input type="hidden" id="jobdetgridlenth" name="jobdetgridlenth" value='<s:property value="jobdetgridlenth"/>'/>

<input type="hidden" id="hidradio" name="hidradio"  value='<s:property value="hidradio"/>'/>
<input type="hidden" id="hidsurvey" name="hidsurvey"  value='<s:property value="hidsurvey"/>'/>
<%-- <input type="hidden" id="hidcmbenqbtype" name="hidcmbenqbtype"  value='<s:property value="hidcmbenqbtype"/>'/> --%>
<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
  <input type="hidden" id="hidenqedit" name="hidenqedit"  value='<s:property value="hidenqedit"/>'/>  
 <%-- <input type="hidden" id="hidcmbsertype" name="hidcmbsertype"  value='<s:property value="hidcmbsertype"/>'/> --%> 

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
<div id="clientsearch1">
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
    <div id="surveytypewindow">
   <div ></div>
   </div>
    <div id="closetquesinfowindow">
   <div ></div>
   </div>
     <div id="serTypeDetailsWindow">
   <div ></div>
   </div>
    <div id="industryDetailsWindow">
   <div ></div>
   </div>
   
<div id="specdetinfowindow">
   <div></div>
</div>  
<div id="areainfowindow2">
   <div></div>
</div>
<div id="frequencyinfowindow">
   <div></div>
</div>

</div>  
</body>
</html>