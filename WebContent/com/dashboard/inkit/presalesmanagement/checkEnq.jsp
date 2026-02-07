<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String enq_id = request.getParameter("enq_id").trim();
	
 	Connection conn = null;
try{	

	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	int val=0;
	String strSql = "select doc_no from cm_staffcontrm ctr where ctr.refno="+enq_id+" and ctr.reftype='ENQ'";
	System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
    
	if(rs.next()) {
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