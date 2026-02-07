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
String agtype=request.getParameter("agtype")==null?"":request.getParameter("agtype");
String agto=request.getParameter("agto")==null?"":request.getParameter("agto");    
String epmt=request.getParameter("equipment")==null?"":request.getParameter("equipment");
String trackid=request.getParameter("trackid")==null?"":request.getParameter("trackid");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String expdate=request.getParameter("expdate")==null?"":request.getParameter("expdate");     
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");
Connection conn=null;
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	java.sql.Date sqlexpdate=null;
	int val=0;
 	conn = ClsConnection.getMyConnection();
 	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	int docval=0;
	String upsql="select coalesce(max(doc_no)+1,1) doc_no from cr_assignment";
	ResultSet resultSet = stmt.executeQuery(upsql);
	if(resultSet.next()) {
		  docval=resultSet.getInt("doc_no");   
	}	
	String sqls11="delete from cr_assignment where jobno="+docno+" ";             
	stmt.executeUpdate(sqls11);   
	
	if(!(expdate.equalsIgnoreCase("undefined"))&&!(expdate.equalsIgnoreCase(""))&&!(expdate.equalsIgnoreCase("0"))){
	   sqlexpdate=ClsCommon.changeStringtoSqlDate(expdate);
	}	
	    
	String sqlss="insert into cr_assignment(doc_no, rdocno, agtype, agdate, agto, expdate, equipment, remarks, userid, jobno, trackid) value("+docval+",0,'"+agtype+"',NOW(),'"+agto+"','"+sqlexpdate+"','"+epmt+"','"+remarks+"' ,'"+session.getAttribute("USERID").toString()+"',"+docno+",'"+trackid+"')";
	int aa1=stmt.executeUpdate(sqlss);
	if(aa1>0){  
		  String logdesc="Assigned. Job TrNo#"+docno+" doc_no passing here is doc_no of cr_assignment";               
		  String sqllog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY, description) values ('"+docval+"','"+brhid+"','COPN',now(),'"+session.getAttribute("USERID").toString()+"','A','"+logdesc+"')";      
		  val= stmt.executeUpdate(sqllog);     
	}
	if(val>0){
          conn.commit();       
          conn.close();
	}			
	response.getWriter().print(val);
	stmt.close();
	conn.close();      
   }catch(Exception e){
		 response.getWriter().print(0);    
	 	 conn.close();
	 	 e.printStackTrace();
   }
%>          