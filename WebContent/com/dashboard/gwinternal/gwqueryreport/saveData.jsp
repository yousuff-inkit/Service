<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject data=new JSONObject();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String comprefid=request.getParameter("comprefid")==null?"":request.getParameter("comprefid");
String formname=request.getParameter("formname")==null?"":request.getParameter("formname");
String priority=request.getParameter("priority")==null?"":request.getParameter("priority");
String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
String processstatus=request.getParameter("processstatus")==null?"":request.getParameter("processstatus");
String ackremarks=request.getParameter("ackremarks")==null?"":request.getParameter("ackremarks");
String statusremarks=request.getParameter("statusremarks")==null?"":request.getParameter("statusremarks");
String status=request.getParameter("status")==null?"":request.getParameter("status");
String priorityseqno=request.getParameter("priorityseqno")==null?"":request.getParameter("priorityseqno");
String teamdocno=request.getParameter("teamdocno")==null?"":request.getParameter("teamdocno");
String empdocno=request.getParameter("empdocno")==null?"":request.getParameter("empdocno");
String memberdocno=request.getParameter("memberdocno")==null?"":request.getParameter("memberdocno");


Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	if(processstatus.equalsIgnoreCase("1")){
		String strupdate="update gw_querym set formdocno="+formname+",priority='"+priority+"',processstatus=2 where doc_no="+docno;
		int update=stmt.executeUpdate(strupdate);
		if(update<0){
			errorstatus=1;
		}
		
		String strfollowup="insert into gw_queryfollowup(rdocno, entrydate, comprefid,gwuserid, "+
		" processstatus, description)values("+docno+",now(),"+comprefid+","+userid+",2,'"+ackremarks+"')";
		int followup=stmt.executeUpdate(strfollowup);
		if(followup<=0){
			errorstatus=1;
		}
	}
	else if(processstatus.equalsIgnoreCase("3")){
		String strupdate="update gw_querym set processstatus=3 where doc_no="+docno;
		int update=stmt.executeUpdate(strupdate);
		if(update<0){
			errorstatus=1;
		}
		ResultSet rsgetcomprefid=stmt.executeQuery("select comprefid from gw_querym where doc_no="+docno);
		while(rsgetcomprefid.next()){
			comprefid=rsgetcomprefid.getString("comprefid");
		}
		String strfollowup="insert into gw_queryfollowup(rdocno, entrydate, comprefid,gwuserid, "+
		" processstatus, description)values("+docno+",now(),"+comprefid+","+userid+",3,'Email Sent')";
		int followup=stmt.executeUpdate(strfollowup);
		if(followup<=0){
			errorstatus=1;
		}
	}
	else if(processstatus.equalsIgnoreCase("4")){
		String strupdate="update gw_querym set statusdocno="+status+",priorityseqno='"+priorityseqno+"',processstatus=4,teamdocno="+teamdocno+",empdocno="+empdocno+" where doc_no="+docno;
		int update=stmt.executeUpdate(strupdate);
		if(update<0){
			errorstatus=1;
		}
		
		String strfollowup="insert into gw_queryfollowup(rdocno, entrydate, comprefid,gwuserid, "+
		" processstatus, description,memberdocno,teamdocno,empdocno,statusdocno)values("+docno+",now(),"+comprefid+","+userid+",4,'"+statusremarks+"',"+memberdocno+","+teamdocno+","+empdocno+","+status+")";
		int followup=stmt.executeUpdate(strfollowup);
		if(followup<=0){
			errorstatus=1;
		}
	}
	data.put("errorstatus",errorstatus);
	data.put("docno",docno);
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