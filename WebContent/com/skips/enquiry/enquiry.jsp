<%@ taglib prefix="s" uri="/struts-tags"%>
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
	color: red;
	font-weight: bold;
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
color: blue
}
</style>
<%
String modes = request.getParameter("modes") == null ? "0" : request.getParameter("modes").toString();
String enqdocno = request.getParameter("enqdocno") == null ? "0" : request.getParameter("enqdocno").toString();

String vocno = request.getParameter("vocno") == null ? "0" : request.getParameter("vocno").toString();
String isassign = request.getParameter("isassign") == null ? "0" : request.getParameter("isassign").toString();

String docno = request.getParameter("docno") == null ? "0" : request.getParameter("docno").toString();

String date = request.getParameter("date") == null ? "0" : request.getParameter("date").toString();
String client = request.getParameter("client") == null ? "0" : request.getParameter("client").toString();
String cldocno = request.getParameter("cldocno") == null ? "0" : request.getParameter("cldocno").toString();
String contrmode = request.getParameter("contrmode") == null ? "0" : request.getParameter("contrmode").toString();
String mail = request.getParameter("mail") == null ? "0" : request.getParameter("mail").toString();
String mob = request.getParameter("mob") == null ? "0" : request.getParameter("mob").toString();
String address = request.getParameter("address") == null ? "0" : request.getParameter("address").toString();
String remarks = request.getParameter("remarks") == null ? "0" : request.getParameter("remarks").toString();
String telno = request.getParameter("telno") == null ? "0" : request.getParameter("telno").toString();
String source = request.getParameter("source") == null ? "0" : request.getParameter("source").toString();
String sourceid = request.getParameter("sourceid") == null ? "0" : request.getParameter("sourceid").toString();
String cperson = request.getParameter("cperson") == null ? "0" : request.getParameter("cperson").toString();
String cpersonid = request.getParameter("cpersonid") == null ? "0" : request.getParameter("cpersonid").toString();
String sal_name = request.getParameter("sal_name") == null ? "0" : request.getParameter("sal_name").toString();
String sal_id = request.getParameter("sal_id") == null ? "0" : request.getParameter("sal_id").toString();
String sjobtype = request.getParameter("sjobtype") == null ? "0" : request.getParameter("sjobtype").toString();
String brhid = request.getParameter("brhid") == null ? "0" : request.getParameter("brhid").toString();
%>
<script type="text/javascript">
var modes='<%=modes%>';
var masterdoc='<%=docno%>';
var enqdocno='<%=enqdocno%>';
var brhid='<%=brhid%>';
 $(document).ready(function () {
	 Setenqstatus();getenqbuildtype(); 
	 setChange();
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
     $('#desiginfowindow').jqxWindow({ width: '35%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Designation Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#desiginfowindow').jqxWindow('close');
     $('#areainfowindow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#areainfowindow').jqxWindow('close');
 	 $('#skipinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Skip Size Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#skipinfowindow').jqxWindow('close');
 	 $('#wasteinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Waste Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#wasteinfowindow').jqxWindow('close');
 	 $('#methodinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Method Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	 $('#methodinfowindow').jqxWindow('close');
  	 $('#servbyinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Ownership Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	 $('#servbyinfowindow').jqxWindow('close');
  	 $('#scheduleinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Term Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	 $('#scheduleinfowindow').jqxWindow('close');
  	 $('#collectioninfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Collection Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	 $('#collectioninfowindow').jqxWindow('close');
  	 $('#specinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Spec Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	 $('#specinfowindow').jqxWindow('close');
  	 $('#siteinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27}); 
 	 $('#siteinfowindow').jqxWindow('close');   
 	 $('#contactinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Contact Person Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#contactinfowindow').jqxWindow('close');
	 $('#site1infowindow').jqxWindow({ width: '80%', height: '85%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Site Details' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#site1infowindow').jqxWindow('close');
 	 $('#surveytypewindow').jqxWindow({ width: '35%', height: '45%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 300, y: 87 }, keyboardCloseKey: 27});
	 $('#surveytypewindow').jqxWindow('close'); 
	 $('#grpcmpinfowindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Company Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	 $('#grpcmpinfowindow').jqxWindow('close'); 
	 $('#contactpersonsavewindow').jqxWindow({ width: '80%', height: '29%',  maxHeight: '60%' ,maxWidth: '90%' ,title: ' Save Contact Person ' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
     $('#contactpersonsavewindow').jqxWindow('close'); 
     $('#groupcompanysavewindow').jqxWindow({ width: '50%', height: '12%',  maxHeight: '20%' ,maxWidth: '60%' ,title: ' Save Group Company ' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
     $('#groupcompanysavewindow').jqxWindow('close');   
     $('#depinfowindow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Department Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	 $('#depinfowindow').jqxWindow('close'); 
  	 $('#activityinfowindow').jqxWindow({ width: '40%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#activityinfowindow').jqxWindow('close');
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
    $('#grpcmp').dblclick(function(){  
		 //if(document.getElementById("custid").checked){  
	    	$('#grpcmpinfowindow').jqxWindow('open');
	    	grpcmpinfoSearchContent('searchGroupCompany.jsp?', $('#grpcmpinfowindow')); 
		 //}  
   });
    
    $('#txtdesig').dblclick(function(){
    	/* var clientid=document.getElementById("cmbclient").value;
		var custid=$('#custid').val();
		if((clientid=="") && !(parseInt(custid)==1)){
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
		}
		else{
    		$('#desiginfowindow').jqxWindow('open');
        	desigSearchContent('activity.jsp');
    	} */
    	$('#desiginfowindow').jqxWindow('open');
    	desigSearchContent('activity.jsp');   
   });
    
    if(document.getElementById("txtradio").value==1)
    	{
    	//document.getElementById("r2").checked = true;
    
		$("#cmbclient").hide();
		/* $("#btnnewclient").hide(); */  
    	}
  
   if(document.getElementById("txtradio").value=="")
	   {
	
	   $("#cmbclient").hide();
		/* $("#btnnewclient").hide(); */
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
         

			$("#cmbclient").show();
			
			/* $('#fromEnquiry input').attr('readonly', true );
			$('#txtdesig').attr('placeholder', 'Press F3 to Search');
			$('#txtcontact').attr('readonly', false );
			$('#txtdesc').attr('readonly', false );
			$('#grpcmp').attr('disabled', false );
			$("#jqxEnquiry").jqxGrid({ disabled: false}); */
			 document.getElementById("txtradio").value="2";
			// $('#hidradio').val('AMC');
			   document.getElementById("errormsg").innerText="";
			/* $("#btnnewclient").show(); */
			
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
 function getdesig(event){  
		/* var clientid=document.getElementById("cmbclient").value;
		var chkval=$('#custid').val();
		if((clientid=="") && !(parseInt(chkval)==1)){
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
		} */ 
		var x= event.keyCode;
		if(x==114){
	 	   $('#desiginfowindow').jqxWindow('open');
	       desigSearchContent('activity.jsp'); 
	     }else{
			 }
  } 
	        	 
  function desigSearchContent(url) {
		 //alert(url);
	 	 $.get(url).done(function (data) {
				 //alert(data);
		$('#desiginfowindow').jqxWindow('setContent', data);

	               	}); 
	     	}
	     	
	function getcontact(event){
	  	 var x= event.keyCode;
	  	 if(x==114){
	  	  $('#contactinfowindow').jqxWindow('open');
	  
	    
	   contactSearchContent('Searchcontact.jsp?cldocno='+cldocno); }
	  	 else{
	  		 }
	  	 }
	function contactSearchContent(url) {
        //alert(url);
          $.get(url).done(function (data) {
 //alert(data);
           $('#contactinfowindow').jqxWindow('setContent', data);

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
          function grpcmpinfoSearchContent(url) {
            	 //alert(url);
            		 $.get(url).done(function (data) {
            			 
            			 $('#grpcmpinfowindow').jqxWindow('open');
            		$('#grpcmpinfowindow').jqxWindow('setContent', data);
            
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
		//$('#fromEnquiry')[0].reset(); 
	}
	function funReadOnly(){
		$("#btnsavecp").hide();
		$("#btnsavegc").hide();
		$('#btnques').attr('disabled', true);
		$('#fromEnquiry input').prop('readonly', true );
		$('#fromEnquiry textarea').attr('readonly', true );
		$('#fromEnquiry select').attr('disabled', true);
		$('#cmbclient').attr('disabled', true );
		$('#custid').attr('disabled', true);
		$('#txtsalesman').attr('disabled', true );
		// $('#txtdesc').attr('readonly', true );
		$('#txtsource').attr('disabled', true );
	    $('#grpcmp').attr('disabled', true );  

		//$('#c1').attr('disabled', true);
		$('#c2').attr('disabled', true);
		/* $('#btnnewclient').attr('disabled', true); */
		 $("#siteGrid").jqxGrid({ 'disabled': true});
	//	$('#r1').attr('disabled', true);
	//	$('#r2').attr('disabled', true);
		$('#EnquiryDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxEnquiry").jqxGrid({ disabled: true});
	   /*  if(document.getElementById("cmbclient").value==0){
			document.getElementById("custid").checked = true;
	        $('#cmbclient').hide();
	   	    $('#fromEnquiry input').attr('readonly', false );
		}
	    if(document.getElementById("cmbclient").value>0) {
			document.getElementById("custid").checked = false;
	        $('#cmbclient').show();
	   	    $('#fromEnquiry input').attr('readonly', true );
		} */  
	    
	    if(modes=="view")
		{
	    	console.log("modes="+modes);  
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
      	
          document.getElementById("fromEnquiry").submit();
		// $("#activityDetailsDiv").load("activityDetailsGrid.jsp?trno="+docno);
		
		  $('#masterdoc_no').attr('disabled', false);
		   $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false); --%>
		   
		}
	
	}
	function funRemoveReadOnly(){
		document.getElementById("statusval").innerHTML=" ";
		$("#btnsavecp").show();
		$("#btnsavegc").show(); 
		//$('#btnques').attr('disabled', false);
		$('#fromEnquiry input').attr('readonly', false );
		 $('#cmbclient').attr('disabled', false );
			$('#custid').attr('disabled', false);	
		 $('#txtsalesman').attr('disabled', false );
		 $('#txtsource').attr('disabled', false );
		 
		$('#fromEnquiry textarea').attr('readonly', false );
		$('#fromEnquiry select').attr('disabled', false);
		//$('#c1').attr('disabled', false);
		$('#c2').attr('disabled', false);
	/* 	$('#btnnewclient').attr('disabled', false); */
		$('#txtsource').attr('readonly', true);
	//	$('#r1').attr('disabled', false);
	//	$('#r2').attr('disabled', false);
	 $("#siteGrid").jqxGrid({ disabled: false});
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		$('#cmbprocess').attr('disabled', false);
		 $("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#grpcmp').attr('disabled', false );

		if ($("#mode").val() == "A") {
		//	 $("#btnques").attr('disabled', true );           
		//	$('#hidradio').val('AMC');
		//	document.getElementById("c2").checked=true;
			//getsjobtype();
			chkChange();
			 $('#EnquiryDate').val(new Date());
		     $("#jqxEnquiry").jqxGrid('clear');
		    $("#jqxEnquiry").jqxGrid('addrow', null, {});
		    $("#siteGrid").jqxGrid('clear');
		  $("#siteGrid").jqxGrid('addrow', null, {});
		   }
		
		if ($("#mode").val() == "E") {
			// $("#jqxEnquiry").jqxGrid('addrow', null, {});
			 var chkcldoc= document.getElementById("cmbclient").value;  
			 console.log("chkcldoc="+chkcldoc);  
			 if(parseInt(chkcldoc)==0 || parseInt(chkcldoc)==""){
				 console.log("1=1");
           	  document.getElementById("custid").checked=true;
                /*  $('#cmbclient').hide();
           	    $('#fromEnquiry input').attr('readonly', false );
       		 document.getElementById("cmbclient").value=""; */
             }else if(parseInt(chkcldoc)>0){
            	 console.log("2=2");
           	  document.getElementById("custid").checked=false;
           	  /* $('#cmbclient').show();
         	    $('#fromEnquiry input').attr('readonly', true );
        		$('#txtdesig').attr('disabled', false);
    			$('#txtdesig').attr('placeholder', 'Press F3 to Search'); */ 
             }else{}
		}
		setChange();
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
 
 function getsite1(rowBoundIndex){
	 
 	  $('#site1infowindow').jqxWindow('open');
 
         var cldocno = document.getElementById("cmbclient").value;

           site1SearchContent('site1.jsp?rowBoundIndex='+rowBoundIndex+'&cldocno='+cldocno);
        	 }
        	 
function site1SearchContent(url) {
 //alert(url);
 	 $.get(url).done(function (data) {
		 //alert(data);
$('#site1infowindow').jqxWindow('setContent', data);

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
 
 function getmethod(rowBoundIndex){
	 
	  $('#methodinfowindow').jqxWindow('open');

   // $('#accountWindow').jqxWindow('focus');
          methodSearchContent('getmethod.jsp?rowBoundIndex='+rowBoundIndex);
       	 }
function methodSearchContent(url) {
	      	 // alert(url);
	      	  	 $.get(url).done(function (data) {
	      	 		 //alert(data);
	      	 $('#methodinfowindow').jqxWindow('setContent', data);

	      	                	}); 
	      	      	}
function getservby(rowBoundIndex){
	 
	  $('#servbyinfowindow').jqxWindow('open');

 // $('#accountWindow').jqxWindow('focus');
        servbySearchContent('getservby.jsp?rowBoundIndex='+rowBoundIndex);
     	 }
function servbySearchContent(url) {
	      	 // alert(url);
	      	  	 $.get(url).done(function (data) {
	      	 		 //alert(data);
	      	 $('#servbyinfowindow').jqxWindow('setContent', data);

	      	                	}); 
	      	      	}
function getschedule(rowBoundIndex){
	 
	  $('#scheduleinfowindow').jqxWindow('open');

 // $('#accountWindow').jqxWindow('focus');
        scheduleSearchContent('getschedule.jsp?rowBoundIndex='+rowBoundIndex);
     	 }
function scheduleSearchContent(url) {
	      	 // alert(url);
	      	  	 $.get(url).done(function (data) {
	      	 		 //alert(data);
	      	 $('#scheduleinfowindow').jqxWindow('setContent', data);

	      	                	}); 
	      	      	}
 
function getcollection(rowBoundIndex){
	 
	  $('#collectioninfowindow').jqxWindow('open');

// $('#accountWindow').jqxWindow('focus');
      collectionSearchContent('getcollection.jsp?rowBoundIndex='+rowBoundIndex);
   	 }
function collectionSearchContent(url) {
	      	 // alert(url);
	      	  	 $.get(url).done(function (data) {
	      	 		 //alert(data);
	      	 $('#collectioninfowindow').jqxWindow('setContent', data);

	      	                	}); 
	      	      	}
function getspec(rowBoundIndex){
	 
	  $('#specinfowindow').jqxWindow('open');

//$('#accountWindow').jqxWindow('focus');
    specSearchContent('getspec.jsp?rowBoundIndex='+rowBoundIndex);
 	 }
function specSearchContent(url) {
	      	 // alert(url);
	      	  	 $.get(url).done(function (data) {
	      	 		 //alert(data);
	      	 $('#specinfowindow').jqxWindow('setContent', data);

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
 
 	  function refsearchContent(url) {
    
       $.get(url).done(function (data) {

     $('#surveytypewindow').jqxWindow('setContent', data);

 	}); 
 	}
	function Setviewmode(enqdocno,brhid){
		console.log("set view mode");
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
			              document.getElementById("grpcmp").value=items[20];

			        	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
			        	console.log("set view mode");
			            document.getElementById("fromEnquiry").submit();  
			 
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
	function getgrpcmp(event){
		 //if(document.getElementById("custid").checked){
			 var x= event.keyCode;
	   	     if(x==114){
		   		 $('#grpcmpinfowindow').jqxWindow('open');
		   		 grpcmpinfoSearchContent('searchGroupCompany.jsp?', $('#grpcmpinfowindow'));     
		   	 }
		   	 else{
		   	 }
		 //}
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
	       function validateEmail($email) {
	    		  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	    		  if(emailReg.test( $email )){
	    			  document.getElementById("errormsg").innerText="";
	    				//$('#txtmobilevalidation').val(0);
	    				return true;
	    			}
	    			else{
	    				document.getElementById("errormsg").innerText="Email Address Not Valid";
	    				//$('#txtmobilevalidation').val(1);
	    				return false;
	    			}
	    		  return true;
	    		} 
	       
	function funNotify(){
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		var chckcredit=document.getElementById("chkcredit").value;
		if(chckcredit>0)
     	{
     	document.getElementById("errormsg").innerText="Credit Period Exceeded";
     	//return 0;  
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
	 
		 var mobile=document.getElementById("txtmobile").value;   
		 var email=document.getElementById("txtemail").value;
		 var contact=document.getElementById("txtcontact").value;  
		 if(document.getElementById("custid").checked){
			 if(mobile==""){  
				 document.getElementById("errormsg").innerText="Please enter mobile number";
				 document.getElementById("txtmobile").focus();
				 return 0;
			 }else{
				 document.getElementById("errormsg").innerText="";
			 }
			 if(email==""){  
				 document.getElementById("errormsg").innerText="Please enter email";   
				 document.getElementById("txtemail").focus();  
				 return 0;  
			 }else{
				 document.getElementById("errormsg").innerText=""; 
			 }
			 if(contact==""){  
				 document.getElementById("errormsg").innerText="Please enter Contact person name";     
				 document.getElementById("txtcontact").focus();    
				 return 0;  
			 }else{
				 document.getElementById("errormsg").innerText="";  
			 }
		 }  
		 var source = $("#txtsource").val();
		 if(source==""){
				document.getElementById("errormsg").innerText="Please select a source";
				return 0;
	     }else{
				document.getElementById("errormsg").innerText="";  
		 }
		 var grpcmp = $("#grpcmp").val();
		 if(grpcmp==""){
				document.getElementById("errormsg").innerText="Please select a group company"; 
				return 0;
		 }else{
				document.getElementById("errormsg").innerText=""; 
		 }
		 var valid=0,valid1=0;
		 var validenqrows = $("#jqxEnquiry").jqxGrid('getrows');   
		 for(var i=0 ; i < validenqrows.length ; i++){  
			 if(validenqrows[i].site!="" && typeof(validenqrows[i].site)!="undefined" && typeof(validenqrows[i].site)!="NaN" && validenqrows[i].site!=null){  
				 valid=1;
				 if(validenqrows[i].skipdoc=="" || typeof(validenqrows[i].skipdoc)=="undefined" || typeof(validenqrows[i].skipdoc)=="NaN" || validenqrows[i].skipdoc==null){  
					 valid1=1;
				 }
				 if(validenqrows[i].wastedoc=="" || typeof(validenqrows[i].wastedoc)=="undefined" || typeof(validenqrows[i].wastedoc)=="NaN" || validenqrows[i].wastedoc==null){  
					 valid1=1;
				 }
				 if(validenqrows[i].sepcid=="" || typeof(validenqrows[i].sepcid)=="undefined" || typeof(validenqrows[i].sepcid)=="NaN" || validenqrows[i].sepcid==null){  
					 valid1=1;
				 }
				 if(validenqrows[i].nos=="" || typeof(validenqrows[i].nos)=="undefined" || typeof(validenqrows[i].nos)=="NaN" || validenqrows[i].nos==null){  
					 valid1=1;
				 }
				 if(validenqrows[i].scheduledays=="" || typeof(validenqrows[i].scheduledays)=="undefined" || typeof(validenqrows[i].scheduledays)=="NaN" || validenqrows[i].scheduledays==null){  
					 valid1=1;
				 }
				 if(validenqrows[i].collectionsrno=="" || typeof(validenqrows[i].collectionsrno)=="undefined" || typeof(validenqrows[i].collectionsrno)=="NaN" || validenqrows[i].collectionsrno==null){  
					 valid1=1;
				 }
				 if(validenqrows[i].servsrno=="" || typeof(validenqrows[i].servsrno)=="undefined" || typeof(validenqrows[i].servsrno)=="NaN" || validenqrows[i].servsrno==null){  
					 valid1=1;
				 }
				 if(validenqrows[i].schedulesrno=="" || typeof(validenqrows[i].schedulesrno)=="undefined" || typeof(validenqrows[i].schedulesrno)=="NaN" || validenqrows[i].schedulesrno==null){    
					 valid1=1;
				 }
			 }
		 }  
		 if(valid==0){
			 document.getElementById("errormsg").innerText="Please enter data in enquiry details";    
			 return 0;  
		 }
		 if(valid1==1){
			 document.getElementById("errormsg").innerText="Please fill data in all columns of enquiry details";     
			 return 0;  
		 }
		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
	 	 var enqdetlen=0;
		 for(var k=0 ; k < rows.length ; k++){
			   var methods="";var servmethods="";var scheduletypes="";
			   if(rows[k].site!="" && typeof(rows[k].site)!="undefined" && typeof(rows[k].site)!="NaN" && rows[k].site!=null){  
				    newTextBox = $(document.createElement("input"))  
				       .attr("type", "dil")
				       .attr("id", "enqtest"+k)
				       .attr("name", "enqtest"+k)
				       .attr("hidden", "true"); 
				   newTextBox.val(rows[k].site+" :: "+rows[k].wastedoc+" :: "+rows[k].skipdoc+" :: "+rows[k].sepcid+" :: "+rows[k].srno+" :: "+rows[k].servsrno+" :: "+rows[k].nos+" :: "+rows[k].schedulesrno+" :: " +rows[k].scheduledays+" :: " +rows[k].collectionsrno+" :: "+rows[k].rowno+" :: ");
				   newTextBox.appendTo('form');
				   enqdetlen++;
		       } 
		  }  
		  $('#enqgridlenght').val(enqdetlen);    
		   var rowssitegrid = $("#siteGrid").jqxGrid('getrows');
		    $('#siteGridlength').val(rowssitegrid.length);
		   var survid="";
		   for(var i=0 ; i < rowssitegrid.length ; i++){
			   if(rowssitegrid[i].site!="" ||rowssitegrid[i].site!="undefined"|| rowssitegrid[i].site!="null")
				{
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "sitetest"+i)
		       .attr("name", "sitetest"+i)
		       .attr("hidden", "true"); 
		    if (rowssitegrid[i].surid ==" " || rowssitegrid[i].surid =="undefined" || rowssitegrid[i].surid =="null") {
		    	survid=0;
			}
		   newTextBox.val(rowssitegrid[i].site+" :: "+rowssitegrid[i].remarks+" :: "+rowssitegrid[i].areaid+" :: "+survid+" :: "+rowssitegrid[i].rowno+" :: ");
		   newTextBox.appendTo('form');
				}
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		//fromEnquiryfrn.submit();
	}

	function funSearchLoad(){
		 changeContent('enqMastersearch.jsp'); 
	}
    $(function(){
        $('#fromEnquiry').validate({
                rules: { 
                txtclientname:{"required":true},
                txtmobile:{number:true,maxlength:12,minlength:12},
                txttelno:{number:true,maxlength:11,minlength:11},
             //   txtemail:"",
              //  txtaddress: {maxlength:200},
                txtRemarks:{maxlength:200},               
                txtdesc:{maxlength:500}

                 },
                 messages: {
                 txtRemarks: {maxlength:" Max 200 chars"},
                 txtdesc: {maxlength:" Max 500 chars"},
                 txtclientname: {required:" *required"},
               //  txtaddress: {maxlength:" Max 200 chars"},
                 txtmobile:{number:" Invalid MOB NO",maxlength:" Max 12 chars",minlength:" Minimum 12 chars" },
                 txttelno:{number:" Invalid Tel No",maxlength:" Max 11 chars",minlength:" Minimum 11 chars" },
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
     	      $('#fromEnquiry input').attr('readonly', true );
     			$('#fromEnquiry textarea').attr('readonly', true );
     			
     		
     	        return false;			            	              		          	  
   		}  
		 else 
	         	
 		{ 
			 document.getElementById("errormsg").innerText="";	
			 
			 $('#fromEnquiry input').attr('readonly', false );
				$('#fromEnquiry textarea').attr('readonly', false );
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
  	/* 	$("#btnnewclient").show();  */
  	    $('#fromEnquiry input').attr('readonly', true );
		$('#fromEnquiry textarea').attr('readonly', true );
        $('#docno').attr('readonly', true);
		
		/* 
		
  		  }
  	  else 
  		  {
  	
  		  document.getElementById("r1").checked = true;
  		 document.getElementById("r2").checked = false;
  		  $('#fromEnquiry input').attr('readonly', true );
			$('#fromEnquiry textarea').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			
  		  }
			}
		else{}
 
    
	     */
    } 
	
	
	 function disfields(){
		/*  $('#docno').attr('readonly', true);
		 $('#cmbclient').attr('readonly', true );
		 
	     var chkcldoc=document.getElementById("cmbclient").value;
		 if(chkcldoc==""){
          	  $('#cmbclient').hide();
		  	    $('#fromEnquiry input').attr('readonly', false );

              	if ($("#mode").val() == "E") {
                 	  $('#cmbclient').hide();
              	    $('#fromEnquiry input').attr('readonly', false );

					}
		 }
		 else{
          	  $('#cmbclient').show();
		  	    $('#fromEnquiry input').attr('readonly', true );
				

	    	if ($("#mode").val() == "view" ) {
	           	$('#cmbclient').show();
	      	    $('#fromEnquiry input').attr('readonly', true );
	    		

	
					}
		 } */  
			
	 }
	function setValues() {
		  if($('#hidcmbenqbtype').val()!="")
		  {
		  $('#cmbenqbtype').val($('#hidcmbenqbtype').val());   

		  }
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
  	  
      if(docVal1>0) {
	      	 Setenqstatus();
			 var indexVal2 = document.getElementById("masterdoc_no").value;
	     	  
	         $("#enqdiv").load("enquiryDetails.jsp?enqrdocno="+indexVal2);
	         $("#sitediv").load("siteGrid.jsp?sitedocno="+indexVal2);
	         
	         var chkcldoc= document.getElementById("cmbclient").value;
			 if(chkcldoc=="0" || chkcldoc==""){  
	       	  	document.getElementById("custid").checked=true;
	         }else{
	       	    document.getElementById("custid").checked=false;
	         } 
			 setChange();
        }
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
      	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
      	enquiryAlert();	
	}
    
  /*  function funPrintBtn(){
 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
 	  
 	   var url=document.URL;

        var reurl=url.split("/com/");
   
        $("#docno").prop("disabled", false);                
        
  
var win= window.open(reurl[0]+"printEnqnew?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
     
win.focus();
 	   } 
 	  
 	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     }
	    	
 	}*/
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
    
    function enquiryAlert(){
    	var docVal1 = document.getElementById("masterdoc_no").value;
    	var x = new XMLHttpRequest();
    	x.onreadystatechange = function() {
    		if(x.readyState == 4 && x.status == 200){
    			
    			var items = x.responseText.trim();
    			document.getElementById("statusval").innerHTML="Last Modified :"+items;
    		}
    		
    	}
    	x.open("GET", "getEnqStatus.jsp?docno="+docVal1);
		x.send();
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
					  $("#btnEdit").attr('disabled', false );
					  $("#btnDelete").attr('disabled', false );  
					}
				
			} else {
			}
		}
		x.open("GET", "getEnqStat.jsp?masterdoc="+$('#masterdoc_no').val(), true);
		x.send();
	}
     
 function creditperiod()
 {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				//alert(items);
				 document.getElementById("chkcredit").value=items;
				
	           if(parseInt(items)>0)
					{
					document.getElementById("errormsg").innerText="Credit Period Exceeded";  
					return 0;

					}
				else
					{
					document.getElementById("errormsg").innerText=" ";  
					}
	       	  
				
			} else {
			}
       //     $("#items").value="";
		}
		x.open("GET", "creditperiod.jsp?cldocno="+$('#cmbclient').val(), true);
		x.send();
	}
 
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
	 if(document.getElementById("custid").checked){
			if ($("#mode").val() == "A" || $("#mode").val() == "E") {
				 $('#txtdesc').attr('readonly', false );
				 $('#txtclientname').attr('readonly', false );
				 $('#txtaddress').attr('readonly', false );
				 $('#txtemail').attr('readonly', false );
				 $('#txtmobile').attr('readonly', false );
				 $('#txttelno').attr('readonly', false );  
				 $('#txtcontact').attr('readonly', false ); 
				 $("#btnsavecp").hide();
			 }
			 document.getElementById("cmbclient").value="";
			 //$('#grpcmp').attr('placeholder', 'Press F3 to Search');    
			 $('#cmbclient').hide();
	 }else{ 
		    $("#hidchkclienttype").val(0);  
		    $('#cmbclient').show();
			$('#txtdesig').attr('disabled', false);
			$('#txtdesig').attr('placeholder', 'Press F3 to Search');
			$('#txtclientname').attr('readonly', true );  
			$('#txtaddress').attr('readonly', true );
			$('#txtemail').attr('readonly', true );
			$('#txtmobile').attr('readonly', true );
			$('#txttelno').attr('readonly', true ); 
			$('#txtcontact').attr('readonly', true );  
			if ($("#mode").val() == "A" || $("#mode").val() == "E") {
				$('#txtdesc').attr('readonly', false ); 
				 $("#btnsavecp").show();  
			}
	 }
 }
 function funContactPerson(){
	         var cldocno = $("#cmbclient").val()
	         if(cldocno=="" || cldocno=="0"){
	        	 $.messager.alert('Message','Please select a client!!','warning');  
	 			 return 0;  
	         }else{
	        	 $('#contactpersonsavewindow').jqxWindow('open');    
			     saveContent('cpSaveWindow.jsp?cldocno='+cldocno,$("#contactpersonsavewindow").attr('id'));  
	         }
      }  
 
 function funGroupCompany(){  
    	 $('#groupcompanysavewindow').jqxWindow('open');      
	     saveContent('gcSaveWindow.jsp?',$("#groupcompanysavewindow").attr('id'));  
 } 
 function saveContent(url,id) {      
	          $.get(url).done(function (data) {  
		           $('#'+id).jqxWindow('setContent', data);
         	  }); 
 }  
</script>
</head>
<body onload="setValues();getServiceType();"
	onmouseover="Setenqstatus();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="fromEnquiry" action="saveEnquiryskip" autocomplete="OFF">

			<jsp:include page="../../../header.jsp"></jsp:include><br />

			<fieldset>
				<legend>Customer Enquiry</legend>
				<table width="100%" >  
					<tr>
						<td width="6%" align="right">Date</td>
						<td width="5%" align="left"><div id='EnquiryDate'
								name='EnquiryDate' value='<s:property value="EnquiryDate"/>'></div>
							<input type="hidden" id="hidEnquiryDate" name="hidEnquiryDate"
							value='<s:property value="hidEnquiryDate"/>' /></td>
						<td width="30%"><label class="branch">New Client</label> <input
							type="checkbox" id="custid" name="custid" onchange="setChange();"/><input  
							type="hidden" id="hidgrpcmpid" name="hidgrpcmpid"
							value='<s:property value="hidgrpcmpid"/>' /><input
							type="hidden" id="hidchkclienttype" name="hidchkclienttype"  
							value='<s:property value="hidchkclienttype"/>' /></td>  
						<td align="left" width="30%">
						<button type="button" class="icon tooltip" id="btnsavecp" onclick="funContactPerson();">
							<img alt="savecp" src="icons/icons8-male-user-25.png">
							 <span class="tooltiptext">Contact Person</span> 
						</button>&nbsp;&nbsp; 
						
						<button type="button" class="icon tooltip" id="btnsavegc" onclick="funGroupCompany();">
							<img alt="savegc" src="icons/icons8-library-building-25.png">
							 <span class="tooltiptext">Group Company</span> 
						</button> <label id="statusval" ></label>
						</td>   
						<td width="30%" align="right">&nbsp;&nbsp; &nbsp;&nbsp;Doc
							No<input type="text" id="docno" name="docno" tabindex="-1"
							style="width: 50%;" value='<s:property value="docno"/>'
							onfocus="disfields();" />
						</td>
					</tr>
					<%--   <tr>
    <td align="right">&nbsp;</td>
    <td colspan="2"><input type="radio" id="r1" name="genaral" value='<s:property value="0"/>'  >General</td>
    <td colspan="2"><input type="radio" id="r2" name="client" value='<s:property value="1"/>' >Client</td>
  </tr>  --%>

					<tr>
						<td width="2%" align="right">Client</td>
						<td width="5%" colspan="2"><input type="text" style="width: 55px;"  id="cmbclient"
							name="cmbclient" placeholder="Press F3 To Search"
							value='<s:property value="cmbclient"/>'
							onKeyDown="getclinfo(event);"> <input
							type="text" id="txtclientname" name="txtclientname"
							style="width: 57%;" value='<s:property value="txtclientname"/>'
							onfocus="reqdata();disfields();"></td>
							<td align="left" width="30%">						
							
</td> 
							  
						<!-- <td align="left" width="30%">
							<button type="button" id="btnnewclient" class="myButton"
								onclick="text();">Create new Client</button> &nbsp;&nbsp;&nbsp;
						</td> -->  
						<td align="right">
						Group Companies<input type="text" id="grpcmp" name="grpcmp"
							style="width: 50%;" value='<s:property value="grpcmp"/>' onKeyDown="getgrpcmp(event);" placeholder="Press F3 To Search">      
						</td>
					</tr>

					<!--  <td width="10.8%" align="right">Contact person</td>
    <td><input type="text" id="txtcontact" name="txtcontact" style="width:25%;" value='<s:property value="txtcontact"/>' onKeyDown="getcontact(event);"></td>  -->
					<tr>
						<td width="3%" align="right">Contact person</td>
						<td width="5%" colspan="2"><input type="text" id="txtcontact"
							name="txtcontact" style="width: 71%;"
							value='<s:property value="txtcontact"/>'
							onKeyDown="getcontact(event);">&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Designation</td>
							<td><input type="text" id="txtdesig" name="txtdesig" style="width:100%;"
							placeholder="Press F3 To Search" value='<s:property value="txtdesig"/>'
							onKeyDown="getdesig(event);"></td>
							
							<td align="right">Source <input type="text" id="txtsource"
							name="txtsource" style="width: 50%;" readonly
							placeholder="Press F3 To Search" onKeyDown="getSource(event);"
							value='<s:property value="txtsource"/>'> <input
							type="checkbox" name="chksurvey" id="chksurvey" value="chksurvey"
							hidden="true" value='<s:property value="chksurvey"/>'
							onclick="$(this).attr('value', this.checked ? 1 : 0);">
						</td>
					</tr>
					<tr>
						<td align="right" width="2%">Address</td>
						<td colspan="2"><input type="text" id="txtaddress"
							name="txtaddress" style="width: 71%;"
							value='<s:property value="txtaddress"/>'
							onfocus="reqdata();disfields();">
							&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Email</td>  
							<td><input type="text" id="txtemail"
							name="txtemail" style="width: 100%;"
							value='<s:property value="txtemail"/>'
							onblur="validateEmail(this.value);"
							onfocus="reqdata();disfields();"></td>
						<td align="right">Salesman <input type="text"
							id="txtsalesman" name="sal_name" style="width: 50%;"
							placeholder="Press F3 To Search"
							value='<s:property value="sal_name"/>'
							onKeyDown="getsalinfo(event);" onfocus="disfields();">
							<input type="hidden" id="txtsalesmandocno" name="sal_id"
							value='<s:property value="sal_id"/>'>
						</td>
					</tr>
					<tr>
						<td align="right" width="2%">MOB</td>
						<td colspan="2"><input type="text" id="txtmobile"
							name="txtmobile" style="width: 35%;"
							value='<s:property value="txtmobile"/>'
							onfocus="reqdata();disfields();">
							&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp; &nbsp;&nbsp; Tel</td>
							 <td> <input type="text" id="txttelno"
							name="txttelno" style="width: 50%;"
							value='<s:property value="txttelno"/>'
							onfocus="reqdata();disfields();">
							</td>
							<td align="right">Industry <select id="cmbenqbtype"
							name="cmbenqbtype" style="width: 50%;"
							value='<s:property value="cmbenqbtype"/>'></select> <input
							type="hidden" id="hidcmbenqbtype" name="hidcmbenqbtype"
							value='<s:property value="hidcmbenqbtype"/>' /></td>

					</tr>
					<tr>
						<td align="right" width="2%">Description</td>

						<td colspan="4"><input type="text" id="txtdesc"
							name="txtdesc" style="width: 100%;"
							value='<s:property value="txtdesc"/>'
							onfocus="reqdata();disfields();"></td>

						<td hidden="true" align="right" width="10.8%">Remarks</td>
						<td hidden="true" colspan="3"><input type="text"
							id="txtRemarks" name="txtRemarks" style="width: 76.6%;"
							value='<s:property value="txtRemarks"/>'
							onfocus="reqdata();disfields();"></td>


					</tr>
				</table>
				<table width="100%">


					<tr>
						<td align="right" hidden="true" width="150">Contract Type</td>
						<td width="148" hidden="true"><input type="radio" id="c2"
							name="cnt" checked='true' value="SJOB" onchange="getsjobtype();"
							onClick="getsjobtype();jobChange();">SJOB</td>
						<td align="right" hidden="true">Type</td>
						<td align="left" hidden="true"><select name="cmbprocess"
							id="cmbprocess" style="width: 62%;" name="cmbprocess"
							onchange="funtxtenable(value);"
							value='<s:property value="cmbprocess"/>'></select> <input
							type="hidden" name="hidcmbprocess" id="hidcmbprocess"
							value='<s:property value="hidcmbprocess"/>' /></td>
						<td align="right" hidden="true">Questionnaire Type</td>
						<td align="left" hidden="true"><select name="cmbques"
							id="cmbques" style="width: 62%;" name="cmbques"
							value='<s:property value="cmbques"/>'>
								<option value="1">Kitchen</option>
								<option value="2">Closet</option>
						</select> <input type="hidden" name="hidcmbques" id="hidcmbques"
							value='<s:property value="hidcmbques"/>' /></td>
					</tr>
				</table>
				<table width="100%">
					<tr>
						<td width="2%" hidden="true" align="right">Service Type</td>
						<td width="5%" hidden="true"><select id="cmbsertype"
							name="cmbsertype" style="width: 70%;"
							value='<s:property value="cmbsertype"/>'></select> <input
							type="hidden" id="hidcmbsertype" name="hidcmbsertype"
							value='<s:property value="hidcmbsertype"/>' /></td>
						<td hidden="true"><button type="button" id="btnques"
								class="myButton">Questionnaire</button></td>
					</tr>
				</table>
			</fieldset>

			<table width="100%">
				<tr>
					<td><fieldset>
							<legend>Site Details</legend>
							<div id="sitediv"><jsp:include page="siteGrid.jsp"></jsp:include></div>
						</fieldset></td>

				</tr>
				<tr>
					<td>
						<fieldset>
							<legend>Enquiry Details &nbsp;&nbsp;&nbsp;&nbsp; Double
								click or press F3 to select Data</legend>
							<div id="enqdiv">
								<jsp:include page="enquiryDetails.jsp"></jsp:include></div>
						</fieldset>
					</td>
				</tr>
				<tr>
					<td><input type="hidden" id="masterdoc_no" name="masterdoc_no"
						value='<s:property value="masterdoc_no"/>' /> <input
						type="hidden" id="mode" name="mode"
						value='<s:property value="mode"/>' /> <input type="hidden"
						name="deleted" id="deleted" value='<s:property value="deleted"/>' />
						<input type="hidden" name="enqdtype" id="enqdtype"
						value='<s:property value="enqdtype"/>' /> <input type="hidden"
						id="enqgridlenght" name="enqgridlenght" /> <input type="hidden"
						id="siteGridlength" name="siteGridlength" /> <input type="hidden"
						name="gridval" id="gridval" value='<s:property value="gridval"/>' />
						<input type="hidden" name="forradiochk" id="forradiochk"
						value='<s:property value="forradiochk"/>' /> <input type="hidden"
						name="brandval" id="brandval"
						value='<s:property value="brandval"/>' /> <input type="hidden"
						name="sourceid" id="sourceid"
						value='<s:property value="sourceid"/>' /> <input type="hidden"
						name="cpersonid" id="cpersonid"
						value='<s:property value="cpersonid"/>' /> <input type="hidden"
						name="activityid" id="activityid"
						value='<s:property value="activityid"/>' /> <input type="hidden"
						name="fromdatesval" id="fromdatesval"
						value='<s:property value="fromdatesval"/>' /> <input
						type="hidden" name="todateval" id="todateval"
						value='<s:property value="todateval"/>' /> <input type="hidden"
						id="sertypeids" name="sertypeids"
						value='<s:property value="sertypeids"/>' /> <input type="hidden"
						id="enqstatus" name="enqstatus"
						value='<s:property value="enqstatus"/>' /> <input type="hidden"
						id="hidradio" name="hidradio"
						value='<s:property value="hidradio"/>' /> <input type="hidden"
						id="hidsurvey" name="hidsurvey"
						value='<s:property value="hidsurvey"/>' />  <input
						type="hidden" name="txtradio" id="txtradio"
						value='<s:property value="txtradio"/>' /> <input type="hidden"
						id="msg" name="msg" value='<s:property value="msg"/>' /> <input
						type="hidden" id="hidenqedit" name="hidenqedit"
						value='<s:property value="hidenqedit"/>' /> <input type="hidden"
						id="hidcmbsertype" name="hidcmbsertype"
						value='<s:property value="hidcmbsertype"/>' /> <input
						type="hidden" id="chkcredit" name="chkcredit"
						value='<s:property value="chkcredit"/>' />
						</td>     
				</tr>
			</table>
		</form>
		<div id="sourcesearchwndow">
			<div></div>
		</div>
		<div id="modelsearchwndow">
			<div></div>
		</div>
		<div id="brandsearchwndow">
			<div></div>
		</div>
		<div id="contactinfowindow">
			<div></div>
		</div>
		<div id="clientsearch1">
			<div></div>
		</div>
		<div id="salesManDetailsWindow">
			<div></div>
		</div>
		<div id="desiginfowindow">
			<div></div>
		</div>
		<div id="areainfowindow">
			<div></div>
		</div>
		<div id="skipinfowindow">
			<div></div>
		</div>
		<div id="wasteinfowindow">
			<div></div>
		</div>
		<div id="methodinfowindow">
			<div></div>
		</div>
		<div id="servbyinfowindow">
			<div></div>
		</div>
		<div id="scheduleinfowindow">
			<div></div>
		</div>
		<div id="collectioninfowindow">
			<div></div>
		</div>
		<div id="specinfowindow">
			<div></div>
		</div>
		<div id="siteinfowindow">
			<div></div>
		</div>
		<div id="site1infowindow">
			<div></div>
		</div>
		<div id="surveytypewindow">
			<div></div>
		</div>
		<div id="closetquesinfowindow">
			<div></div>
		</div>
		<div id="grpcmpinfowindow">
			<div></div>
		</div>
		<div id="contactpersonsavewindow">   
	   		<div ></div>
	   </div> 
	   <div id="depinfowindow">   
	   		<div ></div>
	   </div> 
	   <div id="activityinfowindow">   
	   		<div ></div>
	   </div> 
	   <div id="groupcompanysavewindow">   
	   		<div ></div>
	   </div> 
	</div>

</body>
</html>