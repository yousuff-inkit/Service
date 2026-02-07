<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Purchase Order Follow-up</title>
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
          </div>
          
          <div class="form-group col-auto">
            <label class="form-group">Type:</label>
            <div class="form-group">
              <select id="cmbtype" name="cmbtype" style="width:100%">
              <option value="SOR">SOR</option>
              <option value="DEL">DEL</option>
              </select>
            </div>
          </div>
        </div>
        <div class="primarypanel custompanel">
          <button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom">
            <i class="fa fa-refresh" aria-hidden="true"></i>
          </button>
        
        </div>
        <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btncalculate">
            <i class="fa fa-calculator" aria-hidden="true" data-toggle="tooltip" title="Calculate" data-placement="bottom"></i>
          </button>
          
          <button type="button" class="btn btn-default" id="btndeltrigger">
            <i class="fa fa-th-list" aria-hidden="true" data-toggle="tooltip" title="Create Delivery Note" data-placement="bottom"></i>
          </button>
        
          <button type="button" class="btn btn-default" id="btninvtrigger" disabled="disabled">
            <i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Create Credit Invoice" data-placement="bottom"></i>
          </button>
        </div>
       
      </form>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div id="mainDiv">
      <jsp:include page="mainGrid.jsp"></jsp:include>
    </div>
  </div>
</div>

<div class="row" style="margin-top:10px">
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div id="subDiv">
      <jsp:include page="invoiceGrid.jsp"></jsp:include>
    </div>
  </div>
</div>

<div id="modaldel" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:center">Delivery Note Creation</h4>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Date</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <div id="masterdatedel"></div>
          	</div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Ref No</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="refnodel" style="height:22px" placeholder="Ref No" autocomplete="off"/>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Location</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="txtlocationdel" style="height:22px" placeholder="Location" onkeydown="getloc(event,'DEL');" readonly/>
              <input type="hidden" id="hidlocationiddel">
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Salesman</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="txtsalesmandel" style="height:22px" onkeydown="getSalesman(event,'DEL');" placeholder="Press F3 to Search">
			  <input type="hidden" id="hidsalesmaniddel">
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <textarea class="textarea-simple-1" style="width:100%;height:60px;" placeholder="Description" id="descdel"></textarea>
            </div>
          </div>
          
        </div>
        <div class="clear"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="btncreatedel">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
      </div>
    </div>
  </div>
</div>

<div id="modalinv" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:center">Credit Invoice Creation</h4>
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
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Ref No</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="refno" style="height:22px" placeholder="Ref No" autocomplete="off"/>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Location</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="txtlocation" style="height:22px" placeholder="Location" onkeydown="getloc(event,'INV');" readonly/>
              <input type="hidden" id="hidlocationid">
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Salesman</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="txtsalesman" style="height:22px" onkeydown="getSalesman(event,'INV');" placeholder="Press F3 to Search">
			  <input type="hidden" id="hidsalesmanid">
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Payment Due on</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <div id="payduedate" style="border: 1px solid black" style="width:69%;"></div>
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

<div id="locationwindow">
	<div></div>
</div>

<div id="salwindow">
	<div></div>
</div>

<input type="hidden" id="pmgt"/>
<input type="hidden" id="cmbvatype"/>

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<script type="text/javascript">

let loaded=false;

$(document).ready(function() {
	
    $('[data-toggle="tooltip"]').tooltip();
    
    $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
    $('#locationwindow').jqxWindow('close');  
		  
    $('#salwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#salwindow').jqxWindow('close');
	
    $("#masterdatedel").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});
    $("#masterdate").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});
	$("#payduedate").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});

    $('#txtlocationdel').dblclick(function() {
    	$('#locationwindow').jqxWindow('open');
    	innerWindowSearchContent('searchlocation.jsp?type=DEL&brhid='+$('#cmbbranch').val(),'locationwindow');
    });

    $('#txtsalesmandel').dblclick(function(){
		$('#salwindow').jqxWindow('open');
		innerWindowSearchContent('salesmanSearchGrid.jsp?type=DEL&id=1','salwindow');
   	});
    
	$('#txtlocation').dblclick(function() {
    	$('#locationwindow').jqxWindow('open');
    	innerWindowSearchContent('searchlocation.jsp?type=INV&brhid='+$('#cmbbranch').val(),'locationwindow');
    });

    $('#txtsalesman').dblclick(function(){
		$('#salwindow').jqxWindow('open');
		innerWindowSearchContent('salesmanSearchGrid.jsp?type=INV&id=1','salwindow');
   	});
    
    $('#cmbtype').select2({});
});

