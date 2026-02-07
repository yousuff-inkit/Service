<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
int errorstatus=0;
Connection conn=null;
String datechk = request.getParameter("datechk")==null?"":request.getParameter("datechk").trim().toString(); 
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();   
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon objcommon=new ClsCommon(); 
	Statement stmt=conn.createStatement();
	String sqltest="";  
	if(datechk.equalsIgnoreCase("1")) {   
		if(!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("0")) {
			sqltest+=" and m.enddt>'"+objcommon.changeStringtoSqlDate(todate)+"'";     
		}
	}
	String strcountdata="select (select count(*) from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no where d.srdocno>0 and m.status<>7 "+sqltest+") serreq";  
	ResultSet rs=stmt.executeQuery(strcountdata);
	while(rs.next()){       
		result=rs.getString("serreq");        
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