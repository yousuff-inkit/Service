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
<%@page import="com.mailwithpdf.EmailProcess"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		
		String proname=request.getParameter("proname").trim();
		String bibid=request.getParameter("bibid").trim();
		String date=request.getParameter("date");
		String branchid=request.getParameter("branchid");
		String docno=request.getParameter("docno");
		//System.out.println("docno=="+docno);    
		String enqdocno=request.getParameter("enqdocno");
		String rdtype=request.getParameter("rdtype");
		String remarks=request.getParameter("remarks");
		//System.out.println("remarks=="+remarks);
		String fdocno=request.getParameter("fdocno");
		String drftdocno=request.getParameter("drftdocno");
		//System.out.println("drftdocno=="+drftdocno);
		String fstatus=request.getParameter("fstatus");
		String ddocno=request.getParameter("ddocno");
	
		String dstatus=request.getParameter("dstatus");
		String cldocno=request.getParameter("client");
		//System.out.println("cldocno=="+cldocno);
		String userid=session.getAttribute("USERID").toString();
		//System.out.println("userid=="+userid);
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

	    
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		 if(proname.equalsIgnoreCase("Follow-Up")){
			 sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,fstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+","+fdocno+")";
			 //System.out.println("followup=="+sql);
			 val= stmt.executeUpdate(sql);
			 if(val>0){
				 String logsql="insert into sk_presaleslog (doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+branchid+"','"+session.getAttribute("USERID").toString()+"','Follow-Up Done',now())";
				 val= stmt.executeUpdate(logsql);  
			 }  
		}
		 if(proname.equalsIgnoreCase("Dropped")){
				sql="update gl_bqot set status=7 where rdocno="+docno+" ";  
				//System.out.println("Dropped=="+sql);
				val= stmt.executeUpdate(sql);
		    	if(val>0){
			    	 sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7)";
					 val= stmt.executeUpdate(sql);
					 if(val>0){
						 String logsql="insert into sk_presaleslog (doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+branchid+"','"+session.getAttribute("USERID").toString()+"','Dropped Document',now())";  
						 val= stmt.executeUpdate(logsql);  
					 } 
		    	}
			}
		 if(proname.equalsIgnoreCase("Approve")){
				sqlsub="update sk_srvqotm set quotstatus=2  where tr_no="+docno+" ";  
				//System.out.println("==sk_srvqotmDeclined===="+sqlsub);
				val= stmt.executeUpdate(sqlsub);
				if(val>0){
					  sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",3)";
					  //System.out.println("==strSql1===="+sql);  
					  val= stmt.executeUpdate(sql);
					  if(val>0){
							 String logsql="insert into sk_presaleslog (doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+branchid+"','"+session.getAttribute("USERID").toString()+"','Approved Document',now())";      
							 val= stmt.executeUpdate(logsql);    
					   }  
				} 
		 }		  
		if(proname.equalsIgnoreCase("Declined")) { 
			sqlsub="update sk_srvqotm set quotstatus=1  where tr_no="+docno+" ";
			//System.out.println("==sk_srvqotmDeclined===="+sqlsub);
			val= stmt.executeUpdate(sqlsub);
			if(val>0){
			  sql1="update gl_bqot set status=7 where bibpid="+bibid+" and rdocno="+docno+" ";  
		      //System.out.println("==Declined===="+sql1);
		      val= stmt.executeUpdate(sql1);
			  sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status,dstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7,"+ddocno+")";
			  //System.out.println("==strSql1===="+sql);
			  val= stmt.executeUpdate(sql);
			  if(val>0){
					 String logsql="insert into sk_presaleslog (doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+branchid+"','"+session.getAttribute("USERID").toString()+"','Declined Document',now())";    
					 val= stmt.executeUpdate(logsql);    
			   }
			} 
		}  
		 if(val>0){  
			 conn.commit();
		 }
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
