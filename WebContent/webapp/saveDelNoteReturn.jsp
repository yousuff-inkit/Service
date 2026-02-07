<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.sales.Sales.deliverynotereturn.ClsDeliverynoteReturnDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String strretarray[]=request.getParameterValues("retarray[]");
System.out.println("Array Recieved:"+strretarray);
ArrayList<String> retarray=new ArrayList();
for(int i=0;i<strretarray.length;i++){
	retarray.add(strretarray[i]);
}
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
String location=request.getParameter("location")==null?"":request.getParameter("location").toString();
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();
String deldocno=request.getParameter("deldocno")==null?"":request.getParameter("deldocno").toString();
String desc=request.getParameter("desc")==null?"":request.getParameter("desc").toString();
Connection conn=null;
int errorstatus=0;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	ClsDeliverynoteReturnDAO retdao=new ClsDeliverynoteReturnDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strmisc="select ac.acno,head.curid,head.rate,curdate() basedate from my_acbook ac left join my_head head on ac.acno=head.doc_no where "+
	" ac.cldocno="+cldocno+" and ac.dtype='CRM'";
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	java.sql.Date sqldate=null;
	String curid="",rate="";
	while(rsmisc.next()){
		sqldate=rsmisc.getDate("basedate");	
		curid=rsmisc.getString("curid");
		rate=rsmisc.getString("rate");
	}
	
	conn.close();
	/* java.sql.Date date,String refno,String curr,String currate,int clientid,String rrefno,String rreftype,String locid,String payterms,String delterms,String desc,
	String mode,String formcode,ArrayList prodarray,HttpSession session,HttpServletRequest request,String refmasterdocno */
	int retdoc=retdao.insert(sqldate, deldocno, curid, rate, Integer.parseInt(cldocno), deldocno, "DEL",location, "", "", desc, "A", "DLR", retarray, session, request, deldocno);
	System.out.println("Ret Doc:"+retdoc);
	if(retdoc<=0){
		errorstatus=1;
	}
	objdata.put("retdoc",retdoc);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>