<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select year(curdate())-1 year";
		ResultSet rs = stmt.executeQuery(strSql);
		int endyear=0,startyear=0,i=0;      
		String year="";
		String yearid="";
		while(rs.next()) {
			startyear=rs.getInt("year");	
	  	}
		endyear=startyear+100;    
		for(i=startyear;i<=endyear;i++){                 
			year+=i+",";
			yearid+=i+",";
		}
		
		year=year.substring(0, year.length()>0?year.length()-1:0);
		
		response.getWriter().write(year+"####"+yearid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
