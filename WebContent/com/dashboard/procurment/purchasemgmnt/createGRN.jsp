 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.procurement.purchase.goodsreceiptnote.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
Connection conn=null;

ClsgoodsreceiptnoteDAO  DAO =new ClsgoodsreceiptnoteDAO ();
//String date1=request.getParameter("date")==null?"":request.getParameter("date");

String grnarray=request.getParameter("grnarray")==null?"":request.getParameter("grnarray");
int vacno = request.getParameter("vacno")==null || request.getParameter("vacno").equals("")?0:Integer.parseInt(request.getParameter("vacno").trim());
String podocnos=request.getParameter("podocnos")==null?"":request.getParameter("podocnos");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String delterms=request.getParameter("delterms")==null?"":request.getParameter("delterms");
String paymentterms=request.getParameter("paymentterms")==null?"":request.getParameter("paymentterms");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
int loc=request.getParameter("loc")==null?0:Integer.parseInt( request.getParameter("loc").trim());
session.setAttribute("BRANCHID", brhid);
System.out.println("loc"+loc);
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
//System.out.println("vacno"+vacno);
int val=0;
ArrayList<String> mainarray=new ArrayList<String>();
String temparray[]=grnarray.split(",");
for(int i=0;i<temparray.length;i++){
	mainarray.add(temparray[i]);
}

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();

	/*  java.sql.Date sqlfromdate = null;
     if (!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase(""))
             && !(date.equalsIgnoreCase("0"))) {
         sqlfromdate = objcommon.changeStringtoSqlDate(date);
     } */
     
 	long millis=System.currentTimeMillis();  
	 java.sql.Date date=new java.sql.Date(millis);
	// System.out.println("mainarray-=========="+mainarray);
	 val= DAO.insert(date, date,"",vacno,1,1.0,delterms,paymentterms,"",0.0,0.0,0.0,0.0,0.0,0.0,0.0,0,session,"A","GRN",request,mainarray,"PO",podocnos.substring(0,podocnos.length()-1),0.0,loc,date,invno,0,0) ;
	 //System.out.println("arrsaysss-=========="+val);
	 if(val>0){
		   vocno = 	request.getAttribute("vocno").toString();
	   }
	 if(val==0){
		 //return null;
  	  //conn.commit();
    }
 response.getWriter().print(val+"####"+vocno);

 stmt.close();
 conn.close();
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}finally{
 conn.close();
}
%>