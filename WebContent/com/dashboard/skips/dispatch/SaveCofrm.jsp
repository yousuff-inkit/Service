<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String cnttrno=request.getParameter("cnttrno")=="" || request.getParameter("cnttrno")==null?"0":request.getParameter("cnttrno");
ClsConnection objconn=new ClsConnection();  
Connection conn=null;
String msg="";
int temp=0;
int insertval=0;
try{
	conn=objconn.getMyConnection();
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	String strsql="update in_underwriterm set confirm=1 where cnttrno='"+cnttrno+"'";  
	insertval=stmt.executeUpdate(strsql);
	/* String strsql2="update in_opaccount set confirm=1 where cnttrno='"+cnttrno+"'";  
	insertval=stmt.executeUpdate(strsql2);     
 */	response.getWriter().print(insertval);    
}   
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>