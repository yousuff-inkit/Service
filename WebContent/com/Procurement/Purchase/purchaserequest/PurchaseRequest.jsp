<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<%
    String mod = request.getParameter("mod") == null ? "view" : request
            .getParameter("mod").toString();
 String purchasearray = request.getParameter("purchasearray") == null? "0": request.getParameter("purchasearray").toString() ;
 System.out.println("purchasearray==="+purchasearray);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include> 
 
 <%
    String contextPath=request.getContextPath();
    //For PurchaseMgmt Bi View
    String bimod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
    String brch = request.getParameter("brch") == null ? "" : request.getParameter("brch").toString();
    String chck1 = request.getParameter("chk1") == null ? "" : request.getParameter("chk1").toString();
    String  docnotemp = request.getParameter("docno") == null? "0": request.getParameter("docno").toString() ;
 %>
 
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
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }

/* Retained Original Overrides */
#psearch { background:#FAEBD7; }
</style>

<script type="text/javascript">
var mod1='<%=mod%>';
var prcharray='<%=purchasearray%>';

//For purchaseMgmt Bi View
var bimode='<%=bimod%>';
var temp_doc='<%=docnotemp%>'; 
var chck1='<%=chck1%>';
var bibranch='<%=brch%>';

$(document).ready(function () {
     
     /* Configured for modern UI 24px height */
     $("#reqmasterdate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});   
     setTimeout(function () {
        $("#reqmasterdate").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#reqmasterdate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
     }, 0);

     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
     $('#sidesearchwndow').jqxWindow('close');   
     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
     $('#searchwindow').jqxWindow('close');
     
     $('#itemdocno').dblclick(function(){
            if($("#mode").val() == "A" || $("#mode").val() == "E") {
                $('#searchwindow').jqxWindow('open');
            if(document.getElementById("itemtype").value=="1") {
                refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value);   
            }
            else if(document.getElementById("itemtype").value=="6") {
                refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?');   
            }
            else {
                 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value);     
            }
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
            var docno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-doc_no');
            var method = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-method');

            document.getElementById("sqotprdid").value=prdid;
            document.getElementById("unit").value=unit;
            document.getElementById("brand").value=brand;
            document.getElementById("psrno").value=psrno;
            document.getElementById("unitdocno").value=unitdoc;
            document.getElementById("specid").value=specid;
            document.getElementById("doc_no").value=docno;
            document.getElementById("method").value=method;
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
            var docno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-doc_no');
            var method = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-method');

            document.getElementById("sqotprdname").value=prdname;
            document.getElementById("unit").value=unit;
            document.getElementById("brand").value=brand;
            document.getElementById("psrno").value=psrno;
            document.getElementById("unitdocno").value=unitdoc;
            document.getElementById("specid").value=specid;
            document.getElementById("doc_no").value=docno;
            document.getElementById("method").value=method;
            getunit(psrno);
             }
            });
});
 
