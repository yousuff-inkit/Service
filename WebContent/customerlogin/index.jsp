<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Customer Login</title>      
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
<style>
.form-bg{
   width: 100%;
   margin: 0 auto;  
}
.form-container{ font-family: 'Overpass', sans-serif; }
.form-container .form-horizontal{
    background: linear-gradient(to right,#202926 49%,#15201C 50%);
    width: 350px;
    height: 350px;
    padding: 75px 55px;
    margin: 0 auto;
    border-radius: 50%;
}
.form-container .title{
    color: #838585;
    font-family: 'Teko', sans-serif;
    font-size: 35px;
    font-weight: 400;
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin: 0 0 10px 0;
}
.form-horizontal .form-group{
    background-color: rgba(255,255,255,0.15);
    font-size: 0;
    margin: 0 0 15px;
    border: 1px solid #838585;
    border-radius: 3px;
}
.form-horizontal .input-icon{
    color: #838585;
    font-size: 16px;
    text-align: center;
    line-height: 48px;
    height: 45px;
    width: 40px;
    vertical-align: top;
    display: inline-block;
}
.form-horizontal .form-control{
    color: #838585;
    background-color: transparent;
    font-size: 14px;
    letter-spacing: 1px;
    width: calc(100% - 55px);
    height: 45px;
    padding: 2px 10px 0 0;
    box-shadow: none;
    border: none;
    border-radius: 0;
    display: inline-block;
    transition: all 0.3s;
}
.form-horizontal .form-control:focus{
    box-shadow: none;
    border: none;
}
.form-horizontal .form-control::placeholder{
    color: #838585;
    font-size: 13px;
    text-transform: capitalize;
}
.form-horizontal .btn{
    color: rgba(255,255,255,0.8);
    background: rgb(37 100 241 / 95%);
    font-size: 15px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 1px;
    width: 120px;
    height: 120px;
    line-height: 120px;
    margin: 0 0 15px 0;
    border: none;
    border-radius: 50%;
    display: inline-block;
    transform: translateX(30px);
    transition: all 0.3s ease;
}
.form-horizontal .btn:hover,
.form-horizontal .btn:focus{
    color: #fff;
    letter-spacing: 4px;
    box-shadow: 0 0 5px rgba(0,0,0,0.5);
}
.form-horizontal .forgot-pass{
    font-size: 12px;
    text-align: left;
    width: calc(100% - 125px);
    display: inline-block;
    vertical-align: top;
}
.form-horizontal .forgot-pass a{
    color: #999;
    transition: all 0.3s ease;
}
.form-horizontal .forgot-pass a:hover{
    color: #555;
    text-decoration: underline;
}
@media only screen and (max-width:379px){
    .form-container .form-horizontal{
        width: 100%;
    }
}
</style>  
</head>
<body>
   <div class="form-bg">   
    <div class="container-login100" style="background-image: url('images/slider-2.jpg');">
        <div class="row">
            <div class="col-md-offset-4 col-md-4 col-sm-offset-3 col-sm-6">
                <div class="form-container">
                    <form class="login100-form form-horizontal" id="frmCustomerLogin" action="saveCustomerLogin" method="post">    
                        <h3 class="title">Customer Login</h3>      
                        <div class="validate-input form-group" data-validate = "Username is required">
                            <span class="input-icon"><i class="fa fa-user"></i></span>
                            <input class="input100 form-control" type="text" placeholder="Username" name="clientusername" id="clientusername">    
                        </div>
                        <div class="validate-input form-group" data-validate = "Password is required">  
                            <span class="input-icon"><i class="fa fa-lock"></i></span>
                            <input class="input100 form-control" type="password" placeholder="Password" name="clientpassword" id="clientpassword">
                        </div>
                        <span class="forgot-pass"></span>   
                        <button class="login100-form-btn signin">Login</button>
                        <input type="hidden" name="docno" id="docno">
						<input type="hidden" name="mode" id="mode">
						<input type="hidden" name="msg" id="msg">
                    </form>
                </div>
            </div>
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