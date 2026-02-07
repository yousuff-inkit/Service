<%@page import="java.sql.ResultSet"%>
<%@page import="com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String refdocno=request.getParameter("refdocno")==null?"":request.getParameter("refdocno");

String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String locid=request.getParameter("locid")==null?"":request.getParameter("locid");
String billtype=request.getParameter("billtype")==null?"":request.getParameter("billtype");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");

String[] strprodarray=request.getParameterValues("prodarray[]");
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClspurchaseinvoiceDAO pivdao=new ClspurchaseinvoiceDAO();
	java.sql.Date sqldate=null,sqlinvdate=null;
	if(!date.trim().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	
	if(!invdate.trim().equalsIgnoreCase("")){
		sqlinvdate=objcommon.changeStringtoSqlDate(invdate);
	}
	
	ArrayList<String> blankarray=new ArrayList<>();
	double total=0.0,taxamount=0.0,discount=0.0,taxtotal=0.0;
	ArrayList<String> prodarray=new ArrayList<>();
	
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int vendoracno=0;
	int vendorcurid=0;
	double vendorcurrate=0.0;
	String strvendor="select ac.acno,h.curid,h.rate from my_acbook ac left join my_head h on ac.acno=h.doc_no where ac.cldocno="+cldocno+" and ac.dtype='VND' and ac.status=3";
	ResultSet rsvendor=stmt.executeQuery(strvendor);
	while(rsvendor.next()){
		vendoracno=rsvendor.getInt("acno");
		vendorcurid=rsvendor.getInt("curid");
		vendorcurrate=rsvendor.getDouble("rate");
	}
	
	
	for(int i=0;i<strprodarray.length;i++){
		String[] temp=strprodarray[i].split("::");
		total+=Double.parseDouble(strprodarray[i].split("::")[5].trim());
		discount+=Double.parseDouble(strprodarray[i].split("::")[5].trim());
		taxamount+=Double.parseDouble(strprodarray[i].split("::")[18].trim());
		taxtotal+=Double.parseDouble(strprodarray[i].split("::")[19].trim());
		prodarray.add(strprodarray[i]);
	}
	
	/* Date masterdate, Date deldate, String refno, int vendocno, 
	String cmbcurr, double currate, String delterms, String payterms,
	String purdesc, double productTotal, double descPercentage,
	double descountVal, double roundOf, double netTotaldown,
	double servnettotal, double orderValue, int chkdiscount,
	HttpSession session, String mode,
	String formdetailcode, HttpServletRequest request, ArrayList <String> descarray, ArrayList <String> masterarray, String reftype,
	String rrefno, double prddiscount, ArrayList<String> exparray,  
	double exptotal, Date invdate, String invno, int locationid, double stval, double tax1, double tax2, double tax3, double nettax, 
	int cmbbilltype,int itermtype,int costtrno,double descgridhid,double descgridtax,int chkcshprchse */
	int insertvalue=pivdao.insert(sqldate, null, refno, vendoracno, vendorcurid+"", vendorcurrate, "", "", desc,total, 0.0, 0.0, 0.0, taxtotal, 0.0, total, 0, 
			session, "A", "PIV", request, blankarray, prodarray, "GRN", refdocno, 0.0, blankarray, 0.0, sqlinvdate, invno, Integer.parseInt(locid), taxamount,
			0, 0, 0, taxamount, Integer.parseInt(billtype), 0, 0, 0.0, 0.0, 0);
	
	if(insertvalue<=0){
		errorstatus=1;
	}
	else{
		objdata.put("docno", insertvalue);
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>