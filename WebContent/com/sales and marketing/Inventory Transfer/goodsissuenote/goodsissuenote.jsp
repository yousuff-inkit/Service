<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

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
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String mod =request.getParameter("mod")==null?"view":request.getParameter("mod").toString();
String mastertrno =request.getParameter("masterdocno")==null?"0":request.getParameter("masterdocno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
String brch1 =request.getParameter("brch")==null?"0":request.getParameter("brch").toString();

String client =request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String cperson =request.getParameter("cperson")==null?"0":request.getParameter("cperson").toString();
String mob =request.getParameter("mob")==null?"0":request.getParameter("mob").toString();
String tel =request.getParameter("tel")==null?"0":request.getParameter("tel").toString();
String mail =request.getParameter("mail")==null?"0":request.getParameter("mail").toString();
String cpersonid =request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid").toString();
String address =request.getParameter("address")==null?"0":request.getParameter("address").toString();
String amcno =request.getParameter("amcno")==null?"0":request.getParameter("amcno").toString();
String salname =request.getParameter("salname")==null?"0":request.getParameter("salname").toString();
String salid =request.getParameter("salid")==null?"0":request.getParameter("salid").toString();
%>

<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
var brhidview='<%=brch1%>';

var clientname='<%=client%>';
var clientno='<%=cldocno%>';
var cpersonname='<%=cperson%>';
var mob='<%=mob%>';
var tel='<%=tel%>';
var mail='<%=mail%>';
var cpersonid='<%=cpersonid%>';
var address='<%=address%>';
var amcno='<%=amcno%>';
var salname='<%=salname%>';
var salid='<%=salid%>';

$(document).ready(function () {  
    $('#btnvaluechange').hide();

    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#masterdate").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#expdate").jqxDateTimeInput({  width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
     
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#masterdate, #expdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#masterdate, #expdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#searchwndow').jqxWindow('close');  
    $('#sidesearchwndow').jqxWindow({ width: '55%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#sidesearchwndow').jqxWindow('close');   
    
    $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#searchwindow').jqxWindow('close'); 

    $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
    $('#importwindow').jqxWindow('close');   
     
    $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#locationwindow').jqxWindow('close');  
	
    $('#itemdocno').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            $('#searchwindow').jqxWindow('open');
            if(document.getElementById("itemtype").value=="1") {
                refsearchContent('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
            } else if(document.getElementById("itemtype").value=="6") {
                refsearchContent('fleetGrid.jsp?'); 	
            } else {
                refsearchContent('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
            } 
        }
    }); 
			  
    $('#txtlocation').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
            $('#locationwindow').jqxWindow('open');
            locationsearchContent('searchlocation.jsp?'); 
        }
    }); 
		   
    $('#masterdate').on('change', function (event) {
        var maindate = $('#masterdate').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
            funDateInPeriodchk(maindate);
        }
    });

    $("#sqotprdname").change(function(){
        var dl=$("#sqotprdts")[0];
        var el=$("#sqotprdname")[0];
        if(el.value.trim() != ''){
            var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
            var unit = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unit');
            var brand = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-brand');
            var psrno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-psrno')
            var specid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-specid');
            var unitdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitdoc');
            
            document.getElementById("sqotprdid").value=prdid;
            document.getElementById("unit").value=unit;
            document.getElementById("brand").value=brand;
            document.getElementById("temppsrno").value=psrno;
            document.getElementById("tempunitdocno").value=unitdoc;
            document.getElementById("tempspecid").value=specid;
            getunit(psrno);
        }
    });
				 	
    $("#sqotprdid").change(function(){
        var dl=$("#sqotproductid")[0];
        var el=$("#sqotprdid")[0];
        if(el.value.trim() != ''){
            var prdname = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-prdname');
            var unit = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unit');
            var brand = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-brand');
            var psrno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-psrno')
            var specid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-specid');
            var unitdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitdoc');
            
            document.getElementById("sqotprdname").value=prdname;
            document.getElementById("unit").value=unit;
            document.getElementById("brand").value=brand;
            document.getElementById("temppsrno").value=psrno;
            document.getElementById("tempunitdocno").value=unitdoc;
            document.getElementById("tempspecid").value=specid;
            getunit(psrno);
        }
    });
});

