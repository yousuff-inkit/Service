
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html >
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="<%=contextPath+"/"%>gatelogo.ico" > 
		<title>Gateway ERP(Integrated) Copyright &#169; 2017 GW INNOVATIONS Pvt Ltd</title>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/vendors/bootstrap-v4/css/bootstrap.min.css">
		<script type="text/javascript" src="<%=contextPath%>/vendors/jquery/jquery-3.2.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/vendors/bootstrap-v4/js/popper.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/vendors/bootstrap-v4/js/bootstrap.min.js"></script>
		
		<style type="text/css">
			.limiter {
				width: 100%;
			  	margin: 0 auto;
			}
			
			.container-login100 {
			  	width: 100%;  
			  	min-height: 100vh;
			  	display: -webkit-box;
			  	display: -webkit-flex;
			  	display: -moz-box;
			  	display: -ms-flexbox;
			  	display: flex;
			  	flex-wrap: wrap;
			  	justify-content: center;
			  	align-items: center;
			  	background: #f2f2f2;
			}
			
			
			.wrap-login100 {
			  	width: 100%;
			  	background: #fff;
			  	overflow: hidden;
			  	display: -webkit-box;
			  	display: -webkit-flex;
			  	display: -moz-box;
			  	display: -ms-flexbox;
			  	display: flex;
			  	flex-wrap: wrap;
			  	align-items: stretch;
			  	flex-direction: row-reverse;
			
			}
			
			.login100-more {
			  width: calc(100% - 560px);
			  background-repeat: no-repeat;
			  background-size: cover;
			  /*background-position: center;*/
			  background-position: 30% 10%;
			  position: relative;
			  z-index: 1;
			  animation: 6s pan infinite alternate linear;
			}
			@keyframes pan {
    			100%{
        			background-position:50% 50%;
    			}
			}
			.login100-more::before {
			  content: "";
			  display: block;
			  position: absolute;
			  z-index: -1;
			  width: 100%;
			  height: 100%;
			  top: 0;
			  left: 0;
			  background: rgba(0,0,0,0.1);
			}
			
			.login100-form {
			  width: 560px;
			  min-height: 100vh;
			  display: block;
			  background-color: #f7f7f7;
			  padding: 17px 1em 0 1em;
			}
			
			.login100-form-title {
			  width: 100%;
			  display: block;
			  font-family: Poppins-Regular;
			  font-size: 30px;
			  color: #333333;
			  line-height: 1.2;
			  text-align: center;
			}
		</style>
	</head>
	<body>
		<div class="limiter">
			<div class="container-login100">
				<div class="wrap-login100">
					<form class="login100-form">
						<span class="login100-form-title p-b-43">
							Choose Company to continue
						</span>
						<div class="company-container" style="height:90vh;overflow-y:auto;">
								
						</div>
						
					</form>
					<div class="login100-more" style="background-image: url('icons/multi-screen2.jpg');">
						<div class="text-center mt-5">
							<img src="icons/epic.jpg" class="img-fluid rounded shadow p-4" style="background-color:rgba(0,0,0,00.5);">
						</div>
						
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				getInitData();
			});
			
			function getInitData(){
				$.get('getMultiCompany.jsp',function(data){
					data=JSON.parse(data);
					var htmldata='';
					$.each(data.dbdata,function(index,value){
						htmldata+='<a class="card rounded shadow" href="'+value.compurl+'" data-compdocno="'+value.compdocno+'">';
						htmldata+='<span class="card-body">';
						htmldata+='<p class="mb-0">'+value.compname+'</p>';
						htmldata+='</span>';
						htmldata+='</a>';
					});
					$('.company-container').html($.parseHTML(htmldata));
					
					var intercompdocno='<%=request.getParameter("compdocno")==null?"":request.getParameter("compdocno").toString()%>';
					var interusername='<%=request.getParameter("username")==null?"":request.getParameter("username").toString()%>';
					if(intercompdocno!=null && intercompdocno!="" && intercompdocno!="undefined" && typeof(intercompdocno)!="undefined"){
						$.each(data.dbdata,function(index,value){
							if(value.compdocno==intercompdocno){
								location.href=value.compurl+"?compdocno="+intercompdocno+"&username="+interusername;
								return false;
							}
						});
						
					}
					
				});
			}
		</script>
	</body>
</html>