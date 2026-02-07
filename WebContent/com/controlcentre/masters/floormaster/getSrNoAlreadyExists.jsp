<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
Connection conn=null;
try{
	ClsConnection ClsConnection=new ClsConnection();
String temp=request.getParameter("srno")==null||request.getParameter("srno")==""?"0":request.getParameter("srno");
String rackid=request.getParameter("rackid")==null||request.getParameter("rackid")==""?"0":request.getParameter("rackid");
String doc=request.getParameter("doc")==null||request.getParameter("doc")==""?"0":request.getParameter("doc");

	System.out.println(temp);
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strsql1="";
	if(!(doc.equalsIgnoreCase("undefined"))&&!(doc.equalsIgnoreCase(""))&&!(doc.equalsIgnoreCase("0"))){
		strsql1=strsql1+" and doc_no <>"+doc+"";
	}
	String strSql = "select srno from my_flbin where (srno='"+temp+"' and rck_id="+rackid+" "+strsql1+" ) and status<>7";
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	
	String srno="";
	if(rs.next()) {
		srno=rs.getString("srno");
  		} 
	else{
		srno="undefine";
	}
	stmt.close();
	conn.close();


	response.getWriter().write(srno);
	System.out.println("srno:"+srno);
	/* response.getWriter().write(auth.toArray()); */
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>