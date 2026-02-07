<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%
int id = request.getParameter("docno") == null || request.getParameter("docno").equals("") ? 0 : Integer.parseInt(request.getParameter("docno"));
Connection conn = null;
String label=""; 
try {

	ClsConnection ClsConnection = new ClsConnection();
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String sql = "select concat(if(coalesce(user_name,'')!='',cast(concat(' : ',user_name)AS CHAR CHARACTER SET utf8),'') ,' ',if(edate is not null,cast(concat(' : ',edate)AS CHAR CHARACTER SET utf8),''),' ',if(coalesce(entry,'')!='',cast(concat(' : ',entry)AS CHAR CHARACTER SET utf8),''),' ',cast(status AS CHAR CHARACTER SET utf8)) label from(select date_format(d.edate,'%d.%m.%Y %h:%i')  edate,case when d.entry='A' then 'ADD' when d.entry='E' then 'EDIT'  when d.entry='D' then 'DELETE' else '' END  entry,u.user_name, if(m.status=10,' : Terminated','') status from sk_srvcontrm m left join (select max(trno) trno,doc_no,brhid,dtype,edate,entry from datalog group by doc_no,brhid,dtype) d on d.doc_no=m.doc_no and d.brhid=m.brhid and d.dtype='AMC' left join datalog dd on dd.trno=d.trno left join my_user u on u.doc_no=m.userid where m.tr_no='"+id+"')a";
	System.out.println("Test"+sql);
	ResultSet rs=stmt.executeQuery(sql);         
	if(rs.next()){
		label=rs.getString("label");	
	}
	
response.getWriter().print(label);  

stmt.close();
conn.close();
} catch (Exception e) {
	e.printStackTrace();
	conn.close();

}finally{
	conn.close();

}
%>