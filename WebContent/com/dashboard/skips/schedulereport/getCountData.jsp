<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();  
String cntrno=request.getParameter("contrno")==null?"":request.getParameter("contrno").toString();  
String fromdate=request.getParameter("fdate")==null?"":request.getParameter("fdate").toString();  
String todate=request.getParameter("tdate")==null?"":request.getParameter("tdate").toString();  
String routeid=request.getParameter("routeid")==null?"":request.getParameter("routeid").toString();  
String result="";
int errorstatus=0;
ClsCommon ClsCommon=new ClsCommon();
JSONObject objdata=new JSONObject(); 
ClsConnection objconn=new ClsConnection(); 
try{
	Connection conn=objconn.getMyConnection(); 
	Date fdate=null;
	Date tdate=null;
	String sqadd="";
	String sqaddel="";
	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	     fdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     sqadd +=" and sc.date>='"+fdate+"'"; 
	     sqaddel +=" and sd.deldate>='"+fdate+"'"; 
	}
	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     tdate=ClsCommon.changeStringtoSqlDate(todate);
	     sqadd +=" and sc.date<='"+tdate+"'"; 
	     sqaddel +=" and sd.deldate<='"+tdate+"'"; 
	}
	
	if(!(cntrno.equalsIgnoreCase("undefined"))&&!(cntrno.equalsIgnoreCase(""))&&!(cntrno.equalsIgnoreCase("0"))){
	     sqadd +=" and sc.rdocno='"+cntrno+"'"; 
	     sqaddel +=" and sd.rdocno='"+cntrno+"'"; 
	}
	
	if(!routeid.equalsIgnoreCase("undefined") && !routeid.equalsIgnoreCase("") && !routeid.equalsIgnoreCase("0")) {  
		sqadd+=" and (sc.routeid='"+routeid+"' or dl.routeid='"+routeid+"')";                                               
	}
	if(!cldocno.equalsIgnoreCase("undefined") && !cldocno.equalsIgnoreCase(null) && !cldocno.equalsIgnoreCase("0")&& !cldocno.equalsIgnoreCase("")) {  
		sqadd+=" and (cm.cldocno='"+cldocno+"' )";                                      
		sqaddel+=" and (cm.cldocno='"+cldocno+"' )";                    
	}
	
	
	Statement stmt=conn.createStatement();
	String sql = "SELECT SUM(CASE WHEN sc.statusid = 1 THEN 1 ELSE 0 END) completed,SUM(CASE WHEN sc.statusid = 2 THEN 1 ELSE 0 END) dropped,SUM(CASE WHEN sc.statusid = 3 THEN 1 ELSE 0 END) noshow,SUM(CASE WHEN sc.statusid = 4 THEN 1 ELSE 0 END) visitchargeable , SUM(CASE WHEN sc.statusid = 5 THEN 1 ELSE 0 END) visitfree, SUM(CASE WHEN sc.statusid = 6 THEN 1 ELSE 0 END) cancelled, SUM(CASE WHEN sc.statusid NOT IN (1,2,3,4,5,6) THEN 1 ELSE 0 END) pending  FROM sk_srvcontrsch sc left join sk_srvcontrdel dl on dl.doc_no=sc.delid left join sk_srvcontrm cm on cm.tr_no=sc.rdocno where 1=1 "+sqadd+" ";	
	ResultSet rs = stmt.executeQuery(sql);
	while(rs.next()){
		objdata.put("completed", rs.getObject("completed"));
		objdata.put("dropped", rs.getObject("dropped"));
		objdata.put("noshow", rs.getObject("noshow"));
		objdata.put("visitchargeable", rs.getObject("visitchargeable"));
		objdata.put("visitfree", rs.getObject("visitfree"));
		objdata.put("cancelled", rs.getObject("cancelled"));
		objdata.put("pending", rs.getObject("pending"));
	}
	String sqld = "select (SELECT COUNT(*) FROM `sk_srvcontrdet` sd left join sk_srvcontrm cm on cm.tr_no=sd.rdocno WHERE sd.statusid=2 "+sqaddel+") delivery";
	rs = stmt.executeQuery(sqld);
	while(rs.next()){
		objdata.put("delivery", rs.getObject("delivery"));
	}
	
	} catch (Exception e) {
	e.printStackTrace();   
}
response.getWriter().write(result+"####"+objdata);    
%>