<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
int errorstatus=0;
Connection conn=null;
String comprefid=request.getParameter("comprefid")==null?"":request.getParameter("comprefid");
String empdocno=request.getParameter("empdocno")==null?"":request.getParameter("empdocno");
String type=request.getParameter("type")==null?"":request.getParameter("type");
System.out.println("comprefid=="+comprefid+"empdocno==="+empdocno+"type==="+type);
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="";
	if(!comprefid.equalsIgnoreCase("") && !comprefid.equalsIgnoreCase("a")){
		sqltest+=" and gm.comprefid="+comprefid;
	}
	if(!empdocno.equalsIgnoreCase("") && !empdocno.equalsIgnoreCase("undefined")){
		sqltest+=" and gm.empdocno="+empdocno;
	}
	if(!type.equalsIgnoreCase("") && !type.equalsIgnoreCase("undefined")){
		sqltest+=" and gm.type="+type;
	}
	sqltest+=" and gm.status=3 and gm.statusdocno<8 ";
	
	String strcountdata="select (select count(*) from gw_querym gm where priority='MO' "+sqltest+") dccount,"+
			" (select count(*) from gw_querym gm where priority='CS' "+sqltest+") cscount,"+
			" (select count(*) from gw_querym gm where priority='RO' "+sqltest+") rocount,"+
			" (select count(*) from gw_querym gm where priority='MI' "+sqltest+") micount,"+
			" (select count(*) from gw_querym gm where priority='SCR' "+sqltest+") scrcount,"+
			" (select count(*) from gw_querym gm where priority='NW' "+sqltest+") nwcount,"+
			" (select count(*) from gw_querym gm where priority='' "+sqltest+") nacount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%entered%' "+sqltest+") enteredcount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%documented%' "+sqltest+") documentedcount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%started%' "+sqltest+") startedcount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%on hold%' "+sqltest+") onholdcount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%completed%' "+sqltest+") completedcount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%tested%' "+sqltest+") testedcount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%deployed%' "+sqltest+") deployedcount,"+
			" (select count(*) from gw_querym gm left join cm_assignstatus cs on gm.statusdocno=cs.doc_no where cs.description like'%client confirmed%' "+sqltest+") confirmcount ";
System.out.println("strcountdata===="+strcountdata);
	ResultSet rs=stmt.executeQuery(strcountdata);
	while(rs.next()){
		result=rs.getString("dccount")+"::"+rs.getString("cscount")+"::"+rs.getString("rocount")+"::"+rs.getString("micount")+"::"+rs.getString("scrcount")+"::"+rs.getString("nwcount")+"::"+rs.getString("nacount")+"::"+rs.getString("enteredcount")+"::"+rs.getString("documentedcount")+"::"+rs.getString("startedcount")+"::"+rs.getString("onholdcount")+"::"+rs.getString("completedcount")+"::"+rs.getString("testedcount")+"::"+rs.getString("deployedcount")+"::"+rs.getString("confirmcount");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>