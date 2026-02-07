<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>

<script type="text/javascript">


$(document).ready(function () { 
    
	   /* Date */ 	
$('#productSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
    $('#productSearchwindow').jqxWindow('close');
    $("#nipurchaseorderdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     
		$('#typesearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : ' Search',
			position : {
				x : 700,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#typesearchwindow').jqxWindow('close');
		
		
		$('#txtproducttype').dblclick(function(){
			
			typeFormSearchContent('typeFormSearchGrid.jsp'); 
			
		});      
	 
    $('#puraccid').dblclick(function(){
    	//($("#mode").val() == "view")
    	if($('#mode').val()!= "view")
    		{
    	
    		
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	
	  	  accountSearchContent('accountsDetailsFromGrid.jsp?');
    		}
  });   
    
    
    $('#txtreqrefno').dblclick(function(){
			var reftype=document.getElementById("cmbreftype").value;

			if($('#mode').val()!= "view"){
	 		 	changeContent('niPuReqSearch.jsp'); 
	   		}
	});
  
});

function typeFormSearchContent(url) {
	 document.getElementById("errormsg").innerText="";
	$('#typesearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#typesearchwindow').jqxWindow('setContent', data);
		$('#typesearchwindow').jqxWindow('bringToFront');
	});
}
function getProdType(event){
	 var x= event.keyCode;
	 if(x==114){
		 typeFormSearchContent('typeFormSearchGrid.jsp');  	 }
	 else{
		 }
      	 }

function getproductdetails(event){
 	// var x= event.keyCode;
 	 
 	if($('#mode').val()!= "view")
	{
	 	 
	 	  $('#productSearchwindow').jqxWindow('open');
	 
	 
	 	 productSearchContent('productSearchGrid.jsp');  
	 	 
	  } 
 	else{}
 	 }  
	  function productSearchContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#productSearchwindow').jqxWindow('setContent', data);

	}); 
    	}



function getaccountdetails(event){
 	 var x= event.keyCode;
   	
 	if($('#mode').val()!="view")
 		{
 		
 	 if(x==114){
 	  $('#accountSearchwindow').jqxWindow('open');
 	
 	 accountSearchContent('accountsDetailsFromGrid.jsp?');    }
 	 else{
 		 }
 		}
 	 }  
	  function accountSearchContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
    	}

function funReset(){
	//$('#frmNipurchaseOrder')[0].reset(); 
}
function funReadOnly(){
	$('#frmNipurchaseOrder input').attr('readonly', true );
	$('#frmNipurchaseOrder select').attr('disabled', true );
	 $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: true});
	 $('#deliverydate').jqxDateTimeInput({ disabled: true});
		$("#descdetailsGrid").jqxGrid({ disabled: true});
	  $('#cmbcurr').attr('disabled', true);
	 $('#acctype').attr('disabled', true);
	 
	 $('#txtproducttype').attr('disabled', true);
	
}
function funRemoveReadOnly(){
	funinterstate();
	$('#frmNipurchaseOrder input').attr('readonly', false );
	
	$('#frmNipurchaseOrder select').attr('disabled', false );
      $('#currate').attr('readonly', true);
	  $('#puraccid').attr('readonly', true);
	  $('#puraccname').attr('readonly', true);
	  
	 $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: false});
	 $('#deliverydate').jqxDateTimeInput({ disabled: false});

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	$("#descdetailsGrid").jqxGrid({ disabled: false});

	refChange();
	
	if ($("#mode").val() == "A") {
		$('#nipurchaseorderdate').val(new Date());
		$('#deliverydate').val(new Date());
		 $("#descdetailsGrid").jqxGrid('clear');
		    $("#descdetailsGrid").jqxGrid('addrow', null, {});
		    $('#txtproducttype').attr('disabled', true);
			  document.getElementById("validates").value=0;
	   }
	
	  if($('#mode').val()=='E')
	   {
	   $("#descdetailsGrid").jqxGrid('addrow', null, {});
	   
	   }
	
	
	getCurrencyIds();
}
function funFocus(){
	 
   	$('#nipurchaseorderdate').jqxDateTimeInput('focus'); 	    		
}
function funNotify(){	
 
var purid= document.getElementById("puraccid").value;

if(purid=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Account";
	 

	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }

if(parseInt(document.getElementById("validates").value)==1)
	{
	
    var txtproducttype= document.getElementById('txtproducttype').value;
	 
	 if(txtproducttype=="")
	 {
		 document.getElementById("errormsg").innerText=" Bill Type Is Required ";	
		 document.getElementById('txtproducttype').focus();
		 return 0;
	 }
	 
	
	}
	   
	   
var refval= document.getElementById("nettotal").value;

if(refval=="")
	{
	 document.getElementById("errormsg").innerText="Net Amount Empty";
	 

	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }

	 var rows = $("#descdetailsGrid").jqxGrid('getrows');
	    $('#descgridlenght').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "desctest"+i)
	       .attr("name", "desctest"+i)
	       .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
			   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice
			   +" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+rows[i].refrow+"::");
	
	// alert(newTextBox.val());
	   newTextBox.appendTo('form');
	  
	    //alert("ddddd"+$("#test"+i).val());
	    
	   }   
	
	return 1;
} 

