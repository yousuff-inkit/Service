<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Store Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    #psearch {
 
background:#FAEBD7;
 
}
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.datepanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
    }
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	
/* 	.modal-dialog,
.modal-content {
    /* 80% of window height */
    height: 80%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}		 */
  </style>
 <script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script> 
  
<script type="text/javascript">

$(document).ready(function(){
	getBranch('','');
	getLocation('','');

	 $('#stocklistgrid').show();
	 $('#popendinggrid').hide();
	 $('#grnpendinggrid').hide();
	 $('#invreqgrid').hide();
	 $('#invpenissrpt').hide();
			
	 getProduct();

$('#btnsubmit').click(function(){
	
	  
	 var brhid = document.getElementById("cmbbranch").value;
	 var rds=document.getElementById("ctype").value;
		
	 if(rds=="STOCKLIST"){
		var load="yes";
		   $('.load-wrapp').show();
           $('#stocklistgrid').load("stocklistGrid.jsp?load="+load+'&brhid='+brhid);
    }else if(rds=="PENDINGPO"){
			var load="yes";
			$('.load-wrapp').show();
	        $('#popendinggrid').load('pendingpoGrid.jsp?load='+load+'&brhid='+brhid);
	 }else if(rds=="PENDINGGRN"){
			var load="yes";
			$('.load-wrapp').show();
	        $('#grnpendinggrid').load('pendingGRNGrid.jsp?load='+load+'&brhid='+brhid);
	 }else if(rds=="INVREQLIST"){
				var load="yes";
				$('.load-wrapp').show();
		        $('#invreqgrid').load('inventoryrequestGrid.jsp?load='+load+'&brhid='+brhid );  
	  }else if(rds=="PENRCPT"){
				var load="yes";
				$('.load-wrapp').show();
			    $('#invpenissrpt').load('pendingissreptGrid.jsp?load='+load+'&brhid='+brhid);
				 }
	  
	  
});

$('#btninvreq').click(function(){
	
	$('#modalinvreq').modal('show');
	
});

$('#btninvissue').click(function(){

	var brhid= $('#cmbbranch').val();


	var rowss = $("#invreqgriddet").jqxGrid('getrows');

	var rows=$("#invreqgriddet").jqxGrid('selectedrowindexes');
	rows = rows.sort(function(a,b){return a - b});
 
	if(rows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	} 
	var docnos="",brhid="",locid="";
	var accdocno="";
	var multiAcc=false;
	var i=0;i1=0;var docnos="";            
	var j=0;
	var vacno=0;
	var a1=0,a2=0,a11=0,a21=0,val1=0,val11=0;
	for (i = 0; i < rows.length; i++) {  
		if(i==0){
			docnos+=$('#invreqgriddet').jqxGrid('getcellvalue',rows[i],'docno');
			brhid+=$('#invreqgriddet').jqxGrid('getcellvalue',rows[i],'brhid');
			locid+=$('#invreqgriddet').jqxGrid('getcellvalue',rows[i],'locid');
				
		}else{
			docnos+=","+$('#invreqgriddet').jqxGrid('getcellvalue',rows[i],'docno');
			brhid+=","+$('#invreqgriddet').jqxGrid('getcellvalue',rows[i],'brhid');
			locid+=","+$('#invreqgriddet').jqxGrid('getcellvalue',rows[i],'locid');
		}  

    if(i==0){
			
			 a2 = $('#invreqgriddet').jqxGrid('getcellvalue', rows[i], "brhid");
			 a21=  $('#invreqgriddet').jqxGrid('getcellvalue', rows[i], "locid");
		 }
		 a1 = $('#invreqgriddet').jqxGrid('getcellvalue', rows[i], "brhid");
		 a11 = $('#invreqgriddet').jqxGrid('getcellvalue', rows[i], "locid");
			
			 if(a1!=a2){
			 val1=1;
		 }
			 if(a11!=a21){
				 val11=1;
			 }
	     a2=a1;	
	     a21=a11;		 
	}	
if(val1==1){
	 
	 	Swal.fire({
        type: 'error',
        title: 'Warning',
        text: 'Please select documents of  Same Branch'
    });
    return false;
}
if(val11==1){
	 
 	Swal.fire({
    type: 'error',
    title: 'Warning',
    text: 'Please select documents of  Same Location'
});
return false;
}

//alert(docnos);
//alert(brhid);   
//alert(locid);  

var type="issue";
//alert(type);
getBranch(brhid,'issue');   
getLocation(locid,'issue');   


	$('#modalinvissue').modal('show');
	$('#invissdiv').load('proinvissueGrid.jsp?docnos='+encodeURIComponent(docnos)+'&brhid='+encodeURIComponent(brhid)+'&locid='+encodeURIComponent(locid)+'&type='+type);
	
	
	
	
});


$('#btngrnentry').click(function(){
	
	funCreateGRN();
	
});


$('#btngrrentry').click(function(){
	
	funCreateGRR();
	
});

$('#btninvrcpt').click(function(){
	
	var rowss = $("#pendingissrptdet").jqxGrid('getrows');

	var rows=$("#pendingissrptdet").jqxGrid('selectedrowindexes');
	rows = rows.sort(function(a,b){return a - b});
 
	if(rows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	} 
	var docnos="",brhhid="",brhid="",locid="",branchnames="",locationnames="";
	var accdocno="";
	var multiAcc=false;
	var i=0;i1=0;var docnos="";            
	var j=0;
	var vacno=0;
	var a1=0,a2=0,a11=0,a21=0,val1=0,val11=0;
	for (i = 0; i < rows.length; i++) {  
		if(i==0){
			docnos+=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'dcnoo');  
			
		 brhhid=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'frmbrhid');  
		 brhid+=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'frmbrhid');
	     locid+=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'frmlocid');
	     branchnames=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'branchnames');
	 	locationnames=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'locationnames');
	 	
		}else{
			docnos+=","+$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'dcnoo');
		    brhid+=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'frmbrhid');
			locid+=$('#pendingissrptdet').jqxGrid('getcellvalue',rows[i],'frmlocid');
				}

    if(i==0){
			
			 a2 = $('#pendingissrptdet').jqxGrid('getcellvalue', rows[i], "frmbrhid");
			a21=  $('#pendingissrptdet').jqxGrid('getcellvalue', rows[i], "frmlocid");
		 }
		 a1 = $('#pendingissrptdet').jqxGrid('getcellvalue', rows[i], "frmbrhid");
		 a11 = $('#pendingissrptdet').jqxGrid('getcellvalue', rows[i], "frmlocid");
			
			 if(a1!=a2){
			 val1=1;
		 }
			if(a11!=a21){
				 val11=1;
			}
	     a2=a1;	
	   a21=a11;		 
	}	
