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
          
          <button type="button" class="btn btn-default" id="btninvtrigger">
            <i class="fa fa-plus-square " aria-hidden="true" data-toggle="tooltip" title="Create Purchase Invoice" data-placement="bottom"></i>
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
      <jsp:include page="subGrid.jsp"></jsp:include>
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
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Ref No</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="refno" style="height:22px" placeholder="Ref No" autocomplete="off"/>
            </div>
          </div>
          
          <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Location</div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
              <input type="text" id="txtlocation" style="height:22px" placeholder="Location" onkeydown="getloc(event);" readonly/>
              <input type="hidden" id="txtlocationid">
            </div>
          </div>
          
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

<div id="locationwindow">
	<div></div>
</div>

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	
    $('[data-toggle="tooltip"]').tooltip();
    
    $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
    $('#locationwindow').jqxWindow('close');  
		   
    $("#masterdate").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});
	$("#invdate").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});
	$("#deldate").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});

    $('#txtlocation').dblclick(function() {
    	$('#locationwindow').jqxWindow('open');
        locationsearchContent('searchlocation.jsp?brhid='+$('#cmbbranch').val());
    });

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
    $('.load-wrapp').show();
    $('#mainDiv').load('mainGrid.jsp?brhid=' + brhid +"&load=1");
    
    funLoadDetails(0, 0, 0, 0);
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
	var accdocno="";
	var cmbbilltype="1";
	var date = $("#masterdate").val();
	
	var multiAcc=false;
	
	for(var i=0;i<selectedrows.length;i++){
		if(accdocno!="" && accdocno!=$('#poGrid').jqxGrid('getcellvalue',selectedrows[i],'account')){
			multiAcc=true;
		}
		
		accdocno=$('#poGrid').jqxGrid('getcellvalue',selectedrows[i],'account');
		
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
            text: 'Please select documents of same Vendor'
        });
        return false;
		}
	
	funLoadDetails(docnos, accdocno, cmbbilltype, date);
});

function funLoadDetails(docnos, accdocno, cmbbilltype, date) {
    $('.load-wrapp').show();
    $('#subDiv').load('subGrid.jsp?docnos=' + docnos + '&accdocno=' + accdocno + '&cmbbilltype=' + cmbbilltype + '&date=' + date);
}

$('#btninvtrigger').click(function() {
	var selectedrows = $("#serviecGrid").jqxGrid('selectedrowindexes');

	if (selectedrows == "") {
        Swal.fire({
            type: 'error',
            title: 'Warning',
            text: 'Please select Products'
        });
        return false;
    }
    
    $('#modalpurchaseinv').modal('show');
});

$('#btncreateinv').click(function() {
	var date = $("#masterdate").val();
	var billtype = $("#cmbbilltype").val();
	var refno = $("#refno").val().trim();
	var locationid = $("#txtlocationid").val();
	var invno = $("#invno").val().trim();
	var invdate = $("#invdate").val();
	var deldate = $("#deldate").val();
	var delterms = $("#delterms").val().trim();
	var payterms = $("#payterms").val().trim();
	var desc = $("#desc").val().trim();
	
	var accdocno="";
	var brhid="";
	var rownos="";

	var prodlist = new Array();
	
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
	
	if(invno==""){
		 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Please enter Inv No.'
	        });
	 	$("#invno").focus();
	    return false;
	}
	
	var selectedrows = $("#serviecGrid").jqxGrid('selectedrowindexes');
	
	for(var i=0;i<selectedrows.length;i++){
		accdocno=$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'account');
		brhid=$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
		
		if(i==0){
			rownos+=$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'refrowno');
		}else{
			rownos+=","+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'refrowno');
		}
		
		prodlist.push($('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'psrno')+"::"+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'prodoc')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'unitdocno')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'qty')
				+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'unitprice')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'total')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'discount')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'nettotal')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'saveqty')
				+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'checktype')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'specid')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'discper')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'stockid')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'oldqty')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'foc')
				+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'orderdiscper')+" :: "+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'orderamount')+"::"+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'taxper')+"::"+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'taxperamt')+"::"+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'taxamount')+"::"+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'batch_no')
				+" :: "+$('#serviecGrid').jqxGrid('getcelltext', i, "exp_date")+"::"+$('#serviecGrid').jqxGrid('getcellvalue',selectedrows[i],'taxdocno')+" :: "+"0000"+" :: "); 
	
	}
	 
	Swal.fire({
	  title: 'Do you want to create Purchase Invoice ?',
	  showCancelButton: true,
	  confirmButtonText: 'Yes',
	}).then((result) => {
	  if (result.isConfirmed) {
	    createPurchaseInv(date, billtype, refno, locationid, invno, invdate, deldate, delterms, payterms, desc, accdocno, brhid, rownos, prodlist);
	  } 
	})
});

function createPurchaseInv(date, billtype, refno, locationid, invno, invdate, deldate, delterms, payterms, desc, accdocno, brhid, rownos, prodlist) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var msg = x.responseText.trim();
            $('.load-wrapp').hide();
            if (parseInt(msg)>0) {
            	
            	$('#modalpurchaseinv').modal('hide');
            	funLoad();
            	
            	$("#cmbbilltype").val(1).trigger('change');
            	$("#refno").val('');
            	$("#invno").val('');
            	$("#delterms").val('');
            	$("#payterms").val('');
            	$("#desc").val('');
            	
            	$('#masterdate').jqxDateTimeInput('setDate', new Date());
            	$('#invdate').jqxDateTimeInput('setDate', new Date());
            	$('#deldate').jqxDateTimeInput('setDate', new Date());
            	
            	Swal.fire({
                    type: 'success',
                    title: 'Message',
                    text: 'Successfully Created PIV No : '+msg
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
    x.open("GET", "createPurchaseInv.jsp?date=" + date + "&billtype=" + billtype + "&refno=" + refno + "&locationid=" + locationid 
    		+ "&invno=" + invno + "&invdate=" + invdate + "&deldate=" + deldate + "&delterms=" + delterms + "&payterms=" + payterms 
    		+ "&desc=" + desc + "&accdocno=" + accdocno + "&brhid=" + brhid + "&rownos=" + rownos + "&prodlist=" + prodlist, true);
    x.send();
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
              
        $('.load-wrapp').hide();
    });
}

$("#cmbbranch").change(function(){
	var brhid = $('#cmbbranch').val();
	if($.isNumeric(brhid)){
		getDefaultLocation(brhid);
	}else{
		document.getElementById("txtlocationid").value = "";
        document.getElementById("txtlocation").value = "";
	}
})

function getDefaultLocation(brhid) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            var item = items.split('::');

            document.getElementById("txtlocationid").value = item[0];
            document.getElementById("txtlocation").value = item[1];
        } 
    }
    x.open("GET", "locationset.jsp?brhid="+brhid, true);
    x.send();
}

function getloc(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#locationwindow').jqxWindow('open');
        locationsearchContent('searchlocation.jsp?brhid='+$('#cmbbranch').val());
    }
}

function locationsearchContent(url) {
    $.get(url).done(function(data) {
        $('#locationwindow').jqxWindow('setContent', data);
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
    if (value < styear || value > edyear) {
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

    if (value <= mclose) {
    	 Swal.fire({
	            type: 'error',
	            title: 'Warning',
	            text: 'Closing Done, Transaction Restricted.'
	        });
        return 0;
    }

    if (value <= validatedate) {
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
