<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String enqdocno=request.getParameter("enqdocno")==null || request.getParameter("enqdocno")==""?"0":request.getParameter("enqdocno");  
    String masterdoc=request.getParameter("masterdoc")==null || request.getParameter("masterdoc")==""?"0":request.getParameter("masterdoc");    
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0,tr_no=0,val2=0;
	String strSql = "select tr_no from sk_srvcontrm where refdtype='ENQ' and refdocno='"+enqdocno+"'";  
	//System.out.println("strSql---->>>"+strSql);  
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		  tr_no=rs.getInt("tr_no");  
  	}     
	if(tr_no>0){
		val=1;    
	 }
	
	String strSql2 = "select doc_no from sk_srvqotm where tr_no='"+masterdoc+"' and revision_no!=0";   
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