function getProduct() {
        var dates=document.getElementById("reqmasterdate").value;
        var dtype='PR';
        var presulttype='1';
        var optionsyear = "";
        var optionsyearnw = "";
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                var prddatas=JSON.parse(items.trim());          
                    
                        $.each(prddatas, function( index, value ) {
                             optionsyearnw += '<option value="' + value.part_no + '" data-prdname="' + value.productname + '" data-unit="' + value.unit + '" data-brand="' + value.brandname + '" data-psrno="' + value.psrno + '" data-specid="' + value.specid + '" data-unitdoc="' + value.munit + '"data-doc_no="' + value.doc_no + '"data-method="' + value.method + '"></option>';
                                
                                optionsyear += '<option value="' + value.productname + '" data-prdid="' + value.part_no + '" data-unit="' + value.unit + '" data-brand="' + value.brandname + '" data-psrno="' + value.psrno + '" data-specid="' + value.specid + '" data-unitdoc="' + value.munit +  '"data-doc_no="' + value.doc_no + '"data-method="' + value.method + '"></option>';      
                                });
                        console.log(optionsyear)
                        console.log(optionsyearnw) 
                        $("datalist#sqotprdts").html(optionsyear);
                    $("datalist#sqotproductid").html(optionsyearnw);            
            } else {
            }
        }
        x.open("GET", '../getProduct.jsp?&dates=' + dates +'&dtype='+dtype+'&presulttype='+presulttype, true);
        x.send();
    }
 
 function getitem(event){
     var x= event.keyCode;
     if(x==114){
          $('#searchwindow').jqxWindow('open');
            
        if(document.getElementById("itemtype").value=="1") 
        {
        refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value);   
        }
        else if(document.getElementById("itemtype").value=="6")
        {
         refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?');  
        }
    else
        {
         refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value);    
        }
     }
     else{
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
    
    function funReset(){
    }
    function funReadOnly(){
        $('#frmpurReq input').attr('readonly', true );
        $('#frmpurReq textarea').attr('readonly', true );
        $('#frmpurReq select').attr('disabled', true);
         $('#psearch').attr('disabled', true );
         $('#setbtn_ps').attr('disabled', true ); 
         $('#setbtn').attr('disabled', true ); 
        $('#reqmasterdate').jqxDateTimeInput({ disabled: true});
        
        $("#purchasedetails").jqxGrid({ disabled: true});
        
         if(document.getElementById("status").value.trim()=="0" )
            {
            mod1="view";
            }
            if(mod1=="A")
                {
                 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
                document.getElementById("formdetail").value=window.parent.formName.value;
                document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
                funCreateBtn();
                }
            if(bimode=="viewBI"){
                 if(temp_doc>0){
                     <%
                     if(chck1.equalsIgnoreCase("1")){
                            session.setAttribute("BRANCHID", brch);
                        }

                     %>
                     document.getElementById("docno").value=temp_doc;
                        document.getElementById("mode").value="view";
                        window.parent.branchid.value=bibranch;
                        bimode="";
                        <%bimod="";%>
                        document.getElementById("frmpurReq").submit();
                 }
                }
    }
    function funRemoveReadOnly(){
         chkmultiqty();
        $('#frmpurReq input').attr('readonly', false );
        $('#frmpurReq textarea').attr('readonly', false );
        $('#frmpurReq select').attr('disabled', false);
    
        $('#reqmasterdate').jqxDateTimeInput({ disabled: false});
    
        $("#purchasedetails").jqxGrid({ disabled: false});
        $('#docno').attr('readonly', true);
        if ($("#mode").val() == "A") {
            getProduct();
            $('#reqmasterdate').val(new Date());

          
             $("#purchasedetails").jqxGrid('clear');
                $("#purchasedetails").jqxGrid('addrow', null, {});
           }
        
         if(mod1=="A")
            {
                $("#vehpurcgasereq").load("purreqDetails.jsp?prcharray="+'<%=purchasearray.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
            }
        
         chkcostcode();
         
         $('#itemdocno').attr('readonly', true);
         $('#itemname').attr('readonly', true);
         
         chkproductconfig();
            $('#psearch').attr('disabled', false );
            $('#setbtn_ps').attr('disabled', false ); 
               $('#setbtn').attr('disabled', false );
        
    }
    
    function funNotify(){   
         var rows = $("#purchasedetails").jqxGrid('getrows');
            $('#reqgridlenght').val(rows.length);
           for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "reqtest"+i)
               .attr("name", "reqtest"+i)  
            .attr("hidden", "true"); 
            
            newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "+rows[i].specid+" :: ");
        
           newTextBox.appendTo('form');
           }   
        
        return 1;
    } 

    function funChkButton() {
        frmpurReq.submit();
    }

    function funSearchLoad(){
         changeContent('mainsearch.jsp?'); 
    }
   $(function(){
        $('#frmpurReq').validate({
                rules: { 
                    purdesc:{maxlength:100}
                 },
                 messages: {
                     purdesc: {maxlength:" Max 100 chars"}
                 }
        });});
    
        
    function funFocus(){
        
        $('#reqmasterdate').jqxDateTimeInput('focus');          
    } 
    
    function setValues() {
        if($('#hidreqmasterdate').val()){
            $("#reqmasterdate").jqxDateTimeInput('val', $('#hidreqmasterdate').val());
        }
        
      var docVal1 = document.getElementById("masterdoc_no").value;
      
        if(docVal1>0)
            {
         var indexVal2 = document.getElementById("masterdoc_no").value;
         $("#vehpurcgasereq").load("purreqDetails.jsp?reqdoc="+indexVal2);
            funchkforedit(); 
            }
        if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
    
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
          funSetlabel();
    }
    
    function funPrintBtn(){
       if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
       var url=document.URL;
         var reurl=url.split("savepurreqdata");
  var brhid=<%=session.getAttribute("BRANCHID").toString()%>
             var dtype=$('#formdetailcode').val();
  
   var win= window.open(reurl[0]+"printPurchaseReqLd?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");  
 win.focus();
       } 
      
       else {
                   $.messager.alert('Message','Select a Document....!','warning');
                   return false;
                 }
            
    }
    
    function funchkforedit()
    {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();  
                if(parseInt(items)>0)
                    {
                     $("#btnEdit").attr('disabled', true );
                     $("#btnDelete").attr('disabled', true ); 
                    }
            } else {
            }
        }
        x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
        x.send();
    }
    
     function getitemtype(){ 
        
            
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              items= x.responseText;
               
              items=items.split('####');
                   var docno=items[0].split(",");
                   var type=items[1].split(",");
                
                   var optionstype = '';

        
                   for ( var i = 0; i < type.length; i++) {
                       optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
                    }
                    
                     $("select#itemtype").html(optionstype);    
                    
                
                     if($('#hideitemtype').val()!="")
                      {
                      $('#itemtype').val($('#hideitemtype').val());   
                      }
            }
               }
           x.open("GET","getitem.jsp?",true);
            x.send();
                }
    
     
     function chkcostcode()
     {
        
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
         {
           var items= x.responseText.trim();
          
           if(parseInt(items)>0)
            {
               
               document.getElementById("costcheck").value=1;
               $('#hcostcodes').show();
             }
               else
           { 
                   document.getElementById("costcheck").value=0;
                   $('#hcostcodes').hide();
           }
           
            }}
        x.open("GET","<%=contextPath%>/com/Procurement/Purchase/costcodesearch/checkcostcode.jsp?",true);
        x.send();
     } 
     
     function cleardata()
     {
         document.getElementById("itemdocno").value="";
         document.getElementById("itemname").value="";
     }
     function getunit(val){ 
        
            
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
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
        function setgrid()
         {
             var temppsrno=document.getElementById("psrno").value; 
             var unit=document.getElementById("unit").value; 
            
        var rows1 = $("#purchasedetails").jqxGrid('getrows');
        var aa=0;
        for(var i=0;i<rows1.length;i++){
    
            
             
           if(parseInt(rows1[i].prodoc)==parseInt(temppsrno))
               {
          
                 if((parseInt(document.getElementById("multimethod").value)==1))
                {   
                   
               if(parseInt(rows1[i].unitdocno)==parseInt(unit))
               {
                   
                   aa=1;
                   break;
               }
                }
                 else
                     {
               
               aa=1;
               break;
                     }
               }
           else{
               
               aa=0;
               } 
        }
            
       if(parseInt(aa)==1)
           {
           
            document.getElementById("errormsg").innerText="You have already select this product";
             document.getElementById("sqotprdid").focus();
            
           return 0;
           
           
           
           }
       else
           {
           document.getElementById("errormsg").innerText="";
           }
        
       if(!$.isNumeric(temppsrno)){
            $.messager.alert('Message','Product Not Available');
            return 0;
         }
     if($('#quantity').val()==0 || $('#quantity').val()==null || $('#quantity').val()==''){
         document.getElementById("errormsg").innerText="Quantity Cannot be Zero ";
          return 0;
     }
            
            
             var rows = $('#purchasedetails').jqxGrid('getrows');
              
            
             var rowlength= rows.length;
             
             var partno=$('#sqotprdid').val();
            var pname=$('#sqotprdname').val();
            var unit=$('#unit').val();
            var brand=$('#brand').val();
            var psrno=$('#psrno').val();
            var unitdocno=$('#unitdocno').val();
            var specid=$('#specid').val();
            var qty=$('#quantity').val();
            var docno=$('#doc_no').val();
            var method=$('#method').val();
            
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "proid" ,partno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "proname" ,pname);
            
            
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "productid" ,partno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "productname" ,pname);
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "prodoc" ,docno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "unit" ,unit);
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "unitdocno" ,unitdocno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "psrno" ,psrno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "qty" ,qty);
            
            if(unit>0){
                 $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());

            }
            
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "specid" ,specid);
            
            
            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "brandname" ,brand);
                   
                     $('#sqotprdid').val('');
                     $('#sqotprdname').val('');
                     $('#unit').val('');
                     $('#brand').val('');
                     $('#psrno').val('');
                     $('#unitdocno').val('');
                     $('#specid').val('');
                     $('#quantity').val('');
                     $('#method').val('');
                     $('#doc_no').val('');
                                    
                     $("#purchasedetails").jqxGrid('addrow', null, {});
                 document.getElementById("sqotprdid").focus();
        
         }
        
        function prosrch(){
            var dates=document.getElementById("reqmasterdate").value;
            var dtype='PR';
            var presulttype='1';
           productSearchContent('productSearch.jsp?dates='+dates+'&dtype='+dtype);
            
        }
    
