<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%@page import="java.sql.*"%>
<%
	String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid");
	String netotal=request.getParameter("netotal")==null?"0":request.getParameter("netotal");
	String taxtotal=request.getParameter("taxtotal")==null?"0":request.getParameter("taxtotal");
	String netaxtotal=request.getParameter("netaxtotal")==null?"0":request.getParameter("netaxtotal");
	String productsarray=request.getParameter("products")==null?"0":request.getParameter("products");
	String inspdocno=request.getParameter("inspdocno")==null?"0":request.getParameter("inspdocno");
	String scheduledate=request.getParameter("scheduledate")==null?"":request.getParameter("scheduledate");
	String clntacno=request.getParameter("clntacno")==null?"0":request.getParameter("clntacno");
	System.out.println("clntacno===:"+clntacno);
	System.out.println("productsarray:"+productsarray);
	ArrayList<String> prodarray=new ArrayList();
	if(!productsarray.trim().equalsIgnoreCase("")){
		for(int i=0;i<productsarray.split(",").length;i++){
			prodarray.add(productsarray.split(",")[i]);
		}		
	}
	ArrayList<String> termsarray=new ArrayList();
	ArrayList<String> servarray=new ArrayList();
	ArrayList<String> shiparray=new ArrayList();
	
	Connection conn=null;
	int errorstatus=0;
	int docno=0;
	int val=0;
	String doc="";
	try{
		ClsConnection objconn=new ClsConnection();
		ClsCommon objcommon=new ClsCommon();
		conn=objconn.getMyConnection();
		ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		java.sql.Date sqlscheduletdate=null;
		long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis);
		int cid=Integer.parseInt(clientid);
		
		double ttotal=Double.parseDouble(taxtotal);
        System.out.println("savedate===="+date);  
		if(!scheduledate.equalsIgnoreCase("")){
			sqlscheduletdate=objcommon.changeStringtoSqlDate(scheduledate);
		}
		String branchid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
		String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
		java.sql.Date sqlcontractfromdate=null,sqlcontracttodate=null;
	 	val=DAO.insert(date,"0","1","1","1",0,cid,"0","DIR","0","web app credit invoice", netotal,"0", netaxtotal,"0","0", netaxtotal,"A","INV", prodarray, termsarray, servarray, session, request,"0","0",date,1,"credit","0", shiparray,0,ttotal,ttotal,0.0,0.0,ttotal,1,"0","0","0",clntacno);
	 	doc=request.getAttribute("vdocNo").toString();  
	 	System.out.println("val===="+val+"doc===="+doc);  
			 if(val>0){
			conn.commit();
		} 
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().print(val+"###"+doc);
%>