function getitem(event){
    var x= event.keyCode;
    if(x==114){
        $('#searchwindow').jqxWindow('open');
        if(document.getElementById("itemtype").value=="1") {
            refsearchContent('costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
        } else if(document.getElementById("itemtype").value=="6") {
            refsearchContent('fleetGrid.jsp?'); 	
        } else {
            refsearchContent('costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
        }
    }
}  

function refsearchContent(url) {
    $.get(url).done(function (data) {
        $('#searchwindow').jqxWindow('setContent', data);
    }); 
}
	  
function productSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 

function getloc(event){
    var x= event.keyCode;
    if(x==114){
        $('#locationwindow').jqxWindow('open');
        locationsearchContent('searchlocation.jsp?');   
    }
}  

function locationsearchContent(url) {
    $.get(url).done(function (data) {
        $('#locationwindow').jqxWindow('setContent', data);
    }); 
}

function funReset(){}

function funReadOnly(){
	$('#frmgin input').attr('readonly', true );
	$('#frmgin select').attr('disabled', true );
	$('#masterdate').jqxDateTimeInput({ disabled: true});
	$("#serviecGrid").jqxGrid({ disabled: true});
	$('#psearch').attr('disabled', true );
	$('#setbtn').attr('disabled', true ); 
    $('#btnvaluechange').hide();
}

function funRemoveReadOnly(){
	getProduct();    
	chkmultiqty();
	chkproductconfig();
	document.getElementById("editdata").value="";
	$('#frmgin input').attr('readonly', false );
	$('#frmgin select').attr('disabled', false );
    $('#btnvaluechange').hide();
    $('#txtlocation').attr('readonly', true);
    $('#itemdocno').attr('readonly', true);
    $('#itemname').attr('readonly', true);
    $('#clientname').attr('readonly', true);
    $('#psearch').attr('disabled', false );
    $('#setbtn').attr('disabled', false ); 
    $('#site').attr('readonly', true);
	  
	$('#masterdate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
	$("#serviecGrid").jqxGrid({ disabled: false});

	if ($("#mode").val() == "A") {
		$('#masterdate').val(new Date());
        $("#serviecGrid").jqxGrid('clear');
        $("#serviecGrid").jqxGrid('addrow', null, {});
        $('#itemname').attr('readonly', true);
        $('#clientname').attr('readonly', true);
        $('#site').attr('readonly', true);
	}
	
  	if ($("#mode").val() == "E") {
		 $('#btnvaluechange').show();
		$("#serviecGrid").jqxGrid({ disabled: true});
	}  
}

function funcheckaccinvendor() {
	if(document.getElementById("puraccid").value=="") {
		 document.getElementById("errormsg").innerText="Search Vendor";  
		 document.getElementById("puraccid").focus();
	     return 0;
    }
}

function funFocus(){
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}

function funDateInPeriodchk(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
 
    if(value>currentDate){
        document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
        return 0;
    } 
    document.getElementById("errormsg").innerText="";
    return 1;
}

function funNotify(){	
    var item=$('#itemtype').val();
    var itemdocno=$('#itemdocno').val();
    if(item=='' || item==null){
        document.getElementById("errormsg").innerText="Please select the type";  
        document.getElementById("itemtype").focus();
        return 0;
    }
    if(itemdocno=='' || itemdocno==null || itemdocno.equals=='0'){
        document.getElementById("errormsg").innerText="Please select the sub type";
        document.getElementById("itemdocno").focus();
        return 0;
    }
    var type=$('#type').val();
    if(type=='' || type==null){
        document.getElementById("errormsg").innerText="Select the type";
        document.getElementById("type").focus();
        return 0;
    }
	var maindate = $('#masterdate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriodchk(maindate);
    if(validdate==0){
        return 0; 
    }

	if(document.getElementById("txtlocation").value=="") {
        document.getElementById("errormsg").innerText="Search Location";  
        document.getElementById("txtlocation").focus();
        return 0;
	} else {
        document.getElementById("errormsg").innerText="";
    }
    
	var rows = $("#serviecGrid").jqxGrid('getrows');
	var product=$('#serviecGrid').jqxGrid('getcellvalue', 0, "productid");
	if(product=='' || product==null){
		 document.getElementById("errormsg").innerText="Add Product !!";  
	     return 0; 
	}
	 
	var retval=restrictEdit();
	if(retval==0){     
	   	document.getElementById("errormsg").innerText="Goods Issue Already Returned!";    
	}else{
	 	document.getElementById("errormsg").innerText="";
	 	if(parseInt(document.getElementById("multimethod").value)==1) {	
	 	    chkstock();
	 	} else {
	 		save();
	 	}
	}   
	return retval;
}


function chkstock() {
    var rows = $("#serviecGrid").jqxGrid('getrows');
    var list = new Array();
    for(var i=0 ; i < rows.length; i++){
        if(parseInt(rows[i].prodoc)>0)  { 
            list.push(rows[i].prodoc+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].unitdocno+"::"+rows[i].oldqty);
        }
    }
    ajaxcallchk(list);
}
	   
function ajaxcallchk(list){
    var branch=document.getElementById("brchName").value;
    var location=document.getElementById("txtlocationid").value;
    var mode=$('#mode').val();
    
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText.trim();
            if(parseInt(items)==1) {
                document.getElementById("errormsg").innerText=" Does Not Have Sufficient Stock !!";  
                return 0;
            } else if(parseInt(items)==2) {
                document.getElementById("errormsg").innerText=" error!!";  
                return 0;
            } else {
                save();
            }
        }
    }
    x.open("GET","validateqty.jsp?list="+list+"&branch="+branch+"&mode="+mode+"&location="+location+"&date="+document.getElementById("masterdate").value,true);
    x.send();
}

function save(){	
    var rows = $("#serviecGrid").jqxGrid('getrows');
    $('#serviecGridlength').val(rows.length);
  
    for(var i=0 ; i < rows.length ; i++){
        var chkqty=rows[i].qty;
        newTextBox = $(document.createElement("input"))  
            .attr("type", "dil")
            .attr("id", "sertest"+i)
            .attr("name", "sertest"+i)
            .attr("hidden", "true");         
				  
        if(parseFloat(chkqty)>0){	 
            newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
                        +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+rows[i].cost_price+" ::"+rows[i].savecost_price);
        }	 
        newTextBox.appendTo('form');
    }   
	  
    $("#serviecGrid").jqxGrid({ disabled: false});
    $("#frmgin").submit();
	return 1;
} 

