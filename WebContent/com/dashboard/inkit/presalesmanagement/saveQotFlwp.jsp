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
		System.out.println("docno=="+docno);
		String enqdocno=request.getParameter("enqdocno");
		String rdtype=request.getParameter("rdtype");
		String remarks=request.getParameter("remarks");
		System.out.println("remarks=="+remarks);
		String fdocno=request.getParameter("fdocno");
		String drftdocno=request.getParameter("drftdocno");
		System.out.println("drftdocno=="+drftdocno);
		String fstatus=request.getParameter("fstatus");
		String ddocno=request.getParameter("ddocno");
	
		String dstatus=request.getParameter("dstatus");
		String cldocno=request.getParameter("client");
		System.out.println("cldocno=="+cldocno);
		String userid=session.getAttribute("USERID").toString();
		System.out.println("userid=="+userid);
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

	    
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		 if(proname.equalsIgnoreCase("Follow-Up"))
		{
			 sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,fstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+","+fdocno+")";
			 System.out.println("followup=="+sql);
			 val= stmt.executeUpdate(sql);
				String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+enqdocno+",'Follow-Up Done')";
				int aaa= stmt.executeUpdate(upsql);
			 if(val>0)
			 {
				 temp="1";
			 }
		}
		 
		 if(proname.equalsIgnoreCase("Dropped"))
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
				 String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+enqdocno+",'Dropped Document')";
					int aaa= stmt.executeUpdate(upsql);
		    	}
		    	if(val>0)
				 {
					 temp="1";
				 }
			}
		
		if(proname.equalsIgnoreCase("Declined"))
		{
			sqlsub="update cm_srvqotm set quotstatus=1  where tr_no="+docno+" ";
			System.out.println("==cm_srvqotmDeclined===="+sqlsub);
			int data= stmt.executeUpdate(sqlsub);
			if(data>0){
			sql1="update gl_bqot set status=7 where  rdocno="+docno+" ";
		      System.out.println("==Declined===="+sql1);
			int dat= stmt.executeUpdate(sql1);
			 String upsql="insert into my_presaleslog (type,brhId, logdate, userid, rdocno,description) values ('Process','"+session.getAttribute("BRANCHID").toString()+"',now(),'"+session.getAttribute("USERID").toString()+"',"+enqdocno+",'Declined Document')";
				int aaa= stmt.executeUpdate(upsql);
			 sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, bibpid, brhid, userid,status,dstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+bibid+", "+branchid+", "+session.getAttribute("USERID").toString()+",7,"+ddocno+")";
			 System.out.println("==strSql1===="+sql);
			 val= stmt.executeUpdate(sql);
			
			  if(val>0)
			 {
				 temp="1";
				 String userName="",Password="",host="",port="";
				    Statement stmt1 = conn.createStatement();
				    String strSql1 = "select email,mailpass,smtpserver,smtphostport  FROM my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";
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
				     
						      EmailProcess ep=new EmailProcess();
				    //EmailUtility eut=new EmailUtility();
				   // System.out.println("==strSql1===="+host+"======"+port+"======"+userName+"======"+Password+"======"+recipient+"======"+subject+"======"+message);
				    //eut.sendEmail(host, port, userName, Password, recipient,"",subject, message, null,"");
				   
				   // ep.sendEmailNew(host, port, userName, Password,recipient, "","",subject, message,"");
			 }   
			} 
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
