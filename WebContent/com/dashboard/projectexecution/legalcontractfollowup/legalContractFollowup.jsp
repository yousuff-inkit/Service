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
<style>
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}
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


.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}


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
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

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

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		  $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});	
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		  
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	});
	
	
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
					+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	
  
	
	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		 $('#btnattachments').attr("disabled",true);
		 $('#legno').attr("disabled",true);
		 $("#followUpDetailsGrid").jqxGrid('clear');
		 $("#followUpDetailsGrid").jqxGrid("addrow", null, {}); 
		 $("#followUpDetailsGrid").jqxGrid({ disabled: true});
	}
	
	
	function funreload(event){
	 	disable();
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var followupdate = $('#followupdate').val(); 
		 var chkfollowup = $('#hidchckfollowup').val();
		
		 $("#overlay, #PleaseWait").show();
		 
		 $("#legalContractFollowupDiv").load("legalContractFollowupGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate);
		}
	
	function funUpdate(event){
		var pro= $('#cmbprocess').val().split(":");
		var bibid=pro[0].trim();
		var proname=pro[1].trim();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var remarks = $('#txtremarks').val();
		var docno = $('#txtdocno').val();
		var rdtype = $('#conttype').val();
		var legcontno = $('#legno').val();
		
		if(bibid==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }

		 if(proname==("Submit") && legcontno=='')
			{
			 $.messager.alert('Message','Please Enter Legal Contract No.','warning');   
			 return 0;
			}
		 
		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks,legcontno);	
		     	}
		});
	}
	
	function followupcheck(){
		 if(document.getElementById("chckfollowup").checked){
			 document.getElementById("hidchckfollowup").value = 1;
			 $('#followupdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfollowup").value = 0;
			 $('#followupdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
		
   
	    
	function saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks,legcontno){

		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				if(parseInt(items)=="1")
				{	
				$('#cmbprocess').val('');
				$('#date').val(new Date());
				$('#txtbranch').val('');
				$('#txtremarks').val('');
				$('#txtdocno').val('');
				$('#contno').val('');
				$('#conttype').val('');
				$('#legno').val('');
				$("#followUpDetailsGrid").jqxGrid('clear'); 
				funreload(event)
				$.messager.alert('Message', '  Record Successfully Updated ');  
			//	funreload(event); 
				disable();
				}
				else
				{
				$.messager.alert('Message', '  Not Updated  ');
				}
				}
		}
			
	x.open("GET","saveData.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks+"&legcontno="+legcontno,true);
	x.send();
			
	}
	
	function funtxtenable()
	{
		$('#legno').val('');
		$('#legno').attr("disabled",true);
		var pro= $('#cmbprocess').val().split(":");
		//var bibid=pro[0];
		var proname=pro[1].trim();
		
		if(proname==("Submit"))
			{
			$('#legno').attr("disabled",false);
			}
	}
	
	
	
	function funExportBtn(){
		/* JSONToCSVCon(legalcontfolwuptexcel, 'Legal Contract Followup', true); */
		$("#legalContractFollowupDiv").excelexportjs({
			containerid: "legalContractFollowupDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "jqxloaddataGrid", 
			columns: getColumns("jqxloaddataGrid") , 
			worksheetName:"Legal Contract Followup"
			});
		   }
	
	function funAttachments(){
    	
  		if ($("#contno").val()!="") {

  			var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+document.getElementById("conttype").value
					 +"&docno="+document.getElementById("contno").value+"&brchid="+document.getElementById("cmbbranch").value+"&frmname="+document.getElementById("lbldetailname").innerText,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					  myWindow.focus();
		
		} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
  }
</script>
</head>
<body onload="getBranch();getProcess();disable();followupcheck();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

<!-- ===== Fixed Header ===== -->
<div class="sidebar-fixed-top">
    <div class="filter-card">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>
</div>

<!-- ===== Scrollable Section ===== -->
<div class="sidebar-scroll-content">

<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Up To</td>
<td>
    <div id="uptodate"
         value='<s:property value="uptodate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">FollowUp</td>
<td>
    <input type="checkbox"
           id="chckfollowup"
           name="chckfollowup"
           onchange="followupcheck();"
           onclick="$(this).attr('value', this.checked ? 1 : 0)">
    <input type="hidden"
           id="hidchckfollowup"
           name="hidchckfollowup"
           value='<s:property value="hidchckfollowup"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">FollowUp Date</td>
<td>
    <div id="followupdate"
         value='<s:property value="followupdate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">Contract No.</td>
<td>
    <input type="text"
           id="contno"
           name="contno"
           class="filter-input"
           readonly
           value='<s:property value="contno"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Contract Type</td>
<td>
    <input type="text"
           id="conttype"
           name="conttype"
           class="filter-input"
           readonly
           value='<s:property value="conttype"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Legal Contract No.</td>
<td>
    <input type="text"
           id="legno"
           name="legno"
           class="filter-input"
           value='<s:property value="legno"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Process</td>
<td>
    <select id="cmbprocess"
            name="cmbprocess"
            class="filter-input"
            onchange="funtxtenable();">
    </select>
</td>
</tr>

<tr>
<td class="label-cell">Date</td>
<td>
    <div id="date"
         value='<s:property value="date"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">Remarks</td>
<td>
    <input type="text"
           id="txtremarks"
           name="txtremarks"
           class="filter-input"
           value='<s:property value="txtremarks"/>'/>
</td>
</tr>

</table>
</div>

<!-- ===== Buttons ===== -->
<div class="button-group">
    <button type="button"
            class="btn-submit"
            id="btnattachments"
            onclick="funAttachments(event);">
        Attach
    </button>

    <button type="button"
            class="btn-submit"
            id="btnupdate"
            onclick="funUpdate(event);">
        Update
    </button>
</div>

<!-- ===== Hidden Fields ===== -->
<input type="hidden" id="txtdocno" name="txtdocno"
       value='<s:property value="txtdocno"/>'/>

<input type="hidden" id="txtbranch" name="txtbranch"
       value='<s:property value="txtbranch"/>'/>

<input type="hidden" id="txtcldocno" name="txtcldocno"
       value='<s:property value="txtcldocno"/>'/>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT SIDE ================= -->
<td width="80%" valign="top">

<div class="grid-container">

<div class="filter-card">
    <div id="legalContractFollowupDiv">
        <jsp:include page="legalContractFollowupGrid.jsp"></jsp:include>
    </div>
</div>

<div class="filter-card">
    <div id="detailDiv">
        <jsp:include page="detailGrid.jsp"></jsp:include>
    </div>
</div>

</div>

</td>

</tr>
</table>

</div>
</div>

</body>
</html>