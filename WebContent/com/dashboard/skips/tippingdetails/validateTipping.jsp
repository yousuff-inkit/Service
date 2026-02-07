<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;
    int val=0,val1=0;
	try{
		 ClsConnection connDAO = new ClsConnection();     
		 conn = connDAO.getMyConnection();
		 Statement stmt = conn.createStatement();
	 	 String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno"); 
	 	 String dno=request.getParameter("dno")==null || request.getParameter("dno")==""?"0":request.getParameter("dno");
	 	
	 	 String strsql="select invno from sk_tippingdet where srno='"+srno+"'";   
	 	 ResultSet rs = stmt.executeQuery(strsql);  
	 	 while(rs.next()){
	 		 val=rs.getInt("invno");  
	 	 }
	 	 
	 	 String strsql1="select srno from sk_tippingdet where dno='"+dno+"' and srno!='"+srno+"'";   
	 	 ResultSet rs1 = stmt.executeQuery(strsql1);    
	 	 while(rs1.next()){
	 		 val1=rs1.getInt("srno");  
	 	 }
	 	 
		 response.getWriter().print(val+"####"+val1);          
	 	 conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
