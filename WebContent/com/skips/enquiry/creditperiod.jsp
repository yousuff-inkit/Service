<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String strSql = "select j.acno,period,period2,datediff(curdate(),min(j.date)) days from my_acbook a inner join my_jvtran j on a.acno=j.acno and j.status=3 where a.dtype='crm' and a.cldocno='"+cldocno+"' group by a.acno having  period2<days";
	//System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
    
	if(rs.next()) {
		val=1;
  		} 
	
	stmt.close();
	conn.close();  

	response.getWriter().print(val); 
	//System.out.println("---Val--"+val);

}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>