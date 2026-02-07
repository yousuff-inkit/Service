<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection conobj= new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();
		String catid=request.getParameter("catid").equalsIgnoreCase("")?"0":request.getParameter("catid");

		String strSql = "SELECT subcategory,doc_no FROM my_clsubcatm where status<>7 and catid="+catid;
		 //System.out.println("strsql1====="+strSql);

		ResultSet rs = stmt.executeQuery(strSql);
		String category1="";
		String categoryid1="";
		while(rs.next()) {
			category1+=rs.getString("subcategory")+",";		
			categoryid1+=rs.getString("doc_no")+",";
	  		} 
		
		category1=category1.substring(0, category1.length()>0?category1.length()-1:0);
		
		response.getWriter().write(category1+"####"+categoryid1);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
