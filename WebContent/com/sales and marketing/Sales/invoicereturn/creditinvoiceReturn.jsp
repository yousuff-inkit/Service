<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html> 
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function() {
	locationset();
$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
$("#payDueDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
refChange();
//getCurrencyIds();
//getPriceGroup();
chkfoc();
$('#btnvaluechange').hide();
$('#customerDetailsWindow').jqxWindow({width: '60%', height: '60%',  maxHeight: '75%' ,maxWidth: '60%'  ,title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#customerDetailsWindow').jqxWindow('close'); 
$('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
$('#sidesearchwndow').jqxWindow('close'); 
$('#salespersonwindow').jqxWindow({
		width : '25%',
		height : '58%',
		maxHeight : '70%',
		maxWidth : '45%',
		title : 'Sales Person Search',
		position : {
			x : 420,
			y : 87
		},
		theme : 'energyblue',
		showCloseButton : true,
		keyboardCloseKey : 27
	});
	$('#salespersonwindow').jqxWindow('close');
	
	
	$('#accountsearchwindow').jqxWindow({
		width : '25%',
		height : '58%',
		maxHeight : '70%',
		maxWidth : '45%',
		title : 'Account Search',
		position : {
			x : 420,
			y : 87
		},
		theme : 'energyblue',
		showCloseButton : true,
		keyboardCloseKey : 27
	});
	$('#accountsearchwindow').jqxWindow('close');
	
	
	 $('#locationwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Location Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#locationwindow').jqxWindow('close');
	
	$('#searchwndow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position : {
		x : 420,
		y : 87
	}, keyboardCloseKey: 27});
    $('#searchwndow').jqxWindow('close');  
	 $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	   $('#refnosearchwindow').jqxWindow('close'); 
	
//getCurrencyIds();
//getPriceGroup();
 

$('#txtclient').dblclick(function(){
	   
   	if($('#mode').val()!= "view")
   		{
	  	  CustomerSearchContent('clientINgridsearch.jsp');
   		}
 });

$('#txtsalesperson').dblclick(function(){
	   
   	if($('#mode').val()!= "view")
   		{
   		salespersonSearchContent('salesPersonSearch.jsp');
   		}
 });



$('#txtlocation').dblclick(function(){
	   
   	if($('#mode').val()!= "view")
   		{
   		$('#locationwindow').jqxWindow('open');
   		locationSearchContent('locationSearch.jsp');  
   		}
 });

$('#rrefno').dblclick(function(){
	 var clientid=document.getElementById("clientid").value;
	 
		if(clientid>0){
			
			document.getElementById("errormsg").innerText="";
	            var txtlocation=document.getElementById("locationid").value;
			
			if(txtlocation>0){
				document.getElementById("errormsg").innerText="";
				
			}
			else
				{
				document.getElementById("errormsg").innerText="Select Location";
				document.getElementById("txtlocation").focus();
				return 0;
				
				
				}
			
		}
		else{
			document.getElementById("errormsg").innerText="Select a client";
			document.getElementById("clientid").focus();
			return 0;
		}
		 
 	if($('#mode').val()!= "view")
 		{
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp');  
 		}
 	
 	



 	
});

$('#date').on('change', function (event) {
	  
	    var maindate = $('#date').jqxDateTimeInput('getDate');
	  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
	    funDateInPeriod(maindate);
	  	 }
	   });
	   
$("#sqotprdname").change(function(){
	var dl=$("#sqotprdts")[0];
	 var el=$("#sqotprdname")[0];
	// alert(el.value.trim());
	 if(el.value.trim() != ''){
	
	var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
	//var productname = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-productname');
	//var doc_no = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-doc_no');
	var tax = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxper')
	var unit = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unit');
	var brand = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-brandname');
	var psrno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-psrno')
	var specid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-specid');
	var unitdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitdocno');
	//alert("unitdoc"+unitdoc);
	var uprice = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitprice')
	//var taxdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxdoc');
	var balqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-balqty');
	var qty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-qty');
	var outqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-outqty');
	var totqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-totqty');
	var stkid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-stkid');
	//var eidtprice = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-eidtprice');
	//var locid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-locid');
	var dis = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-dis');
	var discper = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-discper');
	//alert(totqty)
//	var allowdiscount = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-allowdiscount');
	//var lbrchg = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-lbrchg');
	//var discountset = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-discountset');
	//var method = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-method');
//	var colbatch=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-colbatch');
	var rdocno=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-rdocno');
	var foc=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-foc');
	var totamt=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-netotal');
	var taxamt=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxamt');
	var nettotal=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-finaltotamt');
	var total=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-total');
	var prodoc=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-doc_no');
	var deldoc=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-deldoc');
	var billtype=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-billtype');
	var vattype=$("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-vattype');
	/*  var clnttax=document.getElementById("hidcmbtaxqot").value;
	if(parseInt(clnttax)==0){
		tax=0;
	}  */
	//alert("doc-no : "+unitdoc);
	//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"doc_no==="+doc_no+"unitdoc==="+unitdoc+"balqty==="+balqty+"qty==="+qty+"outqty==="+outqty+"totqty===="+totqty+"stkid====="+stkid+"eidtprice==="+eidtprice+"locid===="+locid+"dis===="+dis+"discper====="+discper+"allowdiscount===="+allowdiscount+"lbrchg===="+lbrchg+"discountset====="+discountset+"method===="+method);
	document.getElementById("sqotprdid").value=prdid;
	//document.getElementById("totamt").value=totamt;
	//document.getElementById("amounts").value=totamt;
	//document.getElementById("taxamountstotal").value=nettotal;

	document.getElementById("unit").value=unit;
	//document.getElementById("uprice").value=uprice;
	//document.getElementById("taxpers").value=tax;
	//document.getElementById("doc_no").value=doc_no;
	document.getElementById("unitdocno").value=unitdoc;
	document.getElementById("outqty").value=outqty;
	document.getElementById("balqty").value=balqty;
	//alert("balqty==="+balqty)
	document.getElementById("totqty").value=totqty;
	document.getElementById("stkid").value=stkid;
	//document.getElementById("eidtprice").value=eidtprice;
	//document.getElementById("locid").value=locid;
	//document.getElementById("dict").value=dis;
	//document.getElementById("dispers").value=discper;
//	document.getElementById("allowdiscount").value=allowdiscount;
//	document.getElementById("lbrchg").value=lbrchg;
//	document.getElementById("discountset").value=discountset;
//	document.getElementById("method").value=method;
	document.getElementById("brand").value=brand;
	document.getElementById("psrno").value=psrno;
	document.getElementById("quantity").value=qty;

	document.getElementById("tempspecid").value=specid;
//	document.getElementById("collqty").value=colbatch;
	document.getElementById("rdocno").value=rdocno;
	//document.getElementById("ffocs").value=foc;
	//document.getElementById("focval").value=foc;
	//document.getElementById("taxamounts").value=taxamt;
	//document.getElementById("totamt").value=total;
	document.getElementById("deldoc").value=deldoc;
	document.getElementById("prodoc").value=prodoc;
	document.getElementById("biltype").value=billtype;
	document.getElementById("vattype").value=vattype;
	
	funRoundAmt2(totamt,"amounts");
	funRoundAmt2(uprice,"uprice");
	funRoundAmt2(nettotal,"taxamountstotal");
	funRoundAmt2(taxamt,"taxamounts");
	funRoundAmt2(tax,"taxpers");
	funRoundAmt2(tax,"taxpers");
	funRoundAmt2(totamt,"totamt");
	funRoundAmt2(dis,"dict");
	funRoundAmt2(discper,"dispers");
	 getunit(psrno);
	/*  if($('#batchval').val()==2){
			document.getElementById("quantity").value='';
			document.getElementById("ffocs").value='';
	$('#quantity').attr('readonly',true);
	$('#ffocs').attr('readonly',true);
		}else{
			document.getElementById("quantity").value=qty;
			document.getElementById("ffocs").value=foc;
		} */
	// document.getElementById("taxdoc").value=taxdoc;
	 /*document.getElementById("hidunitprice").value=uprice;
	document.getElementById("sqotunitprice").value=uprice; */
	 }
	 
	});
	
$("#sqotprdid").change(function(){
	var dl=$("#sqotproductid")[0];
	 var el=$("#sqotprdid")[0];
		//alert("el :"+el)

	  //alert("test"+el.value.trim());
	 if(el.value.trim() != ''){
	
			//var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
			var productname = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-productname');
			//var doc_no = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-doc_no');
			var tax = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-taxper')
			var unit = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unit');
			var brand = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-brandname');
			var psrno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-psrno')
			var specid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-specid');
			var unitdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitdocno');
			//alert("unitdoc"+unitdoc);
			var uprice = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitprice')
			//var taxdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-taxdoc');
			var balqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-balqty');
			var qty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-qty');
			var outqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-outqty');
			var totqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-totqty');
			var stkid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-stkid');
			//var eidtprice = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-eidtprice');
			//var locid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-locid');
			var dis = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-dis');
			var discper = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-discper');
		//	var allowdiscount = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-allowdiscount');
		//	var lbrchg = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-lbrchg');
		//	var discountset = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-discountset');
		//	var method = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-method');
		//	var colbatch=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-colbatch');
			var rdocno=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-rdocno');
			var foc=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-foc');
			var totamt=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-netotal');
			var taxamt=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-taxamt');
			var nettotal=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-finaltotamt');
			var total=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-total');
			var prodoc=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-doc_no');
			var deldoc=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-deldoc');
			var billtype=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-billtype');
			var vattype=$("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-vattype');

			//alert("tax=="+tax);
	/*  var clnttax=document.getElementById("hidcmbtaxqot").value;
	if(parseInt(clnttax)==0){
		tax=0;
	} */ 
	//alert("===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice);
	// alert("doc_no:"+doc_no)
	document.getElementById("sqotprdname").value=productname;
	document.getElementById("biltype").value=billtype;
	document.getElementById("vattype").value=vattype;
	//document.getElementById("uprice").value=uprice;
	
	//document.getElementById("taxamounts").value=taxamt;
	//document.getElementById("amounts").value=totamt;
	//document.getElementById("taxamountstotal").value=nettotal;
	
	//document.getElementById("taxpers").value=tax;
	document.getElementById("unit").value=unit;
	//document.getElementById("dispers").value=discper;
	//document.getElementById("taxpers").value=tax;
	//document.getElementById("ffocs").value=foc;
	//document.getElementById("focval").value=foc;
	//document.getElementById("doc_no").value=doc_no;
	document.getElementById("psrno").value=psrno;
	document.getElementById("unitdocno").value=unitdoc;
	document.getElementById("outqty").value=outqty;
	document.getElementById("balqty").value=balqty;
	document.getElementById("totqty").value=totqty;
	document.getElementById("stkid").value=stkid;
	//document.getElementById("eidtprice").value=eidtprice;
	//document.getElementById("locid").value=locid;
	//document.getElementById("dict").value=dis;
	//document.getElementById("dispers").value=discper;
	//document.getElementById("allowdiscount").value=allowdiscount;
	//document.getElementById("lbrchg").value=lbrchg;
	//document.getElementById("discountset").value=discountset;
	//document.getElementById("method").value=method;	
	document.getElementById("temppsrno").value=psrno;	
	document.getElementById("quantity").value=qty;	
	//document.getElementById("totamt").value=totamt;	
	document.getElementById("brand").value=brand;
	
	//document.getElementById("sqotunit").value=unit;
	//document.getElementById("totalstock").value=balqty;
	//document.getElementById("temppsrno").value=psrno;
	//document.getElementById("tempunitdocno").value=unitdoc;
	document.getElementById("tempspecid").value=specid;
	//document.getElementById("collqty").value=colbatch;
	document.getElementById("rdocno").value=rdocno;
	document.getElementById("totamt").value=total;
	document.getElementById("prodoc").value=prodoc;
	document.getElementById("deldoc").value=deldoc;
	funRoundAmt2(totamt,"amounts");
	funRoundAmt2(uprice,"uprice");
	funRoundAmt2(nettotal,"taxamountstotal");
	funRoundAmt2(taxamt,"taxamounts");
	funRoundAmt2(tax,"taxpers");
	funRoundAmt2(tax,"taxpers");
	funRoundAmt2(totamt,"totamt");
	funRoundAmt2(dis,"dict");
	funRoundAmt2(discper,"dispers");
/* 	if($('#batchval').val()==2){
		document.getElementById("quantity").value='';
		document.getElementById("ffocs").value='';
$('#quantity').attr('readonly',true);
$('#ffocs').attr('readonly',true);
	}else{
		document.getElementById("quantity").value=qty;
		document.getElementById("ffocs").value=foc;
	} */

		//alert("productname==="+productname+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"===doc_no==="+doc_no+"===unitdoc==="+unitdoc+"===balqty==="+balqty+"===qty==="+qty+"===outqty==="+outqty+"===totqty===="+totqty+"===stkid====="+stkid+"===eidtprice==="+eidtprice+"===locid===="+locid+"===dis===="+dis+"===discper====="+discper+"===allowdiscount===="+allowdiscount+"===lbrchg===="+lbrchg+"===discountset====="+discountset+"===method===="+method);

	 getunit(psrno);
	 //document.getElementById("taxdoc").value=taxdoc;
	 /*document.getElementById("hidunitprice").value=uprice;
	document.getElementById("sqotunitprice").value=uprice; */
	 }
	 
	});
});
function setgrid()
{
 
 //calculatedata(0);
 
	 var temppsrno=document.getElementById("temppsrno").value; 

	 //console.log("temppsrno"+temppsrno);
	 var unit=document.getElementById("unit").value; 
	 var rows1 = $("#jqxInvoiceReturn").jqxGrid('getrows');
	 var aa=0;

    var upr=document.getElementById("uprice").value;
	//alert("upr"+document.getElementById("uprice").value)
	 var rows = $('#jqxInvoiceReturn').jqxGrid('getrows');
	//alert("rows===="+rows)
     var rowlength= rows.length;
	//alert("rowlength : "+rowlength)
     var rowg=$('#rowindexg').val();
	//	alert("rowg===="+rowg)
	
	
     var qutval=$("#totqty").val();
		var qty=$('#quantity').val();
		var foc=$('#ffocs').val();
		var focval=$('#focval').val();
		if(parseFloat(qutval)<parseFloat(qty)){
			  document.getElementById("errormsg").innerText="Qty should not be grater that available QTY : "+qutval;
			  return 0;
		}else{
			  document.getElementById("errormsg").innerText="";

		}
		if(parseFloat(focval)<parseFloat(foc)){
			  document.getElementById("errormsg").innerText="Foc should not be grater that available FOC : "+focval;
			  return 0;
		}else{
			  document.getElementById("errormsg").innerText="";

		}
		
		
     if(parseInt(aa)==0)
    {
		//	alert("inside if")

      if(document.getElementById("rowindexg").value!="" && !(document.getElementById("rowindexg").value==null) && !(document.getElementById("rowindexg").value=="undefiend")){
		//	alert("inside if rowindexg")

    	  //$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowg, "qutval",setqty); 
    	  $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "productid", document.getElementById("sqotprdid").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "productname", document.getElementById("sqotprdname").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "brandname", document.getElementById("brand").value);
 	     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "foc", document.getElementById("ffocs").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unitdocno", document.getElementById("unitdoc").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unitprice", document.getElementById("uprice").value);  
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "total", document.getElementById("totamt").value);
 	     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "collectqty", document.getElementById("collqty").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "rdocno", document.getElementById("rdocno").value);

 	    if(parseFloat(document.getElementById("dispers").value)>0){
 		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "discper", document.getElementById("dispers").value);  
 		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "dis", document.getElementById("dict").value);
 		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "netotal", document.getElementById("amounts").value);	 
 		 }
 	     else{
 	    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg,"discpers", 0);  
 	    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg,"dict", 0);
 	    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "nettotal", document.getElementById("totamt").value);
 	     }
 	     if(parseFloat(document.getElementById("taxpers").value)>0)		    		 {
 	    	  $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxper", document.getElementById("taxpers").value);
 	    	  $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxperamt", document.getElementById("taxamounts").value);
 	    	  $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "fintot", document.getElementById("taxamountstotal").value);	    		 }
 	     else{
 	    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxper", 0);
 		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "taxperamt", 0);
 		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "fintot",  document.getElementById("amounts").value);  
 		 }
 	   //  alert("we : "+document.getElementById("unit").value)
 	     if(document.getElementById("unit").value>0)
 	     {
 	     	$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unit", $("#unit option:selected").text());
 	     } 
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "psrno", document.getElementById("temppsrno").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowg, "prodoc", document.getElementById("doc_no").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "specid", document.getElementById("tempspecid").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowg, "productid" ,document.getElementById("sqotprdid").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "productname", document.getElementById("sqotprdname").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "qty", document.getElementById("qty").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "totqty", document.getElementById("totqty").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "balqty", document.getElementById("balqty").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "outqty", document.getElementById("outqty").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "detdocno", document.getElementById("deldoc").value);
 	     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "foc", document.getElementById("ffocs").value);
 	    // $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "balfoc", document.getElementById("focval").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "unitdocno", document.getElementById("unitdocno").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "billtype", document.getElementById("biltype").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowg, "vatype", document.getElementById("vattype").value);
 	   /*  var nettotal=0;
 	     nettotal=parseFloat(nettotal)+parseFloat(document.getElementById("amounts").value);
 	     document.getElementById("nettotal").value=nettotal;*/
 	    document.getElementById("rowindexg").value=""; 
     } 
     
     else{
			//alert("else if rowindexg")

    	 //$('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowlength-1, "qutval",setqty);
			//alert(document.getElementById("sqotprdid").value);
			//alert("Doc_no :   "+document.getElementById("docno").value);
			$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("sqotprdid").value);
		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("sqotprdname").value);
		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "stkid", document.getElementById("stkid").value); 

		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("prodoc").value);
		     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);	
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowlength-1 , "productid", document.getElementById("sqotprdid").value);
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("sqotprdname").value);
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
      $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);

      $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
    // $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "foc", document.getElementById("ffocs").value);
    // $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "balfoc", document.getElementById("focval").value);
    //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "unit", document.getElementById("unit").value);
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "unitprice", document.getElementById("uprice").value);  
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "total", document.getElementById("totamt").value);
     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "collectqty", document.getElementById("collqty").value);
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "rdocno", document.getElementById("rdocno").value);
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unitdocno").value);
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "totqty", document.getElementById("totqty").value);
	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "balqty", document.getElementById("balqty").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "outqty", document.getElementById("outqty").value);
 	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "detdocno", document.getElementById("deldoc").value);
 	    $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "billtype", document.getElementById("biltype").value);
	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "vatype", document.getElementById("vattype").value);
     //alert(document.getElementById("sqotprdname").value);

    // $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "batch_no", document.getElementById("batch").value);
    // $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "exp_date",$('#expdate').jqxDateTimeInput('getDate'));
     if(parseFloat(document.getElementById("dispers").value)>0){
			//alert("inside if discper")

	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "discper", document.getElementById("dispers").value); 
			//alert("1")
	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "dis", document.getElementById("dict").value);
	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "netsss", document.getElementById("amounts").value);	 
	 }
     else{ 
			//alert("else discper")

    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1,"discper", 0);  
    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1,"dis", 0);
    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "netsss", document.getElementById("totamt").value);
     } 
     //alert("tax"+document.getElementById("taxpers").value)
     if(parseFloat(document.getElementById("taxpers").value)>0)		    		 {
			//alert("if tax")

    	  $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxper", document.getElementById("taxpers").value);
    	  $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", document.getElementById("taxamounts").value);
    	  $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "fintot", document.getElementById("taxamountstotal").value);	    		 }
     else{
			//alert("else tax")

    	 $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxper", 0);
	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "taxperamt", 0);
	     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "fintot",  document.getElementById("amounts").value);  
	 }
   //  alert("we : "+document.getElementById("unit").value)
     if(document.getElementById("unit").value>0)
     {
			//alert("if unit")

     	$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
     }
    // alert("qyt : "+document.getElementById("quantity").value )
     
    /*  $('#jqxInvoiceReturn').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("sqotprdid").value);
     $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("sqotprdname").value); */
     
    // $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "qutval", document.getElementById("qutval").value);
     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "saveqty", document.getElementById("saveqty").value);
     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "pqty", document.getElementById("pqty").value); */
     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "focqutval", document.getElementById("focqutval").value);
     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "focsaveqty", document.getElementById("focsaveqty").value);
    // $('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "orderdiscper", document.getElementById("orderdiscper").value);
     //$('#jqxInvoiceReturn').jqxGrid('setcellvalue',  rowlength-1, "orderamount", document.getElementById("orderamount").value);
     /* var nettotal=0;
     nettotal=parseFloat(nettotal)+parseFloat(document.getElementById("amounts").value);
     document.getElementById("nettotal").value=nettotal; */
     
     $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
     }
		var ordertotal="0";
 	  
 	  var nettotalval="0";
 	  
   var exptotalval="0";
      /*  alert('nettotal : '+document.getElementById("nettotal").value);
       if(document.getElementById("nettotal").value!="" && !(document.getElementById("nettotal").value==null) && !(document.getElementById("nettotal").value=="undefiend")) 
    	   {
    nettotalval=parseFloat(document.getElementById("txtnettotal").value);
    	   }
       
       ordertotal=parseFloat(nettotalval)+parseFloat(exptotalval)+parseFloat(document.getElementById("nettotal").value);
	   
       
    	funRoundAmt2(ordertotal,"orderValue"); */
    	 
    	funRoundAmt2(0,"roundOf");
    	funRoundAmt2(ordertotal,"nettotal"); 
    }   
	    document.getElementById("sqotprdid").value ="";
	   document.getElementById("sqotprdname").value="";
	   document.getElementById("brand").value=""; 
	   //document.getElementById("collqty").value ="";
	   document.getElementById("quantity").value ="";
	   document.getElementById("unit").value ="";
	   document.getElementById("dispers").value ="";
	   document.getElementById("dict").value ="";
	  // document.getElementById("focs").value="";
	   document.getElementById("uprice").value="";
	   document.getElementById("totamt").value="";
	   document.getElementById("amounts").value="";
	   document.getElementById("taxpers").value=""
	   document.getElementById("taxamounts").value="";
	   document.getElementById("taxamountstotal").value="";
	   document.getElementById("temppsrno").value="";
	   document.getElementById("tempspecid").value="";
	 //  document.getElementById("qutval").value="";
	  // document.getElementById("ffocs").value="";
	  // document.getElementById("batch").value="";
 }
 
 function calculatedata(val)
{
	var quantity=document.getElementById("quantity").value;
	var qutval=document.getElementById("qutval").value;
	var uprice=document.getElementById("uprice").value;
	var taxpers=document.getElementById("taxpers").value;
	var disper=document.getElementById("dispers").value;
	var discount=0;
	var totamt=0;
	var netamount=0; 
	var taxamounts=0; 
	var taxamountstotal=0; 
	
	if(quantity=="" || quantity==null || quantity==0 ||typeof(width)=="quantity"|| typeof(quantity)=="NaN")
	{
		quantity=0;
	}
	
	if(qutval=="" || qutval==null || qutval==0 ||typeof(width)=="qutval"|| typeof(qutval)=="NaN")
	{
		qutval=0;
	}

	
	
	if(uprice=="" || uprice==null || uprice==0 || typeof(uprice)=="undefined"|| typeof(uprice)=="NaN")
	{
		uprice=0;
	}

	if(disper=="" || disper==null || disper==0 || typeof(disper)=="undefined"|| typeof(disper)=="NaN")
	{
		disper=0;
	}
	 
	if(parseFloat(quantity)>0 && parseFloat(uprice)>0){
		 totamt=parseFloat(quantity)*parseFloat(uprice);
		 
		 if(parseFloat(disper)>0){
			discount=(parseFloat(totamt)*parseFloat(disper))/100;
		 	netamount=parseFloat(totamt)-parseFloat(discount);
		}else{
			disper=0;
			discount=0;
			netamount=totamt;
		}
	}
	
	if(taxpers=="" || taxpers==null || taxpers==0 || typeof(taxpers)=="undefined"|| typeof(taxpers)=="NaN")
	{
		taxpers=0;
	}
	
	if(parseFloat(taxpers)>0)
	{
		 taxamounts=parseFloat(netamount)*(parseFloat(taxpers)/100);
		 taxamountstotal=parseFloat(netamount)+parseFloat(taxamounts);
	}
	else{
		 taxamountstotal=netamount;
	}
	document.getElementById("totamt").value=(totamt).toFixed(2);
	document.getElementById("amounts").value=(netamount).toFixed(2);
	document.getElementById("dict").value=(discount).toFixed(2);
	document.getElementById("taxamounts").value=(taxamounts).toFixed(2);
	document.getElementById("taxamountstotal").value=(taxamountstotal).toFixed(2);
} 

