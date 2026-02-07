<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");



int tr_no=0;
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	
 
	String strSql2 = "select * from my_srvsaleretm where rrefno='"+masterdoc_no+"' ";
	// System.out.println("---1-"+strSql2);
	ResultSet rs1 = stmt.executeQuery(strSql2);
	if(rs1.next()) {
		val=1;
 		} 
	
	String strSql3 = "select * from my_srvsalem m left join my_jvtran j on j.tr_no=m.tr_no where j.prep=1 and m.doc_no='"+masterdoc_no+"' ";
     System.out.println("---2-"+strSql3);
	ResultSet rs3 = stmt.executeQuery(strSql3);
	if(rs3.next()) {
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