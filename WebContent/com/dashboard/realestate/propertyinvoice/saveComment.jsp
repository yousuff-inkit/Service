<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String comment=request.getParameter("comment")==null?"":request.getParameter("comment");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno");        
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();        
	Statement stmt=conn.createStatement();
	String strsql="insert into rl_comments(doc_no,pro_srno,dtype,userid,msgdate,msg) values('"+docno+"','"+srno+"','PMT',"+userid+",now(),'"+comment+"')";
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