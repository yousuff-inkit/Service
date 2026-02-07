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
		String jobdetno=request.getParameter("jobdetno");
		String saldocno=request.getParameter("saldocno").trim();
		String salname=request.getParameter("salname").trim();
		
		System.out.println("proname------"+proname+"===prdocno==="+prdocno+"===docno==="+docno);
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
			
			sqlsub="update gl_enqjobdet set  typupdt="+prdocno+" where doc_no="+jobdetno+" and enq_id="+docno+" ";
			//sqlsub="update gl_enqm set enqstatus=1 , survdatetime=now(),draftid="+drftdocno+" where doc_no="+docno+" ";
			System.out.println("sqlsub--gl_enqjobdet----"+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			/* String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Priority','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'Priority Updated')";
			int aaa= stmt.executeUpdate(upsql);*/
			 if(data>0)
			 {
				 temp="1";
			 } 
		}
		if(proname.equalsIgnoreCase("statu"))
		{
			
			sqlsub="update gl_enqjobdet set  statupdt="+saldocno+" where doc_no="+jobdetno+" and enq_id="+docno+" ";
			//sqlsub="update gl_enqm set enqstatus=1 , survdatetime=now(),draftid="+drftdocno+" where doc_no="+docno+" ";
			System.out.println("sqlsub---gl_enqjobdet---"+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			/* String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Salesman Assignment','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'Salesman Updated')";
			int aaa= stmt.executeUpdate(upsql); */
			 if(data>0)
			 {
				 temp="1";
			 }
		}
		
		if(proname.equalsIgnoreCase("emp"))
		{
			sqlsub="update gl_enqjobdet set empid="+saldocno+" where doc_no="+jobdetno+" and enq_id="+docno+" ";
			
			int data= stmt.executeUpdate(sqlsub);
			 if(data>0)
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
