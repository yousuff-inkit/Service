 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function loadSearch() {

 		var productsname=document.getElementById("txtproductsname").value;
 		var brandsname=document.getElementById("txtbrandsname").value;
 		var cldocnos=document.getElementById("txtcldocnos").value;
 		var estdates=document.getElementById("txtestdates").value;
 		var gridprdname=document.getElementById("txtgridprdname").value;
 		var gridunit=document.getElementById("txtgridunit").value;
 		
		var id="1";
		getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit);
	}
	function getdata(productsname,brandsname,cldocnos,estdates,id,gridprdname,gridunit){
		 $("#refreshBrandDiv").load('brandSearch.jsp?productsname='+productsname.replace(/ /g, "%20")+'&brandsname='+brandsname.replace(/ /g, "%20")+'&cldocnos='+cldocnos+'&estdates='+estdates+"&id="+id+"&gridprdname="+gridprdname+"&gridunit="+gridunit);
		}

	</script>
<body>
<div id="search">

<table width="100%" cellspacing="8">

  <tr>
    <td width="12%" align="right" class="label">Product ID</td>
    <td width="28%">
      <input type="text"
             name="txtproductsname"
             id="txtproductsname"
             value='<s:property value="txtproductsname"/>'
             style="width:100%;">
    </td>

    <td width="10%" align="right" class="label">Brand</td>
    <td width="25%">
      <input type="text"
             name="txtbrandsname"
             id="txtbrandsname"
             value='<s:property value="txtbrandsname"/>'
             style="width:100%;">

      <input type="hidden"
             name="txtcldocnos"
             id="txtcldocnos"
             value='<s:property value="txtcldocnos"/>'>

      <input type="hidden"
             name="txtestdates"
             id="txtestdates"
             value='<s:property value="txtestdates"/>'>
    </td>

    <td width="15%" rowspan="2" align="center">
      <input type="button"
             name="btnsearch"
             id="btnsearch"
             class="blueButton"
             value="Search"
             onclick="loadSearch();">
    </td>
  </tr>

  <tr>
    <td align="right" class="label">Product Name</td>
    <td>
      <input type="text"
             name="txtgridprdname"
             id="txtgridprdname"
             value='<s:property value="txtgridprdname"/>'
             style="width:100%;">
    </td>

    <td align="right" class="label">Unit</td>
    <td>
      <input type="text"
             name="txtgridunit"
             id="txtgridunit"
             value='<s:property value="txtgridunit"/>'
             style="width:100%;">
    </td>
  </tr>

  <tr>
    <td colspan="5">
      <div id="refreshBrandDiv">
        <jsp:include page="brandSearch.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>

</div>
</body>
</html>