function getunit(val){ 
	//alert("UNIT");
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

function getProduct() {
	
	 var prodsearchtype=$("#prodsearchtype").val();
	 var locid=document.getElementById("locationid").value;
	 var docno=document.getElementById("refmasterdocno").value;
		 var docdepid=0; 
		var optionsyear = "";
		var optionsyearnw = "";
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			console.log(items);
			// Parse the JSON response
            var response = JSON.parse(items.trim());
            var prddatas = response.pddata; // Access the array of products

            console.log(prddatas); // Log the parsed data to verify          
					$.each(prddatas, function( index, value ) {
						//alert(value.part_no);
						optionsyearnw += '<option value="' + value.part_no + '" data-productname="'+value.productname+'" data-taxper="'+value.taxper+'" data-unit="'+value.unit+'" data-brandname="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdocno="'+value.unitdocno+'" data-unitprice="'+value.unitprice+'"data-balqty="'+value.balqty+'" data-qty="'+value.qty+'" data-outqty="'+value.outqty+'" data-totqty="'+value.totqty+'"data-stkid="'+value.stkid+'"data-dis="'+value.dis+'"data-discper="'+value.discper+'"data-doc_no="'+value.doc_no+'"data-rdocno="'+value.rdocno+'"data-foc="'+value.foc+'"data-total="'+value.total+'"data-taxamt="'+value.taxamt+'"data-netotal="'+value.netotal+'"data-finaltotamt="'+value.finaltotamt+'"data-deldoc="'+value.detdocno+'"data-billtype="'+value.billtype+'"data-vattype="'+value.vattype+'"></option>';
						optionsyear += '<option value="' + value.productname + '" data-prdid="'+value.part_no+'" data-taxper="'+value.taxper+'" data-unit="'+value.unit+'" data-brandname="'+value.brandname+'" data-psrno="'+value.psrno+'" data-specid="'+value.specid+'" data-unitdocno="'+value.unitdocno+'" data-unitprice="'+value.unitprice+'"data-balqty="'+value.balqty+'" data-qty="'+value.qty+'" data-outqty="'+value.outqty+'" data-totqty="'+value.totqty+'"data-stkid="'+value.stkid+'"data-dis="'+value.dis+'"data-discper="'+value.discper+'"data-doc_no="'+value.doc_no+'"data-rdocno="'+value.rdocno+'"data-foc="'+value.foc+'"data-total="'+value.total+'"data-taxamt="'+value.taxamt+'"data-netotal="'+value.netotal+'"data-finaltotamt="'+value.finaltotamt+'"data-deldoc="'+value.detdocno+'"data-billtype="'+value.billtype+'"data-vattype="'+value.vattype+'"></option>';
					});
					console.log("==optionsyearnw=="+optionsyearnw);
				$("datalist#sqotprdts").html(optionsyear);
				$("datalist#sqotproductid").html(optionsyearnw);			
		} else {
		}
	}
	x.open("GET", "getProduct.jsp?prodsearchtype="+prodsearchtype+"&docno="+docno+"&locid="+locid, true);
	//x.open("GET", "../../getProduct.jsp?presulttype="+presulttype+"&refmasterdocno="+refmasterdocno+"&reftype="+reftype+"&location="+locationid+'&dtype='+dtype, true);
	x.send();
}

