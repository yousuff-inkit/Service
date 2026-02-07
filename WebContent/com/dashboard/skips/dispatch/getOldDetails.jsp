<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String docno = request.getParameter("docno")==null || request.getParameter("docno").equals("")?"0":request.getParameter("docno");    
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	String user="", userid="", remarks="", status="", statusid="0", receivedby="", date="",ackdate="";       
	String strSql = "select d.date,d.ackdate,d.rowno, coalesce(u.user_name,'') user_name, coalesce(d.receivedby,'') receivedby, coalesce(d.remarks,'') remarks, coalesce(s.name,'') status, coalesce(d.statusid,0) statusid, d.auserid from sk_dispatchlog d left join my_user u on u.doc_no=d.auserid left join sk_dispatchstatus s on s.rowno=d.statusid where d.rdocno='"+docno+"' order by d.rowno desc limit 1";
	//System.out.println("strSql3"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		user = rs.getString("user_name"); 
		userid = rs.getString("auserid"); 
		remarks = rs.getString("remarks"); 
		status = rs.getString("status"); 
		statusid = rs.getString("statusid");     
		receivedby = rs.getString("receivedby");  
		date =rs.getString("date");
		ackdate =rs.getString("ackdate");
  	}       
	 
	stmt.close();
	conn.close();  

	response.getWriter().print(user+"####"+userid+"####"+remarks+"####"+status+"####"+statusid+"####"+receivedby+"####"+date+"####"+ackdate);             
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>