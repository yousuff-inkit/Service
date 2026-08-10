 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>   

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>

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
	$(document).ready(function () {
 
	}); 

 	function invloadSearch1() {
 		
 
 		var Cl_namess=document.getElementById("Cl_names").value;
 		var contno=document.getElementById("contno").value;
 		var invtype=document.getElementById("invtype").value;
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		
	getdata1(Cl_names,contno,invtype);
 

	}
	function getdata1(Cl_names,contno,invtype){
		
		 $("#refreshdivmas").load('contractsubMastersearch.jsp?Cl_names='+Cl_names+'&contno='+contno+'&invtype='+invtype);
		
		}

	</script>
<body bgcolor="#E0ECF8">

<div id="search">

<table width="100%" cellspacing="10">

<tr>

  <td width="12%" align="right" class="label">Contract No</td>
  <td width="18%">
    <input type="text"
           name="contno"
           id="contno"
           value='<s:property value="contno"/>'
           style="width:100%;">
  </td>

  <td width="10%" align="right" class="label">Client</td>
  <td width="30%">
    <input type="text"
           name="Cl_names"
           id="Cl_names"
           value='<s:property value="Cl_names"/>'
           style="width:100%;">
  </td>

  <td width="12%" align="right" class="label">Contract Type</td>
  <td width="15%">
    <select name="invtype"
            id="invtype"
            style="width:100%;">
      <option value="">-- Select --</option>
      <option value="AMC">AMC</option>
      <option value="SJOB">SJOB</option>
    </select>
  </td>

  <td width="13%" align="center">
    <input type="button"
           name="invbtnrasearch"
           id="invbtnrasearch"
           class="blueButton"
           value="Search"
           onclick="invloadSearch1()">
  </td>

</tr>

<tr>
  <td colspan="7">
    <div id="refreshdivmas">
      <jsp:include page="contractsubMastersearch.jsp"></jsp:include>
    </div>
  </td>
</tr>

</table>

</div>

</body>
</html>