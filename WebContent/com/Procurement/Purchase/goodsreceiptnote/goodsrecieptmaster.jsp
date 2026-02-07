<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <% String contextPath=request.getContextPath();%>

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
 #psearch {
 
background:#FAEBD7;
 
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>
<%
String mod = request.getParameter("mod") == null ? "" : request.getParameter("mod").toString();

String  docno = request.getParameter("docno") == null? "0": request.getParameter("docno").toString() ;

String  ref = request.getParameter("refno") == null? "0": request.getParameter("refno").toString() ;

String  buyersname = request.getParameter("buyersname") == null? "0": request.getParameter("buyersname").toString() ;



String mods = request.getParameter("mods") == null ? "" : request.getParameter("mods").toString();
String  accountno = request.getParameter("accountnos") == null? "": request.getParameter("accountnos").toString() ;
String  acccountname = request.getParameter("acccountnames") == null? "": request.getParameter("acccountnames").toString() ;
String  docnos = request.getParameter("docnos") == null? "": request.getParameter("docnos").toString() ;
String  vocnos = request.getParameter("vocnos") == null? "": request.getParameter("vocnos").toString() ;
String  currate = request.getParameter("currates") == null? "": request.getParameter("currates").toString() ;
String  refno = request.getParameter("refnos") == null || request.getParameter("refnos").equals("") || request.getParameter("refnos").equals("undefined")? "": request.getParameter("refnos").toString() ;
String  refinvno = request.getParameter("refinvnos") == null || request.getParameter("refinvnos").equals("") || request.getParameter("refinvnos").equals("undefined")? "": request.getParameter("refinvnos").toString() ;
String  delterm = request.getParameter("delterms") == null || request.getParameter("delterms").equals("") || request.getParameter("delterms").equals("undefined")? "": request.getParameter("delterms").toString() ;
String  payterm = request.getParameter("payterms") == null || request.getParameter("payterms").equals("") || request.getParameter("payterms").equals("undefined")? "": request.getParameter("payterms").toString() ;
String  description = request.getParameter("descriptions") == null || request.getParameter("descriptions").equals("") || request.getParameter("descriptions").equals("undefined") ? "": request.getParameter("descriptions").toString() ;
String  locid = request.getParameter("locids") == null? "": request.getParameter("locids").toString() ;
String  locname = request.getParameter("locnames") == null? "": request.getParameter("locnames").toString() ;


%>
<script type="text/javascript">
var refdate='';
var mod1='<%=mod%>';   			 
var tempdocno='<%=docno%>';    
var tempref='<%=ref%>';
var buyersname='<%=buyersname%>';

