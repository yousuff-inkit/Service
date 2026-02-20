<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<style>
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
input[type="text"],
select {
    width: 100%;
    height: 28px !important;   /* Slightly smaller */
    padding: 6px 10px;
    font-size: 13px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    box-sizing: border-box;
    background-color: #ffffff;
}

</style>
  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 
	 
	
	     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("body").prepend('<div id="overlaysub" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWaitsub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#fieldexpdocmnt').hide();
	     $('#chkvalue').val("1");
	/*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
	/*  $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); */
	 $("#expfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#exptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#expupdatefromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	 $("#expupdatetodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
/* 	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
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
	 }); */
	 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
	 fundisable();
	 $('#uptodate').hide();
	 $('#uptodatelbl').hide();
	
});

function funreload(event)
{
	/* var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate')); */
// out date
	 /* var todates=new Date($('#todate').jqxDateTimeInput('getDate'));  */
 /* if(fromdates>todates){
	   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
	 
 return false;
}  */
	 var barchval = document.getElementById("cmbbranch").value;
     /* var fromdate= $("#fromdate").val(); */
	/*  var todate= $("#todate").val(); */
	 var uptodate= $("#uptodate").val();
	 var chk_val= $('#chkvalue').val();
  $("#overlaysub, #PleaseWaitsub").show();
 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val+"&uptodate="+uptodate);
  fundisable();
	}
	

function funchangeinfo()
{
	
	 $('#date').jqxDateTimeInput( 'focus');
	
	}
function fundisable(){
	$('#datadelete').attr('disabled',true);  
	$('#dataupdate').attr('disabled',true);
	$('#update').attr('disabled',true);
	$('#txtdocnameupd').val("");
	$('#txtdescupd').val("");
	$('#txtnoteupd').val("");
	$('#txtdocnameupd').attr('disabled',true);
	$('#txtdescupd').attr('disabled',true);
	$('#expupdatefromdate').jqxDateTimeInput({disabled:true});
	$('#expupdatetodate').jqxDateTimeInput('disabled',true);
	$('#txtnoteupd').attr('disabled',true);
	 
	
}
function funchkval(){
	 if (document.getElementById('chknew').checked) {
		 $('#uptodate').hide();
		 $('#uptodatelbl').hide();
		 $('#fieldnewdocmnt').show();
		 $('#fieldupdatedocmnt').show();
		 $('#fieldexpdocmnt').hide();
		 $('#chkvalue').val("1");
		 $('#docCntrlRegId').jqxGrid('clear');
		 $('#txtdocnameupd').val("");
			$('#txtdescupd').val("");
			$('#txtnoteupd').val("");
			$('#txtdocnameupd').attr('disabled',true);
			$('#txtdescupd').attr('disabled',true);
			$('#expupdatefromdate').jqxDateTimeInput({disabled:true});
			$('#expupdatetodate').jqxDateTimeInput('disabled',true);
			$('#uptodate').jqxDateTimeInput('disabled',false);
			 $('#uptodate').jqxDateTimeInput({disabled:true});
			$('#txtnoteupd').attr('disabled',true);
			$('#update').attr('disabled',true);
			$('#dataupdate').attr('disabled',true); 
			$('#datadelete').attr('disabled',true);
	 	}
	 else if (document.getElementById('chkexpd').checked) {
		 $('#uptodate').show();
		 $('#uptodatelbl').show();
		 $('#uptodate').jqxDateTimeInput({disabled:false});
		 $('#fieldnewdocmnt').hide();
		 $('#fieldupdatedocmnt').hide();
		 $('#fieldexpdocmnt').show();
		 $('#chkvalue').val("2");
		 $('#docCntrlRegId').jqxGrid('clear');
	 }
	 }
	 
function funupdate(){
	 var date=$('#date').val();
	 var docno=$('#hidocno').val();
	 
	  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 updatedata(docno,date);	
	     	}
		     });
	
	
	
}
function updatedata(docno,date)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 if(items==1){		
			 
			  $('#date').val(new Date());
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
				  var barchval = document.getElementById("cmbbranch").value;
				     /* var fromdate= $("#fromdate").val(); */
					/*  var todate= $("#todate").val(); */
					 var chk_val= $('#chkvalue').val();
				  $("#overlaysub, #PleaseWaitsub").show();
				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
				  
		 		 
			     
		     });
			 funreload(event); 
			 fundisable();
			 }
			}
	}
		
x.open("GET","savedata.jsp?docno="+docno+"&date="+date+"&op=2",true);

