<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");

String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype");
String refmasterdocno=request.getParameter("refmasterdocno")==null?"0":request.getParameter("refmasterdocno");
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	

int paymode=0;
int tr_no=0;
int stkid=0;

	String aaa = " select paymode from my_invm where doc_no= '"+masterdoc_no+"' ";
			
			ResultSet rss = stmt.executeQuery(aaa);
 
	if(rss.next()) {
	
		
		paymode=rss.getInt("paymode");
		 
  		} 
	String paymodes="";
	if(paymode==1)
	{
		paymodes="Cash Invoice";
	}
	else if(paymode==2)
	{
		paymodes="Credit Invoice";
	}
	
	
	String strSql111 = " select p.add1,(case when coalesce(ex.apprStatus,0)=0 then p.edit else 0 end) as edit, "
			+ " (case when coalesce(ex.apprStatus,0)=0 then p.del else 0 end) as del,p.print,p.attach,p.excel,p.email,ex.apprStatus "
			+ " from  my_powr p left join my_user u on u.role_id=p.roleid  left join my_menu m on(m.menu_name=p.menu_name) "
			+ "left join my_exdet ex on(ex.dtype=m.doc_type and u.doc_no=ex.userid and ex.doc_no='"+masterdoc_no+"') "
			+ "  where p.menu_name='"+paymodes+"' and u.doc_no='"+session.getAttribute("USERID").toString()+"' ";
	System.out.println("---strSql111--"+strSql111);
	ResultSet rs111 = stmt.executeQuery(strSql111);
	int editval=0;
	if(rs111.next()) {
	
		
		editval=rs111.getInt("edit");
		if(editval==0)
		{
			val=1;
		}
		
  		} 
	
	
 
	
	
	
	if(reftype.equalsIgnoreCase("SOR"))
	{
		String strSql2 = "select * from my_sorderd where rdocno in("+refmasterdocno+")  and clstatus=1 ";
		
		 System.out.println("-asd-asdasd-1-"+strSql2);
		ResultSet rs1 = stmt.executeQuery(strSql2);

		if(rs1.next()) {
			val=1;
	  		}
	}
	
	
	String strSql = "select rrefno from my_invr where  FIND_IN_SET('"+masterdoc_no+"', rrefno)";
	
	System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
		val=1;
  		} 
	String strSql1 = "select tr_no from my_invm where  doc_no='"+masterdoc_no+"'";
	
	System.out.println("---strSql--"+strSql1);
	ResultSet rs1 = stmt.executeQuery(strSql1);

	if(rs1.next()) {
		tr_no=rs1.getInt("tr_no");
  		} 
	
String strSql2 = "select out_qty from my_invd where out_qty>0 and  tr_no='"+tr_no+"'";
	
	System.out.println("---strSql--"+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);

	if(rs2.next()) {
		val=1;
  		} 
String strSql3 = "select stockid from my_prddout where  tr_no='"+tr_no+"'";
	
	System.out.println("---strSql3--"+strSql3);
	ResultSet rs3 = stmt.executeQuery(strSql3);

	if(rs3.next()) {
		stkid=rs3.getInt("stockid");
  		} 
/* String strSql4 = "select out_qty from my_prddin where (out_qty>0 or rsv_qty>0 or del_qty>0  or foc_out>0) and stockid='"+stkid+"'";
	
	System.out.println("---strSql4--"+strSql4);
	ResultSet rs4 = stmt.executeQuery(strSql4);

	if(rs4.next()) {
		val=1;
  		} */
String strSql5 = "select out_qty from my_prddout where (out_qty>0 or rsv_qty>0 or del_qty>0) and  tr_no='"+tr_no+"'";
	
	System.out.println("---strSql5--"+strSql5);
	ResultSet rs5 = stmt.executeQuery(strSql5);

	if(rs5.next()) {
		val=1;
  		} 
	
	
	
	
	System.out.println("---val--"+val);

 
	
 
	

	
	
	
	stmt.close();
	conn.close();

	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally {
	conn.close();
}
	%>