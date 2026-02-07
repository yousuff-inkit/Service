<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../../../../css/myButton.css" rel="stylesheet" type="text/css"/>
<style>
#whole
{
width:100%;
}
#header
{
background-color: #E0ECF8;
color:black;
text-align:left;
height:7%;
width:3%
padding:0px;
}
#nav
{
   line-height:30px;
    background-color: #E0ECF8;
    height:90.5%;
    width:5%;
    float:left;
    position:absolute;
    
    
}

#comiframe
{
float:right;
width:98.5%;
height:98%;
color:#eeeeee;

}
</style>
<script type="text/javascript">
	
$(document).ready(function() 
	{
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
		
	});
	</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<h3>Dump Related Master</h3>


<div id="nav">
<table >
<tr><td><input type="button" name="btnskip" class="myButton" value="Skip Size" style="width:90px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/skip.jsp";'></td></tr>
 <tr><td><input type="button" name="btnwaste" class="myButton" value="Waste Type" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/waste.jsp";'></td></tr>
<tr><td><input type="button" name="btnskipmaster" class="myButton" value="Skip Master" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/skipmaster.jsp";'></td></tr>
<tr><td><input type="button" name="btndump" class="myButton" value="Dump Site" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/dump.jsp";'></td></tr>
<tr><td><input type="button" name="btnspec" class="myButton" value="Spec" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/spec.jsp";'></td></tr>
<tr><td><input type="button" name="btnroute" class="myButton" value="Route" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/route.jsp";'></td></tr>
<tr><td><input type="button" name="btngroup" class="myButton" value="Group" style="width:90px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/groups.jsp";'></td></tr>

</table>
</div>
 <input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='DMP'/> 
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/controlcentre/masters/dumpmaster/skip.jsp"></iframe>
</div>
<!-- <script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe2]
                    .document.body.scrollHeight;
}
</script> -->

</div>
</body>
</html>