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
<%@page import="com.project.execution.completioncertificate.ClsCompletionCertificateDAO"%>   
<%@page import="java.text.SimpleDateFormat" %>   
<%	
	ClsConnection connDAO=new ClsConnection();     
	ClsCommon commonDAO=new ClsCommon();        
	ClsCompletionCertificateDAO DAO= new ClsCompletionCertificateDAO();       
	Connection conn = null;
	java.sql.Date sqlStartDate=null; 
	System.out.println("In1");
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");       
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));                        
	java.sql.Date sqlStartDate2=null; 
	System.out.println("In2");
	String contractval=request.getParameter("contractval")=="" || request.getParameter("contractval")==null?"0":request.getParameter("contractval");
	int cldocno=request.getParameter("cldocno")=="" || request.getParameter("cldocno")==null?0:Integer.parseInt(request.getParameter("cldocno").toString());    
	String certifyper=request.getParameter("certifyper")=="" || request.getParameter("certifyper")==null?"0":request.getParameter("certifyper");     
	String progressdesc=request.getParameter("progressdesc")=="" || request.getParameter("progressdesc")==null?"":request.getParameter("progressdesc");
	int jobdocno=request.getParameter("jobdocno")=="" || request.getParameter("jobdocno")==null?0:Integer.parseInt(request.getParameter("jobdocno").toString());       
	String pdrowno=request.getParameter("pdrowno")=="" || request.getParameter("pdrowno")==null?"0":request.getParameter("pdrowno");   
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid").trim().toString();
    int val=0,tempvocno=0; 
    System.out.println("In3");
	try{ 
	 	conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement(); 
		conn.setAutoCommit(false);             
		ArrayList<String> gridarray=new ArrayList<String>();                 
  				
		tempvocno=DAO.insert(cdate, "SJOB", jobdocno, cldocno, progressdesc, contractval, certifyper, gridarray, session, "A", "PPIV", request);           
		if(tempvocno>0){  
			 String sql="update cm_srvcontrpd set ppivdocno='"+tempvocno+"' where rowno='"+pdrowno+"'"; 
			 //System.out.println("sql==="+sql);   
			 val=stmt.executeUpdate(sql);           
		}   
		if(val>0){  
			 conn.commit();     
		}   
	                               
  		 response.getWriter().write(val+"::"+tempvocno);             
	 	 conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>