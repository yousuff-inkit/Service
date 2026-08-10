 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
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


#search .myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;

    background-color: #007bff;
    color: #ffffff;

    padding: 8px 20px;
    border: none;
    border-radius: 4px;

    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

#search .myButton:hover {
    background-color: #007bff;
}

/* Result grid spacing */
#refreshdiv {
    margin-top: 10px;
}
.search-popup {
    padding: 14px;
}


.search-form {
    width: 100%;
    border-spacing: 18px 12px;
}


.search-form .label {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
    text-align: right;
}


.search-form .field {
    width: 28%;
}


.search-form .action {
    text-align: center;
    width: 12%;
}

.search-grid {
    margin-top: 14px;
    border: 1px solid #dcdcdc;
    border-radius: 4px;
    background: #ffffff;
    padding: 6px;
}
.myButtons {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    background-color: #007bff;   /* BLUE */
    color: #ffffff;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}


.myButtons:hover {
    background-color: #007bff;
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
<%String cmbtype=request.getParameter("cmbtype")==null?"0":request.getParameter("cmbtype");


%>

<script type="text/javascript">


$(document).ready(function () {
	<%--  var temp='<%=cmbtype%>';
	document.getElementById("acctype1").value=='<%=request.getParameter("cmbtype")%>'; --%>
	
}); 



function loadAccountSearch() {
 
			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			 
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,check);
	}
		
	function getAccountDetails(accountsno,accountsname,check){
		 $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&check='+check);
	}

</script>
<body>

<div id="search">

<table width="100%" cellspacing="8">

  <!-- ROW 1 -->
  <tr>
    <td width="12%" align="right" class="label">Account No</td>
    <td width="55%">
      <input type="text"
             name="txtaccountsno"
             id="txtaccountsno"
             value='<s:property value="txtaccountsno"/>'
             style="width:100%;">
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

  <!-- ROW 2 -->
  <tr>
    <td align="right" class="label">Account Name</td>
    <td colspan="2">
      <input type="text"
             name="txtaccountsname"
             id="txtaccountsname"
             value='<s:property value="txtaccountsname"/>'
             style="width:100%;">
    </td>
  </tr>

  <!-- GRID -->
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