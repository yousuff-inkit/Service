 <%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
</head>
<body bgcolor="#E0ECF8">
	<div id=search>
    	<div id="srefreshdiv">
   			<jsp:include  page="classificationSetupSearchGrid.jsp"></jsp:include> 
   		</div>
  	</div>
</body>
</html>