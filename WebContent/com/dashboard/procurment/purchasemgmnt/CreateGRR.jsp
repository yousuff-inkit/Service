 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import=" com.procurement.purchase.goodsreceiptnotereturn.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

Connection conn=null;

ClsgoodsreceiptnotereturnDAO  DAO =new ClsgoodsreceiptnotereturnDAO ();
String grrarray=request.getParameter("grrarray")==null?"":request.getParameter("grrarray");
int vacno = request.getParameter("vacno")==null || request.getParameter("vacno").equals("")?0:Integer.parseInt(request.getParameter("vacno").trim());
String podocnos=request.getParameter("podocnos")==null?"":request.getParameter("podocnos");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String delterms=request.getParameter("delterms")==null?"":request.getParameter("delterms");
String paymentterms=request.getParameter("paymentterms")==null?"":request.getParameter("paymentterms");
int loc=request.getParameter("loc")==null?0:Integer.parseInt(request.getParameter("loc").trim());
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String brachval=request.getParameter("brchid")==null?"":request.getParameter("brchid");
session.setAttribute("BRANCHID", brachval);
//System.out.println("vacno"+vacno);

int val=0;
ArrayList<String> mainarray=new ArrayList<String>();
String temparray[]=grrarray.split(",");
for(int i=0;i<temparray.length;i++){
	mainarray.add(temparray[i]);
}

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();

		
		
	long millis=System.currentTimeMillis();  
	 java.sql.Date date=new java.sql.Date(millis);  
	// System.out.println("mainarray-=========="+mainarray);
     val= DAO.insert(date, date,"",vacno,1,1.0,delterms,paymentterms,"",0.0,0.0,0.0,0.0,0.0,0.0,0.0,0,session,"A","GRR",request,mainarray,"GRN",podocnos.substring(0,podocnos.length()-1),0.0,loc) ;
	 //System.out.println("arrsaysss-=========="+val);
     if(val>0){
		   vocno = 	request.getAttribute("vocno").toString();
	   }
	 if(val==0){
  	  conn.commit();
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