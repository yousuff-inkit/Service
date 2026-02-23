<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
		
		 $('#btncontract').attr("disabled",true);
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		   $("#followupdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     $('#amcwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'AMC No. Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		   $('#amcwindow').jqxWindow('close');
	     
	     var fromdates=new Date($('#uptodate').jqxDateTimeInput('getDate'));
		 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()+1)); 
		    
	     $('#uptodate').jqxDateTimeInput('setDate', new Date(onemounth));
		   
		 $('#amcno').dblclick(function(){
			 var docno = $('#contno').val();
			 var cldocno = $('#txtcldocno').val();
		  	    
			   $('#amcwindow').jqxWindow('open');
			       		amcsearchContent('amcsearch.jsp?doc='+docno+"&cldoc="+cldocno, $('#amcwindow')); 
		       });
	 

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
		 //$('#uptodate').jqxDateTimeInput({ disabled: true});
		
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
		 $('#amcno').attr("disabled",true);
		 $("#amcfollowupGrid").jqxGrid('clear');
		 $("#amcfollowupGrid").jqxGrid("addrow", null, {}); 
		 $("#amcfollowupGrid").jqxGrid({ disabled: true});
	}
	
	
	function funreload(event){
		disable();
		 var uptodate = $('#uptodate').val();
		 var branchval = document.getElementById("cmbbranch").value;
		 var chkfollowup = $('#hidchckfollowup').val();
		 var followupdate = $('#followupdate').val();
		 $("#overlay, #PleaseWait").show();
		 
		 $("#amcRenewalFollowupDiv").load("amcrenewalfollowupGrid.jsp?branchval="+branchval+"&uptodate="+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate);
		}
	
	function funUpdate(event){
		var pro= $('#cmbprocess').val().split(":");
		var bibid=pro[0].trim();
		var proname=pro[1].trim();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var remarks = $('#txtremarks').val();
		var trno = $('#txtdocno').val();
		var rdtype = $('#conttype').val();
		var client = $('#txtclient').val();
		var cntctperson = $('#txtcperson').val();
		var cntctpersonid = $('#txtcpersonid').val();
		var cldocno = $('#txtcldocno').val();
		var amcno = $('#amcno').val();
		
		if(bibid==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }

		  if(proname==("Renewed") && amcno=='')
			{
			 
			 $.messager.alert('Message','Please Choose AMC No.','warning');   
			 return 0;
			} 
		 
		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		 if(proname==("Create Enquiry"))
			{
			var docno=document.getElementById("amcno").value;   
		     var path1="com/operations/marketing/enquirynew/enquiry.jsp";
		     var name="Enquiry";  
		     var url=document.URL;
		     var reurl=url.split("/com/");  

		     window.parent.formName.value="Enquiry";
		     window.parent.formCode.value="ENQ";
		     var detName="Enquiry";
             var mode="A";
             var desc="renewal for amcno="+amcno;
		     var path= path1+"?mod="+mode+"&client="+client.replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cldocno="+cldocno+"&cperson="+cntctperson
		     +"&dtype="+rdtype+"&proname="+proname+"&desc="+desc+"&cpersonid="+cntctpersonid+"&trno="+trno;  

		     top.addTab( detName,reurl[0]+"/"+path);   
			
			}
		
		 if(proname!=("Create Enquiry"))
			{
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {  
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(bibid,proname,date,branchid,trno,rdtype,remarks,amcno);	
		     	}
		});
		}
	}
	function funCreateContract(event){
		var docno=document.getElementById("amcno").value;   
	     var path1="com/project/execution/serviceContract/servicecontract.jsp";
	     var name="Service Contract";  
	     var url=document.URL;
	     var reurl=url.split("/com/");  

	     window.parent.formName.value="Service Contract";
	     window.parent.formCode.value="AMC";
	     var detName="Service Contract";
        var mode="A";
        var desc="renewal for amcno="+amcno;
	     var path= path1+"?modes="+mode+"&client="+$('#txtclient').val().replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&cldocno="+$('#txtcldocno').val()+"&cperson="+$('#txtcperson').val()
	     +"&mob="+$('#txtmob').val()+"&tel="+$('#txttel').val()+"&mail="+$('#txtmail').val()+"&cpersonid="+$('#txtcpersonid').val()+"&address="+$('#txtaddress').val().replace("/\s/g","%20").replace('#','%23').replace('&','%26')+"&amcno="+$('#txtdocno').val()+"&salname="+$('#txtsalname').val()+"&salid="+$('#txtsalid').val();   
	   //  var path= path1+"?modes="+mode;
	     top.addTab( detName,reurl[0]+"/"+path); 
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
		
   
	    
	function saveGridData(bibid,proname,date,branchid,docno,rdtype,remarks,amcno){

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
				$('#txtcldocno').val('');
				$('#contno').val('');
				$('#conttype').val('');
				$('#amcno').val('');
				
				
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
			
	x.open("GET","saveData.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks+"&amcno="+amcno,true);
	x.send();
			
	}
	
	function funtxtenable()
	{
		$('#amcno').val('');
		$('#amcno').attr("disabled",true);
		var pro= $('#cmbprocess').val().split(":");
		var bibid=pro[0];
		var proname=pro[1].trim();
		
		if(proname==("Renewed"))
			{
			if ($('#amcno').val() == '') {
	    		 
	  	        $('#amcno').attr('placeholder', 'Press F3 To Search'); 
	  	    }
			$('#amcno').attr("disabled",false);
			}
	}
	
	
	
	function funExportBtn(){
	    

		//JSONToCSVCon(amcrenewalexcel, 'AMC Renewal Followup', true);
		
		 $("#amcRenewalFollowupDiv").excelexportjs({
				containerid: "amcRenewalFollowupDiv",   
				datatype: 'json',
				dataset: null,
				gridId: "jqxloaddataGrid",
				columns: getColumns("jqxloaddataGrid") ,   
				worksheetName:"AMC Renewal Followup"       
			});
		   }
	function getamcinfo(event){
		 var x= event.keyCode;
		if(x==114){
	 		$('#amcwindow').jqxWindow('open');
			amcsearchContent('amcsearch.jsp?doc='+docno+"&cldoc="+cldocno, $('#amcwindow'));    }
		else{}
	} 

	function amcsearchContent(url) {
		 	$.get(url).done(function (data) {
			$('#amcwindow').jqxWindow('open');
			$('#amcwindow').jqxWindow('setContent', data);
	}); 
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

<!-- Fixed Header -->
<div class="sidebar-fixed-top">
<div class="filter-card">
<jsp:include page="../../heading.jsp"></jsp:include>
</div>
</div>

<!-- Scrollable Content -->
<div class="sidebar-scroll-content">

<!-- Up To + Followup -->
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
<td></td>
<td>
<label>
<input type="checkbox"
id="chckfollowup"
onchange="followupcheck();"
onclick="$(this).attr('value', this.checked ? 1 : 0)">
Followup
</label>

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

</table>
</div>

<!-- Document Info -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Doc No</td>
<td>
<input type="text"
id="contno"
name="contno"
readonly
value='<s:property value="contno"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Doc Type</td>
<td>
<input type="text"
id="conttype"
name="conttype"
readonly
value='<s:property value="conttype"/>'/>
</td>
</tr>

</table>
</div>

<!-- Process Section -->
<div class="filter-card">
<table class="filter-table">

<tr>
<td class="label-cell">Process</td>
<td>
<select id="cmbprocess"
name="cmbprocess"
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
<td class="label-cell">New AMC No</td>
<td>
<input type="text"
id="amcno"
name="amcno"
readonly
placeholder="Press F3 To Search"
onkeydown="getamcinfo(event);"
value='<s:property value="amcno"/>'/>
</td>
</tr>

<tr>
<td class="label-cell">Remarks</td>
<td>
<input type="text"
id="txtremarks"
name="txtremarks"
value='<s:property value="txtremarks"/>'/>
</td>
</tr>

</table>
</div>

<!-- Buttons -->
<div class="button-group">

<button type="button"
class="myButton"
onclick="funUpdate(event);">
Update
</button>

<button type="button"
class="myConfirmButton"
onclick="funCreateContract(event);">
Create Contract
</button>

</div>

<!-- Hidden Fields -->
<input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
<input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
<input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
<input type="hidden" id="txtclient" name="txtclient" value='<s:property value="txtclient"/>'/>
<input type="hidden" id="txtcperson" name="txtcperson" value='<s:property value="txtcperson"/>'/>
<input type="hidden" id="txtcpersonid" name="txtcpersonid" value='<s:property value="txtcpersonid"/>'/>
<input type="hidden" id="txtmob" name="txtmob" value='<s:property value="txtmob"/>'/>
<input type="hidden" id="txttel" name="txttel" value='<s:property value="txttel"/>'/>
<input type="hidden" id="txtmail" name="txtmail" value='<s:property value="txtmail"/>'/>
<input type="hidden" id="txtsalname" name="txtsalname" value='<s:property value="txtsalname"/>'/>
<input type="hidden" id="txtsalid" name="txtsalid" value='<s:property value="txtsalid"/>'/>
<input type="hidden" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>'/>

</div>
</div>
</div>

</td>

<!-- ================= RIGHT SIDE ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
<td>
<div id="amcRenewalFollowupDiv">
<jsp:include page="amcrenewalfollowupGrid.jsp"></jsp:include>
</div>
</td>
</tr>

<tr>
<td>
<div id="detailDiv">
<jsp:include page="detailGrid.jsp"></jsp:include>
</div>
</td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<div id="amcwindow"><div></div></div>

</div>
</body>
</html>