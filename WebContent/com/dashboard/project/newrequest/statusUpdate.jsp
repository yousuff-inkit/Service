<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
	String cmbstatus=request.getParameter("cmbstatus")==null?"":request.getParameter("cmbstatus");
	String statusupdateremarks=request.getParameter("statusupdateremarks")==null?"":request.getParameter("statusupdateremarks");
	ClsConnection objconn=new ClsConnection();
	Connection conn=null;
	int errorstatus=0;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String strupdate="update cm_cuscallm set nrstatus="+cmbstatus+" where doc_no="+jobcarddocno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
		else{
			String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
			String branchid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
			String strloginsert="insert into my_creglog(docno, remarks, autodate, userid, brhid)values("+jobcarddocno+",'"+statusupdateremarks+"',now(),"+userid+","+branchid+")";
			int loginsert=stmt.executeUpdate(strloginsert);
			if(loginsert<=0){
				errorstatus=1;
			}
		}
		
		if(errorstatus==0){
			conn.commit();
		}
		response.getWriter().write(errorstatus+"");
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=0;
	}
	finally{
		conn.close();
	}
	
%>