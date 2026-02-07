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
	String strgetsalesman="select doc_no,sal_name name from my_salm where status=3";
	ResultSet rsgetsalesman=stmt.executeQuery(strgetsalesman);
	while(rsgetsalesman.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetsalesman.getString("doc_no"));
		objtemp.put("name",rsgetsalesman.getString("name"));
		salarray.add(objtemp);
	}
	objdata.put("salesmandata",salarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>