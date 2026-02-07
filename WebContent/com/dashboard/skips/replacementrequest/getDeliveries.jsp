<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();  

	Connection conn = null;
	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select 'All' slno from sk_srvcontrdel dl where dl.rdocno='"+contrno+"' and dl.srno='"+srno+"' group by dl.rdocno union all select dl.slno from sk_srvcontrdel dl where dl.rdocno='"+contrno+"' and dl.srno='"+srno+"'";
		//System.out.println("strSql="+strSql);      
		ResultSet rs = stmt.executeQuery(strSql);  
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("slno")+",";  
					sr+=rs.getString("slno")+",";    
		} 
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
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  