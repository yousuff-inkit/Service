<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>

<!DOCTYPE html>
<html>
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
String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
String docno= request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String reviseno=request.getParameter("reviseno")==null?"0":request.getParameter("reviseno").toString();
String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String ref_type=request.getParameter("ref_type")==null?"0":request.getParameter("ref_type").toString();
String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
String reftrno=request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String material=request.getParameter("material")==null?"0":request.getParameter("material").toString();
String labour=request.getParameter("labour")==null?"0":request.getParameter("labour").toString();
String machine=request.getParameter("machine")==null?"0":request.getParameter("machine").toString();
String nettotal=request.getParameter("nettotal")==null?"0":request.getParameter("nettotal").toString();
String surtrno=request.getParameter("surtrno")==null?"0":request.getParameter("surtrno").toString();
%>

<script type="text/javascript">
var mod1='<%=mod%>';
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';

	$(document).ready(function() {
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
  	    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        
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
  	  
        /* Searching Window */
        $('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#clientsearch1').jqxWindow('close');
        $('#activitysearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#activitysearchwindow').jqxWindow('close'); 
        $('#lchargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Labour Charge Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#lchargeinfowindow').jqxWindow('close');
        $('#echargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Equipment Charge Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#echargeinfowindow').jqxWindow('close');
        $('#sidesearchwndow').jqxWindow({ width: '70%', height: '80%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 400, y: 0 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#sidesearchwndow').jqxWindow('close');
        $('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#enquirywindow').jqxWindow('close');
        
        $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#servicetypewindow').jqxWindow('close'); 
        
        $('#sitewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Site Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#sitewindow').jqxWindow('close');
        
        $('#scopesearchwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Scope Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#scopesearchwindow').jqxWindow('close');
        
        $('#templatesearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Template Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
        $('#templatesearchwindow').jqxWindow('close'); 
            
        $('#unitsearchwindow').jqxWindow({ width : '25%', height : '58%', maxHeight : '70%', maxWidth : '45%', title : 'Unit Search', position : { x : 420, y : 87 }, theme : 'energyblue', showCloseButton : true, keyboardCloseKey : 27 });
        $('#unitsearchwindow').jqxWindow('close');
        
        refChange();getPreSalesScopeAllowed();
        
        $('#txtclient').dblclick(function(){
            if($('#mode').val()!= "view") {
                $('#clientsearch1').jqxWindow('open');
                clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
            }
        });
        
        $('#txtenquiry').dblclick(function(){
            var clientid=document.getElementById("clientid").value;
            var reftype=$('#cmbreftype').val();
            if(clientid>0){
                document.getElementById("errormsg").innerText="";
            } else{
                document.getElementById("errormsg").innerText="Select a client";
                return 0;
            } 
            
            if($('#mode').val()!= "view") {
                changeContent('enqMastersearch.jsp?reftype='+reftype); 
            }
        });
        
        $('#txtsite').dblclick(function(){
            if($('#mode').val()!= "view") {
                if(document.getElementById("cmbreftype").value!="DIR"){
                    $('#sitewindow').jqxWindow('open');
                    var reftype=$('#cmbreftype').val();
                    var srvedocno=$('#txtenquiry').val();
                    var surtrno=$('#hidsurtrno').val();
                    var enqtrno=$('#hidenqtrno').val();
                    var id=0;
                    
                    if(surtrno>0){
                        id=4;
                        siteSearchContent("sitesearch.jsp?reftrno="+surtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1"); 
                    } else {
                        id=3;
                        siteSearchContent("sitesearch.jsp?reftrno="+enqtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1");
                    }
                } else {
                    $('#txtsite').attr('readonly', false );
                    $('#txtsite').val('');$('#txtsiteid').val('');
                }
            }
        });
        
        $('#txttemplatecode').dblclick(function(){
            if($('#mode').val()!= "view") {
                $('#templatesearchwindow').jqxWindow('open');
                templateSearchContent('templatesDetailsSearch.jsp?', $('#templatesearchwindow'));    	
            }
        });
	});
      
    function unitSearchContent(url) {
  		$('#unitsearchwindow').jqxWindow('open');
  		$.get(url).done(function(data) {
  			$('#unitsearchwindow').jqxWindow('setContent', data);
  			$('#unitsearchwindow').jqxWindow('bringToFront');
  		});
  	}
      
    function templateSearchContent(url) {
        $('#templatesearchwindow').jqxWindow('open');
        $.get(url).done(function(data) {
            $('#templatesearchwindow').jqxWindow('setContent', data);
            $('#templatesearchwindow').jqxWindow('bringToFront');
        });
    }
      
    function scopeSearchContent(url) {
        $('#scopesearchwindow').jqxWindow('open');
        $.get(url).done(function(data) {
            $('#scopesearchwindow').jqxWindow('setContent', data);
            $('#scopesearchwindow').jqxWindow('bringToFront');
        });
    }
      
    function getScopeGroup() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var scopeGroupItems = items[0].split(",");
                var scopeGroupIdItems = items[1].split(",");
                var optionsscopegroup = '<option value="">--Select--</option>';
                for (var i = 0; i < scopeGroupItems.length; i++) {
                    optionsscopegroup += '<option value="' + scopeGroupIdItems[i] + '">'
                            + scopeGroupItems[i] + '</option>';
                }
                $("select#cmbscopegroup").html(optionsscopegroup);
                if ($('#hidcmbscopegroup').val() != null) {
                    $('#cmbscopegroup').val($('#hidcmbscopegroup').val());
                }
            }
        }
        x.open("GET", "getScopeGroup.jsp?contrmode="+$('#txtcontrmode').val(), true);
        x.send();
    }
      
    function getScopeAMCDetails(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                
                if ($("#mode").val() == "A") {
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "scope" ,items[0]);
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "scopeid" ,items[1]);
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "product" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "productid" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "brand" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "brandname" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "unit" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "scopeamount" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "amount" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "unittotal" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "total" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "nettotal" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "margin" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "proname" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "prodoc" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "unitdocno" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "psrno" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "proid" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "specid" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "brandid" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "stdprice" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "marginper" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "lbrchg" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "scopestdcost" ,"");
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "scopeproduct" ,items[2]);
                     $('#materialGrid').jqxGrid('setcellvalue', 0, "qty" ,"");
                }
            }
        }
        x.open("GET", "getScopeAMCDetails.jsp?scopegroup="+$('#cmbscopegroup').val(), true);
        x.send();
    }
      
    function getPreSalesScopeAllowed(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#presalesscopeallowed').val(items);
                
                if(parseInt(items)==1){
                    $('#tblpresalesscope').show();
                    $('#cmbscopegroup').show();
                    document.getElementById("lblscopegroup").style.display = 'inline-block';
                    $('#materialGrid').jqxGrid('showcolumn', 'scope');
                    $('#materialGrid').jqxGrid('showcolumn', 'scopeamount');
                    $('#materialGrid').jqxGrid('showcolumn', 'unittotal');
                } else {
                    $('#tblpresalesscope').hide();
                    $('#cmbscopegroup').hide();
                    document.getElementById("lblscopegroup").style.display = 'none';
                    $('#materialGrid').jqxGrid('hidecolumn', 'scope');
                    $('#materialGrid').jqxGrid('hidecolumn', 'scopeamount');
                    $('#materialGrid').jqxGrid('hidecolumn', 'unittotal');
                }
            }
        }
        x.open("GET", "getPreSalesScopeAllowed.jsp", true);
        x.send();
    }
      
    function getTemplateDetailsADD(docno,site,siteid){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim().split('##');
                for(var i=0;i<items.length;i++) {
                    var data=items[i].split("::");
                    var desc1=data[0].trim()=="undefined" || data[0].trim()=="NaN" || data[0].trim()==""|| data[0].trim()==null?"0":data[0].trim().replace( "20%", " ");
                    var scope=data[1]=="undefined" || data[1]=="NaN" || data[1]==""|| data[1]==null?"0":data[1].trim();
                    var scopeid=data[2]=="undefined" || data[2]=="NaN" || data[2]==""|| data[2]==null?"0":data[2].trim();
                    var product=data[3].trim()=="undefined" || data[3].trim()=="NaN" || data[3].trim()==""|| data[3].trim()==null?"0":data[3].trim().replace( "20%", " ");
                    var productid=data[4]=="undefined" || data[4]=="NaN" || data[4]==""|| data[4]==null?"0":data[4].trim();
                    var activity=data[5]=="undefined" || data[5]=="NaN" || data[5]==""|| data[5]==null?"0":data[5].trim();
                    var activityid=data[6]=="undefined" || data[6]=="NaN" || data[6]==""|| data[6]==null?"0":data[6].trim();
                    var brandname=data[7]=="undefined" || data[7]=="NaN" || data[7]==""|| data[7]==null?"0":data[7].trim();
                    var unit=data[8]=="undefined" || data[8]=="NaN" || data[8]==""|| data[8]==null?"0":data[8].trim();
                    var scopeamount=data[9]=="undefined" || data[9]=="NaN" || data[9]==""|| data[9]==null?"0":data[9].trim();
                    var amount=data[10]=="undefined" || data[10]=="NaN" || data[10]==""|| data[10]==null?"0":data[10].trim();
                    var total=data[11]=="undefined" || data[11]=="NaN" || data[11]==""|| data[11]==null?"0":data[11].trim();
                    var nettotal=data[12]=="undefined" || data[12]=="NaN" || data[12]==""|| data[12]==null?"0":data[12].trim();
                    var margin=data[13].trim()=="undefined" || data[13].trim()=="NaN" || data[13].trim()==""|| data[13]==null?"0":data[13].trim();
                    var invoiced=data[14].trim()=="undefined" || data[14].trim()=="NaN" || data[14].trim()==""|| data[14]==null?"0":data[14].trim();
                    var proname=data[15].trim()=="undefined" || data[15].trim()=="NaN" || data[15].trim()==""|| data[15]==null?"0":data[15].trim().replace( "20%", " ");
                    var prodoc=data[16].trim()=="undefined" || data[16].trim()=="NaN" || data[16].trim()==""|| data[16]==null?"0":data[16].trim();
                    var unitdocno=data[17].trim()=="undefined" || data[17].trim()=="NaN" || data[17].trim()==""|| data[17]==null?"0":data[17].trim();
                    var psrno=data[18].trim()=="undefined" || data[18].trim()=="NaN" || data[18].trim()==""|| data[18]==null?"0":data[18].trim();
                    var proid=data[19].trim()=="undefined" || data[19].trim()=="NaN" || data[19].trim()==""|| data[19]==null?"0":data[19].trim();
                    var specid=data[20].trim()=="undefined" || data[20].trim()=="NaN" || data[20].trim()==""|| data[20]==null?"0":data[20].trim();
                    var stypeid=data[21].trim()=="undefined" || data[21].trim()=="NaN" || data[21].trim()==""|| data[21]==null?"0":data[21].trim();
                    var site=data[22].trim()=="undefined" || data[22].trim()=="NaN" || data[22].trim()==""|| data[22]==null?"0":data[22].trim().replace( "20%", " ");
                    var sertype=data[23].trim()=="undefined" || data[23].trim()=="NaN" || data[23].trim()==""|| data[23]==null?"0":data[23].trim();
                    var brandid=data[24].trim()=="undefined" || data[24].trim()=="NaN" || data[24].trim()==""|| data[24]==null?"0":data[24].trim();
                    var sitesrno=data[25].trim()=="undefined" || data[25].trim()=="NaN" || data[25].trim()==""|| data[25]==null?"0":data[25].trim();
                    var stdprice=data[26].trim()=="undefined" || data[26].trim()=="NaN" || data[26].trim()==""|| data[26]==null?"0":data[26].trim();
                    var marginper=data[27].trim()=="undefined" || data[27].trim()=="NaN" || data[27].trim()==""|| data[27]==null?"0":data[27].trim();
                    var lbrchg=data[28].trim()=="undefined" || data[28].trim()=="NaN" || data[28].trim()==""|| data[28]==null?"0":data[28].trim();
                    var scopestdcost=data[29].trim()=="undefined" || data[29].trim()=="NaN" || data[29].trim()==""|| data[29]==null?"0":data[29].trim();
                    var qty=data[30].trim()=="undefined" || data[30].trim()=="NaN" || data[30].trim()==""|| data[30]==null?"0":data[30].trim();
                     
                    var rows = $("#materialGrid").jqxGrid('getrows');
                    var rowindex=((rows.length)-1);
                    
                    $('#materialGrid').jqxGrid('setcellvalue',rowindex , "desc1" ,desc1);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scope" ,scope);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scopeid" ,scopeid);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "product" ,product);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "productid" ,productid);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "brand" ,brandname);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "brandname" ,brandname);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "unit" ,unit);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scopeamount" ,scopeamount);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "amount" ,amount);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "total" ,total);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "nettotal" ,nettotal);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "margin" ,margin);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "proname" ,proname);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "prodoc" ,prodoc);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "unitdocno" ,unitdocno);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "psrno" ,psrno);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "proid" ,proid);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "specid" ,specid);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "site" ,site);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "brandid" ,brandid);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "sitesrno" ,sitesrno);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "stdprice" ,stdprice);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "marginper" ,marginper);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "lbrchg" ,lbrchg);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scopestdcost" ,scopestdcost);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "stypeid" ,stypeid);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "sertype" ,sertype);
                    $('#materialGrid').jqxGrid('setcellvalue', rowindex, "qty" ,qty);
                }
                $("#overlay, #PleaseWait").hide();
            }
        }
        x.open("GET", "getTemplateDetails.jsp?docno="+docno+"&sitename="+site.replace(/ /g, "%20")+"&siteid="+siteid, true);
        x.send();
    }

    function funrevisionConfirm(){
        var trno = $('#masterdoc_no').val();
        var revision = $('#hidlatestrevno').val(); 
        if(revision=="" || revision=="0"){    
            $.messager.alert('Warning','There are no revisions to confirm.');   
            return false;
        }
        revmsg="Latest revision no is "+$("#hidlatestrevno").val()+" and you are confirming revision no "+$('#txtrevise').val();
        $.messager.confirm('Message', revmsg+'<br><b>Do you want to confirm?<b>', function(r){      
            if(r==false) {
                return false; 
            } else {
                 funconfirm(trno,$('#txtrevise').val());
            }
        });  
    }

    function funconfirm(trno,revision){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                if(parseInt(items)>0){
                     $.messager.alert('Message','Successfully Confirmed');   
                }else{
                     $.messager.alert('Message','Not Confirmed');     
                }
            }
        }
        x.open("GET", "confirmSave.jsp?trno="+trno+"&revision="+revision, true);      
        x.send();  
    }

    function editstatuscheck(){         
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.split("####");  	
                if(parseInt(items[0])>0) {  
                     $("#btnEdit").attr('disabled', true ); 
                     $("#btnDelete").attr('disabled', true ); 
                     $("#confirmbtn").attr('disabled', true );
                 }else{
                     $("#btnEdit").attr('disabled', false ); 
                     $("#btnDelete").attr('disabled', false );      
                     $("#confirmbtn").attr('disabled', false );
                 }
                 if(parseInt(items[1])>0 || parseInt(items[0])>0){       
                     $("#btnEdit").attr('disabled', true );  
                 }else{
                     $("#btnEdit").attr('disabled', false ); 
                 }   
                } 
        }
        x.open("GET", "getEditStat.jsp?masterdoc="+$('#masterdoc_no').val(), true);                       
        x.send();
    }

    function funConfirmConfig(){   
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
                var items= x.responseText;
                if(items==1){
                     $("#confirmbtn").show();  
                }else{
                     $("#confirmbtn").hide();
                }
         }
         }
         x.open("GET","getConfirmConfig.jsp",true);
         x.send();
    } 

    function isNumber(evt,id) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
             document.getElementById("errormsg").innerText="Enter Numbers Only.";
             $("#"+id+"").focus();
             return false;
        }
        document.getElementById("errormsg").innerText="";
        return true;
    }

    function funmaxlength(value,id){
        if(parseFloat(value)>100){
             document.getElementById("errormsg").innerText="Enter Numbers Upto 100.";
             $("#"+id+"").focus();
             $("#"+id+"").val(100);
             return false;
        }
         document.getElementById("errormsg").innerText="";
         return true;
    }

    function getclinfo(event){
         var x= event.keyCode;
         if(x==114){
          $('#clientsearch1').jqxWindow('open');
         clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
    } 

    function clientSearchContent(url) {
        $.get(url).done(function (data) {
           $('#clientsearch1').jqxWindow('setContent', data);
        }); 
    }

    function getcontact(event){
        var clientid=document.getElementById("clientid").value;
        if(clientid==""){
            document.getElementById("errormsg").innerText=" Select Client";
            return 0;
        }
        var x= event.keyCode;
         if(x==114){
          $('#cpinfowindow').jqxWindow('open');
           cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid); 
                 }
    }

    function cpSearchContent(url) {
         $.get(url).done(function (data) {
        $('#cpinfowindow').jqxWindow('setContent', data);
        }); 
    }

    function productSearchContent(url) {
         $.get(url).done(function (data) {
             $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
    } 

    function funReadOnly(){
        $('#frmEstimation input').attr('readonly', true );
        $('#frmEstimation select').attr('disabled', true);
        $('#date').jqxDateTimeInput({disabled: true});
        $('#btnSummary').attr('disabled', true );
        $('#btntemplateadd').attr('disabled', true );
        $("#materialGrid").jqxGrid({ disabled: true});
        
        if(modes=="view") {
            document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
            document.getElementById("formdetail").value=window.parent.formName.value;
            document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
            $('#doc_no').attr('disabled', false);
            $('#masterdoc_no').attr('disabled', false);
            $('#mode').attr('disabled', false);
            $('#cmbreftype').attr('disabled', false);
            $('#date').jqxDateTimeInput({ disabled: false}); 
            
            document.getElementById("masterdoc_no").value=mastertrno;
            document.getElementById("mode").value=modes;
            var loadid=2;
            var docno=mastertrno;

            document.getElementById("docno").value= '<%=docno%>';
            document.getElementById("txtreviseno").value='<%=reviseno%>';
            $('#date').jqxDateTimeInput('val','<%=date%>');
            $('#hiddate').jqxDateTimeInput('val','<%=date%>');
            document.getElementById("txtclient").value='<%=client%>';
            document.getElementById("clientid").value='<%=cldocno%>';
            document.getElementById("cmbreftype").value='<%=ref_type%>';
            document.getElementById("hidcmbreftype").value='<%=ref_type%>';
            document.getElementById("txtenquiry").value='<%=refdocno%>';
            document.getElementById("enquiryid").value='<%=reftrno%>';
            document.getElementById("txtmatotal").value='<%=material%>';
            
            document.getElementById("txtnettotal").value='<%=nettotal%>';
            document.getElementById("txtnettotalshow").value='<%=nettotal%>';
            document.getElementById("txtclientdet").value='<%=address%>';
            $('#cmbscopegroup').attr('disabled', false);
            var cmbreftype=$('#cmbreftype').val();
            if(cmbreftype!='DIR'){
                 $('#cmbreftype').attr('disabled', false);
            }
            refChange();
            $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
        
            $('#docno').attr('disabled', false);
            $('#mode').attr('disabled', false);
        }
        
        if(document.getElementById("status").value.trim()=="0" ) {
            mod1="view";
        }
            
        if(mod1=="A") {
            document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
            document.getElementById("formdetail").value=window.parent.formName.value;
            document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
            funCreateBtn();
        }
    } 

    function funRemoveReadOnly(){
        getPreSalesScopeAllowed();
        getScopeGroup();
        
        $('#frmEstimation input').attr('readonly', false );
        $('#frmEstimation select').attr('disabled', false);
        $('#date').jqxDateTimeInput({disabled: false});
        $('#btnSummary').attr('disabled', false );
        $('#btntemplateadd').attr('disabled', false );
        $('#docno').attr('readonly', true);
        $('#txtactivityname').attr('readonly', true );
        $('#txtclient').attr('readonly', true );
        $('#txtclientdet').attr('readonly', true );
        $('#txtreftype').attr('readonly', true );
        $('#txttemplatecode').attr('readonly', true );
        $('#txttemplatename').attr('readonly', true );
        $('#txtnettotalshow').attr('readonly', true );
        $("#materialGrid").jqxGrid({ disabled: false});
        
        if ($("#mode").val() == "E") {
            $('#txtenquiry').attr('disabled', false );
            $('#enquiryid').attr('disabled', false );
            $('#clientid').attr('disabled', false );
            $('#cmbreftype').attr('disabled', false );
            $('#cmbscopegroup').attr('disabled', false);
            $('#frmEstimation input').attr('readonly', true );
            $("#materialGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
            
            $('#gridtext').attr('readonly', false );
            $('#gridtext1').attr('readonly', false );
        }
        
        if ($("#mode").val() == "A") {
            $("#activitiesid").val("0");
            $("#txtreviseno").val("0");
            $('#date').val(new Date());
            $("#materialGrid").jqxGrid('clear');
            $("#materialGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
        }
        
        if(mod1=="A") {
             document.getElementById("txtclient").value='<%=client%>';
             document.getElementById("clientid").value='<%=cldocno%>';
             document.getElementById("txtclientdet").value='<%=address%>';
             document.getElementById("cmbreftype").value='<%=ref_type%>';
             document.getElementById("hidcmbreftype").value='<%=ref_type%>';
             document.getElementById("txtenquiry").value='<%=refdocno%>';
             document.getElementById("enquiryid").value='<%=reftrno%>';
             document.getElementById("hidenqtrno").value='<%=reftrno%>';
             document.getElementById("hidsurtrno").value='<%=surtrno%>';
             var cmbreftype=$('#cmbreftype').val();
             
             if(cmbreftype!='DIR'){
                 $('#cmbreftype').attr('disabled', false);
             }
             $('#cmbscopegroup').attr('disabled', false);
             refChange();
             if(cmbreftype=='ENQ'){
                 $("#materialDiv").load("materialDetailsGrid.jsp?enqtrno="+'<%=reftrno%>'+"&loadid=3");
             }
        }
        
        chkproductconfig();
    }

    function funExcelBtn(){
        if(parseInt(window.parent.chkexportdata.value)=="1") {
          JSONToCSVCon(materialexcel,$("#docno").val()+'/'+$("#txtclient").val(), true);
        }
    }

    function funSearchLoad(){
         changeContent('Mastersearch.jsp'); 
    }

    function funChkButton() {}

    function getsite(rowBoundIndex,reftrno,id){
          $('#sitewindow').jqxWindow('open');
          var reftype=$('#cmbreftype').val();
          var srvedocno=document.getElementById("txtenquiry").value;
          siteSearchContent("sitesearch.jsp?rowBoundIndex="+rowBoundIndex+"&reftrno="+reftrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=2");
    }
       
    function getsites(event){
         var x= event.keyCode;
         if(x==114){
                if($('#mode').val()!= "view") {
                    if(document.getElementById("cmbreftype").value!="DIR"){
                        $('#sitewindow').jqxWindow('open');
                          var reftype=$('#cmbreftype').val();
                          var srvedocno=$('#txtenquiry').val();
                          var surtrno=$('#hidsurtrno').val();
                          var enqtrno=$('#hidenqtrno').val();
                          var id=0;
                          
                          if(surtrno>0){
                             id=4;
                             siteSearchContent("sitesearch.jsp?reftrno="+surtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1"); 
                          } else {
                              id=3;
                              siteSearchContent("sitesearch.jsp?reftrno="+enqtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1");
                          }
                    } else {
                        $('#txtsite').attr('readonly', false );
                        $('#txtsite').val('');$('#txtsiteid').val('');
                    }
                }   
         }
    }

    function siteSearchContent(url) {
         $.get(url).done(function (data) {
        $('#sitewindow').jqxWindow('setContent', data);
        }); 
    }

    function funNotify(){
        if($('#clientid').val()=="") {
            document.getElementById("errormsg").innerText="select a Client";
            return 0;
        }
     
        var rows1 = $("#materialGrid").jqxGrid('getrows');
        document.getElementById("errormsg").innerText="";

        var griddesc="";
        var errorstatus=0;
        if(rows1.length=="0"){
            $.messager.alert('Message','Enter Proper Details','warning');
            errorstatus=1;
            return 0;
         } else{
                 for(var i=0;i<rows1.length;i++){   
                     if(rows1[i].prodoc>0) {
                         if(parseFloat(rows1[i].amount)>0 && parseFloat(rows1[i].stdprice)>=parseFloat(rows1[i].amount)){
                            document.getElementById("errormsg").innerText="Amount Should Be Greater than Standard Price ("+rows1[i].stdprice+")";
                            return 0;
                            errorstatus=1;
                         }
                     } else {
                        document.getElementById("errormsg").innerText="";
                         errorstatus=0;
                     }
                 }
         }    
         
         if(errorstatus==1){  
             return 0;
         }

         var reftype=$("#cmbreftype").val();
         var srno=0, gridlen=0, val1=0;    
         var amount=0.0;
         for(var i=0 ; i < rows1.length ; i++){
            if(!(rows1[i].desc1=="undefined" || typeof(rows1[i].desc1)=="undefined" || rows1[i].desc1==null || rows1[i].desc1=="") ||
                    !(rows1[i].stypeid=="undefined" || typeof(rows1[i].stypeid)=="undefined" || rows1[i].stypeid==null || rows1[i].stypeid=="") ||
                    !(rows1[i].prodoc=="undefined" || typeof(rows1[i].prodoc)=="undefined" || rows1[i].prodoc==null || rows1[i].prodoc=="")){   
                 
                newTextBox = $(document.createElement("input"))
                   .attr("type", "dil")
                   .attr("id", "mate"+i)
                   .attr("name", "mate"+i)
                   .attr("hidden", "true"); 
                 
                 if(reftype=="DIR"){
                     srno=srno+1;
                 }else{
                     srno=rows1[i].sitesrno;   
                 }
                
                 if(rows1[i].nettotal!="undefined" && typeof(rows1[i].nettotal)!="undefined" && rows1[i].nettotal!=null && rows1[i].nettotal!=""){
                    amount += rows1[i].nettotal;    
                 }
                
                 newTextBox.val(rows1[i].desc1+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].margin+" :: "+rows1[i].nettotal+" :: "+rows1[i].activityid+" :: "+rows1[i].site+" :: "+rows1[i].stypeid+" :: "+srno+" :: "+rows1[i].marginper+" :: "+rows1[i].scopeid+" :: "+rows1[i].scopeamount+" :: "+rows1[i].stdprice+" :: "+rows1[i].lbrchg+" :: "+rows1[i].scopestdcost+" :: " );
                 newTextBox.appendTo('form');
                 gridlen++; 
                 val1++;
            }
          }	
         
         if(val1 == 0){         
            $.messager.alert('Message','Enter Proper Details','warning');    
            return 0;
          }
        
         var netamount = $("#txtnettotal").val();
         if(parseFloat(netamount)!=parseFloat(amount)){         
            $.messager.alert('Message','Totals are not matching!!!','warning');        
            return 0;
          }
         
          $('#matgridlen').val(gridlen);    
          $('#cmbscopegroup').attr('disabled', false);   
          return 1;  
    } 
     
    function funFocus(){
        document.getElementById("txtclient").focus();
    }

    function funPrintBtn(){
        if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
            var url=document.URL;
            var reurl=url.split("saveEstimationnew");
            $("#docno").prop("disabled", false);                
            var brhid=<%= session.getAttribute("BRANCHID").toString()%>
            var dtype=$('#formdetailcode').val();
            var win= window.open(reurl[0]+"printestimation?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&trno="+trno+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            win.focus();
        } else {
            $.messager.alert('Message','Select a Document....!','warning');
            return false;
        } 
    }

    function setValues(){
        var netval=document.getElementById('txtnettotal').value;
        var grtotal=(parseFloat(netval));
        if(!netval.includes(",")){
            var newgrtot=grtotal.toLocaleString(undefined, {maximumFractionDigits:2});
            if(!newgrtot.includes(".")) {
                newgrtot=newgrtot+".00";
            }
            document.getElementById('txtnettotal').value=newgrtot;
        }
          
        var islegaldoc=$("#islegaldoc").val();
        
        if(islegaldoc>0){
            document.getElementById("chklegaldoc").checked=true;
            legChange();
        }

        if($('#hiddate').val()!=""){
             $("#date").jqxDateTimeInput('val', $('#hiddate').val());
        }
      
        if($('#hidcmbreftype').val()!=""){
             $("#cmbreftype").val($('#hidcmbreftype').val());
        }

        var docno=$("#masterdoc_no").val();
        var reviseno=$("#txtrevise").val();
        var rdo=document.getElementById("hidradio").value;
        
        if(rdo=='AMC'){
            document.getElementById("ramc").checked=true;
            if(document.getElementById("termstatus").value==1){
                document.getElementById("formdetailcode").value="SQOT-AMC";
            }
        }
        if(rdo=='SJOB'){
            document.getElementById("rsjob").checked=true;
            if(document.getElementById("termstatus").value==1){
                document.getElementById("formdetailcode").value="SQOT-SJOB";
            }
        }
        
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        
        if(docno>0){
            var dtype=$('#formdetailcode').val().trim();
            refChange();
            $("#siteDetailsDiv").load("siteGrid.jsp?docno="+docno);
            $("#serviceDetailsDiv").load("serviceGrid.jsp?docno="+docno+"&reviseno="+reviseno); 
            $("#termsDiv").load("termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno);
        }
          
        funSetlabel();
    }
  
    function getEnquiry(event){
        var clientid=document.getElementById("clientid").value;
        if(clientid>0){
            document.getElementById("errormsg").innerText="";
        } else{
            document.getElementById("errormsg").innerText="Select a client";
            return 0;
        } 
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

    function refChange(){
        var reftype=$('#cmbreftype').val();
        if(reftype=='DIR'){
            $('#txtenquiry').attr('disabled', true);
            $('#txtsite').attr('readonly', false);
            $('#txtsite').val('');$('#txtsiteid').val('');
        } else{
            $('#txtenquiry').attr('disabled', false);
            $('#txtenquiry').attr('readonly', true);
            $('#txtsite').attr('readonly', true);
            $('#txtsite').val('');$('#txtsiteid').val('');
            if (document.getElementById("txtsiteid").value == "") {
                $('#txtsite').attr('placeholder', 'Press F3 to Search'); 
            }
        }
    }

    function funTemplateLoadAdd(){
        var siteid=$('#txtsiteid').val();
        var templateid=$('#txttemplateid').val();
        var site=$('#txtsite').val();
        
        if(site==''){
            document.getElementById("errormsg").innerText="Site is Mandatory.";
            return 0;
        }
        
        if(templateid==''){
            document.getElementById("errormsg").innerText="Template is Mandatory.";
            return 0;
        }
        document.getElementById("errormsg").innerText="";
        
        $("#overlay, #PleaseWait").show();
        getTemplateDetailsADD(templateid,site,siteid);
    }
</script>
</head>
<body onload="setValues();getsjobtype();funConfirmConfig();" onmouseover="editstatuscheck();">   
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmEstimation" action="saveEstimationnew" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include>
        
        <div class="modern-ui hidden-scrollbar">
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Estimation Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div style="width: 125px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>
                    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Revise No.</label>
                    <input type="text" id="txtreviseno" name="txtreviseno" style="width:125px;" value='<s:property value="txtreviseno"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                    <input type="text" id="docno" name="docno" style="width:125px;" value='<s:property value="docno"/>' tabindex="-1" readonly/>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Client & Classification</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Customer</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtclient" name="txtclient" placeholder="Press F3" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtclient').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="txtclientdet" name="txtclientdet" style="flex:1; margin-left:15px;" value='<s:property value="txtclientdet"/>' tabindex="-1" readonly/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Ref. Type</label>
                    <select id="cmbreftype" name="cmbreftype" style="width:125px;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
                        <option value="DIR">DIR</option>
                        <option value="ENQ">ENQ</option>
                        <option value="SRVE">SRVE</option>
                    </select>
                    <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Enquiry</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtenquiry" name="txtenquiry" placeholder="Press F3" value='<s:property value="txtenquiry"/>' onKeyDown="getEnquiry(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtenquiry').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtcontrmode" name="txtcontrmode" value='<s:property value="txtcontrmode"/>'/>
                    
                    <label id="lblscopegroup" class="lbl-right" style="width:80px; margin-left:15px;">Scope Group</label>
                    <select id="cmbscopegroup" name="cmbscopegroup" style="width:125px;" onchange="getScopeAMCDetails();" value='<s:property value="cmbscopegroup"/>'>
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbscopegroup" name="hidcmbscopegroup" value='<s:property value="hidcmbscopegroup"/>'/>
                </div>
            </div>

            <div class="middle-panel" id="tblpresalesscope">
                <span class="middle-panel-title">Pre-sales Scope</span>
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Site</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtsite" name="txtsite" value='<s:property value="txtsite"/>' onKeyDown="getsites(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txtsite').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'/>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Template</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txttemplatecode" name="txttemplatecode" placeholder="Press F3" value='<s:property value="txttemplatecode"/>' onKeyDown="getTemplate(event);"/>
                        <svg class="magnifier-icon" onclick="$('#txttemplatecode').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txttemplateid" name="txttemplateid" value='<s:property value="txttemplateid"/>'/>
                    
                    <input type="text" id="txttemplatename" name="txttemplatename" style="flex:1; margin-left:8px;" tabindex="-1" value='<s:property value="txttemplatename"/>' readonly/>
                    <button class="myButton" type="button" id="btntemplateadd" name="btntemplateadd" onclick="funTemplateLoadAdd();" style="margin-left: 15px;">ADD</button>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Material Details</span>
                <div class="field-row" style="justify-content: flex-end; margin-bottom: 5px;">
                    <label class="lbl-right" style="font-size: 13px;">Total</label>
                    <input type="text" id="txtnettotalshow" name="txtnettotalshow" style="width:150px; text-align:right; font-weight:bold; color:#000000; background-color:#F2F4F4;" readonly tabindex="-1" value='<s:property value="txtnettotal"/>'/>
                    <input type="hidden" id="txtnettotal" name="txtnettotal" value='<s:property value="txtnettotal"/>'/>
                </div>
                
                <div id="materialDiv" class="grid-container" style="border:none;">
                    <jsp:include page="materialDetailsGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Logic Fields for Material Grid -->
            <div style="display:none;">
                <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>'/>   
                <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>'/> 
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
                <input type="hidden" id="enquiryid" name="enquiryid" value='<s:property value="enquiryid"/>'/>
                <input type="hidden" id="activitiesid" name="activitiesid" value='<s:property value="activitiesid"/>'/>
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                <input type="hidden" id="presalesscopeallowed" name="presalesscopeallowed" value='<s:property value="presalesscopeallowed"/>'/>
                <input type="hidden" id="txtmatotal" name="txtmatotal" value='<s:property value="txtmatotal"/>'/>
                <input type="hidden" id="txtlabtotal" name="txtlabtotal" value='<s:property value="txtlabtotal"/>'/>
                <input type="hidden" id="txteqptotal" name="txteqptotal" value='<s:property value="txteqptotal"/>'/>
                <input type="hidden" id="matgridlen" name="matgridlen" value='<s:property value="matgridlen"/>'/>
                <input type="hidden" id="labgridlen" name="labgridlen" value='<s:property value="labgridlen"/>'/>
                <input type="hidden" id="eqgridlen" name="eqgridlen" value='<s:property value="eqgridlen"/>'/>
                <input type="hidden" id="actgridlen" name="actgridlen" value='<s:property value="actgridlen"/>'/>
                <input type="hidden" id="hidestedit" name="hidestedit" value='<s:property value="hidestedit"/>'/>
                <input type="hidden" id="hidsurtrno" name="hidsurtrno" value='<s:property value="hidsurtrno"/>' />
                <input type="hidden" id="hidenqtrno" name="hidenqtrno" value='<s:property value="hidenqtrno"/>' />
                <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>' />
                <input type="hidden" id="txtgridservicetypeid" name="txtgridservicetypeid" value='<s:property value="txtgridservicetypeid"/>' />  
                <input type="hidden" id="txtgridscopeid" name="txtgridscopeid" value='<s:property value="txtgridscopeid"/>' />    
                <input type="hidden" name="txtgridscopeproduct" id="txtgridscopeproduct" value='<s:property value="txtgridscopeproduct"/>'>
            </div>
            
        </div>
    </form>

    <!-- Search Windows Outside of Form Content to prevent scrolling issues -->
    <div id="customerDetailsWindow"><div></div><div></div></div>
    <div id="activitysearchwindow"><div></div><div></div></div>
    <div id="clientsearch1"><div></div><div></div></div>
    <div id="sidesearchwndow"><div></div><div></div></div>
    <div id="lchargeinfowindow"><div></div><div></div></div>
    <div id="echargeinfowindow"><div></div><div></div></div>
    <div id="enquirywindow"><div></div><div></div></div>
    <div id="servicetypewindow"><div></div><div></div></div>
    <div id="sitewindow"><div></div><div></div></div>
    <div id="unitsearchwindow"><div></div><div></div></div>
    <div id="templatesearchwindow"><div></div><div></div></div>
    <div id="scopesearchwindow"><div></div><div></div></div>
</div>
</body>
</html>