<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
		 
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();


	try{
		
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
	int val=0;
	
		String sql="select coalesce(method,0) method from gl_config where field_nme='category'";
		System.out.println("config-====="+sql);
		ResultSet rsconfg = stmt.executeQuery(sql);
		
		while (rsconfg.next()) {
			val=rsconfg.getInt("method");
			System.out.println("val=="+val);
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
  