function calculatedata(val) {}

function funwarningopen(){
    $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
        if (r){
            document.getElementById("editdata").value="Editvalue";
            $("#serviecGrid").jqxGrid({ disabled: false});
            $("#serviecGrid").jqxGrid('addrow', null, {});
            $('#psearch').attr('disabled', false );
            $('#setbtn').attr('disabled', false );  
        }
    });
}

function funChkButton() {}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}

function getCurrencyIds(){}
	   
function getRatevalue(angel){}
	   
function combochange(){}

function setValues() {
    if($('#hidmasterdate').val()){
        $("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
    }
    
    var dis=document.getElementById("masterdoc_no").value;
    if(dis>0) {     
        restrictEdit();
        var indexval1 = document.getElementById("masterdoc_no").value;   
        var locationid=document.getElementById("txtlocationid").value;
        $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&locationid="+locationid+"&date="+document.getElementById("masterdate").value);
    } 

    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    } 
				
    combochange();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
} 

function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveActiongins");
        
        $("#docno").prop("disabled", false);                
        var dtype=$('#formdetailcode').val();
  
        var win= window.open(reurl[0]+"PRINTgin?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus(); 
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}

$(function(){
    $('#frmgin').validate({
        rules: { 
            delterms:{maxlength:200},
            purdesc:{maxlength:200},
            payterms:{maxlength:200},
            puraccid:{required:true}
        },
        messages: {
            delterms: {maxlength:"  Max 200 chars"},
            purdesc: {maxlength:"  Max 200 chars"},
            payterms: {maxlength:"  Max 200 chars"},
            puraccid: {required:" *"}
        }
    });
});

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}
 
