<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%> 
<%	
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();
	String etd=request.getParameter("etd")==null?"":request.getParameter("etd");
	String transit=request.getParameter("transit")==null  || request.getParameter("etd")==""?"0":request.getParameter("transit");
	java.sql.Date sqlfromdate=null; 
	String strSql ="", todate="";
	int fromval=0,toval=0,val=0;              
	try{
		ClsCommon ClsCommon=new ClsCommon();
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		if(!etd.equalsIgnoreCase("")){
			 sqlfromdate=ClsCommon.changeStringtoSqlDate(etd);    
		}   
		strSql = "SELECT DATE_ADD('"+sqlfromdate+"', INTERVAL "+transit+" DAY) todate";    
		//System.out.println("==="+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			todate=rs.getString("todate");       
		} 
		
		response.getWriter().print(todate);          
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  