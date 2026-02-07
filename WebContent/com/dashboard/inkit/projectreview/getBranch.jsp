
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();


    String menubrch=request.getParameter("menubranch");
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
	    String strSql = "select branchname, doc_no from my_brch where status<>7" ;
		//System.out.println("sql ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",brnchId="";
		while(rs.next()) {
					brnch+=rs.getString("branchname")+",";
					brnchId+=rs.getString("doc_no")+",";
	  		} 
	
		String brn[]=brnch.split(",");
		String brnId[]=brnchId.split(",");
		
		brnch=brnch.substring(0, brnch.length()-1);
		brnchId=brnchId.substring(0, brnchId.length()-1);
		
		
		response.getWriter().print(brnchId+"####"+brnch);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>