if(val1==1){
	 
	 	Swal.fire({
        type: 'error',
        title: 'Warning',
        text: 'Please select documents of  Same Branch'
    });
    return false;
}
if(val11==1){
	 
 	Swal.fire({
    type: 'error',
    title: 'Warning',
    text: 'Please select documents of  Same Location'
});
return false;
}

document.getElementById("branchrcpt").value=branchnames;
document.getElementById("locationrcpt").value=locationnames;

//alert(docnos);
//alert(brhhid);

$('#modalinvissrcpt').modal('show');

$('#invissrcptdiv').load('invissueloadGrid.jsp?docnos='+encodeURIComponent(docnos)+'&brhhid='+encodeURIComponent(brhhid));

});



$("#sqotprdid").change(function(){
	var dl=$("#sqotproductid")[0];
	 var el=$("#sqotprdid")[0];
	 if(el.value.trim() != ''){
	
	var prdname = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-prdname');
	var unit = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unit');
	var psrno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-psrno')
	var balqty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-balqty')
	var doc_no = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-doc_no')
	
	document.getElementById("sqotprdname").value=prdname;
	document.getElementById("unit").value=unit;
	document.getElementById("temppsrno").value=psrno;
	document.getElementById("balqty").value=balqty;
	document.getElementById("doc_no").value=doc_no;
	    getunit(psrno);
	
	
	 }
	 
	});

$("#sqotprdname").change(function(){
	var dl=$("#sqotprdts")[0];
	 var el=$("#sqotprdname")[0];
	// alert(el.value.trim());
	 if(el.value.trim() != ''){
	
		    var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
			var unit = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unit');
			var psrno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-psrno')
			var balqty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-balqty')
		    var doc_no = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-doc_no')
		
			document.getElementById("sqotprdid").value=prdid;
			document.getElementById("unit").value=unit;
	    	document.getElementById("temppsrno").value=psrno;
	    	document.getElementById("balqty").value=balqty;
	    	document.getElementById("doc_no").value=doc_no;

	 }	
	
});


});

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
	        	   optionstype += '<option value="' + docno[i]+"::"+type[i] + '">' + type[i] + '</option>';
		        }
	            
	            $("select#unit").html(optionstype);   	  
	            
	            
	         
	  
	    }
	       }
	   x.open("GET","getunit.jsp?psrno="+val,true);
		x.send();
	        
	      
	        }	

function onchangegrid(){
	
     var rds=document.getElementById("ctype").value;
		
	 if(rds=="STOCKLIST"){
		 $("#stocklistgrid").show();
		 $("#popendinggrid").hide();
		 $("#grnpendinggrid").hide();
		 $("#invreqgrid").hide();
		 $("#invpenissrpt").hide();
			
	 }else if(rds=="PENDINGPO"){
		 $("#stocklistgrid").hide();
		 $("#popendinggrid").show();
		 $("#grnpendinggrid").hide();
		 $("#invreqgrid").hide();
		 $("#invpenissrpt").hide();
			
	 }else if(rds=="PENDINGGRN"){
		 $("#stocklistgrid").hide();
		 $("#popendinggrid").hide();
		 $("#grnpendinggrid").show();
		 $("#invreqgrid").hide();
		 $("#invpenissrpt").hide();
			
	}else if(rds=="INVREQLIST"){
			 $("#stocklistgrid").hide();
			 $("#popendinggrid").hide();
			 $("#grnpendinggrid").hide();
			 $("#invreqgrid").show();
			 $("#invpenissrpt").hide();
    }else if(rds=="PENRCPT"){
	 $("#stocklistgrid").hide();
	 $("#popendinggrid").hide();
	 $("#grnpendinggrid").hide();
	 $("#invreqgrid").hide();
	 $("#invpenissrpt").show();
		
	 }

	  
	 }
	 
function getBranch(brhid,type) {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('####');
			var brnch = items[0].split(",");
			var brnchId = items[1].split(",");
			var optionsbrand = '<option value="">--SELECT--</option>';
			var optionsbrands = '<option value="">--SELECT--</option>';
			var optionsbrands1 = '<option value="">--SELECT--</option>';
			var optionsbrands12 = '<option value="">--SELECT--</option>';
			for (var i = 0; i < brnch.length; i++) {
				optionsbrand += '<option value="' + brnch[i].trim() + '">'
						+ brnchId[i].trim() + '</option>';
				optionsbrands += '<option value="' + brnch[i].trim() + '">'
				+ brnchId[i].trim() + '</option>';
				optionsbrands1 += '<option value="' + brnch[i].trim() + '">'
				+ brnchId[i].trim() + '</option>';
		
				optionsbrands12 += '<option value="' + brnch[i].trim() + '">'
				+ brnchId[i].trim() + '</option>';
			}
//alert("optionsbrand==="+optionsbrand)
			$("select#cmbbranch").html(optionsbrand);
			$("select#branch").html(optionsbrands);
			$("select#branch1").html(optionsbrands1);
			$("select#branchrcpt").html(optionsbrands12);

		} else {
		}
	}
	x.open("GET", "getBranch.jsp?brhid="+brhid+"&type="+type, true);   
	x.send();
}

