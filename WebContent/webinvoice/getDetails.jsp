<%@page import="webinvoice.CBDCrypto"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String docid=request.getParameter("docid")==null?"":request.getParameter("docid");
System.out.println("Doc ID:"+docid);
if(docid.equalsIgnoreCase("")){
	docid="923";
	//testing purpose
}
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	CBDCrypto crypt=new CBDCrypto();
	Statement stmt=conn.createStatement();
	double invamount=0.0;
	String strgetinvdetails="select coalesce(m.desc1,'') desc1,date_format(m.date,'%M %Y') maindate,date_format(m.date,'%d %M %Y') longdate,date_format(m.date,'%d-%m-%Y') strdate,format(round(coalesce(d.nettaxamount,0),2),2) nettaxamount,"+
	" format(round(coalesce(d.nettotal,0),2),2) nettotal,format(round(coalesce(d.tax,0),2),2) tax,round(coalesce(d.taxper,0),0) taxpercent,m.date,ac.refname from my_srvsalem m left join my_srvsaled d on"+
	" m.doc_no=d.rdocno left join my_acbook ac on m.acno=ac.acno where m.doc_no="+docid;
	System.out.println(strgetinvdetails);
	ResultSet rsgetinvdetails=stmt.executeQuery(strgetinvdetails);
	String strdate="",nettaxtotal="",nettotal="",tax="",taxpercent="",clientname="",longdate="",maindate="",desc="";
	String paidstatus="0";
	while(rsgetinvdetails.next()){
		desc=rsgetinvdetails.getString("desc1");
		nettaxtotal=rsgetinvdetails.getString("nettaxamount");
		nettotal=rsgetinvdetails.getString("nettotal");
		tax=rsgetinvdetails.getString("tax");
		taxpercent=rsgetinvdetails.getString("taxpercent");
		strdate=rsgetinvdetails.getString("strdate");
		clientname=rsgetinvdetails.getString("refname");
		longdate=rsgetinvdetails.getString("longdate");
		maindate=rsgetinvdetails.getString("maindate");
	}
	String strgetpaidstatus="select responsecode from my_onlinepayments where orderid="+docid;
	ResultSet rspaidstatus=stmt.executeQuery(strgetpaidstatus);
	while(rspaidstatus.next()){
		paidstatus="1";
	}
	//invamount=5000;
	String data="<BankInformation>"+
	"<ClientID>CBD73</ClientID>"+
	//" <ReturnPage>http://localhost/CBD.PSP.PGTesting/PaymentTesting//CheckoutStatus</ReturnPage>"+
	"<ReturnPage>http://abzig-deira.fortiddns.com:8889/REALESTATETRIAL/webinvoice/paymentStatus.jsp</ReturnPage>"+
	"<CreateToken>false</CreateToken>"+
	"<locale>en-us</locale>"+
	"<PaymentInformation>"+
	"<OrderID>"+docid+"</OrderID>"+
	"<TotalAmount>"+nettaxtotal.replace(",","")+"</TotalAmount>"+
	"<TransactionType>sale</TransactionType>"+
	"<OrderDescription>"+desc+"</OrderDescription>"+
	"<Currency>AED</Currency>"+
	"</PaymentInformation>"+
	"</BankInformation>";
	System.out.println(data);
	System.out.println("------------------------------------");
	
	final String encrypted=crypt.encrypt(data, "0GY943VDCJ10LF8");	
	System.out.println(crypt.decrypt(encrypted,"0GY943VDCJ10LF8"));
	objdata.put("encrypted",encrypted);
	objdata.put("nettaxtotal",nettaxtotal);
	objdata.put("nettotal",nettotal);
	objdata.put("tax",tax);
	objdata.put("taxpercent",taxpercent);
	objdata.put("invdate",strdate);
	objdata.put("clientname",clientname);
	objdata.put("longdate",longdate);
	objdata.put("maindate",maindate);
	objdata.put("desc",desc);
	objdata.put("paidstatus",paidstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>