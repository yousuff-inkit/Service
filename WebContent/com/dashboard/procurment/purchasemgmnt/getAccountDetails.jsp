<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%
JSONObject objdata=new JSONObject();
		String brch=session.getAttribute("BRANCHID").toString();
		String strSql ="";	
		ClsConnection ClsConnection=new ClsConnection();
		Connection conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		JSONArray vendorarray=new JSONArray();
		strSql="select a.tax,t.doc_no,t.cldocno,t.account,t.description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t  inner join my_acbook a on t.cldocno=a.cldocno and a.dtype='VND'	and t.atype='AP' where a.active=1 and t.m_s=0";
		System.out.println("Test : "+strSql);
		ResultSet resultSet = stmt.executeQuery(strSql);
		while(resultSet.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("cldocno",resultSet.getString("cldocno"));
			objtemp.put("acno",resultSet.getString("doc_no"));
			objtemp.put("desc",resultSet.getString("description"));
			objtemp.put("tax",resultSet.getString("tax"));
			System.out.println("Tax : "+resultSet.getString("tax"));
			vendorarray.add(objtemp);
		}
		
		objdata.put("vendordata", vendorarray);
		response.getWriter().write(objdata+"");
		resultSet.close();
		stmt.close();
		conn.close();


%>