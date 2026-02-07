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

String[] strprodarray=request.getParameterValues("prodarray[]");
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsDeliveryNoteDAO deldao=new ClsDeliveryNoteDAO();
	
	java.sql.Date sqldate=null;
	if(!date.trim().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	
	ArrayList<String> blankarray=new ArrayList<>();
	double total=0.0,taxamount=0.0,discount=0.0,taxtotal=0.0;
	ArrayList<String> prodarray=new ArrayList<>();
	for(int i=0;i<strprodarray.length;i++){
		System.out.println("Test:"+strprodarray[i]);
		String[] temp=strprodarray[i].split("::");
		String strtotal=strprodarray[i].split("::")[6].trim();
		if(strtotal==null || strtotal.equalsIgnoreCase("") || strtotal.equalsIgnoreCase("undefined")){
			strtotal="0";
		}
		total+=Double.parseDouble(strtotal);
		String strdiscount=strprodarray[i].split("::")[8].trim();
		if(strdiscount==null || strdiscount.equalsIgnoreCase("") || strdiscount.equalsIgnoreCase("undefined")){
			strdiscount="0";
		}
		discount+=Double.parseDouble(strdiscount);
	
		prodarray.add(strprodarray[i]);
	}
	
	int insertvalue=deldao.insert(sqldate, refno, "", "1", "1", 0, Integer.parseInt(cldocno), refdocno, "SOR", "", desc, total+"", discount+"", (total-discount)+"", "0.0", "0.0", (total-discount)+"", "A", "DEL", prodarray,blankarray, blankarray, session, request, refdocno, "0", locid, blankarray, 0, "exclusive");
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