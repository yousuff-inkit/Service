<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
Connection conn = null;              
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;

	String strSql1 = "select * from sa_srvcontrd where rdocno="+docno+" and invtrno!=0";
	//System.out.println("---1 inv-"+strSql1);
	ResultSet rs1 = stmt.executeQuery(strSql1);

	if(rs1.next()) {  
		val=1;
	}
	
	String strSql2 = "select * from sa_srvcontrd where rdocno="+docno+" and invdate is not null";
	//System.out.println("---1 inv-"+strSql2);
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