x.send();
		
}

 function funupdatedata(){     
	 if(document.getElementById("txtdocnameupd").value=="")
	 {
		 $.messager.alert('Message','Enter Doc.Name ','warning');   
		 return 0;
	 } 
	 if($('#txtdescupd').val()=="") 
	 {
		 $.messager.alert('Message','Enter Description ','warning');   
		 return 0;
	 }
	 var desc = document.getElementById("txtdescupd").value;
	 var nmax = desc.length;
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Description cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   } 
      if($('#txtnoteupd').val()=="") 
 	 {
 		 $.messager.alert('Message','Enter Note ','warning');   
 		 return 0;
 	 }
 	 var note =document.getElementById("txtnoteupd").value;
 	 var nmax1 =note.length;
       if(nmax1>99)
    	   {
    	  $.messager.alert('Message',' Note cannot contain more than 100 characters ','warning');   
    	
 			return false; 
    	   } 
      
       /* var expfromdates=$('#expfromdate').val();
	   var exptodates=$('#exptodate').val(); */
	   var expupfromdates1=new Date($('#expupdatefromdate').jqxDateTimeInput('getDate'));
	   var expuptodates1=new Date($('#expupdatetodate').jqxDateTimeInput('getDate'));
	   if(expupfromdates1>expuptodates1){
			   
			   $.messager.alert('Message','Issue Date Less Than Exp.From Date  ','warning');   
			 
		   return false;
		  } 
	   $('#expupdatetodate').on('change', function (event) {
		    
		      var fdate=new Date($('#expupdatetodate').jqxDateTimeInput('getDate'));
		      var curdate=new Date(); 
		      fdate.setHours(0,0,0,0);
		      curdate.setHours(0,0,0,0);
		      if(fdate<curdate){
		       
		       $.messager.alert('Message','Select Future Date','warning');   
		       $('#expupdatetodate').jqxDateTimeInput('setDate', new Date());
		     
		      return false;
		     } 
	   });     
     var doc_name=document.getElementById("txtdocnameupd").value;
	 var desc=document.getElementById("txtdescupd").value;
	 var note=document.getElementById("txtnoteupd").value;
	 var brchid=<%=session.getAttribute("BRANCHID")%>;
	 var userid=<%=session.getAttribute("USERID")%>;
	 var expupfromdates=$('#expupdatefromdate').val();
	 var expuptodates=$('#expupdatetodate').val();
	 var op="3";
	 var docno=$('#hidocno').val();
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		updatedata1(doc_name,desc,note,expupfromdates,expuptodates,brchid,userid,docno,op);	
	     	}
		     });
	
	
	
}
 function updatedata1(doc_name,desc,note,expfromdates,exptodates,brchid,userid,docno,op)
 {
 	
 	var x=new XMLHttpRequest();
 	x.onreadystatechange=function(){
 	if (x.readyState==4 && x.status==200)
 		{
 		
      			
 			var items=x.responseText;
 			 if(items==1){
 			 document.getElementById("txtdocname").value="";
 			 document.getElementById("txtdesc").value="";
 			 document.getElementById("txtnote").value="";
 			
 			 
 			  $('#date').val(new Date());
 			  $.messager.alert('Message', '  Record Successfully Updated', function(r){
 				  var barchval = document.getElementById("cmbbranch").value;
 				     /* var fromdate= $("#fromdate").val(); */
 					/*  var todate= $("#todate").val(); */
 					 var chk_val= $('#chkvalue').val();
 				  $("#overlaysub, #PleaseWaitsub").show();
 				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
 		     });
 			 fundisable();
 			 funreload(event); 
 			 }
 			}
 	}
 		
 x.open("GET","savedata.jsp?doc_name="+doc_name+"&desc="+desc+"&note="+note+"&expfromdates="+expfromdates+"&exptodates="+exptodates+"&brchid="+brchid+"&userid="+userid+"&op="+op+"&docno="+docno,true);

 x.send();
 		
 }	 
 
