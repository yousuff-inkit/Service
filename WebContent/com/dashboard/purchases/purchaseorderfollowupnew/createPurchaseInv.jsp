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
<%@page
	import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>

<%
	ClspurchaseinvoiceDAO ClspurchaseinvoiceDAO = new ClspurchaseinvoiceDAO();

String date = request.getParameter("date");
String billtype = request.getParameter("billtype");
String refno = request.getParameter("refno");
String locationid = request.getParameter("locationid");
String invno = request.getParameter("invno");
String invdate = request.getParameter("invdate");
String deldate = request.getParameter("deldate");
String delterms = request.getParameter("delterms");
String payterms = request.getParameter("payterms");
String desc = request.getParameter("desc");

String accdocno = request.getParameter("accdocno");
String brhid = request.getParameter("brhid");
String rownos = request.getParameter("rownos");

String prodlist = request.getParameter("prodlist") == null ? "0" : request.getParameter("prodlist");

Connection conn = null;
try {
	ClsConnection ClsConnection = new ClsConnection();
	ClsCommon ClsCommon = new ClsCommon();
	java.sql.Date dates = null;
	java.sql.Date deldates = null;
	java.sql.Date invdates = null;

	int val = 0;
	conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);

	Statement stmt = conn.createStatement();

	if (!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0"))) {
		dates = ClsCommon.changeStringtoSqlDate(date);
	}

	if (!(deldate.equalsIgnoreCase("undefined")) && !(deldate.equalsIgnoreCase(""))
	&& !(deldate.equalsIgnoreCase("0"))) {
		deldates = ClsCommon.changeStringtoSqlDate(deldate);
	}

	if (!(invdate.equalsIgnoreCase("undefined")) && !(invdate.equalsIgnoreCase(""))
	&& !(invdate.equalsIgnoreCase("0"))) {
		invdates = ClsCommon.changeStringtoSqlDate(invdate);
	}

	String curId = "1";
	double currRate = 1;
	String curSql = "select a.curid,a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate \r\n"
	+ "from my_curbook cb where coalesce(toDate,curdate())>='" + dates + "' and frmDate<='" + dates + "'\r\n"
	+ "group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) \r\n"
	+ "inner join my_head h on h.curid=a.curid\r\n" + "where h.doc_no='" + accdocno + "';";

	ResultSet curRs = stmt.executeQuery(curSql);
	while (curRs.next()) {
		curId = curRs.getString("curid");
		currRate = curRs.getDouble("rate");
	}

	String poDocNos = "";
	String poSql = "select distinct rdocno from my_ordd where rowno in (" + rownos + ") order by rdocno;";
	ResultSet poRs = stmt.executeQuery(poSql);
	while (poRs.next()) {
		poDocNos += poRs.getString("rdocno") + ",";
	}

	poDocNos = poDocNos.substring(0, poDocNos.length() - 1);

	int disstatus = 0, costtype = 0, costcode = 0;
	double amount = 0, disper = 0, discount = 0, roundVal = 0, netAmount = 0, supplExp = 0, prddiscount = 0,
	nettaxamount = 0;
	
	double mamount=0,mdiscount=0,mnettotal=0,taxamounts=0;

	ArrayList<String> masterarray = new ArrayList<String>();
	ArrayList<String> descarray = new ArrayList<String>();
	ArrayList<String> exparray = new ArrayList<String>();

	String aa[] = prodlist.split(",");
	for (int i = 0; i < aa.length; i++) {
		String bb[] = aa[i].split("::");
		String temp = "";
		for (int j = 0; j < bb.length; j++) {
			temp = temp + bb[j] + "::";
		}
		masterarray.add(temp);
		
		mamount = Double.parseDouble(bb[5]);
		mdiscount = Double.parseDouble(bb[6]);
		mnettotal = Double.parseDouble(bb[7]);
		taxamounts = Double.parseDouble(bb[18]);
		
		amount += mamount;
		prddiscount += mdiscount;
		netAmount += mnettotal;
		nettaxamount += taxamounts;
	}

	session.setAttribute("BRANCHID", brhid);

	val = ClspurchaseinvoiceDAO.insert(dates, deldates, refno, Integer.parseInt(accdocno), curId, currRate, delterms,
	payterms, desc, amount, disper, discount, roundVal, netAmount + nettaxamount, supplExp,
	netAmount + nettaxamount, disstatus, session, "A", "PIV", request, descarray, masterarray, "PO", poDocNos,
	prddiscount, exparray, 0.00, invdates, invno, Integer.parseInt(locationid), nettaxamount, 0.00, 0.00,
	nettaxamount, 0.00, Integer.parseInt(billtype), costtype, costcode, 0.0, 0.0, 0);

	if (val > 0) {
		conn.commit();
		conn.close();
	}

	response.getWriter().print(val);
	stmt.close();
	conn.close();

} catch (Exception e) {
	response.getWriter().print(0);
	conn.close();
	e.printStackTrace();
}
%>
