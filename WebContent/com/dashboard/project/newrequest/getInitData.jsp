<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	String strsql="select rowno,name from cm_nrstatus where status=3";
	Statement stmt=conn.createStatement();
	ResultSet rs=stmt.executeQuery(strsql);
	JSONArray statusarray=new JSONArray();
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("id",rs.getString("rowno"));
		objtemp.put("name",rs.getString("name"));
		statusarray.add(objtemp);
	}
	objdata.put("statusdata",statusarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>