function funsave()
{
	
	  if(document.getElementById("txtdocname").value=="")
	 {
		 $.messager.alert('Message','Enter Doc.Name ','warning');   
		 return 0;
	 } 
	 if($('#txtdesc').val()=="") 
	 {
		 $.messager.alert('Message','Enter Description ','warning');   
		 return 0;
	 }
	 var desc = document.getElementById("txtdesc").value;
	 var nmax = desc.length;
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Description cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   } 
      if($('#txtnote').val()=="") 
 	 {
 		 $.messager.alert('Message','Enter Note ','warning');   
 		 return 0;
 	 }
 	 var note =document.getElementById("txtnote").value;
 	 var nmax1 =note.length;
       if(nmax1>99)
    	   {
    	  $.messager.alert('Message',' Note cannot contain more than 100 characters ','warning');   
    	
 			return false; 
    	   } 
      
       /* var expfromdates=$('#expfromdate').val();
	   var exptodates=$('#exptodate').val(); */
	   var expfromdates1=new Date($('#expfromdate').jqxDateTimeInput('getDate'));
	   var exptodates1=new Date($('#exptodate').jqxDateTimeInput('getDate'));
	   if(expfromdates1>exptodates1){
			   
			   $.messager.alert('Message','Issue Date Less Than Exp.From Date  ','warning');   
			 
		   return false;
		  } 
	   $('#exptodate').on('change', function (event) {
		    
		      var fdate=new Date($('#exptodate').jqxDateTimeInput('getDate'));
		      var curdate=new Date(); 
		      fdate.setHours(0,0,0,0);
		      curdate.setHours(0,0,0,0);
		      if(fdate<curdate){
		       
		       $.messager.alert('Message','Select Future Date','warning');   
		       $('#exptodate').jqxDateTimeInput('setDate', new Date());
		     
		      return false;
		     } 
	   });     
     var doc_name=document.getElementById("txtdocname").value;
	 var desc=document.getElementById("txtdesc").value;
	 var note=document.getElementById("txtnote").value;
	 var brchid=<%=session.getAttribute("BRANCHID")%>;
	 var userid=<%=session.getAttribute("USERID")%>;
	 var expfromdates=$('#expfromdate').val();
	 var exptodates=$('#exptodate').val();
	 var op="1";
	  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savedata(doc_name,desc,note,expfromdates,exptodates,brchid,userid,op);	
	     	}
		     });
	
	
	
}
function savedata(doc_name,desc,note,expfromdates,exptodates,brchid,userid,op)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 if(items==1){
			 document.getElementById("txtdocname").value="";
			 document.getElementById("txtdesc").value="";
			 document.getElementById("txtnote").value="";
			
			 
			  $('#date').val(new Date());
			  $.messager.alert('Message', '  Record Successfully Saved', function(r){
				  var barchval = document.getElementById("cmbbranch").value;
				     /* var fromdate= $("#fromdate").val(); */
					 /* var todate= $("#todate").val(); */
					 var chk_val= $('#chkvalue').val();
				  $("#overlaysub, #PleaseWaitsub").show();
				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
				  
		 		 
			     
		     });
			 funreload(event); 
			 fundisable();
			 }
			}
	}
		
x.open("GET","savedata.jsp?doc_name="+doc_name+"&desc="+desc+"&note="+note+"&expfromdates="+expfromdates+"&exptodates="+exptodates+"&brchid="+brchid+"&userid="+userid+"&op="+op,true);
x.send();
}
function funExportBtn(){
	//JSONToCSVCon(documentntcontrolexcel, 'Document Control Register', true);
	$("#docmntControlReg").excelexportjs({
		containerid: "docmntControlReg",
		datatype: 'json',
		dataset: null,
		gridId: "docCntrlRegId",
		columns: getColumns("docCntrlRegId") ,
		worksheetName:"Document Control Register"
		});
}
function fundeletedata(){
	 var doc_name=document.getElementById("txtdocname").value;
	 var desc=document.getElementById("txtdesc").value;
	 var note=document.getElementById("txtnote").value;
	 var brchid=<%=session.getAttribute("BRANCHID")%>;
	 var userid=<%=session.getAttribute("USERID")%>;    
	 var expfromdates=$('#expfromdate').val();
	 var exptodates=$('#exptodate').val();
	 var op="4";
	 var docno=$('#hidocno').val();
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;
			 if(items==1){
			 document.getElementById("txtdocname").value="";
			 document.getElementById("txtdesc").value="";
			 document.getElementById("txtnote").value="";
			  $('#date').val(new Date());
			  $.messager.alert('Message', '  Record Successfully Deleted', function(r){
				  var barchval = document.getElementById("cmbbranch").value;
				     /* var fromdate= $("#fromdate").val(); */
					/*  var todate= $("#todate").val(); */
					 var chk_val= $('#chkvalue').val();
				  $("#overlaysub, #PleaseWaitsub").show();
				 $("#docmntControlReg").load("docmntControlRegGrid.jsp?branchval="+barchval+"&id=1"+"&chk_val="+chk_val);
		     });
			 fundisable();
			 funreload(event); 
			 }
			}
	}
