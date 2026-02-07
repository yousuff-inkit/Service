<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Purchase Order Process</title>
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

</head>
<body onLoad="getInitData();">
	
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
      <form class="form-inline">
        <div class="primarypanel custompanel">
          <div class="form-group col-auto">
            <label class="form-group">Branch:</label>
            <div class="form-group">
              <select id="cmbbranch" name="cmbbranch"></select>
            </div>
            
           &nbsp;&nbsp;&nbsp;&nbsp;
           		<div class="form-group col-auto" style="display:none;">
           	 		<label class="form-group">Location:</label>
           		  	<div class="form-group">
              			<select id="txtlocation" name="txtlocation"></select>
            		</div>
            	</div>
            	
            	&nbsp;&nbsp;&nbsp;&nbsp;
            	
            	<div class="form-group col-auto">
           	 		<label class="form-group">Vendor:</label>
           		 <div class="form-group">
               		<input id="txtvendor" type="text" readonly="readonly"  onKeyDown="getVendor(event);" placeholder="Press F3 to Search" style="height:27px; border-radius:3px; border-width:thin; text-indent:6px; font-size:1.4rem;">
            	</div>
            	</div>
            	
            	
         
            <div class="form-group col-auto" style="margin-top:3px" hidden=true>
               <input hidden=true id="rsumm" type="radio" name="stkled" onchange="fundisable();"onclick="$(this).attr('value', this.checked ? 1 : 0)" >
               <label for="rsumm" hidden=true>Summary</label>   
       		</div>
       		
       		    &nbsp;&nbsp;&nbsp;&nbsp;
        
          <div class="form-group col-auto">
            <label class="form-group">Product:</label>
            <div class="form-group">
              <select  id="prodsearchby" name="prodsearchby"></select>
            </div>
            
            
            <div class="form-group">
            	<button type="button" class="btn btn-default" onClick="setprodSearch();" id="additem" name="btnadditem" data-toggle="tooltip" title="Add" data-placement="bottom">
            	<i class="fa fa-plus" aria-hidden="true"></i>
        	</button>&nbsp;<button type="button" class="btn btn-default" onClick="setRemove();" id="btnremoveitem" name="btnremoveitem" data-toggle="tooltip" title="Remove" data-placement="bottom">
            	<i class="fa fa-minus" aria-hidden="true"></i>
        	</button>
        	
        	
        	<button type="button" class="btn btn-default" id="popoverButton">
           		<i class="fa fa-list" aria-hidden="true" data-toggle="tooltip" title="Product Details" data-placement="bottom"></i>
          	</button>
        	
        	<textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:90%;" rows="13"  readonly hidden=true></textarea>
        	
            </div>
          </div> 
          </div>
        </div>
        <div class="primarypanel custompanel">
          	<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom">
            	<i class="fa fa-refresh" aria-hidden="true"></i>
        	</button>
        </div>
        <div class="primarypanel custompanel">
          
          	<button type="button" class="btn btn-default" id="btnclear" onclick="funClearData();">
           		<i class="fa fa-undo" aria-hidden="true" data-toggle="tooltip" title="Clear" data-placement="bottom"></i>
          	</button>
          
          
          	<button type="button" class="btn btn-default" id="btnprint"  onclick="funPrint();">
           		<i class="fa fa-print" aria-hidden="true" data-toggle="tooltip" title="Print" data-placement="bottom"></i>
          	</button>
          		
          	<button type="button" class="btn btn-default" id="btnpurchaseorder">
           		<i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Purchase Order" data-placement="bottom"></i>
          	</button>
        </div>
        
        <div>
        	<input type="hidden" id="vendor" name="vendor"  value='<s:property value="vendor"/>' />
        	<input type="hidden" id="locid" name="locid"/> <!-- value='<s:property value="locid"/>' -->
        	<input type="hidden" id="psrno" name="psrno" /> <!-- value='<s:property value="psrno"/>'  -->
        	<input type="hidden" id="txtpartno" name="txtpartno" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>'/>
        	<input type="hidden" id="txtproductname" name="txtproductname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/>
        	<input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  <input type="hidden" name="hidvendoracno" id="hidvendoracno">
			  <input type="hidden" name="hidvendorcldocno" id="hidvendorcldocno">
			  <input type="hidden" name="hidvendoraccount" id="hidvendoraccount">
			   <input type="hidden" name="hidcurates" id="hidcurates">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct">
			  <input type="hidden" name="hidvendor" id="hidvendor">
        	
        	  <input type="hidden" id="statusselect" name="statusselect">
   			  <input type="hidden" id="acno" name="acno">
        </div>
       
      </form>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div id="mainDiv">
       <div id="stockLedgerDiv"><jsp:include page="stockGridSummary.jsp"></jsp:include></div> 
    </div>
  </div>
