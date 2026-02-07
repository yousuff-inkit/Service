<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>     
<%	

	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();                         
	ClsSurveyDetailsDAO DAO= new ClsSurveyDetailsDAO();                       
	Connection conn = null;
	java.sql.Date sqlDate=null;
	String address=request.getParameter("address")==null?"":request.getParameter("address");
	String latittude=request.getParameter("latittude")==null?"":request.getParameter("latittude");     
	String longitude=request.getParameter("longitude")==null?"":request.getParameter("longitude");         
	int enqid=request.getParameter("enqid")==null || request.getParameter("enqid")==""?0:Integer.parseInt(request.getParameter("enqid").trim().toString());
	String enqno=request.getParameter("enqno")==null || request.getParameter("enqno")==""?"0":request.getParameter("enqno").trim().toString();
	int empid=request.getParameter("empid")==null || request.getParameter("empid")==""?0:Integer.parseInt(request.getParameter("empid").trim().toString());
	String date=request.getParameter("date")==null?"0":request.getParameter("date").trim().toString();
	int clientid=request.getParameter("clientid")==null || request.getParameter("clientid")==""?0:Integer.parseInt(request.getParameter("clientid").trim().toString());
	String txtdesc=request.getParameter("txtdesc")==null?"":request.getParameter("txtdesc").trim();   
	int cpersonid=request.getParameter("cpersonid")==null || request.getParameter("cpersonid")==""?0:Integer.parseInt(request.getParameter("cpersonid").trim().toString());
	String sertypeids=request.getParameter("empid")==null || request.getParameter("empid")==""?"0":request.getParameter("empid").trim().toString();
	String contractr=request.getParameter("contractr")==null?"":request.getParameter("contractr").trim();
	String branch=request.getParameter("brhid")==null?"":request.getParameter("brhid").trim();
	try{                                                      
		ArrayList<String> sertypelist=new ArrayList<String>();
		ArrayList<String> sertypedetlist=new ArrayList<String>();
		ArrayList<String> servlist=new ArrayList<String>();     
		ArrayList<String> sitelist=new ArrayList<String>();               
		//String branch=session.getAttribute("BRANCHID").toString().trim();   
		String sql=null;
		int val=0;
	 	conn=connDAO.getMyConnection();
	 	Statement stmt=conn.createStatement(); 
	 	//System.out.println(clientid+"=clientid==date="+date);    
		if(!date.equalsIgnoreCase("0") && !date.equalsIgnoreCase("")){   
			sqlDate = commonDAO.changetstmptoSqlDate(date);      
		}       
		           
        val=DAO.insert(sqlDate, enqid, clientid, empid, txtdesc, enqno, sertypelist, sertypedetlist, servlist, sitelist, session, request, "A", "SUR", cpersonid, sertypeids, contractr);                            
		int docnoss=Integer.parseInt(request.getAttribute("docNo").toString());    
        if(val>0){
        	String sqlup="update cm_surveym set portal=1,longitude='"+longitude+"',latittude='"+latittude+"',address='"+address+"' where doc_no="+docnoss+"";       
			int val1=stmt.executeUpdate(sqlup); 
			if(val1>0){
				val=1;     
			}
		}    
        response.getWriter().print(val);          

	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>

