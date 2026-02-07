<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String masterdoc=request.getParameter("cnttrno")==null?"0":request.getParameter("cnttrno");
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0,invtrno=0,invrettrno=0,jvtrno=0;
	String strSql = "select coalesce(invtrno,0) invtrno,coalesce(invrettrno,0) invrettrno,coalesce(jvtrno,0) jvtrno from in_opaccount where dtype='INS' and cnttrno='"+masterdoc+"'";
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		invtrno=rs.getInt("invtrno");
		invrettrno=rs.getInt("invrettrno");
		jvtrno=rs.getInt("jvtrno");   
  		}       
	if(invtrno>0 || invrettrno>0){         
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