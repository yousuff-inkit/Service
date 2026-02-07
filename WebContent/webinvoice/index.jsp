<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Cuba admin is super flexible, powerful, clean &amp; modern responsive bootstrap 5 admin template with unlimited possibilities.">
    <meta name="keywords" content="admin template, Cuba admin template, dashboard template, flat admin template, responsive admin template, web app">
    <meta name="author" content="pixelstrap">
    <link rel="icon" href="../assets/images/favicon.png" type="image/x-icon">
    <link rel="shortcut icon" href="../assets/images/favicon.png" type="image/x-icon">
    <title>GatewayERP</title>
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css?family=Rubik:400,400i,500,500i,700,700i&amp;display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i,900&amp;display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../vendors/font-awesome-4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style type="text/css">
  *{
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }
  html,body{
    background-color: #E5E5EC;
    width: 100%;
    height: 100%;
  }
  .border{
    border: 1px solid #000;
  }
  .container{

  }
  .list-group .list-group-item .badge-primary{
    border-radius: 4px;
    width: 100%;
    text-align: left;
    background-color: rgba(115, 102, 255, 0.3);
  }
  .left,.right{
    width: 50%;
    height: 100%;
    float: left;
    display: inline-block;
  }
  .right{
    background-color: #fff;
  }
  /* Extra small devices (phones, 600px and down) */
@media only screen and (max-width: 600px) {
  .left,.right{
    display: block;
    width: 100%;
    height: auto;
  }
}

/* Small devices (portrait tablets and large phones, 600px and up) */
@media only screen and (min-width: 600px) {
  .left,.right{
    display: block;
    width: 100%;
    height: auto;
  }
}

/* Medium devices (landscape tablets, 768px and up) */
@media only screen and (min-width: 768px) {
  .left,.right{
    width: 50%;
    height: 100%;
    float: left;
    display: inline-block;
  }
}

/* Large devices (laptops/desktops, 992px and up) */
@media only screen and (min-width: 992px) {
  .left,.right{
    width: 50%;
    height: 100%;
    float: left;
    display: inline-block;
  }
}

