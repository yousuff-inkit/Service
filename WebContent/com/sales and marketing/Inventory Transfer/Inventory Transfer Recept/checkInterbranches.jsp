<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
      String br1 = request.getParameter("br1")==null?"0":request.getParameter("br1");
	  String br2 = request.getParameter("br2")==null?"0":request.getParameter("br2");     
 	  Connection conn = null;
  try{
	  ClsConnection ClsConnection=new ClsConnection();
	  conn= ClsConnection.getMyConnection();
	  Statement stmt = conn.createStatement ();
  	  int val=0;
	  String strSql = "SELECT doc_no FROM my_intr WHERE (br1 = "+br1+" and br2 = "+br2+") or (br1 = "+br2+" and br2 = "+br1+")";   
	  //System.out.println("---strSql--"+strSql);
	  ResultSet rs = stmt.executeQuery(strSql);
	  if(rs.next()) {
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