<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%@page import="com.skips.quotation.ClsQuotationAction"%>   
<%
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsQuotationAction action=new ClsQuotationAction();  
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String trno=request.getParameter("trno")==null || request.getParameter("trno").trim().equalsIgnoreCase("")?"0":request.getParameter("trno");
		String cldocno="0",email="",date="",msg="",skipsize="",insname="",brhid="",company="",docno="";      
		Statement stmt2 = conn.createStatement();
	
		String strSql2 = "select date_format(m.date,'%d-%M-%Y') date,m.brhid,m.doc_no,m.cldocno,e.email,s.name skipsize,(select company from my_comp) company from sk_srvqotm m left join sk_srvqotdet d on d.rdocno=m.tr_no left join sk_skiptype s on s.doc_no=d.skiptype left join gl_enqm e on (e.doc_no=m.refdocno and m.refdtype='ENQ') where m.tr_no='"+trno+"'";
		//System.out.println("sql=="+strSql2);  
		ResultSet rs2 = stmt2.executeQuery(strSql2);     
		while(rs2.next ()) {
			  cldocno=rs2.getString("cldocno");
			  email=rs2.getString("email");
			  brhid=rs2.getString("brhid"); 
			  skipsize=rs2.getString("skipsize");    
			  company=rs2.getString("company");   
			  date=rs2.getString("date");   
			  docno=rs2.getString("doc_no");     
		}  
		action.emailAction(trno, brhid);     
		  //String receiptdate=request.getParameter("receiptdate");   
		  //String docno=request.getParameter("docno");
		   String userid=session.getAttribute("USERID").toString();
		  /*  msg="<html>"              
				+" <body>"
				+" <p>Dear <<company>>,</p><br/>"
				+" <p>Please find the attached quotation - <<docno>> for <<skipsize>> created on <<datess>></p>" 
				+" </body>"
			    +" </html>"; */    
		  msg="<html>"              
						+" <body>"
						+" <p>Dear Sir/ Madam,</p><br/>"
						+" <p>Greetings from MR Skips Team!</p>" 
						+" <p>We value your trust in our company by giving us a chance to serve you. Please find enclosed our quotation for your further perusal.</p>" 
						+" <p>The above attached is the best offer to meet your service expectations therefore we look forward to receiving your positive approval at the earliest.</p>" 
						+" <p>If you need to discuss about our offer in details, please do not hesitate to contact us anytime.</p>" 
						+" <p>Thanks & Regards</p>" 
						+" </body>"
					    +" </html>";				
		 /*  msg = msg.replace("<<company>>",company);     
		  msg = msg.replace("<<datess>>",date);        
		  msg = msg.replace("<<docno>>",docno);    
		  msg = msg.replace("<<skipsize>>",skipsize);   */           
		  String formdetailcode="QOT",refid="",result="";//BI event reminder     
		  result=msg+"####"+email+"####"+cldocno;           
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