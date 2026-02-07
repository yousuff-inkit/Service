<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>   
<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	Statement stmt = conn.createStatement();  
	 	String tipdetsrno=request.getParameter("tipdetsrno")==null || request.getParameter("tipdetsrno").trim()==""?"0":request.getParameter("tipdetsrno").trim();
	 	String dno=request.getParameter("dno")==null || request.getParameter("dno").trim()==""?"0":request.getParameter("dno").trim();
		int val=0;
		
		 
		String upsql1="update sk_tippingdet set dno='"+dno+"' where srno='"+tipdetsrno+"'";                         
		// System.out.println("upsql1--->>>"+upsql1);
		val= stmt.executeUpdate(upsql1);  
		 			
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