$('#btnsubmit').click(function() {
	var brhid = $('#cmbbranch').val();
	if(!$.isNumeric(brhid)){
		 Swal.fire({
             type: 'error',
             title: 'Warning',
             text: 'Please select a branch'
         });
         return false;
	}
	funLoad();
});

function funLoad() {
    var brhid = $('#cmbbranch').val();
    var type = $('#cmbtype').val();
    $('.load-wrapp').show();
    $('#mainDiv').load('mainGrid.jsp?brhid=' + brhid + '&type=' + type + '&load=1');
    
    loaded=true;
    
    funLoadDetails(0, 0, 0, 0, 0, 0, 0, 0);
}

$('#btncalculate').click(function() {
	var selectedrows = $("#poGrid").jqxGrid('selectedrowindexes');
	
	if(selectedrows==""){
		Swal.fire({
                type: 'error',
                title: 'Warning',
                text: 'Please select documents'
        });
		return false;
	}
	
	var docnos="";
	var clientcaid="";
	var cldocno="";
	var cmbbilltype="1";
	var date = $("#masterdate").val();
	
	var brhid = $('#cmbbranch').val();
	var cmbtype = $('#cmbtype').val();
	var locationid = $("#hidlocationid").val();
	
	var multiAcc=false;
	
	for(var i=0;i<selectedrows.length;i++){
		if(cldocno!="" && cldocno!=$('#poGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno')){
			multiAcc=true;
		}
		
		cldocno=$('#poGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
		clientcaid=$('#poGrid').jqxGrid('getcellvalue',selectedrows[i],'clientcaid');
		
		if(i==0){
			docnos+=$('#poGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
		}else{
			docnos+=","+$('#poGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
		}
	}
	
	if(multiAcc){
		Swal.fire({
            type: 'error',
            title: 'Warning',
            text: 'Please select documents of same Customer'
        });
        return false;
	}
	
	funLoadDetails(brhid, docnos, cmbtype, date, clientcaid, cmbbilltype, cldocno, locationid);
});

function funLoadDetails(brhid, docnos, cmbtype, date, clientcaid, cmbbilltype, cldocno, locationid) {
    $('.load-wrapp').show();

    if(cmbtype=="SOR"){
	    $('#subDiv').load('deliveryNoteGrid.jsp?brhid=' + brhid + '&docnos=' + docnos + '&locationid=' + locationid + '&date=' + date);
	}else{
	    $('#subDiv').load('invoiceGrid.jsp?brhid=' + brhid + '&docnos=' + docnos + '&cmbtype=' + cmbtype + '&date=' + date + '&clientcaid=' + clientcaid + '&cmbbilltype=' + cmbbilltype + '&cldocno=' + cldocno);
	}
}

$('#btndeltrigger').click(function() {
	var selectedrows = $("#jqxDeliveryNote").jqxGrid('selectedrowindexes');

	if (selectedrows == "") {
        Swal.fire({
            type: 'error',
            title: 'Warning',
            text: 'Please select Products'
        });
        return false;
    }
    
    $('#modaldel').modal('show');
});


$('#btncreatedel').click(function() {
	var locationid = $("#hidlocationiddel").val();

	var maindate = $('#masterdatedel').jqxDateTimeInput('getDate');
	var validdate=funDateInPeriodLocal(maindate);
	if(validdate==0){
	   return false; 
	}
	
	if(locationid==""){
		 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Please Select a Location'
	        });
	 	$("#txtlocationdel").focus();
	    return false;
	}
	
	chkstock('DEL','jqxDeliveryNote');
});

function confirmDel() {
	var date = $("#masterdatedel").val();
	var vatype = $("#cmbvatype").val();
	var refno = $("#refnodel").val().trim();
	var locationid = $("#hidlocationiddel").val();
	var salesmanid = $("#hidsalesmaniddel").val();
	var desc = $("#descdel").val().trim();
	var brhid = $('#cmbbranch').val();
	
	var cldocno="";
	var rownos="";

	var prodlist = new Array();
	
	var selectedrows = $("#jqxDeliveryNote").jqxGrid('selectedrowindexes');
	
	for(var i=0;i<selectedrows.length;i++){
		cldocno=$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
		
		if(i==0){
			rownos+=$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'refrowno');
		}else{
			rownos+=","+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'refrowno');
		}
		
		prodlist.push($('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'prodoc')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'unitdocno')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'totwtkg')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'kgprice')+"::"+ 
				  $('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'unitprice')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'total')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'discper')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'dis')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'netotal')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'specid')+"::"+
				  $('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'outqty')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'stkid')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'oldqty')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'foc')+"::"+$('#jqxDeliveryNote').jqxGrid('getcellvalue',selectedrows[i],'ordout_qty')); 
	}
	 
	Swal.fire({
	  title: 'Do you want to create Delivery Note ?',
	  showCancelButton: true,
	  confirmButtonText: 'Yes',
	}).then((result) => {
	  if (result.isConfirmed) {
		  $('.load-wrapp').show();
		  createDel(date, vatype, refno, locationid, salesmanid, desc, cldocno, brhid, rownos, prodlist);
	  } 
	})
}

function createDel(date, vatype, refno, locationid, salesmanid, desc, cldocno, brhid, rownos, prodlist) {
	var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var msg = x.responseText.trim();
            $('.load-wrapp').hide();
            if (parseInt(msg)>0) {
            	
            	$('#modaldel').modal('hide');
            	funLoad();
            	
            	$("#refnodel").val('');
            	$("#hidsalesmaniddel").val('');
            	$("#txtsalesmandel").val('');
            	$("#descdel").val('');
            	
            	$('#masterdatedel').jqxDateTimeInput('setDate', new Date());
            	
            	Swal.fire({
                    type: 'success',
                    title: 'Message',
                    text: 'Successfully Created DEL No : '+msg
                });

            } else {
                Swal.fire({
                    type: 'error',
                    title: 'Message',
                    text: 'Not Created'
                });
            }
        }
    }
    
    x.open("GET", "createDel.jsp?date=" + date + "&vatype=" + vatype + "&refno=" + refno + "&locationid=" + locationid 
    		+ "&salesmanid=" + salesmanid + "&desc=" + desc + "&cldocno=" + cldocno + "&brhid=" + brhid + "&rownos=" + rownos + "&prodlist=" + prodlist, true);
    x.send();
}


$('#btninvtrigger').click(function() {
	var selectedrows = $("#jqxInvoiceGrid").jqxGrid('selectedrowindexes');

	if (selectedrows == "") {
        Swal.fire({
            type: 'error',
            title: 'Warning',
            text: 'Please select Products'
        });
        return false;
    }
    
    $('#modalinv').modal('show');
});

$('#btncreateinv').click(function() {
	var locationid = $("#hidlocationid").val();

	var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	var validdate=funDateInPeriodLocal(maindate);
	if(validdate==0){
	   return false; 
	}
	
	if(locationid==""){
		 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Please Select a Location'
	        });
	 	$("#txtlocation").focus();
	    return false;
	}
	
	chkstock('INV','jqxInvoiceGrid');
});

