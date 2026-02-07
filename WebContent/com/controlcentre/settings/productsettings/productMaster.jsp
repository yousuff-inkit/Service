<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet"
	type="text/css" />
<link href="../../../../css/myButton.css" rel="stylesheet"
	type="text/css" />
<style>
#whole {
	width: 100%;
}

#header {
	background-color: #E0ECF8;
	color: black;
	text-align: left;
	height: 7%;
	width: 3% padding:0px;
}

#nav {
	line-height: 30px;
	background-color: #E0ECF8;
	height: 90.5%;
	width: 5%;
	float: left;
	position: absolute;
}

#comiframe {
	float: right;
	width: 98.5%;
	height: 98%;
	color: #eeeeee;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value);
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value);
	});
</script>
<script type="text/javascript">

	function gethsnconfig(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var res= x.responseText;
			 	if(res>0){
			 		$("#hsnbutton").attr('type',"button");
				}
			}
		       else
			  {}
	     }
	     x.open("GET",'hsnconfig.jsp',true);
	     x.send();   
	}
	
	
	function getsubcategoryconfig(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var res= x.responseText;
			 	if(res==0){
			 		$("#subcategorybutton").attr('type',"button");
				}
			}
		       else
			  {}
	     }
	     x.open("GET",'subcategoryconfig.jsp',true);
	     x.send();   
	}
	
	function getcategoryconfig(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var res= x.responseText;
			 	if(res==0){
			 		$("#categorybutton").attr('type',"button");
				}
			}
		       else
			  {}
	     }
	     x.open("GET",'categoryconfig.jsp',true);
	     x.send();   
	}
</script>

</head>
<body onload="gethsnconfig(); getsubcategoryconfig(); getcategoryconfig();">
	<div id="mainBG" class="homeContent" data-type="background">
		<div id="header">
			<h3>Product Related Master</h3>

		</div>

		<div id="nav">
			<table>
				<tr>
					<td><input type="button" name="btntype" class="myButton"
						value="Tax Type" style="width: 90px; outline: none;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/typeMaster.jsp";'></td>
				</tr>
				<tr>
					<td><input type="button" name="btnbrand" class="myButton"
						value="Brand" style="width: 90px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/brand.jsp";'></td>
				</tr>
				<tr>
					<td><input type="hidden" name="btncategory" class="myButton" id="categorybutton"
						value="Category" style="width: 90px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/Category.jsp";'></td>
				</tr>
				<tr>
					<td><input type="hidden" name="btnscategory" class="myButton" id="subcategorybutton"
						value="Subcategory" style="width: 90px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/SubCategory.jsp";'></td>
				</tr>
				<tr>
					<td><input type="button" name="btndept" class="myButton"
						value="Department" style="width: 90px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/deptMaster.jsp";'></td>
				</tr>
				<tr>
					<td><input type="button" name="btnunit" class="myButton"
						value="Unit" style="width: 90px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/unit.jsp";'></td>
				</tr>
				<tr>
					<td><input type="hidden" name="btnsubfamily" id="hsnbutton" class="myButton"
						value="HSNCode" style="width: 90px;"
						onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/settings/productsettings/HSNCode.jsp";'></td>
				</tr>
			
			</table>
			<input type="hidden" id="formName" name="formName" value="000" /> <input
				type="hidden" id="formCode" name="formCode" value="COM" /> <input
				type="hidden" id="branchid" name="branchid" value='' /> 
				<input type="hidden" id="mode" name="mode"  />
				<input type="hidden" id="hsnid" name="hsnid" value='<s:property value="hsnid"/>'/>
		</div>
		<div id="comiframe">

			<iframe width="100%" height="100%" id="iframe2" align="right"
				frameborder="0" marginwidth="100%" scrolling="no"
				src="<%=contextPath%>/com/controlcentre/settings/productsettings/typeMaster.jsp"></iframe>
		</div>
		<script>
			function resizeIframeToFitContent(iframe) {
				// This function resizes an IFrame object
				// to fit its content.
				// The IFrame tag must have a unique ID attribute.
				iframe.height = document.frames[iframe.iframe2].document.body.scrollHeight;
			}
		</script>
	</div>
</body>
</html>