<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int data=0;
	Statement stmt=conn.createStatement();
	String strsql="select method from gl_config where field_nme='MobConfig'";
	//System.out.println("config========="+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		data=rs.getInt("method");
	}
	response.getWriter().write(data+"####"+data);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}


%>