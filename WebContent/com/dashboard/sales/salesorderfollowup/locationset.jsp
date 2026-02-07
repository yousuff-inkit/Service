<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.ClsEncrypt"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");

String location = "", docno = "";

Connection conn = null;
try {
	ClsConnection ClsConnection = new ClsConnection();
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String strSql = "select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="
	+ brhid + "  group by m.brhid order by m.doc_no asc";

	ResultSet rs = stmt.executeQuery(strSql);
	int userid = 0;
	while (rs.next()) {
		docno = rs.getString("doc_no");
		location = rs.getString("location");
	}

	stmt.close();
	conn.close();

	response.getWriter().print(docno + "::" + location);
} catch (Exception e) {
	e.printStackTrace();
	conn.close();
}
%>