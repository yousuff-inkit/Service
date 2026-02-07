<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>


<%
	int id = request.getParameter("docno") == null ? 0 : Integer.parseInt(request.getParameter("docno"));
System.out.println("Test :======" + id);
Connection conn = null;
String date="";
String uname="";
String entry="";
try {

	ClsConnection ClsConnection = new ClsConnection();
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String sql = "select date_format(d.edate,'%d.%m.%Y %h:%i')  edate,case when d.entry='A' then 'ADD' when d.entry='E' then 'EDIT'  when d.entry='D' then 'DELETE' else '' END  entry,u.user_name from gl_enqm m left join (select max(trno) trno,doc_no,brhid,dtype,edate,entry from datalog group by doc_no,brhid,dtype) d on d.doc_no=m.voc_no and d.brhid=m.brhid and d.dtype='enq' left join datalog dd on dd.trno=d.trno left join my_user u on u.doc_no=m.userid where m.doc_no='"+id+"'";
	ResultSet rs=stmt.executeQuery(sql);
	
	if(rs.next()){
		date=rs.getString("edate");	
		
		uname=rs.getString("user_name");
		entry=rs.getString("entry");
	}
	
	System.out.println("TEest 1===="+date+"#####"+uname);
response.getWriter().print(uname+", "+date+", "+entry);

stmt.close();
conn.close();
} catch (Exception e) {
	e.printStackTrace();
	conn.close();

}finally{
	conn.close();

}
%>