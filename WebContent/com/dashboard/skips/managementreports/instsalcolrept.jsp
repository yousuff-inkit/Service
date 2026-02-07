<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
 <%@ taglib prefix="s" uri="/struts-tags"%>
 <% String from =request.getParameter("from")==null?"0":request.getParameter("from").toString();
  String to=request.getParameter("to")==null?"0":request.getParameter("to").toString();
  String branch =request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
  String salesman=request.getParameter("salesman")==null?"0":request.getParameter("salesman").toString();
  ClsStatusDAO sd= new ClsStatusDAO(); 
 %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="text/javascript">

	
	var RESULTDATA9= '<%= sd.getInstSalColRept(from,to,request,branch,salesman) %>';

 
    </script>
 </head>
 <body> 
 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
 <div  class="col-xs-12" id="ofrgrid">
		                       <div class="panel panel-default panel-contracts table-responsive m-t-15" style="max-height:370px;overflow:auto;">
  								<table class="table table-hover tbloffer" id="tbloffer" >       
  									<thead>     
  <tr>
    <th width="5%" align="left">Sr No</th>
   <!--  <th  width="20%"align="left">Branch</th> -->
    <th  width="15%"align="left">Category</th>
    <td  width="10%"align="right"><strong>Value</strong></td>
   
  </tr>
  </thead>
  <s:iterator var="stat" value='#request.instsalcoldetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr> 
</s:iterator> 
 
</table>
</div>
</div>
</div>
 <br><br>
   <!-- <div class="row" align="center" >
 
<div id="jqxInstSalGrid" style="margin-left: 20px;display:none"></div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxInstSAlChart' style="margin-top: 1px; width: 500px; height: 300px; position: relative;">
    </div></div>

 </div> -->
 
 
</body>
</html>