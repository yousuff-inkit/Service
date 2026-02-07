<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String  compid="",type="";
		
			String strSql = "select comp_id, company from gw_complist";
			//System.out.println(strSql);   
			ResultSet rs = stmt.executeQuery(strSql);
			
			while(rs.next()) {
				compid+=rs.getString("comp_id")+",";
				type+=rs.getString("company")+","; 
			}
			
			if(!compid.equals("")){  
				compid=compid.substring(0, compid.length()-1);
				type=type.substring(0, type.length()-1);
			}
		 
		//System.out.println(docno+"==="+type); 
		    response.getWriter().print(compid+"####"+type);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>