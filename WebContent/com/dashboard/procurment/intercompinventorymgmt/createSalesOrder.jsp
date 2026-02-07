<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.sales.marketing.salesorder.ClsSalesOrderDAO"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");

String[] strprodarray=request.getParameterValues("prodarray[]");
JSONObject objdata=new JSONObject();
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsSalesOrderDAO orderdao=new ClsSalesOrderDAO();
	
	java.sql.Date sqldate=null;
	if(!date.trim().equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	
	ArrayList<String> blankarray=new ArrayList<>();
	double total=0.0,taxamount=0.0,discount=0.0,taxtotal=0.0;
	ArrayList<String> prodarray=new ArrayList<>();
	for(int i=0;i<strprodarray.length;i++){
		String[] temp=strprodarray[i].split("::");
		total+=Double.parseDouble(strprodarray[i].split("::")[3].trim());
		discount+=Double.parseDouble(strprodarray[i].split("::")[5].trim());
		taxamount+=Double.parseDouble(strprodarray[i].split("::")[8].trim());
		taxtotal+=Double.parseDouble(strprodarray[i].split("::")[9].trim());
		prodarray.add(temp[0].trim()+"::"+temp[11]+"::"+temp[1]+"::"+0+"::"+0+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[10]+"::"+0+"::"+0+"::"+0+"::"+0+"::"+0+"::"+0+"::"+temp[7]+"::"+temp[8]+"::"+temp[9]+"::"+0+"::"+0+"::"+0);
	}
	int insertvalue=orderdao.insert(sqldate, refno, "1", "1", "1", 0, Integer.parseInt(cldocno), "", "DIR", "", desc, 
			total+"", discount+"", taxtotal+"", "0.0", "0.0", taxtotal+"", "A", "SOR", 
			prodarray, blankarray, blankarray, session, request, 
			"", "0", blankarray, 0, "", taxamount, 0.0, 0.0, 0.0, taxamount, 1, "exclusive");
	
	if(insertvalue<=0){
		errorstatus=1;
	}
	else{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		for(int i=0;i<strprodarray.length;i++){
			String[] temp=strprodarray[i].split("::");
			String strupdatepo="update my_ordd set interoutqty=(interOutQty+"+temp[1].trim()+") where rowno="+temp[12].trim();
			int updatepo=stmt.executeUpdate(strupdatepo);
			if(updatepo<=0){
				errorstatus=1;
			}
		}
		if(errorstatus==0){
			conn.commit();
		}
		objdata.put("docno", insertvalue);
	}
	/* java.sql.Date date,String refno,String pricegrp,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
	String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,
	ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,
	String qotmasterdocno,String descper, ArrayList<String> shiparray,int shipdocno,String delterms,
	double stval, double tax1, double tax2, double tax3, double nettax,int cmbbilltype,String vatype */
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>