function locationset(){
	  var brchid = $("#brchName").val();

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				items = items.split('####');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
			
				document.getElementById("txtlocation").value=locItems;
				document.getElementById("locationid").value= locIdItems;
				
			} else {
			}
		}
		x.open("GET", "locationset.jsp?brchid="+brchid, true);
		x.send();
} 

 
function CustomerSearchContent(url) {
$('#customerDetailsWindow').jqxWindow('open');
$.get(url).done(function (data) {
$('#customerDetailsWindow').jqxWindow('setContent', data);
$('#customerDetailsWindow').jqxWindow('bringToFront');
}); 
} 

function getSalesPerson(event){
var x= event.keyCode;
if(x==114){
	salespersonSearchContent('salesPersonSearch.jsp');  	 }
else{
	 }
 	 }

function salespersonSearchContent(url) {
$('#salespersonwindow').jqxWindow('open');
$.get(url).done(function(data) {
	$('#salespersonwindow').jqxWindow('setContent', data);
	$('#salespersonwindow').jqxWindow('bringToFront');
});
}

function getLocation(event){
	 var x= event.keyCode;
	 if(x==114){
		locationSearchContent('locationSearch.jsp');  	 }
	 else{
		 }
     	 }
     	 
function accountSearchContent(url) {
	$('#accountsearchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#accountsearchwindow').jqxWindow('setContent', data);
		$('#accountsearchwindow').jqxWindow('bringToFront');
	});
}   	 