function getLocation(locid,type) {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('####');
			var location = items[0].split(",");
			var locationId = items[1].split(",");
			var optionsbrand = '<option value="">--SELECT--</option>';
			var optionsbrand1 = '<option value="">--SELECT--</option>';
			var optionsbrand12 = '<option value="">--SELECT--</option>';
			for (var i = 0; i < location.length; i++) {
				optionsbrand += '<option value="' + location[i].trim() + '">'
						+ locationId[i].trim() + '</option>';
				optionsbrand1 += '<option value="' + location[i].trim() + '">'
				+ locationId[i].trim() + '</option>';
				optionsbrand12 += '<option value="' + location[i].trim() + '">'
				+ locationId[i].trim() + '</option>';
		
			}

			$("select#location").html(optionsbrand);
			$("select#location1").html(optionsbrand1);
			$("select#locationrcpt").html(optionsbrand12);
		} else {
		}
	}
	x.open("GET", "locationSearch.jsp?locid="+locid+"&type="+type, true);
	x.send();
}


function getProduct() {

	 var id=1; 
		var optionsyear = "";
		var optionsyearnw = "";
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			
			var items = x.responseText;
			var prddatas=JSON.parse(items.trim());          
			
				$.each(prddatas.pddata, function( index, value ) {
					optionsyearnw += '<option value="' + value.part_no + '" data-prdname="'+value.productname+'" data-unit="'+value.unit+'"  data-psrno="'+value.psrno+'"  data-balqty="'+value.balqty+'" data-doc_no="'+value.doc_no+'" ></option>';
					optionsyear += '<option value="' + value.productname + '" data-prdid="'+value.part_no+'" data-unit="'+value.unit+'" data-psrno="'+value.psrno+'"  data-balqty="'+value.balqty+'" data-doc_no="'+value.doc_no+'"></option>';
				});
				//alert("==optionsyear=="+optionsyear);
				$("datalist#sqotprdts").html(optionsyear);
				$("datalist#sqotproductid").html(optionsyearnw);			
		} else {
		}
	}
	x.open("GET", 'getProduct.jsp?id='+id, true);
	x.send();
}

function setgrid() {
	
	var sqotprdid = $('#sqotprdid').val();
	var sqotprdname = $('#sqotprdname').val();
	var unit = $('#unit').val();
	var quantity = $('#quantity').val();
	var remarks = $('#remarks').val();
	var psrno = $('#temppsrno').val();
	var branch = $('#branch').val();
	var location = $('#location').val();
	var balqty= $('#balqty').val();
	var doc_no= $('#doc_no').val();
	

     
	
	if(sqotprdid==''){
		 swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please select a Product ID!!!' 
			});
		      return false;
	 }
	
	if(sqotprdname==''){
		 swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please Select a Product Name!!!'
			});
		      return false;
	 }
	
	if(unit==''){
		 swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please Select a Unit!!!'
			});
		      return false;
	 }
	
	if(quantity==''){
		 swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please Enter Quantity!!!'
			});
		      return false;
	 }
	
	if(remarks==''){
		 swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please Enter Remarks!!!'
			});
		      return false;
	 }
	
	if(branch==''){
		 swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please Select a Branch!!!'
			});
		      return false;
	 }
	
	if(location==''){
		 swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please Select a Location!!!'
			});
		      return false;
	 }
	
	  var temppsrno = document.getElementById("temppsrno").value;
	    
	    if(!$.isNumeric(temppsrno)){
			$.messager.alert('Message','Product Not Available');
			return 0;
	    }
	   
	    var rows1 = $("#productgriddet").jqxGrid('getrows');
	    var aa = 0;
	    
          
	    for (var i = 0; i < rows1.length; i++) {
	        if (parseInt(rows1[i].psrno) == parseInt(psrno)) {  
	            aa = 1;
	            break;
	        } else {
	            aa = 0;
	        }
	    }

	    if (parseInt(aa) == 1) {
	    	swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Product already selected!!!'
			});
		      return false;
	 }
	    
	    
	    
	    var rowg=$('#rowindexg').val();
	  
	    
	    if(!$.isNumeric(rowg)){
	    	$("#productgriddet").jqxGrid('addrow', null, {});
	    }
	    var rows = $('#productgriddet').jqxGrid('getrows');

	    var rowlength = rows.length;
	    
	    var rowindx = $.isNumeric(rowg) ? rowg: rowlength - 1;

	    var units = $("#unit").val().split("::");
	    
	   
	    $('#productgriddet').jqxGrid('setcellvalue', rowindx, "productid", document.getElementById("sqotprdid").value);
	    $('#productgriddet').jqxGrid('setcellvalue', rowindx, "productname", document.getElementById("sqotprdname").value);
	    $('#productgriddet').jqxGrid('setcellvalue', rowindx, "unit", units[1]);
	    $('#productgriddet').jqxGrid('setcellvalue', rowindx, "unitid", units[0]);
	    $('#productgriddet').jqxGrid('setcellvalue', rowindx, "quantity", document.getElementById("quantity").value);
		$('#productgriddet').jqxGrid('setcellvalue', rowindx, "remarks", document.getElementById("remarks").value);
		$('#productgriddet').jqxGrid('setcellvalue', rowindx, "psrno", document.getElementById("temppsrno").value);
		$('#productgriddet').jqxGrid('setcellvalue', rowindx, "branch", document.getElementById("branch").value);
		$('#productgriddet').jqxGrid('setcellvalue', rowindx, "location", document.getElementById("location").value);
		$('#productgriddet').jqxGrid('setcellvalue', rowindx, "balqty", document.getElementById("balqty").value);
		$('#productgriddet').jqxGrid('setcellvalue', rowindx, "doc_no", document.getElementById("doc_no").value);
				
		
		
		
		
		
		
	    document.getElementById("sqotprdid").value = "";
	    document.getElementById("sqotprdname").value = "";  
	    document.getElementById("unit").value = "";
	    document.getElementById("quantity").value = "";
		document.getElementById("temppsrno").value = "";
		document.getElementById("balqty").value = "";
		document.getElementById("doc_no").value = "";
		document.getElementById("temppsrno").value = "";
		   
		      
	   
	    document.getElementById("sqotprdid").focus();
	    
		
	 
	}
	
