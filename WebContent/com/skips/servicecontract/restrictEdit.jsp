<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>  
<%
    String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno");    
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0;       
	
	String strSql2 = "select if(status in (10,9,6) ,1,0) status from sk_srvcontrm where tr_no='"+trno+"'";  // and revision_no!=0   

	//System.out.println("strSql2---->>>"+strSql2);  
	ResultSet rs2 = stmt.executeQuery(strSql2);           
	if(rs2.next()) {     
		val = rs2.getInt("status");         
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