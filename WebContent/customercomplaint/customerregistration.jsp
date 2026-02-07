<jsp:include page="../includes.jsp"></jsp:include>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>   
<html lang="en">
<head>
	<title>Customer Complaint</title>        
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
<body>
	<!-- <div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i>Loading</button>
	</div> -->
	
	<div class="container-fluid m-t-30 m-b-10">
					<div class="row">   
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-5">
							<div class="form-group">
							    <label for="name">Name:</label>  
								<input type="text" class="form-control" style="height:30px" name="txtname" id="txtname">      
							</div> 
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
							<div class="form-group">
							    <label for="name">Mobile:</label>  
								<input type="text" class="form-control" style="height:30px" name="txtmob" id="txtmob">  
							</div> 
						</div>
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
							<div class="form-group">
							    <label for="room">Room No:</label>             
								<input type="text" class="form-control" style="height:30px" name="txtroomno" id="txtroomno">  
							</div> 
						</div>
					</div>
					<div class="row">   
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="form-group">
							    <label for="email">Complaint:</label>      
								<input type="text" class="form-control" style="height:30px" name="txtcomplaint" id="txtcomplaint">  
							</div> 
						</div>
					</div>
					<div class="row">   
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="form-group">
							    <label for="email">Description:</label>                   
								<textarea  class="form-control" name="txtdesc" id="txtdesc" rows="4"></textarea>     
							</div> 
						</div>
					</div>	
					<div class="button-container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="pull-right">
								<button type="button" class="btn btn-default btn-primary" id="btnsave">Save Changes</button>
								<button type="button" class="btn btn-default btn-primary" id="btnattach">Attach</button>
							</div>
						</div>
					</div>
				</div>
			</div>
     <div id="fileuploaddiv">
		<jsp:include page="fileUpload.jsp"></jsp:include>
	 </div>    
	<input type="file" name="file" id="file" class="form-control hidden">
	<input type="hidden" name="docno" id="docno">   
	<!-- <script src="../vendors/jquery/jquery-3.2.1.min.js"></script> -->   
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
	<script src="../vendors/signaturepad/signature_pad.umd.js"></script>
	<!--<script src="../vendors/signaturepad/app.js"></script>-->
	<script type="text/javascript">
		 $(document).ready(function () {   
		 $('#btnsave').click(function(){
  			var formname="CGC";     
  			var name=$("#txtname").val();
  			var mob=$("#txtmob").val();
  			var complaint=$("#txtcomplaint").val();
  			var desc=$("#txtdesc").val();  
  			var roomno=$("#txtroomno").val();
  			if(complaint=="") {     
	 				Swal.fire({
							icon: 'warning',
							title: 'Warning',
							text: 'Please enter Complaint'      
						});
						return false;  
			     }
  			
  			 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
  		        
  		     	if(r==false)
  		     	  {
  		     		return false; 
  		     	  }
  		     	else{
  		     		
  							        var signerrorstatus=0;
  		 		    				var x1 = new XMLHttpRequest();       
  		 		    				x1.open("POST","saveSignature.jsp?formname="+formname+"&desc="+desc+"&name="+name+"&complaint="+complaint+"&roomno="+roomno+"&mob="+mob,false); 
  		 		    				//x1.setRequestHeader('Content-Type', 'canvas/upload');
  		 		    				x1.onreadystatechange=function(){
  		 		    					if (x1.readyState == 4) {
  		 		    						var items = x1.responseText.trim();
  		 		    						var items1=items.split('####'); 
  		 		    						$("#docno").val(items1[1]);       
  		 		    						if(items1[0]=="0"){
  		 		    							$('#txtname').val('');
  		 		    							$('#txtmob').val('');
  		 		    							$('#txtroomno').val('');
  		 		    							$('#txtcomplaint').val('');
  		 		    							$('#txtdesc').val('');
  		 		    							
  		 		    							$("#docno").val(items1[1]); 
  		 		    						}
  		 		    						else{
  		 										signerrorstatus=1;
  		 		    						}
  		 		    					}
  		 		      				}
  		 							x1.send();    
  							if(signerrorstatus==0){
  								Swal.fire({    
  									icon: 'success',
  									title: 'success',
  									text: 'Successfully Updated'
  								});
  							}
  							else{
  								Swal.fire({
  									icon: 'error',
  									title: 'Error',
  									text: 'Not Updated'
  								});
  							}
  						}

  		});
  			 
 			 			
			});
		 $('#btnattach').click(function(){ 
			 var docno=$("#docno").val();
	 			if(docno=="") {     
	 				Swal.fire({
							icon: 'warning',
							title: 'Warning',
							text: 'Please save first'         
						});
						return false;  
			     }
				$('#file').trigger('click');   
				return false;
			});
		 }); 
	</script>
</body>
</html>