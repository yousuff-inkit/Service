<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>

<%	
JSONObject objdata=new JSONObject();

String brch = request.getParameter("brch") == null ? "" : request.getParameter("brch").toString();

	String strSql ="";	
	ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	try{
JSONArray locationArray=new JSONArray();
		strSql = "select loc_name,doc_no,brhid from my_locm where status=3 and brhid="+brch+"";
	System.out.println("===strSql===="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	while(rs.next()) {
		JSONObject ob=new JSONObject();
		ob.put("doc_no", rs.getString("doc_no"));
		ob.put("loc_name", rs.getString("loc_name"));
		locationArray.add(ob);
  		} 
	objdata.put("location", locationArray);	
	response.getWriter().write(objdata+"");
	
	

	}catch(Exception e){
		e.printStackTrace();
	}
	stmt.close();
	conn.close();

  %>
  
