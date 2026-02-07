<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%> 
<%	
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	java.sql.Date sqldate=null; 
	String strSql ="",fromdate="",todate="",acno="0";
	try{
		ClsCommon ClsCommon=new ClsCommon();
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String sql="select date_format(fromdate,'%d.%m.%Y') fromdate,date_format(todate,'%d.%m.%Y') todate,ac.acno from rl_rental r left join my_acbook ac on (ac.cldocno=r.cldocno and ac.dtype='CRM') where r.doc_no="+docno+" and cancelstatus=0";
		//System.out.println("sql===="+sql);
		ResultSet rs1 = stmt.executeQuery(sql);    
		while(rs1.next()) {
			fromdate=rs1.getString("fromdate"); 
			todate=rs1.getString("todate"); 
			acno=rs1.getString("acno");     
		} 
		response.getWriter().print(fromdate+"####"+todate+"####"+acno);          
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  