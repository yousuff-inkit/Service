<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="creditinvlogin.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>

<%ClsCreditInvLoginDAO DAO= new ClsCreditInvLoginDAO(); %>
<%
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
String catid=request.getParameter("catid")==null?"0":request.getParameter("catid");
String subcatid=request.getParameter("subcatid")==null?"0":request.getParameter("subcatid");
JSONArray RESULTDATA=DAO.productSearch(catid);
PrintWriter wrt = response.getWriter();
wrt.println(RESULTDATA);
%>