var mod2='<%=mods%>';  
var accountnos='<%=accountno%>';
var acccountnames='<%=acccountname%>';
var docnooo='<%=docnos%>';
var vocnooo='<%=vocnos%>';
var currates='<%=currate%>';
var refnos='<%=refno%>';
var refinvnos='<%=refinvno%>';
var delterms='<%=delterm%>';
var payterms='<%=payterm%>';
var descriptions='<%=description%>';
var locids='<%=locid%>';
var locnames='<%=locname%>';
$(document).ready(function () {  
    
	   /* Date */ 	
	   // $('#setbtnps').hide();
	   		 $('#btnvaluechange').hide();
	   
	   	    $("#invdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	   	    $("#expdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	   
       $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     $('#searchwndow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	     $('#searchwndow').jqxWindow('close');  
	      
/* 	     $('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');   */ 
	     
	     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '92%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 300, y: 0 }, keyboardCloseKey: 27});
	     $('#sidesearchwndow').jqxWindow('close');
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		   $('#refnosearchwindow').jqxWindow('close'); 
	 
		   $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		     $('#searchwindow').jqxWindow('close');	   
		   
		   $('#importwindow').jqxWindow({ width: '30%', height: '24.4%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Import Options' , position: { x: 500, y: 200 }, theme: 'energyblue', showCloseButton: false});
		     $('#importwindow').jqxWindow('close');   
		     $('#bacthWindow').jqxWindow({ width: '45%', height: '65%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Search',position: { x: 700, y:100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
				$('#bacthWindow').jqxWindow('close');
		     
		     $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		     $('#locationwindow').jqxWindow('close');  
			   
		     if($('#reftypeval').val()=="PO")
			  {
		    	 $("#btnDelete").attr('disabled', true );
			  }
		     else
		    	 {
		    	 $("#btnDelete").attr('disabled', true );
		    	 }
		   
		   $('#rrefno').dblclick(function(){
			   
			  if($("#mode").val() == "A")
				  {
			   
				  if(document.getElementById("puraccid").value=="")
					{
					
					 document.getElementById("errormsg").innerText="Search Vendor";  
					 document.getElementById("puraccid").focus();
				       
				        return 0;
					}
				  
		  	    $('#refnosearchwindow').jqxWindow('open');
		  	
		  	  refsearchContent('refnosearch.jsp?'); 
				  }
			  
	          
			  }); 
			  
			   $('#txtlocation').dblclick(function(){
				   
					  if($("#mode").val() == "A" || $("#mode").val() == "E")
						  {
					   
				  	    $('#locationwindow').jqxWindow('open');
				  	
				  	  locationsearchContent('searchlocation.jsp?'); 
						  }
					  
			  	  
		          
	                     }); 
		   
		   
		   
    $('#puraccid').dblclick(function(){
    	//($("#mode").val() == "view")
    	if($('#mode').val()!= "view")
    		{
    	
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	
	  	  accountSearchContent('accountsDetailsSearch.jsp?');
    		}
  });   
    
    
    
    $('#itemdocno').dblclick(function(){

		  if($("#mode").val() == "A" || $("#mode").val() == "E")
			  {
	 
		 
	    $('#searchwindow').jqxWindow('open');
	
		if(document.getElementById("itemtype").value=="1") 
			{
		 
			refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
			}
		else if(document.getElementById("itemtype").value=="6")
		{
		 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	
		else
			{
			 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
			}
		
		 
			  }
	  }); 
    
    $("#sqotprdname").change(function(){
		var dl=$("#sqotprdts")[0];
		 var el=$("#sqotprdname")[0];
		// alert(el.value.trim());
		 if(el.value.trim() != ''){
		
		var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
		var tax = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-tax')
		var unit = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unit');
		var brand = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-brand');
		var psrno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-psrno')
		var specid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-specid');
		var unitdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitdoc');
		var uprice = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-uprice')
		var taxdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxdoc');
		var refrowno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-refrowno');
		var sr_no = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-sr_no');
		var qty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-qty');
		//alert(qty);
		var qutval = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-qutval');
		//alert(qutval);
		var saveqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-saveqty');
		var foc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-foc');
		var date = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-date');
		//alert(foc)
		//alert("fox : "+foc)

		/* var clnttax=document.getElementById("hidcmbtaxqot").value;
		if(parseInt(clnttax)==0){
			tax=0;
		} */
		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
		document.getElementById("sqotprdid").value=prdid;
		//document.getElementById("sqottaxper").value=tax;
	//document.getElementById("sqotprdname").value=prdname;
		//document.getElementById("sqottaxper").value=tax;
		document.getElementById("unit").value=unit;
		document.getElementById("brand").value=brand;
		//document.getElementById("sqotunit").value=unit;
		
		document.getElementById("temppsrno").value=psrno;
		document.getElementById("tempunitdocno").value=unitdoc;
		document.getElementById("tempspecid").value=specid;
		document.getElementById("refrowno").value=specid;
		document.getElementById("sr_no").value=specid;
		document.getElementById("quantity").value=qty;
		document.getElementById("qutval").value=qutval;
		document.getElementById("saveqty").value=specid;
		document.getElementById("focs").value=foc;
		document.getElementById("focval").value=foc;
		
		 getunit(psrno);
		 document.getElementById("hidunitprice").value=uprice;
		 
		/*  var date1=$('#refdate').val();
		 var latestDate;
		 if(typeof(date1)=='undefined' || date1=='' || date1==null){
			 alert('date1 : '+date1)
			 if(date){
				 $('#refdate').val(date);
			 }else{
				 $('#refdate').val(0);
			 }
			
			 
		 }else{
			 var date2 = date;

			    // Convert date strings to Date objects
			    var dateObj1 = new Date(date1);
			    var dateObj2 = new Date(date2);

			    // Compare the dates and set the latest date
			    console.log('dateobj1 : '+dateObj1)
			    console.log('dateobj2 : '+dateObj2)
			    if (dateObj1 > dateObj2) {
			        latestDate = dateObj1;
			    } else {
			        latestDate = dateObj2;
			    }
			    document.getElementById("refdate").value=latestDate;
		 } */
		//alert('latest date : '+latestDate)
		/* document.getElementById("taxdoc").value=taxdoc;
		document.getElementById("hidunitprice").value=uprice;
		document.getElementById("sqotunitprice").value=uprice; */
		 }
		 
		});
 	
	$("#sqotprdid").change(function(){
		var dl=$("#sqotproductid")[0];
		 var el=$("#sqotprdid")[0];
		// alert(el.value.trim());
		 if(el.value.trim() != ''){
		
		var prdname = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-prdname');
		var tax = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-tax')
		var unit = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unit');
		var brand = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-brand');
		var psrno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-psrno')
		var specid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-specid');
		var unitdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitdoc');
		var uprice = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-uprice')
		var taxdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-taxdoc');
		var refrowno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-refrowno');
		var sr_no = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-sr_no');
		var qty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-qty');
		var qutval = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-qutval');
		var saveqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-saveqty');
		var foc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-foc');
		var date = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-date');
		//alert("fox : "+foc)
		//alert("tax=="+tax);
		/* var clnttax=document.getElementById("hidcmbtaxqot").value;
		if(parseInt(clnttax)==0){
			tax=0;
		} */
		//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
		document.getElementById("sqotprdname").value=prdname;
		//document.getElementById("sqottaxper").value=tax;
		document.getElementById("unit").value=unit;
		document.getElementById("brand").value=brand;
		//document.getElementById("sqotunit").value=unit;
		
		document.getElementById("temppsrno").value=psrno;
		document.getElementById("tempunitdocno").value=unitdoc;
		document.getElementById("tempspecid").value=specid;
		document.getElementById("refrowno").value=specid;
		document.getElementById("sr_no").value=specid;
		document.getElementById("quantity").value=qty;
		document.getElementById("qutval").value=qutval;
		document.getElementById("saveqty").value=specid;
		document.getElementById("focs").value=foc;
		document.getElementById("focval").value=foc;
		 getunit(psrno);
		 document.getElementById("hidunitprice").value=uprice;
		/* document.getElementById("taxdoc").value=taxdoc;
		document.getElementById("hidunitprice").value=uprice;
		document.getElementById("sqotunitprice").value=uprice; */
		
		/*  var date1=$('#refdate').val();
		 var latestDate;
		 if(typeof(date1)=='undefined' || date1=='' || date1==null){
			 alert('date1 : '+date1)
			 if(date){
				 $('#refdate').val(date);
			 }else{
				 $('#refdate').val(0);
			 }
			
			 
		 }else{
			 var date2 = date;

			    // Convert date strings to Date objects
			    var dateObj1 = new Date(date1);
			    var dateObj2 = new Date(date2);

			    // Compare the dates and set the latest date
			    console.log('dateobj1 : '+dateObj1)
			    console.log('dateobj2 : '+dateObj2)
			    if (dateObj1 > dateObj2) {
			        latestDate = dateObj1;
			    } else {
			        latestDate = dateObj2;
			    }
			    document.getElementById("refdate").value=latestDate;
		 } */
		 }
		 
		});
    
    $("#btnDelete").attr('disabled', true ); 
    getConfig();
    getFocConfig();
});

function getitem(event){
	 var x= event.keyCode;
	 if(x==114){

		  $('#searchwindow').jqxWindow('open');
			
		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
		{
		refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
		}
		
		else if(document.getElementById("itemtype").value=="6")
		{
		 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	
		
	else
		{
		 refsearchContent1('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
		}
	

		 
		  
	 
	 }
	 else{
		 }
	 }  
	  function refsearchContent1(url) {
     //alert(url);
        $.get(url).done(function (data) {
//alert(data);
      $('#searchwindow').jqxWindow('setContent', data);

	}); 
  	}
function getloc(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#locationwindow').jqxWindow('open');
	
	  locationsearchContent('searchlocation.jsp?');   }
	 else{
		 }
	 }  
	  function locationsearchContent(url) {
     //alert(url);
        $.get(url).done(function (data) {
//alert(data);
      $('#locationwindow').jqxWindow('setContent', data);

	}); 
  	}








function getrefDetails(event){
	if(document.getElementById("puraccid").value=="")
	{
	
	 document.getElementById("errormsg").innerText="Search Vendor";  
	 document.getElementById("puraccid").focus();
       
        return 0;
	}
	 var x= event.keyCode;
	 if(x==114){
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp?'); }
	 else{
		 }
	 }  
	  function refsearchContent(url) {
      //alert(url);
         $.get(url).done(function (data) {
//alert(data);
       $('#refnosearchwindow').jqxWindow('setContent', data);

	}); 
   	}

	  function importsearchcontent(url) {
	      //alert(url);
	      
	       $('#importwindow').jqxWindow('open');
	      
	         $.get(url).done(function (data) {
	//alert(data);
	       $('#importwindow').jqxWindow('setContent', data);

		}); 
	   	}
	  function getrefno(event)
	  {
	  	 var x= event.keyCode;
	  	 if(x==114){
	  	  $('#refnosearchwindow').jqxWindow('open');
	  	
	  	  refsearchContent('refnosearch.jsp?');  }
	  	 else{
	  		 }
	  	 }  
	  	

function getaccountdetails(event){
 	 var x= event.keyCode;
   	
 	if($('#mode').val()!="view")
 		{
 		
 	 if(x==114){
 	  $('#accountSearchwindow').jqxWindow('open');
 	
 	 accountSearchContent('accountsDetailsSearch.jsp?');    }
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
	  
	  
	  function reqproductSearchContent(url) {
	     	 //alert(url);
	     		 $.get(url).done(function (data) {
	     			 
	     			 $('#searchwndow').jqxWindow('open');
	     		$('#searchwndow').jqxWindow('setContent', data);
	     
	     	}); 
	     	} 

	  
	  
      function productSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#sidesearchwndow').jqxWindow('open');
     		$('#sidesearchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 

function funReset(){
	//$('#frmgrn')[0].reset(); 
}
function funReadOnly(){
	$('#frmgrn input').attr('readonly', true );
	$('#frmgrn select').attr('disabled', true );
	 $('#masterdate').jqxDateTimeInput({ disabled: true});
	 $('#deliverydate').jqxDateTimeInput({ disabled: true});
	 
	 $('#invdate').jqxDateTimeInput({ disabled: true});
		 
		$("#serviecGrid").jqxGrid({ disabled: true});
		
		
		
		
		
		 $('#rrefno').attr('disabled', true);
/* 		  $('#descPercentage').attr('disabled', true);
		 $('#descountVal').attr('disabled', true);
		 $('#chkdiscount').attr('disabled', true);	 
 */
 $('#setbtnps').prop('disabled', true);
 $('#setbtn').prop('disabled', true);
	  $('#cmbcurr').attr('disabled', true);		 $('#btnvaluechange').hide();
	 $('#acctype').attr('disabled', true);
	 
	 if(mod1=="A")
		{
		
		 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
		funCreateBtn();
		}
	 
	 else if(mod1=="open")
		{
	 
		/* document.getElementById("masterdoc_no").value=tempdocno;
		document.getElementById("mode").value="view";
		 document.getElementById("purchaseOrder").submit();
		 mod1="view"; */
		}
	 else
		 {
		 mod1="view";
		 }
	 
	 
	 
	 
	 
	 
	 
	 if(mod2=="A")
		{
		
		 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
		funCreateBtn();
		}
	 
	 else if(mod2=="open")
		{
	 
		/* document.getElementById("masterdoc_no").value=tempdocno;
		document.getElementById("mode").value="view";
		 document.getElementById("purchaseOrder").submit();
		 mod1="view"; */
		}
	 else
		 {
		 mod2="view";
		 }
	
	
}
function funRemoveReadOnly(){
	//reloads();
	//getProduct();
	funchkps();
	chkmultiqty();
	 document.getElementById("editdata").value="";
	$('#frmgrn input').attr('readonly', false );
/* 	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true); */
	$('#frmgrn select').attr('disabled', false );
      $('#currate').attr('readonly', false);
	  $('#puraccid').attr('readonly', true);
	  $('#puraccname').attr('readonly', true);
	  $('#rrefno').attr('disabled', true);
	  $('#rrefno').attr('readonly', true);
		 $('#btnvaluechange').hide();
		 
		 $('#txtlocation').attr('readonly', true);
		 
		 $('#setbtnps').prop('disabled', false);
		 $('#setbtn').prop('disabled', false);
 
		 
		 $('#invdate').jqxDateTimeInput({ disabled: false});
	  
	 $('#masterdate').jqxDateTimeInput({ disabled: false});
	 $('#deliverydate').jqxDateTimeInput({ disabled: false});

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	 
	 $("#serviecGrid").jqxGrid({ disabled: false});

	 
	  /* $('#descPercentage').attr('disabled', true); */
/* 	 $('#descountVal').attr('disabled', false); */
	 $('#docno').attr('readonly', true);
	 
/* 	 $('#orderValue').attr('readonly', true);
	  
	 $('#productTotal').attr('readonly', true);
	 $('#netTotaldown').attr('readonly', true); */
	 
	 if(mod1=="A")  
		{
		 
		 $("#sevdesc").load("serviecgrid.jsp?tempdocno="+tempdocno+"&cond=2"); 
		 document.getElementById('hidrxdoc').value=tempdocno;
		 document.getElementById('refno').value=tempref;
		 document.getElementById('purdesc').value=buyersname;
		 
		 
		}
	 
	if ($("#mode").val() == "A") {
		  //$('#chkdiscount').attr('disabled', false);
		$('#masterdate').val(new Date());
		$('#deliverydate').val(new Date());
		 
		$('#invdate').val(new Date());
		
 
			 $("#serviecGrid").jqxGrid('clear');
			    $("#serviecGrid").jqxGrid('addrow', null, {});
		    
		   
	   }
	
  	if ($("#mode").val() == "E") {
		 $('#btnvaluechange').show();
		 $('#setbtnps').prop('disabled', true);
		 $('#setbtn').prop('disabled', true);
		$("#serviecGrid").jqxGrid({ disabled: true});
	}  
  
	
	
	
	
	getCurrencyIds();
	
 chkcostcode();
	 
	 $('#itemdocno').attr('readonly', true);
	 $('#itemname').attr('readonly', true);
	 
	 
	 if(mod2=="A")  
		{
		    
	 	  	 
	 	  	 document.getElementById("accdocno").value=accountnos;
	 	  	document.getElementById("puraccid").value=accountnos;
	 		document.getElementById("puraccname").value=acccountnames;
	 		document.getElementById("reftype").value="PO";
	 		document.getElementById("rrefno").value=vocnooo;
	 		document.getElementById("currate").value=currates;
	 		document.getElementById("refno").value=refnos;
	 		document.getElementById("invno").value=refinvnos;
	 		document.getElementById("payterms").value=payterms;
	 		document.getElementById("delterms").value=delterms;
	 		document.getElementById("purdesc").value=descriptions;
	 		document.getElementById("refmasterdoc_no").value=docnooo;
	 		document.getElementById("txtlocationid").value=locids;
	 		document.getElementById("txtlocation").value=locnames;
		 	
		}
	 getConfig();
}

function funcheckaccinvendor()
{
	if(document.getElementById("puraccid").value=="")
		{
		
		 document.getElementById("errormsg").innerText="Search Vendor";  
		 document.getElementById("puraccid").focus();
	       
	        return 0;
		}
	
}


function funFocus(){
	 
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}


function funNotify(){
console.log('refdate '+refdate);
 var batchconf=$('#batchconf').val();
 if($('#reftype').val()!='DIR'){
 var curdate=$("#masterdate").jqxDateTimeInput('getDate');
 console.log('curdate : '+curdate);
 // Convert date strings to Date objects
 var dateObj1 = new Date(refdate);
 var dateObj2 = new Date(curdate);
 dateObj1.setHours(0, 0, 0, 0);
 dateObj2.setHours(0, 0, 0, 0);
 var formattedDateCurdate = ('0' + dateObj2.getDate()).slice(-2) + '-' +
 ('0' + (dateObj2.getMonth() + 1)).slice(-2) + '-' +
 dateObj2.getFullYear();
 var formattedDaterefdate = ('0' + dateObj1.getDate()).slice(-2) + '-' +
 ('0' + (dateObj1.getMonth() + 1)).slice(-2) + '-' +
 dateObj1.getFullYear();

 // Compare the dates and set the latest date
 console.log('dateobj fun 1 : '+dateObj1)
 console.log('dateobj fun 2 : '+dateObj2)
 console.log('dateobj fun 3 : '+formattedDateCurdate)
 console.log('dateobj fun 3 : '+formattedDaterefdate)
 if (formattedDaterefdate <= formattedDateCurdate) {
	 document.getElementById("errormsg").innerText="";
 } else {
     //latestDate = dateObj2;
	 document.getElementById("errormsg").innerText=" Date Cannot be prior than : "+formattedDaterefdate;
	 return 0;

 }
 }
var purid= document.getElementById("puraccid").value;

if(purid=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Account";
	 
	 document.getElementById("puraccid").focus();
	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }
	   
	   

	   
	   
if(document.getElementById("txtlocation").value=="")
{

 document.getElementById("errormsg").innerText="Search Location";  
 document.getElementById("txtlocation").focus();
   
    return 0;
}
	 
else
	{
	  document.getElementById("errormsg").innerText="";
	}
	   
if(document.getElementById('reftype').value=="DIR")
{
	
}
else
	{
	
	if(document.getElementById("rrefno").value=="")
	{

	 document.getElementById("errormsg").innerText="Search Purchase Order";  
	 document.getElementById("rrefno").focus();
	   
	    return 0;
	}
	
	}  
	   
if(document.getElementById("invno").value=="")
{

 document.getElementById("errormsg").innerText="Enter Invno";  
 document.getElementById("invno").focus();
   
    return 0;
}
	 
else
	{
	  document.getElementById("errormsg").innerText="";
	}
	   

	   
	   
/* var refval= document.getElementById("nettotal").value;

if(refval=="")
	{
	
	document.getElementById("nettotal").value=0;
	
	  document.getElementById("errormsg").innerText="Net Amount Empty";
	 

	 return 0;  
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   } */

/* psrno unitdocno prodoc qty unitprice discount nettotal */
var rows = $("#serviecGrid").jqxGrid('getrows');
	   var rowlength=0;
   $('#serviecGridlength').val(rows.length);
  //alert($('#gridlength').val());
  for(var i=0 ; i < rows.length ; i++){
	  var reftype=$('#reftype').val();
	  if(typeof(rows[i].prodoc)=='undefined' || rows[i].prodoc==null || rows[i].prodoc=='' || rows[i].prodoc==0){
		  
	  }else{
		  
	  
	  if(reftype =='PO'){
	  	var qutval=rows[i].qutval;
	  	var qty=rows[i].qty;
	  	var foc=rows[i].foc;
	  	var focval=rows[i].focval;
	    //alert("qutval====="+qutval+"=====qty===="+qty);
	    //alert("focval====="+focval+"=====foc===="+foc);

	  	if(parseFloat(qutval)<parseFloat(qty)){
	  		  document.getElementById("errormsg").innerText="Qty should not be grater that available QTY : "+qutval;
	  		  return 0;
	  	}
	  	if(parseFloat(focval)<parseFloat(foc)){
	  		  document.getElementById("errormsg").innerText="Foc should not be grater that available FOC : "+focval;
	  		  return 0;
	  	}
	  	
	  }
	  if(typeof(rows[i].qty)=='undefined' || rows[i].qty==null || rows[i].qty=='' || rows[i].qty==0){
		  document.getElementById("errormsg").innerText="QTY is required!";  
		  return 0
	  }
	  if(batchconf==2){
		  if((typeof(rows[i].colbatch)=='undefined' || rows[i].colbatch==null || rows[i].colbatch=='' || rows[i].colbatch==0) && (rows[i].batch_no=='' || rows[i].batch_no==null || typeof(rows[i].batch_no)=='undefined')){
			  document.getElementById("errormsg").innerText="Batch number is required for the product :"+rows[i].productid;  
			  return 0
		  }
	  }
	  if(rows[i].chkbox){
		  if((typeof(rows[i].colbatch)=='undefined' || rows[i].colbatch==null || rows[i].colbatch=='' || rows[i].colbatch==0)){
			  document.getElementById("errormsg").innerText="Multi Batch is required for the product :"+rows[i].productid;
			  return 0;
		  }
	  }
	 
	  
			  // var myvar = rows[i].tarif; 
				   newTextBox = $(document.createElement("input"))  
				      .attr("type", "dil")
				      .attr("id", "sertest"+rowlength)
				      .attr("name", "sertest"+rowlength)
				      .attr("hidden", "true");         
				  
				  /* newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
						   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: ");
				 */ /* discount  disper */
				// alert("batch :"+rows[i].batch_no)
				// alert("expiry :"+$('#serviecGrid').jqxGrid('getcelltext', i, "exp_date"))
				 newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "  
						   +rows[i].saveqty+" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].foc+" ::"+rows[i].unitprice+" ::"+rows[i].discount+" ::"+rows[i].disper+" :: "+rows[i].batch_no+"::"+$('#serviecGrid').jqxGrid('getcelltext', i, "exp_date")+" :: "
						   +rows[i].chkbox+" :: "+rows[i].colbatch+" :: "+rows[i].rxdesc+" :: "+rows[i].rxref+" :: "+rows[i].total+" :: "+rows[i].netotal+" :: "+rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].rowno+" :: "+rows[i].productid+" :: ");
				
				 
				  newTextBox.appendTo('form');
				  rowlength++;
		   
  }		 
   //alert("ddddd"+$("#test"+i).val());
   
  }   
	  
  if(rowlength<=0){
	  document.getElementById("errormsg").innerText="Product is required!";  
	  return 0;
  }  
  $('#serviecGridlength').val(rowlength);  
		if ($("#mode").val() == "E") {
			
			 if($('#reftypeval').val()=="PO")
			  {
			
			  $('#rrefno').attr('disabled', false);
			  
		      $('#rrefno').attr('readonly', true);

			  }
			 
			 
			 
			 
			 
		/* 	 $('#chkdiscount').attr('disabled', false);
			   if(document.getElementById("chkdiscountval").value==1)
		 		  {
				   
				   
		 		 
					  document.getElementById("chkdiscount").value = 1;
		 		  
		 		 $('#descPercentage').attr('disabled', false);
		 		 $('#btnCalculate').attr('disabled', false);
		 		 $('#descountVal').attr('disabled', false);
		 		    
		 		  
		 	 
		 		  } */
		 	 
				  $('#rrefno').attr('disabled', false);
				  $('#rrefno').attr('readonly', true);
	    	   
	    	   
	    		$("#serviecGrid").jqxGrid({ disabled: false});
			 
			 
			 
			 
			 
			} 
		  
	   
	
	return 1;
} 



function funwarningopen(){
	   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
	       if (r){
	    /* 	   $('#chkdiscount').attr('disabled', false);
			   if(document.getElementById("chkdiscountval").value==1)
		 		  {
				   
				   
		 		  document.getElementById("chkdiscount").checked = true;
		 		  document.getElementById("chkdiscount").value = 1;
		 		  
		 		 $('#descPercentage').attr('disabled', false);
		 		 $('#btnCalculate').attr('disabled', false);
		 		 $('#descountVal').attr('disabled', false);
		 		    
		 		  
		 	 
		 		  } */
		 		  document.getElementById("editdata").value="Editvalue";
				//  $('#rrefno').attr('disabled', false);
				//  $('#rrefno').attr('readonly', true);
	    	    $('#setbtnps').prop('disabled', false);
		 $('#setbtn').prop('disabled', false);
	getProduct();
	    		$("#serviecGrid").jqxGrid({ disabled: false});
	    		  $("#serviecGrid").jqxGrid('addrow', null, {});

	       }
	      });
	   }

function funChkButton() {
	

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}

function getConfig(){
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('::');
	      //alert('batch : '+items[0])
	      if(items[0]==1 || items[0]==2 ){
	    	  //alert("Batch")
	    	  $(".ff2").show();
	    	  $("#loads").show();
	    	  $('#batchconf').val(items[0]);
	    	  
	      }else{
	    	  $(".ff2").hide(); 
	      }
	      if(items[1]==1){
	    	  $(".ff3").show();
	    	  //alert("Expiry")
	      } else{
	    	  $(".ff3").hide();
	      }    
	         
	    }
	   
	   
	       }
	   x.open("GET","checkbatch.jsp",true);
		x.send();
}
function getFocConfig(){
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      
	      if(items[0]==1){
	    	  $(".ff").show();
	    	  $('#batchsearchgrid').jqxGrid('showcolumn', 'foc');
	    	  //alert("FOC")
	    	  //$(".ff2").show();
	    	  
	      }else{
	    	  $(".ff").hide();
	    	  $('#batchsearchgrid').jqxGrid('hidecolumn', 'foc');
	      }
	       
	         
	    }
	   
	   
	       }
	   x.open("GET","checkfoc.jsp",true);
		x.send();
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
	           
	            for ( var i = 0; i < curcodeItems.length; i++) {
	           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
	           }
	            $("select#cmbcurr").html(optionscurr);
	                   
	          //funRoundRate(currateItems,"currate");
	      
	          //$('#currate').attr('readonly', true);
	         
	    }
	   
	   //alert("curr=="+$('#cmbcurrval').val());
	   if($('#cmbcurrval').val()!="")
		  {
         document.getElementById("cmbcurr").value=$('#cmbcurrval').val();
		  }
	       }
	   x.open("GET","getCurrencyId.jsp",true);
		x.send();
	        
	      
	        }
	   
	   function getRatevaluenw(angel)
	   {
		   
		   //alert("angel=="+angel);
		   
	   var mdate=$('#masterdate').val(); 
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
	   x.open("GET","getRateTo.jsp?currs="+angel+"&date="+mdate,true);
		x.send();
	        
	      
	        }
	   
	   
	   function combochange()
	   {
		   /* if($('#cmbcurrval').val()!="")
			  {
			  
			  
			  $('#cmbcurr').val($('#cmbcurrval').val());   
			  
			  } */
			  if($('#reftypeval').val()!="")
			  {
			  
			  
			  $('#reftype').val($('#reftypeval').val());
			  }
			 
			 if($('#reftypeval').val()=="PO")
			  {
			
			  $('#rrefno').attr('disabled', false);
			  
		  $('#rrefno').attr('readonly', true);
		
			  }
		   
		   
		   
		/*    if(document.getElementById("chkdiscountval").value==1)
 		  {
 		  document.getElementById("chkdiscount").checked = true;
 		  
 		  
 		  document.getElementById("chkdiscount").value = 1;
 	 
 		  }
 	  else
 		  {
 		  document.getElementById("chkdiscount").checked = false;
 		  document.getElementById("chkdiscount").value = 0;
 		  
 		  } */
		   
		   
		   
		   
		   
		   
		   
			
	   }

	   function setValues() {
			if($('#hidmasterdate').val()){
				$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
			}
			
			if($('#hiddeliverydate').val()){
				$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
			}
			
			
			
			if($('#hidinvdate').val()){
				$("#invdate").jqxDateTimeInput('val', $('#hidinvdate').val());
			}
			
			 $("#btnDelete").attr('disabled', true);
	
			
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
				funchkforedit();
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   

	     	  		  
	     	  		 
	     	  		  
	     	  		 var reftypeval = document.getElementById("reftypeval").value;  
	     	  		 var refmasterdoc_no = document.getElementById("refmasterdoc_no").value;  
	     	  		 
	     	  		 $("#sevdesc").load("serviecgrid.jsp?purdoc="+indexval1+"&reftype="+reftypeval+"&refmasterdoc_no="+refmasterdoc_no);
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
				//  getCurrencyId();
    		 $("#btnDelete").attr('disabled', true ); 
		} 
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;
 
	        var reurl=url.split("saveActionGdsrnote");
	        
	        $("#docno").prop("disabled", false);                
	        
	  
	var win= window.open(reurl[0]+"printGrn?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#frmgrn').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	/* refno:{required:true}, */
                	puraccid:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
               /*  	 refno: {required:" * required"}, */
                	 puraccid: {required:" *"}
                 }
        });});
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
        	}
        document.getElementById("errormsg").innerText="";  
        return true;
    }
