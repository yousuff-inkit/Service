<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String docno =request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
 //System.out.println("docno=="+docno);
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String strSql ="",process="SUR";
		
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		
		strSql = "update gl_enqm set enqstatus=1 where doc_no="+docno+" and status=3 ";      
		System.out.println("strSql=="+strSql); 
	    int rs = stmt.executeUpdate(strSql);   
		if(rs>0){       
			 String sqlassign="insert into gl_beqs(brhid, rdocno, process) values ('"+branchid+"','"+docno+"','"+process+"')";        
			 stmt.executeUpdate(sqlassign);   
			
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branchid+"','PSM',now(),'"+userid+"','E')";
			 rs= stmt.executeUpdate(sqls);
			 if(rs<=0){    
				 stmt.close();
				 conn.close();
			 }
		}
		response.getWriter().print(rs);    

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  