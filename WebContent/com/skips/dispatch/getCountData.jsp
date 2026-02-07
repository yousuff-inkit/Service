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
	String strcountdata="select (select count(*) from in_underwriterm where estatus=17)  pcdocrcvd,(select count(*) from in_underwriterm where estatus=18)  cardsrcvd,(select count(*) from in_underwriterm where estatus=21)  sndbymsgr,(select count(*) from in_underwriterm where estatus=22)  bkdcorr";
	ResultSet rs=stmt.executeQuery(strcountdata);
	while(rs.next()){       
		result=rs.getString("pcdocrcvd")+"::"+rs.getString("cardsrcvd")+"::"+rs.getString("sndbymsgr")+"::"+rs.getString("bkdcorr");
	} 
	String sql2="select count(ass_user) ass_user from an_taskcreation where ass_user='"+session.getAttribute("USERID")+"' and close_status=0";     
	 //System.out.println("--------assgnuser----------"+sql2);   
	ResultSet rs12=stmt.executeQuery(sql2);      
	while(rs12.next()){
    	result+="::"+rs12.getString("ass_user");   
    }
	String sql3="select count(ass_user) ass_user from in_dispatchcreation where ass_user='"+session.getAttribute("USERID")+"' and close_status=0";     
	 //System.out.println("----in_dispatchcreation----assgnuser----------"+sql3);   
	ResultSet rs13=stmt.executeQuery(sql3);      
	while(rs13.next()){
   	result+="::"+rs13.getString("ass_user");   
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