function confirmInv() {
	var date = $("#masterdate").val();
	var billtype = $("#cmbbilltype").val();
	var vatype = $("#cmbvatype").val();
	var refno = $("#refno").val().trim();
	var locationid = $("#hidlocationid").val();
	var salesmanid = $("#hidsalesmanid").val();
	var payduedate = $("#payduedate").val();
	var delterms = $("#delterms").val().trim();
	var payterms = $("#payterms").val().trim();
	var desc = $("#desc").val().trim();
	var brhid = $('#cmbbranch').val();
	
	var cldocno="";
	var rownos="";

	var prodlist = new Array();
	
	var selectedrows = $("#jqxInvoiceGrid").jqxGrid('selectedrowindexes');
	
	for(var i=0;i<selectedrows.length;i++){
		cldocno=$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
		
		if(i==0){
			rownos+=$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'refrowno');
		}else{
			rownos+=","+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'refrowno');
		}
		
		prodlist.push($('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'prodoc')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'unitdocno')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'qty')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'totwtkg')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'kgprice')+"::"+
				 $('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'unitprice')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'total')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'discper')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dis')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'netotal')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'specid')+"::"+
				 $('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'outqty')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'stkid')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'oldqty')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'foc')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'locid')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'taxper')+"::"
				 +$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'taxamount')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'allowdiscount')+"::"+000+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'collectqty')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'taxdocno')+"::"+$('#jqxInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'taxperamt')+"::"+"0000"+"::"); 
	}
	 
	Swal.fire({
	  title: 'Do you want to create Credit Invoice ?',
	  showCancelButton: true,
	  confirmButtonText: 'Yes',
	}).then((result) => {
	  if (result.isConfirmed) {
		  $('.load-wrapp').show();
		  createInv(date, billtype, vatype, refno, locationid, salesmanid, payduedate, delterms, payterms, desc, cldocno, brhid, rownos, prodlist);
	  } 
	})
}

