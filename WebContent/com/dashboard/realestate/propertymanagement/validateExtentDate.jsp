<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%> 
<%	
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();
	String date=request.getParameter("date")==null?"":request.getParameter("date");
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String srno=request.getParameter("srno")==null?"":request.getParameter("srno");     
	java.sql.Date sqldate=null; 
	String strSql ="";
	int toval=0,val=0;                 
	try{
		ClsCommon ClsCommon=new ClsCommon();
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		if(!date.equalsIgnoreCase("")){
			 sqldate=ClsCommon.changeStringtoSqlDate(date);         
		} 
		String sql="select if('"+sqldate+"' between fromdate and todate,1,0) toval from rl_rental where cancelstatus=0 and propertyid="+docno+" and propertysub="+srno+"";
		//System.out.println("sql===="+sql);
		ResultSet rs1 = stmt.executeQuery(sql);    
		while(rs1.next()) {
			toval=rs1.getInt("toval"); 
			if(toval>0){   
				val=1;
			}
		} 
		//System.out.println("val===="+val);
		response.getWriter().print(val);          
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  