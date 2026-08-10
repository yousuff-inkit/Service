<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<%--   <% 
  
String dtype=  session.getAttribute("Code").toString();
  System.out.println("sss    "+dtype);
  %>  --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include> 

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<%
String mod =request.getParameter("mod")==null?"0":request.getParameter("mod").toString();
System.out.println("mod====="+mod);
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String enqdocno =request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").toString();

String vocno =request.getParameter("vocno")==null?"0":request.getParameter("vocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();


String docno= request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String trno= request.getParameter("trno")==null?"0":request.getParameter("trno").toString();
String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
System.out.println("client====="+client);
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();

System.out.println("cldocno====="+cldocno);
String contrmode=request.getParameter("contrmode")==null?"0":request.getParameter("contrmode").toString();
String mail=request.getParameter("mail")==null?"0":request.getParameter("mail").toString();
String mob=request.getParameter("mob")==null?"0":request.getParameter("mob").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String remarks=request.getParameter("remarks")==null?"0":request.getParameter("remarks").toString();
String telno=request.getParameter("telno")==null?"0":request.getParameter("telno").toString();
String source=request.getParameter("source")==null?"0":request.getParameter("source").toString();
String sourceid=request.getParameter("sourceid")==null?"0":request.getParameter("sourceid").toString();
String cperson=request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
System.out.println("cperson====="+cperson);
String cpersonid=request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String sjobtype=request.getParameter("sjobtype")==null?"0":request.getParameter("sjobtype").toString();
String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
String proname=request.getParameter("proname")==null?"0":request.getParameter("proname").toString();
System.out.println("proname====="+proname);
String desc=request.getParameter("desc")==null?"0":request.getParameter("desc").toString();
System.out.println("desc====="+desc);
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
String salid=request.getParameter("salid")==null?"0":request.getParameter("salid").toString();
String salesman=request.getParameter("salesman")==null?"":request.getParameter("salesman").toString();  
%>
<script type="text/javascript">
var mod1='<%=mod%>';
var modes='<%=modes%>';
var masterdoc='<%=docno%>';
var enqdocno='<%=enqdocno%>';
var brhid='<%=brhid%>';
 $(document).ready(function () {
	
     /* Formatted jqxDateTimeInput heights to match modern UI 24px */
   	 $("#EnquiryDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});    
     
     /* force internal alignment AFTER render */
     setTimeout(function () {
         $("#EnquiryDate").find("input").css({
             "margin-top": "0px",
             "line-height": "24px",
             "font-size": "12px", 
             "font-family": "Arial, sans-serif", 
             "padding": "0 6px", 
             "box-sizing":"border-box"
         });
         $("#EnquiryDate").find(".jqx-action-button").css({
             "top": "0px",
             "height": "24px"
         });
     }, 0);

   	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 200, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 
     $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
     $('#clientsearch1').jqxWindow('close');
     $('#salesManDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Salesman Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#salesManDetailsWindow').jqxWindow('close');
     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
     $('#sourcesearchwndow').jqxWindow('close');
     $('#cpinfowindow').jqxWindow({ width: '35%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
     $('#cpinfowindow').jqxWindow('close');
     $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
 	$('#areainfowindow').jqxWindow('close');
 	
  	$('#surveytypewindow').jqxWindow({ width: '35%', height: '45%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 300, y: 87 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#surveytypewindow').jqxWindow('close'); 
    $('#cmbclient').dblclick(function(){
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
		
		if(clientid==""){
			document.getElementById("errormsg").innerText=" Select Client";
			return 0;
		}
    	
    	$('#cpinfowindow').jqxWindow('open');
    	cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid, $('#cpinfowindow'));  
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
			$("#jqxEnquiry").jqxGrid({ disabled: false});
			 document.getElementById("txtradio").value="2";
			// $('#hidradio').val('AMC');
			   document.getElementById("errormsg").innerText="";
			$("#btnnewclient").show();
			
	});
 
 
 function getcontact(event){
	  	
		var clientid=document.getElementById("cmbclient").value;
		
		if(clientid==""){
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
	 	 $.get(url).done(function (data) {
		$('#cpinfowindow').jqxWindow('setContent', data);

	               	}); 
	     	}
	     	

 
          function brandinfoSearchContent(url) {
      		 $.get(url).done(function (data) {
      			 
      			 $('#brandsearchwndow').jqxWindow('open');
      		$('#brandsearchwndow').jqxWindow('setContent', data);
      
      	}); 
      	} 
          function modelinfoSearchContent(url) {
           		 $.get(url).done(function (data) {
           			 
           			 $('#modelsearchwndow').jqxWindow('open');
           		$('#modelsearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	} 
          function sourceinfoSearchContent(url) {
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
		//$('#frmEnquiry')[0].reset(); 
	}
	function funReadOnly(){
	;
		$('#frmEnquiry input').prop('readonly', true );
		
		$('#frmEnquiry textarea').attr('readonly', true );
		$('#frmEnquiry select').attr('disabled', true);
		$('#btnnewclient').attr('disabled', true);
		 $("#siteGrid").jqxGrid({ disabled: true});
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
		   
		}
		if(mod1=="A")
		{
	    
	    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
		funCreateBtn();
		
		
		}
	
	}
	function funRemoveReadOnly(){
		
		$('#frmEnquiry input').attr('readonly', false );
		$('#frmEnquiry textarea').attr('readonly', false );
		$('#frmEnquiry select').attr('disabled', false);
		$('#btnnewclient').attr('disabled', false);
		$('#txtsource').attr('readonly', true);
	 $("#siteGrid").jqxGrid({ disabled: false});
		$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
		$('#cmbprocess').attr('disabled', false);
		$("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		
		if ($("#mode").val() == "A") {    
			$('#hidradio').val('<%=dtype%>');
			document.getElementById("c1").checked=true;
			//getsjobtype();
			 $('#EnquiryDate').val(new Date());
		     $("#jqxEnquiry").jqxGrid('clear');
		    $("#jqxEnquiry").jqxGrid('addrow', null, {});
		    $("#siteGrid").jqxGrid('clear');
			$("#siteGrid").jqxGrid('addrow', null, {});
		   }
		 
		   if (mod1 == "A") {
			 document.getElementById("txtsalesman").value='<%=salesman%>';
			 document.getElementById("txtsalesmandocno").value='<%=salid%>';  
		     document.getElementById("cmbclient").value='<%=cldocno%>';
	         document.getElementById("txtclientname").value='<%=client%>';
	         document.getElementById("txtcontact").value='<%=cperson%>';
	         document.getElementById("proname").value='<%=proname%>';
	         <%-- document.getElementById("txtRemarks").value='<%=desc%>'; --%>
	         document.getElementById("cpersonid").value='<%=cpersonid%>';
	         document.getElementById("hidtrno").value='<%=trno%>';
	        
		   }
		
		if ($("#mode").val() == "E") {
			 $("#jqxEnquiry").jqxGrid('addrow', null, {});
			
		}
	
		$('#txtsource').attr('readonly', true );
		$('#txtclientname').attr('readonly', true );
		
		
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
			             
			      		if(rdo=='AMC'){
			      			document.getElementById("c1").checked=true;
			      			
			      		}
			      		if(rdo=='SJOB'){
			      			document.getElementById("c2").checked=true;
			      			if(sjobtype>0){
			         			 document.getElementById("hidcmbprocess").value=sjobtype;
			         			}
			      		}
			      
			        	$('#EnquiryDate').jqxDateTimeInput({ disabled: false});
			     	
			         document.getElementById("frmEnquiry").submit();
			 
			 	 
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
		
		
		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
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
   	            
		   }
	//site grid
	
		   var rowsite = $("#siteGrid").jqxGrid('getrows');
		
		        if(rowsite[0].site==""||rowsite[0].site=="0"||typeof(rowsite[0].site)=="undefined"||typeof(rowsite[0].site)=="NaN")
  		
				{
				document.getElementById("errormsg").innerText="Enter Site Details";  
		    	return 0;
				}
	 	
	 
	
	
		 var rows = $("#jqxEnquiry").jqxGrid('getrows');
		    $('#enqgridlenght').val(rows.length);
		  
		   for(var i=0 ; i < rows.length ; i++){
		
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "enqtest"+i)
		       .attr("name", "enqtest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].descritpion+" :: "+rows[i].qty+" :: "+rows[i].remarks+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		   
		   
		   var rowssitegrid = $("#siteGrid").jqxGrid('getrows');
		  var len=0;   
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
		   len++;     
				}
		   }   
		   $('#siteGridlength').val(len);    
		return 1;
	} 

	function funChkButton() {
		
		//frmEnquiry.submit();
	}

	function funSearchLoad(){
		 changeContent('enqMastersearch.jsp'); 
	}
     $(function(){
        $('#frmEnquiry').validate({
                rules: { 
                txtclientname:{"required":true},
                txtmobile:{number:true,maxlength:12,minlength:12},
                txttelno:{number:true,maxlength:15},
             //   txtemail:"",
                txtaddress: {maxlength:200},
                txtRemarks:{maxlength:200}
                 },
                 messages: {
                 txtRemarks: {maxlength:" Max 200 chars"},
                 txtclientname: {required:" *required"},
                 txtaddress: {maxlength:" Max 200 chars"},
                 txtmobile:{number:" Invalid MOB NO",maxlength:" Max 12 chars",minlength:" Minimum 12 chars" },
                 txttelno:{number:" Invalid Tel No",maxlength:" Max 15 chars" },
              //   txtemail:" *Enter Valid Email",
              
                 }
        });});    
    
		
	function funFocus(){
		 
	}
	function reqdata()
	{
	}
	
	
	function chkChange()
    {
  	 	$("#cmbclient").show();
  		$("#btnnewclient").show(); 
  	    $('#frmEnquiry input').attr('readonly', true );
		$('#frmEnquiry textarea').attr('readonly', true );
        $('#docno').attr('readonly', true);
    } 
	
	
	 function disfields()
	 {
		 $('#docno').attr('readonly', true);
		 $('#cmbclient').attr('readonly', true );
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
	 
	 
	function setValues() {
		  document.getElementById("formdetail").value="Enquiry";
	   		document.getElementById("formdetailcode").value="ENQ"; 
	   	 var chksurvey=document.getElementById("hidsurvey").value;
			
			if(chksurvey>0){
				document.getElementById("chksurvey").checked=true;
			}
			else{
				document.getElementById("chksurvey").checked=false;
			}
		if($('#hidEnquiryDate').val()){
			$("#EnquiryDate").jqxDateTimeInput('val', $('#hidEnquiryDate').val());
		}
		var rdo=document.getElementById("hidradio").value;
		
		if(rdo=='AMC'){
			document.getElementById("c1").checked=true;
			
		}
		if(rdo=='SJOB'){
			document.getElementById("c2").checked=true;
			
		}
		if(document.getElementById("hidenqedit").value=="1"){
		    $('#btnEdit').attr('disabled', true );
	  } else {
		    $('#btnEdit').attr('disabled', false );
	  } 
  	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
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
    	
    	if(document.getElementById("c1").checked==true)
    		{
    		
    		 document.getElementById("hidradio").value="AMC";
    		
    		 document.getElementById("hidcmbprocess").value=0;
    		
    		}
    	else
    		{
    		 document.getElementById("hidradio").value="SJOB";
    		}
    }
	
</script>
</head>
<body onload="setValues();getsjobtype();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmEnquiry" action="saveEnquirynew" autocomplete="OFF" method="POST">   
        <jsp:include page="../../../../header.jsp"></jsp:include>
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Customer Enquiry</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id='EnquiryDate' name='EnquiryDate' value='<s:property value="EnquiryDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidEnquiryDate" name="hidEnquiryDate" value='<s:property value="hidEnquiryDate"/>'/>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">User Name</label>
                    <input type="text" style="width:150px; background-color:#f8f9fa;" value="<%=session.getAttribute("USERNAME")%>" tabindex="-1" readonly/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" id="docno" name="docno" style="width:125px;" tabindex="-1" value='<s:property value="docno"/>' onfocus="disfields();"/>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Client</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="cmbclient" name="cmbclient" placeholder="Press F3" value='<s:property value="cmbclient"/>' onKeyDown="getclinfo(event);" onfocus="disfields();">
                        <svg class="magnifier-icon" onclick="$('#cmbclient').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="txtclientname" name="txtclientname" style="flex:1; margin-left:8px;" value='<s:property value="txtclientname"/>' onfocus="reqdata();disfields();">
                    <button type="button" id="btnnewclient" class="myButton" onclick="text();" style="margin-left: 15px;">Create new Client</button>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Contact person</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtcontact" name="txtcontact" placeholder="Press F3" value='<s:property value="txtcontact"/>' onKeyDown="getcontact(event);">
                        <svg class="magnifier-icon" onclick="$('#txtcontact').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Salesman</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txtsalesman" name="sal_name" placeholder="Press F3" value='<s:property value="sal_name"/>' onKeyDown="getsalinfo(event);" onfocus="disfields();">
                        <svg class="magnifier-icon" onclick="$('#txtsalesman').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtsalesmandocno" name="sal_id" value='<s:property value="sal_id"/>'>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Address</label>
                    <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>' onfocus="reqdata();disfields();">
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">MOB</label>
                    <input type="text" id="txtmobile" name="txtmobile" style="width:125px;" value='<s:property value="txtmobile"/>' onfocus="reqdata();disfields();">
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Tel</label>
                    <input type="text" id="txttelno" name="txttelno" style="width:125px;" value='<s:property value="txttelno"/>' onfocus="reqdata();disfields();">
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Email</label>
                    <input type="email" id="txtemail" name="txtemail" style="flex:1;" value='<s:property value="txtemail"/>' onfocus="reqdata();disfields();">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Classification & Remarks</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Contract Type</label>
                    <div style="display:flex; align-items:center; gap: 15px; width:125px;">
                        <label style="display:flex; align-items:center; gap:4px; font-size:12px;">
                            <input type="radio" id="c1" name="cnt" value="AMC" onchange="getsjobtype();" onClick="getsjobtype();jobChange();" style="margin:0;"> AMC
                        </label>
                        <label style="display:flex; align-items:center; gap:4px; font-size:12px;">
                            <input type="radio" id="c2" name="cnt" value="SJOB" onchange="getsjobtype();" onClick="getsjobtype();jobChange();" style="margin:0;"> SJOB
                        </label>
                    </div>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Type</label>
                    <select name="cmbprocess" id="cmbprocess" style="width:150px;" onchange="funtxtenable(value);" value='<s:property value="cmbprocess"/>'></select>
                    <input type="hidden" name="hidcmbprocess" id="hidcmbprocess" value='<s:property value="hidcmbprocess"/>' /> 
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Source</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txtsource" name="txtsource" readonly placeholder="Press F3" onKeyDown="getSource(event);" value='<s:property value="txtsource"/>'>
                        <svg class="magnifier-icon" onclick="$('#txtsource').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label style="display:flex; align-items:center; gap:4px; font-size:12px; margin-left:15px;">
                        <input type="checkbox" name="chksurvey" id="chksurvey" value='<s:property value="chksurvey"/>' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="margin:0;"> Surveyed
                    </label>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Remarks</label>
                    <input type="text" id="txtRemarks" name="txtRemarks" style="flex:1;" value='<s:property value="txtRemarks"/>' onfocus="reqdata();disfields();">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Site Details</span>
                <div id="sitediv" class="grid-container" style="border: none;">
                    <jsp:include page="siteGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Enquiry Details</span>
                <div id="enqdiv" class="grid-container" style="border: none;">
                    <jsp:include page="enquiryDetails.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
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
                <input type="hidden" id="hidradio" name="hidradio"  value='<s:property value="hidradio"/>'/>
                <input type="hidden" id="hidsurvey" name="hidsurvey"  value='<s:property value="hidsurvey"/>'/>
                <input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 
                <input type="hidden" name="proname" id="proname" value='<s:property value="proname"/>' />
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
                <input type="hidden" id="hidenqedit" name="hidenqedit"  value='<s:property value="hidenqedit"/>'/> 
                <input type="hidden" id="hidtrno" name="hidtrno"  value='<s:property value="hidtrno"/>'/> 
            </div>

        </div>
    </form>

    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="sourcesearchwndow">
       <div></div><div></div>
    </div>
    <div id="modelsearchwndow">
       <div></div><div></div>
    </div>
    <div id="brandsearchwndow">
       <div></div><div></div>
    </div>
    <div id="clientsearch1">
       <div></div><div></div>
    </div>
    <div id="salesManDetailsWindow">
       <div></div><div></div>
    </div>
    <div id="cpinfowindow">
       <div></div><div></div>
    </div>
    <div id="areainfowindow">
       <div></div><div></div>
    </div>
    <div id="surveytypewindow">
       <div></div><div></div>
    </div>
</div>  
</body>
</html>