function createInv(date, billtype, vatype, refno, locationid, salesmanid, payduedate, delterms, payterms, desc, cldocno, brhid, rownos, prodlist) {
	var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var msg = x.responseText.trim();
            $('.load-wrapp').hide();
            if (parseInt(msg)>0) {
            	
            	$('#modalinv').modal('hide');
            	funLoad();
            	
            	$("#cmbbilltype").val(1).trigger('change');
            	$("#refno").val('');
            	$("#hidsalesmanid").val('');
            	$("#txtsalesman").val('');
            	$("#delterms").val('');
            	$("#payterms").val('');
            	$("#desc").val('');
            	
            	$('#masterdate').jqxDateTimeInput('setDate', new Date());
            	$('#payduedate').jqxDateTimeInput('setDate', new Date());
            	
            	Swal.fire({
                    type: 'success',
                    title: 'Message',
                    text: 'Successfully Created INV No : '+msg
                });

            } else {
                Swal.fire({
                    type: 'error',
                    title: 'Message',
                    text: 'Not Created'
                });
            }
        }
    }
    
    x.open("GET", "createInv.jsp?date=" + date + "&billtype=" + billtype + "&vatype=" + vatype + "&refno=" + refno + "&locationid=" + locationid 
    		+ "&salesmanid=" + salesmanid + "&payduedate=" + payduedate + "&delterms=" + delterms + "&payterms=" + payterms 
    		+ "&desc=" + desc + "&cldocno=" + cldocno + "&brhid=" + brhid + "&rownos=" + rownos + "&prodlist=" + prodlist, true);
    x.send();
}

function chkstock(type, gridId) {
	$('.load-wrapp').show();
    var rows = $("#"+gridId).jqxGrid('getrows');
    var list = new Array();
	var selectedrows = $("#"+gridId).jqxGrid('selectedrowindexes');
	
	for(var i=0;i<selectedrows.length;i++){
		if (parseInt($("#"+gridId).jqxGrid('getcellvalue',selectedrows[i],'prodoc')) > 0) {
			list.push($("#"+gridId).jqxGrid('getcellvalue',selectedrows[i],'prodoc') + "::" + $("#"+gridId).jqxGrid('getcellvalue',selectedrows[i],'specid') + "::" + $("#"+gridId).jqxGrid('getcellvalue',selectedrows[i],'qty') + "::" + $("#"+gridId).jqxGrid('getcellvalue',selectedrows[i],'unitdocno') + "::" + $("#"+gridId).jqxGrid('getcellvalue',selectedrows[i],'oldqty') + "::" + $("#"+gridId).jqxGrid('getcellvalue',selectedrows[i],'productid'));
		}
	}
    ajaxcallchk(type, list);
}

function ajaxcallchk(type, list) {
    var branch = document.getElementById("cmbbranch").value;
    var location = document.getElementById("hidlocationid").value;
    var date = document.getElementById("masterdate").value;
    
    if(type=="DEL"){
    	 branch = document.getElementById("cmbbranch").value;
    	 location = document.getElementById("hidlocationiddel").value;
    	 date = document.getElementById("masterdatedel").value;
    }

    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split("####");
            
            $('.load-wrapp').hide();
            
            if (parseInt(items[0]) == 1) {
                Swal.fire({
    	            type: 'error',
    	            title: 'Warning',
    	            text: 'Product ID - ' + items[1] + ' - Does Not Have Sufficient Stock !!'
    	        });
                return 0;
          
            } else if (parseInt(items[0]) == 2) {
                Swal.fire({
    	            type: 'error',
    	            title: 'Warning',
    	            text: ' error!!'
    	        });
                return 0;

            } else {
            	  if(type=="DEL"){
            		confirmDel();
            	  }else{
            		confirmInv();
            	  }
            }
        }
    }
    x.open("GET", "validateqty.jsp?list=" + list + "&branch=" + branch + "&location=" + location + "&date=" + date, true);
    x.send();
}

