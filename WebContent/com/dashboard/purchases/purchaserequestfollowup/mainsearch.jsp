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
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		   /* Date */ 	
	    $("#datess1").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var refnoss=document.getElementById("refnoss").value;
 	 
 		var datess=document.getElementById("datess1").value;
  
 		
 	 
 		var descriptionss=document.getElementById("descriptionss").value.replace(/ +(?= )/g,'');
		
	var aa="yes";
		getdata(docnoss,datess,aa,descriptionss,refnoss);
 

	}
	function getdata(docnoss,datess,aa,descriptionss,refnoss){
		
		 $("#refreshdivs").load('Subsearch.jsp?docnoss='+docnoss+'&datess='+datess+'&aa='+aa+'&descriptions='+descriptionss+'&refnoss='+refnoss);

		}

	</script>
<body bgcolor="#E0ECF8">

<div id="search">

<table width="100%" cellspacing="10">

  <!-- ROW 1 -->
  <tr>
    <td width="10%" align="right" class="label">Doc No</td>
    <td width="20%">
      <input type="text"
             name="docnoss"
             id="docnoss"
             value='<s:property value="docnoss"/>'
             style="width:100%;">
    </td>

    <td width="10%" align="right" class="label">Ref No</td>
    <td width="20%">
      <input type="text"
             name="refnoss"
             id="refnoss"
             value='<s:property value="refnoss"/>'
             style="width:100%;">
    </td>

    <td width="8%" align="right" class="label">Date</td>
    <td width="18%">
      <div id="datess1"
           name="datess1"
           value='<s:property value="datess1"/>'>
      </div>
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td align="right" class="label">Description</td>
    <td colspan="3">
      <input type="text"
             name="descriptionss"
             id="descriptionss"
             value='<s:property value="descriptionss"/>'
             style="width:100%;">
    </td>

    <td colspan="2" align="center">
      <input type="button"
             name="searchs"
             id="searchs"
             class="blueButton"
             value="Search"
             onclick="loadSearchs()">
    </td>
  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="6">
      <div id="refreshdivs">
        <jsp:include page="Subsearch.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>

</div>

</body>
</html>