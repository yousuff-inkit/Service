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

</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#cpdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function cpsearchload() {
 		
 		var cpdate=document.getElementById("cpdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var salmanss=document.getElementById("salman").value;
 		
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		var salman = salmanss.replace(' ', '%20');
	getdata1(Cl_names,msdocno,salman,cpdate);
 

	}
	function getdata1(Cl_names,msdocno,salman,cpdate){
		

		
		 $("#cpsearchdiv").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&salman='+salman+'&cpdate='+cpdate+'&id='+1);
		
		}

	</script>
<style>
/*=========================================================
                MASTER SEARCH UI
=========================================================*/

html,
body{
    margin:0;
    padding:0;
    background:#ffffff !important;
    font-family:'Segoe UI',Tahoma,Verdana,sans-serif;
}

#search{
    background:#ffffff !important;
    padding:10px;
}

#search table{
    width:100%;
    border-collapse:collapse;
}

#search td{
    padding:5px 6px;
    vertical-align:middle;
}

#search td[align="right"]{
    font-size:12px;
    font-weight:500;
    color:#333;
    white-space:nowrap;
}

#search input[type="text"]{
    height:26px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    background:#ffffff;
    font-family:'Segoe UI',Tahoma,Verdana,sans-serif;
    font-size:12px;
}

#search input[type="text"]:focus{
    outline:none;
    border-color:#2563eb;
}

/* EXACT MASTER UI BUTTON */
.myButton,
.btn{
    height:24px !important;
    line-height:22px !important;
    padding:0 12px;
    font-family:Arial,sans-serif;
    font-size:11px;
    font-weight:bold;
    border-radius:3px;
    cursor:pointer;
    text-shadow:none;
    transition:all 0.2s;
    box-shadow:0 1px 2px rgba(0,0,0,0.1);
    border:none;
    background:linear-gradient(135deg,#0b45a2 0%,#2563eb 100%);
    color:#ffffff;
    white-space:nowrap;
    display:inline-block;
    box-sizing:border-box;
}

/* Grid */
#cpsearchdiv{
    background:#ffffff;
    border:1px solid #cccccc;
    border-radius:4px;
    overflow:hidden;
}
</style>

<body>

<div id="search">

    <!-- Keep your existing outer table structure exactly as it is -->

    <table width="100%">

        <!-- Your existing rows stay here -->

        <tr>

            <td align="right">
                salesman
            </td>

            <td colspan="2">
                <input type="text"
                       name="salman"
                       id="salman"
                       style="width:80%;"
                       value='<s:property value="salman"/>'>
            </td>

        </tr>

        <!-- Your existing table closing structure -->
        </table>

    </td>

    <tr>
        <td colspan="8">

            <div id="cpsearchdiv">

                <jsp:include page="subMastersearch.jsp"></jsp:include>

            </div>

        </td>
    </tr>

</table>

</div>


</body>
</html>