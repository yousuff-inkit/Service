<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

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

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var employeeName=document.getElementById("txtpartyname").value;
 		var empId=document.getElementById("txtpartyid").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		
		getdata(employeeName,empId,contactNo);
	}
	function getdata(employeeName,empId,contactNo){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename='+employeeName.replace(/ /g, "%20")+'&empid='+empId+'&contactno='+contactNo);
		}

	</script>
<body>

<div id="search">

<table width="100%" cellspacing="8">

  <!-- Row 1 -->
  <tr>
    <td width="12%" align="right" class="label">Name</td>
    <td width="60%">
      <input type="text"
             name="txtpartyname"
             id="txtpartyname"
             value='<s:property value="txtpartyname"/>'
             style="width:100%;">
    </td>
    <td width="18%" align="center">
      <input type="button"
             name="btnsearch"
             id="btnsearch"
             class="blueButton"
             value="Search"
             onclick="loadSearch();">
    </td>
  </tr>

  <!-- Row 2 -->
  <tr>
    <td align="right" class="label">ID#</td>
    <td width="30%">
      <input type="text"
             name="txtpartyid"
             id="txtpartyid"
             value='<s:property value="txtpartyid"/>'
             style="width:100%;">
    </td>

    <td align="right" class="label">Contact No.</td>
    <td width="30%">
      <input type="text"
             name="txtcontactno"
             id="txtcontactno"
             value='<s:property value="txtcontactno"/>'
             style="width:100%;">
    </td>
  </tr>

  <!-- Grid -->
  <tr>
    <td colspan="4">
      <div id="refreshdiv">
        <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>

</div>

</body>
</html>