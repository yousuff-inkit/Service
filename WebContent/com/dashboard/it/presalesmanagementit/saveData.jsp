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
		
		String proname=request.getParameter("proname").trim();
		String prdocno=request.getParameter("prdocno").trim();
		String prname=request.getParameter("prname").trim();
		String docno=request.getParameter("docno");
		String saldocno=request.getParameter("saldocno").trim();
		String salname=request.getParameter("salname").trim();
		
		//System.out.println("proname------"+proname+"===prdocno==="+prdocno+"===docno==="+docno);
		//java.sql.Date sqlDate=null;

	    /* if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		} */

	    
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		
		if(proname.equalsIgnoreCase("priority"))
		{
			sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, brhid, userid) values( now(), "+docno+", 'ENQ', now(), 'enqflwp', "+session.getAttribute("BRANCHID").toString()+", "+session.getAttribute("USERID").toString()+")";      
			// System.out.println("followup=="+sql);
			 val= stmt.executeUpdate(sql);
			sqlsub="update gl_enqm set  priority="+prdocno+" where doc_no="+docno+" ";
			//sqlsub="update gl_enqm set enqstatus=1 , survdatetime=now(),draftid="+drftdocno+" where doc_no="+docno+" ";
			//System.out.println("sqlsub--priority----"+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Priority','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'Priority Updated')";
			int aaa= stmt.executeUpdate(upsql);
			 if(data>0)
			 {
				 temp="1";
			 }
		}
		if(proname.equalsIgnoreCase("assignsalman"))
		{
			
			sqlsub="update gl_enqm set  sal_id="+saldocno+",sal_name='"+salname+"' where doc_no="+docno+" ";
			//sqlsub="update gl_enqm set enqstatus=1 , survdatetime=now(),draftid="+drftdocno+" where doc_no="+docno+" ";
			//System.out.println("sqlsub---assignsalman---"+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Salesman Assignment','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'Salesman Updated')";
			int aaa= stmt.executeUpdate(upsql);
			 if(data>0)
			 {
				 temp="1";
			 }
		}
		if(proname.equalsIgnoreCase("confirm"))
		{
			
			sqlsub="update gl_enqm set  confirm=1 where doc_no="+docno+" ";
			//sqlsub="update gl_enqm set enqstatus=1 , survdatetime=now(),draftid="+drftdocno+" where doc_no="+docno+" ";
			//System.out.println("sqlsub---confirm---"+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Confirm','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'Document Confirmed')";
			int aaa= stmt.executeUpdate(upsql);
			 if(data>0)
			 {
				 temp="1";
			 }
		}
		
		if(proname.equalsIgnoreCase("proceed"))
		{
			
			sqlsub="update gl_enqm set  prcdcreate=1 where doc_no="+docno+" ";
			//sqlsub="update gl_enqm set enqstatus=1 , survdatetime=now(),draftid="+drftdocno+" where doc_no="+docno+" ";
			//System.out.println("sqlsub---proceed---"+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Proceed to Create ','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'Document Confirmed')";
			int aaa= stmt.executeUpdate(upsql);
			 if(data>0)
			 {
				 temp="1";
			 }
		}
		
		if(proname.equalsIgnoreCase("Quotation"))
		{
			
			
			String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Quotation','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'Quotation Created')";
			int aaa= stmt.executeUpdate(upsql);
			 if(aaa>0)
			 {
				 temp="1";
			 }
		}
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