function funRoundAmt4(value,id){
	  var res=parseFloat(value).toFixed(4);
	  var res1=(res=='NaN'?"0":res);
	  document.getElementById(id).value=res1;  
	 }  


function funRoundAmt2(value,id){
	  var res=parseFloat(value).toFixed(2);
	  var res1=(res=='NaN'?"0":res);
	  document.getElementById(id).value=res1;  
	 }  

function locationSearchContent(url) {
	$('#locationwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#locationwindow').jqxWindow('setContent', data);
		$('#locationwindow').jqxWindow('bringToFront');
	});
}



function funReadOnly(){

	$('#frmSalesReturn input').attr('readonly', true );
	$('#frmSalesReturn select').attr('disabled', true);
	$('#payDueDate').jqxDateTimeInput({disabled: true});
	$("#jqxInvoiceReturn").jqxGrid({ disabled: true});
	$('#btnvaluechange').hide();
	chkfoc();
	chktax();
}

function funRemoveReadOnly(){
gridLoad(); locationset();
chkmultiqty();
chkfoc();
chktax();
getCurrencyIds();
document.getElementById("editdata").value="";
	$('#frmSalesReturn input').attr('readonly', false );
	$('#frmSalesReturn select').attr('disabled', false);
	$('#txtclient').attr('disabled', true);
	$('#txtclientdet').attr('disabled', true);
	$('#rrefno').attr('disabled', true);
	$('#cmbcurr').attr('disabled', true);
	$('#cmbbilltype').attr('disabled', true);
	$('#txtsalesperson').attr('readonly', true );


	$('#rrefno').attr('readonly', true );
	$('#txtlocation').attr('readonly', true );
	$('#txtsalesperson').attr('readonly', true );
	$('#txtproductamt').attr('readonly', true );
	$('#txtdiscount').attr('readonly', true );
	$('#txtnettotal').attr('readonly', true );
	$('#txtlocation').attr('disabled', true );
	
	$('#orderValue').attr('readonly', true);
	
	$('#date').jqxDateTimeInput({disabled: false});
	$('#docno').attr('readonly', true);
	$("#jqxInvoiceReturn").jqxGrid({ disabled: false}); 
	/* $("#jqxTerms").jqxGrid({ disabled: false}); */
/* 	if ($("#mode").val() == "E") {
		 
		    $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
		 
	  }  */
    
	if ($("#mode").val() == "E") {

 
$('#btnvaluechange').show();

$("#jqxInvoiceReturn").jqxGrid({ disabled: true});
$('#date').jqxDateTimeInput({disabled: true});
$('#payDueDate').jqxDateTimeInput({disabled: true});






   

}
	if ($("#mode").val() == "A") {
		$('#date').jqxDateTimeInput({disabled: false});
		$('#txtsalesperson').attr('readonly', false );

		$('#payDueDate').jqxDateTimeInput({disabled: false});
		$('#txtlocation').attr('disabled', false );
		$('#txtclient').attr('disabled', false );
		$('#txtclientdet').attr('disabled', false );
		$('#cmbcurr').attr('disabled', false );
		$('#rrefno').attr('disabled', false );
		$('#cmbbilltype').attr('disabled', true );
		$('#txtlocation').attr('readonly', false );
		
		$("#txtproductamt").val("0.0");
		$("#txtdiscount").val("0.0");
		$("#txtnettotal").val("0.0");
		$("#descPercentage").val("0.0");
		$("#prodsearchtype").val("0");
		$("#orderValue").val("0.0");
		$("#roundOf").val("0.0");
		$("#nettotal").val("0.0");
		//getCurrencyIds();
	//	getPriceGroup();
		$('#date').val(new Date());
		$('#payDueDate').val(new Date());
		/* $("#jqxTerms").jqxGrid({ disabled: false}); */
		/* $("#jqxserviceGrid").jqxGrid({ disabled: false}); */
		/* $("#jqxserviceGrid").jqxGrid('clear'); 
		$("#jqxserviceGrid").jqxGrid('addrow', null, {}); */
		$("#jqxInvoiceReturn").jqxGrid('clear'); 
		$("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
	}
	
}

function funSearchLoad(){
changeContent('Mastersearch.jsp'); 
}

function funChkButton() {
	/* funReset(); */
}

function funFocus(){
	$('#date').jqxDateTimeInput('focus'); 	    		
}

$(function(){
   $('#frmSalesReturn').validate({
           rules: {
           txtfromaccid:"required",
           txtfromamount:{"required":true,number:true}
           },
            messages: {
            txtfromaccid:" *",
            txtfromamount:{required:" *",number:"Invalid"}
            }
   });});
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
	$('#date').jqxDateTimeInput({disabled: false});
	$('#payDueDate').jqxDateTimeInput({disabled: false});
	$('#txtlocation').attr('disabled', false );
	$('#txtclient').attr('disabled', false );
	$('#txtclientdet').attr('disabled', false );
	$('#cmbcurr').attr('disabled', false );
	$('#rrefno').attr('disabled', false );
	$('#cmbbilltype').attr('disabled', false );
	$('#txtlocation').attr('readonly', false );
	$('#txtsalesperson').attr('readonly', false );


	var maindate = $('#date').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriod(maindate);
	   if(validdate==0){
	   return 0; 
	   }
	if($('#txtlocation').val()== "")
	{
	document.getElementById("errormsg").innerText="select location";
	document.getElementById("txtlocation").focus();
	return 0;
	}
	 var currate=$('#currate').val();
	  if(currate==null || currate=='' || currate=='undefined' || typeof(currate)=='undefined' || parseFloat(currate)==0.0 || parseFloat(currate)<0.0){
		  document.getElementById("errormsg").innerText="Invalid Rate";
		  return 0;
	  }
	  
	  

 var rows = $("#jqxInvoiceReturn").jqxGrid('getrows');
  $('#gridlength').val(rows.length);
  var cnt=0;
 for(var i=0 ; i < rows.length ; i++){ 
	  
	 
  newTextBox = $(document.createElement("input"))
     .attr("type", "dil")
     .attr("id", "prodg"+cnt)
     .attr("name", "prodg"+cnt)
     .attr("hidden", "true");
  //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::");
   //alert('rows[i].qty : '+rows[i].qty + "==rows[i].prodoc=="+rows[i].prodoc)
   if(parseInt(rows[i].qty)>0 && parseInt(rows[i].prodoc)>0)  
			   { 
				 newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"
		 +rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netsss+"::"+rows[i].specid+"::"+rows[i].outqty+"::"
		 +rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::"+rows[i].rdocno+"::"+rows[i].detdocno
		 +"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].fintot);
 
 
   
				newTextBox.appendTo('form');
 cnt=cnt+1;
			   }
 
	    
 }
 if(cnt<=0){
	 document.getElementById("errormsg").innerText="Add product Details";
	 $("#overlay, #PleaseWait").hide();
	 return 0;
 }
 
  $('#gridlength').val(cnt);
 // alert($('#gridlength').val());
  var retval  = restrictEdit();  
  if(retval==0){     
  		document.getElementById("errormsg").innerText="Item Already Returnd!";  
  }else{

		document.getElementById("errormsg").innerText="";
  }  

 return retval;
 //return 1;
} 