/* function fundisable()
{
	
	   if (document.getElementById('chkdiscount').checked) {
	$.messager.confirm('Confirm', 'Line Discount Will Override With Bill Discount', function(r){
		if (r==false){
			document.getElementById('chkdiscount').checked=false;
			return 0;
		}
		else
			{
	
	
			
			   if (document.getElementById('chkdiscount').checked) {
			 
			  $('#descPercentage').attr('disabled', false);
			 $('#descountVal').attr('disabled', false);
			  
	   }
	  
	   
			}
		
		
	      
      });
	   }
	   else
	   {
	   document.getElementById('descPercentage').value="";
	   document.getElementById('descountVal').value="";
	   
	   $('#descPercentage').attr('disabled', true);
		 $('#descountVal').attr('disabled', true);
			$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", true);
	   }
   
	}
function funcalcu()
{
	
 
	
	
	
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descPercentage=document.getElementById('descPercentage').value;
	
	//alert("pro"+productTotal);
	
	//alert("descPercentage"+descPercentage);
	//productTotal descPercentage
	
	var descvalue=parseFloat(productTotal)*(parseFloat(descPercentage)/100);
	var netval=parseFloat(productTotal)-parseFloat(descvalue);
	
	var  roundOf=document.getElementById('roundOf').value;
	
	 if(roundOf!="" ||roundOf==null || typeof(roundOf)=="undefiend") 
 	   {
		 netval=parseFloat(productTotal)+parseFloat(roundOf);
 	   }
	
	
 
	funRoundAmt(descvalue,"descountVal");
	funRoundAmt(netval,"netTotaldown");
	var aa;
 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
   	            	   {
   	               
   	               aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
   	            	   }
   	               else
   	            	   {
   	            	    aa=document.getElementById("netTotaldown").value;
   	            	   }
        
                
            	funRoundAmt(aa,"orderValue");
	
	 var rows = $('#serviecGrid').jqxGrid('getrows');
      var rowlength= rows.length-1;
  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
  	
 
   
		    for(var i=0;i<rowlength;i++)
					  {
	 
		    	var totamt=rows[i].total;
		     
		    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
		     
		    	var nettot=parseFloat(totamt)-parseFloat(discounts);
		    	
	  
		    	$('#serviecGrid').jqxGrid('setcellvalue',i, "discount" ,discounts);
		    	$('#serviecGrid').jqxGrid('setcellvalue',i, "nettotal" ,nettot);
				 
			  
					  }
	 
	 
	
 
	
	
	
	
	}
	
	
	
	
function funvalcalcu()
	{
	
	$('#serviecGrid').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
	var  productTotal=document.getElementById('productTotal').value;
	var  descountVal=document.getElementById('descountVal').value;
 
	var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
	var netval=parseFloat(productTotal)-parseFloat(descountVal);
	
 
	funRoundAmt(descper,"descPercentage");
	funRoundAmt(netval,"netTotaldown");
	funcalcu();
	}
	
	
	
 function roundval()
{
		var  netTotaldown=document.getElementById('netTotaldown').value;
	    var roundOf=document.getElementById('roundOf').value;
 
		 
		var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
		funRoundAmt(netval,"netTotaldown"); 
} 
	 */
 
 function funrefdisslno()
 {
	 
	 if(document.getElementById('reftype').value=="DIR")
		 {
		 
		  $('#rrefno').attr('disabled', true);
		  $('#rrefno').attr('readonly', true);
		  
			 document.getElementById("rrefno").value="";
			 document.getElementById("refmasterdoc_no").value="";
			 $("#serviecGrid").jqxGrid('clear');
			 $("#serviecGrid").jqxGrid('addrow', null, {});
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("sqotprdid").value ="";
			   document.getElementById("sqotprdname").value="";
			   document.getElementById("brand").value=""; 
	           document.getElementById("collqty").value ="";
			   document.getElementById("quantity").value ="";
			   document.getElementById("unit").value ="";
			    document.getElementById("focs").value="";
			   	
		  	   document.getElementById("batch").value="";
			   document.getElementById("colbatch").value=""; 
			    document.getElementById("temppsrno").value="";
			     document.getElementById("tempspecid").value="";
			 getProduct();
		 }
	 
	 else
		 {
		 
		  $('#rrefno').attr('disabled', false);
		  $('#rrefno').attr('readonly', true);
		  
			 document.getElementById("rrefno").value="";
			 document.getElementById("refmasterdoc_no").value="";
			 $("#serviecGrid").jqxGrid('clear');
			 document.getElementById("sqotprdid").value ="";
			   document.getElementById("sqotprdname").value="";
			   document.getElementById("brand").value=""; 
	           document.getElementById("collqty").value ="";
			   document.getElementById("quantity").value ="";
			   document.getElementById("unit").value ="";
			    document.getElementById("focs").value="";
			   	
		  	   document.getElementById("batch").value="";
			   document.getElementById("colbatch").value=""; 
			    document.getElementById("temppsrno").value="";
			     document.getElementById("tempspecid").value="";
			 $("#serviecGrid").jqxGrid('addrow', null, {});
			 getProduct();
		  
		 
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
					else
						{
						 
						}
				  
					
					
					
				} else { 
				}
			}
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value+"&refmasterdocno="+document.getElementById("refmasterdoc_no").value+"&reftype="+document.getElementById("reftypeval").value, true);
			x.send();
		
		
		}
	 
	function removemsg()
	{
		 document.getElementById("errormsg").innerText="";
		
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
	/* 	 document.getElementById("clientname").value="";
	 
		 document.getElementById("cldocno").value="";
		 document.getElementById("siteid").value="";
		 document.getElementById("site").value=""; */
		 
	 
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
			
			/* var batchconf=$('#batchconf').val();
			alert('batchconf : '+batchconf)
			if(batchconf==2){
				alert('batch : '+$('#batch').val())
				if($('#batch').val()==null || $('#batch').val()=='' || typeof($('#batch').val())=='undefined'){
		 			document.getElementById("errormsg").innerText="Batch is Mandatory";
		 			return 0;
				}
			} */
			
			   var qty=$('#quantity').val();
			   if(qty==0 || qty==null){
		 			document.getElementById("errormsg").innerText="Quantity is Mandatory";
		 			 document.getElementById("quantity").focus();
    	 	 		 return 0;
			   }
			 
			 var temppsrno=document.getElementById("temppsrno").value; 
			 var unit=document.getElementById("unit").value; 
			 
			 
	 
        	  
    		var rows1 = $("#serviecGrid").jqxGrid('getrows');
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
 			  

				 
		     document.getElementById("jqxInput1").focus();
 			 
 		   return 0;
 		   
 		   
 		   
 		   }
 	   else
 		   {
 		   document.getElementById("errormsg").innerText="";
 		   }
 	    
			
			var reftype=$('#reftype').val();
			if(reftype =='PO'){
				var qutval=$('#qutval').val();
				var qty=$('#quantity').val();
				var foc=$('#focs').val();
				var focval=$('#focval').val();
				if(parseFloat(qutval)<parseFloat(qty)){
					  document.getElementById("errormsg").innerText="Qty should not be grater that available QTY : "+qutval;
					  return 0;
				}
				if(parseFloat(focval)<parseFloat(foc)){
					  document.getElementById("errormsg").innerText="Foc should not be grater that available FOC : "+focval;
					  return 0;
				}
				
			}

			
			 var rows = $('#serviecGrid').jqxGrid('getrows');
			  
		 	 
		     var rowlength= rows.length;
			 

		     
		  /*    if(document.getElementById("multi").checked)
			 {
		    	
		    	 
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
				  
				 
				  if(document.getElementById("colbatch").value=="")
					  {
					  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
		        		 
		        		return 0;
					  }
				  
				  
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
				     
		    	 
		    	 
		     }
		     else
		    	 {
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
				 
			 
				 if(parseInt(document.getElementById("expchk").value)==1)
					 {
					 
					  var  exp_date=document.getElementById("expdate").value;
					 
					 
					   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
		      	 	   {
							 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
			        		 
				        		return 0;
		      	 	   }
		     		   
					 
			 
					 
					 
					 
					   $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
					 }else
						 {
						 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
						 }
				 
				 
				
				 
		    	 
		    	 } */
		    	// alert($('#expdate').jqxDateTimeInput('getDate'));
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("sqotprdid").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("sqotprdname").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("focs").value);
		    
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
		     if(document.getElementById("unit").value>0)
		     {
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
		     }
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
		     $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("sqotprdid").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("sqotprdname").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "qutval", document.getElementById("qutval").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "focval", document.getElementById("focval").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "focval", document.getElementById("focval").value);
		     $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "unitprice",document.getElementById("hidunitprice").value);

		      							

		   /*  


		     
		     if(document.getElementById("multi").checked)
			 {
		    	
		    	 
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",true);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no",'');
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date",'');
				  
				 
				  if(document.getElementById("colbatch").value=="")
					  {
					  document.getElementById("errormsg").innerText="Multi_Batch Details Is Required ";
		        		 
		        		return 0;
					  }
				  
				  
				  $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "colbatch", document.getElementById("colbatch").value);
				     
		    	 
		    	 
		     }
		     else
		    	 {
		    	 
		    	 
		    	 $('#serviecGrid').jqxGrid('setcellvalue', rowlength-1, "chkbox",false);
				 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
				 
			 
				 if(parseInt(document.getElementById("expchk").value)==1)
					 {
					 
					  var  exp_date=document.getElementById("expdate").value;
					 
					 
					   if(exp_date=="" ||exp_date==null || typeof(exp_date)=="undefiend") 
		      	 	   {
							 document.getElementById("errormsg").innerText="Expiry Date Is Required ";
			        		 
				        		return 0;
		      	 	   }
		     		   
					 
			 
					 
					 
					 
					   $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", $('#expdate').jqxDateTimeInput('getDate'));
					 }else
						 {
						 $('#serviecGrid').jqxGrid('setcellvalue',  rowlength-1, "exp_date", "1990.01.01");
						 }
				 
				 
				
				 
		    	 
		    	 }
				  
				  */ 
				   document.getElementById("sqotprdid").value ="";
				   document.getElementById("sqotprdname").value="";
				   document.getElementById("brand").value=""; 
		           document.getElementById("collqty").value ="";
				   document.getElementById("quantity").value ="";
				   document.getElementById("unit").value ="";
				    document.getElementById("focs").value="";
				   	
			  	   document.getElementById("batch").value="";
				   document.getElementById("colbatch").value=""; 
				    document.getElementById("temppsrno").value="";
				     document.getElementById("tempspecid").value="";
				     
				      
				     /*  
				      
				      document.getElementById("multi").checked=false;
					 	 document.getElementById("batch").value="";
						 document.getElementById("colbatch").value="";
						 
						 
						  $('#batch').attr('readonly', false);
						 $('#expdate').jqxDateTimeInput({ disabled: false});
						 $('#expdate').val(null);
						  */
			 		 $("#serviecGrid").jqxGrid('addrow', null, {});
		    		 document.getElementById("sqotprdid").focus();
		 
		 }
		function calculatedata(val)
		 {

		 }
		function prosrch(){
			if($('#puraccid').val()==null || $('#puraccid').val()==0 ){
	 			document.getElementById("errormsg").innerText="Select the vendor";
	 			return 0;
			}
			var reqdoc=document.getElementById("refmasterdoc_no").value;
			//alert(reqdoc)
    		var dtype='GRN';
    		var accdocno = document.getElementById("accdocno").value;
    		var cmbbilltype=$('#cmbbilltype').val();
    		var reftype=$("#reftype").val();
    		var clientid =$('#hidcldocno').val();
			var presulttype="2";
		//	 alert("cnf=="+cnf);
    	  	 productSearchContent('productSearch.jsp?reqmasterdocno='+reqdoc+'&dtype='+dtype+'&reftype='+reftype+'&clientid='+clientid+'&presulttype='+presulttype+'&cmbbilltype='+cmbbilltype+'&acno='+accdocno);
			
		}
		
		function funchkps()
	    {
		

		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)
						{
						
						
						// alert("ps enable");
						 
						 document.getElementById("hidpsconf").value="1";
					//	 $('#setbtnps').show();
						 
						}
					else
						{
						 document.getElementById("hidpsconf").value="0";
					//	 $('#setbtnps').hide();
						}
				  
					
					
					
				} else { 
				}
			}
			x.open("GET", "checkps.jsp", true);
			x.send();
		
		
		}
		  function reloads()
			{  
		    var locid =document.getElementById("txtlocationid").value;      
	        var date =$('#masterdate').val();    
	        var id=1;
	        var cnf=document.getElementById("hidpsconf").value;
	 		 $("#part").load('part.jsp?locid='+locid+"&date="+date+"&id="+id+'&psconf='+document.getElementById("hidpsconf").value);
	 		 $("#pnames").load('name.jsp?locid='+locid+"&date="+date+"&id="+id+'&psconf='+document.getElementById("hidpsconf").value);  
			}   
		 
		 function batchinfoSearchContent(url) {
			 //alert(url);
				 $.get(url).done(function (data) {
					 
					 $('#bacthWindow').jqxWindow('open');
				$('#bacthWindow').jqxWindow('setContent', data);
				       
			}); 
		 }
		 
	    
	    	
	    	function getProduct() {
	    		var prodsearchtype=$("#prodsearchtype").val();
	    		var reqdoc=document.getElementById("refmasterdoc_no").value;
	    	    var accdocno = document.getElementById("accdocno").value;
	    		var cmbbilltype=$('#cmbbilltype').val();
	    		var dtype='GRN';
	    		var reftype=$("#reftype").val();
	    		//alert(reftype)
	    		var clientid="",catid="",docid="";
	    		var presulttype="1";
	    		var brhid=$('#brchName').val();
	    		clientid =$('#hidcldocno').val();
	    		var optionsyear = "";
	          	var optionsyearnw = "";
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						var prddatas=JSON.parse(items.trim());          
		  					$.each(prddatas, function( index, value ) {
		  						optionsyearnw += '<option value="' + value.part_no + '" data-prdname="'+value.productname+'" data-tax="'+value.taxper+'" data-unit="'+value.unit+'" data-brand="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdoc="'+value.unitdocno+'" data-uprice="'+value.unitprice+'" data-taxdoc="'+value.taxdocno+'" data-catname="'+value.category+'" data-scatname="'+value.subcategory+'" data-sprice="'+value.cost_price+'" data-dmbrand="'+value.demobrand+'"data-refrowno="'+value.refrowno+'"data-sr_no="'+value.sr_no+'"data-qty="'+value.qty+'"data-qutval="'+value.qutval+'"data-saveqty="'+value.saveqty+'"data-foc="'+value.foc+'"></option>';
		  						optionsyear += '<option value="' + value.productname + '" data-prdid="'+value.part_no+'" data-tax="'+value.taxper+'" data-unit="'+value.unit+'" data-brand="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdoc="'+value.unitdocno+'" data-uprice="'+value.unitprice+'" data-taxdoc="'+value.taxdocno+'" data-catname="'+value.category+'" data-scatname="'+value.subcategory+'" data-sprice="'+value.cost_price+'" data-dmbrand="'+value.demobrand+'"data-refrowno="'+value.refrowno+'"data-sr_no="'+value.sr_no+'"data-qty="'+value.qty+'"data-qutval="'+value.qutval+'"data-saveqty="'+value.saveqty+'"data-foc="'+value.foc+'"></option>';
		  					});
		  					//alert("==optionsyear=="+optionsyear);
							$("datalist#sqotprdts").html(optionsyear);
							$("datalist#sqotproductid").html(optionsyearnw);			
					} else {
					}
				}
				x.open("GET", "../getProduct.jsp?clientid="+clientid+"&presulttype="+presulttype+"&reftype="+reftype+"&reqmasterdocno="+reqdoc+"&dtype="+dtype+"&cmbbilltype="+cmbbilltype+"&acno="+accdocno, true);
				x.send();
			} 
	     	
