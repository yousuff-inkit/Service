<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	/* String strSql = "select brand,doc_no from my_brand where status<>7"; */
String strSql = "select c.doc_no,c.privillege from  in_privillege c where status=3 ";
	
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String privillege="";
	String privillegeid="";
	while(rs.next()) {
		privillege+=rs.getString("privillege")+",";		
		privillegeid+=rs.getString("doc_no")+",";
  		} 
	if(privillege.length()>0){
		privillege=privillege.substring(0, privillege.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(privillege+"###"+privillegeid);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
  

