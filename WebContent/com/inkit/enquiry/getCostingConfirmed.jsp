<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
	 	
		Statement stmt = conn.createStatement();

		String enquiryno=request.getParameter("enquiryno");
		int AlreadyExists=0;
		
		String strSql = "select * from is_costingm where status=3 and confirm>0 and enqno="+enquiryno+"";
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
			AlreadyExists=1;
		} 
	    
		response.getWriter().print(AlreadyExists);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  