</script>
</head>
<body onLoad="getCurrencyIds();setValues();chkcostcode();getitemtype();funchkps();" >


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmgrn" action="saveActionGdsrnote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    
	<br/> 
	<jsp:include page="multiqty.jsp"></jsp:include><br/>
	<fieldset>
 
    
    <table width="100%"  > 
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="12%"><div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
      <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'></td>
            <td align="right" width="6%">Location</td> 
    <td colspan="3"  ><input type="text" id="txtlocation" name="txtlocation" style="width:40.5%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>'  onkeydown="getloc(event);"/>
      <input type="hidden" id="txtlocationid" name="txtlocationid" value='<s:property value="txtlocationid"/>'/></td>
    <td width="3%" align="right">Ref No</td>
    <td width="18%"><input type="text" name="refno" id="refno" style="width:50%;" value='<s:property value="refno"/>'></td>
    <td width="5%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>

  <tr>
    <td align="right">Vendor</td>   
    <td colspan="3"><input type="text" name="puraccid" id="puraccid" value='<s:property value="puraccid"/>' placeholder="Press F3 To Search"   style="width:25%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:72%;"></td>
      
      <td align="right">Ref Type</td>
    <td colspan="5"><select name="reftype" id="reftype" style="width:17%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno();">
      <option value="DIR" >DIR</option>
      <option value="PO" >PO</option>
    </select>&nbsp;&nbsp;<input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:32%;" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefDetails(event);"></td>
      
    
  </tr>
    <tr>
    <td   align="right">Currency</td>
    <td  ><select name="cmbcurr" id="cmbcurr" style="width:73%;"  value='<s:property value="cmbcurr"/>' onchange="getRatevaluenw(this.value);">
      <option value="-1" >--Select--</option>
    </select></td>
    <td align="right">Rate</td>
    <td  ><input type="text" name="currate" id="currate"  value='<s:property value="currate"/>'></td>
    

