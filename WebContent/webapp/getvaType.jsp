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
	String strSql = "select vattype from my_vattype order by typeid";
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println(strSql);
	String brand="";
	String brandid="";
	while(rs.next()) {
		brand+=rs.getString("vattype")+",";		
		brandid+=rs.getString("vattype")+",";
  		} 
	if(brand.length()>0){
		brand=brand.substring(0, brand.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(brand+"###"+brandid);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
  