</div>

<div id="modalpurchaseinv" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:center">Purchase Invoice Creation</h4>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Date</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <div id="masterdate"></div>
          	</div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Bill Type</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <select id="cmbbilltype"></select>
            </div>
          </div>
       

        <!--   <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Location</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="txtlocation" style="height:22px" placeholder="Location" onkeydown="getLocation(event);" readonly/>
              <input type="hidden" id="locid">
            </div>
          </div>  -->
          
           <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Inv No</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="invno" style="height:22px" placeholder="Inv No" autocomplete="off"/>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Inv Date</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <div id="invdate" style="border: 1px solid black" style="width:69%;"></div>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Del Date</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <div id="deldate" style="border: 1px solid black" style="width:69%;"></div>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Delivery Terms</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <textarea class="textarea-simple-1" style="width:100%;height:60px;" placeholder="Delivery Terms" id="delterms"></textarea>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Payment Terms</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <textarea class="textarea-simple-1" style="width:100%;height:60px;" placeholder="Payment Terms" id="payterms"></textarea>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <textarea class="textarea-simple-1" style="width:100%;height:60px;" placeholder="Description" id="desc"></textarea>
            </div>
          </div>
          
        </div>
        <div class="clear"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="btncreateinv">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
      </div>
    </div>
  </div>
</div>

<div id="textviewWindow">
	<div></div><div></div>
</div>

<div id="productDetailsWindow">
	<div></div><div></div>
</div>

<div id="locationDetailsWindow">
	<div></div><div></div>
</div>

<div id="ptypewindow">
<div></div>
</div>

<div id="pvendorwindow">
<div></div>
</div>

<div id="productwindow">
<div></div>
</div>

<div id="brandwindow">
<div></div>
</div>

<div id="pcategorywindow">
<div></div>
</div>

<div id="psubcategorywindow">
<div></div>
</div>

<div id="departmentwindow">
<div></div>
</div>

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
let loaded=false;
$(document).ready(function() {
	$('[data-toggle="tooltip"]').tooltip();
	$('#stockLedgerDiv').show();
	$('#stockLedgerDetDiv').hide();
	document.getElementById('rsumm').checked=true;	
});


$('#textviewWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Selected',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#textviewWindow').jqxWindow('close');

$('#productDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#productDetailsWindow').jqxWindow('close');

$('#locationDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
$('#locationDetailsWindow').jqxWindow('close');

$('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#ptypewindow').jqxWindow('close');

$('#pvendorwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Vendor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#pvendorwindow').jqxWindow('close');

$('#brandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#brandwindow').jqxWindow('close');

$('#departmentwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#departmentwindow').jqxWindow('close');

$('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#productwindow').jqxWindow('close');

$('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#pcategorywindow').jqxWindow('close');

$('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#psubcategorywindow').jqxWindow('close');

$('#txtpartno').dblclick(function(){
	 productSearchContent('productSearch.jsp', $('#productDetailsWindow'));
}); 





$('#popoverButton').click(function(){
	var textdata = "<textarea rows="+30+" cols="+60+" style="+"border:none; outline: none; resize: none;"+">"+document.getElementById("searchdetails").value+"</textarea>";
	 $('#textviewWindow').jqxWindow('setContent', textdata);
	 $('#textviewWindow').jqxWindow('open');
});






$('#txtlocation').dblclick(function(){
	locationSearchContent('locationSearch.jsp', $('#locationDetailsWindow'));
	
});

$('#txtvendor').dblclick(function(){
	
	vendorSearchContent('vendorsearch.jsp', $('#pvendorwindow'));
});

$('#btnpurchaseorder').click(function(){
	
	funPurchaseorder();
});

$('#btnproduct').click(function(){
	getProduct()
});


$('#btnsubmit').click(function(){
	funreload(event)
});


function funopen(docno){	
	var url=document.URL;
	var reurl=url.split("com/");
	
	window.parent.formName.value="Purchase Order";
	window.parent.formCode.value="PO";
	//alert(document.getElementById("hidcurates").value);	
	var detName= "Purchase Order";
	var path= "com/Procurement/Purchase/PurchaseOrder/PurchaseOrder.jsp?mod=A"+"&venddocno="+document.getElementById("hidvendoracno").value+"&vendname="+encodeURIComponent(document.getElementById("vendor").value)+"&vendaccount="+document.getElementById("hidvendoraccount").value+"&docno="+docno+"&currate="+document.getElementById("hidcurates").value+"&check=1";
	top.addTab( detName,reurl[0]+""+path);

}

function getProduct(){
	
	var brandid=$('#hidbrandid').val().trim();
	var catid=$('#hidcatid').val().trim();
	var subcatid=$('#hidsubcatid').val().trim();
	
	 $('#productwindow').jqxWindow('open');
		$('#productwindow').jqxWindow('focus');
		 productSearchContent('prodSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, $('#productwindow'));

}

function productSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#productwindow').jqxWindow('setContent', data);

	}); 
	}
	




