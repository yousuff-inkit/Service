<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
JSONObject objdata=new JSONObject();
String assignid=request.getParameter("assignid")==null || request.getParameter("assignid")==""?"0":request.getParameter("assignid").trim().toString();
try{    
	JSONArray salarray=new JSONArray();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetclient="select s.empid doc_no,name from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no="+assignid+"";
	System.out.println("sql----->>>"+strgetclient);  
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);      
	while(rsgetclient.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetclient.getString("doc_no"));      
		objtemp.put("name",rsgetclient.getString("name"));
		salarray.add(objtemp);
	}
	objdata.put("asgnmembrdata",salarray);              
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>