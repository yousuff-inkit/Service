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
<%                         	
String trno=request.getParameter("trno");    
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno").toString();
Connection conn=null;
int aaa=0,val=0;
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	 
	String sql1="delete from cm_subdivm where jobdocno="+docno+"";  
	 //System.out.println("sql1---->>>"+sql1);      
	int bbb= stmt.executeUpdate(sql1);
	String aa[]=trno.split(",");    
	for(int i=0;i<aa.length;i++){
		 String bb[]=aa[i].split("###");    
		 //System.out.println(bb[0]+"<<<---->>>"+bb[1]);  
		 Double budget=Double.parseDouble(bb[1]);         
		 String rdocno=bb[0];      
		 String sql="insert into cm_subdivm(jobdocno, rdocno, budget, status) values('"+docno+"','"+rdocno+"',"+budget+",3)";    
		 //System.out.println("sql---->>>"+sql);      
		 aaa= stmt.executeUpdate(sql);
	  }
	 if(aaa>0){ 
		 String logdesc="Cost Budgeting";            
		 String sqllog="insert into gl_jobactivitylog(doc_no, brhId, dtype, edate, userId,description) values("+vocno+",'"+brhid+"','AMCM',now(),'"+session.getAttribute("USERID")+"','"+logdesc+"')";                       
		 //System.out.println(val+"====sqllog===="+sqllog);
		 val=stmt.executeUpdate(sqllog);
	 }
	stmt.close();
	conn.close();      
}
catch(Exception e){
conn.close();
e.printStackTrace();
}
response.getWriter().print(aaa);
%>