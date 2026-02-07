<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();
Connection conn=null;
JSONObject objexenq=new JSONObject();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select compname,dbname from intercompany.my_intrcomp where status=3";
   	//System.out.println(strsql);
	ArrayList<String> enqarray=new ArrayList();
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		enqarray.add(rs.getString("compname")+"::"+rs.getString("dbname"));        
	}     
	objexenq.put("exenqarray", enqarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objexenq+"");
%>