<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String docno=request.getParameter("vocno")==null || request.getParameter("vocno").trim().equalsIgnoreCase("")?"0":request.getParameter("vocno");
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid");
		String cldocno="0",email="",date="",msg="",policyno="",insname="";  
		Statement stmt2 = conn.createStatement();
	
		String strSql2 = "select m.doc_no policyno,m.cldocno,DATE_FORMAT(m.enddt,'%d %M %Y') enddt,ac.mail1 email,s.name insname from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no left join my_acbook ac on (ac.cldocno=m.cldocno and ac.dtype='CRM') left join sk_skiptype s on s.doc_no=d.skiptype where m.doc_no='"+docno+"' and m.brhid='"+brhid+"'";
		System.out.println("sql=="+strSql2);
		ResultSet rs2 = stmt2.executeQuery(strSql2);  
		while(rs2.next ()) {
			  cldocno=rs2.getString("cldocno");
			  date=rs2.getString("enddt");
			  email=rs2.getString("email");
			  policyno=rs2.getString("policyno");  
			  insname=rs2.getString("insname");
		}
		  //String receiptdate=request.getParameter("receiptdate");   
		  //String docno=request.getParameter("docno");
		   String userid=session.getAttribute("USERID").toString();
		   msg="<html>"              
					  +" <body>"
					  +" <p>Dear Sir / Madam,</p><br/>"
					  +" <p>Please note that your contract is due for renewal as below </p>" 
					  +" <p>Contract number  :<<policy>></p>"
					  +" <p>Expiry date    :<<datess>></p>"
					  +" <p>For Skip Size  :<<instype>></p>"
					  +" <p>It is our sincere effort to arrange this facility on your behalf. If you should have any questions or concerns, please dont hesitate to contact our office.</p>"  
					  +" <p>Yours Sincerely,</p>"
					  +" <p>Team Renewal</p>" 
					  +" <p>Please dont print e-mails unless you really need</p>"
					  +" </p>"
					  +" </body>"
					  +" </html>"; 
		  msg = msg.replace("<<datess>>",date);        
		  msg = msg.replace("<<policy>>",policyno);  
		  msg = msg.replace("<<instype>>",insname);    
		  String formdetailcode="CRF",refid="",result="";//BI event reminder    
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