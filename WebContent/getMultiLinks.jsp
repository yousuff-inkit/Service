<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String multilinkconfig = "0";
try{
	    JSONArray urldata = new JSONArray();
		ClsConnection objconn = new ClsConnection();
		conn = objconn.getMyConnection();
		Statement stmt = conn.createStatement(); 
		
		String strsql = "select method from gl_config where field_nme='MULTILINKS'";  
		System.out.println(strsql);
		ResultSet rs = stmt.executeQuery(strsql);
		if(rs.next()){
			multilinkconfig = rs.getString("method");
		}
		
		String strsql2 = "select link, doc_no, name from my_links";
		System.out.println(strsql2);
		ResultSet rs2 = stmt.executeQuery(strsql2);
		while(rs2.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("link", rs2.getString("link"));
			objtemp.put("name", rs2.getString("name"));
			urldata.add(objtemp);
		}	
 
	
	objdata.put("urldata",urldata);
	objdata.put("multilinkconfig",multilinkconfig);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(conn!=null){
		conn.close();	
	}
	
}
response.getWriter().write(objdata+"");

%>