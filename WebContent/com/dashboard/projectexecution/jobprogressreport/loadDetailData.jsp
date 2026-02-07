<%@page import="com.dashboard.projectexecution.jobprogressreport.ClsjobProgressReportDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsCommon objcommon=new ClsCommon();
String jobno=request.getParameter("jobno")==null?"":request.getParameter("jobno");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String salesman=request.getParameter("salesman")==null?"":request.getParameter("salesman");
String contracttype=request.getParameter("contracttype")==null?"":request.getParameter("contracttype").toString();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
ClsjobProgressReportDAO dao=new ClsjobProgressReportDAO();
java.sql.Date sqltodate=null;
if(!todate.equalsIgnoreCase("")){
	sqltodate=objcommon.changeStringtoSqlDate(todate);
}
JSONObject objdetaildata=new JSONObject();
objdetaildata.put("detaildata", dao.getJobProgressDetailData(sqltodate,contracttype,session,salesman,branch));
//System.out.println(objdetaildata);
response.getWriter().write(objdetaildata+"");
%>