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
<%@page import="com.email.*"%>
<%@page import="com.mailwithpdf.EmailProcess"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String date=request.getParameter("date")==null?"":request.getParameter("date");  
		String branchid=request.getParameter("branchid")==null?"0":request.getParameter("branchid");
		String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno");
		String rdtype=request.getParameter("rdtype");
		String remarks=request.getParameter("remarks");
		String rowno=request.getParameter("rowno")==null || request.getParameter("rowno")==""?"0":request.getParameter("rowno");
		String userid=session.getAttribute("USERID").toString();
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){  
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

	    
		String sql="",sqlsub="",sql1=""; 
		String temp="";
		int val=0;
	    sql="insert into gl_bamc(rtrno, rrowno, date, rdtype, fdate, brhid, userid, remarks) values('"+trno+"', "+rowno+", now(), '"+rdtype+"', '"+sqlDate+"', "+branchid+", "+session.getAttribute("USERID").toString()+", '"+remarks+"')";
		 //System.out.println("followup=="+sql);
		val= stmt.executeUpdate(sql);
		if(val>0){
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+rowno+"','"+branchid+"','CRF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 // System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);    
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
