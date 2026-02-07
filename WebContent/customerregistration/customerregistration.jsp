 
<jsp:include page="../includes.jsp"></jsp:include>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>   
<html lang="en">
<head>
	<title>Customer Guest Registration</title>        
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
	<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="css/util.css">
	<link rel="stylesheet" href="css/signature-pad.css">      
	<style type="text/css">
		@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
		@import url(https://fonts.googleapis.com/css?family=Teko:700);
		:root {
	  		/*--main-bg-color:#5867dd;
	  			rgba(88,103,221,1)
	  		*/
	  		--main-bg-color:#5867dd;
	  		--main-sec-color:#fff;
	  		--main-third-color:#000;
		}
		@font-face {
			font-family: Poppins-Regular;
		  	src: url('../vendors/fonts/poppins/Poppins-Regular.ttf'); 
		}
		
		@font-face {
		  	font-family: Poppins-Medium;
		  	src: url('../vendors/fonts/poppins/Poppins-Medium.ttf'); 
		}
		
		@font-face {
		  	font-family: Montserrat-Medium;
		  	src: url('../vendors/fonts/montserrat/Montserrat-Medium.ttf'); 
		}
		
		@font-face {
		  	font-family: Montserrat-SemiBold;
		  	src: url('../vendors/fonts/montserrat/Montserrat-SemiBold.ttf'); 
		}
		* {
			margin: 0px; 
			padding: 0px; 
			box-sizing: border-box;
		}
		html,body{
			width:100%;
			height:100%;
			background-color:#E9E9E9;
			font-family: Poppins-Regular, sans-serif;
		}
		.page-loader{
			width:100vw;
			height:100vh;
			background-color:rgba(255,255,255,0.5);
			position:fixed;
			z-index:9999999;
		}
		.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
			background-color: var(--main-bg-color);
	    	border-color: var(--main-bg-color);
			color:#fff;
			position:absolute;
			top:50%;
			left:50%;
			transform:translate(-50%,-50%);
		}
		.room-container,.key-container{
			background-color: #fff;
			box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
			padding: 20px;
			display: inline-block;
			cursor: pointer;
		}
		.room-container.active,.key-container.active{
			background-color:var(--main-bg-color);
		}
		.room-container.active .roomname,.key-container.active .keyname{
			color: #fff;
		}
		#filterlist li{
			cursor:pointer;
		}
		.room-outer-container{
			width: 100%;
			background-color: transparent;
			border:none;
			outline: none;
		}
		.room-outer-container .outer-wrapper,.outer-wrapper-keys{
			max-width: 100%;
			overflow-x: auto;
			scroll-behavior: smooth;
			white-space: nowrap;
			display: inline;
			float: left;
			background-color: transparent;
			border:none;
			outline: none;
		}
		
		
		@media (max-width: 767px) {
    		.custom-tabs.nav-pills > li {
			    float:none;
			    display:inline-block;
			}	
		}

	</style>