function funClearData(){
		document.getElementById('txtpartno').value="";
		document.getElementById('txtproductname').value="";
		document.getElementById('psrno').value="";
		document.getElementById('rsumm').checked=true;
		$('#txtpartno').attr('placeholder', 'Press F3 TO Search'); 
		document.getElementById("locid").value="";
		document.getElementById("vendor").value="";
		document.getElementById("txtvendor").value="";
		document.getElementById("hidvendorcldocno").value="";
		document.getElementById("hidvendoracno").value="";
		document.getElementById("hidvendoraccount").value="";
		document.getElementById("vendor").value="";
		document.getElementById("hidbrandid").value="";
		document.getElementById("hidtypeid").value="";
		document.getElementById("hidproductid").value="";
		document.getElementById("hidcatid").value="";
		document.getElementById("hidsubcatid").value=""; 
		document.getElementById("hidbrand").value="";
		document.getElementById("hidtype").value="";
		document.getElementById("hidproduct").value="";
		document.getElementById("hidcat").value="";
		document.getElementById("hidsubcat").value="";
		document.getElementById("searchdetails").value="";
		document.getElementById("hideptid").value="";
		document.getElementById("hidept").value="";
		document.getElementById("hidvendoracno").value="";
		document.getElementById("hidvendorcldocno").value="";
		$("#cmbbranch").val('').trigger('change');
		$("#prodsearchby").val('').trigger('change');
		$("#txtlocation").val('').trigger('change');
//$("#partSearchdiv").load("partSearchGrid.jsp");

}


function setRemove(){
	document.getElementById("hidbrandid").value="";
	document.getElementById("hidtypeid").value="";
	document.getElementById("hidproductid").value="";
	document.getElementById("hidcatid").value="";
	document.getElementById("hidsubcatid").value=""; 
	document.getElementById("hidbrand").value="";
	document.getElementById("hidtype").value="";
	document.getElementById("hidproduct").value="";
	document.getElementById("hidcat").value="";
	document.getElementById("hidsubcat").value="";
	document.getElementById("prodsearchby").value="";
	document.getElementById("searchdetails").value="";
	document.getElementById("hideptid").value="";
	document.getElementById("hidept").value="";
	$("#prodsearchby").val('').trigger('change');
}


function funPrint(){
	 var barchval = document.getElementById("cmbbranch").value;
	 var branchid=document.getElementById("cmbbranch").value;
	 var hidbrand=document.getElementById("hidbrandid").value;
	 var hidtype=document.getElementById("hidtypeid").value;
	 var hidproduct=document.getElementById("hidproductid").value;
	 var hidcat=document.getElementById("hidcatid").value;
	 var hidsubcat=document.getElementById("hidsubcatid").value;
	 var hidept=document.getElementById("hideptid").value;
	 var hidcldocno=document.getElementById("hidvendorcldocno").value;
	 var hidacno=document.getElementById("hidvendoracno").value;
	     
		 var statusselect=$("#statusselect").val();
		 
		 var psrno=$("#psrno").val();
		 
		 var locid=$("#txtlocation").val();
		 
		 var url=document.URL;
			var reurl=url.split("com");
			var path= "com/dashboard/procurment/purchaseorderprocess/purchaseorderprocessprint.action?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&locid="+locid+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&hidcldocno="+hidcldocno+"&hidacno="+hidacno+"&type=1";
			var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
			win.focus();		
		 
		
	}



