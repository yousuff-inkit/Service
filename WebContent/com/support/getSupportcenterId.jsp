<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%	
Connection conn =null;
Statement stmt =null;
ClsConnection ClsConnection=new ClsConnection();


try{
	String strSql ="",user="",userid="";
	
		 strSql ="select user_id as user,company,u.doc_no as userid from gw_userlist u inner join gw_complist c on(c.doc_no=u.comp_id) where c.comp_id='0000001'";	
	
	//System.out.println("===strSql===="+strSql);
 	 conn = ClsConnection.getMyConnection();
	 stmt = conn.createStatement ();
	ResultSet rs = stmt.executeQuery(strSql);
	
	while(rs.next()) {
		
			user=rs.getString("user");
			userid=rs.getString("userid");
	}
	

	
    response.getWriter().write(user+"####"+userid);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	stmt.close();
	conn.close();
}
   
	
	
  %>
  
