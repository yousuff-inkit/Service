<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>


<%	
Connection conn =null;
Statement stmt =null;
Statement ucheckstmt=null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

try{
String uchecksql="";
int isonline=0;
String userfrmid=request.getParameter("userfrmid").trim();
String usertoid=request.getParameter("usertoid").trim();
//System.out.println("===userfrmid==="+userfrmid);
   java.util.Date date=new java.util.Date();
   //System.out.println("==date====="+date);
   java.sql.Date sd=ClsCommon.getSqlDate(date);
   
 	 conn = ClsConnection.getMyConnection();
	 stmt = conn.createStatement ();
	String strSql = "update gw_userlist set is_online=1 where doc_no='"+userfrmid+"'";
	//System.out.println("strSql======"+strSql);
	int rs = stmt.executeUpdate(strSql);
	
	
	uchecksql="select is_online  from gw_userlist u where doc_no='"+usertoid+"'";
	
	//System.out.println("==uchecksql===="+uchecksql);
	
	ucheckstmt =conn.createStatement ();
	ResultSet rsucheck = ucheckstmt.executeQuery(uchecksql);
	while(rsucheck.next()) {
		isonline=rsucheck.getInt("is_online");
		//System.out.println("usercount===="+usercount);
	}
	
	
	
	response.getWriter().print(isonline);
	//System.out.println("isonline       "+isonline);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	stmt.close();
	conn.close();
}
	
	  
  %>
  