function getInitData() {
    $.get('getInitData.jsp', function(data) {
    	data = JSON.parse(data.trim());
        
        var htmldata = '';
        $.each(data.branchdata, function(index, value) {
            htmldata += '<option value="' + value.docno + '">' + value.refname + '</option>';
        });
        $('#cmbbranch').html($.parseHTML(htmldata));
        $('#cmbbranch').select2({
            placeholder: "Select Branch",
            allowClear: true
        }); 
        
        htmldata = '';
        $.each(data.billtypedata, function(index, value) {
            htmldata += '<option value="' + value.docno + '">' + value.code + '</option>';
        });
        $('#cmbbilltype').html($.parseHTML(htmldata));
        
        htmldata ='';
        $.each(data.locationdata, function(index, value){
        	 htmldata += '<option value="' + value.docno + '">' + value.location + '</option>';
        });
        $('#txtlocation').html($.parseHTML(htmldata));
        $('#txtlocation').select2({
            placeholder: "Select Location",
            allowClear: true
        }); 
        $("#txtlocation").append("<option value='' selected disabled>Select Location</option>");
           
        
        data = {"productdata":[
        	
        	{"val":"","display":""},
        	{"val":"ptype","display":"TYPE"},
        	{"val":"pbrand","display":"BRAND"},
        	{"val":"pdept","display":"DEPARTMENT"},
        	{"val":"pcategory","display":"CATEGORY"},
        	{"val":"psubcategory","display":"SUB CATEGORY"}
        ]};
        
        htmldata = '';
        $.each(data.productdata, function(index, value) {
            htmldata += '<option value="' + value.val + '">' + value.display + '</option>';
        });
        $('#prodsearchby').html($.parseHTML(htmldata));
        $('#prodsearchby').select2({
            placeholder: "Select Product",
            allowClear: true
        });
        
        
        $('.load-wrapp').hide();
    });
}

function locationSearchContent(url) {
    $('#locationDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#locationDetailsWindow').jqxWindow('setContent', data);
	$('#locationDetailsWindow').jqxWindow('bringToFront');
}); 
}

function vendorSearchContent(url) {
	$("#stocklistgrid").jqxGrid('clear');
   $('#pvendorwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#pvendorwindow').jqxWindow('setContent', data);
	$('#pvendorwindow').jqxWindow('bringToFront');
});
}

function getLocation(){
	 $('#locationDetailsWindow').jqxWindow('open');
		$('#locationDetailsWindow').jqxWindow('focus');
		locationSearchContent('locationSearch.jsp', $('#locationDetailsWindow'));

}

function funPurchaseorder()
{
	
	
	var cmbbranch=document.getElementById("cmbbranch").value;
	if(cmbbranch=="a" || cmbbranch=="")
	{
  $.messager.alert('Message',' Branch Is Mandatory','warning');   
  document.getElementById("cmbbranch").focus();
  return 0;
	}
	
	var vend=document.getElementById("hidvendorcldocno").value;
	if(vend=="")
	{
  $.messager.alert('Message',' Vendor Is Mandatory','warning');   
  return 0;
	}
	
	var selectedrows=$("#stocklistgrid").jqxGrid('selectedrowindexes');
	if(selectedrows.length==0){
		 $.messager.alert('Message',' Product Is Mandatory','warning');   
		  return 0;
			}
		
	$('#stocklistgrid').jqxGrid('clearfilters');
	var listss = new Array();
	var selectedrows=$("#stocklistgrid").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});
		  for(var i=0 ; i < selectedrows.length ; i++){
			 listss.push($("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'foc')
					 +"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'extfoc')
					 +"::"+$("#stocklistgrid").jqxGrid('getcellvalue',selectedrows[i],'price')); 
				  }
		   save(listss);
            
	   
	
	}
	
function save(listss){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) 
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			 
  if(parseInt(itemval)>0)
  	{
			 	funopen(itemval);
	 
			}
		else
			{
			}  
	}
	}  
x.open("GET","savedata.jsp?list="+listss+"&venddocno="+document.getElementById("hidvendoracno").value);
	x.send();
}

