<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONObject"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	JSONArray clientarray=new JSONArray();
	String str="select cldocno,refname,tax from my_acbook where status=3 and dtype='CRM'";
	ResultSet rs=conn.createStatement().executeQuery(str);
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("cldocno",rs.getString("cldocno"));
		objtemp.put("refname",rs.getString("refname"));
		objtemp.put("tax",rs.getString("tax"));
		clientarray.add(objtemp);
	}
	objdata.put("clientdata",clientarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>