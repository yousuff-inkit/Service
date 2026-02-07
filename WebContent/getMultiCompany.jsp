<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	Properties prop = new Properties();
	String filePath=request.getSession().getServletContext().getRealPath("/com/login/login.properties");
	filePath=filePath.replace("\\", "\\\\"); 
	FileInputStream ip=new FileInputStream(filePath);
	prop.load(ip);
	
	String dbname=prop.getProperty("intercompdb");
	String multicompconfig=prop.getProperty("multicompany");
	JSONArray dbdata=new JSONArray();
	if(multicompconfig.equals("1") || multicompconfig.equalsIgnoreCase("1")){
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		String strsql="select compname,doc_no,compurl from "+dbname+".my_intrcomp WHERE STATUS=3 group by  compname";
		ResultSet rs=conn.createStatement().executeQuery(strsql);
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("compname", rs.getString("compname"));
			objtemp.put("compurl", rs.getString("compurl"));
			objtemp.put("compdocno",rs.getString("doc_no"));
			dbdata.add(objtemp);
		}	
	}
	
	objdata.put("dbdata",dbdata);
	objdata.put("multicompconfig",multicompconfig);
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