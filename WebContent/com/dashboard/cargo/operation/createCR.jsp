<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%@page import="com.operations.commercialreceipt.ClsCommercialReceiptDAO" %>          
<%	
ClsConnection ClsConnection=new ClsConnection();     
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();            
		Statement stmt = conn.createStatement();   
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
		String refdate=request.getParameter("refdate")=="" || request.getParameter("refdate")==null?"0":request.getParameter("refdate");
		String date=request.getParameter("date")=="" || request.getParameter("date")==null?"0":request.getParameter("date");
		int cldocno=request.getParameter("cldocno")=="" || request.getParameter("cldocno")==null?0:Integer.parseInt(request.getParameter("cldocno").trim().toString());
		int clacno=request.getParameter("clacno")=="" || request.getParameter("clacno")==null?0:Integer.parseInt(request.getParameter("clacno").trim().toString());
		String netamt=request.getParameter("netamt")=="" || request.getParameter("netamt")==null?"0.0":request.getParameter("netamt");
		String paytype=request.getParameter("paytype")==null || request.getParameter("paytype").trim().equalsIgnoreCase("")?"0":request.getParameter("paytype").toString();
		int acdocno=request.getParameter("acdocno")==null || request.getParameter("acdocno")==""?0:Integer.parseInt(request.getParameter("acdocno").trim().toString());         
		String cardtype=request.getParameter("cardtype")==null || request.getParameter("cardtype").trim().equalsIgnoreCase("")?"0":request.getParameter("cardtype").toString();
		String refno=request.getParameter("refno")==null || request.getParameter("refno").trim().equalsIgnoreCase("")?"0":request.getParameter("refno").toString();
		String destion=request.getParameter("desc")==null || request.getParameter("desc").trim().equalsIgnoreCase("")?"":request.getParameter("desc").toString();
		String description="";                
		Double nettotal=0.0,rctotal=0.0;
		int dat=0;       
		int val=0,temp=0,val1=0;   
		description=destion;              
		ClsCommercialReceiptDAO DAO=new ClsCommercialReceiptDAO();                          
			 ArrayList<String> cparray= new ArrayList<String>();
		     java.sql.Date sqlrefdate=null;
		     java.sql.Date sqldate=null;
		     if(!refdate.equalsIgnoreCase("0")){
		    	 sqlrefdate=ClsCommon.changeStringtoSqlDate(refdate);
		     }
		     if(!date.equalsIgnoreCase("0")){          
		    	 sqldate=ClsCommon.changeStringtoSqlDate(date);
		     }
		     ArrayList<String> gridarray=new ArrayList<String>();          
			 session.setAttribute("BRANCHID",brhid);   
			   
			 dat=DAO.insert(conn,sqldate,"CMR",paytype,acdocno,cardtype,refno,sqlrefdate,description,0, brhid+"",cldocno,clacno,"COPN",docno,"1",Double.parseDouble(netamt),0.0,0.0,0.0,Double.parseDouble(netamt),"","",0.0,gridarray,session,request);
			 //System.out.println("val--->>>"+dat);
			 if(dat>0){  
				 String logdesc="Receipt created#"+dat+" contract tr_no is passing here";                          
   	        	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
				 //System.out.println(val+"====sqllog===="+sqllog);   
				 stmt.executeUpdate(sqllog);  
   	         }
			 response.getWriter().print(dat);                   
 	stmt.close();  
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
