<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection(); 
	try{    
			Connection conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement(); 
		
		String strSql = "select trim(concat(cldocno,' - ',refname)) refname,trim(cldocno) cldocno from my_acbook where status=3 and dtype='CRM' order by refname";  
		//System.out.println("strSql==="+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("refname")+",";    
					sr+=rs.getString("cldocno")+",";    
		} 
		//System.out.println(pro+"==="+sr);
		if(!pro.equalsIgnoreCase("")){  
			String procc[]=pro.split(",");
			String brnId[]=sr.split(",");
			
			pro=pro.substring(0, pro.length()-1);
			sr=sr.substring(0, sr.length()-1);
		}  
		response.getWriter().write(sr+"####"+pro);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();  
	}
  %>
  