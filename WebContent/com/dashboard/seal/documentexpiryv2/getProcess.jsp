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
		
		String strSql = "select srno,process,rowno from gl_bibp where bibdid=190";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String pro="",srno="",rowno="";
		while(rs.next()) {
					pro+=rs.getString("process")+",";
					rowno+=rs.getString("rowno")+",";
					srno+=rs.getString("srno")+",";
				} 
		
		String procc[]=pro.split(",");
		String rownoId[]=rowno.split(",");
		String srnoId[]=srno.split(",");
		pro=pro.substring(0, pro.length()-1);
		rowno=rowno.substring(0, rowno.length()-1);
		srno=srno.substring(0, srno.length()-1);
		
		response.getWriter().write(srno+"####"+pro+"####"+rowno);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  