function setValues(){
	 $("#btnEdit").attr('disabled', true );
	 $("#btnDelete").attr('disabled', true );
 if($('#hiddate').val()){
		 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
	  }
 
 if($('#hidpayDueDate').val()){
	 $("#payDueDate").jqxDateTimeInput('val', $('#hidpayDueDate').val());
  }
 

 if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
 if($('#hidcmbcurr').val()!=""){
	 if($('#hidcmbcurr').val()=="1"){
		 $('#cmbcurr').val("AFN");
		  }
	 if($('#hidcmbcurr').val()=="2"){
		 $('#cmbcurr').val("USD");
		  }
	 if($('#hidcmbcurr').val()=="3"){
		 $('#cmbcurr').val("RUP");
		  }
	  } 
 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 funSetlabel();
 combochange();
 var masterdoc_no=$('#masterdoc_no').val().trim();
 var refmasterdocno=$('#refmasterdocno').val().trim();
 var dtype=$('#formdetailcode').val().trim();
 var locaid=$('#locationid').val();
 if(masterdoc_no>0){
	 funchkforedit();
	  //$("#btnEdit").attr('disabled', true );
	  $("#btnDelete").attr('disabled', true );  
	  $("#invoiceDiv").load("invoiceReturnGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&locaid="+locaid+"&cond=2");
 }
	 
}