<%--     <td align="right">Ref Type</td>
    <td colspan="5"><select name="reftype" id="reftype" style="width:10%;"  value='<s:property value="reftype"/>' onchange="funrefdisslno();">
      <option value="DIR" >DIR</option>
      <option value="PO" >PO</option>
    </select>&nbsp;&nbsp;<input type="text" name="rrefno" id="rrefno" placeholder="Press F3 To Search" style="width:37.2%;" value='<s:property value="rrefno"/>' onfocus="funcheckaccinvendor();" onKeyDown="getrefnosearch(event);"></td>
  </tr> --%>
  <td align="right">Inv. Date</td>
    <td><div id="invdate" name="invdate" value='<s:property value="invdate"/>'></div>  
    <input type="hidden" name="hidinvdate" id="hidinvdate" value='<s:property value="hidinvdate"/>'></td>
    <td align="right">Inv. No</td>
    <td colspan="1"><input type="text" name="invno" id="invno" style="width:50%;" onblur="removemsg()" value='<s:property value="invno"/>'></td>
    
    <td colspan="2" rowspan="3"><div id="hcostcodes" hidden="true">  
 
 <table width="100%" >
 <tr><td align="right" width="15%">Group</td><td><select  id="itemtype"  name="itemtype" style="width:62%;" onchange="cleardata()"> 
    <option>
     </option>   
                             
    </select></td>
 
  <tr><td align="right">Job No</td><td><input type="text" id="itemdocno" placeholder="Press F3 to Search"    name="itemdocno"  onkeydown="getitem(event);" value='<s:property value="itemdocno"/>' >
    </td>
    
     <tr><td colspan="2">  <input type="text" id="itemname" name="itemname" style="width:99%;"   value='<s:property value="itemname"/>' > </td>
 
 </table>
 
 
  </div>
 
  </td>
    
    </tr>
  
  <tr>
    <td align="right">Delivery Date</td>
    <td><div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'></td>
    <td align="right">Delivery Terms</td>
    <td colspan="5"><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:84.4%;"></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="7"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:88.2%;"></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="7"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:88.2%;"></td>
    <td colspan="2" align="center"><button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
