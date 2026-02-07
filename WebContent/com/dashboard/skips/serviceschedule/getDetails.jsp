<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>   
<%@page import="com.connection.*" %>     
<%	
ClsConnection ClsConnection=new ClsConnection();  

	Connection conn = null;
	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
 	String slno=request.getParameter("slno")==null || request.getParameter("slno").trim()==""?"0":request.getParameter("slno").trim();
 	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();  
		String name="",mobile="",email="",location="";
		String strSql = "select coalesce(name,'') name, coalesce(mobile,'') mobile, coalesce(email,'') email, coalesce(location,'') location from sk_srvcontrdel where slno='"+slno+"' and rdocno='"+contrno+"' and srno='"+srno+"'";
		//System.out.println("strSql="+strSql);      
		ResultSet rs = stmt.executeQuery(strSql);  
		while(rs.next()) {
			name = rs.getString("name");  
			mobile = rs.getString("mobile");  
			email = rs.getString("email");  
			location = rs.getString("location");            
		} 
		response.getWriter().write(name+"####"+mobile+"####"+email+"####"+location+"####");            
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  