function funChkButton() {
	

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}
function getCurrencyIds(){
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('####');
	           var curidItems=items[0].split(",");
	           var curcodeItems=items[1].split(",");
	           var currateItems=items[2].split(",");
	           var multiItems=items[3].split(",");
	           var optionscurr = '';
	           /* if(curcodeItems.indexOf(",")>=0){
	            //curidItems.split(",");
	            //curcodeItems.split(",");
	            //currateItems.split(",");
	         
	        	   for ( var i = 0; i < curcodeItems.length; i++) {
	    	           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
	    	           }
	    	            $("select#cmbcurr").html(optionscurr);
	        }
	        
	   
	          else
	      {
	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
	           $("select#cmbcurr").html(optionscurr);
	          
	        //  $('#currate').val(currateItems) ;
	      } */ 
	           for ( var i = 0; i < curcodeItems.length; i++) {
    	           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
    	           }
    	            $("select#cmbcurr").html(optionscurr);
	          funRoundRate(currateItems,"currate");
	      
	          $('#currate').attr('readonly', true);
	          var chkcurid=$('#cmbcurrval').val()
			  document.getElementById("cmbcurr").value=chkcurid;
			  getRatevaluenw(chkcurid);
	      
	    }
	       }
	   x.open("GET","getCurrencyId.jsp",true);
		x.send();
	        
	      
	        }
	   
	   function getRatevaluenw(angel)
	   {
		   var docdate=$('#nipurchaseorderdate').val();
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText;
	      
	      
	    /*      $('#currate').val(items) ; */
	         funRoundRate(items,"currate"); 
	        }
	          else
	      {
	      }
	       }
	   x.open("GET","getRateTo.jsp?curr="+angel+"&date="+docdate,true);
		x.send();
	        
	      
	        }
	   
	   
	   function combochange()
	   {
		  // alert("curr"+$('#cmbcurrval').val());
		  
		 
		/*    if($('#cmbcurrval').val()!="")
			  {
			  
			  
			  $('#cmbcurr').val($('#cmbcurrval').val());
			  } */
		   
		   if($('#acctypeval').val()!="")
			  {
			  
			  
			  $('#acctype').val($('#acctypeval').val());
			  }
			
	   }
	   

	   function setValues() {
			if($('#hidnipurchaseorderdate').val()){
				$("#nipurchaseorderdate").jqxDateTimeInput('val', $('#hidnipurchaseorderdate').val());
			}
			
			if($('#hiddeliverydate').val()){
				$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
			}
			
			if($('#hidcmbreftype').val()){
	    		$("#cmbreftype").val($('#hidcmbreftype').val());
	    		refChange();
	    	}
			
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{   
	funchkforedit();  
				//alert("");
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   
				
	     	  		 
	     	  	
	     	  		 $("#descdetail").load("descgridDetails.jsp?nipurdoc="+indexval1);
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
				//  getCurrencyId();
    		funSetlabel();
		} 
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveActionNipurOrder");
	        
	        $("#docno").prop("disabled", false);                
	        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
	  	var dtype=$('#formdetailcode').val();
	  	    //var dtype=$('#formdetailcode').val();    
	 var win= window.open(reurl[0]+"printniphOrder?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus(); 
	       /*  var win= window.open(reurl[0]+"PRINTniphOrder?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		     
	    	win.focus(); */
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#frmNipurchaseOrder').validate({
                rules: { 
              
                	delterms:{maxlength:500},
                	purdesc:{maxlength:500},
                	payterms:{maxlength:500},
                	/* refno:{required:true}, */
                	puraccid:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 500 chars"},
                	 purdesc: {maxlength:"  Max 500 chars"},
                	 payterms: {maxlength:"  Max 500 chars"},
               /*  	 refno: {required:" * required"}, */
                	 puraccid: {required:" *"}
                 }
        });});

		
	function funchkforedit()
    {
	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0){
					 $("#btnEdit").attr('disabled', true );
					 $("#btnDelete").attr('disabled', true ); 
				}else{
					 $("#btnEdit").attr('disabled', false);
					 $("#btnDelete").attr('disabled', false);
				}
			}
		}
		x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();    
	
	}
	
	function refChange(){
		var reftype=$('#cmbreftype').val();

		if(reftype=='DIR'){
			  $('#txtreqrefno').attr('disabled', true);
		}else{
			  $('#txtreqrefno').attr('disabled', false);
		}
	}
	
	function getNiPuReq(event){
	 	var reftype=document.getElementById("cmbreftype").value;

		var x= event.keyCode;
		if(x==114){
			changeContent('niPuReqSearch.jsp');  	
		}		 	 
	}
	
