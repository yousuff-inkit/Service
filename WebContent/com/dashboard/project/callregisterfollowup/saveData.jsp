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
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String date=request.getParameter("date");
		String branchid=request.getParameter("branchid");
		String docno=request.getParameter("docno");
		String remarks=request.getParameter("remarks");
		
		java.sql.Date sqlDate=null;
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}
		String sql="",sqlsub="",sql1="",rdtype="CREG";
		String temp="";
		int val=0;
			 sql="insert into gl_bcgf( date, rdocno, rdtype, fdate, remarks, brhid, userid) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"',"+branchid+", "+session.getAttribute("USERID").toString()+")";
			 val= stmt.executeUpdate(sql);                                        
			 if(val>0)
			 {
				 temp="1";
			 }
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
