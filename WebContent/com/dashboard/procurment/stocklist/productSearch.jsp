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
<style>
 

</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		 
		   
	});   
		   
  	function loadSearchss() { // docnoss prdid prdname
 		
 		var docnoss=document.getElementById("docnoss").value;
 		 
 		var prdid=document.getElementById("prdid").value;
 		var prdname=document.getElementById("prdname").value;
 		
 		 

		
	var aa="yes";
		getdatas(docnoss,prdid,prdname,aa);
 

	}
	function getdatas(docnoss,prdid,prdname,aa){
		
		 
			 $("#refsearch").load('productssubsearch.jsp?docnoss='+docnoss+'&prdid='+prdid+'&prdname='+prdname+'&aa='+aa);
		

		}  
	
	
 
	

	</script>
<body bgcolor="#E0ECF8">

<div id="search">

<table width="100%" cellspacing="10">

  <!-- ROW -->
  <tr>

    <td width="10%" align="right" class="label">Product</td>
    <td width="25%">
      <input type="text"
             name="prdid"
             id="prdid"
             value='<s:property value="prdid"/>'
             style="width:100%;">
    </td>

    <td width="12%" align="right" class="label">Product Name</td>
    <td width="35%">
      <input type="text"
             name="prdname"
             id="prdname"
             value='<s:property value="prdname"/>'
             style="width:100%;">
    </td>

    <td width="18%" align="center">
      <input type="button"
             name="searchs"
             id="searchs"
             class="blueButton"
             value="Search"
             onclick="loadSearchss()">
    </td>

  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="5">
      <div id="refsearch">
        <jsp:include page="productssubsearch.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>

<!-- Hidden field -->
<input type="hidden"
       name="docnoss"
       id="docnoss"
       value='<s:property value="docnoss"/>'>

</div>

</body>
</html>