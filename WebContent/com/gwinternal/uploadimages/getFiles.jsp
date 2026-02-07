<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.io.File"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	String imgpath="";
	String strgetimgpath="select imgpath from my_comp where doc_no=1";
	Statement stmt=conn.createStatement();
	ResultSet rsgetimgpath=stmt.executeQuery(strgetimgpath);
	while(rsgetimgpath.next()){
		imgpath=rsgetimgpath.getString("imgpath");
	}
	imgpath.replaceAll("//","////");
	
	
	File dir=new File(imgpath+"//icons");
	File filearray[]=dir.listFiles();
	JSONArray filenamearray=new JSONArray();
	for(File file:filearray){
		JSONObject objtemp=new JSONObject();
		objtemp.put("filename",file.getName());
		filenamearray.add(objtemp);
	}
	JSONArray dbiconarray=new JSONArray();
	
	String strgeticons="select name,type from my_icons";
	ResultSet rsgeticons=stmt.executeQuery(strgeticons);
	while(rsgeticons.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("type",rsgeticons.getInt("type"));
		objtemp.put("name",rsgeticons.getString("name"));
		dbiconarray.add(objtemp);
	}	
	objdata.put("filedata",filenamearray);
	objdata.put("dbicondata",dbiconarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>