x.open("GET","savedata.jsp?doc_name="+doc_name+"&desc="+desc+"&note="+note+"&expfromdates="+expfromdates+"&exptodates="+exptodates+"&brchid="+brchid+"&userid="+userid+"&op="+op+"&docno="+docno,true);
x.send();
}
</script>
</head>
<body onload="setval()">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Fixed Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <!-- Radio Section -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <input type="radio" name="chk"
                                       checked
                                       id="chknew"
                                       value="out"
                                       onchange="funchkval()">
                                <label>New Document</label>

                                &nbsp;&nbsp;

                                <input type="radio"
                                       name="chk"
                                       id="chkexpd"
                                       value="in"
                                       onchange="funchkval()">
                                <label>Expired Document</label>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Upto Date</td>
                            <td>
                                <div id="uptodate"
                                     value='<s:property value="uptodate"/>'>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>


                <!-- ================= NEW DOCUMENT ================= -->
                <div id="fieldnewdocmnt" class="filter-card">
                    <strong style="color:#1a3a5f;">New Document</strong>
                    <br><br>

                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Document Name</td>
                            <td><input type="text"
                                       id="txtdocname"
                                       name="txtdocname"
                                       value='<s:property value="txtdocname"/>'></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Description</td>
                            <td><input type="text"
                                       id="txtdesc"
                                       name="txtdesc"
                                       value='<s:property value="txtdesc"/>'></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Issue Date</td>
                            <td><div id="expfromdate"
                                     value='<s:property value="expfromdate"/>'></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Exp. Date</td>
                            <td><div id="exptodate"
                                     value='<s:property value="exptodate"/>'></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Notes</td>
                            <td><input type="text"
                                       id="txtnote"
                                       name="txtnote"
                                       value='<s:property value="txtnote"/>'></td>
                        </tr>

                    </table>

                    <button class="btn-submit"
                            type="button"
                            onclick="funsave();">
                        Save
                    </button>
                </div>


                <!-- ================= UPDATE DOCUMENT ================= -->
                <div id="fieldupdatedocmnt" class="filter-card">
                    <strong style="color:#1a3a5f;">Update Document</strong>
                    <br><br>

                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Document Name</td>
                            <td><input type="text"
                                       id="txtdocnameupd"
                                       name="txtdocnameupd"
                                       value='<s:property value="txtdocnameupd"/>'></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Description</td>
                            <td><input type="text"
                                       id="txtdescupd"
                                       name="txtdescupd"
                                       value='<s:property value="txtdescupd"/>'></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Notes</td>
                            <td><input type="text"
                                       id="txtnoteupd"
                                       name="txtnoteupd"
                                       value='<s:property value="txtnoteupd"/>'></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Issue Date</td>
                            <td><div id="expupdatefromdate"
                                     value='<s:property value="expupdatefromdate"/>'></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Exp. Date</td>
                            <td><div id="expupdatetodate"
                                     value='<s:property value="expupdatetodate"/>'></div></td>
                        </tr>

                    </table>

                    <button class="btn-submit"
                            type="button"
                            onclick="funupdatedata();">
                        Update
                    </button>

                    <button class="btn-submit"
                            type="button"
                            onclick="fundeletedata();">
                        Delete
                    </button>
                </div>


                <!-- ================= EXTEND EXP DATE ================= -->
                <div id="fieldexpdocmnt" class="filter-card">
                    <strong style="color:#1a3a5f;">Extend Exp. Date</strong>
                    <br><br>

                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Extend To</td>
                            <td>
                                <div id="date"
                                     value='<s:property value="date"/>'></div>
                            </td>
                        </tr>
                    </table>

                    <button class="btn-submit"
                            type="button"
                            onclick="funupdate();">
                        Update Exp. Date
                    </button>
                </div>


                <!-- Hidden Fields -->
                <input type="hidden"
                       name="hidocno"
                       id="hidocno"
                       value='<s:property value="hidocno"/>'>

                <input type="hidden"
                       name="chkvalue"
                       id="chkvalue"
                       value='<s:property value="chkvalue"/>'>

            </div>
        </div>
    </div>
</td>


<!-- ================= RIGHT GRID AREA ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="docmntControlReg">
                    <jsp:include page="docmntControlRegGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

</div>
</div>

</body>
</html>