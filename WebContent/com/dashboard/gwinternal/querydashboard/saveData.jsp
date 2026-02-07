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
//System.out.println("Array Passed: "+request.getParameterValues("docnoarray[]"));
String docnoarray[]=request.getParameterValues("docnoarray[]");
String dept=request.getParameter("dept")==null?"":request.getParameter("dept");
String eddate=request.getParameter("eddate")==null || request.getParameter("eddate")==""?"0":request.getParameter("eddate").toString();
String chk=request.getParameter("chk")==null?"":request.getParameter("chk");
String dept1=request.getParameter("dept1")==null?"":request.getParameter("dept1");
String eddate1=request.getParameter("eddate1")==null || request.getParameter("eddate1")==""?"0":request.getParameter("eddate1").toString();



Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon objcommon=new ClsCommon();

	conn.setAutoCommit(false);
	java.sql.Date sqleddate = null;
	
    	if(!(eddate.equalsIgnoreCase("undefined"))&&!(eddate.equalsIgnoreCase(""))&&!(eddate.equalsIgnoreCase("0"))){
     		sqleddate=objcommon.changeStringtoSqlDate(eddate);
        }
    	java.sql.Date sqleddate1 = null;
    	
    	if(!(eddate1.equalsIgnoreCase("undefined"))&&!(eddate1.equalsIgnoreCase(""))&&!(eddate1.equalsIgnoreCase("0"))){
     		sqleddate1=objcommon.changeStringtoSqlDate(eddate1);
        }
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
		
		if(processstatus.equalsIgnoreCase("1")){
			if(chk.equalsIgnoreCase("1"))
			{
				if(dept1.equalsIgnoreCase(""))
				{
				String stredupdate="update gw_querym set eddate='"+sqleddate1+"' where doc_no="+docno;
				System.out.println(stredupdate);
				int edupdate=stmt.executeUpdate(stredupdate);
				}
				else
				{
					String stredupdate="update gw_querym set department='"+dept1+"',eddate='"+sqleddate1+"' where doc_no="+docno;
					System.out.println(stredupdate);
					int edupdate=stmt.executeUpdate(stredupdate);
				}
				
			}
			else
			{
			String strupdate="update gw_querym set formdocno="+formname+",priority='"+priority+"',department='"+dept+"',eddate='"+sqleddate+"',processstatus=3 where doc_no="+docno;
			System.out.println(strupdate);
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
			" processstatus, description)values("+docno+",now(),"+comprefid+","+userid+",2,'"+ackremarks+"')";
			//System.out.println(strfollowup);
			int followup=stmt.executeUpdate(strfollowup);
			if(followup<=0){
				errorstatus=1;
			}
			}
		}
		else if(processstatus.equalsIgnoreCase("3")){
			String strupdate="update gw_querym set processstatus=3 where doc_no="+docno;
			//System.out.println(strupdate);
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
			" processstatus, description)values("+docno+",now(),"+comprefid+","+userid+",3,'Email Sent')";
			//System.out.println(strfollowup);
			int followup=stmt.executeUpdate(strfollowup);
			if(followup<=0){
				errorstatus=1;
			}
		}
		else if(processstatus.equalsIgnoreCase("4")){
			String strupdate="update gw_querym set statusdocno="+status+",priorityseqno='"+priorityseqno+"',processstatus=4,teamdocno="+teamdocno+",empdocno="+empdocno+" where doc_no="+docno;
			//System.out.println(strupdate);
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
			" processstatus, description,memberdocno,teamdocno,empdocno,statusdocno)values("+docno+",now(),"+comprefid+","+userid+",4,'"+statusremarks+"',"+memberdocno+","+teamdocno+","+empdocno+","+status+")";
			//System.out.println(strfollowup);
			int followup=stmt.executeUpdate(strfollowup);
			if(followup<=0){
				errorstatus=1;
			}
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