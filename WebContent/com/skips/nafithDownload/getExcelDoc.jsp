<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	String username=request.getParameter("username")==null?"":request.getParameter("username").toString();
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetdocno="select coalesce(max(doc_no),0)+1 maxdocno from gl_nafithm";
	ResultSet rsgetdocno=stmt.executeQuery(strgetdocno);
	int maxdocno=0;
	while(rsgetdocno.next()){
		maxdocno=rsgetdocno.getInt("maxdocno");
		objdata.put("exceldocno",maxdocno);
	}
	String userid=session.getAttribute("USERID").toString();
	String brhid=session.getAttribute("BRANCHID").toString();
	
	String strinsertmaster="insert into gl_nafithm(doc_no,date,userid,brhid,status,username)values("+maxdocno+",CURDATE(),"+userid+","+brhid+",3,'"+username+"')";
	int insertmaster=stmt.executeUpdate(strinsertmaster);
	if(insertmaster<=0){
		errorstatus=1;
	}
	session.setAttribute("ITEMCURRENTDOCNO",maxdocno);
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
