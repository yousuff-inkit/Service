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
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		String proname=request.getParameter("proname")==null?"":request.getParameter("proname").trim();
		String bibid=request.getParameter("bibid")==null?"":request.getParameter("bibid").trim();
		String date=request.getParameter("date")==null?"":request.getParameter("date").trim();
		String branchid=request.getParameter("branchid")==null?"":request.getParameter("branchid").trim();
		String docno=request.getParameter("docno")==null?"":request.getParameter("docno").trim();
		//System.out.println("docno=="+docno);
		String enqdocno=request.getParameter("enqdocno")==null?"":request.getParameter("enqdocno").trim();
		String rdtype=request.getParameter("rdtype")==null?"":request.getParameter("rdtype").trim();
		String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").trim();
		//System.out.println("remarks=="+remarks);
		String fdocno=request.getParameter("fdocno")==null?"":request.getParameter("fdocno").trim();
		String drftdocno=request.getParameter("drftdocno")==null?"":request.getParameter("drftdocno").trim();
		//System.out.println("drftdocno=="+drftdocno);
		String fstatus=request.getParameter("fstatus")==null?"":request.getParameter("fstatus").trim();
		String ddocno=request.getParameter("ddocno")==null?"":request.getParameter("ddocno").trim();
		String enqprocess=request.getParameter("enqprocess")==null?"":request.getParameter("enqprocess").trim();   
		String dstatus=request.getParameter("dstatus")==null?"":request.getParameter("dstatus").trim();
		String cldocno=request.getParameter("client")==null?"":request.getParameter("client").trim();
		String reason=request.getParameter("reason")==null || request.getParameter("reason")==""?"0":request.getParameter("reason").trim();
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
		 if(processid.equalsIgnoreCase("Quotation Followup")){
		 if(proname.equalsIgnoreCase("Follow-Up"))
		{
			 sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,fstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", '"+session.getAttribute("BRANCHID").toString()+"', "+session.getAttribute("USERID").toString()+","+fdocno+")";
			 //System.out.println("followup=="+sql);
			 val= stmt.executeUpdate(sql);
				String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+enqdocno+",'SQOT Follow-Up Done')";
				int aaa= stmt.executeUpdate(upsql);
			 if(val>0)
			 {
				 temp="1";
			 }
		}
		 
/* 		 if(proname.equalsIgnoreCase("Dropped"))
			{
				sql="update gl_bqot set status=7 where rdocno="+docno+" ";
				 System.out.println("Dropped=="+sql);
		    	int dat= stmt.executeUpdate(sql);
		   	 System.out.println("Dropped=dat="+dat);
		    	if(dat>0){
		    	 sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7)";
		    	 System.out.println("Dropped=gl_bqot="+sql);
		    	 val= stmt.executeUpdate(sql);
		    	 System.out.println("Dropped=gl_bqot="+val);
				 String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+enqdocno+",'SQOT Dropped Document')";
					int aaa= stmt.executeUpdate(upsql);
		    	}
		    	if(val>0)
				 {
					 temp="1";
				 }
			} */
		
		if(proname.equalsIgnoreCase("Dropped"))
		{
			sqlsub="update cm_srvqotm set quotstatus=1  where tr_no="+docno+" ";
			//System.out.println("==cm_srvqotmDeclined===="+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			if(data>0){
			sql1="update gl_bqot set status=7 where  rdocno="+docno+" ";
		     // System.out.println("==Declined===="+sql1);
			int dat= stmt.executeUpdate(sql1);
			 String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+enqdocno+",'SQOT Declined Document')";
				int aaa= stmt.executeUpdate(upsql);
			 sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status,dstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+",'"+session.getAttribute("BRANCHID").toString()+"', "+session.getAttribute("USERID").toString()+",7,"+ddocno+")";
			 //System.out.println("==strSql1===="+sql);
			 val= stmt.executeUpdate(sql);
			
		 	  if(val>0)
			 {
				 temp="1";
				 String userName="",Password="",host="",port="";
				    Statement stmt1 = conn.createStatement();
				    /* String strSql1 = "select email,mailpass,smtpserver,smtphostport  FROM my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";
				      System.out.println("==strSql1===="+strSql1);
				     ResultSet rs1 = stmt1.executeQuery(strSql1);
				     while(rs1.next ()) {
				       userName=rs1.getString("email");
				       Password=ClsEncrypt.getInstance().decrypt(rs1.getString("mailpass"));
					   host=rs1.getString("smtpserver");
					   port=rs1.getString("smtphostport");
				     }
				     String recipient="",subject="",message="";
				     Statement stmt2 = conn.createStatement();
				     String strSql2 = "select msg,subject,toemail from gl_emailmsg where dtype='bqot' and srno=5";
				     System.out.println("email=="+strSql2);
				     ResultSet rs2 = stmt2.executeQuery(strSql2);
				     while(rs2.next ()) {
				        message=rs2.getString("msg");
				        subject=rs2.getString("subject");
				        recipient=rs2.getString("toemail");
				     } 
				     message=message.replace("CLDOCVal",""+cldocno+"");
				     message=message.replace("decdocno",""+ddocno+"");
					 message=message.replace("qottrno",""+docno+"");
					 message=message.replace("useridd",""+userid+"");
					 message=message.replace("remarkss",""+remarks+"");
				 	System.out.println("message=="+message);
				 
				 ResultSet rs3 = stmt2.executeQuery(message);   
						      while(rs3.next ()) {
							        message=rs3.getString("msg");
							         
							      }
				     
						      EmailProcess ep=new EmailProcess();*/	
				    //EmailUtility eut=new EmailUtility();
				   // System.out.println("==strSql1===="+host+"======"+port+"======"+userName+"======"+Password+"======"+recipient+"======"+subject+"======"+message);
				    //eut.sendEmail(host, port, userName, Password, recipient,"",subject, message, null,"");
				   
				    //ep.sendEmailNew(host, port, userName, Password,recipient, "","",subject, message,"");
			 }    
			} 
		}
		 }
		
		if(processid.equalsIgnoreCase("Enquiry Followup")){
			/* java.sql.Date sqlDate=null;
		    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
			     sqlDate=ClsCommon.changeStringtoSqlDate(date);
			} */
			if(enqprocess.equalsIgnoreCase("2")){ 
				 String upsql1="update gl_enqm set dropped=1 where doc_no='"+docno+"'";             
				 //System.out.println("upsql1--->>>"+upsql1);   
				 val= stmt.executeUpdate(upsql1); 
				 
				sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, brhid, userid, dstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+session.getAttribute("BRANCHID").toString()+", "+session.getAttribute("USERID").toString()+", '"+reason+"')";    
				// System.out.println("drop=="+sql);
				 val= stmt.executeUpdate(sql);
				 if(val>0) { 
					 String logsql="insert into my_presaleslog(type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'ENQ Drop Done')";    
					 // System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);        
				 }
			}else{
				sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, brhid, userid) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+session.getAttribute("BRANCHID").toString()+", "+session.getAttribute("USERID").toString()+")";      
			//	 System.out.println("followup=="+sql);
				 val= stmt.executeUpdate(sql);
				 if(val>0) { 
					 String logsql="insert into my_presaleslog(type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+docno+",'ENQ Follow Up Done')";  
					 //System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);        
				 }
			}
			 
	     }
		if(val>0){
			 temp="1";    
		 }
		 if(temp.equalsIgnoreCase("1"))
		 {
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
