<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();  

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String salsql="select doc_no,sal_name from my_salm where  status<>7 ";
		ResultSet rs = stmt.executeQuery(salsql);
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("sal_name")+",";  
					sr+=rs.getString("doc_no")+",";
		} 
		if(!pro.equalsIgnoreCase("")){  
			String procc[]=pro.split(",");
			String brnId[]=sr.split(",");
			
			pro=pro.substring(0, pro.length()-1);
			sr=sr.substring(0, sr.length()-1);
		}  
		response.getWriter().write(sr+"####"+pro);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  