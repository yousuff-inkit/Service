<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%@page import="java.sql.ResultSet"%>
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

String locid=request.getParameter("locid")==null?"":request.getParameter("locid");
String billtype=request.getParameter("billtype")==null?"":request.getParameter("billtype");
String vattype=request.getParameter("vattype")==null?"":request.getParameter("vattype");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");

String[] strprodarray=request.getParameterValues("prodarray[]");
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsSalesInvoiceDAO salesdao=new ClsSalesInvoiceDAO();
	java.sql.Date sqldate=null;
	if(!date.trim().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	
	
	ArrayList<String> blankarray=new ArrayList<>();
	double total=0.0,taxamount=0.0,discount=0.0,taxtotal=0.0;
	ArrayList<String> prodarray=new ArrayList<>();
	
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int clientacno=0;
	int clientcurid=0;
	double clientcurrate=0.0;
	java.sql.Date sqlbasedate=null;
	int salesmanid=0;
	String strvendor="select CURDATE() basedate,sal_id,ac.acno,h.curid,h.rate from my_acbook ac left join my_head h on ac.acno=h.doc_no where ac.cldocno="+cldocno+" and ac.dtype='CRM' and ac.status=3";
	ResultSet rsvendor=stmt.executeQuery(strvendor);
	while(rsvendor.next()){
		sqlbasedate=rsvendor.getDate("basedate");
		clientacno=rsvendor.getInt("acno");
		clientcurid=rsvendor.getInt("curid");
		clientcurrate=rsvendor.getDouble("rate");
		salesmanid=rsvendor.getInt("sal_id");
	}
	
	double nettotal=0.0;
	for(int i=0;i<strprodarray.length;i++){
		String[] temp=strprodarray[i].split("::");
		System.out.println("Checking before converting");
		System.out.println(temp[6].trim()+"::"+temp[8].trim()+"::"+temp[9].trim()+"::"+temp[17].trim()+"::"+temp[22].trim());
		
		total+=Double.parseDouble(strprodarray[i].split("::")[6].trim());
		discount+=Double.parseDouble(strprodarray[i].split("::")[8].trim());
		nettotal+=Double.parseDouble(strprodarray[i].split("::")[9].trim());
		taxamount+=Double.parseDouble(strprodarray[i].split("::")[22].trim());
		taxtotal+=Double.parseDouble(strprodarray[i].split("::")[17].trim());
		prodarray.add(strprodarray[i]);
	}
	
	/* java.sql.Date date,String refno,String pricegrp,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
	String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,
	ArrayList servarray,HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper,java.sql.Date payduedate
	,int locationid,String modepay,String deltems, ArrayList<String> shiparray,int shipdocno, double stval, double tax1, double tax2, double tax3, double nettax, 
	int cmbbilltype,String billto,String btrnno,String vatype,String clntacno */ 
	System.out.println("Tax Amount:"+taxamount);
	int insertvalue=salesdao.insert(sqldate, refno, "1", clientcurid+"", clientcurrate+"", salesmanid, Integer.parseInt(cldocno), refdocno, "DEL", "", desc, 
		total+"", discount+"",nettotal+"", "0.0", "0.0", taxtotal+"", "A", "INV", prodarray, blankarray, blankarray, session, request, "0", "0.0",sqlbasedate, 
		Integer.parseInt(locid), "credit", "",blankarray, 0, taxamount, 0.0, 0.0, 0.0, taxamount, Integer.parseInt(billtype), "", "", vattype, clientacno+"");
	
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