<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/main.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" rel="stylesheet" type="text/css"/>

<jsp:include page="../../../includes.jsp"></jsp:include>

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


.fa-container {
    display: flex;
    gap: 20px;
    height: calc(100vh - 120px);
}

.fa-sidebar {
    width: 180px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.fa-sidebar .myButton {
    width: 100%;
}

.fa-content {
    flex: 1;
    background: #ffffff;
    border-radius: 12px;
    overflow: hidden;
}

.fa-content iframe {
    width: 100%;
    height: 100%;
    border: none;
}
/* ================= FIXED ASSET SIDEBAR NAV ================= */

.fa-sidebar {
    width: 200px;
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.fa-nav-btn {
    width: 100%;
    padding: 10px 14px;
    border-radius: 10px;
    border: none;
    background: #f1f3f6;
    color: #2d3748;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    text-align: left;
    transition: all 0.2s ease;
}

.fa-nav-btn:hover {
    background: #e2e8f0;
}

.fa-nav-btn.active {
    background: #1e88e5;
    color: #ffffff;
}
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
	});
	</script>
	<script>
function setActive(button) {
    const buttons = document.querySelectorAll('.fa-nav-btn');
    buttons.forEach(btn => btn.classList.remove('active'));
    button.classList.add('active');
}
</script>
</head>
<body>

<div id="mainBG" class="homeContent" data-type="background">

<h3 class="page-title">Fixed Asset Master</h3>

<div class="fa-container">

    <!-- LEFT SIDE NAVIGATION -->
    <div class="fa-sidebar">

    <button class="fa-nav-btn active"
        onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp"; setActive(this);'>
        Group Master
    </button>

    <button class="fa-nav-btn"
        onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/locationMaster.jsp"; setActive(this);'>
        Location Master
    </button>

</div>
    <!-- RIGHT CONTENT AREA -->
    <div class="fa-content">
        <iframe id="iframe2"
                frameborder="0"
                src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp">
        </iframe>
    </div>

</div>

<input type="hidden" id="formName" name="formName" value="000"/>
<input type="hidden" id="formCode" name="formCode" value="SAP"/>
<input type="hidden" id="branchid" name="branchid" value=""/>
<input type="hidden" id="mode" name="mode"/>

</div>

</body>
</html>