function funreload(event)
{
	
	 branchid=document.getElementById("cmbbranch").value;
 	 hidbrand=document.getElementById("hidbrandid").value;
	 hidtype=document.getElementById("hidtypeid").value;
	 hidproduct=document.getElementById("hidproductid").value;
	 hidcat=document.getElementById("hidcatid").value;
	 hidsubcat=document.getElementById("hidsubcatid").value;
	 hidept=document.getElementById("hideptid").value;
	 hidcldocno=document.getElementById("hidvendorcldocno").value;
	 hidacno=document.getElementById("hidvendoracno").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();

	 var barchval = document.getElementById("cmbbranch").value;
     
	 var statusselect=$("#statusselect").val();
	 
	 var psrno=document.getElementById("psrno").value;
	 var locid=$("#txtlocation").val();
	 
	 
	if(hidcldocno==""){
	 	$.messager.alert('Message',' Vendor Is Mandatory','warning');   
	  	return 0;
	}
   
		if (document.getElementById('rsumm').checked) {
			
			
			  $("#overlay, #PleaseWait").show();
			  var load="yes";
			  $('.load-wrapp').show();
			  $("#stockLedgerDiv").load("stockGridSummary.jsp?barchval="+barchval+"&statusselect="+statusselect+"&psrno="+psrno+"&locid="+locid+"&load="+load+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&hidcldocno="+hidcldocno+"&hidacno="+hidacno+"&fromdate="+fromdate+"&todate="+todate+"&type=1");
			 
		}
		
		
	}
	
function setprodSearch(){
	var value=$('#prodsearchby').val().trim();

	if(value=="ptype"){
		getPtype();
	}
	else if(value=="pbrand"){
		getPbrand(2);
	}
	else if(value=="pdept"){
		getDept();
	}
	else if(value=="product"){
		getProduct();
	}
	else if(value=="pcategory"){
		getPcategory();
	}
	else if(value=="psubcategory"){
		getPsubcategory();
	}
	
	else if(value=="pvendor"){
		getPvendor();
	}
	
	else{
		
	}
}

function getPtype(){
	 
	  $('#ptypewindow').jqxWindow('open');
		$('#ptypewindow').jqxWindow('focus');
		typeSearchContent('typeSearch.jsp', $('#ptypewindow'));

}
function typeSearchContent(url) {
//alert(url);
$.get(url).done(function (data) {
//alert(data);
$('#ptypewindow').jqxWindow('setContent', data);

}); 
}

function getPbrand(t){
	 
	  $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('focus');
		brandSearchContent('brandSearch.jsp?id='+t, $('#brandwindow'));

}
function brandSearchContent(url) {
//alert(url);
$.get(url).done(function (data) {
//alert(data);
$('#brandwindow').jqxWindow('setContent', data);

}); 
}
function getDept(){

	  $('#departmentwindow').jqxWindow('open');
		$('#departmentwindow').jqxWindow('focus');
		 deptSearchContent('deptSearch.jsp', $('#departmentwindow'));
}
function deptSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#departmentwindow').jqxWindow('setContent', data);

	}); 
	}
	
function productSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#productwindow').jqxWindow('setContent', data);

	}); 
	}
	
function getPcategory(){

	  $('#pcategorywindow').jqxWindow('open');
		$('#pcategorywindow').jqxWindow('focus');
		 categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
}
function categorySearchContent(url) {
//alert(url);
$.get(url).done(function (data) {
//alert(data);
$('#pcategorywindow').jqxWindow('setContent', data);

}); 
}

function getPsubcategory(){
	var catid=$('#hidcatid').val().trim();
	if(catid==""){
		$.messager.alert('Message','Please select the category First','warning');
	}else{
		 $('#psubcategorywindow').jqxWindow('open');
			$('#psubcategorywindow').jqxWindow('focus');
			 subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));
	}
	

}
function subcategorySearchContent(url) {
//alert(url);
  $.get(url).done(function (data) {
//alert(data);
$('#psubcategorywindow').jqxWindow('setContent', data);

}); 
}

function getPvendor(){
	 $('#pvendorwindow').jqxWindow('open');
		$('#pvendorwindow').jqxWindow('focus');
		 pvendorsearchContent('vendorsearch.jsp', $('#pvendorwindow'));

}
function pvendorsearchContent(url) {
//alert(url);
  $.get(url).done(function (data) {
//alert(data);
$('#pvendorwindow').jqxWindow('setContent', data);

}); 
}

function getVendor(){
	 $('#pvendorwindow').jqxWindow('open');
		$('#pvendorwindow').jqxWindow('focus');
		vendorSearchContent('vendorsearch.jsp', $('#pvendorwindow'));

}
function vendorSearchContent(url) {
	$("#stocklistgrid").jqxGrid('clear');
 $('#pvendorwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#pvendorwindow').jqxWindow('setContent', data);
	$('#pvendorwindow').jqxWindow('bringToFront');
}); 
}


</script>