</script>
</head>
<body onload="setValues();chkcostcode();getitemtype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpurReq" action="savepurreqdata" autocomplete="OFF">     

<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <!-- Header Details Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Purchase Request Details</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id='reqmasterdate' name='reqmasterdate' value='<s:property value="reqmasterdate"/>'></div> 
            </div>
            <input type="hidden" id="hidreqmasterdate" name="hidreqmasterdate" value='<s:property value="hidreqmasterdate"/>'/>
            
            <label class="lbl-right" style="width:80px;">Ref No</label>
            <input type="text" id="refno" name="refno" style="width:125px;" value='<s:property value="refno"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width:125px;" tabindex="-1" value='<s:property value="docno"/>' readonly/>
        </div>
        
        <!-- Hide/show container for Group and Job No -->
        <div class="field-row" id="hcostcodes" style="display:none;">
             <label class="lbl-right" style="width:80px;">Group</label>
             <select id="itemtype" name="itemtype" style="width:125px;" onchange="cleardata()">
                <option></option>
             </select>
             
             <label class="lbl-right" style="width:80px;">Job No</label>
             <div class="input-search-container" style="width: 125px;">
                 <input type="text" id="itemdocno" name="itemdocno" placeholder="Press F3" onkeydown="getitem(event);" value='<s:property value="itemdocno"/>'>
                 <svg class="magnifier-icon" onclick="$('#itemdocno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
             </div>
             
             <input type="text" id="itemname" name="itemname" style="flex:1;" value='<s:property value="itemname"/>' readonly>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="purdesc" name="purdesc" style="flex:1;" value='<s:property value="purdesc"/>'/>
        </div>
    </div>

    <!-- Item Details Entry Panel -->
    <div id="psearch" class="middle-panel" style="background:#FAEBD7;">
        <span class="middle-panel-title">Item Details</span>
        <div class="field-row" style="margin-bottom:0;">
            <button class="myButton" type="button" id="setbtn_ps" onclick="prosrch()">PS</button>
            
            <label class="lbl-right">Prod ID</label>
            <input type="text" id="sqotprdid" list="sqotproductid" style="width:120px;">
            <datalist id="sqotproductid"></datalist>

            <label class="lbl-right">Prod Name</label>
            <input type="text" id="sqotprdname" list="sqotprdts" style="flex:1;">
            <datalist id="sqotprdts"></datalist>
            
            <label class="lbl-right">Brand</label>
            <input type="text" id="brand" style="width:120px;">

            <label class="lbl-right">Unit</label>
            <select id="unit" style="width:80px;"></select>
            
            <label class="lbl-right">Qty</label>
            <input type="text" id="quantity" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1(event);" onchange="calculatedata(this.id);" style="width:80px; text-align:right;">

            <button class="myButton" type="button" id="setbtn" onclick="setgrid()" style="margin-left:auto;">ADD</button>
            <input type="hidden" id="cleardata">
        </div>
    </div>

    <!-- Grid Data Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="vehpurcgasereq" class="grid-container" style="border:none;">
            <jsp:include page="purreqDetails.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" name="reqgridlenght" id="reqgridlenght" value='<s:property value="reqgridlenght"/>' />   
        <input type="text" name="gridtext" id="gridtext" value='<s:property value="gridtext"/>' />   
        <input type="text" name="gridtext1" id="gridtext1" value='<s:property value="gridtext1"/>' />   
        <input type="hidden" id="costtr_no" name="costtr_no" value='<s:property value="costtr_no"/>'/> 
        <input type="hidden" id="costcheck" name="costcheck" value='<s:property value="costcheck"/>'/> 
        <input type="hidden" id="hideitemtype" name="hideitemtype" value='<s:property value="hideitemtype"/>'/> 
        <input type="hidden" id="hidetype" name="hidetype" value='<s:property value="hidetype"/>'/>
        <input type="hidden" id="productchk" name="productchk" value='<s:property value="productchk"/>' />
        <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
        <input type="hidden" id="psrno" > 
        <input type="hidden" id="specid" > 
        <input type="hidden" id="doc_no" > 
        <input type="hidden" id="unitdocno" > 
        <input type="hidden" id="method" > 
    </div>

</div>
</form>

<!-- Search Windows -->
<div id="sidesearchwndow"><div></div></div>
<div id="searchwindow"><div></div></div>

</div>
</body>
</html>