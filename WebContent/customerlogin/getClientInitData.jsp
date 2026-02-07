<%@page import="customerlogin.ClsCustomerLoginDAO"%>     
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
Connection conn=null;
String refname="",acno="0";
JSONObject objcntlist=new JSONObject(); 
JSONObject objschlist=new JSONObject(); 
JSONObject objinvlist=new JSONObject();
JSONObject objwrklist=new JSONObject();
JSONObject objacstmtlist=new JSONObject();    
ClsCustomerLoginDAO dao=new ClsCustomerLoginDAO(); 
String cldocno=session.getAttribute("CLDOCNO")==null?"":session.getAttribute("CLDOCNO").toString();
String type=request.getParameter("type")==null?"":request.getParameter("type").trim().toString();  
String conttype=request.getParameter("conttype")==null?"":request.getParameter("conttype").trim().toString(); 
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim().toString();
String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();
String status=request.getParameter("status")==null?"":request.getParameter("status").trim().toString();
String sertrno=request.getParameter("sertrno")==null?"":request.getParameter("sertrno").trim().toString();     
try{     
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="select coalesce(refname,'') refname, acno from my_acbook where cldocno="+cldocno+" and dtype='crm'";
	ResultSet rs=stmt.executeQuery(strsql);     
	while(rs.next()){
		refname=rs.getString("refname");
		acno=rs.getString("acno");  
	}
	if(type.equalsIgnoreCase("Contract List")){     
		JSONArray contractarray=dao.getContractData(cldocno, conttype, fromdate, todate, conn);        
		objcntlist.put("contractdata", contractarray); 
	}else if(type.equalsIgnoreCase("Schedule List")){      
		JSONArray schedulearray=dao.getScheduleData(cldocno, status, fromdate, todate, conn);  
		objschlist.put("scheduledata", schedulearray); 
	}else if(type.equalsIgnoreCase("Invoice List")){     
		JSONArray invoicearray=dao.getInvoiceData(cldocno, fromdate, todate, conn);   
		objinvlist.put("invoicedata", invoicearray);
	}else if(type.equalsIgnoreCase("workdetails")){           
		JSONArray workdetailsarray=dao.getWorkdetailsData(sertrno, conn);     
		objwrklist.put("workdetailsdata", workdetailsarray);        
	}else if(type.equalsIgnoreCase("Account Statement")){                  
		JSONArray acstmtdetailsarray=dao.getAccountStatement(acno, fromdate, todate, conn);            
		objacstmtlist.put("acstmtdata", acstmtdetailsarray);                
	}else{}   
}      
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(refname+" :: "+objcntlist+" :: "+objschlist+" :: "+objinvlist+" :: "+objwrklist+" :: "+objacstmtlist+" :: "+acno);                  
%>