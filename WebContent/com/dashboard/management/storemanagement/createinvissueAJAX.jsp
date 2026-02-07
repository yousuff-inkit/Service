 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.sales.InventoryTransfer.InventoryTransferIssue.*" %>
<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

Connection conn=null;

ClsTransferIssueDAO DAO= new ClsTransferIssueDAO();
String invissuearray=request.getParameter("invissuearray")==null?"":request.getParameter("invissuearray");
String remarks1=request.getParameter("remarks1")==null?"":request.getParameter("remarks1");
String txttotal=request.getParameter("txttotal")==null?"":request.getParameter("txttotal");
int frmlocid = Integer.parseInt(request.getParameter("frmlocid"));
int frmbrhid = Integer.parseInt(request.getParameter("frmbrhid"));
int branch1 = Integer.parseInt(request.getParameter("branch1"));
int location1 = Integer.parseInt(request.getParameter("location1"));
String txtnettotal=request.getParameter("txtnettotal")==null?"":request.getParameter("txtnettotal");
String seramt=request.getParameter("seramt")==null?"":request.getParameter("seramt");
String roundof=request.getParameter("roundof")==null?"":request.getParameter("roundof");
String finalamt=request.getParameter("finalamt")==null?"":request.getParameter("finalamt");

ArrayList<String> mainarray=new ArrayList<String>();
String temparray[]=invissuearray.split(",");
for(int i=0;i<temparray.length;i++){
	mainarray.add(temparray[i]);
}

try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();

	
 long millis=System.currentTimeMillis();  
 java.sql.Date date=new java.sql.Date(millis);  
 
 String reftype="";
 
	if(frmbrhid==branch1){
		reftype="ILT";	
	}else{
		reftype="IBT";
	}
	
	
	
	System.out.println("arraysys======="+mainarray);
       int val= DAO.insert("",date,reftype,branch1,location1,frmbrhid,frmlocid,remarks1,txttotal,txtnettotal,"0","0",finalamt,"A","ITI", mainarray, session, request); 
    
       if(val==0){
    	  conn.commit();
      }
   response.getWriter().print(val);
   stmt.close();
	conn.close();
}catch(Exception e){
 	e.printStackTrace();
 	conn.close();
}finally{
   conn.close();
}
%>