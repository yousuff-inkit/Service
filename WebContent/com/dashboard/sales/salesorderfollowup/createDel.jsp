<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.common.*"%>
<%@page import="com.sales.Sales.deliverynote.ClsDeliveryNoteDAO"%>

<%
ClsDeliveryNoteDAO DAO = new ClsDeliveryNoteDAO();

String date = request.getParameter("date");
String vatype = request.getParameter("vatype");
String refno = request.getParameter("refno");
String locationid = request.getParameter("locationid");
int salesmanid = request.getParameter("salesmanid") != "" ?  Integer.parseInt(request.getParameter("salesmanid")) : 0;
String desc = request.getParameter("desc");

int cldocno = Integer.parseInt(request.getParameter("cldocno"));
String brhid = request.getParameter("brhid");
String rownos = request.getParameter("rownos");

String prodlist = request.getParameter("prodlist") == null ? "0" : request.getParameter("prodlist");

Connection conn = null;
try {
	ClsConnection ClsConnection = new ClsConnection();
	ClsCommon ClsCommon = new ClsCommon();
	java.sql.Date dates = null;
	java.sql.Date payduedates = null;

	int val = 0;
	conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);

	Statement stmt = conn.createStatement();

	if (!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0"))) {
		dates = ClsCommon.changeStringtoSqlDate(date);
	}

	String curId = "1";
	String currRate = "1";

	String curSql = "select a.curid,a.rate,a.type,h.doc_no from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate \r\n"
	+ "from my_curbook cb where coalesce(toDate,curdate())>='" + dates + "' and frmDate<='" + dates + "'\r\n"
	+ "group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) \r\n"
	+ "inner join my_head h on h.curid=a.curid where h.cldocno='" + cldocno + "';";

	ResultSet curRs = stmt.executeQuery(curSql);
	while (curRs.next()) {
		curId = curRs.getString("curid");
		currRate = curRs.getString("rate");
	}
	
	String refDocNos = "";
	String refSql = "select distinct rdocno from my_sorderd where doc_no in (" + rownos + ") order by rdocno;";
	ResultSet refRs = stmt.executeQuery(refSql);
	while (refRs.next()) {
		refDocNos += refRs.getString("rdocno") + ",";
	}
	
	refDocNos = refDocNos.substring(0, refDocNos.length() - 1);

	ArrayList<String> masterarray = new ArrayList<String>();
	ArrayList<String> termsarray = new ArrayList<String>();
	ArrayList<String> servarray = new ArrayList<String>();
	ArrayList<String> shiparray = new ArrayList<String>();

	String aa[] = prodlist.split(",");
	for (int i = 0; i < aa.length; i++) {
		String bb[] = aa[i].split("::");
		String temp = "";
		for (int j = 0; j < bb.length; j++) {
			temp = temp + bb[j] + "::";
		}
		masterarray.add(temp);
	}
	
	session.setAttribute("BRANCHID", brhid);
		 
	val=DAO.insert(dates, refno, "1", curId, currRate, salesmanid, cldocno, "", "SOR", locationid, desc, 
			"0", "0", "0", "0", "0", "0", "A", "DEL",
			masterarray, termsarray, servarray, session, request, refDocNos, "0", locationid, shiparray, 0, vatype);

	String vocNo="0";

	if (val > 0) {
		vocNo=request.getAttribute("vdocNo").toString();
		conn.commit();
		conn.close();
	}

	response.getWriter().print(vocNo);
	stmt.close();
	conn.close();

} catch (Exception e) {
	response.getWriter().print(0);
	conn.close();
	e.printStackTrace();
}
%>
