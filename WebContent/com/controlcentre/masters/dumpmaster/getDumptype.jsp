<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn=null;
try{
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select name,doc_no from sk_dumptype where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String name="";
	String doc_no="";
	while(rs.next()) {
		name+=rs.getString("name")+",";		
		doc_no+=rs.getString("doc_no")+",";
		//System.out.println(name);
		
				
  		} 
	name=name.substring(0, name.length()-1);
	stmt.close();
	conn.close();

	response.getWriter().write(name+"***"+doc_no);
	//System.out.println("id==="+doc_no);
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