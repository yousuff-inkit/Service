<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();    

	Connection conn = null;
	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno")==""?"0":request.getParameter("contrno").trim().toString();  
	String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString();   
	int val = 0;  
	 try{
		conn = ClsConnection.getMyConnection();  
		Statement stmt = conn.createStatement(); 
		
		String  strSql="select doc_no from sk_srvcontrrenew where cnttrno='"+contrno+"' and rsrno='"+srno+"' and status=0";    
		//System.out.println("===strSql===="+strSql);               
		ResultSet rs = stmt.executeQuery(strSql);
		if(rs.next()) {
					val = 1;
		} 
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
  