</script>
</head>
<body onLoad="getCurrencyIds();setValues();funinterstate();">


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNipurchaseOrder" action="saveActionNipurOrder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<fieldset>
<table width="100%"  >

  <tr>
    <td width="4.8%" align="right">Date</td> 
    <td width="8%" align="left"><div id="nipurchaseorderdate" name="nipurchaseorderdate" value='<s:property value="nipurchaseorderdate"/>'></div>
    
    <input type="hidden" name="hidnipurchaseorderdate" id="hidnipurchaseorderdate" value='<s:property value="hidnipurchaseorderdate"/>'>
    </td>
    
    <td width="15%" align="right" colspan="2">Ref Type</td>
    <td width="6%"><select id="cmbreftype" name="cmbreftype" style="width:100%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="NRQ">NRQ</option>
      </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
    </td>
     <td width="6%"><input type="text" id="txtreqrefno" name="txtreqrefno"  onKeyDown="getNiPuReq(event);" style="width:100%;"  value='<s:property value="txtreqrefno" />'/></td>
    
<td align="right" width="10%">Ref No</td>
    <td align="left"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td>
    <td width="5%" align="right">Doc No</td>
    <td width="28.7%" align="left"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly"></td>
  
  </tr>
  </table>
 <table width="100%" >
  <tr>
     <td width="2.2%" align="right">Vendor</td>
    <td colspan="5" width="14%" align="left"> 
      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
<%--     <td width="1%" align="right">Account</td>
  
     <td colspan="5" width="14%" align="left"> 
    <select name="acctype" id="acctype" style="width:10%;"  value='<s:property value="acctype"/>' >
    <option value="" ></option>
      <option value="AR" >AR</option>
      <option value="AP" >AP</option>  
    </select>   --%>
    <input type="text" name="puraccid" id="puraccid" placeholder="Press F3 To Search" value='<s:property value="puraccid"/>' style="width:20%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:69.5%;"></td>
    <td align="right" width="10.5%">Curr</td>
    <td width="4%" align="left"><select name="cmbcurr" id="cmbcurr" style="width:92%;"  value='<s:property value="cmbcurr"/>' onchange="getRatevaluenw(this.value);">
      <option value="-1" >--Select--</option>
    </select>    </td>

    <td width="3.1%" align="right">Rate <input type="text" name="currate" id="currate" value='<s:property value="currate"/>'></td>
    <td width="9%" align="left"></td>
    
  </tr>
  </table>
  <table width="100%" >
  <tr>
 
    <td align="right" width="4.3%" >Del Date</td>
    <td align="left"width="3%" ><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
    
     <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
    
    </td>
  

 
    <td align="right" width="3.8%" >Del Terms</td>
    <td colspan="4" align="left" width="73%" ><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:60%;">
    
    &nbsp;&nbsp; <label id="billtype">Bill Type</label> &nbsp;<input type="text" id="txtproducttype" name="txtproducttype"
											style="width: 10%;" placeholder="Press F3 for Search"  onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' /> 
    
    </td>
    
  </tr></table>
                              
    <table width="100%"  >
  <tr>
  <td align="right"  width="4.7%">Pay Terms</td>
    <td colspan="6"  width="100%" align="left"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:78.5%;"></td>
    </tr>
    <tr>
    <td align="right"  width="4.7%">Description</td>
    <td colspan="6"  width="100%" align="left"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:78.5%;"></td></tr>
</table>s

 </fieldset>
 <br>
 <fieldset>
 
    <div id="descdetail" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>
     

</fieldset>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
           <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
             <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
             
             <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>   
             
              <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
         <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
          <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
           <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
              <input type="hidden" id="validates" name="validates"  value='<s:property value="validates"/>'/>   
           
           <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
               <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
                   <input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
                     <input type="hidden" id="hideproducttype" name="hideproducttype"  value='<s:property value="hideproducttype"/>'/>
          
 <input type="hidden" id="unitprice" name="unitprice"  value='<s:property value="unitprice"/>' />
<input type="hidden" id="total" name="total"  value='<s:property value="total"/>' />
<input type="hidden" id="discount" name="discount"  value='<s:property value="discount"/>' />
<input type="hidden" id="net" name="net"  value='<s:property value="net"/>' />
<input type="hidden" id="taxamt" name="taxamt"  value='<s:property value="taxamt"/>' />

</form>
  <div id="accountSearchwindow">
	   <div ></div>
	</div>
<div id="productSearchwindow">
	   <div></div>
	</div>
	<div id="typesearchwindow">
			<div></div>
			 
		</div>
</div>
</body>
</html>