function funrefdisslno() {}
 
function restrictEdit(){
    var retval = 1; 
    if($("#mode").val()=="E" || $("#mode").val()=="R"){       
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;  
                    if(parseInt(items)>0){
                        retval = 0;
                        $("#btnEdit").attr('disabled', true );
                         $("#btnDelete").attr('disabled', true );
                        
                    } else {
                        retval = 1; 
                    }
                }   
        }
        x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, false);                  
        x.send();
    }
    return retval; 
}
	 
function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();	
            if(parseInt(items)>0) {
                 $("#btnEdit").attr('disabled', true );
                 $("#btnDelete").attr('disabled', true ); 
            }
        }
    }
    x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
    x.send();
}
	 
function removemsg() {
     document.getElementById("errormsg").innerText="";
}
	
function gettype(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype = '';

            for ( var i = 0; i < type.length; i++) {
                optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
            }
          
            $("select#type").html(optionstype); 	
            
            if($('#hidetype').val()!="") {
                $('#type').val($('#hidetype').val());   
            }
        }
    }
    x.open("GET","gettype.jsp?",true);
    x.send();
}
	 
function getitemtype(){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype = '';

            for ( var i = 0; i < type.length; i++) {
                optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
            }
            
            $("select#itemtype").html(optionstype); 	
            
            if($('#hideitemtype').val()!="") {
                $('#itemtype').val($('#hideitemtype').val());   
            }
        }
    }
    x.open("GET","getitem.jsp?",true);
    x.send();
}
	 
function cleardata() {
    document.getElementById("itemdocno").value="";
    document.getElementById("itemname").value="";
    document.getElementById("clientname").value="";
    document.getElementById("cldocno").value="";
    document.getElementById("siteid").value="";
    document.getElementById("site").value="";
}

function setgrid() {
    var temppsrno=document.getElementById("temppsrno").value; 
    var unit=document.getElementById("unit").value; 
    var rows1 = $("#serviecGrid").jqxGrid('getrows');
    var aa=0;
    
    for(var i=0;i<rows1.length;i++){
        if(parseInt(rows1[i].prodoc)==parseInt(temppsrno)) {
            if((parseInt(document.getElementById("multimethod").value)==1)) {	
                if(parseInt(rows1[i].unitdocno)==parseInt(unit)) {
                    aa=1;
                    break;
                }
            } else {
                aa=1;
                break;
            }
        } else {
            aa=0;
        } 
    }
			 
    if(parseInt(aa)==1) {
        document.getElementById("errormsg").innerText="You have already select this product";
        document.getElementById("jqxInput1").focus();
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
	    
    var rows = $('#serviecGrid').jqxGrid('getrows');
    var rowlength= rows.length;

    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("sqotprdid").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("sqotprdname").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
    
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
    if(document.getElementById("unit").value>0) {
        $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
    }
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
    $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("sqotprdid").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("sqotprdname").value);
    $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);

    document.getElementById("sqotprdid").value ="";
    document.getElementById("sqotprdname").value="";
    document.getElementById("brand").value=""; 
    document.getElementById("collqty").value ="";
    document.getElementById("quantity").value ="";
    document.getElementById("unit").value ="";
    document.getElementById("temppsrno").value="";
    document.getElementById("tempspecid").value="";
				      								
    $("#serviecGrid").jqxGrid('addrow', null, {});
    document.getElementById("sqotprdid").focus();
}

