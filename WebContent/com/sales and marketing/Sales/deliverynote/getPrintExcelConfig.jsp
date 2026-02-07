<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int docdateconfig=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strconfig="select coalesce(method,0) method from gl_config where field_nme='excelconfig'";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	while(rsconfig.next()){
		docdateconfig=rsconfig.getInt("method");
	}
  System.out.println("docdateconfig=="+docdateconfig);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(docdateconfig+"");
%>