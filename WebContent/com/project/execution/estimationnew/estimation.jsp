<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath(); %>

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
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String surdocno =request.getParameter("surdocno")==null?"0":request.getParameter("surdocno").toString();

String mod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String ref_type=request.getParameter("ref_type")==null?"0":request.getParameter("ref_type").toString();
String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
String reftrno=request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").toString();
String clientdet=request.getParameter("clientdet")==null?"0":request.getParameter("clientdet").toString();
String cpersonid=request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String cperson=request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
String cpersondet=request.getParameter("cpersondet")==null?"0":request.getParameter("cpersondet").toString();
%>

<script type="text/javascript">
var modes='<%=modes%>';
var masterdocno1='<%=surdocno%>';
var mod1='<%=mod%>';

	$(document).ready(function() {
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
  	    $("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' });
        
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#date").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#date").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);
  	  
  	$('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#enquirywindow').jqxWindow('close');
	
	$('#sertypesearchwindow').jqxWindow({ width: '35%', height: '45%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 300, y: 87 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#sertypesearchwindow').jqxWindow('close'); 
	    
	$('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#employeeDetailsWindow').jqxWindow('close');
    
    $('#areainfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	$('#areainfowindow').jqxWindow('close');
	
	$('#serviceinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	 $('#serviceinfowindow').jqxWindow('close');
	 
	 
	$('#txtenquiry').dblclick(function(){
		 changeContent('enqMastersearch.jsp');  
	});
	
	$('#txtsertype').dblclick(function(){
		 $('#sertypesearchwindow').jqxWindow('open');
	 	  refsearchContent('sertypeSearch.jsp');
	});
	
	$('#surveyedby').dblclick(function(){
		$('#employeeDetailsWindow').jqxWindow('open');
	   	 employeeSearchContent('employeeDetailsSearch.jsp');
	});
	
	});
	function funReadOnly() {
		$('#frmSurveydet input').attr('readonly', true);
		 $('#frmSurveydet input').attr('disabled', true);
		 $('#frmSurveydet select').attr('disabled', true);
		 $('#txtsertype').attr('readonly', true);
		 $('#date').jqxDateTimeInput({ disabled: true}); 
		 $("#serviceGrid").jqxGrid({ disabled: true});
		 $("#siteGrid").jqxGrid({ disabled: true});
		 $("#sertypeGrid").jqxGrid({ disabled: true});
		 if(modes=="view")
			{
			  document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				Setviewmode(masterdocno1);
			}
		 if(mod1=="A")
			{
			 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			 document.getElementById("formdetail").value=window.parent.formName.value;
			 document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			 funCreateBtn();
			}   
	}
	function funRemoveReadOnly() {
		$('#frmSurveydet input').attr('readonly', false);
		$('#frmSurveydet select').attr('disabled', false);
		$('#frmSurveydet input').attr('disabled', false);
		$('#docno').attr('readonly', true);
		$('#txtenquiry').attr('readonly', true);
		$('#txtcontact').attr('readonly', false);
		$('#contactnumber').attr('readonly', true);
		$('#surveyedby').attr('readonly', true);
		$('#txtsertype').attr('readonly', true);
		
		 $('#date').jqxDateTimeInput({ disabled: false}); 
		 $("#serviceGrid").jqxGrid({ disabled: false});
		 $("#siteGrid").jqxGrid({ disabled: false});
		 $("#sertypeGrid").jqxGrid({ disabled: false});
		 
		 if($('#mode').val()=='A'){
			 
			$("#serviceGrid").jqxGrid('clear');
			$("#serviceGrid").jqxGrid('addrow', null, {});
				
			$("#siteGrid").jqxGrid('clear');
			$("#siteGrid").jqxGrid('addrow', null, {});
					
		    $("#sertypeGrid").jqxGrid('clear');
			$("#sertypeGrid").jqxGrid('addrow', null, {});
						
			$("#servtypeDetailsGridID").jqxGrid('clear');
		 }
		 if(mod1=="A")
			{
				   document.getElementById("clientid").value= '<%=cldocno%>';
	               document.getElementById("txtclient").value='<%=client%>';
	               document.getElementById("txtclientdet").value='<%=clientdet%>';
				   document.getElementById("txtenquiry").value='<%=refdocno%>';
		           document.getElementById("enqdoc_no").value='<%=reftrno%>';
				   document.getElementById("cpersonid").value='<%=cpersonid%>';
		           document.getElementById("txtcontact").value='<%=cperson%>';
		           document.getElementById("contactnumber").value='<%=cpersondet%>'; 
		           var trno='<%=reftrno%>';   
		           $("#sitediv").load("siteGrid.jsp?trno="+trno+"&gridload=1");
				   
	        }
		 
	}
	function Setviewmode(masterdoc){
		
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	 items=items.split('###');
				 	 
				 	 $('#date').jqxDateTimeInput({ disabled: false}); 
				 	 $('#date').jqxDateTimeInput('val',items[0]);
			         document.getElementById("hiddate").value=items[0];
			         document.getElementById("masterdoc_no").value=items[1];
			         document.getElementById("docno").value=items[2];
			         document.getElementById("enqdoc_no").value=items[3];
			         document.getElementById("txtenquiry").value=items[4]; 
			         document.getElementById("txtclient").value=items[5];
			         document.getElementById("clientid").value=items[6];
			         document.getElementById("txtclientdet").value=items[7];
			         document.getElementById("txtcontact").value=items[8];
			         document.getElementById("cpersonid").value=items[9];
			         document.getElementById("contactnumber").value= items[10];
			         document.getElementById("surveyedby").value=items[11]; 
			         document.getElementById("empid").value=items[12];
			         document.getElementById("txtdesc").value=items[13];
			         document.getElementById("txtcontractr").value=items[14];
			         
			         var docno=$('#masterdoc_no').val();
			    	if(docno>0){
			 			$("#servtypeDetailsDiv").load("servtypeDetailsGrid.jsp?trno="+docno);
			 			 $("#sitediv").load("siteGrid.jsp?docno="+docno);
			 			 $("#servicediv").load("serviceGrid.jsp?docno="+docno);
			  			
			 		}
					
				 	 
					}
			       else
				  {}
		     }
		      x.open("GET","setViewMode.jsp?masterdoc="+masterdoc,true);
		     x.send();
		    
		   }
	function setValues() {
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		
		
		var docno=$('#masterdoc_no').val();
		var sid=$('#sertypeids').val();
		if(document.getElementById("hidsuredit").value=="1"){
		    $('#btnEdit').attr('disabled', true );
	  } else {
		    $('#btnEdit').attr('disabled', false );
	  } 
		if(docno>0){
			$("#servtypeDetailsDiv").load("servtypeDetailsGrid.jsp?trno="+docno);
			 $("#sitediv").load("siteGrid.jsp?docno="+docno);
			 $("#servicediv").load("serviceGrid.jsp?docno="+docno);
		}
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	function getemployee(event){
		var x= event.keyCode;
	 	 if(x==114){
		   
   	  $('#employeeDetailsWindow').jqxWindow('open');
   	 employeeSearchContent('employeeDetailsSearch.jsp'); 
          	 }
	}

	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

	 function funFocus()
	    {
	    	document.getElementById("txtenquiry").focus();
	    		
	    }
	 
	  function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	    
	 function getEnquiry(event){

			var x= event.keyCode;
		 	 if(x==114){
			   
		 		 changeContent('enqMastersearch.jsp');  
			
		    	 }
	}
		    	 
		function enquirySearchContent(url) {
			 $.get(url).done(function (data) {
			$('#enquirywindow').jqxWindow('setContent', data);
		           	}); 
		 	}
	 
	     	     
	    function funNotify(){
    	 
    	 
    	 var rows = $("#sertypeGrid").jqxGrid('getrows');
    	 var rows2 = $("#servtypeDetailsGridID").jqxGrid('selectedrowindexes');
		 var rows3 = $("#siteGrid").jqxGrid('getrows');
		 var rows4 = $("#serviceGrid").jqxGrid('getrows');
		
		 $('#sertypegridlen').val(rows.length);
		 $('#servtypdetgridlen').val(rows2.length);
		 $('#sitelen').val(rows3.length);
		 $('#servlen').val(rows4.length);
		 
		 
		   for(var i=0 ; i < rows.length ; i++){
					 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+i)
		       .attr("name", "test"+i)
		       .attr("hidden", "true"); 

		   newTextBox.val(rows[i].specid+" :: "+rows[i].details+" :: "+rows[i].desc1+" :: "+rows[i].servtypeid+" :: ");
					
		   newTextBox.appendTo('form');
		  
			}
		   
		   for(var i=0 ; i < rows2.length ; i++){
			   
			   var row = $("#servtypeDetailsGridID").jqxGrid('getrowdata', rows2[i]);
				
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "sertyp"+i)
			       .attr("name", "sertyp"+i)
			       .attr("hidden", "true"); 
			   newTextBox.val(row.doc_no+" :: ");
			   newTextBox.appendTo('form');
			  
					}
				
		   for(var i=0 ; i < rows3.length ; i++){
			   
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "site"+i)
			       .attr("name", "site"+i)
			       .attr("hidden", "true"); 
			 
			   newTextBox.val(rows3[i].site+" :: "+rows3[i].areaid+" :: ");
			   newTextBox.appendTo('form');
			  
					}
			
				
		   for(var i=0 ; i < rows4.length ; i++){
				
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "serv"+i)
			       .attr("name", "serv"+i)
			       .attr("hidden", "true"); 
			   newTextBox.val(rows4[i].serid+" :: ");
			   newTextBox.appendTo('form');
			  
					}
		
    		return 1;
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
	   
	   function getservice(rowBoundIndex){
	     	 
	    	  $('#serviceinfowindow').jqxWindow('open');
	              serviceSearchContent('service.jsp?rowBoundIndex='+rowBoundIndex);
	           	 }
	           	 
	   function serviceSearchContent(url) {
	    	 $.get(url).done(function (data) {
	   $('#serviceinfowindow').jqxWindow('setContent', data);

	                  	}); 
	        	}
	   
	   
	   function getsertype(event)
		 {
		  
		 	 var x= event.keyCode;
		 	 if(x==114){
		 	  $('#sertypesearchwindow').jqxWindow('open');
		 	
		 	  refsearchContent('sertypeSearch.jsp');  }
	}  
		 	
		 	  function refsearchContent(url) {
		    
		       $.get(url).done(function (data) {
		
		     $('#sertypesearchwindow').jqxWindow('setContent', data);

		 	}); 
		 	}
		 	  
		 	  function loadSubmit(){
		 		  
			 		 var docno=$("#masterdoc_no").val();
			 		 
			 		 if(docno>0){
			 			
			 			loadgridReload();
			 		 }
			 		 else{
			 			loadgrid();
			 		 }
			 		  
			 	  }
		 	  
		 	  function loadgrid(){
		 		  
			 		 var rows = $("#servtypeDetailsGridID").jqxGrid('selectedrowindexes');
			 		   var sid=0;
			 		    var loadid=1;
			 		    for (var m = 0; m < rows.length; m++) {
			 		        var row = $("#servtypeDetailsGridID").jqxGrid('getrowdata', rows[m]);
			 		       if(typeof(row.doc_no) != "undefined" && typeof(row.doc_no) != "NaN" && row.doc_no != ""){
				     	       sid=sid+row.doc_no+",";
				     	      
			 		       }
			 		       	}
			 		  document.getElementById("sertypeids").value=sid;
			 		 $("#sertypeDiv").load("ServiceTypeGrid.jsp?sid="+sid+"&gridload=1");
			 	  }
			 	  
			 	 function loadgridReload(){
			 		  
			 		 var rows = $("#servtypeDetailsGridID").jqxGrid('selectedrowindexes');
			 		   var sid=0;
			 		    var loadid=2;
			 		    for (var m = 0; m < rows.length; m++) {
			 		        var row = $("#servtypeDetailsGridID").jqxGrid('getrowdata', rows[m]);
			 		       if(typeof(row.doc_no) != "undefined" && typeof(row.doc_no) != "NaN" && row.doc_no != ""){
				     	       sid=sid+row.doc_no+",";
				     	     
			 		       }
			 		       	}
			 		  document.getElementById("sertypeids").value=sid;
			 		  if(typeof(sid) != "undefined" && typeof(sid) != "NaN" && sid != ""){
			 			 var docno=$("#masterdoc_no").val();
			 		   
			 			$("#sertypeDiv").load("ServiceTypeGrid.jsp?docno="+docno+"&sid="+sid);	 
			 		
			 		  }
			 		  
			 	  }
			 	 
			 	 
			 	 
				  function funPrintBtn() {
						if (($("#mode").val() == "view") && $("#docno").val()!="") {

							 $("#docno").prop("disabled", false);
							 $("#masterdoc_no").prop("disabled", false);
							 $("#formdetailcode").prop("disabled", false);
							 
							var docno=$('#docno').val();
					  		var trno=$('#masterdoc_no').val();
					  		var dtype=$('#formdetailcode').val();
					  		var sertypeids=$('#sertypeids').val();
					  	  var brhid=document.getElementById("brchName").value
					  		
					  		var url=document.URL;
					  		var reurl=url.split("com/"); 
					     
					  		 var win= window.open(reurl[0]+"printSurvey?docno="+docno+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype+"&sertypeids="+sertypeids+"&header=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
					     }
					    else {
							$.messager.alert('Message','Select a Document....!','warning');
							return;
						}
			    }			 	 
			 	 
</script>
 </head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmSurveydetails" action="saveSurveydetails" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Survey Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date" />'></div>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Enquiry No</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" onKeyDown="getEnquiry(event);" name="txtenquiry" placeholder="Press F3" value='<s:property value="txtenquiry" />' id="txtenquiry">
                        <svg class="magnifier-icon" onclick="$('#txtenquiry').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No</label>
                    <input type="text" name="docno" value='<s:property value="docno" />' id="docno" style="width:125px;" tabindex="-1" readonly>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Client</label>
                    <input type="text" name="txtclient" id="txtclient" style="width:125px;" value='<s:property value="txtclient" />'>
                    
                    <input type="text" name="txtclientdet" id="txtclientdet" style="flex:1; margin-left:15px;" value='<s:property value="txtclientdet" />'>
                    
                    <label class="lbl-right" style="width:120px; margin-left:15px;">Existing Contractor</label>
                    <input type="text" name="txtcontractr" id="txtcontractr" style="width:125px;" value='<s:property value="txtcontractr" />'>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Contact Person</label>
                    <input type="text" name="txtcontact" id="txtcontact" style="width:125px;" value='<s:property value="txtcontact" />'>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Contact Number</label>
                    <input type="text" name="contactnumber" id="contactnumber" style="flex:1;" value='<s:property value="contactnumber" />'>
                    
                    <label class="lbl-right" style="width:100px; margin-left:15px;">Surveyed By</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="surveyedby" id="surveyedby" onKeyDown="getemployee(event);" placeholder="Press F3" value='<s:property value="surveyedby" />'>
                        <svg class="magnifier-icon" onclick="$('#surveyedby').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Description</label>
                    <input type="text" name="txtdesc" id="txtdesc" value='<s:property value="txtdesc" />' style="flex:1;">
                </div>
            </div>

            <div style="display: flex; gap: 15px; align-items: flex-start;">
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Site Details</span>
                    <div id="sitediv" class="grid-container" style="border:none;">
                        <jsp:include page="siteGrid.jsp"></jsp:include>
                    </div>
                </div>
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Service Details</span>
                    <div id="servicediv" class="grid-container" style="border:none;">
                        <jsp:include page="serviceGrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>

            <div style="display: flex; gap: 15px; align-items: flex-start; margin-top:15px;">
                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Service Type Details</span>
                    
                    <div class="field-row">
                        <label class="lbl-right" style="width:80px;">Service Type</label>
                        <div class="input-search-container" style="flex:1;">
                            <input type="text" id="txtsertype" name="txtsertype" placeholder="Press F3" value='<s:property value="txtsertype"/>' onkeydown="getsertype(event);"/>
                            <svg class="magnifier-icon" onclick="$('#txtsertype').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="hidden" id="txtsertypeid" name="txtsertypeid" value='<s:property value="txtsertypeid"/>'/>
                    </div>
                    
                    <div id="servtypeDetailsDiv" class="grid-container" style="border:none; margin-top:10px;">
                        <jsp:include page="servtypeDetailsGrid.jsp"></jsp:include>
                    </div>
                    
                    <div class="field-row" style="justify-content: center; margin-top:10px; margin-bottom:0;">
                        <input type="button" class="myButton" name="btnLoad" id="btnLoad" value="Submit" onclick="loadSubmit();">
                    </div>
                </div>

                <div class="middle-panel" style="flex: 3; margin-bottom: 0; min-height: 250px;">
                    <span class="middle-panel-title">Service Type Grid</span>
                    <div id="sertypeDiv" class="grid-container" style="border:none; height: 100%;">
                        <jsp:include page="ServiceTypeGrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
                <input type="hidden" id="cpersonid" name="cpersonid" value='<s:property value="cpersonid"/>'/>
                <input type="hidden" id="sertypeids" name="sertypeids" value='<s:property value="sertypeids"/>'/>
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
                <input type="hidden" id="enqdoc_no" name="enqdoc_no" value='<s:property value="enqdoc_no"/>'/>
                <input type="hidden" id="empid" name="empid" value='<s:property value="empid"/>'/>
                <input type="hidden" id="sertypegridlen" name="sertypegridlen" value='<s:property value="sertypegridlen"/>'/>
                <input type="hidden" id="servtypdetgridlen" name="servtypdetgridlen" value='<s:property value="servtypdetgridlen"/>'/>
                <input type="hidden" id="servlen" name="servlen" value='<s:property value="servlen"/>'/>
                <input type="hidden" id="sitelen" name="sitelen" value='<s:property value="sitelen"/>'/>
                <input type="hidden" id="hidsuredit" name="hidsuredit" value='<s:property value="hidsuredit"/>'/>
            </div>
            
        </div>
    </form>

    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="enquirywindow"><div></div><div></div></div>
    <div id="employeeDetailsWindow"><div></div><div></div></div>
    <div id="areainfowindow"><div></div><div></div></div>
    <div id="serviceinfowindow"><div></div><div></div></div> 
    <div id="sertypesearchwindow"><div></div><div></div></div>     
</div>
</body>
</html>