function savegrid(){  
	
	
	 var gridarray=new Array();
	 var rows=$('#productgriddet').jqxGrid('getrows');
	 var val=0,productid=0;
	 for(var i=0;i<rows.length;i++){
		 //alert(rows[i].productid+rows[i].productname+rows[i].quantity+rows[i].unit+rows[i].remarks+rows[i].branch+rows[i].location+rows[i].psrno)
	  		 gridarray.push(rows[i].productid+" :: "+rows[i].productname+" :: "+rows[i].quantity+" :: "+rows[i].unitid+" :: "+rows[i].remarks+" :: "+rows[i].branch+" :: " +rows[i].location+" :: " +rows[i].psrno+" :: ");      
	 }
	 
	 
	
	Swal.fire({
		title: 'Are you sure?',
		text: "Do you want to Save?",  
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Yes'
	}).then((result) => {
			if (result.isConfirmed) {
				savedata(gridarray); 
			}
	}); 
	
	
	
}
	
function savedata(gridarray){
	
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
			var items=x.responseText.split('####');
		    if(parseInt(items[0])=="1") {	
					$('.load-wrapp').hide();
					$('#unit').val(''); 
					$('#quantity').val('');
					$('#remarks').val('');
					$('#branch').val('');  
					$('#location').val('');  
					$('#sqotprdid').val('');  
					$('#sqotprdnname').val('');
					$('#productgriddet').jqxGrid('clear');	
					 
					 
					$('#ProloadDiv').load('ProductGrid.jsp');   
					Swal.fire({
						icon: 'success',
						title: 'Success',    
						text: 'REQ - '+items[1]+' Successfully Updated'   
					});
		    } else {
					 $('.load-wrapp').hide();
					 Swal.fire({
						    icon: 'warning',
							title: 'Warning',
							text: 'Not Updated'
					 });
					 return false;
		   } 
		    $('#modalinvreq').modal('hide');
	   }
	}
x.open("GET","saveData.jsp?productid="+encodeURIComponent(gridarray),true);   
x.send();

}



function CreateInvIssue(){
	
	//$('#invissuegriddet').jqxGrid('clearfilters');
	var branch1=document.getElementById("branch1").value;
	var location1=document.getElementById("location1").value;
	var cmbbranch=document.getElementById("cmbbranch").value;
	var balqty=document.getElementById("balqty").value;
	var quantity=document.getElementById("quantity").value;
	//alert("location1="+location1);
	//alert("branch1="+branch1);
			
	var invissuearray=new Array();
	
	var rows = $("#invissuegriddet").jqxGrid('getrows');

	/* var selectedrows=$("#invissuegriddet").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b}); */
	
	
	if(branch1==''){
			 swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a Branch!!!' 
				});
			      return false;
		 }
		
		if(location1==''){
			 swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a Location!!!' 
				});
			      return false;
		 }	
     var remarks="",txttotal="",nettottal="",finalamt="",refno="";
	    var frmbrhid=0,frmlocid=0;
		var i=0;var temptrno="",voc_no="";       
		var j=0, qty=0,rowno="";
	
		for (i = 0; i < rows.length; i++) {  
	
			 remarks =  $('#invissuegriddet').jqxGrid('getcellvalue', i, "remarks");
			 txttotal =  $('#invissuegriddet').jqxGrid('getcellvalue', i, "total");
			 txtnettotal= $('#invissuegriddet').jqxGrid('getcellvalue', i, "netotal");
			 frmbrhid=  $('#invissuegriddet').jqxGrid('getcellvalue', i, "reqbrhid");
			 frmlocid=  $('#invissuegriddet').jqxGrid('getcellvalue', i, "reqlocid");
			 finalamt=  $('#invissuegriddet').jqxGrid('getcellvalue',i, "netotal");
			 quantity =  $('#invissuegriddet').jqxGrid('getcellvalue', i, "quantity");
			 balqty =  $('#invissuegriddet').jqxGrid('getcellvalue', i, "balqty");
			 qty +=  $('#invissuegriddet').jqxGrid('getcellvalue', i, "quantity");
			 voc_no =  $('#invissuegriddet').jqxGrid('getcellvalue', i, "docno");
			 rowno =  $('#invissuegriddet').jqxGrid('getcellvalue', i, "rowno");

			 var prodoc= $('#invissuegriddet').jqxGrid('getcellvalue', i, "prodoc");
			 var unitdocno= $('#invissuegriddet').jqxGrid('getcellvalue', i, "unitdocno");
			 var quantity= $('#invissuegriddet').jqxGrid('getcellvalue', i, "quantity");
			 var totwtkg= $('#invissuegriddet').jqxGrid('getcellvalue', i, "totwtkg");
			 var kgprice= $('#invissuegriddet').jqxGrid('getcellvalue', i, "kgprice");
			 var unitprice= $('#invissuegriddet').jqxGrid('getcellvalue', i, "unitprice");
			 var total= $('#invissuegriddet').jqxGrid('getcellvalue', i, "total");
			 var discper= $('#invissuegriddet').jqxGrid('getcellvalue', i, "discper");
			 var dis= $('#invissuegriddet').jqxGrid('getcellvalue', i, "dis");
			 var netotal= $('#invissuegriddet').jqxGrid('getcellvalue', i, "netotal");
			 var specid= $('#invissuegriddet').jqxGrid('getcellvalue', i, "specid");
			 var outqty= $('#invissuegriddet').jqxGrid('getcellvalue', i, "outqty");
			 var stkid= $('#invissuegriddet').jqxGrid('getcellvalue', i, "stkid");
			 var oldqty= $('#invissuegriddet').jqxGrid('getcellvalue', i, "oldqty");
			 var foc= $('#invissuegriddet').jqxGrid('getcellvalue', i, "foc");

			 
			 
			 	 
			
			  invissuearray.push(prodoc+" :: "+unitdocno+" :: "+quantity+" :: "+totwtkg+" :: "+kgprice+" :: "+unitprice+" :: "+total+" :: "+discper+" :: "+dis+" :: "+netotal+" :: "+specid+" :: "+outqty+" :: "+stkid+" :: "+oldqty+" :: "+foc+" :: "+rowno+" :: ");
		}
	 	
		//alert(invissuearray);
		
