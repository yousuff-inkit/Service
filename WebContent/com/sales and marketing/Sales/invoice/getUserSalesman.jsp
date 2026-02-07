<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%        
 	Connection conn = null;
try{	
	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String userid= session.getAttribute("USERID").toString();

	String sal_id="0";
	String sal_name="";
	
	String strSql = "select doc_no,sal_name from my_salm where status=3 and userid="+userid;
	
	ResultSet rs = stmt.executeQuery(strSql);
	if(rs.next ()) {
		sal_id=rs.getString("doc_no");
		sal_name=rs.getString("sal_name");
	}
	
	stmt.close();
	conn.close();

	response.getWriter().print(sal_id+"#"+sal_name);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally {
	conn.close();
}
%>