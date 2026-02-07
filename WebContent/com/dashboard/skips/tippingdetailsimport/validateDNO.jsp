<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;
    int val=0;
	try{
		 ClsConnection connDAO = new ClsConnection();     
		 conn = connDAO.getMyConnection();
		 Statement stmt = conn.createStatement();
	 	 String dno=request.getParameter("dno")==null || request.getParameter("dno")==""?"0":request.getParameter("dno");
	 	
	 	 String strsql="select srno from sk_tippingdet where dno='"+dno+"'";
	 	 ResultSet rs = stmt.executeQuery(strsql);  
	 	 while(rs.next()){
	 		 val=rs.getInt("srno");
	 	 }
	 	 
		 response.getWriter().print(val);        
	 	 conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
