<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String contextPath = request.getContextPath();
    String cmbtype = request.getParameter("cmbtype") == null 
                     ? "0" 
                     : request.getParameter("cmbtype");
%>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" 
      media="screen" 
      rel="stylesheet" 
      type="text/css" />

<style type="text/css">

#search {
    background-color: #ffffff;
    padding: 8px;
}

#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 15px 12px;
}

#search td[align="right"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
}

#search input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;
    padding: 6px 10px;
    height: 34px;
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #bdc3c7;
    border-radius: 4px;
    background-color: #ffffff;
}

#search input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

.blueButton {
    background: linear-gradient(to bottom, #2196F3, #1976D2);
    color: #ffffff;
    border: 1px solid #1565C0;
    padding: 6px 18px;
    font-size: 14px;
    font-weight: 600;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.blueButton:hover {
    background: linear-gradient(to bottom, #42A5F5, #1E88E5);
}

.blueButton:active {
    background: #1565C0;
    transform: scale(0.98);
}

</style>

<script type="text/javascript">

$(document).ready(function () {

    // If needed later
    var temp = "<%= cmbtype %>";
    console.log("cmbtype:", temp);

});

function loadAccountSearch() {

    var accountsno = document.getElementById("txtaccountsno").value;
    var accountsname = document.getElementById("txtaccountsname").value;
    var check = 1;

    getAccountDetails(accountsno, accountsname, check);
}

function getAccountDetails(accountsno, accountsname, check) {

    $("#refreshAccountDetailsDiv").load(
        "accountDetailsSearchGrid.jsp?accountno=" 
        + accountsno 
        + "&accountname=" 
        + accountsname.replace(/ /g, "%20") 
        + "&check=" 
        + check
    );
}

</script>

</head>

<body>

<div id="search">

<table width="100%" cellspacing="8">

<tr>
    <td width="12%" align="right">Account No</td>
    <td width="60%">
        <input type="text"
               name="txtaccountsno"
               id="txtaccountsno"
               value='<s:property value="txtaccountsno"/>'>
    </td>
    <td width="18%" align="center">
        <input type="button"
               name="btnAccountSearch"
               id="btnAccountSearch"
               class="blueButton"
               value="Search"
               onclick="loadAccountSearch();">
    </td>
</tr>

<tr>
    <td align="right">Account Name</td>
    <td colspan="2">
        <input type="text"
               name="txtaccountsname"
               id="txtaccountsname"
               value='<s:property value="txtaccountsname"/>'>
    </td>
</tr>

<tr>
    <td colspan="3">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

</table>

</div>

</body>
</html>
