<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		//conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
		String verifyremarks=request.getParameter("verifyremarks")==null?"":request.getParameter("verifyremarks").trim();     
		String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();  
	    
		int val=0;  
	  
		String strsql="update sk_invm set verifyremarks='"+verifyremarks+"',verifyuser='"+session.getAttribute("USERID")+"' where doc_no='"+docno+"'";                     
		// System.out.println("strsql--->>>"+strsql);       
		val= stmt.executeUpdate(strsql);      
		 
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