function getCustomer(event){
 var x= event.keyCode;
 	if(x==114){
	  <%-- CustomerSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp"); --%>
 	}
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
	          
	          //  curidItems.split(",");
	           // curcodeItems.split(",");
	           // currateItems.split(",");
	            for ( var i = 0; i < curcodeItems.length; i++) {
	           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
	           }
	            $("select#cmbcurr").html(optionscurr);
	          
	        
	            if($('#hidcmbcurr').val()!="")
				  {
			    	  // alert("currency=="+$('#hidcmbcurr').val());
				  
				  $('#cmbcurr').val($('#hidcmbcurr').val());   
				  
				  }
	   /*        else
	      {
	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
	           $("select#cmbcurr").html(optionscurr);
	          
	        //  $('#currate').val(currateItems) ;
	          
	          funRoundRate(currateItems,"currate");
	      
	          $('#currate').attr('readonly', true);
	       
	      } */
	    }
	       }
	   x.open("GET","getCurrencyId.jsp",true);
		x.send();
	        
	      
	        }


function getPriceGroup(){ 
	return 0;
	var clientid=document.getElementById("clientid").value;
	
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('####');
	           var pgid=items[0];
	           var pgcode=items[1];
	           var pgname=items[2];
	       //alert(pgname);
	           var optionspg = '';
	           if(pgname>=0){
	        	   var pgids=pgid.split(",");
	        	   var pgcodes=pgcode.split(",");
	        	   var pgnames=pgname.split(",");
	        	   /* alert(pgnames.length); */
	            for ( var i = 0; i < pgnames.length; i++) {
	            	
	            	optionspg += '<option value="' + pgids[i] + '">' + pgnames[i] + '</option>';
	           }
	            $("select#cmbprice").html(optionspg);
	          
	        }
	   
	          else
	      {
	        	  optionspg += '<option value="' + pgid + '"selected>' + pgname + '</option>';
	           $("select#cmbprice").html(optionspg);
	       			       
	      }
	    }
	       }
	   x.open("GET","getPriceId.jsp?clientid="+clientid,true);
		x.send();
	        
	      
	        }



	   	  
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#customerDetailsWindow').jqxWindow('open');


	 clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow'));    }
	 else{
		 }
	 } 


function getDocumentSearch(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#customerDetailsWindow').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp', $('#customerDetailsWindow'));    }
	 else{
		 }
	 } 



      function clientSearchContent(url) {
            
                $.get(url).done(function (data) {
   
	           $('#customerDetailsWindow').jqxWindow('setContent', data);

     	}); 
          	} 
      
      
      
      function termsSearchContent(url) {
   	   $('#searchwndow').jqxWindow('open');
            $.get(url).done(function (data) {
          $('#searchwndow').jqxWindow('setContent', data);
          $('#searchwndow').jqxWindow('bringToFront');

	}); 
      	} 
      
      
      function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#sidesearchwndow').jqxWindow('open');
      		$('#sidesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      	} 


function refChange(){
 var reftype=$('#cmbreftype').val();

 if(reftype=='DIR'){
	  
	  $('#rrefno').attr('disabled', true);
 }
 else{
	  
	  $('#rrefno').attr('disabled', false);
 }
 
}

function gridLoad(){
 var dtype=document.getElementById("formdetailcode").value;
 /* $("#termsDiv").load("termsGrid.jsp?dtype="+dtype); */
}




function getrefno(event)
{
 
 var clientid=document.getElementById("clientid").value;
	
	if(clientid>0){
		
		document.getElementById("errormsg").innerText="";
		
	}
	else{
		document.getElementById("errormsg").innerText="Select a client";
		
		return 0;
	}
	
 
 
	 var x= event.keyCode;
	 if(x==114){
	  $('#refnosearchwindow').jqxWindow('open');
	
	  refsearchContent('refnosearch.jsp');  }
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
	  
	   function combochange()
  {
	   if($('#hidcmbcurrency').val()!="")
		  {
		  
		  
		  $('#cmbcurr').val($('#hidcmbcurrency').val());   
		  
		  }
	   
	   if($('#hidcmbbilltype').val()!="")
		  {
		  
		  
		  $('#cmbbilltype').val($('#hidcmbbilltype').val());   
		  
		  }
	    
		  if($('#hidcmbreftype').val()!="")
		  {
		  
		  
		  $('#cmbreftype').val($('#hidcmbreftype').val());
		  }
		 
		 if($('#hidcmbreftype').val()=="SQOT")
		  {
		
		  $('#rrefno').attr('disabled', false);
		  
	  $('#rrefno').attr('readonly', true);
	
		  }
	   
		 if($('#cmbreftype').val()!='DIR'){
			 $('#btnDelete').attr('disabled', true);
		 }
		
		 
	 
  }
	   
	   
	 function funcalcu()
	{
		
	 
		document.getElementById('prddiscount').value="";
		
		
		$('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'discount',  "editable", false);
		var  productTotal=document.getElementById('txtproductamt').value;
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
		
		
	/* 	
		alert("descvalue"+descvalue);
		
		alert("netval"+netval);
		 */
		funRoundAmt(descvalue,"txtdiscount");
		funRoundAmt(netval,"txtnettotal");
		var aa;
	 if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
	   	            	   {
	   	               
	   	               aa=parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
	   	            	   }
	   	               else
	   	            	   {
	   	            	    aa=document.getElementById("txtnettotal").value;
	   	            	    
	   	            	
	   	            	   }
	        
				document.getElementById("orderValue").value=aa;	
	            	funRoundAmt(aa,"orderValue");
		
		 var rows = $('#jqxInvoiceReturn').jqxGrid('getrows');
	      var rowlength= rows.length;
	  	var disval=parseFloat(descvalue)/(parseInt(rowlength));
	   
			    for(var i=0;i<rowlength;i++)
						  {
		 
			    	var totamt=rows[i].total;
			     
			    	var discounts=(parseFloat(descvalue)/parseFloat(productTotal))*parseFloat(totamt);
			     
			    	var nettot=parseFloat(totamt)-parseFloat(discounts);
			    	
		  
			    	$('#jqxInvoiceReturn').jqxGrid('setcellvalue',i, "dis" ,discounts);
			    	$('#jqxInvoiceReturn').jqxGrid('setcellvalue',i, "netotal" ,nettot);
					 
				  
						  }
		 
	
		
		}
		
		
		
		
	function funvalcalcu()
		{
		
		
		document.getElementById('prddiscount').value="";
		$('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'dis',  "editable", false);
		var  productTotal=document.getElementById('txtproductamt').value;
		var  descountVal=document.getElementById('txtdiscount').value;
	 
		var descper=(parseFloat(descountVal)/parseFloat(productTotal))*100;
		var netval=parseFloat(productTotal)-parseFloat(descountVal);
		
	 
		funRoundAmt(descper,"descPercentage");
		funRoundAmt(netval,"txtnettotal");
		funcalcu();
		}
		
		
		
	 function roundval()
	{
			var  netTotaldown=document.getElementById('txtnettotal').value;
		    var roundOf=document.getElementById('roundOf').value;
	 
			 
			var	 netval=parseFloat(netTotaldown)+parseFloat(roundOf);
			funRoundAmt(netval,"txtnettotal");
			funRoundAmt(netval,"orderValue");
	}
	 
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
	
	function fundisable()
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
				 $('#txtdiscount').attr('disabled', false);
				  
		   }
		  
		   
				}
			
			
		      
	      });
		   }
		   else
		   {
		   document.getElementById('descPercentage').value="";
		   document.getElementById('txtdiscount').value="";
		   var summaryData3= $("#jqxInvoiceReturn").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	  	   document.getElementById("prddiscount").value=summaryData3.sum.replace(/,/g,'');
		   $('#descPercentage').attr('disabled', true);
			 $('#txtdiscount').attr('disabled', true);
				$('#jqxInvoiceReturn').jqxGrid('setcolumnproperty', 'dis',  "editable", true);
		   }
	   
		}
	
	function chkfoc()
    {
     
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
     {
       var items= x.responseText.trim();
       var item = items.split('##');
			var foc  = item[0];
			var kg = item[1];
       if(parseInt(foc)>0)
        {
      
        
        $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'foc');
     
        
        
         }
           else
       {
       
            $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'foc');
       
       }
       
        if(parseInt(kg)>0)
       {
     
       
       $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'kgprice');
       $('#jqxInvoiceReturn').jqxGrid('showcolumn', 'totwtkg');
    
       
       
        }
          else
      {
      
           $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'kgprice');
           $('#jqxInvoiceReturn').jqxGrid('hidecolumn', 'totwtkg');
      
      } 
       
       
       
        }}
    x.open("GET","checkfoc.jsp",true);
  x.send();
  
       
         
     
    }

	function funwarningopen(){
		   $.messager.confirm('Confirm', 'Transaction Will Affect Already Inserted Values.', function(r){
		       if (r){
 
			 		 document.getElementById("editdata").value="Editvalue";
					  $('#rrefno').attr('disabled', false);
					  $('#rrefno').attr('readonly', true);
					  $('#date').jqxDateTimeInput({disabled: false});
						$('#payDueDate').jqxDateTimeInput({disabled: false});
						$('#txtlocation').attr('disabled', false );
						$('#txtclient').attr('disabled', false );
						$('#txtclientdet').attr('disabled', false );
						$('#cmbcurr').attr('disabled', false );
						$('#rrefno').attr('disabled', false );
						$('#cmbbilltype').attr('disabled', false );
						$('#txtlocation').attr('readonly', false );
						$('#txtsalesperson').attr('readonly', false );
		    	   
		
		    		$("#jqxInvoiceReturn").jqxGrid({ disabled: false});
		    		
		    		  $("#jqxInvoiceReturn").jqxGrid('addrow', null, {});
		    		

		       }
		      });
		   }
	
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveSalesInvoiceReturncr");
	        
	        $("#docno").prop("disabled", false);                
	        
	  
	var win= window.open(reurl[0]+"printinvcreditret?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=CREDIT","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
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
					else
						{
						 
						}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();
		
		
		}
	   
	   function restrictEdit(){
		    var retval = 1; 
			if($("#mode").val()=="E" || $("#mode").val()=="R"){       
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
							var items = x.responseText;  
							if(parseInt(items)>0){
								retval = 0;
							} else {
								retval = 1; 
							}
						}else {  
						}    
				}
				x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, false);                  
				x.send();
				}
			return retval; 
		}
	   function getBill(){ 
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		     
		      items=items.split('####');
		           var pgid=items[0].split(",");
		           var pgcode=items[1].split(",");
		         
		       //alert(pgname);
		           var optionspg = '';
		         
		            for ( var i = 0; i < pgcode.length; i++) {
		            	
		            	optionspg += '<option  value="' + pgid[i] + '">' + pgcode[i] + '</option>';
		           }
		            $("select#cmbbilltype").html(optionspg);
		            if($('#hidcmbbilltype').val()!="")
					  {
		           // document.getElementById("cmbbilltype").value=$('#hidcmbbilltype').val();
		            $('#cmbbilltype').val($('#hidcmbbilltype').val());
					  }
		            gettaxaccount(1);
		     
		    }
		       }
		   x.open("GET","getBillType.jsp",true);
			x.send();
		        
		      
		        }
	   function isNumber1(evt) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
	        
	           if (iKeyCode == 45)
	                      
	             {
	            
	            
	             return true;
	               } 
	          
	          
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	         document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	           
	            return false;
	         }
	        document.getElementById("errormsg").innerText="";  
	        return true;
	    }
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
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
.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}

