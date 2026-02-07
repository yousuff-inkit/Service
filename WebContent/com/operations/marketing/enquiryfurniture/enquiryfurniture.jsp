<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includeso.jsp"></jsp:include> 
<style>
form label.error {
  color:red;
  font-weight:bold;
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
 	  $('#skipinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Skip Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 	$('#skipinfowindow').jqxWindow('close');
 	   $('#wasteinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Dump Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 	$('#wasteinfowindow').jqxWindow('close');
 	 	
 	$('#surveytypewindow').jqxWindow({ width: '35%', height: '45%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 300, y: 87 }, keyboardCloseKey: 27});
	$('#surveytypewindow').jqxWindow('close'); 
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
		//$('#frmEnquiryfurniture')[0].reset(); 
	}
	function funReadOnly(){
		$('#btnques').attr('disabled', true);
		$('#frmEnquiryfurniture input').prop('readonly', true );
		$('#frmEnquiryfurniture textarea').attr('readonly', true );
		$('#frmEnquiryfurniture select').attr('disabled', true);
		//$('#c1').attr('disabled', true);
		$('#c2').attr('disabled', true);
		$('#btnnewclient').attr('disabled', true);
		 $("#siteGrid").jqxGrid({ 'disabled': true});
	//	$('#r1').attr('disabled', true);
	//	$('#r2').attr('disabled', true);
		$('#EnquiryDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxEnquiry").jqxGrid({ disabled: true});
		
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
      	
          document.getElementById("frmEnquiryfurniture").submit();
		// $("#activityDetailsDiv").load("activityDetailsGrid.jsp?trno="+docno);
		
		  $('#masterdoc_no').attr('disabled', false);
		   $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false); --%>
		   
		}
	
	}
	function funRemoveReadOnly(){
		$('#btnques').attr('disabled', false);
		$('#frmEnquiryfurniture input').attr('readonly', false );
		
		$('#frmEnquiryfurniture textarea').attr('readonly', false );
		$('#frmEnquiryfurniture select').attr('disabled', false);
		//$('#c1').attr('disabled', false);
		$('#c2').attr('disabled', false);
		$('#btnnewclient').attr('disabled', false);
		$('#txtsource').attr('readonly', true);
	//	$('#r1').attr('disabled', false);
	//	$('#r2').attr('disabled', false);
	 $("#siteGrid").jqxGrid({ disabled: false});
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		$('#cmbprocess').attr('disabled', false);
		 $("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			 $("#btnques").attr('disabled', true );           
			$('#hidradio').val('AMC');
			document.getElementById("c2").checked=true;
			//getsjobtype();
			 $('#EnquiryDate').val(new Date());
		     $("#jqxEnquiry").jqxGrid('clear');
		    $("#jqxEnquiry").jqxGrid('addrow', null, {});
		    $("#siteGrid").jqxGrid('clear');
			$("#siteGrid").jqxGrid('addrow', null, {});
		   }
		
		if ($("#mode").val() == "E") {
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
	
		$('#txtsource').attr('readonly', true );
		$('#txtclientname').attr('readonly', true );
		
		
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
 
    // $('#accountWindow').jqxWindow('focus');
           wasteSearchContent('getwastetype.jsp?rowBoundIndex='+rowBoundIndex);
        	 }
 function wasteSearchContent(url) {
	      	 // alert(url);
	      	  	 $.get(url).done(function (data) {
	      	 		 //alert(data);
	      	 $('#wasteinfowindow').jqxWindow('setContent', data);

	      	                	}); 
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
			     	
			         document.getElementById("frmEnquiryfurniture").submit();
			 
			 	 
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
		
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		
			//var buildtype = document.getElementById("cmbenqbtype").value;
		
		/* if(buildtype==""){
			document.getElementById("errormsg").innerText=" Select Build type";
			return 0;
		 }
	else{
		 document.getElementById("errormsg").innerText="";
	} */
		
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
	
	 	 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		    $('#enqgridlenght').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		    newTextBox = $(document.createElement("input"))  
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)
		       .attr("hidden", "true"); 
		   newTextBox.val(rowssitegrid[i].site+" :: "+rowssitegrid[i].skipdoc+" :: "+rowssitegrid[i].nos+" :: "+rowssitegrid[i].wastedoc+" :: "+rowssitegrid[i].method+" :: "+rowssitegrid[i].servicemthd+" :: "+rowssitegrid[i].serviceschdle+" :: "+rowssitegrid[i].days+" :: ");
		   newTextBox.appendTo('form');
		   }    
		   
		   
		   var rowssitegrid = $("#siteGrid").jqxGrid('getrows');
		    $('#siteGridlength').val(rowssitegrid.length);
		  
		   for(var i=0 ; i < rowssitegrid.length ; i++){
			   if(rowssitegrid[i].site!="")
				{
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "sitetest"+i)
		       .attr("name", "sitetest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rowssitegrid[i].site+" :: "+rowssitegrid[i].remarks+" :: "+rowssitegrid[i].areaid+" :: "+rowssitegrid[i].surid+" :: ");
		
		   newTextBox.appendTo('form');
				}
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		//frmEnquiryfrn.submit();
	}

	function funSearchLoad(){
		 changeContent('enqMastersearch.jsp'); 
	}
    $(function(){
        $('#frmEnquiryfurniture').validate({
                rules: { 
                txtclientname:{"required":true},
                //txtmobile:{number:true,maxlength:12,minlength:12},
               // txttelno:{number:true,maxlength:15},
             //   txtemail:"",
              //  txtaddress: {maxlength:200},
                txtRemarks:{maxlength:200}
                 },
                 messages: {
                 txtRemarks: {maxlength:" Max 200 chars"},
                 txtclientname: {required:" *required"},
               //  txtaddress: {maxlength:" Max 200 chars"},
               //  txtmobile:{number:" Invalid MOB NO",maxlength:" Max 12 chars",minlength:" Minimum 12 chars" },
               //  txttelno:{number:" Invalid Tel No",maxlength:" Max 15 chars" },
              //   txtemail:" *Enter Valid Email",
              
                 }
        });});
    
		
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
     	      $('#frmEnquiryfurniture input').attr('readonly', true );
     			$('#frmEnquiryfurniture textarea').attr('readonly', true );
     			
     		
     	        return false;			            	              		          	  
   		}  
		 else 
	         	
 		{ 
			 document.getElementById("errormsg").innerText="";	
			 
			 $('#frmEnquiryfurniture input').attr('readonly', false );
				$('#frmEnquiryfurniture textarea').attr('readonly', false );
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
  	    $('#frmEnquiryfurniture input').attr('readonly', true );
		$('#frmEnquiryfurniture textarea').attr('readonly', true );
        $('#docno').attr('readonly', true);
		
		/* 
		
  		  }
  	  else 
  		  {
  	
  		  document.getElementById("r1").checked = true;
  		 document.getElementById("r2").checked = false;
  		  $('#frmEnquiryfurniture input').attr('readonly', true );
			$('#frmEnquiryfurniture textarea').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			
  		  }
			}
		else{}
 
    
	     */
    } 
	
	
	 function disfields()
	 {
		 $('#docno').attr('readonly', true);
		 $('#cmbclient').attr('readonly', true );
		 var chkval=0;
		 chkval=$('#custid').val();
		 if(parseInt(chkval)==1){
			 
		 }
		 else{
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
		   }  */
		
		  document.getElementById("formdetail").value="Enquiry";
	   		document.getElementById("formdetailcode").value="ENQ"; 
		if($('#hidEnquiryDate').val()){
			$("#EnquiryDate").jqxDateTimeInput('val', $('#hidEnquiryDate').val());
		}
		var rdo=document.getElementById("hidradio").value;
		
		/* if(rdo=='AMC'){
			document.getElementById("c1").checked=true;
			
		} */
		if(rdo=='SJOB'){
			document.getElementById("c2").checked=true;
			
		}
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
     	  
         $("#enqdiv").load("enquiryDetails.jsp?enqrdocno="+indexVal2);
         $("#sitediv").load("siteGrid.jsp?sitedocno="+indexVal2);
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
 function getenqbuildtype(){ 
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
	        }
 
 function getServiceType(){ 
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
	        }
 
 function setChange(){
	 var chkval=0;
	 chkval=$('#custid').val();
	 if(parseInt(chkval)==1){
		 $('#cmbclient').hide();
		 //('#frmEnquiryfurniture input').attr('readonly', false );
		 //document.getElementById('txtclientname').removeAttribute('readonly');
		 document.getElementById('txtclientname').readOnly =false;
		 document.getElementById('txtcontact').removeAttribute('placeholder');
		 document.getElementById("cmbclient").value="0";
	 }
	 else{
		 $('#cmbclient').show();
		 document.getElementById("txtcontact").setAttribute("placeholder","Press F3 To Search");
	 }
 }
 
</script>
</head>
<body onload="setValues();getenqbuildtype();getServiceType();" onmouseover="Setenqstatus();">     
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEnquiryfurniture" action="saveEnquiryfurniture" autocomplete="OFF">

<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<fieldset>
<legend>Customer Enquiry</legend>  
<table width="100%"  >                        
  <tr>
     <td width="11%" align="right">Date</td>
    <td colspan="2"><div id='EnquiryDate' name='EnquiryDate' value='<s:property value="EnquiryDate"/>'></div>
                     <input type="hidden" id="hidEnquiryDate" name="hidEnquiryDate" value='<s:property value="hidEnquiryDate"/>'/></td> 
      <td width="32%" hidden="true" align="right">User Name</td> 
    <%-- <td width="33%"><input type="text" id="enquserName" name="enquserName" tabindex="-1" value="<%=session.getAttribute("USERNAME")%>"/></td> --%>
   <td align="right" hidden="true" width="10%" id="customerlabel"><label class="branch">Client</label></td>
           <td align="left" hidden="true" width="5%">
           <input type="checkbox" id="custid" name="custid" onchange="setChange();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
           </td>
    <td width="36%" hidden="true" align="right">User Name : <label ><font size="2PX"><%=session.getAttribute("USERNAME")%></font></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      
     </td> 
    <td width="33%" >Doc No&nbsp;<input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' onfoucs="disfields();"/></td>
 </tr>
 <%--   <tr>
    <td align="right">&nbsp;</td>
    <td colspan="2"><input type="radio" id="r1" name="genaral" value='<s:property value="0"/>'  >General</td>
    <td colspan="2"><input type="radio" id="r2" name="client" value='<s:property value="1"/>' >Client</td>
  </tr>  --%>
       
  <tr>
    <td align="right">Client</td>     
    <td width="33%"><input type="text" id="cmbclient" name="cmbclient" placeholder="Press F3 To Search" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" onfocus="disfields();">
		<input type="text" id="txtclientname" name="txtclientname"  style="width: 70%;" value='<s:property value="txtclientname"/>' onfocus="reqdata();disfields();"></td>
    <td colspan="2" hidden="true"><button type="button" id="btnnewclient"  class="myButton" onclick="text();">Create new Client</button></td>  --> 
  </tr>
  <tr>
  <!--  <td width="10.8%" align="right">Contact person</td>
    <td><input type="text" id="txtcontact" name="txtcontact" style="width:25%;" value='<s:property value="txtcontact"/>' onKeyDown="getcontact(event);"></td>  -->
   
   
    <td align="right" >Source</td>
  <td align="left" ><input type="text" id="txtsource" name="txtsource" style="width:90%;" readonly placeholder="Press F3 To Search" onKeyDown="getSource(event);" value='<s:property value="txtsource"/>'></td>
 
   <td  align="right">Salesman</td>
   <td ><input type="text" id="txtsalesman" name="sal_name" style="width:90%;" placeholder="Press F3 To Search" value='<s:property value="sal_name"/>' onKeyDown="getsalinfo(event);" onfocus="disfields();">
   <input type="hidden" id="txtsalesmandocno" name="sal_id" value='<s:property value="sal_id"/>'></td>
	</tr>
	<tr>	
	<td align="right" >Description</td> 
    <td width="30%">
    <input type="text" id="txtdesc" name="txtdesc" style="width:90%;" value='<s:property value="txtdesc"/>'onfocus="reqdata();disfields();"></td>
		
		
    
  </tr>
   <tr>
   <!--   <td width="10.8%" align="right">Address</td>
    <td><input type="text" id="txtaddress" name="txtaddress" style="width:76.7%;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();"></td> -->
  </tr>
  </table>
<table  width="100%">
 <!--  <tr>
    <td align="right" width="10.8%">MOB</td>
    <td ><input type="text" id="txtmobile" name="txtmobile" style="width:60%;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();"></td>
        <td align="right" width="3%" >Tel</td>
    <td width="20%"> <input type="text" id="txttelno" name="txttelno" style="width: 60%;" value='<s:property value="txttelno"/>' onfocus="reqdata();disfields();"></td>
    <td align="right" width="3%" >Email</td>
    <td > <input type="text" id="txtemail" name="txtemail" style="width: 51.5%;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();"></td>
  </tr>  -->
  
  <tr>
  <!--    <td align="right" width="150">Contract Type</td>
  <td width="148"><input type="radio" id="c2" name="cnt" checked='true' value="SJOB" onchange="getsjobtype();" onClick="getsjobtype();jobChange();" >SJOB</td>-->
   <%--  <td align="right">Type</td>
	  <td align="left"><select name="cmbprocess" id="cmbprocess" style="width:62%;" name="cmbprocess" onchange="funtxtenable(value);"  value='<s:property value="cmbprocess"/>'></select>
	  <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' /> 
	  </td> --%>
	  <%-- <td align="right">Questionnaire Type</td>
	  <td align="left"><select name="cmbques" id="cmbques" style="width:62%;" name="cmbques" value='<s:property value="cmbques"/>'>
	  <option value="1">Kitchen</option><option value="2">Closet</option></select>
	  <input type="hidden" name="hidcmbques" id="hidcmbques" value='<s:property value="hidcmbques"/>' /> 
	  </td> --%>
    </tr>
</table> 
  <table  width="100%" >
  <tr>
  <!--   <td width="2%" align="right">Service Type</td>
    <td  width="5%"><select id="cmbsertype" name="cmbsertype" style="width:70%;" value='<s:property value="cmbsertype"/>'></select>  
      <input type="hidden" id="hidcmbsertype" name="hidcmbsertype" value='<s:property value="hidcmbsertype"/>'/></td>
   <td width="1%" align="right">Industry</td>
    <td  width="6%"><select id="cmbenqbtype" name="cmbenqbtype" style="width:55%;" value='<s:property value="cmbenqbtype"/>'></select>  
      <input type="hidden" id="hidcmbenqbtype" name="hidcmbenqbtype" value='<s:property value="hidcmbenqbtype"/>'/></td> -->
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
<td>
 <fieldset><legend>Enquiry Details</legend>
<div id="enqdiv">
<jsp:include page="enquiryDetails.jsp"></jsp:include></div>
</fieldset> </td>
</tr>
<tr>
<td>
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

<input type="hidden" id="hidradio" name="hidradio"  value='<s:property value="hidradio"/>'/>
<input type="hidden" id="hidsurvey" name="hidsurvey"  value='<s:property value="hidsurvey"/>'/>
<input type="hidden" id="hidcmbenqbtype" name="hidcmbenqbtype"  value='<s:property value="hidcmbenqbtype"/>'/>
<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
  <input type="hidden" id="hidenqedit" name="hidenqedit"  value='<s:property value="hidenqedit"/>'/>  
 <input type="hidden" id="hidcmbsertype" name="hidcmbsertype"  value='<s:property value="hidcmbsertype"/>'/> 
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
</div>  

</body>
</html>