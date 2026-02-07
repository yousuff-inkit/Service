
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();


    String menubrch=request.getParameter("menubranch");
    String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
    String type=request.getParameter("type")==null?"":request.getParameter("type");
   // System.out.println("typeselectbrch="+type);
   // System.out.println("brhid="+brhid);
     
    String sql="",sql1="";
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		 if(type.equalsIgnoreCase("issue")){
			 sql+=" and doc_no not in("+brhid+")";
		} 
		 
		
	    String strSql = "select branchname, doc_no from my_brch where status<>7 "+sql;
	//System.out.println("getBranch ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",brnchId="";
		while(rs.next()) {
					brnch+=rs.getString("branchname")+",";
					brnchId+=rs.getString("doc_no")+",";
	  		} 
	
		String brn[]=brnch.split(",");
		String brnId[]=brnchId.split(",");
		
		brnch=brnch.substring(0, brnch.length()-1);
		brnchId=brnchId.substring(0, brnchId.length()-1);
		
		
		response.getWriter().print(brnchId+"####"+brnch);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>