#divname {
    background-color: #e2c791;
    box-shadow: 10px 10px grey;
     position:fixed;z-index:1000;right:30px;top:100px;  
}
.myButtons {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.myButtons:active {
	position:relative;
	top:1px;
} 
</style>

</head>
<body onload="setValues();getCurrencyIds();getBill();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSalesReturn" action="saveSalesInvoiceReturncr" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include> 
<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<table width="100%">
  <tr>
    <td width="7%" height="42" align="right">Date</td>
    <td width="33%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="10%" align="right">Ref. No.</td>
    <td width="17%"><input type="text" id="txtrefno" name="txtrefno" style="width:50%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="9%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
  <td align="right">Sales Person</td>
  <td><input type="text" id="txtsalesperson" name="txtsalesperson" style="width:71%;" placeholder="Press F3 to Search" onKeyDown="getSalesPerson(event);" value='<s:property value="txtsalesperson"/>'>
      <input type="hidden" id="salespersonid" name="salespersonid" value='<s:property value="salespersonid"/>'/></td>
  <td align="right">Mode of Pay</td>
  <td><select id="cmbmodeofpay" name="cmbmodeofpay" style="width:51%;" value='<s:property value="cmbmodeofpay"/>'>
      <option value="credit">CREDIT</option></select>
      <input type="hidden" id="hidcmbmodeofpay" name="hidcmbmodeofpay" value='<s:property value="hidcmbmodeofpay"/>'/></td>
  <td align="right">Location</td>
  <td><input type="text" id="txtlocation" name="txtlocation" style="width:50%;" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onkeydown="getLocation(event);"/>
      <input type="hidden" id="locationid" name="locationid" value='<s:property value="locationid"/>'/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="7%" align="right">Customer</td>
    <td width="14%"><input type="text" id="txtclient" name="txtclient" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);"/></td>
    <td colspan="3"><input type="text" id="txtclientdet" name="txtclientdet" style="width:48%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/>
    </td>
  </tr>
  <tr>
     <td   align="right">Currency</td>
    <td  ><select name="cmbcurr" id="cmbcurr" style="width:73%;"  value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
      <option value="-1" >--Select--</option>
    </select><input type="hidden" id="hidcmbcurr" name="hidcmbcurr" value='<s:property value="hidcmbcurr"/>'/></td>
    <td colspan="3"><input type="text" id="currate" name="currate" style="width:11%;" value='<s:property value="currate"/>'/></td>
  </tr>
  <tr>
    <td align="right">Ref. Type</td>
    <td><select id="cmbreftype" name="cmbreftype" style="width:71%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
       <option value="INV">INV</option></select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
     <td width="14%"><input type="text" id="rrefno" name="rrefno" style="width:100%;" placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/></td> 
     <%-- <td>Sales Order
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="rrefno" name="rrefno" style="width:35%;"  placeholder="Press F3 to Search"  onKeyDown="getrefno(event);" value='<s:property value="rrefno"/>'/>
     </td> --%>
    <td width="12%" align="right">  <label id="billname">Bill Type</label>&nbsp;<select id="cmbbilltype" name="cmbbilltype"   style="width:50%;" value='<s:property value="cmbbilltype"/>'>
      <!-- <option value="1">ST</option>
      <option value="2">CST</option> -->
      
      </select>
      <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/></td>
    <td width="53%"><select hidden="true" id="cmbprice" name="cmbprice" style="width:23%;" value='<s:property value="cmbprice"/>'>
      <option></option></select>
      <input type="hidden" id="hidcmbprice" name="hidcmbprice" value='<s:property value="hidcmbprice"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Due on</td>
    <td><div id="payDueDate" name="payDueDate" value='<s:property value="payDueDate"/>'></div>
    <input type="hidden" id="hidpayDueDate" name="hidpayDueDate" value='<s:property value="hidpayDueDate"/>'/></td>
    <td align="left" colspan="3">Del. Terms <input type="text" id="txtdelterms" name="txtdelterms" style="width:65.7%;" value='<s:property value="txtdelterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Payment Terms</td>
    <td colspan="4"><input type="text" id="txtpaymentterms" name="txtpaymentterms" style="width:75%;" value='<s:property value="txtpaymentterms"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" id="txtdescription" name="txtdescription" style="width:75%;" value='<s:property value="txtdescription"/>'/>
    
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    
    
    </td>
  </tr>
