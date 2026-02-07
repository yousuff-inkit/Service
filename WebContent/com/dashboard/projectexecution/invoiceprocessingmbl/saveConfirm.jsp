<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection();       
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String rowno=request.getParameter("rowno")==null || request.getParameter("rowno")==""?"0":request.getParameter("rowno").toString();   
		int val=0;
		
		String sql="update cm_srvcontrpd set confirm=1 where rowno="+rowno+"";  
		val = stmt.executeUpdate(sql);  
			 
		 response.getWriter().print(val);  
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
