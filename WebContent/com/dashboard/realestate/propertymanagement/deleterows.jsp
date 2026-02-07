<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String rowno=request.getParameter("rowno")==null || request.getParameter("rowno")==""?"0":request.getParameter("rowno");
ClsConnection objconn=new ClsConnection();          
Connection conn=null;         
int status=0,val=0,test1=0,test2=0;        
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strSql = "select coalesce(s.rowno,0) rowno from rl_propertysub s left join rl_propertymaster m on m.doc_no=s.propertyid left join rl_tncm t on (t.doc_no=m.cnt_no and m.cnt_type is null) where ((t.period_from<curdate() and t.period_to<curdate()) or m.cnt_no=0) and s.rowno='"+rowno+"' group by s.rowno;";    
	//System.out.println("strSql===="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	while(rs.next()) {
		test1=rs.getInt("rowno");                           
	}
	String strSql2 = "select coalesce(s.rowno,0) rowno from rl_propertysub s left join rl_rental r on (r.propertyid=s.propertyid and coalesce(propertysub,0)=coalesce(srno) and r.cancelstatus=0) where ((r.fromdate<curdate() and r.todate<curdate()) or r.doc_no is null) and s.rowno='"+rowno+"' group by s.rowno";    
	//System.out.println("strSql===="+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);
	while(rs2.next()) {
		test2=rs2.getInt("rowno");                                     
	}  
	if(test1>0 && test2>0){                 
		String strgetmsg="update rl_propertysub set status=7 where rowno='"+rowno+"'";                
		//System.out.println("strSql===="+strgetmsg);                   
		val=stmt.executeUpdate(strgetmsg);  
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);  
%>