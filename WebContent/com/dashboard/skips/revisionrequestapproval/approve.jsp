<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>  
<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	ClsCommon cmn = new ClsCommon();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
		String status=request.getParameter("status")==null?"1":request.getParameter("status");
		String brhid=request.getParameter("brhid")==null?"1":request.getParameter("brhid");
		String reason=request.getParameter("reason")==null?"":request.getParameter("reason");
		String aprdate=request.getParameter("aprdate")==null?"":request.getParameter("aprdate");    

		java.sql.Date sqldate=null; 
		String sql="",sqlsub="",sql1=""; 
		String temp="";
		int val=0,val1=0;
		
		if(aprdate!=null && !aprdate.equals("")){   
			sqldate = cmn.changeStringtoSqlDate(aprdate);   
		}
		sql="update sk_srvcontrrenew set status = '"+status+"', reason = '"+reason+"', apprdate  = '"+sqldate+"' where doc_no = '"+docno+"'";           
		// System.out.println("update=="+sql);  
		val= stmt.executeUpdate(sql);
		if(status.equalsIgnoreCase("1"))
		{
		  String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY,remarks) values ('"+docno+"','"+brhid+"','RRA',now(),'"+session.getAttribute("USERID").toString()+"','E','Approved')";  
			 // System.out.println("logsql--->>>"+logsql);    
			 stmt.executeUpdate(logsql); 
		}
		if(status.equalsIgnoreCase("2"))
		{
		  String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY,remarks) values ('"+docno+"','"+brhid+"','RRA',now(),'"+session.getAttribute("USERID").toString()+"','E','Rejected')";  
			 // System.out.println("logsql--->>>"+logsql);    
			 stmt.executeUpdate(logsql); 
		}
		response.getWriter().print(val);  
 	    stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
   }finally{
	   conn.close();   
   }
%> 