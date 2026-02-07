<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String masterdoc=request.getParameter("masterdoc")==null || request.getParameter("masterdoc")==""?"0":request.getParameter("masterdoc");    
    Connection conn = null;         
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0,val2=0;
	String strSql = "select tr_no from cm_srvcontrm where ref_type='SQOT' and refTrNo='"+masterdoc+"'";     
	//System.out.println("strSql---->>>"+strSql);  
	ResultSet rs = stmt.executeQuery(strSql);         
	if(rs.next()) {         
		val=1;   
  	}     
	String strSql2 = "select tr_no from cm_srvqotm where tr_no='"+masterdoc+"' and revision_no!=0";   
	ResultSet rs2 = stmt.executeQuery(strSql2);           
	if(rs2.next()) {     
		val2=1;  
  	} 
	stmt.close();
	conn.close();  

	response.getWriter().print(val+"####"+val2);                
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>