<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
JSONObject objdata=new JSONObject();
try{
	JSONArray salarray=new JSONArray();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();   
	String strgetclient="select grpcode name,doc_no  from cm_serteamm where status=3";
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);          
	while(rsgetclient.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetclient.getString("doc_no"));   
		objtemp.put("name",rsgetclient.getString("name"));
		salarray.add(objtemp);
	}
	objdata.put("asgngrpdata",salarray);          
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>