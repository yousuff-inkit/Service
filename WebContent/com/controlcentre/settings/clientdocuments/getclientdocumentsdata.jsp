<%@page import="com.controlcentre.settings.clientdocuments.ClsClientdocumentsDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%
JSONArray data=new JSONArray();

try{
	ClsClientdocumentsDAO DAO= new ClsClientdocumentsDAO();
	data=DAO.searchDetails();	
}
catch(Exception e){
	e.printStackTrace();
}
response.getWriter().write(data+"");
%>