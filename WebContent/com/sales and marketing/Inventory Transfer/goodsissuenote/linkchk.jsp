<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
int tr_no=0;
 	Connection conn = null;
	System.out.println("masterdoc_no"+masterdoc_no);

try{
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String strSql = "select rrefno from my_girm where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
		val=1;
  		} 
	
	
	String strSql2 = "select tr_no from my_gism where  doc_no='"+masterdoc_no+"'";
	
	System.out.println("---strSql-2-"+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);

	if(rs2.next()) {
		System.out.println("---trno--"+rs2.getInt("tr_no"));

		tr_no=rs2.getInt("tr_no");
  		} 
	
	String strSql3 = "select stockid from my_prddout where (out_qty>0) and tr_no='"+tr_no+"' ";
	
	System.out.println("---strSql-3-"+strSql3);
	ResultSet rs3 = stmt.executeQuery(strSql3);

	if(rs3.next()) {
		System.out.println("stockid"+rs3.getString("stockid"));

		val=1;
  		} 
	
	
 
	stmt.close();
	conn.close();

	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>