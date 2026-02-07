<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="com.dashboard.*"%>
<%@page import="java.sql.*"%>

<%
	
	JSONObject data=new JSONObject();
	JSONObject fleetdistdata=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strgetcomp="select comp_id docno,company from gw_complist";
		ResultSet rsgetcomp=stmt.executeQuery(strgetcomp);
		JSONArray comparray=new JSONArray();
		while(rsgetcomp.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetcomp.getString("docno"));
			objtemp.put("name",rsgetcomp.getString("company"));
			comparray.add(objtemp);
		}
		objdata.put("compdata",comparray);
	
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	response.getWriter().write(objdata.toString());
%>