$.messager.confirm('Confirm', 'Do you want to Create Inv Issue?', function(r){
		if (r){
			createinvissue(invissuearray,location1,branch1,remarks,frmbrhid,frmlocid,txttotal,txtnettotal,finalamt,voc_no);	
		}
	});
}
	
function createinvissue(invissuearray,location1,branch1,remarks,frmbrhid,frmlocid,txttotal,txtnettotal,finalamt,voc_no){

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items= x.responseText.trim().split('####');
		if(parseInt(items[0])>0){
		$.messager.alert('message','ITI - '+items[1]+' Successfully Generated');
			$('#invissuegriddet').jqxGrid('clear');
			$('#invreqgriddet').jqxGrid('clear');
			 $('#modalinvissue').modal('hide');
		}
		else if(parseInt(items)==-1){
			
			//alert(items[2]);
			$.messager.alert('message', 'Insufficient Stock!! ' +items[2] );
			
		}else{
			$.messager.alert('message','Not Generated');
			 $('#modalinvissue').modal('hide');
		}
		
		
	}
	else
	{
	}
	}
	x.open("GET", "createinvissue.jsp?invissuearray="+encodeURIComponent(invissuearray)+"&location1="+location1+"&branch1="+branch1+"&remarks="+remarks+"&frmbrhid="+frmbrhid+"&frmlocid="+frmlocid+"&txttotal="+txttotal+"&txtnettotal="+txtnettotal+"&finalamt="+finalamt+"&voc_no="+voc_no, true);
	x.send();

	getBranch('','');
	getLocation('','');

}

function funCreateGRN(){

	
var grnarray=new Array();
	
	var rowss = $("#orderlistdet").jqxGrid('getrows');

	var rows=$("#orderlistdet").jqxGrid('selectedrowindexes');
	rows = rows.sort(function(a,b){return a - b});
 
	if(rows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	}  
	
	var docnos="";
	var accdocno="";
	var multiAcc=false;
	var i=0;var podocnos="";            
	var j=0;
	var vacno=0;
	var a1=0,a2=0,a3=0;
	for (i = 0; i < rows.length; i++) {  
		
		if(accdocno!="" && accdocno!=$('#orderlistdet').jqxGrid('getcellvalue',rows[i],'account')){
			multiAcc=true;
		}
		accdocno=$('#orderlistdet').jqxGrid('getcellvalue',rows[i],'account');
		
		if(i==0){
			docnos+=$('#orderlistdet').jqxGrid('getcellvalue',rows[i],'doc_no');
		}else{
			docnos+=","+$('#orderlistdet').jqxGrid('getcellvalue',rows[i],'doc_no');
		}
		
		if(multiAcc){
		 	Swal.fire({
            type: 'error',
            title: 'Warning',
            text: 'Please select documents of Same Account'
        });
        return false;
		}
	
	 if(i==0){
			 vacno =  $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "acno");
		 }
		 a1 = $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "doc_no");
		 if(a1!=a2){
			 podocnos+=a1+",";
		 }
		 var psrno= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "psrno");
		 var prodoc= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "prodoc");
		 var unitdocno= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "unitdocno");
		 var qty= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "qty");
		 var saveqty= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "saveqty");
		 var checktype= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "checktype");
		 var specid= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "specid");
		 var foc= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "foc");
		 var unitprice= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "unitprice");
		 var discount= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "discount");
		 var disper= $('#orderlistdet').jqxGrid('getcellvalue', rows[i], "disper");
		
			 
        grnarray.push(psrno+":: "+prodoc+" :: "+unitdocno+" :: "+qty+" :: " +saveqty+" :: "+checktype+" :: "+specid+" :: "+foc+" ::"+unitprice+" ::"+discount+" ::"+disper+" ::");
        a2=a1;
	}
	//alert(grnarray);
	//alert(podocnos);
	$.messager.confirm('Confirm', 'Do you want to Create GRN?', function(r){
		if (r){
			createGRN(grnarray,vacno,podocnos);	
		}
	});
}
	
function createGRN(grnarray,vacno,podocnos){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items= x.responseText.trim().split('####');
		if(parseInt(items[0])>0){
			$.messager.alert('message','GRN - '+items[1]+' Successfully Generated');
		
				$('#orderlistdet').jqxGrid('clear');
				
		}
		else{
			$.messager.alert('message','Not Generated');
		}
		
	}
	else
	{
	}
	}
	x.open("GET", "createGRN.jsp?grnarray="+encodeURIComponent(grnarray)+"&vacno="+vacno+"&podocnos="+podocnos, true);   
	x.send();
}


