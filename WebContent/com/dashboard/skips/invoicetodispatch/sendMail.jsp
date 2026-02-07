<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%@page import="com.skips.invoice.ClsManualInvoiceAction"%>     
<%
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsManualInvoiceAction action=new ClsManualInvoiceAction();    
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String docno=request.getParameter("docno")==null || request.getParameter("docno").trim().equalsIgnoreCase("")?"0":request.getParameter("docno");
		String msgstr1="",type="",cldocno="0",email="",date="",msg="",skipsize="",insname="",brhid="",company="",subject="",vocno="",client="",fromdate="",todate="";                
		Statement stmt2 = conn.createStatement();
	
		String strSql2 = "select dd.type, date_format(m.fromdate,'%d-%m-%Y') fromdate, date_format(m.todate,'%d-%m-%Y') todate,ac.refname client,date_format(m.date,'%d-%M-%Y') date,m.brhid,m.doc_no,m.cldocno,coalesce(cm.email,'') email,(select company from my_comp) company,m.voc_no from sk_invm m left join sk_srvcontrm cm on cm.tr_no=m.cnttrno and m.reftype=cm.dtype left join my_acbook ac on (ac.cldocno=m.cldocno and ac.dtype='crm') left join (select group_concat(case when idno=1 then 'S' when idno=2 then 'T' else '' end) type,rdocno from sk_invd group by rdocno) dd on dd.rdocno = m.doc_no where m.doc_no='"+docno+"'";
		System.out.println("sql=="+strSql2);      
		ResultSet rs2 = stmt2.executeQuery(strSql2);        
		while(rs2.next ()) {
			  cldocno=rs2.getString("cldocno");
			  email=rs2.getString("email");
			  brhid=rs2.getString("brhid"); 
			  company=rs2.getString("company");   
			  date=rs2.getString("date");   
			  docno=rs2.getString("doc_no");  
			  vocno=rs2.getString("voc_no");  
			  client=rs2.getString("client");    
			  fromdate=rs2.getString("fromdate");
			  todate=rs2.getString("todate");
			  type=rs2.getString("type");  
		}
		String msgsql="";
		String strSql3 = "select emailcontent, subject from gl_emailmsg WHERE dtype='INVD'";
		//System.out.println("sql=="+strSql3);      
		ResultSet rs3 = stmt2.executeQuery(strSql3);        
		while(rs3.next ()) {
			msgsql = rs3.getString("emailcontent");
			subject = rs3.getString("subject");
		}
		if(!subject.equals("") && subject!=null){
			subject = subject.trim().replaceAll("<<vocno>>", vocno);  
		}
		msgsql = msgsql.trim().replaceAll("docno", docno);    
		ResultSet rs4 = stmt2.executeQuery(msgsql); 
		while(rs4.next()){
			msg = rs4.getString("msg");
		}
		
		if(type.contains("S") && type.contains("T")) {  
			msgstr1="Waste Collection and Tipping fees,"; 
		}else if(type.contains("S")) {
			msgstr1="Waste Collection"; 
		}else if(type.contains("T")) {  
			msgstr1="Tipping fees"; 
		}else {}  
		action.emailAction(docno,brhid);      
		  //String receiptdate=request.getParameter("receiptdate");   
		  //String docno=request.getParameter("docno");
		   String userid=session.getAttribute("USERID").toString();  
		   //subject="Dubai Municipality - ADF (Tipping FEE) Invoice No. "+vocno+" for MR SKIPS Waste Services for immediate payment release.";      
		          
			   /* msg="<html>"                
						+" <body>"
						+" <p>Dear Valued Customer <<client>>,</p>"    
						+" <p>Please adhere attached invoice of <<msgstr1>> due dates"   
					    +" for Waste collection invoice will remain as per expressed contract in place and please note tipping fee does not have any credit period will be paid with immediate effect.</p>" 
					    +" <p>You are also aware of newly implemented prepaid Dubai Municipality w.e.f 01.01.2022 on tipping and gate fees.</p>" 
					    +" <p>Payment can also be made by Bank Transfer/Cards with Following Details:</p>" 
						+" <p>BANK NAME : EMIRATES ISLAMIC BANK <br/>" 
						+"  ACCOUNT NAME : MRSKIPS WASTE SERVICES <br/>" 
						+"  A/C NO : 3708442833901 <br/>"  
						+"  IBAN NO : AE070340003708442833901 <br/>" 
						+"  BRANCH : Al Barsha Mall, Dubai, UAE <br/>"  
						+"  SWIFT CODE : MEBLAEAD </p>"
						+" <p>Note:- Mr Skips is privileged by stepping towards Dubai paperless goal and sending E-Copies of its invoices. </p>" 
						+" <p>We expect your good office to accept this e-copy invoice to release the payment.</p>" 
						+" </body>"   
					    +" </html>"; */    		
		  msg = msg.replace("<<client>>",client);     
		  //msg = msg.replace("<<fromdate>>",fromdate);  
		  //msg = msg.replace("<<todate>>",todate);
		  //msg = msg.replace("<<vocno>>",vocno);  
		  msg = msg.replace("<<msgstr1>>",msgstr1);   
		  msg = msg.replace("<<msgstr0>>","invoice");   
		  String formdetailcode="INVD",refid="",result="";//BI event reminder       
		  result=msg+"####"+email+"####"+cldocno+"####"+subject;           
		  //System.out.println("insend mail"+status);             
	      response.getWriter().print(result);            
	 
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>