/* Extra large devices (large laptops and desktops, 1200px and up) */
@media only screen and (min-width: 1200px) {}
</style>
<body>
<form id="frmWebInvoice" method="post" action="https://test.cbdonline.ae/Cybersource/Payment/InitiateCreditCardPayment">
  <div class="left">
    <div class="container-fluid" style="padding-right: 10%;padding-left: 10%;padding-top: 8%;">
      <div class="row">
        <div class="col-xs-12 text-center">
          <img src="assets/images/logo/gateway-logo.gif" style="width:60%;">
        </div>
      </div>
      
      <h2>Invoice Details</h2>  
      <ul class="list-group">
        <li class="list-group-item">
          <div class="row">
            <div class="col-xs-4">Client</div>
            <div class="col-xs-8">: <span class="clientname"></span></div>  
          </div>
        </li>
        <li class="list-group-item">
          <div class="row">
            <div class="col-xs-4">Property</div>
            <div class="col-xs-8">: <span class="propertyname"></span></div>  
          </div>
        </li>
        <li class="list-group-item">
          <div class="row">
            <div class="col-xs-4">Invoice Date</div>
            <div class="col-xs-8">: <span class="invdate"></span></div>  
          </div>
        </li>
        <li class="list-group-item">
          <div class="row">
            <div class="col-xs-4">Due Date</div>
            <div class="col-xs-8">: <span class="invdate"></span></div>  
          </div>
        </li>
      </ul>
    </div>
    

  </div>
  <div class="right">
    <div class="container-fluid" style="margin-top: 50px;">
      <div class="col-xs-12" style="background-color: #fff;">
        <div class="container-fluid">
            <img src="assets/images/user.jpg" class="img-responsive img-circle" style="margin-left: auto;margin-right: auto;" />
            <h3 class="text-center">Invoice <span class="maindate"></span></h3>
            <ul class="list-inline text-center">
              <li>Status : <span class="paidstatus"><i class="fa fa-exclamation-circle"></i> Not Paid</span></li>
              <li>Date : <span class="longdate"></span></li>
            </ul>
            <div class="panel panel-default" style="margin-bottom: 6px;">
              <div class="panel-heading"><strong>Invoice Summary</strong></div>
            </div>
            <ul class="list-group">
              <li class="list-group-item">
              	<div class="row">
              		<div class="col-xs-8"><span class="desc"></span></div>
              		<div class="col-xs-4">
              			<div class="badge badge-default badge-primary">AED <span class="pull-right nettotal">4,234.00</span></div></div>
              	</div>
              	
              	</li>
              <li class="list-group-item">
              	<div class="row">
              		<div class="col-xs-8">Sub Total</div>
              		<div class="col-xs-4">
              			<div class="badge badge-default badge-primary">AED <span class="pull-right nettotal">4,234.00</span></div></div>
              	</div>
				</li>              	
              <li class="list-group-item">
              	<div class="row">
              		<div class="col-xs-8">Tax (<span class="taxpercent"></span>%)</div>
              		<div class="col-xs-4">
              			<div class="badge badge-default badge-primary">AED <span class="pull-right tax">4,234.00</span></div></div>
              	</div>
              </li>	
              
              <li class="list-group-item">
              	<div class="row">
              		<div class="col-xs-8"><strong>Grand Total</strong></div>
              		<div class="col-xs-4">
              			<div class="badge badge-default badge-primary">AED <span class="pull-right nettaxtotal">4,234.00</span></div></div>
              	</div>
              
            </ul>
            <div class="text-center" >
              <button class="btn btn-default btn-primary btn-payment" type="submit">Proceed To Pay</button>
              <p class="text-grey text-muted text-small"><i class="fa fa-lock"></i> Payments and secured and encrypted</p>
              <p style="margin-top:70px;" class="text-muted text-grey text-uppercase"><small>Powered By </small></p>
              <img src="assets/images/logo/gateway-logo.gif" style="width: 30%;">
            </div>
        </div>
      </div>
    </div>
  </div>
  <input type="hidden" name="c" id="c">
  </form>
  <script type="text/javascript">
  	$(document).ready(function(){
  		//Getting Details
  		<%String docid=request.getParameter("docid")==null?"":request.getParameter("docid");%>
  			var docid='<%=docid%>';
  			
	  		//document.URL.split('docid=')[1];
	  		$.ajax({
	  			async:false,
			    url: 'getDetails.jsp',
			    data: {'docid':docid}, 
			    type: 'POST',
			    success : function(docs){
			    	docs=JSON.parse(docs);
			    	$('#c').val(docs.encrypted);
			    	console.log($('#c').val());
			    	$('.clientname').text(docs.clientname);
			    	$('.invdate').text(docs.invdate);
			    	$('.nettaxtotal').text(docs.nettaxtotal);
			    	$('.nettotal').text(docs.nettotal);
			    	$('.tax').text(docs.tax);
			    	$('.taxpercent').text(docs.taxpercent);
			    	$('.longdate').text(docs.longdate);
			    	$('.maindate').text(docs.maindate);
			    	$('.desc').text(docs.desc);
			    	if(docs.paidstatus=='1'){
			    		$('.paidstatus').html('<i class="fa fa-check-circle"></i> Paid');
			    		$('.btn-payment').attr('disabled',true).addClass('disabled');
			    	}
			    	else{
			    		$('.paidstatus').html('<i class="fa fa-exclamation-circle"></i> Not Paid');
			    	}
			    	var c=$('#c').val();
			    	//var win= window.open("https://test.cbdonline.ae/Cybersource/Payment/InitiateCreditCardPayment?c="+c,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				    //win.focus();
				    
			    },
			    error : function (xhr, ajaxOptions, thrownError){  
			        console.log(xhr.status);          
			        console.log(thrownError);
			    } 
			});
  		$('.btn-payment').click(function(){
  			 //$('#frmWebInvoice').submit();
  		});
  		
  	});
  </script>
</body>
</html>