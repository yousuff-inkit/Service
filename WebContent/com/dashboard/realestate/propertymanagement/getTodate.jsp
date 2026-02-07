<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%> 
<%	
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String noofdays=request.getParameter("noofdays")==null?"":request.getParameter("noofdays");
	String types=request.getParameter("types")==null?"":request.getParameter("types");
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String srno=request.getParameter("srno")==null?"":request.getParameter("srno");     
	java.sql.Date sqlfromdate=null; 
	String strSql ="", todate="";
	int fromval=0,toval=0,val=0;              
	try{
		ClsCommon ClsCommon=new ClsCommon();
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		if(!fromdate.equalsIgnoreCase("")){
			 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);    
		} 
		if(types.equalsIgnoreCase("D")){
			 strSql = "SELECT DATE_ADD('"+sqlfromdate+"', INTERVAL "+noofdays+" DAY) todate";    
		}else if(types.equalsIgnoreCase("M")){
			 strSql = "SELECT DATE_ADD('"+sqlfromdate+"', INTERVAL "+noofdays+" MONTH) todate";    
		}else{}
		//System.out.println("==="+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			todate=rs.getString("todate");       
		} 
		
		String sql="select if('"+sqlfromdate+"' between fromdate and todate,1,0) fromval,if('"+todate+"' between fromdate and todate,1,0) toval from rl_rental where cancelstatus=0 and propertyid="+docno+" and propertysub="+srno+"";
		ResultSet rs1 = stmt.executeQuery(sql);    
		while(rs1.next()) {
			fromval=rs1.getInt("fromval"); 
			toval=rs1.getInt("toval"); 
			if(fromval>0 || toval>0){   
				val=1;
			}             
		}
		  
		String sql2="select if('"+sqlfromdate+"' between period_from and period_to,1,0) fromval,if('"+todate+"' between period_from and period_to,1,0) toval from rl_tncm m left join rl_propertysub s on s.propertyid=m.prtype where prtype="+docno+" and s.srno="+srno+"";
		ResultSet rs2 = stmt.executeQuery(sql2);    
		while(rs2.next()) {
			fromval=rs2.getInt("fromval"); 
			toval=rs2.getInt("toval"); 
			if(fromval>0 || toval>0){   
				val=1;
			}             
		}     
		
		response.getWriter().print(todate+"####"+val);          
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  