<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%@page import="com.common.*"%>
<%
String journalarray=request.getParameter("jvarray")==null?"":request.getParameter("jvarray");   
String amount=request.getParameter("amount")==null || request.getParameter("amount")==""?"0.0":request.getParameter("amount");
String invno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String docno=request.getParameter("invdocno")==null || request.getParameter("invdocno")==""?"0":request.getParameter("invdocno");
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
String invdate=request.getParameter("invdate")==null || request.getParameter("invdate")==""?null:request.getParameter("invdate");
String desc=request.getParameter("desc")==null || request.getParameter("desc")==""?"":request.getParameter("desc");
int val=0,trnno=0;
Connection conn=null;                         
try{
	//System.out.println("journalarray=="+journalarray);
	ClsJournalVouchersDAO dao= new ClsJournalVouchersDAO();
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	//SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");     
	//java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=objcommon.changetstmptoSqlDate(invdate);   
	double cmaount=Double.parseDouble(amount);
	session.setAttribute("BRANCHID",brhid);
	ArrayList<String> journalvouchersarray=new ArrayList<String>();  
	if(!journalarray.equalsIgnoreCase("")){
		String temp[]=journalarray.split(",");
		for(int i=0;i<temp.length;i++){
			journalvouchersarray.add(temp[i]);
		}	
	}
	
	int trno=dao.insert(cdate,"JVT-27", invno, desc, cmaount, cmaount, journalvouchersarray, session, request);       
	if(trno>0){                                 
		trnno=Integer.parseInt(request.getAttribute("tranno").toString());
		String strsql="update cm_srvcontrm set jvtrno='"+trnno+"',docstatus='Posted' where tr_no='"+docno+"'";                          	                         
		//System.out.println("====="+strsql);
		val=stmt.executeUpdate(strsql); 
	}
	if(val>0){          
		 String logdesc="JV created Tr_no#"+trnno+" contract tr_no is passing here";                                  
      	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
		 //System.out.println(val+"====sqllog===="+sqllog);   
		 stmt.executeUpdate(sqllog);
	}
	response.getWriter().print(trno+"###"+trnno);                            
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
%>