<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String comment=request.getParameter("comment")==null?"":request.getParameter("comment");
String enqno=request.getParameter("enqno")==null?"":request.getParameter("enqno");
String dtype=request.getParameter("dtype")==null?"":request.getParameter("dtype"); 
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	String strsql="insert into cr_comments(doc_no, dtype, userid, msgdate, msg, status)values("+enqno+",'"+dtype+"',"+userid+",now(),'"+comment+"',3)";  
	int insertval=stmt.executeUpdate(strsql);
	
	if(insertval>0){    
		conn.commit();
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>