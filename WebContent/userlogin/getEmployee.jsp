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
		
		String strSql = "select m.doc_no empid,UPPER(m.name) emp,round(m.costperhour,2) costperhour from hr_empm m left join hr_setpaycat c on (m.pay_catid=c.doc_no and c.status=3) where m.active=1 and m.status=3 and c.timesheet=1";   
		ResultSet rs = stmt.executeQuery(strSql);      
		
		String emp="";
		String empid="",costperhr="";
		while(rs.next()) {
			emp+=rs.getString("emp")+",";
			empid+=rs.getString("empid")+",";         
			//costperhr+=rs.getString("costperhour")+",";          
	  		} 
		
		emp=emp.substring(0, emp.length()>0?emp.length()-1:0);   
		
		response.getWriter().write(emp+"####"+empid);     
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
