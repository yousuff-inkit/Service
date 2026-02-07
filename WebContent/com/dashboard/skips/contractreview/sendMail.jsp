<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%@page import="com.skips.servicecontract.ClsServiceContractAction"%>   
<%
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsServiceContractAction action=new ClsServiceContractAction();  
	try{
		
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String trno=request.getParameter("trno")==null || request.getParameter("trno").trim().equalsIgnoreCase("")?"0":request.getParameter("trno");
		String xlstat=request.getParameter("xlstat")==null || request.getParameter("xlstat").trim().equalsIgnoreCase("")?"0":request.getParameter("xlstat");
		String typeid=request.getParameter("typeid")==null || request.getParameter("typeid").trim().equalsIgnoreCase("")?"0":request.getParameter("typeid");
		String value=request.getParameter("value")==null || request.getParameter("value").trim().equalsIgnoreCase("")?"0":request.getParameter("value");
		
		String cldocno="0",email="",date="",msg="",skipsize="",insname="",brhid="",company="",docno="",revisionno="";      
		Statement stmt2 = conn.createStatement();
	
		String strSql2 = "select date_format(m.date,'%d-%M-%Y') date,m.brhid,m.doc_no,m.cldocno,m.email,s.name skipsize,m.revision_no,(select company from my_comp) company from sk_srvcontrm m inner join sk_srvcontrdet d  on d.rdocno=m.tr_no left join sk_skiptype s on s.doc_no=d.skiptype where m.tr_no="+trno;
		ResultSet rs2 = stmt2.executeQuery(strSql2);     
		while(rs2.next ()) {
			  cldocno=rs2.getString("cldocno");
			  email=rs2.getString("email");
			  brhid=rs2.getString("brhid"); 
			  skipsize=rs2.getString("skipsize");    
			  company=rs2.getString("company");   
			  date=rs2.getString("date");   
			  docno=rs2.getString("doc_no");     
			  revisionno=rs2.getString("revision_no");     
		}  
		
		action.emailAction(trno, brhid, xlstat, typeid, "AMC", value, revisionno);     
		
		String userid=session.getAttribute("USERID").toString();
		 
		   /* msg="<html>"              
				+" <body>"
				+" <p>Dear <<company>>,</p><br/>"
				+" <p>Please find the attached quotation - <<docno>> for <<skipsize>> created on <<datess>></p>" 
				+" </body>"
			    +" </html>";  */      
			
						msg="<html>"              
						+" <body>"
						+" <p>Dear Sir/ Madam,</p><br/>"
						+" <p>Greetings from MR Skips Team!</p>" 
						+" <p>We value your trust in our company by giving us a chance to serve you. Please find enclosed our contract for your further perusal.</p>" 
						+" <p>If you need to discuss about our offer in details, please do not hesitate to contact us anytime.</p>" 
						+" <p>Thanks & Regards</p>" 
						+" </body>"
					    +" </html>";    				
		
								/*  msg = msg.replace("<<company>>",company);     
		  msg = msg.replace("<<datess>>",date);        
		  msg = msg.replace("<<docno>>",docno);    
		  msg = msg.replace("<<skipsize>>",skipsize); */
		  
		  String formdetailcode="AMC",refid="",result="";//BI event reminder     
		  result=msg+"####"+email+"####"+cldocno;           
		  
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