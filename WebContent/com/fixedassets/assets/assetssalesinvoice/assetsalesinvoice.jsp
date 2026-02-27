<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<style type="text/css">

html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    overflow-y: auto;
    font-family: 'Segoe UI', sans-serif;
    background: #eef1f5;
    color: #2d3748;
}


body::-webkit-scrollbar {
    width: 8px;
}

body::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 10px;
}

body::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}

#mainBG {
    background: #ffffff;
    border-radius: 14px;
    padding: 18px 25px 25px 25px; 
    margin: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.06);
}


#mainBG > br {
    display: none;
}


.page-title {
    font-size: 22px;
    font-weight: 600;
    margin: 10px 0 15px 0; 
    color: #2d3748;
}



.toolbar {
    display: flex;
    gap: 10px;
    margin-bottom: 18px;
}

.toolbar button {
    background: #f1f3f6;
    border: none;
    padding: 7px 16px;
    border-radius: 20px;
    font-size: 13px;
    cursor: pointer;
    transition: 0.2s ease;
}

.toolbar button:hover {
    background: #e2e6ea;
}


.section-card {
    background: #f5f7fa;
    border-radius: 14px;
    padding: 18px;
    margin-bottom: 20px;
}

.section-title {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 18px;
    padding-left: 10px;
    border-left: 4px solid #1e88e5;
    color: #2d3748;
}


.two-column {
    display: flex;
    gap: 20px;
}

.section-half {
    flex: 1;
}


.form-row {
    display: grid;
    grid-template-columns: 140px 1fr 140px 1fr;
    gap: 15px;
    margin-bottom: 14px;
    align-items: center;
}

.form-row.single {
    grid-template-columns: 140px 1fr;
}
input[type="text"],
select {
    height: 34px;
    border: 1px solid #d8dee9;
    border-radius: 8px;
    padding: 6px 12px;
    background: #ffffff;
    font-size: 14px;
    box-sizing: border-box;
    transition: 0.2s ease;
}

input[type="text"]:focus,
select:focus {
    border-color: #1e88e5;
    outline: none;
    box-shadow: 0 0 0 2px rgba(30,136,229,0.15);
}

label {
    font-weight: 600;
    font-size: 13px;
    color: #4a5568;
}

.table-section {
    margin-top: 25px;
}

.table-title {
    font-weight: 600;
    margin-bottom: 10px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e3e8ef;
}

.cr-table th {
    background: #f1f3f6;
    padding: 10px;
    font-size: 13px;
    text-align: left;
    font-weight: 600;
}

.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #edf2f7;
    font-size: 13px;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

input[type="checkbox"] {
    transform: scale(1.05);
    margin-right: 6px;
}


@media (max-width: 1024px) {

    .two-column {
        flex-direction: column;
    }

    .form-row {
        grid-template-columns: 140px 1fr;
    }

}

.primary-btn {
    background: #1e88e5;
    color: #ffffff;
    text-align: center;
}

.primary-btn:hover {
    background: #1565c0;
}

.primary-btn:active {
    transform: scale(0.98);
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	//document.getElementById("btnEdit").disabled=true;  
	//document.getElementById("btnDelete").disabled=true;
	 $('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#assetwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Asset Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#assetwindow').jqxWindow('close');
	   
	   
$("#date").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#fromdate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#todate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$('#client').dblclick(function(){
    $('#clientwindow').jqxWindow('open');
$('#clientwindow').jqxWindow('focus');
clientSearchContent('masterClientSearch.jsp');
});
});
function getClient(event){
	 var x= event.keyCode;
     if(x==114){
    	 $('#clientwindow').jqxWindow('open');
    	 $('#clientwindow').jqxWindow('focus');
    	 clientSearchContent('masterClientSearch.jsp');
     }
     else{
      }
}
function funSearchLoad(){
	 changeContent('mainSearch.jsp', $('#window')); 
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function assetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#assetwindow').jqxWindow('setContent', data);

}); 
}

function detailSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#detailwindow').jqxWindow('setContent', data);

}); 
}
function funChkButton(){
	
}
function funReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: true}); 
	 $('#assetInvoiceGrid').jqxGrid({ disabled: true}); 
		$('#frmAssetInvoice input').attr('readonly', true );
		 $('#frmAssetInvoice select').attr('disabled', true );
		 $('#frmAssetInvoice textarea').attr('readonly', true );
		 $('#btncalculate').prop('disabled',true);

}
function funRemoveReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $('#assetInvoiceGrid').jqxGrid({ disabled: false}); 
		$('#frmAssetInvoice input').attr('readonly', false );
		 $('#frmAssetInvoice select').attr('disabled', false );
		 $('#frmAssetInvoice textarea').attr('readonly', false );
		 $('#btncalculate').prop('disabled',false);
		 $('#client').prop('readonly',true);
		 $('#clientname').prop('readonly',true);
		 $('#docno').prop('readonly',true);
		 $('#vocno').prop('readonly',true);
		 if(document.getElementById("mode").value=='A'){
			 $("#assetInvoiceGrid").jqxGrid('clear');
			 $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
		 }
}
function funFocus(){
	document.getElementById("client").focus();
}
function setValues(){
funSetlabel();
	
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 if ($('#hidcmbtype').val() != null) {
			$('#cmbtype').val($('#hidcmbtype').val());
		}
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	if(document.getElementById("docno").value!=""){
		document.getElementById("brchName").disabled=false;
		$('#assetInvoicediv').load('assetInvoiceGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("hidbranch").value+'&id=1');
		
	}
}
function funNotify(){
	if(document.getElementById("cmbtype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Type is Mandatory";
		document.getElementById("cmbtype").focus();
		return 0;
	}
	var rows = $("#assetInvoiceGrid").jqxGrid('getrows');
	if(!((rows[0].assetno=="undefined") || (rows[0].assetno==null) || (rows[0].assetno==""))){
	
		var rowlength=0;
		for(var i=0 ; i < rows.length ; i++){
		
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "test"+i)
		    .attr("name", "test"+i)
		    .attr("hidden", "true");
			if(rows[i].assetno!="" && rows[i].assetno!="undefined" && rows[i].assetno!=null){
				
		newTextBox.val(rows[i].assetno+"::"+rows[i].assetname+"::"+rows[i].salesprice+"::"+rows[i].dep_posted+"::"+rows[i].pur_value+"::"+rows[i].acc_dep+"::"+rows[i].cur_dep+"::"+rows[i].net_pl+"::"+rows[i].netbook);
		
		newTextBox.appendTo('form');
		rowlength++;
			}
			
			//alert("ddddd"+$("#test"+i).val());
		}
		
		$('#gridlength').val(rowlength);
		
	}
 return 1;	
}


function funCalculate(){

	var date=$('#date').jqxDateTimeInput('val');
	
	var rows=$('#assetInvoiceGrid').jqxGrid('getrows');
	var temp=0;
	for(var i=0;i<rows.length;i++){
		var asset=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetid');
		var assetno=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetno');
		temp=1;
		document.getElementById("errormsg").innerText="";
		if(asset=="" || asset=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Asset is Mandatory";
			$('#assetInvoiceGrid').jqxGrid('selectcell', i, 'assetid');
			return false;
		}
		var salesprice=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'salesprice');
		if(salesprice=="" || salesprice=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Sales Price is Mandatory";
			$('#assetInvoiceGrid').jqxGrid('selectcell', i, 'salesprice');
			return false;
		}
		
		if(document.getElementById("errormsg").innerText=="" && asset!="" && asset!="undefined" && asset!=null){
			getCalData(assetno,salesprice,i,date);
		}
			
	}
	if(temp==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Asset";
		return false;
	}
	
}


function getCalData(asset,salesprice,row,date){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items=items.split("::");
			
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'dep_posted',items[0]); 
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'pur_value',items[1]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'acc_dep',items[2]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'cur_dep',items[3]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'net_pl',items[4]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'netbook',items[5]);
			document.getElementById("days").value=items[3];
		} else {
		}
	}
	x.open("GET", "getCalData.jsp?asset="+asset+"&salesprice="+salesprice+"&date="+date, true);
	x.send();
}




</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmAssetSalesInvoice" action="saveActionAssetSalesInvoice" autocomplete="off">

<jsp:include page="../../../../header.jsp" />

<div style="display:flex; align-items:center; width:100%; margin-bottom:15px;">

    <div class="page-title" style="margin:0;">
        Asset Sales Invoice
    </div>

    <div style="margin-left:auto; display:flex; align-items:center; gap:8px;">
        <label style="font-weight:600;">Doc No :</label>
        <input type="text"
               name="vocno"
               id="vocno"
               value='<s:property value="vocno"/>'
               style="width:160px;"
               tabindex="-1"
               readonly />
    </div>

</div>

<div class="section-card">

    <div class="form-row">

        <label>Date</label>
        <div>
            <div id="date" name="date"
                 value='<s:property value="date"/>'></div>
        </div>

        <label>Client</label>
        <input type="text"
               name="client"
               id="client"
               value='<s:property value="client"/>'
               readonly
               placeholder="Press F3 to Search"
               onkeydown="getClient(event);"
               style="width:160px;" />

    </div>

    <div class="form-row single">

        <label>Client Name</label>
        <input type="text"
               name="clientname"
               id="clientname"
               value='<s:property value="clientname"/>'
               readonly />

    </div>

    <div class="form-row">

        <label>Description</label>
        <input type="text"
               name="description"
               id="description"
               value='<s:property value="description"/>' />

        <label>Type</label>
        <select name="cmbtype" id="cmbtype" style="width:160px;">
            <option value="">--Select--</option>
            <option value="S">Sale</option>
            <option value="L">Total Loss</option>
        </select>

    </div>

    <div class="form-row single">
        <label></label>
      <button type="button"
        name="btncalculate"
        id="btncalculate"
        class="fa-nav-btn primary-btn"
        onclick="funCalculate();">
    Calculate
</button>
    </div>

</div>


<div class="section-card">

    <div class="section-title">Asset Invoice Details</div>

    <div id="assetInvoicediv">
        <jsp:include page="assetInvoiceGrid.jsp"></jsp:include>
    </div>

</div>


<div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' hidden="true"></div>
<div id="todate" name="todate" value='<s:property value="todate"/>' hidden="true"></div>

<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
<input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
<input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
<input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
<input type="hidden" name="days" id="days" value='<s:property value="days"/>'>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1" readonly>

</form>


<div id="clientwindow"><div></div></div>
<div id="assetwindow"><div></div></div>

</div>
</body>
</html>
