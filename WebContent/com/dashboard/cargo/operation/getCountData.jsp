<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();     
	String strcountdata="select (select count(*) from cm_srvcontrm where status<>7 and confirm=0 and tr_no>0 and docstatus is null) entered,(select count(*) from cm_srvcontrm where status<>7 and confirm=0 and tr_no>0 and docstatus='Job settled') jobsettled,(select count(*) from(select m.tr_no from cm_srvcontrm m left join cr_assignment cc on m.tr_no=cc.jobno left join cr_cstatus cs on cs.doc_no=cc.cur_status where m.status<>7 and m.confirm=0 and m.tr_no>0 and cs.name='COMPLETED' group by m.tr_no)b) completed,(select count(*) from cm_srvcontrm where status<>7 and confirm=0 and tr_no>0 and docstatus='Advance paid')  advancepaid,(select count(*) from(select m.tr_no from cm_srvcontrm m left join cr_assignment cc on m.tr_no=cc.jobno left join cr_cstatus cs on cs.doc_no=cc.cur_status where m.status<>7 and m.confirm=0 and m.tr_no>0 and cs.name='BOOKED' group by m.tr_no)c) booked,(select count(*) from(select m.tr_no from cm_srvcontrm m left join cr_assignment cc on m.tr_no=cc.jobno left join cr_cstatus cs on cs.doc_no=cc.cur_status where m.status<>7 and m.confirm=0 and m.tr_no>0 and cs.name='DELIVERED' group by m.tr_no)d) delivered";
	ResultSet rs=stmt.executeQuery(strcountdata);
	while(rs.next()){       
		result=rs.getString("entered")+"::"+rs.getString("jobsettled")+"::"+rs.getString("completed")+"::"+rs.getString("advancepaid")+"::"+rs.getString("booked")+"::"+rs.getString("delivered");
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