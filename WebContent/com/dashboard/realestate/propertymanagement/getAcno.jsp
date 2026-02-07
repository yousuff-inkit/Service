<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%> 
<%	
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String srno=request.getParameter("srno")==null?"":request.getParameter("srno");     
	java.sql.Date sqldate=null; 
	String strSql ="",fromdate="",todate="";
	int acno=0;   
	try{
		ClsCommon ClsCommon=new ClsCommon();
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String sql="select date_format(fromdate,'%d.%m.%Y') fromdate,date_format(todate,'%d.%m.%Y') todate,coalesce(ac.acno,0) acno from rl_rental r left join my_acbook ac on (ac.cldocno=r.cldocno and ac.dtype='CRM') where propertyid="+docno+" and propertysub="+srno+" and cancelstatus=0 and ((fromdate between CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') as DATE) and last_day(now()) or todate between CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') as DATE) and last_day(now())) or (fromdate<CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') as DATE) and todate>last_day(now())))";
		//System.out.println("sql===="+sql);    
		ResultSet rs1 = stmt.executeQuery(sql);    
		while(rs1.next()) {
			fromdate=rs1.getString("fromdate"); 
			todate=rs1.getString("todate"); 
			acno=rs1.getInt("acno");     
		} 
		if(acno==0){     
			String sql2="select date_format(period_from,'%d.%m.%Y') fromdate,date_format(period_to,'%d.%m.%Y') todate,coalesce(acno,0) acno from rl_tncm where prtype="+docno+" and ((period_from between CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') as DATE) and last_day(now()) or period_to between CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') as DATE) and last_day(now())) or (period_from<CAST(DATE_FORMAT(NOW() ,'%Y-%m-01') as DATE) and period_to>last_day(now())))";
			//System.out.println("sql2===="+sql2);    
			ResultSet rs2 = stmt.executeQuery(sql2);    
			while(rs2.next()) {
				fromdate=rs2.getString("fromdate"); 
				todate=rs2.getString("todate"); 
				acno=rs2.getInt("acno");              
			}
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
  