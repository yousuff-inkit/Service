<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>

<%
	String enqid = request.getParameter("enqid").toString();
	Connection conn = null;

	try {
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();

		String strSql = "select coalesce(gr.groupname)groupname from gl_enqm m left join my_groupvals gr on m.sertypeid=gr.doc_no where m.doc_no="
				+ enqid;
		ResultSet rs = stmt.executeQuery(strSql);
		String serType = "";
		while (rs.next()) {
			serType = rs.getString("groupname");
		}

		response.getWriter().write(serType);

		stmt.close();
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		conn.close();
	} finally {
		conn.close();
	}
%>
