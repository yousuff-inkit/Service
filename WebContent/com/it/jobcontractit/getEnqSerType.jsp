<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>

<%
	String quoteid = request.getParameter("quoteid").toString();
	Connection conn = null;

	try {
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();

		String strSql = "select coalesce(gr.groupname)groupname from cm_srvqotm qt left join gl_enqm eq on eq.doc_no=qt.refDocNo and qt.ref_type='ENQ' left join my_groupvals gr on eq.sertypeid=gr.doc_no where qt.doc_no="
				+ quoteid;
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
