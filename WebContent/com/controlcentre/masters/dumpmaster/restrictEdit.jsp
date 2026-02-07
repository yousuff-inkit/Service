<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>  
<%
    String driverid=request.getParameter("driver")==null || request.getParameter("driver")==""?"0":request.getParameter("driver"); 
    String vehicleid=request.getParameter("vehicle")==null || request.getParameter("vehicle")==""?"0":request.getParameter("vehicle"); 
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0;       
	
	String strSql2 = "select *from sk_trip where (driverdocno='"+driverid+"'or fleet_no='"+vehicleid+"')and din is null";  // and revision_no!=0   

	//System.out.println("strSql2---->>>"+strSql2);  
	ResultSet rs2 = stmt.executeQuery(strSql2);           
	 if(rs2.next()) {     
		val = 1;         
  	}  
	stmt.close();
	response.getWriter().print(val);              
}
catch(Exception e){
	e.printStackTrace();
}finally{
	conn.close();  
}
	%>