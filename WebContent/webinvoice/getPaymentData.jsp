<%@page import="java.text.SimpleDateFormat"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="java.io.StringReader"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSON"%>
<%@page import="net.sf.json.xml.*"%>
<%@page import="webinvoice.CBDCrypto"%>
<%@page import="java.sql.Connection"%>
<%
String c=request.getParameter("c")==null?"":request.getParameter("c");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	CBDCrypto crypt=new CBDCrypto();
	/* String xmlresponse="<Response>"+
	"<Header>"+
	"<ResponseCode>00</ResponseCode>"+
	"<ResponseMsg>success</ResponseMsg>"+
	"</Header>"+
	"<Body>"+
	"<PaymentInformation>"+
	"<CBDReferenceNo>58101899</CBDReferenceNo><CCReferenceNo>5252392483666540204104</CCReferenceNo>"+
	"<OrderID>923</OrderID>"+
	"<PaymentDate>02/05/2018</PaymentDate>"+
	"<PaymentTime>09:24:01</PaymentTime>"+
	"</PaymentInformation>"+
	"</Body>"+
	"</Response>"; */
	String xml=crypt.decrypt(c,"0GY943VDCJ10LF8");
	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	DocumentBuilder builder = null;
	builder = factory.newDocumentBuilder();
	Document doc = builder.parse(new InputSource(new StringReader(xml)));
	doc.getDocumentElement().normalize();
	System.out.println("Root Element :" + doc.getDocumentElement().getNodeName());
    System.out.println("------");
    NodeList list = doc.getElementsByTagName("Response");
    String responsecode="",responsemsg="",bankrefno="",cardrefno="",orderid="",paymentdate="",paymenttime="";
    for (int temp = 0; temp < list.getLength(); temp++) {
    	Node node = list.item(temp);
    	Element element = (Element) node;
    	responsecode=element.getElementsByTagName("ResponseCode").item(0).getTextContent();
    	responsemsg=element.getElementsByTagName("ResponseMsg").item(0).getTextContent();
    	bankrefno=element.getElementsByTagName("CBDReferenceNo").item(0).getTextContent();
    	cardrefno=element.getElementsByTagName("CCReferenceNo").item(0).getTextContent();
    	orderid=element.getElementsByTagName("OrderID").item(0).getTextContent();
    	paymentdate=element.getElementsByTagName("PaymentDate").item(0).getTextContent();
    	paymenttime=element.getElementsByTagName("PaymentTime").item(0).getTextContent();
    	java.sql.Date sqlpytdate=null;
    	SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date date = sdf1.parse(paymentdate);
		sqlpytdate = new java.sql.Date(date.getTime());
    	int insertpyt=conn.createStatement().executeUpdate("insert into my_onlinepayments(responsecode, responsemsg, bankrefno, cardrefno, orderid, paymentdate, paymenttime) values('"+responsecode+"', '"+responsemsg+"', '"+bankrefno+"', '"+cardrefno+"', '"+orderid+"', '"+sqlpytdate+"', '"+paymenttime+"')");
    	//System.out.println("Response:"+responsecode+"::"+responsemsg+"::"+bankrefno+"::"+cardrefno+"::"+orderid+"::"+paymentdate+"::"+paymenttime);
    }
    objdata.put("responsecode",responsecode);
    objdata.put("responsemsg",responsemsg);
    objdata.put("orderid",orderid);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>