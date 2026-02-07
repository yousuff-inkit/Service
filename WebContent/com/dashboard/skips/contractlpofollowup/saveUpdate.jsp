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
		
		String contno=request.getParameter("contrno")==null?"0":request.getParameter("contrno");
		String contdet=request.getParameter("contdet")==null?"0":request.getParameter("contdet");

		String uptodate=request.getParameter("uptodate")==null|| request.getParameter("uptodate").equalsIgnoreCase("undefined") ?"":request.getParameter("uptodate");
		String userid=session.getAttribute("USERID").toString();
		java.sql.Date sqlDate=null;

	    if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))){  
		     sqlDate=ClsCommon.changeStringtoSqlDate(uptodate);
		}

	    
		String sql="",sqlsub="",sql1=""; 
		String temp="";
		int val=0,val1=0;
		String remark="Validity Extended";
		String fdate="";

	    sql="update sk_srvcontrd set validupto='"+sqlDate+"'where rdocno= '"+contno+"' ";
	    sql1="insert into sk_clpo(contno,contdet,fdate,edate, userrid, remarks) values('"+contno+"', '"+contdet+"','"+sqlDate+"',now(), "+session.getAttribute("USERID").toString()+", '"+remark+"')";


		// System.out.println("update=="+sql);
		val= stmt.executeUpdate(sql);
		val1=stmt.executeUpdate(sql1);
	
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
