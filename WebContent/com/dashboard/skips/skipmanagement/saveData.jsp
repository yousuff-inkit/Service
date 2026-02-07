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
<%@page import="com.controlcentre.masters.dumpmaster.skipmaster.ClsSkipmasterDAO"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	 	ClsSkipmasterDAO DAO=new ClsSkipmasterDAO();  
	 	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();
	 	String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
		String skipsizeid=request.getParameter("skipsizeid")==null || request.getParameter("skipsizeid").trim()==""?"0":request.getParameter("skipsizeid").trim();  
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		String name=request.getParameter("name")==null || request.getParameter("name").trim()==""?"":request.getParameter("name").trim();
		String code=request.getParameter("code")==null || request.getParameter("code").trim()==""?"":request.getParameter("code").trim();
		System.out.println("process--->>>"+processid+"===docno==="+docno);        
	    
		String sql="",sqlsub="",sql1="";  
		String temp="";
		int val=0;
		java.sql.Date sqldate = null;
		 /*Submit */
	   if(processid.equalsIgnoreCase("Skip Master")){   
		     val=DAO.insert(code, name, skipsizeid, "A", session, "SKM");         
			 
			 if(val>0){     
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+val+"','"+session.getAttribute("BRANCHID").toString()+"','SKM',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else{}        
		 
		if(temp.equalsIgnoreCase("1")){  
			conn.commit();
		}
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
