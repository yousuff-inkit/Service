 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.procurement.purchase.purchaseinvoicereturn.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
Connection conn=null;

ClspurchaseinvoicereturnDAO DAO=new ClspurchaseinvoicereturnDAO();

//String date1=request.getParameter("date")==null?"":request.getParameter("date");

String pivarray=request.getParameter("pivarray")==null?"":request.getParameter("pivarray");
//System.out.println("pivarray====="+pivarray);

int vacno = request.getParameter("vacno")==null || request.getParameter("vacno").equalsIgnoreCase("")?0:Integer.parseInt(request.getParameter("vacno").trim());
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String delterms=request.getParameter("delterms")==null?"":request.getParameter("delterms");
String brchid=request.getParameter("brchid")==null?"":request.getParameter("brchid");
String paymentterms=request.getParameter("paymentterms")==null?"":request.getParameter("paymentterms");
int loc=request.getParameter("loc")==null?0:Integer.parseInt( request.getParameter("loc").trim());
//System.out.println("loc====="+loc);
int billtype=request.getParameter("billtype")==null?0:Integer.parseInt( request.getParameter("billtype").trim());
//System.out.println("billtype====="+pivarray);
session.setAttribute("BRANCHID", brchid);
//int cmbpivbilltype=request.getParameter("cmbpivbilltype")==null || request.getParameter("cmbpivbilltype").equalsIgnoreCase("") ?0: Integer.parseInt(request.getParameter("cmbpivbilltype").trim()) ;
double pivrate=Double.parseDouble(request.getParameter("pivrate")==null?"0.0":request.getParameter("pivrate").trim());
double producttotal=Double.parseDouble(request.getParameter("producttotal")==null?"0.0":request.getParameter("producttotal").trim());
double nettotal=Double.parseDouble(request.getParameter("nettotal")==null?"0.0":request.getParameter("nettotal").trim());
double finaltotal=Double.parseDouble(request.getParameter("finaltotal")==null?"0.0":request.getParameter("finaltotal").trim());
//String date=request.getParameter("date")==null?"":request.getParameter("date");
String pivcurid=request.getParameter("pivcurid")==null?"":request.getParameter("pivcurid");
//System.out.println(pivrate+"::"+vacno+"::"+vocno+"::"+desc+"::"+delterms+"::"+paymentterms+"::"+loc+"::"+invno+"::"+cmbpivbilltype+"::"+pivarray+"::"+pivcurid);
int val=0;
ArrayList<String> mainarray=new ArrayList<String>();
ArrayList<String> prarray=new ArrayList<String>();
ArrayList<String> exarray=new ArrayList<String>();
String temparray[]=pivarray.split(",");
for(int i=0;i<temparray.length;i++){
	//System.out.println("Array : "+temparray[i]);
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
	 //val= DAO.insert(date, date,"",vacno,1,1.0,delterms,paymentterms,"",0.0,0.0,0.0,0.0,0.0,0.0,0.0,0,session,"A","GRN",request,mainarray,"PO",podocnos.substring(0,podocnos.length()-1),0.0,loc,date,invno,0,0) ;
	 //val= DAO.insert(date, date, "", vacno, pivcurid, pivrate, delterms, paymentterms, desc, producttotal, 0.0, 0.0, 0.0, nettotal, 0.0, ordervalue, 0, session, "A", "", request,prarray ,mainarray , "GRN", "", 0.0, exarray, 0.0, date, invno, loc, 0.0, 0.0, 0.0, 0.0, 0.0, cmbpivbilltype, 0, 0, 0.0,0.0,0);
	 //System.out.println("arrsaysss-=========="+val);
	val= DAO.insert(date, date, "", vacno, "1", 1.0, delterms, paymentterms, desc, nettotal, session, "A", "PIR", request, mainarray, "PIV", "", loc, producttotal, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, billtype, finaltotal);
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