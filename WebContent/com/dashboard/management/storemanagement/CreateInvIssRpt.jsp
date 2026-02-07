 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.sales.InventoryTransfer.InventoryTransferRecept.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

Connection conn=null;

ClsTransferReceptDAO  DAO =new ClsTransferReceptDAO ();
String itrarray=request.getParameter("itrarray")==null?"":request.getParameter("itrarray");
int vacno = request.getParameter("vacno")==null || request.getParameter("vacno").equals("")?0:Integer.parseInt(request.getParameter("vacno").trim());
String podocnos=request.getParameter("podocnos")==null?"":request.getParameter("podocnos");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String txttotal=request.getParameter("txttotal")==null?"":request.getParameter("txttotal");
int locationrcpt = request.getParameter("locationrcpt")==null || request.getParameter("locationrcpt").equals("")?0:Integer.parseInt(request.getParameter("locationrcpt").trim());
int branchrcpt = request.getParameter("branchrcpt")==null || request.getParameter("branchrcpt").equals("")?0:Integer.parseInt(request.getParameter("branchrcpt").trim());
int tobrhid = request.getParameter("tobrhid")==null || request.getParameter("tobrhid").equals("")?0:Integer.parseInt(request.getParameter("tobrhid").trim());
int tolocid = request.getParameter("tolocid")==null || request.getParameter("tolocid").equals("")?0:Integer.parseInt(request.getParameter("tolocid").trim());
String txtnettotal=request.getParameter("txtnettotal")==null?"":request.getParameter("txtnettotal");
String finalamt=request.getParameter("finalamt")==null?"":request.getParameter("finalamt");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");


//System.out.println("vacno"+vacno);

int val=0;
ArrayList<String> mainarray=new ArrayList<String>();
String temparray[]=itrarray.split(",");
for(int i=0;i<temparray.length;i++){
	mainarray.add(temparray[i]);
}

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	Statement stmt2=conn.createStatement();
	long millis=System.currentTimeMillis();  
	 java.sql.Date date=new java.sql.Date(millis);  
	String reftype="";
		if(branchrcpt==tobrhid){
			reftype="ILT";	
		}else{
			reftype="IBT";
		}
		
		
		session.setAttribute("BRANCHID",tobrhid); 
		//System.out.println("arraysys======="+mainarray);
	    val=DAO.insert("",date,reftype,branchrcpt,locationrcpt,tobrhid,tolocid,remarks,"0","0","",podocnos.substring(0,podocnos.length()-1),"0","A","ITR",mainarray,session,request) ;
 	// System.out.println("arrsaysss-=========="+val);
	    if(val>0){
			   vocno = 	request.getAttribute("vdocNo").toString();
		   }
	 if(val==0){
  	  conn.commit();
    }
 response.getWriter().print(val+"####"+vocno);

 stmt2.close();
 conn.close();
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}finally{
 conn.close();
}
%>