</table>

  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />  
 
 </fieldset>
 <br>
  <fieldset id="psearch">
 
 <legend>Item Details</legend>
 
   <table width="100% "  >   
   <tr> 
   <td align="center"> &nbsp;</td>
   <td align="center">Product ID</td>
   <td align="center" >Product Name</td>
   <td align="center" style="width:15%;"  >Brand</td>
   <td align="center">Unit</td>
   <td  width="6%" align="center">Qty</td>
    <td align="center" class="ff">FOC</td>
  <!-- <td align="center" class="ff1">Multi_Batch</td> --> 
   <td align="center" class="ff2">Batch</td>
      <td align="center" class="ff3">ExpDate</td> 
    <td align="center">&nbsp;</td>  
   </tr>
 
    <tr><td align="center" ><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtnps"  class="btn" onclick="prosrch()" value="PS" ></td>
    <%-- <td align="center"><div id="part"><jsp:include page="part.jsp"></jsp:include></div> </td>
 <td colspan="2" align="center"> <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div> </td>  --%>
 
 <td width="15% " ><input type="text" class="form-control" id="sqotprdid" list="sqotproductid"  style="text-align: left;width:96%"><datalist id="sqotproductid" style="visibility:none;"></datalist></td>
<td width="30% " ><input type="text" class="form-control" id="sqotprdname" list="sqotprdts" style="text-align: left;width:96%"><datalist id="sqotprdts" style="visibility:none;"></datalist></td>
 
 <td align="center" >   <input type="text" id="brand"   > <input type="hidden" id="collqty"   ></td>
