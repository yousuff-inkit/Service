
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();


    String menubrch=request.getParameter("menubranch");
    String locid=request.getParameter("locid")==null?"":request.getParameter("locid");
     String type=request.getParameter("type")==null?"":request.getParameter("type");
 //System.out.println("typeselectloc="+type);
 // System.out.println("locid="+locid);
   String sql="",sql1="";
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
	 if(type.equalsIgnoreCase("issue")){
			 sql+=" and doc_no not in("+locid+")";
			 
		}
	 
	
		
		String strSql="select doc_no,loc_name from my_locm  where status=3 "+sql;
//System.out.println("loc search ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String location="",locId="";
		while(rs.next()) {
					location+=rs.getString("loc_name")+",";
					locId+=rs.getString("doc_no")+",";
	  		} 
	
		String locn[]=location.split(",");
		String locnId[]=locId.split(",");
		
		location=location.substring(0, location.length()-1);
		locId=locId.substring(0, locId.length()-1);
		
		
		response.getWriter().print(locId+"####"+location);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>