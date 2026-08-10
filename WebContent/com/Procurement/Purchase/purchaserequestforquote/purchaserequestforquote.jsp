<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<%
    String mod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
    String rfqarrays = request.getParameter("rfqarray") == null? "0": request.getParameter("rfqarray").toString();
%>
<% String contextPath=request.getContextPath();%>

<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
.modern-ui .myButton, .modern-ui .btn {
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
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
.modern-ui .myButton:hover, .modern-ui .btn:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

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
    margin: 0;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    overflow-x: hidden;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
var mod1='<%=mod%>';
var rfqarrays='<%=rfqarrays%>';

$(document).ready(function () { 
    $('#btnvaluechange').hide();
    
    /* Configured for modern UI 24px height */
    $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    setTimeout(function () {
        $("#date").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#date").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#searchwndow').jqxWindow('close');
    $('#tremwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : { x : 420, y : 87 }, keyboardCloseKey: 27});
    $('#tremwndow').jqxWindow('close');
    $('#sidesearchwndow').jqxWindow({ width: '50%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27});
    $('#sidesearchwndow').jqxWindow('close');   
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close'); 
    $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
    $('#importwindow').jqxWindow('close');   
         
    if($('#reftypeval').val()=="CEQ" || $('#reftypeval').val()=="PR") {
         $("#btnDelete").attr('disabled', true );
    } else {
         $("#btnDelete").attr('disabled', false );
    }
           
    $('#rrefno').dblclick(function(){
        if($("#mode").val() == "A") {
            $('#refnosearchwindow').jqxWindow('open');
            refsearchContent('refnosearch.jsp?'); 
        }
    }); 
           
    $('#puraccid').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsSearch.jsp?');
        }
    });   
    
    $('#shipto').dblclick(function(){
        if($('#mode').val()!= "view") {
            shipSearchContent('shipmasterSearch.jsp?');
        }
    });   
});

function getshipdetails(event){
    var x= event.keyCode;
    if($('#mode').val()!="view") {
        if(x==114){ shipSearchContent('shipmasterSearch.jsp?'); }
    }
}  

function shipSearchContent(url) {
     $('#accountSearchwindow').jqxWindow('open');
       $.get(url).done(function (data) {
     $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}  

function shipdescSearchContent(url) {
       $.get(url).done(function (data) {
  $('#tremwndow').jqxWindow('open');
     $('#tremwndow').jqxWindow('setContent', data);
    }); 
}  

function termsSearchContent(url) {
    $('#tremwndow').jqxWindow('open');
      $.get(url).done(function (data) {
    $('#tremwndow').jqxWindow('setContent', data);
    $('#tremwndow').jqxWindow('bringToFront');
}); 
} 

function getrefno(event) {
     var x= event.keyCode;
     if(x==114){
      $('#refnosearchwindow').jqxWindow('open');
      refsearchContent('refnosearch.jsp?');  }
}  

function refsearchContent(url) {
    $.get(url).done(function (data) {
       $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
}

function importsearchcontent(url) {
       $('#importwindow').jqxWindow('open');
         $.get(url).done(function (data) {
       $('#importwindow').jqxWindow('setContent', data);
        }); 
}

function getaccountdetails(event){
     var x= event.keyCode;
    if($('#mode').val()!="view") {
     if(x==114){
      $('#accountSearchwindow').jqxWindow('open');
      accountSearchContent('accountsDetailsSearch.jsp?');    }
    }
}  

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}
      
function reqproductSearchContent(url) {
    $.get(url).done(function (data) {
         $('#sidesearchwndow').jqxWindow('open');
         $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 
      
function productSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 

function funReset(){
}

function funReadOnly(){
    $('#purchaseReqforqout input').attr('readonly', true );
    $('#purchaseReqforqout select').attr('disabled', true );
     $('#date').jqxDateTimeInput({ disabled: true});
        $("#serviecGrid").jqxGrid({ disabled: true});
         $("#shipdata").jqxGrid({ disabled: true});
         $('#rrefno').attr('disabled', true);
          $('#descPercentage').attr('disabled', true);
         $('#descountVal').attr('disabled', true);
         $('#chkdiscount').attr('disabled', true);  

         $('#producttype').val(0);  
        
            $("#jqxTerms").jqxGrid({ disabled: true});
            
             $('#btnCalculate').attr('disabled', true);
            
    $('#cmbcurr').attr('disabled', true);       
    $('#btnvaluechange').hide();
     $('#acctype').attr('disabled', true);
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
     document.getElementById("editdata").value="";
    
    if ($("#mode").val() == "A") {
     gridLoad();
     chkprocess();
    }
    $('#purchaseReqforqout input').attr('readonly', false );
    $('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
    $('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
    
    $('#purchaseReqforqout select').attr('disabled', false );
      $('#currate').attr('readonly', true);
      $('#puraccid').attr('readonly', true);
      $('#puraccname').attr('readonly', true);
      $('#rrefno').attr('disabled', true);
      $('#rrefno').attr('readonly', true);
         $('#btnvaluechange').hide();
        
         $('#shipto').attr('readonly', true);
         $('#shipaddress').attr('readonly', true);
         $('#contactperson').attr('readonly', true);
         $('#shiptelephone').attr('readonly', true);
         $('#shipmob').attr('readonly', true);
        
         $('#shipemail').attr('readonly', true);
         $('#shipfax').attr('readonly', true);  
         $('#producttype').val(0);  
        
    $('#date').jqxDateTimeInput({ disabled: false});
      $('#cmbcurr').attr('disabled', false);
     $('#acctype').attr('disabled', false);
    
    $('#docno').attr('readonly', true);
         $("#serviecGrid").jqxGrid({ disabled: false});

      $('#descPercentage').attr('disabled', true);
     $('#descountVal').attr('disabled', true);
     $('#docno').attr('readonly', true);
    
     $('#orderValue').attr('readonly', true);
     $('#productTotal').attr('readonly', true);
     $('#netTotaldown').attr('readonly', true);
    
     $("#shipdata").jqxGrid({ disabled: false});
    
    if ($("#mode").val() == "A") {
          $('#chkdiscount').attr('disabled', false);
        $('#date').val(new Date());
             $("#serviecGrid").jqxGrid('clear');
                $("#serviecGrid").jqxGrid('addrow', null, {});
                
                $("#jqxTerms").jqxGrid('addrow', null, {});
                $("#jqxTerms").jqxGrid({ disabled: false});
        
                $("#shipdata").jqxGrid('clear');
                $("#shipdata").jqxGrid('addrow', null, {});
   }
    
    if ($("#mode").val() == "E") {
        $("#serviecGrid").jqxGrid({ disabled: true});
        $("#shipdata").jqxGrid({ disabled: true});
        $("#jqxTerms").jqxGrid({ disabled: true});
           $('#btnCalculate').attr('disabled', true);
        
           var rows = $("#serviecGrid").jqxGrid('getrows');
            var aa=0;
            for(var i=0;i<rows.length;i++){
               if(parseInt(rows[i].clstatus)==1) { aa=1; break; }
               else{ aa=0; } 
            }
           if(parseInt(aa)==1) {
              $('#serviecGrid').jqxGrid('render');
             $('#btnvaluechange').hide();
           } else {
             $('#btnvaluechange').show();
           }
    }  
    getCurrencyIds();
    if(mod1=="A") {
        $("#sevdesc").load("serviecgrid.jsp?rfqarray="+'<%=rfqarrays.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
    }
    chkproductconfig();
}

function chkproductconfig() {
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200) {
      var items= x.responseText.trim();
      if(parseInt(items)>0) {
           document.getElementById("productchk").value=1;
             $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',false);
            $('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',false);
       } else {
               document.getElementById("productchk").value=0; 
               $('#serviecGrid').jqxGrid('setcolumnproperty','productid','editable',true);
               $('#serviecGrid').jqxGrid('setcolumnproperty','productname','editable',true);
      }
   }
   }
   x.open("GET","checkproductconfig.jsp?",true);
   x.send();
}

function gridLoad(){
      var dtype=document.getElementById("formdetailcode").value;
      $("#termsDiv").load("termsGrid.jsp?dtype="+dtype);
}

function funFocus(){
    $('#date').jqxDateTimeInput('focus');           
}

function funNotify(){   
    var purid= document.getElementById("puraccid").value;
    if(purid=="") {
         document.getElementById("errormsg").innerText=" Select An Account";
         document.getElementById("puraccid").focus();
         return 0;
    } else {
         document.getElementById("errormsg").innerText="";
    }
       
    if(document.getElementById('reftype').value=="DIR") {
    } else {
        if(document.getElementById("rrefno").value=="") {
         document.getElementById("errormsg").innerText="Search Sales Enquiry";  
         document.getElementById("rrefno").focus();
         return 0;
        }
    }  
       
    var refval= document.getElementById("nettotal").value;
    if(refval=="") {
        document.getElementById("nettotal").value=0;
    } else {
         document.getElementById("errormsg").innerText="";
    }

    var rows = $("#serviecGrid").jqxGrid('getrows');
    $('#serviecGridlength').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
           newTextBox = $(document.createElement("input")) 
              .attr("type", "dil")
              .attr("id", "sertest"+i)
              .attr("name", "sertest"+i)
              .attr("hidden", "true");          
          newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
                   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
                   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper); 
          newTextBox.appendTo('form');
    }   

    var rowsShip = $("#shipdata").jqxGrid('getrows');
    $('#shipdatagridlenght').val(rowsShip.length);
    for(var i=0 ; i < rowsShip.length ; i++){
       newTextBox = $(document.createElement("input"))
          .attr("type", "dil")
          .attr("id", "shiptest"+i)
          .attr("name", "shiptest"+i)
          .attr("hidden", "true"); 
      newTextBox.val(rowsShip[i].doc_nos+"::"+rowsShip[i].desc1+" :: "+rowsShip[i].refno+" :: "+rowsShip[i].date+" :: ");
      newTextBox.appendTo('form');
    }  

       var termrows = $("#jqxTerms").jqxGrid('getrows');
          $('#termsgridlength').val(termrows.length);
          for(var i=0 ; i < termrows.length ; i++){ 
               newTextBox = $(document.createElement("input"))
                  .attr("type", "dil")
                  .attr("id", "termg"+i)
                  .attr("name", "termg"+i)
                  .attr("hidden", "true");
              newTextBox.val(termrows[i].voc_no+"::"+termrows[i].dtype+"::"+termrows[i].terms+"::"+termrows[i].conditions+"::");
              newTextBox.appendTo('form');
          }
       
        if ($("#mode").val() == "E") {
             if($('#reftypeval').val()!="DIR") {
              $('#rrefno').attr('disabled', false);
              $('#rrefno').attr('readonly', true);
             }
             $('#chkdiscount').attr('disabled', false);
               if(document.getElementById("chkdiscountval").value==1) {
                 document.getElementById("chkdiscount").value = 1;
                 $('#descPercentage').attr('disabled', false);
                 $('#btnCalculate').attr('disabled', false);
                 $('#descountVal').attr('disabled', false);
               }
                  $('#rrefno').attr('disabled', false);
                  $('#rrefno').attr('readonly', true);
            $("#serviecGrid").jqxGrid({ disabled: false});
            $("#jqxTerms").jqxGrid({ disabled: false});  
        } 
    return 1;
} 

function funwarningopen(){
       $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
           if (r){
               $('#chkdiscount').attr('disabled', false);
               if(document.getElementById("chkdiscountval").value==1) {
                  document.getElementById("chkdiscount").checked = true;
                  document.getElementById("chkdiscount").value = 1;
                  $('#descPercentage').attr('disabled', false);
                  $('#btnCalculate').attr('disabled', false);
                  $('#descountVal').attr('disabled', false);
               }
               
               document.getElementById("editdata").value="Editvalue";
               
               $("#jqxTerms").jqxGrid({ disabled: false});
               $("#serviecGrid").jqxGrid({ disabled: false});
               $("#shipdata").jqxGrid({ disabled: false});
               $("#shipdata").jqxGrid('addrow', null, {});
               $("#serviecGrid").jqxGrid('addrow', null, {});
               $("#jqxTerms").jqxGrid('addrow', null, {});
           }
          });
       }

function funChkButton() {
}

function funSearchLoad(){
    changeContent('mainsearch.jsp'); 
}

function getCurrencyIds(){
       var x=new XMLHttpRequest();
       x.onreadystatechange=function(){
       if (x.readyState==4 && x.status==200) {
          var items= x.responseText;
          items=items.split('####');
               var curidItems=items[0];
               var curcodeItems=items[1];
               var currateItems=items[2];
               var multiItems=items[3];
               var optionscurr = '';
               if(curcodeItems.indexOf(",")>=0){
                curidItems.split(",");
                curcodeItems.split(",");
                currateItems.split(",");
                for ( var i = 0; i < curcodeItems.length; i++) {
               optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
               }
                $("select#cmbcurr").html(optionscurr);
            } else {
                   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                   $("select#cmbcurr").html(optionscurr);
                   funRoundRate(currateItems,"currate");
                   $('#currate').attr('readonly', true);
            }
        }
           }
       x.open("GET","getCurrencyId.jsp",true);
        x.send();
}
       
function getRatevalue(angel) {
       var x=new XMLHttpRequest();
       x.onreadystatechange=function(){
       if (x.readyState==4 && x.status==200) {
          var items= x.responseText;
             funRoundRate(items,"currate"); 
        }
       }
       x.open("GET","getRateTo.jsp?curr="+a,true);
        x.send();
}
       
function combochange() {
           if($('#cmbcurrval').val()!="") {
              $('#cmbcurr').val($('#cmbcurrval').val());   
           }
           if($('#reftypeval').val()!="") {
              $('#reftype').val($('#reftypeval').val());
           }
             if($('#reftypeval').val()!="DIR") {
              $('#rrefno').attr('disabled', false);
             $('#rrefno').attr('readonly', true);
           }
         if(document.getElementById("chkdiscountval").value==1) {
          document.getElementById("chkdiscount").checked = true;
          document.getElementById("chkdiscount").value = 1;
         } else {
          document.getElementById("chkdiscount").checked = false;
          document.getElementById("chkdiscount").value = 0;
         }
}

function setValues() {
        if($('#hiddate').val()){
            $("#date").jqxDateTimeInput('val', $('#hiddate').val());
        }
        var dis=document.getElementById("masterdoc_no").value;
        if(dis>0) {     
            funchkforedit();
             var indexval1 = document.getElementById("masterdoc_no").value;   
                     $("#descdetail").load("descgridDetails.jsp?purdoc="+indexval1);
                     var reftypeval = document.getElementById("reftypeval").value;  
                     var reqmasterdocno = document.getElementById("reqmasterdocno").value;  
                     $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&reqmasterdocno="+reqmasterdocno);
                     $("#termsDiv").load("termsGrid.jsp?masterdoc="+indexval1);
                     $("#shipdetdiv").load("shipdetailsGrid.jsp?masterdoc="+indexval1+"&formcode="+$('#formdetailcode').val());
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
        var reurl=url.split("savepurchaseReqforqout");
        $("#docno").prop("disabled", false);
  var branch=$('#brchName').val();
    var win= window.open(reurl[0]+"printpurchaseReqforqout?docno="+document.getElementById("masterdoc_no").value+"&branch="+branch,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();
       } else {
              $.messager.alert('Message','Select a Document....!','warning');
              return false;
       }
}

$(function(){
        $('#purchaseReqforqout').validate({
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

function fundisable() {
       if (document.getElementById('chkdiscount').checked) {
    $.messager.confirm('Confirm', 'Line Discount Will Override With Bill Discount', function(r){
        if (r==false){
            document.getElementById('chkdiscount').checked=false;
            return 0;
        } else {
           if (document.getElementById('chkdiscount').checked) {
              $('#descPercentage').attr('disabled', false);
             $('#descountVal').attr('disabled', false);
             $('#btnCalculate').attr('disabled', false);
           }
        }
      });
       } else {
       document.getElementById('descPercentage').value="";
       document.getElementById('descountVal').value="";
       var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
       document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
       $('#descPercentage').attr('disabled', true);
         $('#descountVal').attr('disabled', true);
         $('#btnCalculate').attr('disabled', true);
            $('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
            $('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", true);
       }
}

function funcalcu() {
    document.getElementById('prddiscount').value="";
    $('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
    $('#serviecGrid').jqxGrid('setcolumnproperty', 'discper',  "editable", false);
    var  productTotal=document.getElementById('productTotal').value;
    var  descPercentage=document.getElementById('descPercentage').value;
    var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
    var netval=parseFloat(productTotal)-parseFloat(descvalue);
    
     var rows = $('#serviecGrid').jqxGrid('getrows');
      var rowlength= rows.length-1;
    var disval=parseFloat(descvalue)/(parseInt(rowlength));
    
            for(var i=0;i<rowlength;i++) {
                var totamt=rows[i].total;
                var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
                var discper=(100/parseFloat(totamt))*parseFloat(discounts);
                var nettot=parseFloat(totamt)-parseFloat(discounts);
                $('#serviecGrid').jqxGrid('setcellvalue',i, "discount" ,discounts);
                $('#serviecGrid').jqxGrid('setcellvalue',i, "discper" ,discper);
                $('#serviecGrid').jqxGrid('setcellvalue',i, "nettotal" ,nettot);
             }
    
            var  productTotal=document.getElementById('productTotal').value;
            var  descPercentage=document.getElementById('descPercentage').value;
            var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
            var netval=parseFloat(productTotal)-parseFloat(descvalue);
            var  roundOf=document.getElementById('roundOf').value;
            
             if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") {
                 netval=parseFloat(netval)+parseFloat(roundOf);
            }
                funRoundAmt(descvalue,"descountVal");
                funRoundAmt(netval,"netTotaldown");
                var aa;
                 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") {
                       aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
                   } else {
                    aa=document.getElementById("netTotaldown").value;
                   }
                funRoundAmt(aa,"orderValue");
}
    
function funvalcalcu() {
    document.getElementById('prddiscount').value="";
    $('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
    var  productTotal=document.getElementById('productTotal').value;
    var  descountVal=document.getElementById('descountVal').value;
    var descper=(100/parseFloat(productTotal))*parseFloat(descountVal);
    var netval=parseFloat(productTotal)-parseFloat(descountVal);
    funRoundAmt(descper,"descPercentage");
    funRoundAmt(netval,"netTotaldown");
    funcalcu();
}
    
function roundval() {
    var roundOf=document.getElementById('roundOf').value;
    if(roundOf!="") {
      var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
      var  netTotaldown=summaryData.sum.replace(/,/g,'');
        var  netval=parseFloat(netTotaldown)+parseFloat(roundOf);
        funRoundAmt(netval,"netTotaldown"); 
       var ordertotal="0";
          var nettotalval="0";
          if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) {
            nettotalval=parseFloat(document.getElementById("nettotal").value);
         }
       ordertotal=parseFloat(nettotalval)+parseFloat(document.getElementById("netTotaldown").value);
        funRoundAmt(ordertotal,"orderValue");
    }
} 
    
function funrefdisslno() {
     if(document.getElementById('reftype').value=="DIR") {
          $('#rrefno').attr('disabled', true);
          $('#rrefno').attr('readonly', true);
          document.getElementById("errormsg").innerText="";
             document.getElementById("rrefno").value="";
             document.getElementById("reqmasterdocno").value="";
             $("#serviecGrid").jqxGrid('clear');
             $("#serviecGrid").jqxGrid('addrow', null, {});
         } else {
          $('#rrefno').attr('disabled', false);
          $('#rrefno').attr('readonly', true);
             document.getElementById("rrefno").value="";
             document.getElementById("reqmasterdocno").value="";
             $("#serviecGrid").jqxGrid('clear');
             $("#serviecGrid").jqxGrid('addrow', null, {});
         }
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

function isNumber1(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
                 if (iKeyCode == 45) {
                  return true;
                 } 
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
           document.getElementById("errormsg").innerText=" Enter Numbers Only";  
            return false;
        }
        document.getElementById("errormsg").innerText="";  
        return true;
}
</script>

</head>
<body onLoad="getCurrencyIds();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="purchaseReqforqout" action="savepurchaseReqforqout" method="post" autocomplete="off"> 
<jsp:include page="../../../../header.jsp" />    
<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>
    
    <!-- 1. Header Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Header Details</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
            
            <label class="lbl-right" style="width:80px;">Ref No</label>
            <input type="text" name="refno" id="refno" style="width:125px;" value='<s:property value="refno"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:125px;" tabindex="-1" value='<s:property value="docno"/>' readonly>
        </div>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select name="cmbcurr" id="cmbcurr" style="width:125px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>
            
            <label class="lbl-right" style="width:80px;">Rate</label>
            <input type="text" name="currate" id="currate" style="width:125px; text-align:right;" value='<s:property value="currate"/>'>
        </div>
    </div>

    <!-- 2. Vendor & Reference Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Vendor & Settings</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Vendor</label>
            <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
            <div class="input-search-container" style="flex:1;">
                <input type="text" name="puraccid" id="puraccid" placeholder="Press F3" value='<s:property value="puraccid"/>' onKeyDown="getaccountdetails(event);">
                <svg class="magnifier-icon" onclick="$('#puraccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="text" id="puraccname" name="puraccname" style="flex:1;" tabindex="-1" value='<s:property value="puraccname"/>' readonly>
        </div>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Ref Type</label>
            <select name="reftype" id="reftype" style="width:125px;" value='<s:property value="reftype"/>' onchange="funrefdisslno()">
                <option value="DIR">DIR</option>
                <option value="CEQ">CEQ</option>
                <option value="PR">PR</option>
            </select>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Ref Search</label>
            <div class="input-search-container" style="width: 180px;">
                <input type="text" name="rrefno" id="rrefno" placeholder="Press F3" value='<s:property value="rrefno"/>' onKeyDown="getrefno(event);">
                <svg class="magnifier-icon" onclick="$('#rrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
        </div>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" name="purdesc" id="purdesc" style="flex:1;" value='<s:property value="purdesc"/>'>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
        </div>
    </div>
    
    <!-- 3. Services Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Services</span>
        <div id="sevdesc" class="grid-container" style="border:none;">
            <jsp:include page="serviecgrid.jsp"></jsp:include>
        </div>
    </div>
    
    <!-- 4. Shipping Details -->
    <div style="display:flex; gap:15px;">
        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Shipping Details</span>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Name</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="shipto" name="shipto" placeholder="Press F3" value='<s:property value="shipto"/>' onkeydown="getshipdetails(event);">
                    <svg class="magnifier-icon" onclick="$('#shipto').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Address</label>
                <input type="text" id="shipaddress" name="shipaddress" style="flex:1;" value='<s:property value="shipaddress"/>'>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Contact Person</label>
                <input type="text" id="contactperson" name="contactperson" style="flex:1;" value='<s:property value="contactperson"/>'>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Telephone</label>
                <input type="text" id="shiptelephone" name="shiptelephone" style="width:125px;" value='<s:property value="shiptelephone"/>'>
                
                <label class="lbl-right" style="width:60px; margin-left:auto;">MOB</label>
                <input type="text" id="shipmob" name="shipmob" style="width:125px;" value='<s:property value="shipmob"/>'>
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Email</label>
                <input type="text" id="shipemail" name="shipemail" style="width:125px;" value='<s:property value="shipemail"/>'>
                
                <label class="lbl-right" style="width:60px; margin-left:auto;">FAX</label>
                <input type="text" id="shipfax" name="shipfax" style="width:125px;" value='<s:property value="shipfax"/>'>
            </div>
        </div>

        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Shipment Records</span>
            <div id="shipdetdiv" class="grid-container" style="border:none; height: 100%; margin: 0;">
                <jsp:include page="shipdetailsGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
    
    <!-- 5. Terms and Conditions -->
    <div class="middle-panel">
        <span class="middle-panel-title">Terms and Conditions</span>
        <div id="termsDiv" class="grid-container" style="border:none; margin:0;">
            <jsp:include page="termsGrid.jsp"></jsp:include>
        </div>
    </div>
    
    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>'/>   
        <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>'/> 
        <input type="hidden" class="textbox" id="orderValue" readonly tabindex="-1" name="orderValue" value='<s:property value="orderValue"/>'/>
        <input type="hidden" id="chkdiscountval" name="chkdiscountval" value='<s:property value="chkdiscountval"/>'/>      
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>   
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>   
        <input type="hidden" id="serviecGridlength" name="serviecGridlength" value='<s:property value="serviecGridlength"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>    
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>
        <input type="hidden" id="reqmasterdocno" name="reqmasterdocno" value='<s:property value="reqmasterdocno"/>'/>
        <input type="hidden" id="producttype" name="producttype" value='<s:property value="producttype"/>'/>
        <input type="hidden" id="termsgridlength" name="termsgridlength" value='<s:property value="termsgridlength"/>'/>
        <input type="hidden" id="editdata" name="editdata" value='<s:property value="editdata"/>'/>
        <input type="hidden" id="shipdocno" name="shipdocno" value='<s:property value="shipdocno"/>'/>
        <input type="hidden" id="shipdatagridlenght" name="shipdatagridlenght" value='<s:property value="shipdatagridlenght"/>'/>
        <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>'/>
        
        <input type="text" name="productTotal" readonly id="productTotal" value='<s:property value="productTotal"/>'>
        <input type="checkbox" value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)">
        <input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);">
        <button type="button" id="btnCalculate" title="Calculate" onclick="funcalcu();"><img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png"></button> 
        <input type="text" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);">
        <input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>' onkeypress="javascript:return isNumber (event);">
        <input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);">
        <input type="text" name="netTotaldown" readonly id="netTotaldown" value='<s:property value="netTotaldown"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);">
    </div>

</div>
</form>

<!-- Search Windows -->
<div id="refnosearchwindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="sidesearchwndow"><div></div></div>
<div id="importwindow"><div></div></div>
<div id="searchwndow"><div></div></div>
<div id="tremwndow"><div></div></div>

</div>
</body>
</html>