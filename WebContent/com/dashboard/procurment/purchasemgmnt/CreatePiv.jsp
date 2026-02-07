 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.procurement.purchase.purchaseinvoice.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
Connection conn=null;

ClspurchaseinvoiceDAO  DAO =new ClspurchaseinvoiceDAO ();
//String date1=request.getParameter("date")==null?"":request.getParameter("date");

String pivarray=request.getParameter("pivarray")==null?"":request.getParameter("pivarray");
int vacno = request.getParameter("vacno")==null || request.getParameter("vacno").equalsIgnoreCase("")?0:Integer.parseInt(request.getParameter("vacno").trim());

String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");

String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String brachval=request.getParameter("brchid")==null?"":request.getParameter("brchid");

String delterms=request.getParameter("delterms")==null?"":request.getParameter("delterms");

String paymentterms=request.getParameter("paymentterms")==null?"":request.getParameter("paymentterms");

int loc=request.getParameter("loc")==null?0:Integer.parseInt( request.getParameter("loc").trim());

String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
session.setAttribute("BRANCHID", brachval);

int cmbpivbilltype=request.getParameter("cmbpivbilltype")==null || request.getParameter("cmbpivbilltype").equalsIgnoreCase("") ?0: Integer.parseInt(request.getParameter("cmbpivbilltype").trim()) ;
double pivrate=Double.parseDouble(request.getParameter("pivrate")==null?"0.0":request.getParameter("pivrate").trim());
double producttotal=Double.parseDouble(request.getParameter("producttotal")==null?"0.0":request.getParameter("producttotal").trim());
double nettotaldown=Double.parseDouble(request.getParameter("nettotaldown")==null?"0.0":request.getParameter("nettotaldown").trim());
double ordervalue=Double.parseDouble(request.getParameter("ordervalue")==null?"0.0":request.getParameter("ordervalue").trim());
//String date=request.getParameter("date")==null?"":request.getParameter("date");
String pivcurid=request.getParameter("pivcurid")==null?"":request.getParameter("pivcurid");
System.out.println(pivrate+"::"+vacno+"::"+vocno+"::"+desc+"::"+delterms+"::"+paymentterms+"::"+loc+"::"+invno+"::"+cmbpivbilltype+"::"+pivarray+"::"+pivcurid);
int val=0;
ArrayList<String> mainarray=new ArrayList<String>();
ArrayList<String> prarray=new ArrayList<String>();
ArrayList<String> exarray=new ArrayList<String>();
String temparray[]=pivarray.split(",");
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
	 //val= DAO.insert(date, date,"",vacno,1,1.0,delterms,paymentterms,"",0.0,0.0,0.0,0.0,0.0,0.0,0.0,0,session,"A","GRN",request,mainarray,"PO",podocnos.substring(0,podocnos.length()-1),0.0,loc,date,invno,0,0) ;
	 val= DAO.insert(date, date, "", vacno, pivcurid, pivrate, delterms, paymentterms, desc, producttotal, 0.0, 0.0, 0.0, nettotaldown, 0.0, ordervalue, 0, session, "A", "PIV", request,prarray ,mainarray , "GRN", "", 0.0, exarray, 0.0, date, invno, loc, 0.0, 0.0, 0.0, 0.0, 0.0, cmbpivbilltype, 0, 0, 0.0,0.0,0);
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