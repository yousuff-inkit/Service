<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	String str="SELECT doc_no docno,loc_name refname FROM my_locm WHERE brhid=1 AND STATUS=3";
	ResultSet rs=conn.createStatement().executeQuery(str);
	JSONArray locarray=new JSONArray();
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getString("docno"));
		objtemp.put("refname",rs.getString("refname"));
		locarray.add(objtemp);
	}
	objdata.put("docdata",locarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
