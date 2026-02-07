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
     val= DAO.insert(date, date,"",vacno,1,1.0,"","","",0.0,0.0,0.0,0.0,0.0,0.0,0.0,0,session,"A","GRR",request,mainarray,"GRN",podocnos.substring(0,podocnos.length()-1),0.0,0) ;
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