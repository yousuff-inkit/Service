<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select modename ,doc_no,submode from cr_mode where  status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String mode="",sr="",chk="";
		while(rs.next()) {
					mode+=rs.getString("modename")+",";
					sr+=rs.getString("doc_no")+",";
					chk+=rs.getString("submode")+",";
				} 
		
		String modes[]=mode.split(",");
		String modeId[]=sr.split(",");
		String chks[]=chk.split(",");
		mode=mode.substring(0, mode.length()-1);
		sr=sr.substring(0, sr.length()-1);
		chk=chk.substring(0, chk.length()-1);
		response.getWriter().write(sr+"####"+mode+"####"+chk);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  