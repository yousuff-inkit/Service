<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
int tr_no=0;
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype");
String refmasterdocno=request.getParameter("refmasterdocno")==null?"0":request.getParameter("refmasterdocno");

 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	
	if(reftype.equalsIgnoreCase("PO"))
	{
	String strSql2 = "select * from my_ordd where rdocno in("+refmasterdocno+") and clstatus=1 ";
	
	 System.out.println("---1-"+strSql2);
	ResultSet rs1 = stmt.executeQuery(strSql2);

	if(rs1.next()) {
		val=1;
 		} 
	}
	
	
	String strSql = "select rrefno from my_srvm where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
		val=1;
  		} 
	
	
	String strSql2 = "select tr_no from my_grnm where  doc_no='"+masterdoc_no+"'";
	
	System.out.println("---strSql-2-"+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);

	if(rs2.next()) {
		tr_no=rs2.getInt("tr_no");
  		} 
	String strSql6 = "select stockid from my_grnd where (out_qty>0) and tr_no="+tr_no+"";
	
	System.out.println("---strSql-2-"+strSql6);
	ResultSet rs6 = stmt.executeQuery(strSql6);

	if(rs6.next()) {
		val=1;
  		}
	
	String strSql3 = "select stockid from my_prddin where (out_qty>0 or rsv_qty>0 or del_qty>0  or foc_out>0) and tr_no='"+tr_no+"' ";
	
	System.out.println("---strSql-3-"+strSql3);
	ResultSet rs3 = stmt.executeQuery(strSql3);

	if(rs3.next()) {
		val=1;
  		} 
	
	String strsql4="select tr_no from my_grrm where rrefno="+masterdoc_no+"";
	System.out.println("---strSql-4-"+strsql4);
	ResultSet rs4=stmt.executeQuery(strsql4);
	if(rs4.next()){
		tr_no=rs4.getInt("tr_no");
	}
	
	String strsql5="select stockid from my_grrd where tr_no="+tr_no+"";
	System.out.println("---strSql-4-"+strsql5);
	ResultSet rs5=stmt.executeQuery(strsql5);
	if(rs5.next()){
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