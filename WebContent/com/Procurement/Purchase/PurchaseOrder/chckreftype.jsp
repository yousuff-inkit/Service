<%@page import="com.connection.*" %>
<%@page import="javax.sql.*"%>
<%@page import="com.common.*" %>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%

Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
ResultSet rs=null;
String gate=null;
Statement st=null;
try{
	JSONArray prdarray=new JSONArray();
	JSONObject objprd=new JSONObject(); 
	conn=ClsConnection.getMyConnection();
	st=conn.createStatement();
	
	String sql="select gate,doc_type from my_menu where doc_type in('CEQ','SQOT','PO')";
	System.out.println("qwer : "+sql);
	rs=st.executeQuery(sql);
	while(rs.next()){
		JSONObject objsub=new JSONObject();
		objsub.put("method",rs.getString("gate"));
		objsub.put("reftype",rs.getString("doc_type"));
		prdarray.add(objsub);
		//gate=rs.getString("gate");
	}
	objprd.put("refdata", prdarray);
	System.out.println("Res : "+gate);

	response.getWriter().print(objprd);
	rs.close();
	st.close();
	conn.close();
	
}catch(Exception e){
	e.printStackTrace();
	rs.close();
	st.close();
	conn.close();
}finally{
	rs.close();
	st.close();
	conn.close();
}
%>