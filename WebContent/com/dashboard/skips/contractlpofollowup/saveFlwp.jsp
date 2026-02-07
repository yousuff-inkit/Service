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
		
		String edate=request.getParameter("edate")==null?"":request.getParameter("edate");  
		String contno=request.getParameter("contrno")==null || request.getParameter("contrno")=="" || request.getParameter("contrno").equalsIgnoreCase("undefined") ?"0":request.getParameter("contrno");
		String contdet=request.getParameter("contdet")==null || request.getParameter("contdet")=="" || request.getParameter("contdet").equalsIgnoreCase("undefined") ?"0":request.getParameter("contdet");
		String remarks=request.getParameter("remarks")==null || request.getParameter("remarks")==""?"":request.getParameter("remarks");
		String fdate=request.getParameter("date")==null|| request.getParameter("date").equalsIgnoreCase("undefined") ?"":request.getParameter("date");
		String userid=session.getAttribute("USERID").toString();

		java.sql.Date sqlDate=null;

	    if(!(fdate.equalsIgnoreCase("undefined"))&&!(fdate.equalsIgnoreCase(""))&&!(fdate.equalsIgnoreCase("0"))){  
		     sqlDate=ClsCommon.changeStringtoSqlDate(fdate);
		}

	    
		String sql="",sqlsub="",sql1=""; 
		String temp="";
		int val=0;
		
	    sql="insert into sk_clpo(contno,contdet,fdate,edate, userrid, remarks) values('"+contno+"', '"+contdet+"', '"+sqlDate+"',now(), "+session.getAttribute("USERID").toString()+", '"+remarks+"')";
		// System.out.println("followup=="+sql);
	
		val= stmt.executeUpdate(sql);

	
			 
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
