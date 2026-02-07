<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject data=new JSONObject();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String comprefid=request.getParameter("comprefid")==null?"":request.getParameter("comprefid");
String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
String docnoarray[]=request.getParameterValues("docnoarray[]");
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strdocno="";
	for(int i=0;i<docnoarray.length;i++){
		docno=docnoarray[i];	
		if(strdocno.equalsIgnoreCase("")){
			strdocno+=docno;	
		}
		else{
			strdocno+=","+docno;
		}
		
		String strupdate="update gw_querym set type=3 where doc_no="+docno;
		int update=stmt.executeUpdate(strupdate);
		if(update<0){
			errorstatus=1;
		}
			
		String strgetcomprefid="select comprefid from gw_querym where doc_no="+docno;
		//System.out.println(strgetcomprefid);
		ResultSet rsgetcomprefid=stmt.executeQuery(strgetcomprefid);
		while(rsgetcomprefid.next()){
			comprefid=rsgetcomprefid.getString("comprefid");
		}
		
		String strfollowup="insert into gw_queryfollowup(rdocno, entrydate, comprefid,gwuserid, "+
		" processstatus, description)values("+docno+",now(),"+comprefid+","+userid+",2,'Project Management done')";
		int followup=stmt.executeUpdate(strfollowup);
		if(followup<=0){
			errorstatus=1;
		}
	}
	
	data.put("errorstatus",errorstatus);
	data.put("docno",strdocno);
	if(errorstatus==0){
		conn.commit();
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>