function funCreateGRR(){

	
	var grrarray=new Array();
		
		var rowss = $("#pendinggrnGriddet").jqxGrid('getrows');

		var rows1=$("#pendinggrnGriddet").jqxGrid('selectedrowindexes');
		rows1 = rows1.sort(function(a,b){return a - b});
	 
		if(rows1.length==0){
		$("#overlay, #PleaseWait").hide();
		$.messager.alert('Warning','Select documents.');
		return false;
		} 
		
		var docnos="";
		var accdocno="";
		var multiAcc=false;
		var i=0;var podocnos="";            
		var j=0;
		var vacno=0;
		var a1=0,a2=0,a3=0;
		
		for (i = 0; i < rows1.length; i++) {  
			
			if(accdocno!="" && accdocno!=$('#pendinggrnGriddet').jqxGrid('getcellvalue',rows1[i],'account')){
				multiAcc=true;
			}
			accdocno=$('#pendinggrnGriddet').jqxGrid('getcellvalue',rows1[i],'account');
			
			if(i==0){
				docnos+=$('#pendinggrnGriddet').jqxGrid('getcellvalue',rows1[i],'doc_no');
			}else{
				docnos+=","+$('#pendinggrnGriddet').jqxGrid('getcellvalue',rows1[i],'doc_no');
			}
			
			if(multiAcc){
			 	Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Please select documents of Same Account'
	        });
	        return false;
			}
		
			
			
			 if(i==0){
				 vacno =  $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "acno");
			 }
			 a1 = $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "doc_no");
			 if(a1!=a2){
				 podocnos+=a1+",";
			 }
			
			 var psrno= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "psrno");
			 var prodoc= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "prodoc");
			 var unitdocno= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "unitdocno");
			 var qty= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "qty");
			 var saveqty= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "saveqty");
			 var checktype= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "checktype");
			 var specid= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "specid");
			 var foc= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "foc");
			 var stockid= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "stockid");
			 var oldqty= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "oldqty");
			 var oldfoc= $('#pendinggrnGriddet').jqxGrid('getcellvalue', rows1[i], "oldfoc");
					
				 
	        grrarray.push(psrno+"::"+prodoc+" :: "+unitdocno+" :: "+qty+" :: "+saveqty+" :: "+checktype+" :: "+specid+" :: "+foc+" ::"+stockid+" :: "+oldqty+" :: "+oldfoc+" :: ");
			   a2=a1;
		}
		//alert(grrarray);
		//alert(podocnos);
		
		$.messager.confirm('Confirm', 'Do you want to Create GRR?', function(r){
			if (r){
				createGRR(grrarray,vacno,podocnos);	
			}
		});
	}
		
	function createGRR(grrarray,vacno,podocnos){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items= x.responseText.trim().split('####');
			if(parseInt(items[0])>0){
				$.messager.alert('message','GRR - '+items[1]+' Successfully Generated');
			
				$('#pendinggrnGriddet').jqxGrid('clear');
				
			}
			else{
				$.messager.alert('message','Not Generated');
			}
			
		}
		else
		{
		}
		}
		x.open("GET", "CreateGRR.jsp?grrarray="+encodeURIComponent(grrarray)+"&vacno="+vacno+"&podocnos="+podocnos, true);   
		x.send();
	}
	
	
	
	
	function funCreateITR(){
		
	
		var itrarray=new Array();
			
			var rows2 = $("#pendingissrptload").jqxGrid('getrows');

		/* 	var rows2=$("#pendingissrptload").jqxGrid('selectedrowindexes');
			rows1 = rows2.sort(function(a,b){return a - b});
		 */ 

			var docnos="";
			var accdocno="";
			var multiAcc=false;
			var i=0;var podocnos="";            
			var j=0;
			var vacno=0;
			var a1=0,a2=0,a3=0;
			 var remarks="",txttotal="",nettottal="",finalamt="";
			 var branchrcpt=0,locationrcpt=0,tolocid=0,tobrhid=0;
			
		 	for (i = 0; i < rows2.length; i++) {  
				
              	 if(i==0){
					 vacno =  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "voc_no");
				 }
				 a1 = $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "docnoo");
				 if(a1!=a2){
					 podocnos+=a1+",";
				 } 
				 txttotal =  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "total");
				 txtnettotal= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "netotal");
				 frmbrhid=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "frmbrhid");
				 frmlocid=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "frmlocid");
				 finalamt=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "netotal");
				 remarks=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "remarks");
				 tolocid=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "tolocid");
				 tobrhid=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "tobrhid");
					
				 locationrcpt=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "frmlocid");
				 branchrcpt=  $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "frmbrhid");
				 
					
			 	
				
				 
				 var prodoc= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "prodoc");
				 var unitdocno= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "unitdocno");
				 var qty= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "qty");
				 var totwtkg= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "totwtkg");
				 var kgprice= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "kgprice");
				 var unitprice= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "unitprice");
				 var total= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "total");
				 var discper= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "discper");
				 var dis= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "dis");
				 var netotal= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "netotal");
				 var specid= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "specid");
				 var outqty= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "outqty");
				 var stkid= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "stkid");
				 var oldqty= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "oldqty");
				 var foc= $('#pendingissrptload').jqxGrid('getcellvalue', rows2[i], "foc");
								
			
			
				 
				 
		        itrarray.push(prodoc+"::"+unitdocno+"::"+qty+"::"+totwtkg+"::"+kgprice+"::"+unitprice+"::"+total+"::"+discper+"::"+dis+"::"+netotal+"::"+specid+"::"+outqty+"::"+stkid+"::"+oldqty+"::"+foc+"::");
				    a2=a1;
			}
			//alert(itrarray);
			//alert(podocnos);
			
			$.messager.confirm('Confirm', 'Do you want to Create Inv Issue Receipt?', function(r){
				if (r){
					createITR(itrarray,branchrcpt,locationrcpt,tobrhid,tolocid,remarks,txttotal,txtnettotal,finalamt,vacno,podocnos);	
				}
			});
		}
			
		function createITR(itrarray,branchrcpt,locationrcpt,tobrhid,tolocid,remarks,txttotal,txtnettotal,finalamt,vacno,podocnos){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items= x.responseText.trim().split('####');
				if(parseInt(items[0])>0){
					$.messager.alert('message','ITR - '+items[1]+' Successfully Generated');
				
					$('#pendingissrptload').jqxGrid('clear');
					$('#pendingissrptdet').jqxGrid('clear');
					 $('#modalinvissrcpt').modal('hide');
					
				}
				else{
					$.messager.alert('message','Not Generated');
				}
				
			}
			else
			{
			}
			}
			x.open("GET", "CreateInvIssRpt.jsp?itrarray="+encodeURIComponent(itrarray)+"&branchrcpt="+branchrcpt+"&locationrcpt="+locationrcpt+"&tobrhid="+tobrhid+"&tolocid="+tolocid+"&remarks="+remarks+"&txttotal="+txttotal+"&txtnettotal="+txtnettotal+"&finalamt="+finalamt+"&vacno="+vacno+"&podocnos="+podocnos, true);   
			x.send();
	
		}
		
		function stockcheck(){
			
			var invarray=new Array();
			
			var rows = $("#invissuegriddet").jqxGrid('getrows');

			/* var selectedrows=$("#invissuegriddet").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b}); */
			var branch1=document.getElementById("branch1").value;
			var location1=document.getElementById("location1").value;
			
			//alert("brch1=="+branch1);
		//	alert("loc1====="+location1);
			
		var nettottal="",finalamt="",refno="";
			
			
			    
				var i=0;var temptrno="";       
				var j=0;
			
				for (i = 0; i < rows.length; i++) {  
			
					 remarks =  $('#invissuegriddet').jqxGrid('getcellvalue', i, "remarks");


					 
					 
					 
					 var prodoc= $('#invissuegriddet').jqxGrid('getcellvalue', i, "prodoc");
					 var unitdocno= $('#invissuegriddet').jqxGrid('getcellvalue', i, "unitdocno");
					 var quantity= $('#invissuegriddet').jqxGrid('getcellvalue', i, "quantity");
					 var totwtkg= $('#invissuegriddet').jqxGrid('getcellvalue', i, "totwtkg");
					 var kgprice= $('#invissuegriddet').jqxGrid('getcellvalue', i, "kgprice");
					 var unitprice= $('#invissuegriddet').jqxGrid('getcellvalue', i, "unitprice");
					 var total= $('#invissuegriddet').jqxGrid('getcellvalue', i, "total");
					 var discper= $('#invissuegriddet').jqxGrid('getcellvalue', i, "discper");
					 var dis= $('#invissuegriddet').jqxGrid('getcellvalue', i, "dis");
					 var netotal= $('#invissuegriddet').jqxGrid('getcellvalue', i, "netotal");
					 var specid= $('#invissuegriddet').jqxGrid('getcellvalue', i, "specid");
					 var outqty= $('#invissuegriddet').jqxGrid('getcellvalue', i, "outqty");
					 var stkid= $('#invissuegriddet').jqxGrid('getcellvalue', i, "stkid");
					 var oldqty= $('#invissuegriddet').jqxGrid('getcellvalue', i, "oldqty");
					 var foc= $('#invissuegriddet').jqxGrid('getcellvalue', i, "foc");

					 
					 
					 	 
					
					 invarray.push(prodoc+" :: "+unitdocno+" :: "+quantity+" :: "+totwtkg+" :: "+kgprice+" :: "+unitprice+" :: "+total+" :: "+discper+" :: "+dis+" :: "+netotal+" :: "+specid+" :: "+outqty+" :: "+stkid+" :: "+oldqty+" :: "+foc+" :: ");
				}
			
			
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items= x.responseText.trim().split('####');
				if(parseInt(items[0])>0){
					
					$.messager.alert('message','Insufficient Stock!!!- '+items[1]);
					
				}
				else{
					
					 
				}
				
			}
			else
			{
			}
			}
			x.open("GET", "stockcheck.jsp?invarray="+encodeURIComponent(invarray)+"&branch1="+branch1+"&location1="+location1, true);   
			x.send();
	
		}
		
		
		


