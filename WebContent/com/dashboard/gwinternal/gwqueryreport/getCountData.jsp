<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject data=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetcomp="select comp_id docno,company refname from gw_complist";
	ResultSet rsgetcomp=stmt.executeQuery(strgetcomp);
	JSONArray comparray=new JSONArray();
	while(rsgetcomp.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetcomp.getString("docno"));
		objtemp.put("refname",rsgetcomp.getString("refname"));
		comparray.add(objtemp);
	}
	String strgetforms="select doc_no docno,formname refname from gw_formnames where status=3";
	ResultSet rsgetforms=stmt.executeQuery(strgetforms);
	JSONArray formarray=new JSONArray();
	while(rsgetforms.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetforms.getString("docno"));
		objtemp.put("refname",rsgetforms.getString("refname"));
		formarray.add(objtemp);
	}
	String strgetstatus="select doc_no docno,description refname from cm_assignstatus where status=3";
	ResultSet rsgetstatus=stmt.executeQuery(strgetstatus);
	JSONArray statusarray=new JSONArray();
	while(rsgetstatus.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetstatus.getString("docno"));
		objtemp.put("refname",rsgetstatus.getString("refname"));
		statusarray.add(objtemp);
	}
	String strgetmember="select concat(name,' - ',grpcode) member,s.doc_no,s.rdocno teamdocno,name,grpcode,s.empid empdocno from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no)"+
	" left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3";
	ResultSet rsgetmember=stmt.executeQuery(strgetmember);
	JSONArray memberarray=new JSONArray();
	while(rsgetmember.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetmember.getString("doc_no"));
		objtemp.put("member",rsgetmember.getString("member"));
		objtemp.put("teamdocno",rsgetmember.getString("teamdocno"));
		objtemp.put("empdocno",rsgetmember.getString("empdocno"));
		memberarray.add(objtemp);
	}
	data.put("companydata",comparray);
	data.put("formdata",formarray);
	data.put("statusdata",statusarray);
	data.put("memberdata",memberarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>