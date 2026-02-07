<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%

 	Connection conn = null;
	ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
String brchid=request.getParameter("brchid")==null?"0":request.getParameter("brchid").trim();
Statement stmt = conn.createStatement ();
	String strSql = "select loc_name,doc_no from my_locm where status<>7 and brhid="+brchid;
	ResultSet rs = stmt.executeQuery(strSql);
	String loc="";
	String id="";
	while(rs.next()) {
		loc+=rs.getString("loc_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	//System.out.println("Location:"+loc+"***"+id);
	if(loc.length()>0){
	loc=loc.substring(0, loc.length()-1);
	}
	
	if(id.length()>0){
		id=id.substring(0, id.length()-1);
		}
	stmt.close();
	conn.close();
	response.getWriter().write(loc+"####"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>