</script>

</head>
<body>

<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
    
   <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="primarypanel custompanel">
        
       <table> 
      <tr> 
      <td><label class="branch">Branch</label><select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' style="width:100px;"></select></td>
      <td><label class="branch">Type</label><select id="ctype" name="ctype" value='<s:property value="ctype"/>' onchange="onchangegrid();" style="width:180px;">
      <option value="STOCKLIST">Stock List</option><option value="PENDINGPO">Pending PO</option><option value="PENDINGGRN">Pending GRN</option><option value="INVREQLIST">Inventory Request List
       </option><option value="PENRCPT">Pending Issue Receipts</option></select></td>
       </tr>
 </table></div>
 <div class="primarypanel custompanel">
	 	<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
        <button type="button" class="btn btn-default" id="btngrnentry" data-toggle="tooltip" title="GRN entry" data-placement="bottom"><i class="fa fa-sign-in" aria-hidden="true"></i></button>
        <button type="button" class="btn btn-default" id="btngrrentry" data-toggle="tooltip" title="GRR entry" data-placement="bottom"><i class="fa fa-external-link-square" aria-hidden="true"></i></button>
        <button type="button" class="btn btn-default" id="btninvreq" data-toggle="tooltip" title="Inventory Request" data-placement="bottom"><i class="fa fa-retweet" aria-hidden="true"></i></button>
        <button type="button" class="btn btn-default" id="btninvissue" data-toggle="tooltip" title="Inventory Issue" data-placement="bottom"><i class="fa fa-inbox" aria-hidden="true"></i></button>
        <button type="button" class="btn btn-default" id="btninvrcpt" data-toggle="tooltip" title="Inventory receipt" data-placement="bottom"><i class="fa fa-file" aria-hidden="true"></i></button>
    
     </div>
      </div>

</div>
</div>   




 
  <div id="modalinvreq" class="modal fade" role="dialog" >          
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">   
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Inventory Request<span></span></h4><label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>


                    <div class="modal-body">     
            	
                      <div class="row"> 
  					  <div class="col-xs-12 col-sm-8 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="branch">Branch</label>         
		        					<select  id="branch" name="branch" class="form-control input-sm" style="height:20%;"> </select>
	                     	    </div>     
		                   </div> 
  					    
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="location">Location</label>         
		        					<select id="location" name="location" class="form-control input-sm" style="height:20%;"> </select>   
	                     	    </div>     
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">           
		        				<div class="form-group">
		        					<label for="remarks">Remarks</label>      
		        					<input type="text" id="remarks" name="remarks" class="form-control input-sm" style="height:26px;"> 
		        					 
	                     	    </div>  
	                     	  
		                   </div>
                   
		 
		                   </div>
		                
 <div class="row">      
 
 		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				                   
