<!DOCTYPE html>
<html lang="en">
<head>
	<title>Call Register</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/bootstrap-v4/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../vendors/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/select2/css/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../vendors/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->

	<style type="text/css">
		/* Change Autocomplete styles in Chrome*/
		input:-webkit-autofill,
		input:-webkit-autofill:hover, 
		input:-webkit-autofill:focus,
		textarea:-webkit-autofill,
		textarea:-webkit-autofill:hover,
		textarea:-webkit-autofill:focus,
		select:-webkit-autofill,
		select:-webkit-autofill:hover,
		select:-webkit-autofill:focus {
		  /* border: 1px solid green; */
		  /* -webkit-text-fill-color: #fff; */
		   -webkit-box-shadow: 0 0 0px 1000px #fff inset;
		  /*transition: background-color 5000s ease-in-out 0s; */
		}
	</style>
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100" style="background-image: url('images/bg-01.jpg');">
			<div class="wrap-login100 p-t-30 p-b-50">
				<span class="login100-form-title p-b-41">
					GW Account Login
				</span>
				<form class="login100-form validate-form p-b-33 p-t-5" id="frmCallRegisterLogin" action="saveCallRegisterLogin" method="post">

					<div class="wrap-input100 validate-input" data-validate = "Enter username">
						<input class="input100" type="text" name="username" placeholder="User name" id="username">
						<span class="focus-input100" data-placeholder="&#xe82a;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<input class="input100" type="password" name="password" placeholder="Password" id="password">
						<span class="focus-input100" data-placeholder="&#xe80f;"></span>
					</div>

					<div class="container-login100-form-btn m-t-32">
						<button class="login100-form-btn">
							Login
						</button>
					</div>
					<input type="hidden" name="docno" id="docno">
					<input type="hidden" name="mode" id="mode">
					<input type="hidden" name="msg" id="msg">
				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="../vendors/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/bootstrap-v4/js/popper.js"></script>
	<script src="../vendors/bootstrap-v4/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/select2/js/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/daterangepicker/moment.min.js"></script>
	<script src="../vendors/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>