function getunit(val){ 
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var docno=items[0].split(",");
            var type=items[1].split(",");
            var optionstype;

            for ( var i = 0; i < type.length; i++) {
                optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
            }
            
            $("select#unit").html(optionstype); 	
        }
    }
    x.open("GET","getunit.jsp?psrno="+val,true);
    x.send();
}

function reloads() {  
    var locid =document.getElementById("txtlocationid").value;      
    var date =$('#masterdate').val();    
    var id=1;
    $("#part").load('part.jsp?locid='+locid+"&date="+date+"&id="+id);
    $("#pnames").load('name.jsp?locid='+locid+"&date="+date+"&id="+id);  
} 
		 
function getProduct() {
    var locid =document.getElementById("txtlocationid").value;      
    var date =$('#masterdate').val();    
    var id=1;
    var optionsyear = "";
    var optionsyearnw = "";
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            var prddatas=JSON.parse(items.trim());          
            
                $.each(prddatas.pddata, function( index, value ) {
                    optionsyearnw += '<option value="' + value.part_no + '" data-prdname="'+value.productname+'" data-tax="'+value.taxper+'" data-unit="'+value.unit+'" data-brand="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdoc="'+value.unitdocno+'" ></option>';
                    optionsyear += '<option value="' + value.productname + '" data-prdid="'+value.part_no+'" data-tax="'+value.taxper+'" data-unit="'+value.unit+'" data-brand="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdoc="'+value.unitdocno+'"></option>';
                });
            $("datalist#sqotprdts").html(optionsyear);
            $("datalist#sqotproductid").html(optionsyearnw);			
        }
    }
    x.open("GET", 'getProduct.jsp?locid='+locid+'&date='+date+'&id='+id, true);
    x.send();
}
</script>  
</head>

