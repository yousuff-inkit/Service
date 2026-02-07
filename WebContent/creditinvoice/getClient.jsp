<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	Connection conn =  null;try
{
/* 	String dtype=session.getAttribute("Code").toString();
  String clientid=request.getParameter("clientid").trim().toString();
    System.out.println("clientid="+clientid);
	String brch=session.getAttribute("BRANCHID").toString(); */
	String strSql ="";	ClsConnection ClsConnection=new ClsConnection();
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	String strSq = "select acno,cldocno doc_no,refname client,tax from my_acbook where dtype='CRM'";
	/* ResultSet rs1 = stmt.executeQuery(strSq);
	int multi = 0;
	while(rs1.next()){
	multi = rs1.getInt("multiCur");
	}
	
	if(!(clientid.equals("")||clientid.equals("0"))){
		strSql="select c.doc_no,c.code,c.c_rate from my_acbook ac left join my_curr c on (ac.curid=c.doc_no and ac.dtype='CRM') where ac.doc_no="+clientid+" and c.status=3";
	}
	else{
		strSql = "select c.doc_no,code,c.c_rate from my_brch b inner join my_curr c on(c.doc_no=curId) where c.status <> 7 and b.doc_no='"+brch+"'";
	}
	
	System.out.println("===strSql===="+strSql); */
	
	ResultSet rs = stmt.executeQuery(strSq);
	String cldocno="";
	String client="";
	String tax="";
	String acno="";
	while(rs.next()) {
		cldocno+=rs.getInt("doc_no")+",";
		client+=rs.getString("client")+",";
		 tax+=rs.getString("tax")+","; 
		 acno+=rs.getString("acno")+","; 
  		} 
	/* cldocno=cldocno.substring(0, cldocno.length()-1);
	client=client.substring(0, client.length()-1);
 	tax=tax.substring(0, tax.length()-1); */ 
	System.out.println(cldocno+"####"+client+"####"+tax+"####"+acno);
	response.getWriter().write(cldocno+"####"+client+"####"+tax+"####"+acno);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}
  %>
  
