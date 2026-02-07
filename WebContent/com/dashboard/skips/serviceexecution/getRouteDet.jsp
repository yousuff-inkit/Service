<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection();  
	Connection conn = null;
	 String routeid=request.getParameter("routeid")==null || request.getParameter("routeid")==""?"0":request.getParameter("routeid").trim().toString(); 
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql="select driverid, fleetno, helper from sk_route where doc_no='"+routeid+"'";
		//System.out.println("===routedet===="+strSql);            
		ResultSet rs = stmt.executeQuery(strSql);
		String helperid="0",driverid="0", fleetno="0";  
		while(rs.next()) {
			helperid=rs.getString("helper");
			driverid=rs.getString("driverid");
			fleetno=rs.getString("fleetno");    
		} 
		  
		response.getWriter().print(helperid+"####"+driverid+"####"+fleetno);  
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  