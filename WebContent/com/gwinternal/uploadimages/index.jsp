<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upload Images</title>

<link rel="stylesheet" href="../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../vendors/animate/animate.css">
<link href="../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
	html {
	    font-family: sans-serif;
	    line-height: 1.15;
	    -webkit-text-size-adjust: 100%;
	    -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
	}
	body {
	    margin: 0;
	    font-family: "Poppins";
	    font-size: 1.3rem;
	    font-weight: 400;
	    line-height: 1.5;
	    color: #212529;
	    text-align: left;
	    background-color: #F7F7F7;
	    width:100%;
	    overflow:auto;
		height:100%;
		background-color: #f9f9fa;
	}
	.sidenav{
		background-color:#fff;
	}
	.panel-body{
		height:150px;
	}
	.panel.active .panel-footer{
		background-color:mediumpurple;
		color:#fff;
	}
	.col-xs-3 .panel{
		cursor:pointer;
	}
	.border{
		border:1px solid #000;
	}
	.container.container-outer{
		box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
		padding-bottom:20px;
		margin-top:20px;
		border-radius:8px;
	}
	
</style>
</head>
<body>
	<div class="container container-outer" >
		<div class="row content" >
    		<div class="col-sm-2 sidenav" style="padding-top:20px;">
      			<a href="" class="nav-brand">
      				<img alt="" src="../../../icons/gateway_logo.gif" class="img-responsive">
      			</a>
      			
      			<p style="margin-top:30px;"><strong>CATEGORIES (3)</strong></p>
      			<ul class="nav nav-pills nav-stacked">
        			<!-- <li class="active"><a href="#tabsmall">Small</a></li> -->
        			<li class="active"><a href="#tablogo" data-toggle="pill">Logo</a></li>
        			<li><a href="#tabheader" data-toggle="pill">Header</a></li>
        			<li><a href="#tabfooter" data-toggle="pill">Footer</a></li>
      			</ul>
      			<div class="panel panel-default">
      				<div class="panel-heading">
      					<p style="margin:0px;"><strong>Chosen Picture</strong></p>
      				</div>
      				<div class="panel-body">
      					<img src="../../../icons/gateway_logo.gif" class="img-responsive" id="img-viewer">		
      					<input type="file" name="file" id="file" class="form-control" style="display:none;">
      				</div>
      			</div>
    		</div>
    		<div class="col-sm-10">
				<div class="row" style="margin-top:20px;border-bottom: 1px solid #ddd;padding-bottom: 10px;">
					<form class="form-inline" style="padding-left:15px;">
						<div class="input-group">
		        			<input type="text" class="form-control" id="searchimg" placeholder="Search Images..." onkeypress="funFilterList();">
		        			<div class="input-group-btn">
		          				<button class="btn btn-default" type="button" style="padding-top:9px;padding-bottom:9px;">
		            				<span class="fa fa-search"></span>
		          				</button>
		        			</div>
		      			</div>
		      			<div class="dropdown dropdown-mark" style="display:inline-block;">
  								<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><span class="marktext"></span><i class="fa fa-filter"></i>
  									<span class="caret"></span>
  								</button>
  								<ul class="dropdown-menu">
    								<li><a href="#">Mark All</a></li>
    								<li><a href="#">Unmark All</a></li>
  								</ul>
							</div>
					</form>
				</div>    			
    			<div class="tab-content" style="max-height:500px;overflow-y:auto;">
    				<div class="tab-pane fade in active" id="tablogo">
    					<div class="container-fluid">
    						<div class="row" style="margin-top:20px;">
    							
    						</div>
    					</div>
    				</div>
    				<div class="tab-pane" id="tabheader">
    					<div class="container-fluid">
    						<div class="row" style="margin-top:20px;">
    							
    						</div>
    					</div>
    				</div>
    				<div class="tab-pane" id="tabfooter">
    					<div class="container-fluid">
    						<div class="row" style="margin-top:20px;">
    							
    						</div>
    					</div>
    				</div>
    			</div>
    			<div class="row" style="margin-top:15px;">
    				<div class="col-xs-12 text-right">
    					<button type="button" class="btn btn-default" id="btnchoosepic">Choose Picture</button>
    					<button type="button" class="btn btn-default" id="btnupload">Update</button>
    				</div>
    			</div>
    		</div>
  		</div>
	</div>
	
  	<script src="../../../vendors/jquery/jquery-3.2.1.min.js"></script>
	<script src="../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
	<script src="../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
	<script src="ajaxfileupload.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#btnchoosepic').click(function(){
				$('#file').trigger('click');
				return false;
			});
			$('.dropdown-mark ul.dropdown-menu li').click(function(){
				var text=$(this).find('a').text();
				if(text=="Mark All"){
					$('.tab-pane.active.in .container-fluid .row .col-xs-3 .panel').addClass('active');
				}
				else if(text=="Unmark All"){
					$('.tab-pane.active.in .container-fluid .row .col-xs-3 .panel').removeClass('active');
				}
				$(this).parent().closest('.dropdown-mark').find('button').find('.marktext').text(text+' ');
				$(this).parent().closest('.dropdown-mark').find('button').dropdown('toggle');
				return false;
			});
			getFiles();
			document.getElementById('file').onchange = function (evt) {
    			var tgt = evt.target || window.event.srcElement,
        		files = tgt.files;

    			// FileReader support
    			if (FileReader && files && files.length) {
        			var fr = new FileReader();
        			fr.onload = function () {
            			document.getElementById("img-viewer").src = fr.result;
        			}
        			fr.readAsDataURL(files[0]);
    			}
			}
		
		});
		
		function funFilterList(){
			var filtertext=document.getElementById("searchimg").value;
			filtertext = filtertext.toUpperCase();
			$('.tab-pane.active.in .container-fluid .row .col-xs-3').each(function(){
				var text=$(this).find('.panel .panel-footer').text();
				console.log($(this).parent().html());
				if (text.toUpperCase().indexOf(filtertext) > -1) {
      				$(this).show();
    			} else {
      				$(this).hide();
    			}
			});
		}
		function getFiles(){
			$.get('getFiles.jsp',function(data){
				data=JSON.parse(data);
				var htmldata='';
				
				$.each(data.dbicondata,function(index,value){
					$.each(data.filedata,function(mindex,mvalue){
						var filename=mvalue.filename.substring(0, mvalue.filename.length - 4);
						if(value.name.toLowerCase()==filename.toLowerCase()){
							htmldata+='<div class="col-xs-3">';
							htmldata+='<div class="panel panel-default">';
							htmldata+='<div class="panel-body">';
							htmldata+='<img src="../../../icons/'+mvalue.filename+ '?' + (new Date()).getTime()+'" class="img-responsive img-thumbnail" style="max-height:100%;">';
							htmldata+='</div>';
							htmldata+='<div class="panel-footer">'+mvalue.filename+'</div>';
							htmldata+='</div>';
							htmldata+='</div>';
							
							if(value.type=="1"){
								$('#tablogo .container-fluid .row').append($.parseHTML(htmldata));
							}
							else if(value.type=="2"){
								$('#tabheader .container-fluid .row').append($.parseHTML(htmldata));
							}
							else if(value.type=="3"){
								$('#tabfooter .container-fluid .row').append($.parseHTML(htmldata));
							}
							htmldata='';
						}
					});
				});
				$('.col-xs-3 .panel').on('click',function(){
					$(this).toggleClass('active');
				});
			});
		}
		
		$('#btnupload').click(function(){
			if($('.tab-pane.active.in .container-fluid .row .col-xs-3 .panel.active').length==0){
				Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select an image to replace'
				});
				return false;	
			}
			if($('#file').val()==''){
				Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please choose an image to upload'
				});
				return false;
			}
			var errorstatus=0;
			$('.tab-pane.active.in .container-fluid .row .col-xs-3 .panel.active').each(function(){
				var destfilename=$(this).find('.panel-footer').text();
				//$('#destfilename').val();
				$.ajaxFileUpload({
	         		url:'GWAttachAction.action?destfilename='+destfilename,
	       			secureuri:false,//false  
	       			fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	       			dataType: 'json',// json  
	       			success: function (data, status){  
	       				if(status=='success'){
	       					//getFiles();	
	          			}
	          			else if(typeof(data.error) != 'undefined'){
	          				//alert('Not Updated');  
	          				errorstatus=1;
	          			}  
	      			},  
	      			error: function (data, status, e){
	      				//alert('Not Updated');
	      				errorstatus==1;
	      			}
	  			});	
			});
			if(errorstatus==0){
				Swal.fire({
					icon:'success',
					type: 'success',
					title: 'Success',
					text: 'Successfully Uploaded'
				});
				getFiles();	
			}
			else{
				Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Not Uploaded'
				});
				return false;
			}
		});
	</script>
</body>
</html>