$("#cmbtype").change(function(){
	var cmbtype = $('#cmbtype').val();
	if(cmbtype=="SOR"){
		$('#btndeltrigger').attr("disabled",false);
		$('#btninvtrigger').attr("disabled",true);
	}else{
		$('#btndeltrigger').attr("disabled",true);
		$('#btninvtrigger').attr("disabled",false);
	}
	
	if(loaded){
		funLoad();
	}
})

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
              
        $('.load-wrapp').hide();
    });
}

$("#cmbbranch").change(function(){
	var brhid = $('#cmbbranch').val();
	if($.isNumeric(brhid)){
		getDefaultLocation(brhid);
	}else{
		document.getElementById("hidlocationiddel").value = "";
        document.getElementById("txtlocationdel").value = "";
        
        document.getElementById("hidlocationid").value = "";
        document.getElementById("txtlocation").value = "";
	}
	if(loaded){
		funLoad();
	}
})

function getDefaultLocation(brhid) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            var item = items.split('::');

            document.getElementById("hidlocationiddel").value = item[0];
            document.getElementById("txtlocationdel").value = item[1];
            
            document.getElementById("hidlocationid").value = item[0];
            document.getElementById("txtlocation").value = item[1];
        } 
    }
    x.open("GET", "locationset.jsp?brhid="+brhid, true);
    x.send();
}

function getloc(event,type) {
    var x = event.keyCode;
    if (x == 114) {
        $('#locationwindow').jqxWindow('open');
        innerWindowSearchContent('searchlocation.jsp?type='+type+'&brhid='+$('#cmbbranch').val(),'locationwindow');
    }
}

function getSalesman(event,type){
	var x= event.keyCode;
	if(x==114){
		$('#salwindow').jqxWindow('open');
		innerWindowSearchContent('salesmanSearchGrid.jsp?type='+type+'&id=1','salwindow');
	}
}

function innerWindowSearchContent(url,windowid){
	$.get(url).done(function (data) {
		$('#'+windowid).jqxWindow('setContent', data);
	});
}

function funDateInPeriodLocal(value) {
    var periodStartDate = window.parent.txtaccountperiodfrom.value;
    periodStartDate = periodStartDate.split("-");
    var newDateStartYear = periodStartDate[1] + "," + periodStartDate[0] + "," + periodStartDate[2];
    var styear = new Date(newDateStartYear);

    var periodEndDate = window.parent.txtaccountperiodto.value;
    periodEndDate = periodEndDate.split("-");
    var newDateEndYear = periodEndDate[1] + "," + periodEndDate[0] + "," + periodEndDate[2];
    var edyear = new Date(newDateEndYear);

    var mCloseDate = window.parent.monthclosed.value;

    periodMonthCloseDate = mCloseDate.split("-");
    var newDateMonthClose = periodMonthCloseDate[0] + "," + periodMonthCloseDate[1] + "," + periodMonthCloseDate[2];
    var mclose = new Date(newDateMonthClose);

    var taxDate = window.parent.taxdateval.value;

    var taxDates = taxDate.split("-");

    var newtaxDates = taxDates[0] + "," + taxDates[1] + "," + taxDates[2];

    var validatedate = new Date(newtaxDates);

    validatedate.setHours(0, 0, 0, 0);
    mclose.setHours(0, 0, 0, 0);
    edyear.setHours(0, 0, 0, 0);
    styear.setHours(0, 0, 0, 0);

    var currentDate = new Date(new Date());
    
    if ((value < styear || value > edyear) && $("#cmbtype").val()=="DEL") {
    	 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Transaction prior or after Account Period is not valid.'
	        });
        return 0;
    }
    
    if (value > currentDate) {
    	 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Future Date, Transaction Restricted.'
	        });
        return 0;
    }

    if ((value <= mclose) && $("#cmbtype").val()=="DEL") {
    	 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Closing Done, Transaction Restricted.'
	        });
        return 0;
    }

    if ((value <= validatedate) && $("#cmbtype").val()=="DEL") {
    	 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Tax Closing Done, Transaction Restricted.'
	        });
        return 0;
    }

    return 1;
}

</script>

</body>
</html>
