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
	 	Statement stmt = conn.createStatement();  
		String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();  
		System.out.println("docno--->>>"+docno+"===brhid==="+brhid);      
	    
		String sql="",sqlsub="",sql1="";  
		String temp="";
		int val=0;
		 /*Submit */
			 String upsql1="update gl_enqm m left join sk_srvqotm qm on qm.refdocno=m.doc_no and qm.refdtype='ENQ' set m.presalesstatus=5 where qm.doc_no='"+docno+"' and qm.brhid='"+brhid+"'";                
				 //System.out.println("upsql1--->>>"+upsql1);
				 val= stmt.executeUpdate(upsql1);  
			 if(val>0) { 
				 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','Quote Send',now())";
				 //System.out.println("logsql--->>>"+logsql);  
				 val= stmt.executeUpdate(logsql);        
			 }
			 if(val>0){
				 temp="1";  
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
