<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select userid,brhid from userlog where srno=(select max(srno) from userlog)";
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println(strSql);
	String userid="",refname="";
	String brhid="";
	if(rs.next()) {
		userid=rs.getString("userid");		
		brhid=rs.getString("brhid");
  		} 
	String strsqlnw="select coalesce(user_name,'') refname from my_user where doc_no="+userid+"";
	ResultSet rs2=stmt.executeQuery(strsqlnw);     
	while(rs2.next()){
		refname=rs2.getString("refname");
	}
	stmt.close();
	conn.close();
	response.getWriter().write(userid+"###"+brhid+"###"+refname);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
  
