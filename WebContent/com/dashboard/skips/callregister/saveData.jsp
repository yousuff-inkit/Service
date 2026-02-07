<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;  
    String contrno=request.getParameter("contrno")==null || request.getParameter("contrno")==""?"0":request.getParameter("contrno");
    String date=request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");
    String time=request.getParameter("time")==null || request.getParameter("time")==""?"0":request.getParameter("time");
    String wastetype=request.getParameter("wastetype")==null || request.getParameter("wastetype")==""?"":request.getParameter("wastetype");
    String wasteid=request.getParameter("wasteid")==null || request.getParameter("wasteid")==""?"0":request.getParameter("wasteid");
    int val=0;  
	try{
		ClsConnection connDAO = new ClsConnection();       
		conn = connDAO.getMyConnection();
		ClsCommon cmn=new ClsCommon();
		Statement stmt = conn.createStatement(); 
		java.sql.Date sqldate = null;
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
	    	sqldate=cmn.changeStringtoSqlDate(date);   
	     } else{}
	    
		 String sql3="insert into sk_callregm(cnttrno, date, time, wastename, wasteid) values('"+contrno+"', '"+sqldate+"', '"+time+"', '"+wastetype+"', '"+wasteid+"')";      
		 //System.out.println("sql3--->>>"+sql3);    
		 val= stmt.executeUpdate(sql3);      
		
		response.getWriter().print(val);   
	 	conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
