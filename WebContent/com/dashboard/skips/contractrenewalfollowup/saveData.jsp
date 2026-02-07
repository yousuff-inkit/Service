
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
<%@page import="com.email.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	  	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement(); 
	 	
	 	
	 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
	 	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();
	 	String rowno=request.getParameter("rowno")==null || request.getParameter("rowno").trim()==""?"0":request.getParameter("rowno").trim();
	 	
	 	String statusid=request.getParameter("statusid")==null || request.getParameter("statusid").trim()==""?"0":request.getParameter("statusid").trim();
	 	String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		System.out.println("process--->>>"+processid);               
	    
		String sql="",sqlsub="",sql1="";       
		String temp="";
		int val=0;
		java.sql.Date sqldate = null;
		java.sql.Date sqlholddate = null;
		java.sql.Date sqlrenewaldate = null;
		java.sql.Date sqlpodate = null;  
		
		
		 // Submit 
		if(processid.equalsIgnoreCase("Status Update")){           
	    	 String upsql="update sk_srvcontrm set renewalstatusid='"+statusid+"' where tr_no='"+contrno+"'"; 
	    	 //System.out.println("upsql--->>>"+upsql);      
			 val= stmt.executeUpdate(upsql);        
			 
			 if(val>0){
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CRF',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Status Updated')";
				// System.out.println("logsql--->>>"+logsql);          
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";    
			 }
	     }
		if(temp.equalsIgnoreCase("1")){     
			conn.commit();
		}
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
 
 System.out.println("inside save");
 }catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
