<%@page import="java.sql.ResultSet"%>
<%@page import="com.procurement.purchase.goodsreceiptnote.ClsgoodsreceiptnoteDAO"%>
<%@page import="com.sales.Sales.deliverynote.ClsDeliveryNoteDAO"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String locid=request.getParameter("locid")==null?"":request.getParameter("locid");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String refdocno=request.getParameter("refdocno")==null?"":request.getParameter("refdocno");
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
String[] strprodarray=request.getParameterValues("prodarray[]");

System.out.println(brhid+"::"+locid+"::"+cldocno+"::"+refno+"::"+date+"::"+desc+"::"+refdocno+"::"+invno+"::"+invdate);
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsgoodsreceiptnoteDAO grndao=new ClsgoodsreceiptnoteDAO();
	
	java.sql.Date sqldate=null,sqlinvdate=null;
	if(!date.trim().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	
	if(!invdate.trim().equalsIgnoreCase("")){
		sqlinvdate=objcommon.changeStringtoSqlDate(invdate);
	}
	int vendoracno=0;
	conn=objconn.getMyConnection();
	
	String strvendorac="select acno from my_acbook where cldocno="+cldocno+" and dtype='VND'";
	ResultSet rsvendor=conn.createStatement().executeQuery(strvendorac);
	while(rsvendor.next()){
		vendoracno=rsvendor.getInt("acno");
	}
	
	ArrayList<String> blankarray=new ArrayList<>();
	double total=0.0,taxamount=0.0,discount=0.0,taxtotal=0.0;
	ArrayList<String> prodarray=new ArrayList<>();
	for(int i=0;i<strprodarray.length;i++){
		System.out.println("Test:"+strprodarray[i]);
		String[] temp=strprodarray[i].split("::");
		String unitprice=temp[8]==null || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().equalsIgnoreCase("undefined")?"0":temp[8].trim();
		String qty=temp[3]==null || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().equalsIgnoreCase("undefined")?"0":temp[3].trim();
		String strdiscount=temp[9]==null || temp[9].trim().equalsIgnoreCase("") || temp[9].trim().equalsIgnoreCase("undefined")?"0":temp[9].trim();
		discount+=Double.parseDouble(strdiscount);
		total+=Double.parseDouble(unitprice)*Double.parseDouble(qty);
		prodarray.add(strprodarray[i]);
	}
	/* Date masterdate, Date deldate, String refno, int vendocno,
	int cmbcurr, double currate, String delterms, String payterms,
	String purdesc, double productTotal, double descPercentage,
	double descountVal, double roundOf, double netTotaldown,
	double servnettotal, double orderValue, int chkdiscount,
	HttpSession session, String mode,  
	String formdetailcode, HttpServletRequest request, 
	ArrayList <String> masterarray, String reftype, String rrefno, double prddiscount, int locationid, Date invdate, String invno,int itermtype,int costtrno */ 
	int insertvalue=grndao.insert(sqldate, null, refno, vendoracno,1, 1.0, "", "", desc, total, 0.0, discount,0.0,total,0.0,total,0,session,
			"A","GRN",request,prodarray,"PO",refdocno,discount,Integer.parseInt(locid),sqlinvdate,invno,0,0);
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