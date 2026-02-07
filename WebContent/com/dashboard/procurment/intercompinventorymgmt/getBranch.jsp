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
	JSONArray docarray=new JSONArray();
	String str="SELECT doc_no docno,branchname refname FROM my_brch WHERE STATUS=3";
	ResultSet rs=conn.createStatement().executeQuery(str);
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getString("docno"));
		objtemp.put("refname",rs.getString("refname"));
		docarray.add(objtemp);
	}
	objdata.put("docdata",docarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>