<body onLoad="setValues();gettype();getitemtype();" >
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmgin" action="saveActiongins" method="post" autocomplete="off">  
        <jsp:include page="../../../../header.jsp" />  
        <jsp:include page="multiqty.jsp"></jsp:include>
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Master Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
                    </div>
                    <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Type</label>
                    <select id="type" name="type" style="width:125px;"></select>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Location</label>
                    <div class="input-search-container" style="flex:1;">
                        <input type="text" id="txtlocation" name="txtlocation" placeholder="Press F3" value='<s:property value="txtlocation"/>' onkeydown="getloc(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtlocation').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Ref No</label>
                    <input type="text" name="refno" id="refno" style="width:125px;" value='<s:property value="refno"/>'>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Doc No</label>
                    <input type="text" name="docno" id="docno" style="width:125px;" tabindex="-1" value='<s:property value="docno"/>' readonly>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;"></label>
                    <select id="itemtype" name="itemtype" style="width:125px;" onchange="cleardata()"></select>  
                    
                    <div class="input-search-container" style="width:150px; margin-left:8px;">
                        <input type="text" id="itemdocno" name="itemdocno" placeholder="Press F3" value='<s:property value="itemdocno"/>' onkeydown="getitem(event);">
                        <svg class="magnifier-icon" onclick="$('#itemdocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <input type="text" id="itemname" name="itemname" style="flex:1; margin-left:8px;" value='<s:property value="itemname"/>' readonly>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Client</label>    
                    <input type="text" id="clientname" name="clientname" style="flex:1;" value='<s:property value="clientname"/>' readonly/>
                    <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'/>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Site</label>
                    <input type="text" name="site" id="site" style="flex:1;" value='<s:property value="site"/>' readonly>
                    <input type="hidden" name="siteid" id="siteid" value='<s:property value="siteid"/>'>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="flex:1;">
                    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left:15px;">Value Change</button>
                </div>
            </div>

            <!-- Hidden Grid Texts -->
            <div style="display:none;">
                <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>'/>   
                <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>'/>  
            </div>

            <div class="middle-panel" id="psearch">
                <span class="middle-panel-title">Item Details Entry</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Product ID</label>
                    <input type="text" id="sqotprdid" list="sqotproductid" style="width:125px;">
                    <datalist id="sqotproductid" style="visibility:hidden;"></datalist>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Product Name</label>
                    <input type="text" id="sqotprdname" list="sqotprdts" style="flex:1;">
                    <datalist id="sqotprdts" style="visibility:hidden;"></datalist>
                    
                    <label class="lbl-right" style="width:60px; margin-left:15px;">Brand</label>
                    <input type="text" id="brand" style="width:100px;">
                    <input type="hidden" id="collqty">
                    
                    <label class="lbl-right" style="width:40px; margin-left:15px;">Unit</label>
                    <select id="unit" style="width:80px;"></select>
                    
                    <label class="lbl-right" style="width:40px; margin-left:15px;">Qty</label>
                    <input type="hidden" id="loads" class="myButton" value="Load Data" onclick="loaddatass()">  
                    <input type="text" id="quantity" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="width:80px; text-align:right;" onchange="calculatedata(this.id);">
                    <input type="hidden" id="focs">
                    <input type="hidden" id="multi">
                    <input type="hidden" id="batch">
                    <div id="expdate" style="display:none;" name="expdate" value='<s:property value="expdate"/>'></div> 
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <input type="hidden" id="cleardata">
                    <input type="button" id="setbtn" class="myButton-success" onclick="setgrid()" value="ADD" style="margin-left:auto;">
                    
                    <!-- Hidden fields originally present in row -->
                    <input type="hidden" id="totamt">
                    <input type="hidden" id="dispers">
                    <input type="hidden" id="dict">
                    <input type="hidden" id="amounts">
                    <input type="hidden" id="taxpers">
                    <input type="hidden" id="taxamounts">
                    <input type="hidden" id="taxamountstotal">
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Service Details</span>
                <div id="sevdesc" class="grid-container" style="border:none;">
                    <jsp:include page="serviecgrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" name="productTotal" id="productTotal" value='<s:property value="productTotal"/>'>
                <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
                <input type="hidden" name="netTotaldown" id="netTotaldown" value='<s:property value="netTotaldown"/>'>
                <input type="hidden" id="costtr_no" name="costtr_no" value='<s:property value="costtr_no"/>'/> 
                <input type="hidden" id="hideitemtype" name="hideitemtype" value='<s:property value="hideitemtype"/>'/> 
                <input type="hidden" id="hidetype" name="hidetype" value='<s:property value="hidetype"/>'/>
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
                <input type="hidden" id="refmasterdoc_no" name="refmasterdoc_no" value='<s:property value="refmasterdoc_no"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
                <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>'/>
                <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>  
                <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>    
                <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
                <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
                <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>  
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="acctypegrid" name="acctypegrid" value='<s:property value="acctypegrid"/>'/>
                <input type="hidden" id="serviecGridlength" name="serviecGridlength" value='<s:property value="serviecGridlength"/>'/>  
                <input type="hidden" id="hidelocation" name="hidelocation" value='<s:property value="hidelocation"/>'/>
                <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
                <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>'/>
                <input type="hidden" id="temppsrno">  
                <input type="hidden" id="tempspecid"> 
                <input type="hidden" id="tempunitdocno"> 
            </div>
            
        </div>
    </form>
    
    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="searchwindow"><div></div><div></div></div>
    <div id="accountSearchwindow"><div></div><div></div></div>
    <div id="sidesearchwndow"><div></div><div></div></div>
    <div id="importwindow"><div></div><div></div></div>
    <div id="searchwndow"><div></div><div></div></div>
    <div id="locationwindow"><div></div><div></div></div>
</div>
</body>
</html>