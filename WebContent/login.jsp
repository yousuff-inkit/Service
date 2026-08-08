<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/mystyle.css">
<link rel="shortcut icon" href="<%=contextPath+"/"%>icons/ink_new_logo_2025.png" >
<title>INK IT Business Solutions</title>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
<link href="<%=contextPath%>/vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style type="text/css">
@font-face {
    font-family: Poppins-Regular;
    src: url('icons/fonts/poppins/Poppins-Regular.ttf');
}

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html, body {
    width: 100%; height: 100%;
    overflow: hidden;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
}
body { background: #0b1120; }

.page-shell {
    display: flex;
    width: 100vw;
    height: 100vh;
}

/* ─────────────── LEFT : BRAND PANEL ─────────────── */
.brand-panel {
    flex: 0 0 58%;
    position: relative;
    background: linear-gradient(145deg, #0b1120 0%, #0f1e3c 60%, #0b1120 100%);
    overflow: hidden;
    display: flex;
    flex-direction: column;
    padding: 44px 60px;
}
.brand-panel::before {
    content: '';
    position: absolute;
    top: -200px; right: -180px;
    width: 560px; height: 560px;
    background: radial-gradient(circle, rgba(37,99,235,0.28) 0%, transparent 68%);
    border-radius: 50%;
    pointer-events: none;
}
.brand-panel::after {
    content: '';
    position: absolute;
    bottom: -160px; left: -100px;
    width: 440px; height: 440px;
    background: radial-gradient(circle, rgba(16,185,129,0.16) 0%, transparent 68%);
    border-radius: 50%;
    pointer-events: none;
}
.dot-grid {
    position: absolute; inset: 0;
    background-image: radial-gradient(rgba(255,255,255,0.055) 1px, transparent 1px);
    background-size: 26px 26px;
    pointer-events: none;
    z-index: 0;
}
.bp-logo { position: relative; z-index: 2; }
.bp-logo img {
    height: 40px; width: auto;
    filter: brightness(0) invert(1);
    opacity: 0.92;
}
.bp-body {
    position: relative; z-index: 2;
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 0 0 20px;
}
.bp-eyebrow {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 2.5px;
    text-transform: uppercase;
    color: #60a5fa;
    margin-bottom: 22px;
}
.bp-eyebrow::before {
    content: '';
    display: inline-block;
    width: 28px; height: 2px;
    background: linear-gradient(90deg, #2563eb, #60a5fa);
    border-radius: 2px;
}
.bp-title {
    font-size: clamp(30px, 3.4vw, 50px);
    font-weight: 800;
    line-height: 1.1;
    color: #f1f5f9;
    letter-spacing: -1.5px;
    margin-bottom: 22px;
}
.bp-title .grad {
    background: linear-gradient(90deg, #60a5fa 0%, #34d399 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}
.bp-tagline {
    font-size: 14.5px;
    line-height: 1.75;
    color: #94a3b8;
    max-width: 400px;
    margin-bottom: 44px;
}
.bp-features {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 16px;
}
.bp-features li {
    display: flex;
    align-items: center;
    gap: 14px;
    font-size: 13.5px;
    font-weight: 500;
    color: #cbd5e1;
    line-height: 1.4;
}
.bp-feat-icon {
    flex-shrink: 0;
    width: 28px; height: 28px;
    border-radius: 8px;
    background: rgba(37,99,235,0.18);
    border: 1px solid rgba(59,130,246,0.3);
    display: flex; align-items: center; justify-content: center;
}
.bp-feat-icon svg { width: 14px; height: 14px; fill: #60a5fa; }
.bp-stats {
    position: relative; z-index: 2;
    display: flex;
    gap: 0;
    border-top: 1px solid rgba(255,255,255,0.08);
    padding-top: 28px;
    margin-top: auto;
}
.bp-stat { flex: 1; padding-right: 24px; }
.bp-stat:not(:first-child) {
    padding-left: 24px;
    border-left: 1px solid rgba(255,255,255,0.08);
}
.bp-stat-n {
    display: block;
    font-size: 26px;
    font-weight: 800;
    color: #f1f5f9;
    letter-spacing: -1px;
    line-height: 1;
    margin-bottom: 4px;
}
.bp-stat-l {
    display: block;
    font-size: 11.5px;
    font-weight: 500;
    color: #64748b;
    text-transform: uppercase;
    letter-spacing: 1px;
}

/* ─────────────── RIGHT : FORM PANEL ─────────────── */
.form-panel {
    flex: 0 0 42%;
    background: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 48px 40px;
    position: relative;
    overflow-y: auto;
}
.form-panel::before {
    content: '';
    position: absolute;
    top: 0; left: 0;
    width: 3px; height: 100%;
    background: linear-gradient(180deg, #2563eb 0%, #10b981 100%);
}
.fp-inner { width: 100%; max-width: 340px; }
.fp-logo { margin-bottom: 36px; }
.fp-logo img { height: 40px; width: auto; }
.fp-heading { margin-bottom: 22px; }
.fp-heading h2 {
    font-size: 24px;
    font-weight: 800;
    color: #0f172a;
    letter-spacing: -0.5px;
    margin-bottom: 5px;
}
.fp-heading p { font-size: 13.5px; color: #64748b; }

#msgexpiry {
    display: block;
    width: 100%;
    min-height: 16px;
    margin-bottom: 14px;
    padding: 0;
    border: none;
    background: transparent;
    color: #ef4444;
    font-weight: 700;
    font-size: 12.5px;
    text-align: center;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    -moz-animation-duration: 1s;
    -moz-animation-name: blink;
    -moz-animation-iteration-count: infinite;
    -moz-animation-direction: alternate;
    -webkit-animation-duration: 2s;
    -webkit-animation-name: blink;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-direction: alternate;
    animation-duration: 1s;
    animation-name: blink;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}
@-moz-keyframes blink { from { opacity: 1; } to { opacity: 0; } }
@-webkit-keyframes blink { from { opacity: 1; } to { opacity: 0; } }
@keyframes blink { from { opacity: 1; } to { opacity: 0; } }

.fp-form {
    display: flex;
    flex-direction: column;
    gap: 18px;
}
.fp-field {
    display: flex;
    flex-direction: column;
    gap: 7px;
}
.fp-field label {
    font-size: 12.5px;
    font-weight: 600;
    color: #374151;
    letter-spacing: 0.1px;
}
.fp-field select {
    width: 100%;
    height: 46px;
    padding: 0 14px;
    font-size: 14px;
    font-weight: 500;
    color: #0f172a;
    background: #f8fafc;
    border: 1.5px solid #e2e8f0;
    border-radius: 10px;
    appearance: auto;
    cursor: pointer;
    outline: none;
    transition: border-color 0.18s, box-shadow 0.18s, background 0.18s;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
}
.fp-field select:focus {
    border-color: #2563eb;
    background: #fff;
    box-shadow: 0 0 0 3px rgba(37,99,235,0.12);
}
.fp-input-wrap { position: relative; display: flex; align-items: center; }
.fp-icon {
    position: absolute;
    left: 14px;
    font-size: 14px;
    color: #94a3b8;
    pointer-events: none;
    z-index: 1;
}
.fp-field input[type="text"],
.fp-field input[type="password"],
.fp-field input[type="email"] {
    width: 100%;
    height: 46px;
    padding: 0 14px 0 40px;
    font-size: 14px;
    color: #0f172a;
    background: #f8fafc;
    border: 1.5px solid #e2e8f0;
    border-radius: 10px;
    outline: none;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    transition: border-color 0.18s, background 0.18s, box-shadow 0.18s;
}
.fp-field input.no-icon { padding-left: 14px; }
.fp-field input:focus {
    border-color: #2563eb;
    background: #fff;
    box-shadow: 0 0 0 3px rgba(37,99,235,0.12);
}
.fp-field input::placeholder { color: #b0bec5; font-size: 13px; }

.buttonStyle {
    width: 100%;
    height: 48px;
    margin-top: 6px;
    background: linear-gradient(135deg, #1d4ed8 0%, #2563eb 60%, #3b82f6 100%);
    border: none;
    border-radius: 10px;
    color: #fff;
    font-size: 15px;
    font-weight: 700;
    letter-spacing: 0.3px;
    text-transform: uppercase;
    cursor: pointer;
    transition: transform 0.15s, box-shadow 0.18s;
    box-shadow: 0 6px 22px rgba(37,99,235,0.38);
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
}
.buttonStyle:hover,
.buttonStyle:active,
.buttonStyle:focus {
    transform: translateY(-2px);
    box-shadow: 0 12px 32px rgba(37,99,235,0.48);
    color: #fff;
}

.fp-footer {
    margin-top: 30px;
    text-align: center;
    font-size: 11.5px;
    color: #94a3b8;
}

/* ─────────────── WIZARD MODAL ─────────────── */
.wizard-container {
    width: 420px;
    position: absolute;
    z-index: 9999;
    top: 50%;
    left: 50%;
    background-color: #fff;
    transform: translate(-50%,-50%);
    box-shadow: 0 19px 38px rgba(0,0,0,0.15), 0 15px 12px rgba(0,0,0,0.10);
    border-radius: 12px;
    padding: 30px;
    opacity: 0;          
    visibility: hidden;
    transition: all 0.25s ease-in; 
}
.wizard-container.active {
    opacity: 1;
    visibility: visible;
}
.btnwizardclose-container {
    position: absolute;
    top: 15px;
    right: 20px;
}
.btnwizardclose-container a i {
    color: #94a3b8;
    font-size: 18px;
    transition: color 0.2s;
}
.btnwizardclose-container a:hover i {
    color: #0f172a;
}
.wizard-container h3 {
    font-size: 18px;
    font-weight: 700;
    color: #0f172a;
    margin-bottom: 20px;
    text-align: center;
}
.tabcontrols-container {
    display: flex;
    gap: 10px;
    width: 100%;
    margin-bottom: 25px;
}
.tabcontrols-container .tab-control {
    flex: 1;
    padding: 10px;
    background: #f8fafc;
    border: 1.5px solid #e2e8f0;
    border-radius: 8px;
    color: #64748b;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
}
.tab-control.active {
    background-color: #2563eb;
    border-color: #2563eb;
    color: #fff;
}
.tab-content {
    width: 100%;
    display: none;
}
.btn-next, .btn-dismiss {
    float: right;
    margin-top: 15px;
    padding: 10px 20px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
}
.btn-dismiss { float: none; display: inline-block; }
.btn-next:hover, .btn-dismiss:hover {
    background-color: #1d4ed8;
}
.instructions {
    text-align: center;
    font-size: 14px;
    color: #374151;
    line-height: 1.5;
}
.help-block-wizard {
    display: block;
    min-height: 16px;
    margin-top: 4px;
    color: #ef4444;
    font-size: 12px;
}

/* ─────────────── SNACKBAR ─────────────── */
#snackbar {
    visibility: hidden;
    min-width: 280px;
    margin-left: -140px;
    background-color: #0f172a;
    color: #fff;
    text-align: center;
    border-radius: 10px;
    padding: 14px 20px;
    position: fixed;
    z-index: 1;
    left: 50%;
    bottom: 30px;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    font-size: 13px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.25);
}
#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}
@-webkit-keyframes fadein { from {bottom: 0; opacity: 0;} to {bottom: 30px; opacity: 1;} }
@keyframes fadein { from {bottom: 0; opacity: 0;} to {bottom: 30px; opacity: 1;} }
@-webkit-keyframes fadeout { from {bottom: 30px; opacity: 1;} to {bottom: 30px; opacity: 1;} }
@keyframes fadeout { from {bottom: 30px; opacity: 1;} to {bottom: 30px; opacity: 1;} }

.loginTable, .loginTable tr, .loginTable td { all: unset; display: block; }
.content { all: unset; }
</style>

<script>
$(document).ready(function () {
    
    // Auto-login functionality from legacy
    var compdocno='<%=request.getParameter("compdocno")==null?"":request.getParameter("compdocno")%>';
    var username='<%=request.getParameter("username")==null?"":request.getParameter("username")%>';
    if(compdocno!=null && compdocno!="" && compdocno!="undefined" && typeof(compdocno)!="undefined" ){
        $.get('getUserDetails.jsp',{'username':username},function(data){
            data=JSON.parse(data);
            $('#username').val(data.userid);
            $('#password').val(data.password);
            $('#btnlogin').trigger('click');
        })
    }

    if($('#msg').val()!="" ) {
        $.messager.alert('Login Failed',$('#msg').val());
    }
    $('#snackbar').addClass('show');

    $('body').keydown(function (evt) {
        if (evt.keyCode == 8) {
            var d = event.srcElement || event.target;
            if ((d.tagName.toUpperCase() === 'INPUT' && 
                 (
                     d.type.toUpperCase() === 'TEXT' ||
                     d.type.toUpperCase() === 'PASSWORD' || 
                     d.type.toUpperCase() === 'FILE' || 
                     d.type.toUpperCase() === 'EMAIL' || 
                     d.type.toUpperCase() === 'SEARCH' || 
                     d.type.toUpperCase() === 'DATE' )
                 ) || 
                 d.tagName.toUpperCase() === 'TEXTAREA') {
                doPrevent = d.readOnly || d.disabled;
            } else {
                doPrevent = true;
            }
        }
        if (doPrevent) {
            event.preventDefault();
        }
    }); 

    $("input").not($(":button")).keypress(function (evt) {
        if (evt.keyCode == 13) {
            iname = $(this).val();
            if (iname !== 'Submit') {
                var fields = $(this).parents('form:eq(0),body').find('button, input, textarea, select');
                var index = fields.index(this);
                if (index > -1 && (index + 1) < fields.length) {
                    fields.eq(index + 1).focus();
                }
                return false;
            }
        }
    });

    // Wizard Controls
    $('.wizard-container').fadeOut(0);
    
    $('.forgotpwd').click(function(){
        $("#forgotemail").val('');
        $('#forgotemail').css('border-color', '#e2e8f0');
        $('.help-block-wizard').text("");
        $('#btnstep2').removeClass('active');
        $('#btnstep1').addClass('active');

        if($('.wizard-container').hasClass('active')){
            $('.wizard-container').fadeOut(200).removeClass('active');
        } else {
            $('#step2').hide();
            $('#step1').show();
            $('.wizard-container').fadeIn(200).addClass('active');    
        }
    });
    
    $('.wizard-container').keyup(function(e){
        if (e.keyCode == 27) { 
            $(this).fadeOut(200).removeClass('active');
        }
    });
    
    $('.btnwizardclose').click(function(){
        $('.wizard-container').fadeOut(200).removeClass('active');
        return false;
    });

    $('.btn-next').click(function(){
        var email = $("#forgotemail").val();
        if (validateEmail(email)) {
            $('#forgotemail').css('border-color', '#e2e8f0');
            $('.help-block-wizard').text("");
            validateEmailDB(email);
        } else {
            $('#forgotemail').css('border-color', '#ef4444');
            $('.help-block-wizard').text("Please enter a valid email");
        }
    });

    $('.btn-dismiss').click(function(){
        $('.wizard-container').fadeOut(200).removeClass('active');
    });
});

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validateEmailDB(email) { 
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(items == "1") {
                $('#step1').hide();
                $('#forgotemail').css('border-color', '#e2e8f0');
                $('.help-block-wizard').text("");
                
                $('#btnstep1').removeClass('active');
                $('#btnstep2').addClass('active');
                
                $('.instructions').text("The login credentials have been sent to the Email " + email + ". Thank You.");
                $('#step2').fadeIn();
            } else {
                $('#forgotemail').css('border-color', '#ef4444');
                $('.help-block-wizard').text("We couldn't find an account matching this email. Please verify.");
            }
        }
    }
    x.open("GET", "checkForgotEmail.jsp?email=" + email, true);
    x.send();
}

function getComp() {
    var x=new XMLHttpRequest();
    var items, cmpItems;
    x.onreadystatechange=function(){
        if (x.status == 500) {
            chkcompany();
        }
        if (x.readyState==4 && x.status==200) {
            items = x.responseText;
            if(items.trim() == "NOTGET") {
                chkcompany();
                return 0;
            } else {
                items = items.split('####');
                var cmpItems = items[0].split(",");
                var cmpIdItems = items[1].split(",");
                var optionscmp = '';
                for (var i = 0; i < cmpItems.length; i++) {
                    optionscmp += '<option value="' + cmpIdItems[i] + '">' + cmpItems[i] + '</option>';
                }
                $("select#company").html(optionscmp);
                
                if(items[2].trim() == '') {
                    $('#msgexpiry').hide();
                } else {
                    $('#msgexpiry').val(items[2]);
                    $('#msgexpiry').show();
                }
            }
        }
    }
    x.open("GET", "getCompany.jsp", true);
    x.send();
}

function chkcompany() {
    var company = $("#company").val();
    if(!(parseInt(company) > 0)) {  
        setInterval(function(){ 
            window.location.reload(true);
        }, 3000);
    }
}
</script> 

</head>
<body autocomplete="off" onload="getComp();">

<div class="page-shell">

  <!-- ────────── LEFT : BRAND PANEL ────────── -->
  <div class="brand-panel">
    <div class="dot-grid"></div>

    <div class="bp-logo">
     <img src="icons/ink_new_logo_2025.png" alt="INK IT Business Solutions">
    </div>

    <div class="bp-body">
      <span class="bp-eyebrow">Enterprise Resource Planning</span>

      <h1 class="bp-title">
        Smarter ERP for<br>
        <span class="grad">Modern Business</span>
      </h1>

      <p class="bp-tagline">
        A unified platform to manage car rental, fleet, finance, HR, and operations —
        all from a single, powerful workspace.
      </p>

      <ul class="bp-features">
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M3 4h14v2H3V4zm0 4h10v2H3V8zm0 4h14v2H3v-2z"/></svg>
          </span>
          Multi-branch Operations &amp; Fleet Management
        </li>
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M2 11l8-8 8 8v7a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-7z"/></svg>
          </span>
          Real-time Financial Reports &amp; Analytics
        </li>
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M10 10a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm-7 8a7 7 0 0 1 14 0H3z"/></svg>
          </span>
          Integrated HR, Payroll &amp; Leave Management
        </li>
        <li>
          <span class="bp-feat-icon">
            <svg viewBox="0 0 20 20"><path d="M7.629 15.314l-4.71-4.71 1.414-1.415 3.296 3.296 8.042-8.042 1.414 1.414z"/></svg>
          </span>
          Approval Workflows &amp; Role-based Access Control
        </li>
      </ul>
    </div>

    <div class="bp-stats">
      <div class="bp-stat">
        <span class="bp-stat-n">33+</span>
        <span class="bp-stat-l">Modules</span>
      </div>
      <div class="bp-stat">
        <span class="bp-stat-n">Multi</span>
        <span class="bp-stat-l">Branch</span>
      </div>
      <div class="bp-stat">
        <span class="bp-stat-n">24 / 7</span>
        <span class="bp-stat-l">Support</span>
      </div>
    </div>
  </div><!-- /.brand-panel -->


  <!-- ────────── RIGHT : FORM PANEL ────────── -->
  <div class="form-panel">
    <div class="fp-inner">

      <div class="fp-logo">
        <img src="icons/ink_new_logo_2025.png" alt="INK IT Business Solutions">
      </div>

      <div class="fp-heading">
        <h2>Welcome back</h2>
        <p>Sign in to your workspace</p>
      </div>

      <div class="content">
        <form method="post" action="login" autocomplete="off" class="fp-form">

          <table class="loginTable" border="0" align="center" cellpadding="10" cellspacing="0">
          <tr>
              <td colspan="3" align="center"><input type="text" id="msgexpiry" name="msgexpiry" value='<s:property value="msgexpiry"/>'/></td>
          </tr>
          <tr>
              <td colspan="3">
                <div class="fp-field">
                  <label for="company">Company</label>
                  <select name="company" id="company" required="required"></select>
                </div>
              </td>
          </tr>
          <tr>
              <td colspan="3">
                <div class="fp-field">
                  <label for="username">Username</label>
                  <div class="fp-input-wrap">
                    <i class="glyphicon glyphicon-user fp-icon"></i>
                    <input id="username" type="text" name="userid" value="" placeholder="Username" autofocus>
                  </div>
                </div>
              </td>
          </tr>
          <tr>
              <td colspan="3">
                <div class="fp-field">
                  <label for="password">Password</label>
                  <div class="fp-input-wrap">
                    <i class="glyphicon glyphicon-lock fp-icon"></i>
                    <input id="password" type="password" name="password" value="" placeholder="Password">
                  </div>
                </div>
              </td>
          </tr>
          <tr>
    <td colspan="3">
        <div class="fp-field" style="align-items: flex-end; margin-top: 8px; margin-bottom: 8px;">
            <a class="forgotpwd" tabindex="-1" style="font-size: 12px; color: #2563eb; font-weight: 600; cursor: pointer; text-decoration: none;">Forgot Password?</a>
        </div>
    </td>
</tr>
          <tr>
              <td colspan="3" style="text-align:center;"><input class="buttonStyle" type="submit" id="btnlogin" name="commit" value="Login"/></td>
          </tr>
          </table>

          <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>

        </form>
      </div>

      <p class="fp-footer">&copy; 2025 INK IT Solutions Pvt Ltd. All rights reserved.</p>

    </div>
  </div><!-- /.form-panel -->
</div><!-- /.page-shell -->

<!-- ────────── FORGOT PASSWORD WIZARD ────────── -->
<div class="wizard-container">
    <span class="btnwizardclose-container"><a href="#" class="btnwizardclose"><i class="fa fa-times"></i></a></span>
    <h3>Forgot Password Wizard</h3>
    
    <div class="tabcontrols-container">
        <button type="button" class="tab-control active" data-tab="step1" id="btnstep1">Step 1</button>
        <button type="button" class="tab-control" data-tab="step2" id="btnstep2" disabled style="opacity: 0.7; cursor: not-allowed;">Step 2</button>
    </div>
    
    <div class="tab-content-container">
        <div class="tab-content" id="step1" style="display: block;">
            <div class="fp-field">
                <label for="forgotemail">Email Address</label>
                <div class="fp-input-wrap">
                    <i class="fa fa-envelope fp-icon"></i>
                    <input type="email" id="forgotemail" name="forgotemail" placeholder="Enter Email">    
                </div>
                <span class="help-block-wizard"></span>
            </div>
            <div>
                <button type="button" class="btn-next"><i class="fa fa-chevron-right" style="margin-left: 2px;"></i> Next</button>
            </div>
        </div>
        
        <div class="tab-content" id="step2">
            <div>
                <p class="instructions"></p>
            </div>
            <div style="text-align: center;">
                <button type="button" class="btn-dismiss">Dismiss</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>