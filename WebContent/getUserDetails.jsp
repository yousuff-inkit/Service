<%@page import="com.common.ClsEncrypt"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connection.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
String username=request.getParameter("username")==null?"":request.getParameter("username");
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	String strsql="select user_id,pass from my_user where user_id='"+username+"' and status=3";
	ResultSet rs=conn.createStatement().executeQuery(strsql);
	
	while(rs.next()){
		objdata.put("userid", username);
		objdata.put("password", objencrypt.decrypt(rs.getString("pass")));
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>