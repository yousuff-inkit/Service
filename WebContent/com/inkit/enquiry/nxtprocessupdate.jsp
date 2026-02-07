<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.inkit.enquiry.ClsEnquiryAction"%>

<% 
int statusid=0;
if(request.getParameter("statusid")==null){
	statusid=0;
}
else{
	statusid=Integer.parseInt(request.getParameter("statusid").trim());
}
 
int docno=Integer.parseInt(request.getParameter("docno").trim());
int userid=Integer.parseInt(session.getAttribute("USERID").toString().trim());
//int inspgridlenth=Integer.parseInt(request.getParameter("inspgridlenth").trim());
String remarks=request.getParameter("remarks").trim();
//String description=request.getParameter("description").trim();

int result=0;
System.out.println(session.getAttribute("USERID").toString().trim());
System.out.println("statusid"+statusid);
System.out.println("srno"+docno);

ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "update is_enqmaster set curproces_id="+statusid+" where  doc_no="+docno+"";
	String enqdSql="insert into is_enqprocessdet(enq_id, procstatus_id, date, user_id,remarks) values("+docno+","+statusid+",now(),"+userid+",'"+remarks+"')";
	System.out.println("strSql======"+strSql);
	int rs = stmt.executeUpdate(strSql);
	int rs2=stmt.executeUpdate(enqdSql);
	
	response.getWriter().print(rs);
	System.out.println("aaaaaa       "+rs2);
	stmt.close();
	conn.close();
	  
  %>
  
