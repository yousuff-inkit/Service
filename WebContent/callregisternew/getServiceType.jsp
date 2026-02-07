<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String compid=request.getParameter("compid")==null?"0":request.getParameter("compid");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
JSONObject objdata=new JSONObject();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int contracttrno=0,contractdocno=0;
	String strgetcontract="select tr_no,dtype,doc_no,date_format(validfrom,'%d.%m.%Y') fromdate,date_format(validupto,'%d.%m.%Y') todate from cm_srvcontrm where"+
	" cldocno="+compid+" and curdate() between validfrom and validupto and status=3";
	ResultSet rsgetcontract=stmt.executeQuery(strgetcontract);
	while(rsgetcontract.next()){
		objdata.put("contracttype",rsgetcontract.getString("dtype"));
		objdata.put("contractdocno",rsgetcontract.getString("doc_no"));
		objdata.put("contractfrom",rsgetcontract.getString("fromdate"));
		objdata.put("contractto",rsgetcontract.getString("todate"));
		objdata.put("contracttrno",rsgetcontract.getString("tr_no"));
		contracttrno=rsgetcontract.getInt("tr_no");
		contractdocno=rsgetcontract.getInt("doc_no");
		if(contracttrno>0){
			objdata.put("contractexpiry",0);
		}
	}
	if(contracttrno==0){
		objdata.put("contractexpiry",1);
	}
	
	/* String str="select grp.groupname,grp.doc_no from cm_srvcontrm m left join cm_srvcontrd d on (m.tr_no=d.tr_no) left join my_groupvals grp on "+
			" (d.servid=grp.doc_no) where cldocno="+compid+" and CURDATE() between validfrom and validupto"; */
	String str="select groupname,doc_no, CONVERT(coalesce(equips,''),CHAR(100)) item from cm_srvcontrd d left join my_groupvals g on "+
	" (d.servid=g.doc_no and grptype='service') where tr_no="+contracttrno;
	System.out.println(str);
	JSONArray servicetypearray=new JSONArray();
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("name", rs.getString("groupname"));
		objtemp.put("id",rs.getString("doc_no"));
		servicetypearray.add(objtemp);
	}
	String strgetpending="select d.description descriptions,d.cmplid complaintid,d.servid sertypeid,d.equips items,cs.groupname stypes,"+
	" cm.groupname complaints,st.site from cm_servplan s left join cm_cuscallm m on s.doc_no=m.tr_no left join cm_cuscalld d on s.doc_no=d.tr_no "+
	" left join cm_srvcsited st on st.rowno=s.siteid left join my_groupvals cs on (d.servid=cs.doc_no and cs.grptype='service') left join"+
	" my_groupvals cm on (d.cmplid=cm.doc_no and cm.grptype='complaints') where s.workper<>100 and s.dtype='CREG' and m.cldocno="+compid;
	System.out.println(strgetpending);
	ResultSet rsgetpending=stmt.executeQuery(strgetpending);
	JSONArray pendingarray=new JSONArray();
	int serial=1;
	while(rsgetpending.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("serial", serial);
		objtemp.put("servicetype",rsgetpending.getString("stypes"));
		objtemp.put("complaint",rsgetpending.getString("complaints"));
		objtemp.put("description",rsgetpending.getString("descriptions"));
		pendingarray.add(objtemp);
		serial++;
	}
	objdata.put("pendingdata",pendingarray);
	objdata.put("servicetypedata", servicetypearray);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>