<td align="center"> <select    id="unit"   >   </select>      </td> 
 
<td width="6%" align="center" > <input type="hidden" id="loads" class="myButtons" value="Load Data" onclick="loaddatass()">  
  <input type="text" id="quantity"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left;" onchange="calculatedata(this.id);"  ></td>
<td align="center" class="ff"><input type="text" id="focs"  onblur="funRoundAmt(this.value,this.id);"  style="width:82%;" onkeypress="javascript:return isNumber1 (event);"     ></td>
 
 
    
 
   <td align="center" class="ff2"> 
   <input type="text" id="batch"    onkeydown="getbatch(event)" > </td>
<td  class="ff3"><div id="expdate" hidden:"true" name="expdate" value='<s:property value="expdate"/>'></div> </td> 
 
  <td align="center">
     <input type="hidden" id="cleardata">
 &nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 <td align="center" class="ff1"> 
   <input type="hidden" id="multi" style="text-align: right;" onchange="chkmultis()" > </td>
 </tr>
 
   
   </table> 
   </fieldset> 
 <fieldset>
 
    <div id="sevdesc" ><jsp:include page="serviecgrid.jsp"></jsp:include></div>
     

</fieldset>

 
<table width="100%">
<tr>
<td align="right">&nbsp;</td><td><input type="hidden" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'    style="width:50%;text-align: right;"></td>

 <td><input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<%-- <td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td> --%>
  <%-- <td align="right">Discount Value</td><td><input type="text" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td> --%>  