</head>
<body onload="getVisit();">
	<!-- <div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i>Loading</button>
	</div> -->
	
	<div class="container-fluid m-t-30 m-b-10">
					<div class="row">   
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
							<div class="form-group">
							    <label for="name">Name:</label>  
								<input type="text" class="form-control" style="height:30px" name="txtname" id="txtname">      
							</div> 
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
							<div class="form-group">
							    <label for="name">Mobile:</label>  
								<input type="text" class="form-control" style="height:30px" name="txtmob" id="txtmob">  
							</div> 
						</div>
					</div>
					<div class="row">   
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
							<div class="form-group">
							    <label for="name">Date:</label>  
								<div  name="date" id="date"></div>  
							</div> 
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
							<div class="form-group">
							    <label for="time">In Time:</label>  
								<div  name="time" id="time"></div>           
							</div> 
						</div>     
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
							<div class="form-group">
							    <label for="email">Email:</label>  
								<input type="text" class="form-control" style="height:30px" name="txtemail" id="txtemail">  
							</div> 
						</div>
					</div>	
					<div class="row"> 
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
							<div class="form-group">
							    <label for="visit">Purpose of Visit:</label>  
								<select class="form-control" name="txtvisit" id="txtvisit" ><option value="">--Select--</option></select>
		                                        <span class="help-block"></span>   
		                               
							</div> 
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
							<div class="form-group">
							    <label for="type">Type:</label>  
								<select class="form-control" style="height:30px" name="cmbtype" id="cmbtype">
									<option value="">--Select--</option>
									<option value="1">Visitor</option> 
									<option value="2">New Customer</option>            
								</select>
							</div> 
						</div>    
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
							<div class="form-group">
							    <label for="room">Room No:</label>             
								<input type="text" class="form-control" style="height:30px" name="txtroomno" id="txtroomno">  
							</div> 
						</div>
					</div>
			 <div class="signature-container">   	     		 
					<div class="row">      
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
					  		<div id="signature-pad2" class="signature-pad">
					    		<div class="signature-pad--body">
					      			<canvas style="width:100%;min-height:200px;" width="100%"></canvas>
					    		</div>
					    		<div class="signature-pad--footer">
					      			<div class="description text-center">Sign above</div>
					      			<div class="signature-pad--actions hidden">
					        			<div>
					          				<button type="button" class="button clear" data-action="clear">Clear</button>
					          				<button type="button" class="button" data-action="change-color">Change color</button>
					          				<button type="button" class="button" data-action="undo">Undo</button>
					        			</div>
					        			<div>
					          				<button type="button" class="button save" data-action="save-png">Save as PNG</button>
					          				<button type="button" class="button save" data-action="save-jpg">Save as JPG</button>
					          				<button type="button" class="button save" data-action="save-svg">Save as SVG</button>
					        			</div>
					      			</div>
					      			<div class="text-center">
					      				<button type="button" class="btn btn-default btn-primary" id="btnsavesignature">Save Signature</button>
					      			</div>   
					    		</div>
					  		</div>
						</div>
					</div>
				</div>
			</div>
	<input type="file" name="file" id="file" class="form-control hidden">
	<!-- <script src="../vendors/jquery/jquery-3.2.1.min.js"></script> -->   
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
	<script src="../vendors/signaturepad/signature_pad.umd.js"></script>
	<!--<script src="../vendors/signaturepad/app.js"></script>-->
	<script type="text/javascript">
		var wrapper2 = document.getElementById("signature-pad2"),
		canvas2 = wrapper2.querySelector("canvas"),
		signaturePad2;
		function resizeCanvas(canvas) {
			var ratio =  window.devicePixelRatio || 1;
			canvas.width = canvas.offsetWidth * ratio;
			canvas.height = canvas.offsetHeight * ratio;
			canvas.getContext("2d").scale(ratio, ratio);   
		}
	
		resizeCanvas(canvas2);
		signaturePad2 = new SignaturePad(canvas2);
		
		 $(document).ready(function () { 
			 $("#txtvisit").select2({   
	 			    placeholder: "Select Purpose Of Visit",                   
	 			    allowClear: true,
	 			    width: '50%'
	 			});
			   	$("#date").jqxDateTimeInput({  width: '115px', height: '15px', formatString:"dd.MM.yyyy"});
			   	$("#time").jqxDateTimeInput({  width: '50px', height: '20px', formatString : "HH:mm",showCalendarButton: false });
		 $("#time").val(new Date());
		 $('#btnsavesignature').click(function(){      
  			var testCanvas =null;
  			var formname="CGR"; 
  			var date=$("#date").jqxDateTimeInput('val');   
  			var time=$("#time").val();
  			var name=$("#txtname").val();
  			var mob=$("#txtmob").val();
  			var email=$("#txtemail").val();
  			var visit=$("#txtvisit").val();
  			var type=$("#cmbtype").val();
  			var roomno=$("#txtroomno").val();
 			if(signaturePad2.isEmpty()) {     
 				Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please enter signature'  
					});
					return false;
		     }else{
					var signerrorstatus=0;
 							var dataURL1=signaturePad2.toDataURL();
 		  					var postData1 = "canvasData="+dataURL1;
 		    				var x1 = new XMLHttpRequest();
 		    				x1.open("POST","saveSignature.jsp?formname="+formname+"&email="+email+"&name="+name+"&visit="+visit+"&type="+type+"&roomno="+roomno+"&date="+date+"&time="+time+"&mob="+mob+"&signindex=2",true); 
 		    				x1.setRequestHeader('Content-Type', 'canvas/upload');
 		    				x1.onreadystatechange=function(){
 		    					if (x1.readyState == 4) {
 		    						var items1 = x1.responseText.trim();
 		    						if(items1=="0"){
 		    						}
 		    						else{
 										signerrorstatus=1;
 		    						}
 		    					}
 		      				}
 							x1.send(postData1);
					if(signerrorstatus==0){
						Swal.fire({    
							icon: 'success',
							title: 'success',
							text: 'Signature uploaded'
						});
					}
					else{
						Swal.fire({
							icon: 'error',
							title: 'Error',
							text: 'Signature not uploaded'
						});
					}
				}
		      });
			});
		 function getVisit() {
	  			var x = new XMLHttpRequest();
	  			x.onreadystatechange = function() {
	  				if (x.readyState == 4 && x.status == 200) {
	  					var items = x.responseText;
	  					items = items.split('####');
	  					var yearItems = items[0].split(",");
	  					var yearIdItems = items[1].split(",");
	  					var optionsyear = '<option value="">--Select--</option>';
	  					for (var i = 0; i < yearItems.length; i++) {
	  						optionsyear += '<option value="' + yearIdItems[i] + '">'
	  								+ yearItems[i] + '</option>';
	  					}
	  					$("select#txtvisit").html(optionsyear);           
	  				} else {
	  				}
	  			}
	  			x.open("GET", "purposeofvisit.jsp", true);      
	  			x.send();
	  		} 
		 
	</script>
</body>
</html>