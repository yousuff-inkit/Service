<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
  <script src="../js/sweetalert2.all.min.js"></script>
  <script type="text/javascript">
  	window.onbeforeunload = function() { return "Your work will be lost."; };
  </script>
  </head>
<body>
<form>
	<input type="hidden" name="c" id="c">
</form>
<script type="text/javascript">
	$(document).ready(function(){
		<%
			String c=request.getParameter("c")==null?"":request.getParameter("c");
		%>
		var c='<%=c%>';
		$('#c').val(c);
		alert(c);
		if($('#c').val()!=''){
			var c=$('#c').val();
			$.ajax({
	  			async:false,
			    url: 'getPaymentData.jsp',
			    data: {'c':c}, 
			    type: 'POST',
			    success : function(docs){
			    	docs=JSON.parse(docs);
			    	if(docs.responsecode=='00'){
			    		Swal.fire({
							title: 'Success',
						  	text: "Payment Successfull",
						  	icon: 'success',
						  	showCancelButton: false,
						  confirmButtonText: 'OK'
						}).then((result) => {
						  if (result.isConfirmed) {
							var docurl=document.URL;
							window.location.replace(docurl.split('webinvoice')[0]+'webinvoice/index.jsp?docid='+docs.orderid);    
						  }
						});
						
			    	}
			    	else{
			    		Swal.fire({
							type: 'warning',
						  	title: 'Warning',
						  	text: docs.responsemsg        
						});
			    	}
			    },
			    error : function (xhr, ajaxOptions, thrownError){  
			        console.log(xhr.status);          
			        console.log(thrownError);
			    } 
			});
		}
	});
</script>
</body>
</html>