<%-- <td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td> --%>
<td align="right">&nbsp;</td><td><input type="hidden" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
<%-- <td align="right">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td> --%>
 
 
</tr>


</table>
 





<%--  <fieldset>
   <legend>Summary</legend>  
<table width="100%">
<tr>
<td align="right">Product</td><td><input type="text" name="productTotal" readonly="readonly" id="productTotal" value='<s:property value="productTotal"/>'    style="width:50%;text-align: right;"></td>
<td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td>
<td align="right">Discount Value</td><td><input type="text" name="descountVal" id="descountVal" value='<s:property value="descountVal"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="netTotaldown" readonly="readonly" id="netTotaldown" value='<s:property value="netTotaldown"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset> --%>

	 

           <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
           <input type="hidden" id="refmasterdoc_no" name="refmasterdoc_no"  value='<s:property value="refmasterdoc_no"/>'/>
           <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
           <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
           <input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 
           <input type="hidden" id="costcheck" name="costcheck"  value='<s:property value="costcheck"/>'/> 
           <input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
           <input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>
           <input type="hidden" id="rowval" name="rowval"  value='<s:property value="rowval"/>'/>   <!-- for refno  slno set grid -->
               <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
              <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
         <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
          <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
           <input type="hidden" id="reftypeval" name="reftypeval"  value='<s:property value="reftypeval"/>'/>  
           
           
           <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
           
            <input type="hidden" id="acctypegrid" name="acctypegrid"  value='<s:property value="acctypegrid"/>'/>
           
            <input type="hidden" id="serviecGridlength" name="serviecGridlength"  value='<s:property value="serviecGridlength"/>'/>  
          
                <input type="hidden" id="hidelocation" name="hidelocation"  value='<s:property value="hidelocation"/>'/>
                
                 <input type="hidden" id="hidpsconf" name="hidpsconf"  value='<s:property value="hidpsconf"/>'/>
                
                  <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
                   <input type="hidden" id="hidrxdoc" name="hidrxdoc"  value='<s:property value="hidrxdoc"/>'/>
             <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
        <input type="hidden" id="tempunitdocno" > 
          <input type="hidden" id="batchchk" > 
          <input type="hidden" id="hidcldocno" > 
          <input type="hidden" id="colbatch" > 
          <input type="hidden" id="prodsearchtype" > 
          <input type="hidden" id="fro" > 
          <input type="hidden" id="refrowno" > 
          <input type="hidden" id="sr_no" > 
          <input type="hidden" id="qty" > 
          <input type="hidden" id="qutval" > 
          <input type="hidden" id="saveqty" > 
          <input type="hidden" id="focval" > 
          <input type="hidden" id="hidunitprice" > 
          <input type="hidden" id="batchconf" > 
          <input type="hidden" id="refdate1" > 
</form>
<div id="searchwindow">
   <div ></div>
</div>
 <div id="refnosearchwindow">
   <div ></div>
</div>
  <div id="accountSearchwindow">
	   <div ></div>
	</div>
	  <div id="sidesearchwndow">
	   <div ></div>
	</div>
		  <div id="importwindow">
	   <div ></div>
	</div>
		  <div id="searchwndow">
	   <div ></div>
	</div>
		  <div id="locationwindow">
	   <div ></div>
	</div>
	<div id="bacthWindow"> <div></div></div>
</div>
</body>
</html>