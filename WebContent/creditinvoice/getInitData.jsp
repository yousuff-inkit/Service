
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
String insptype=request.getParameter("insptype")==null?"":request.getParameter("insptype");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").toString();
String requestdocno=request.getParameter("requestdocno")==null?"0":request.getParameter("requestdocno").toString();
/* System.out.println("User ID:"+userid);
System.out.println("Insp Type:"+insptype);
System.out.println("Mode:"+mode);
System.out.println("Request Doc No:"+requestdocno); */

try{
	ClsConnection objconn=new ClsConnection();
	
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="";
	
	String strgetdocuments="";
	strgetdocuments="select category,doc_no from my_catm where status=3";
	System.out.println("strgetdocuments======="+strgetdocuments);
	ResultSet rsdoc=stmt.executeQuery(strgetdocuments);
	JSONArray docarray=new JSONArray();
	while(rsdoc.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("doc_no",rsdoc.getString("doc_no"));
		objtemp.put("catname",rsdoc.getString("category"));
		
		docarray.add(objtemp);
	}
	System.out.println("docarray======="+docarray);
	String username=session.getAttribute("USERNAME")==null?"":session.getAttribute("USERNAME").toString();
	
	objdata.put("username",username);
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