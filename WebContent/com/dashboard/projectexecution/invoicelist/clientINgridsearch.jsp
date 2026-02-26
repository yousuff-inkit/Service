 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
     <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

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
	 /* $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); */
	}); 

 	function loadSearch() {
 		//alert("");
 		var clnames=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var clname = clnames.replace(' ', '%20');
		
	//alert(""+clname);
		getdata(clname,mob);
 

	}
	function getdata(clname,mob){
		
		var id=1;
		$("#refreshdiv1").load('searchClient.jsp?clname='+clname+'&mob='+mob+'&id='+id);

		}

	</script>
<body style="background: transparent;">

<div id="search">

<table width="100%" cellpadding="8">

  <tr>
    <td>

      <table width="100%" cellpadding="6">

        <tr>

          <td width="12%" align="right">
            <label style="font:13px Tahoma; font-weight:600;">Name</label>
          </td>

          <td width="30%">
            <input type="text"
                   name="Cl_name"
                   id="Cl_name"
                   style="width:100%; height:24px;"
                   value='<s:property value="Cl_name"/>'>
          </td>

          <td width="12%" align="right">
            <label style="font:13px Tahoma; font-weight:600;">Mobile</label>
          </td>

          <td width="30%">
            <input type="text"
                   name="Cl_mob"
                   id="Cl_mob"
                   style="width:100%; height:24px;"
                   value='<s:property value="Cl_mob"/>'>
          </td>

          <td width="16%" align="center">
            <input type="button"
                   name="btnrasearch"
                   id="btnrasearch"
                   class="myButton"
                   value="Search"
                   onclick="loadSearch();">
          </td>

        </tr>

      </table>

    </td>
  </tr>

  <tr>
    <td>
      <div id="refreshdiv1">
        <jsp:include page="searchClient.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>

</div>

</body>
</html>