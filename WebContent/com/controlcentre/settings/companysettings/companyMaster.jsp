<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
.company-container {
    display: flex;
    gap: 20px;
    height: calc(100vh - 140px);
}


.company-sidebar {
    width: 220px;
    display: flex;
    flex-direction: column;
    gap: 8px;
}
.company-nav-btn {
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

.company-nav-btn:hover {
    background: #e2e8f0;
}

.company-nav-btn.active {
    background: #1e88e5;
    color: #ffffff;
}

.company-content {
    flex: 1;
    background: #ffffff;
    border-radius: 12px;
    overflow: hidden;
}

.company-content iframe {
    width: 100%;
    height: 100%;
    border: none;
}
</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
	});
	</script>
</head>
<body>

<div id="mainBG" class="homeContent" data-type="background">

<div class="page-title">Company Master</div>

<div class="company-container">

   
    <div class="company-sidebar">

        <button class="company-nav-btn active"
            onclick='loadPage(this, "<%=contextPath%>/com/controlcentre/settings/companysettings/company.jsp")'>
            Company
        </button>

        <button class="company-nav-btn"
            onclick='loadPage(this, "<%=contextPath%>/com/controlcentre/settings/companysettings/branch.jsp")'>
            Branch
        </button>

        <button class="company-nav-btn"
            onclick='loadPage(this, "<%=contextPath%>/com/controlcentre/settings/companysettings/location.jsp")'>
            Location
        </button>

        <button class="company-nav-btn"
            onclick='loadPage(this, "<%=contextPath%>/com/controlcentre/settings/companysettings/currency.jsp")'>
            Currency
        </button>

        <button class="company-nav-btn"
            onclick='loadPage(this, "<%=contextPath%>/com/controlcentre/settings/companysettings/province1.jsp")'>
            Province
        </button>

        <input type="hidden" id="formName" name="formName" value="000"/>
        <input type="hidden" id="formCode" name="formCode" value="COM"/>
        <input type="hidden" id="branchid" name="branchid" value=""/>
        <input type="hidden" id="mode" name="mode"/>

    </div>

 
    <div class="company-content">
        <iframe id="iframe2"
                src="<%=contextPath%>/com/controlcentre/settings/companysettings/company.jsp"
                frameborder="0">
        </iframe>
    </div>

</div>

</div>

<script>
function loadPage(button, url) {
    document.getElementById("iframe2").src = url;

    const buttons = document.querySelectorAll('.company-nav-btn');
    buttons.forEach(btn => btn.classList.remove('active'));
    button.classList.add('active');
}

$(document).ready(function() {
    $('#branchid').val(window.parent.branchid.value);
});
</script>

</body>
</html>