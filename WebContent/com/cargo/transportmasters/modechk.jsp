<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	String docno=request.getParameter("mode").toString();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		System.out.println("mode======"+docno);
		String strSql = "select coalesce(submode,0) as submode from cr_mode where  doc_no="+docno;
		ResultSet rs = stmt.executeQuery(strSql);
		
		String mode="",sr="",chk="";
		while(rs.next()) {
					
					chk=rs.getString("submode");
				} 
		
	
		response.getWriter().write(chk);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  