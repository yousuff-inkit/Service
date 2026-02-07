<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 

<%              
String remarks=request.getParameter("remarks")==""?"0":request.getParameter("remarks");   
String receivedby=request.getParameter("receivedby")==""?"":request.getParameter("receivedby");
String userid=request.getParameter("userid")==""?"0":request.getParameter("userid");
String status=request.getParameter("status")==""?"0":request.getParameter("status");
String sdate=request.getParameter("ddate")==""?"":request.getParameter("ddate");
String ackdate=request.getParameter("ackdate");
String docno=request.getParameter("docno")==""?"0":request.getParameter("docno"); 
String dtype=request.getParameter("dtype")==""?"0":request.getParameter("dtype");  
//String oldassuser=request.getParameter("oldassuser")==null?"0":request.getParameter("oldassuser");
int val=0;
// System.out.println("==docno===="+ackdate+"===="+sdate);

Connection conn=null;
try{          
	ClsConnection objconn=new ClsConnection();  
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	String strsql="";
	
	Date sdatesql=null;
	sdatesql=objcommon.changeStringtoSqlDate(sdate);
	Date ackdatesql=null;
	ackdatesql=objcommon.changeStringtoSqlDate(ackdate);
	String[] doc=docno.split(",");
	String[] dtyp=dtype.split(",");
	String flwsql="";
	
		for(int i=0;i<doc.length;i++) { 
			
	if( ackdatesql==null && sdatesql==null)
	{
		flwsql="insert into sk_dispatchlog(rdocno,rdtype,statusid,auserid,receivedby,remarks,userid,edate) values('"+doc[i]+"','"+dtyp[i]+"','"+status+"','"+userid+"','"+receivedby+"','"+remarks+"','"+session.getAttribute("USERID")+"',now())";
	}
	else if( ackdatesql==null)
	{
		flwsql="insert into sk_dispatchlog(rdocno,rdtype,statusid,auserid,date,receivedby,remarks,userid,edate) values('"+doc[i]+"','"+dtyp[i]+"','"+status+"','"+userid+"','"+sdatesql+"','"+receivedby+"','"+remarks+"','"+session.getAttribute("USERID")+"',now())";
	}
	 
	else
	{
		 flwsql="insert into sk_dispatchlog(rdocno,rdtype,statusid,auserid,date,receivedby,ackdate,remarks,userid,edate) values('"+doc[i]+"','"+dtyp[i]+"','"+status+"','"+userid+"','"+sdatesql+"','"+receivedby+"','"+ackdatesql+"','"+remarks+"','"+session.getAttribute("USERID")+"',now())";
	}
	val=stmt.executeUpdate(flwsql);          

       strsql="update sk_invm set dispatchid='"+status+"' where doc_no='"+doc[i]+"' ";
       stmt.executeUpdate(strsql); 
		//System.out.println(val+"---->>>"+strsql); 
		}
	
}   
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(val+"");   

%>