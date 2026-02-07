<%@ taglib prefix="s" uri="/struts-tags"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" href="../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../vendors/animate/animate.css">
<link href="../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../vendors/select2/css/select2.min.css" rel="stylesheet" />
<link href="css/util.css" rel="stylesheet" />
<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	:root {
	    --theme-deafult: #7366ff;
	    --theme-secondary: #f73164;
	    --bs-blue: #0d6efd;
	    --bs-indigo: #6610f2;
	    --bs-purple: #6f42c1;
	    --bs-pink: #d63384;
	    --bs-red: #dc3545;
	    --bs-orange: #fd7e14;
	    --bs-yellow: #ffc107;
	    --bs-green: #198754;
	    --bs-teal: #20c997;
	    --bs-cyan: #0dcaf0;
	    --bs-white: #fff;
	    --bs-gray: #6c757d;
	    --bs-gray-dark: #343a40;
	    --bs-primary: #0d6efd;
	    --bs-secondary: #6c757d;
	    --bs-success: #198754;
	    --bs-info: #0dcaf0;
	    --bs-warning: #ffc107;
	    --bs-danger: #dc3545;
	    --bs-light: #f8f9fa;
	    --bs-dark: #212529;
	    --bs-font-sans-serif: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	    --bs-font-monospace: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
	    --bs-gradient: linear-gradient(180deg, rgba(255,255,255,0.15), rgba(255,255,255,0));
	}
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../../vendors/fonts/Poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../../vendors/fonts/Poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#F7F7F7;
		font-family: Poppins-Regular, sans-serif;
	}
	html {
	    font-family: sans-serif;
	    line-height: 1.15;
	    -webkit-text-size-adjust: 100%;
	    -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
	}
	body {
	    margin: 0;
	    font-family: Poppins-Regular, sans-serif;
	    font-size: 1.3rem;
	    font-weight: 400;
	    line-height: 1.5;
	    color: #212529;
	    text-align: left;
	    background-color: #F7F7F7;
	    width:100%;
	    overflow:auto;
		height:100%;
		background-color: #F7F7F7;
	}
	.sidebar{
		position:absolute;
		z-index:999999;
		width:100px;
		min-height:100%;
		background-color:#fff;
	}
	
	.admin-cover .panel-body,.chart-panel .panel-body{
		border:none;
	}
		
	.page-loader{
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		z-index:9999999;
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.9);
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: #5867dd;
    	border-color: #5867dd;
		color:#fff;
		margin:0 auto;
		position:absolute;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
	}
	.btn-chartfleetsales.active{
		background-color:#5867dd;
		border-color:#5867dd;
		color:#fff;
	}
	.knob:focus,.knob{
        border: 0;
        outline:0;
    }
    .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
        border-radius: 8px;
        margin-bottom: 15px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: center;
        vertical-align: middle;
    }
    .card-container .card-body .card-detail-container{
        width: 68%;
        vertical-align: middle;
    }
    .card-container .card-body>div{
        display: inline-block;
    }
    .card-container .card-body .card-detail-container>div{
        display: inline-block;
        width:24%;
        text-align:center;
    }
    .card-container .card-body .card-detail-container>div:not(:last-child){
    	border-right: 1px solid #efefef;
    }
        
    .chart-gauge {
        width: 200px;
        margin: 10px auto;
    }

    .chart-color1 {
        fill: #43da14;
    }

    .chart-color2 {
        fill: #e0ff00;
    }

    .chart-color3 {
        fill: #e97209;
    }

    .chart-color4 {
        fill: #ff001a;
    }

    .needle,
    .needle-center {
        fill: #464A4F;
    }
    .custom-badge1.badge{
   		margin-left: 10px;
    	border-radius: 3px;
    	background-color: darkblue;
    }
    table tr.active td{
    	background-color:blue;
    	color:#000;
    }
    .btn-table-dropdown,.btn-table-dropdown:focus,.btn-table-dropdown:active,.btn-table-dropdown:hover{
    	margin: 0;
	    padding: 0;
	    outline: 0;
	    border: 0;
	    background-color: transparent;
	    box-shadow: none;
    }
    .panel-heading .dropdown-menu li a[data-target="#"]{
    	cursor:pointer;
    }
    .panel-loader{
   		position: absolute;
    	width: 100%;
    	height: 100%;
    	z-index: 99;
    	background-color: rgba(0,0,0,0.5);
    	margin: 0;
    	padding: 0;
    	overflow: hidden;
    }
    .panel-loader i{
    	color:#fff;
    }
    .no-padding {
   		padding: 0;
   		margin: 0 !important;
	}
	.p-15{
		padding:15px;
	}
	.card-item{
		background-color: #fff;
	    padding-left: 10px;
	    padding-right: 10px;
	    border-radius: 4px;
	    padding-top: 1px;
	    padding-bottom: 4px;
	    margin-bottom:8px;
	    box-shadow:0 5px 10px rgba(154,160,185,.05), 0 15px 40px rgba(166,173,201,.2);
		background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		box-shadow: 0 2px 4px 0 rgb(62 57 107 / 13%);
		position:relative;
		transition:all 0.3s ease;
		cursor:pointer;
		
	}
	.card-item:hover,.card-item.active{
		transform:scale(1.1);
	}
	.card-item.active{
		border-bottom: 5px solid #08ad13;
	}
	.card-item:hover svg,.card-item.active svg {
		transform:rotate(12deg);
	}
	.card-item h2{
		margin-top: 5px;
    	margin-bottom: 5px;
    	color:#fff;
	}
	.card-item h6{
		color:#fff;
		letter-spacing:0.5px;
		font-weight:200;
	}
	.card-item .progress{
		height: 6px;
    	margin-bottom: 6px;
		background-color:#fff;
	}
	.card-item .progress .progress-bar{
		background-color:var(--theme-secondary);
		opacity:0.7;
	}
	.card-item small{
		color: #f8f9fa;
	}
	.card-item svg.icon-bg{
		position: absolute;right: 2px;width: 64px;height: 64px;opacity: 0.5;
		transition:all 0.3s ease;
		stroke:#fff;
	}
	.card-item:hover svg.icon-bg g{
		
	}
	.panel.custom-panel{
		box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	}
	.panel.custom-panel .panel-heading{
		background-color:#fff;
	}
	.panel.custom-panel .panel-heading p{
		color:#000;
	}
	.filter-dropdown .dropdown-menu li .select2-container{
		width: 100%;
    	padding-left: 5px;
    	padding-right: 5px;
    	padding-bottom: 5px;
	}
	.filter-dropdown .dropdown-menu li input{
		width: 100%;
    	margin-left: 5px;
    	margin-right: 8px;
    	margin-bottom: 5px;
	}
	.filter-dropdown .dropdown-menu li button{
		width: 94%;
    	margin-left: 5px;
    	margin-right: 8px;
    	margin-bottom: 5px;
	}
	.tags-container .badge{
		background-color: #0093E9;
		background-image: linear-gradient(90deg, #0093E9 0%, #80D0C7 100%);
		border-radius:4px;
		margin-right:5px;
	}
	.bootstrap-tagsinput {
  		width: 100%;
	}
</style>
</head>
<body>
	<div class="page-loader hidden">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<!-- <div class="sidebar animated slideOutLeft">
		
	</div> -->
	<div class="container-fluid">
	
		<div class="panel panel-default admin-cover animated fadeInDown" style="margin-top:10px;margin-bottom:8px;">
	  		<div class="panel-body">
	  			<p style="margin-bottom:0;display:inline-block;" class="fs-12"><strong>Hi <span style="text-transform:capitalize;">Admin</span></strong>, Your Analytics are all set</p>	
	  			<div class="pull-right" style="display:inline-block;">
					<select name="cmbcompany" id="cmbcompany" class="form-control">
						<option value="">--Select--</option>
					</select>
				</div>
	  		</div>
	  	</div>
	  	
		<div id="floorcard">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
				<div class="row">
					<div class="col-xs-12 col-sm-4 col-md-3 col-lg-3">
						<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapseenter">
							<svg  id="svg1" version="1.1" fill="none" height="24" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="icon-bg">
								<path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
								<g>
								<polyline points="10 17 15 12 10 7"></polyline>
								<line x1="15" x2="3" y1="12" y2="12"></line>
								</g>
							</svg>
							<h2><span class="value">102</span></h2>
							<h6><strong>Entered</strong></h6>
							<small><span class="value">102</span> out of <span class="totalcount"></span></small>
							<div class="progress">
								<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
							</div>
						</div>
					</div>	
					<div class="col-xs-12 col-sm-4 col-md-3 col-lg-3">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapseack">
					<svg class="icon-bg" style="enable-background:new 0 0 50 50;" version="1.1" viewBox="0 0 50 50" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><style type="text/css">
	.st0{display:none;}
	.st1{display:inline;}
	.st2{display:inline;fill:none;stroke:#fff;stroke-width:3;stroke-miterlimit:10;}
	.st3{display:inline;fill:none;stroke:#fff;stroke-width:5;stroke-linecap:round;stroke-miterlimit:10;}
	.st4{display:inline;fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st5{fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st6{display:inline;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st7{display:none;fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
</style><g class="st0" ><g class="st1"><g><path d="M19.5,8.2c6.2,0,11.3,5.1,11.3,11.3s-5.1,11.3-11.3,11.3S8.2,25.8,8.2,19.5S13.2,8.2,19.5,8.2 M19.5,5.2     c-7.9,0-14.3,6.4-14.3,14.3s6.4,14.3,14.3,14.3s14.3-6.4,14.3-14.3S27.3,5.2,19.5,5.2L19.5,5.2z"/></g></g><line class="st2" x1="28.8" x2="32.1" y1="28.7" y2="32"/><line class="st3" x1="44.8" x2="33" y1="44.8" y2="33"/></g><g class="st0" ><path class="st4" d="M46.3,13.9H3.7c-0.3,0-0.5-0.2-0.5-0.5V6.6c0-0.6,0.4-1,1-1h41.7c0.6,0,1,0.4,1,1v6.8   C46.8,13.7,46.6,13.9,46.3,13.9z"/><path class="st4" d="M42.5,44.4H7.5c-0.6,0-1-0.4-1-1V13.9h37.1v29.5C43.5,43.9,43.1,44.4,42.5,44.4z"/><path class="st4" d="M32.3,26.5H18.2c-1.6,0-2.9-1.3-2.9-2.9v0c0-1.6,1.3-2.9,2.9-2.9h14.1c1.6,0,2.9,1.3,2.9,2.9v0   C35.2,25.1,33.9,26.5,32.3,26.5z"/></g><g class="st0" ><path class="st4" d="M11.6,41.3h-3c-0.6,0-1-0.4-1-1v-32c0-0.6,0.4-1,1-1h3V41.3z"/><path class="st4" d="M32.2,6.1H12.6c-0.6,0-1,0.4-1,1v35.8c0,0.6,0.4,1,1,1h28.9c0.6,0,1-0.4,1-1V15c0-0.3-0.1-0.6-0.4-0.8   l-9.2-7.8C32.7,6.2,32.4,6.1,32.2,6.1z"/><line class="st4" x1="32.2" x2="32.2" y1="6.1" y2="14.9"/><line class="st4" x1="42.4" x2="32.2" y1="15" y2="15"/><g class="st1"><line class="st5" x1="19" x2="36" y1="20.9" y2="20.9"/><line class="st5" x1="19" x2="33.3" y1="26" y2="26"/><line class="st5" x1="19" x2="36" y1="30.9" y2="30.9"/><line class="st5" x1="19" x2="33.3" y1="35.6" y2="35.6"/></g></g><g class="st0" ><path class="st4" d="M38.5,32.6v10.7c0,0.6-0.4,1-0.9,1H9.3c-0.5,0-0.9-0.4-0.9-1V6.6c0-0.6,0.4-1,0.9-1h28.3c0.5,0,0.9,0.4,0.9,1   v10.5"/><path class="st6" d="M28.5,30V20c0-0.2-0.3-0.4-0.5-0.2l-6.6,5c-0.2,0.1-0.2,0.4,0,0.5l6.6,5C28.3,30.4,28.5,30.2,28.5,30z"/><line class="st4" x1="28.5" x2="45.6" y1="25" y2="25"/></g><g class="st0" ><path class="st4" d="M9.9,16.1h31.3v-4.6c0-0.6-0.4-1-1-1H4.4c-0.6,0-1,0.4-1,1v23.2c0,0.6,0.4,1,1,1h4.6V17.1   C8.9,16.5,9.4,16.1,9.9,16.1z"/><path class="st4" d="M46,42.8H9.9c-0.6,0-1-0.4-1-1V17.1c0-0.6,0.4-1,1-1H46c0.6,0,1,0.4,1,1v24.7C47,42.4,46.6,42.8,46,42.8z"/><path class="st4" d="M46,42.8H9.9c-0.6,0-1-0.4-1-1V17.1c0-0.6,0.4-1,1-1l15.3,14.6c1.5,1.5,4,1.5,5.5,0L46,16.1c0.6,0,1,0.4,1,1   v24.7C47,42.4,46.6,42.8,46,42.8z"/><line class="st4" x1="22.3" x2="8.9" y1="27.9" y2="38.6"/><line class="st4" x1="33.6" x2="47" y1="28.1" y2="38.9"/></g><g class="st0" ><path class="st6" d="M30.8,36.6l5.8,8.1c0.1,0.2,0.5,0.2,0.5-0.1l2.5-7.9c0.1-0.2-0.1-0.4-0.3-0.4L31,36.1   C30.8,36.1,30.7,36.4,30.8,36.6z"/><path class="st6" d="M18.7,12.6l-5.8-8.1c-0.1-0.2-0.5-0.2-0.5,0.1l-2.5,7.9c-0.1,0.2,0.1,0.4,0.3,0.4l8.3,0.2   C18.7,13.1,18.9,12.8,18.7,12.6z"/><path class="st4" d="M39.4,36.5c-3.5,4.3-8.7,7-14.6,7c-10.4,0-18.8-8.4-18.8-18.8c0-1.5,0.2-2.9,0.5-4.3"/><path class="st4" d="M10.1,12.6c3.5-4.3,8.7-7,14.6-7c10.4,0,18.8,8.4,18.8,18.8c0,1.5-0.2,2.9-0.5,4.3"/></g><path class="st7" d="M25.1,5.3c-11.5,0-20.9,8.1-20.9,18.2c0,5.8,3.1,11,8,14.3L7.5,45  c-0.2,0.2,0.1,0.5,0.3,0.4c4.7-0.6,8.9-2,12.5-4.3c1.5,0.3,3.1,0.5,4.8,0.5c11.5,0,20.9-8.1,20.9-18.2S36.7,5.3,25.1,5.3z" /><g id="SLA"><path class="st5" d="M43.4,44.4H6.6c-0.6,0-1-0.4-1-1V6.6c0-0.6,0.4-1,1-1h36.8c0.6,0,1,0.4,1,1v36.8   C44.4,43.9,43.9,44.4,43.4,44.4z"/><g><g><line class="st5" x1="11.9" x2="24.4" y1="36.2" y2="36.2"/><line class="st7" x1="30.7" x2="33.2" y1="34.8" y2="37.5"/><line class="st7" x1="38.1" x2="33.2" y1="32.5" y2="37.5"/></g><g><line class="st5" x1="11.9" x2="24.4" y1="26.2" y2="26.2"/><line class="st5" x1="30.7" x2="33.2" y1="24.8" y2="27.5"/><line class="st5" x1="38.1" x2="33.2" y1="22.5" y2="27.5"/></g><g><line class="st5" x1="11.9" x2="24.4" y1="16.2" y2="16.2"/><line class="st5" x1="30.7" x2="33.2" y1="14.8" y2="17.5"/><line class="st5" x1="38.1" x2="33.2" y1="12.5" y2="17.5"/></g></g></g><g class="st0" ><path class="st4" d="M44.2,9.3H5.7c-0.6,0-1-0.4-1-1V4.9c0-0.6,0.4-1,1-1h38.5c0.6,0,1,0.4,1,1v3.4C45.2,8.9,44.7,9.3,44.2,9.3z"/><path class="st4" d="M42.2,38.4H7.7c-0.6,0-1-0.4-1-1V9.3h36.5v28.1C43.2,38,42.7,38.4,42.2,38.4z"/><line class="st4" x1="25" x2="25" y1="42.8" y2="38.4"/><circle class="st4" cx="25" cy="45.6" r="2.2"/><g class="st1"><line class="st5" x1="28" x2="38.7" y1="18.8" y2="18.8"/><line class="st5" x1="28" x2="38.7" y1="23.9" y2="23.9"/><line class="st5" x1="28" x2="38.7" y1="29" y2="29"/><path class="st5" d="M17.8,23.4l-0.6-5.2c0-0.2-0.1-0.3-0.3-0.3c-3.5,0.2-6.2,3.5-5.4,7.1c0.5,2.2,2.3,4,4.5,4.5    c3.7,0.8,6.9-1.9,7.1-5.3c0-0.2-0.1-0.3-0.3-0.3L17.8,23.4z"/></g></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Acknowledged</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-3 col-lg-3">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapsemail">
					<svg class="icon-bg" enable-background="new 0 0 96 96" height="96px" id="mail" version="1.1" viewBox="0 0 96 96" width="96px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path style="stroke: none;fill: #fff;" d="M80,12H16C9.373,12,4,17.373,4,24v48c0,6.627,5.373,12,12,12h64c6.627,0,12-5.373,12-12V24C92,17.373,86.627,12,80,12z   M80,20c0.459,0,0.893,0.093,1.303,0.235L48,46.877L14.697,20.235C15.108,20.093,15.541,20,16,20H80z M80,76H16c-2.21,0-4-1.79-4-4  V28.323l33.501,26.8C46.231,55.708,47.116,56,48,56s1.769-0.292,2.499-0.877L84,28.323V72C84,74.21,82.21,76,80,76z"/></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Mail Sent</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-3 col-lg-3">
				<div class="card-item"  data-parent="#floorcard" data-toggle="collapse" data-target="#collapsestatus">
					<svg class="icon-bg" height="8.4666mm" style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd" version="1.1" viewBox="0 0 846.66 846.66" width="8.4666mm" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><defs><style type="text/css">
   <![CDATA[
    .fil0 {fill:#fff;fill-rule:nonzero}
   ]]>
  </style></defs><g id="Layer_x0020_1"><path class="fil0" d="M57.69 10.3l586.02 0c11.4,0 20.65,9.24 20.65,20.64l0 86.43 124.61 0c11.4,0 20.64,9.24 20.64,20.64l0 677.71c0,11.4 -9.24,20.64 -20.64,20.64l-586.02 0c-11.4,0 -20.65,-9.24 -20.65,-20.64l0 -86.43 -124.61 0c-11.4,0 -20.64,-9.24 -20.64,-20.64l0 -677.71c0,-11.4 9.24,-20.64 20.64,-20.64zm606.67 148.36l0 549.99c0,11.4 -9.25,20.64 -20.65,20.64l-420.11 0 0 65.78 544.72 0 0 -636.41 -103.96 0zm-375.67 176.69c-5.31,26.52 -45.63,18.46 -40.33,-8.06 5.33,-26.52 20.73,-49.83 42.89,-65.22 -1.02,-1.32 -2,-2.68 -2.93,-4.07 -8.05,-12.01 -12.75,-26.38 -12.75,-41.76 0,-41.49 33.64,-75.13 75.13,-75.13 41.49,0 75.13,33.64 75.13,75.13 0,16.64 -5.53,32.68 -15.68,45.83 22.17,15.38 37.57,38.7 42.89,65.22 5.3,26.52 -35.02,34.58 -40.32,8.06 -4.36,-21.68 -20.08,-39.68 -40.91,-47.03 -6.82,2.03 -13.99,3.06 -21.11,3.06 -7.1,0 -14.29,-1.03 -21.11,-3.06 -20.83,7.35 -36.55,25.34 -40.9,47.03zm62.01 -85.26c18.93,0 33.84,-15.08 33.84,-33.85 0,-18.69 -15.15,-33.84 -33.84,-33.84 -18.69,0 -33.84,15.15 -33.84,33.84 0,18.93 15.09,33.85 33.84,33.85zm-151.48 198.89c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm0 149.5c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm0 -74.75c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm423.84 -472.14l-544.72 0 0 636.41 544.72 0 0 -636.41z"/></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Status Updated</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>	
				</div>
				<div class="row container-fluid">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 no-padding">
				<div class="collapse table-responsive" id="collapseenter">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Company</th>
										<th>Username</th>
										<th>Form Name</th>
										<th>Short Desc</th>
										<th>Status</th>
										<th>Total Time(Hrs)</th>
										<th>Last Status(Hrs)</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapseack">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Company</th>
										<th>Username</th>
										<th>Form Name</th>
										<th>Short Desc</th>
										<th>Status</th>
										<th>Total Time(Hrs)</th>
										<th>Last Status(Hrs)</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapsemail">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Company</th>
										<th>Username</th>
										<th>Form Name</th>
										<th>Short Desc</th>
										<th>Status</th>
										<th>Total Time(Hrs)</th>
										<th>Last Status(Hrs)</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="collapse table-responsive" id="collapsestatus">
					<div class="panel panel-default">
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Doc No</th>
										<th>Company</th>
										<th>Username</th>
										<th>Form Name</th>
										<th>Short Desc</th>
										<th>Status</th>
										<th>Total Time(Hrs)</th>
										<th>Last Status(Hrs)</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
				
			</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
				<div class="panel panel-default">
					<div class="panel-heading">
						<p style="margin-bottom:0px;"><strong>Company Wise Queries</strong>
					</div>
					<div class="panel-body" style="max-height:250px;overflow-y:auto;">
						<ul class="list-group" id="compwiselist" style="margin-bottom:0px;">
						</ul>	
					</div>
						
				</div>
				
			</div>
			
		</div>
		
		</div>
	</div>
	
	<%-- <script src="../../js/chartutils.js"></script> --%>
	<script src="../../vendors/jquery/jquery-3.2.1.min.js"></script>
	<script src="../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
	<script src="../../vendors/select2/js/select2.min.js"></script>
	<script type="text/javascript">
		
    	$(document).ready(function(){
    		
    		$("#floorcard .collapse").on('show.bs.collapse', function(){
				$("#floorcard .collapse.in").collapse('hide');
			});
			$('.card-item').click(function(){
				$('.card-item').not(this).each(function(){
					if($(this).hasClass('active')){
						$(this).removeClass('active');		
					}
				});
				
				$(this).toggleClass('active');
			});
			funGetInitData();
			funGetFilterData();
    		
    		$('#cmbcompany').on('change', function (e) {
				funGetFilterData();
			});
    	});
		
		function funGetInitData(){
			$.get('getInitData.jsp', function(data) {
				data=JSON.parse(data);
				var htmldata='<option value="">--Select--</option>';
				$.each(data.compdata,function(index,value){
					htmldata+='<option value="'+value.docno+'">'+value.name+'</option>';
				});
				$('#cmbcompany').html($.parseHTML(htmldata));
				$('#cmbcompany').select2({
					placeholder:'Select Company',
					allowClear:true
				});
			});
		}
		function funGetFilterData(){
			
			$.ajax({
				url: "getFilterData.jsp",
				data:{
					compid:$('#cmbcompany').val()
				},
				success: function(data){
    				data=JSON.parse(data);
	    			var enterpercent=((parseFloat(data.entercount)/parseFloat(data.totalcount))*100).toFixed(0);
					var ackpercent=((parseFloat(data.ackcount)/parseFloat(data.totalcount))*100).toFixed(0);
					var mailpercent=((parseFloat(data.mailcount)/parseFloat(data.totalcount))*100).toFixed(0);
					var statuspercent=((parseFloat(data.statuscount)/parseFloat(data.totalcount))*100).toFixed(0);
					if (isNaN(enterpercent)) enterpercent = 0;
					if (isNaN(ackpercent)) ackpercent = 0;
					if (isNaN(mailpercent)) mailpercent = 0;
					if (isNaN(statuspercent)) statuspercent = 0;
					$('.card-item').eq(0).find('.value').text(data.entercount).closest('.card-item').find('.progress-bar').css('width',enterpercent+'%');
					$('.card-item').find('.totalcount').text(data.totalcount);
					$('.card-item').eq(1).find('.value').text(data.ackcount).closest('.card-item').find('.progress-bar').css('width',ackpercent+'%');
					$('.card-item').eq(2).find('.value').text(data.mailcount).closest('.card-item').find('.progress-bar').css('width',mailpercent+'%');
					$('.card-item').eq(3).find('.value').text(data.statuscount).closest('.card-item').find('.progress-bar').css('width',statuspercent+'%');
					
					var htmldata='';
					$.each(data.compwisedata,function(index,value){
						htmldata+='<li class="list-group-item">'+value.compname+'<span class="badge badge-default">'+value.count+'</span></li>';
					});
					$('#compwiselist').html($.parseHTML(htmldata));
					htmldata='';
					var srno=1;
					$.each(data.entercarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.docno+'</td>';
						htmldata+='<td>'+value.company+'</td>';
						htmldata+='<td>'+value.username+'</td>';
						htmldata+='<td>'+value.formname+'</td>';
						htmldata+='<td>'+value.shortdesc+'</td>';
						htmldata+='<td>'+value.laststatus+'</td>';
						htmldata+='<td>'+value.totaltime+'</td>';
						htmldata+='<td>'+value.laststatustime+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapseenter table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.ackcarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.docno+'</td>';
						htmldata+='<td>'+value.company+'</td>';
						htmldata+='<td>'+value.username+'</td>';
						htmldata+='<td>'+value.formname+'</td>';
						htmldata+='<td>'+value.shortdesc+'</td>';
						htmldata+='<td>'+value.laststatus+'</td>';
						htmldata+='<td>'+value.totaltime+'</td>';
						htmldata+='<td>'+value.laststatustime+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapseack table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.mailcarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.docno+'</td>';
						htmldata+='<td>'+value.company+'</td>';
						htmldata+='<td>'+value.username+'</td>';
						htmldata+='<td>'+value.formname+'</td>';
						htmldata+='<td>'+value.shortdesc+'</td>';
						htmldata+='<td>'+value.laststatus+'</td>';
						htmldata+='<td>'+value.totaltime+'</td>';
						htmldata+='<td>'+value.laststatustime+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapsemail table tbody').html($.parseHTML(htmldata));
					htmldata='';
					srno=1;
					$.each(data.statuscarddata,function(index,value){
						htmldata+='<tr>';
						htmldata+='<td>'+srno+'</td>';
						htmldata+='<td>'+value.docno+'</td>';
						htmldata+='<td>'+value.company+'</td>';
						htmldata+='<td>'+value.username+'</td>';
						htmldata+='<td>'+value.formname+'</td>';
						htmldata+='<td>'+value.shortdesc+'</td>';
						htmldata+='<td>'+value.laststatus+'</td>';
						htmldata+='<td>'+value.totaltime+'</td>';
						htmldata+='<td>'+value.laststatustime+'</td>';
						htmldata+='</tr>';
						srno++;
					});
					$('#collapsestatus table tbody').html($.parseHTML(htmldata));
					
  				}
  			});
			
		}
		
	</script>
</body>
</html>