</table>
</fieldset><br/>
 <fieldset id="psearch">
 
 <legend>Item Details</legend>
 
   <table width="100% " >   
   <tr> 
   <td align="center">Product ID</td>
   <td align="center">Product Name</td>
   <td align="center">Unit</td>
  <td  width="6%" align="center">Qty</td>
   <td align="center"> Unit price</td>
   <td align="center"> Total</td>
  
   </tr>
    <tr>
 <td width="15% " ><input type="text" class="form-control" id="sqotprdid" list="sqotproductid"  style="text-align: left;width:96%"><datalist id="sqotproductid" style="visibility:none;"></datalist></td>
<td width="15% " ><input type="text" class="form-control" id="sqotprdname" list="sqotprdts" style="text-align: left;width:96%"><datalist id="sqotprdts" style="visibility:none;"></datalist></td>
<td align="center"> <select    id="unit"   onchange="closes()"  >   </select>      </td> 
<td width="6%" align="center">   <input type="text"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"  id="quantity" style="text-align: left;" onchange="calculatedata(this.id);" ></td>
    <td align="center">   <input type="text"      id="uprice"   onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata(this.id);"  style="text-align: right;"     style="text-align: right;"></td>
  <td align="center">  <input type="text" id="totamt" tabindex="-1"      style="text-align: right;"   ></td>
 </tr>
 <tr>

    <td align="center">Discount% </td>
      <td align="center">Discount</td> 
 
 <td align="center">Net Total</td>
 
<td align="center">Tax%</td>  
<td align="center">Tax Amount</td>  
  <td    align="center">Net Total</td>    
    <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>    
 </tr>
 <tr>

 
 
 


 <td align="center">   <input type="text" id="dispers"    onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata(this.id);"  style="text-align: right;"  ></td> 
<td align="center">   <input type="text" id="dict"  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"   onchange="vatSwitch();"    style="text-align: right;"  ></td>
  <td align="center">   <input type="text" id="amounts" tabindex="-1"     style="text-align: right;" ></td> 

 

 <td align="center"> <input type="text" id="taxpers" onkeypress="javascript:return isNumber1 (event);"  onchange="calculatedata(this.id);"  tabindex="-1"      style="text-align: right;" ></td>  
 
 <td align="center"> 
 <input type="text" id="taxamounts"   tabindex="-1"   onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>
  <td align="center"> 
 <input type="text" id="taxamountstotal" tabindex="-1"    onkeypress="javascript:return isNumber1 (event);"  style="text-align: right;" ></td>  
  <td align="center">
     <input type="hidden" id="cleardata">
 &nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
 </tr>  
   
   </table> 
   </fieldset> 

<div id="invoiceDiv"><center><jsp:include page="invoiceReturnGrid.jsp"></jsp:include></center></div>

<%-- <fieldset>
   <legend>Summary</legend>  
<table width="100%">
<tr>
<td align="right">Product</td><td><input type="text" name="txtproductamt" readonly="readonly" id="txtproductamt" value='<s:property value="txtproductamt"/>'    style="width:50%;text-align: right;"></td>
<td align="right">Discount</td><td><input type="checkbox"  value="0" id="chkdiscount" name="chkdiscount" onchange="fundisable()"    onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
<td align="right">Discount %</td><td><input type="text" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
    <td align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funcalcu();">
       <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
      </button> 
      </td>
<td align="right">Discount Value</td><td><input type="text" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>' onblur="funvalcalcu();" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

<td><input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'   onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>

<td align="right">Round of</td><td><input type="text" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>' onblur="roundval();funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:51%;text-align: right;"></td>
<td align="right">Net Total</td><td><input type="text" name="txtnettotal" readonly="readonly" id="txtnettotal" value='<s:property value="txtnettotal"/>'  onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="width:50%;text-align: right;"></td>
 
</tr>


</table>
</fieldset>
 --%>

<%-- <fieldset>
   <legend>Service</legend>
       <div id="servicegrid" ><jsp:include page="servicegrid.jsp"></jsp:include></div>
</fieldset>
 --%>

<table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label ></label></td><td><input type="hidden" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
<tr>

</table>

</br> 
<%-- <fieldset><legend>Terms and Conditions</legend>
<table width="100%">
  <tr><td>
    <div id="termsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div><br/>
  </td></tr>
</table>
</fieldset> --%>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="refmasterdocno" name="refmasterdocno"  value='<s:property value="refmasterdocno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="termsgridlength" name="termsgridlength" value='<s:property value="termsgridlength"/>'/>
<input type="hidden" id="servgridlen" name="servgridlen"  value='<s:property value="servgridlen"/>'/>
<input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
<input type="hidden" name="txtnettotal"  id="txtnettotal" value='<s:property value="txtnettotal"/>'>
<input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
<input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
<input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
<input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>
 <input type="hidden" id="editdata" name="editdata"  value='<s:property value="editdata"/>'/>
  <input type="hidden" id="hidload" name="hidload"  value='<s:property value="hidload"/>'/>
  <input type="hidden" id="hidvatype" name="hidvatype"  value='<s:property value="hidvatype"/>'/>
  <input type="hidden" id="clntacno" name="clntacno"  value='<s:property value="clntacno"/>'/>
  <input type="hidden" id="psrno" name="psrno"  value='<s:property value="psrno"/>'/>
  <input type="hidden" id="unitdocno" name="unitdocno"  value='<s:property value="unitdocno"/>'/>
  <input type="hidden" id="outqty" name="outqty"  value='<s:property value="outqty"/>'/>
  <input type="hidden" id="balqty" name="balqty"  value='<s:property value="balqty"/>'/>
  <input type="hidden" id="totqty" name="totqty"  value='<s:property value="totqty"/>'/>
  <input type="hidden" id="stkid" name="stkid"  value='<s:property value="stkid"/>'/>
  <input type="hidden" id="temppsrno" name="temppsrno"  value='<s:property value="temppsrno"/>'/>
  <input type="hidden" id="tempspecid" name="tempspecid"  value='<s:property value="tempspecid"/>'/>
  <input type="hidden" id="rdocno" name="rdocno"  value='<s:property value="rdocno"/>'/>
  <input type="hidden" id="dis" name="dis"  value='<s:property value="dis"/>'/>
  <input type="hidden" id="discper" name="discper"  value='<s:property value="discper"/>'/>
  <input type="hidden" id="rowindexg" name="rowindexg"  value='<s:property value="rowindexg"/>'/>
  <input type="hidden" id="prodoc" name="prodoc"  value='<s:property value="prodoc"/>'/>
  <input type="hidden" id="brand" name="brand"  value='<s:property value="brand"/>'/>
  <input type="hidden" id="deldoc" name="deldoc"  value='<s:property value="deldoc"/>'/>
  <input type="hidden" id="biltype" name="biltype"  value='<s:property value="biltype"/>'/>
  <input type="hidden" id="vattype" name="vattype"  value='<s:property value="vattype"/>'/>
  <input type="hidden" id="qutval" name="qutval"  value='<s:property value="qutval"/>'/>
</div>
</form>
	
<div id="salespersonwindow">
			<div></div>
			<div></div>
		</div>
<div id="customerDetailsWindow">
	<div></div>
</div>

<div id="sidesearchwndow">
	<div></div>
</div>  
<div id="refnosearchwindow">
	<div></div>
</div>
<div id="searchwndow">
	<div></div>
</div>
<div id="locationwindow">
	<div></div>
</div>
<div id="accountsearchwindow">
			<div></div>
		</div>	
</div>
</body>
</html>