<label>Product ID</label><input type="text" class="form-control" id="sqotprdid" list="sqotproductid" style="height:26px;" ><datalist id="sqotproductid" style="visibility:none;"></datalist>
</div>
<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        		
<label>Product Name</label><input type="text" class="form-control" id="sqotprdname" list="sqotprdts" style="height:26px;"><datalist id="sqotprdts" style="visibility:none;"></datalist>
		                   
</div>		     
  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="unit">Unit:</label>         
		        				<div><select id="unit" class="form-control input-sm" style="height:20%;" ></select>  </div>     
	                     	    </div>     
		                   </div> 
		                   
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="quantity">Qty:</label>         
		        					<input type="text" id="quantity" name="quantity" class="form-control input-sm" style="height:26px;">    
	                     	    </div>     
		                   </div> 
		                   
		                  
		                   
		                    <input type="hidden" id="balqty" >  
		                   <input type="hidden" id="doc_no" >  
		                  
		                   
		                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			                   <div class="proaddbtn"  style="text-align:right">  
			                  <button type="button" class="btn btn-default btn-primary" id="proaddbtn" onclick=" setgrid();" >ADD PRODUCT</button>   
			                   </div>
			                   <tr><td >&nbsp;</td></tr>
		                   </div> 
		                   
		                     
		                    <input type="hidden" id="temppsrno" >  
		                    
		                   </div> 
		                   
		                    <div class="row">      
		                     <div id="productdiv"><jsp:include page="productGrid.jsp"></jsp:include></div>    
		                  
		                    <tr><td >&nbsp;</td></tr>
		                    
		                      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			                   <div class="btnprosave"  style="text-align:right">  
			                  <button type="button" class="btn btn-default btn-primary" id="btnprosave" onclick=" savegrid();" >SAVE</button>   
			                   </div>
		                   </div> 
		                                    
				             </div>
				     
				           
		             
</div>
</div></div></div>

 <div id="modalinvissue" class="modal fade" role="dialog">          
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">   
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Inventory Issue<span></span></h4><label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>


                    <div class="modal-body">     
            	
                      <div class="row"> 
                     
                
  					  <div class="col-xs-12 col-sm-8 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="branch1">From Branch</label>         
		        					<select  id="branch1" name="branch1" class="form-control input-sm" style="height:20%; "> </select>
	                     	    </div>     
		                   </div> 
  					    
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="location1">From Location</label>         
		        					<select id="location1" name="location1" class="form-control input-sm" style="height:20%; "> </select>   
	                     	    </div>     
		                   </div> 
		                   
		                   <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			                   <div class="btnstkchk"  style="text-align:right">  
			                  <button type="button" class="btn btn-default btn-primary" id="btnstkchk" onclick="stockcheck();" >Stock Check</button>   
			                   </div>
		                   </div> 
		                              
		               
		                   
		                       <input type="hidden" id="balqty" >  
		                <input type="hidden" id="quantity" >  
		                  
		                    
</div>

 <div class="row">      
 <tr><td >&nbsp;</td></tr>
		                   
		                      <div id="invissdiv"><jsp:include page="proinvissueGrid.jsp"></jsp:include></div>    
		                    <tr><td >&nbsp;</td></tr>
		                    
		                      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			                   <div class="btnisssave"  style="text-align:right">  
			                  <button type="button" class="btn btn-default btn-primary" id="btnisssave" onclick="CreateInvIssue(); " >SAVE</button>   
			                   </div>
		                   </div> 
		                                    
				             </div>
				     </div></div></div></div>
				     
			     
				      <div id="modalinvissrcpt" class="modal fade" role="dialog">          
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">   
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Inventory Issue Receipt<span></span></h4><label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>


                    <div class="modal-body">     
            	
                      <div class="row"> 
                     
                
  					  <div class="col-xs-12 col-sm-8 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="branchrcpt">Branch</label>         
		        					<input  id="branchrcpt" name="branchrcpt" class="form-control input-sm" style="height:20%;"> 
	                     	    </div>     
		                   </div> 
  					      
  					    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="locationrcpt">Location</label>         
		        					<input id="locationrcpt" name="locationrcpt" class="form-control input-sm" style="height:20%; width:50%"> 
	                     	    </div>     
		                   </div> 
		                   
		                   
		                  
		                     
</div>

 <div class="row">     
 
 
 <div id="invissrcptdiv"><jsp:include page="invissueloadGrid.jsp"></jsp:include></div>    
		                    <tr><td >&nbsp;</td></tr>
		                     
		            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			                   <div class="btnisssave"  style="text-align:right">  
			                  <button type="button" class="btn btn-default btn-primary" id="btnisssave" onclick="funCreateITR();" >Create Inv Receipt</button>   
			                   </div>
		                   </div> 
		                                    
				             </div>
				     </div></div></div></div> 
				     
				     

 <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="stocklistgrid"><jsp:include page="stocklistGrid.jsp"></jsp:include></div>
      </div>
      
       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="popendinggrid"><jsp:include page="pendingpoGrid.jsp"></jsp:include></div>
      </div>
      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="grnpendinggrid"><jsp:include page="pendingGRNGrid.jsp"></jsp:include></div>
      </div>
      
       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="invreqgrid"><jsp:include page="inventoryrequestGrid.jsp"></jsp:include></div>
      </div>
      
       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="invpenissrpt"><jsp:include page="pendingissreptGrid.jsp"></jsp:include></div>
      </div>
      
      
    </div>
    
</body>
</html>