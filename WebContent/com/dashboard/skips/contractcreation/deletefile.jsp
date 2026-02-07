<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
String srno=request.getParameter("docno")==null?"0": request.getParameter("docno").toString();
ClsConnection clsConnection = new ClsConnection();
Connection con=null;
int id;
try{
	con=clsConnection.getMyConnection();
	Statement st=con.createStatement();
	String sql="update sk_checklistdet skc left join sk_srvqotm srvq on skc.qotno=srvq.tr_no left join my_fileattach f on f.doc_no=srvq.cldocno and skc.attach=f.filename and srvq.brhid=f.brhid and f.dtype='CRM' set skc.attach='',skc.path='',f.status=7 where skc.rowno='"+srno+"'";
	 id=st.executeUpdate(sql);
System.out.println("ID is :"+id);
	 response.getWriter().print(id+"####"+"####"+id);
	 con.close();
	 st.close();
	System.out.println("SRN on delete :"+srno);
}catch(Exception e){
	e.printStackTrace();
	con.close();
}



%>