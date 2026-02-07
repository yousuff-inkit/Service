<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String masterdoc=request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc");
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String strSql = "select doc_no from gl_enqm where doc_no='"+masterdoc+"' and draftid!=0";
	//System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
    
	if(rs.next()) {
		val=1;
  		} 
	String strSql2 = "select doc_no from gl_enqm where doc_no='"+masterdoc+"' and enqstatus!=0";
	//System.out.println("---strSql--"+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);
    
	if(rs2.next()) { 
		val=1;
  		} 
	stmt.close();
	conn.close();  

	response.getWriter().print(val);      
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>