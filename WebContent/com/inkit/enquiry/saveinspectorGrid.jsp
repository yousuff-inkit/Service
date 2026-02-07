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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%	

    String insp_id=request.getParameter("insp_id")==""?"0":request.getParameter("insp_id");
	String priority=request.getParameter("priority")==""?"0":request.getParameter("priority");
	String enq_id=request.getParameter("enq_id")==""?"0":request.getParameter("enq_id");
	
		ClsConnection ClsConnection=new ClsConnection();

		String upsql=null;
		String delsql=null;

		int val=0;
 		Connection conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmtdel = conn.createStatement();
	  
		if(!insp_id.trim().equalsIgnoreCase("undefined") && !insp_id.trim().equalsIgnoreCase("NaN")){
		
			delsql="delete from is_enqinspd where enq_id='"+enq_id+"' and insp_id='"+insp_id+"'";
		    val= stmt.executeUpdate(delsql);
		    
			upsql="INSERT INTO is_enqinspd(enq_id, insp_id, priority) values('"+enq_id+"','"+insp_id+"','"+priority+"')";	
			val= stmt.executeUpdate(upsql);
		
		}
		
		response.getWriter().print(enq_id);
	 
	 	stmt.close();
	 	stmtdel.close();
	 	conn.close();
	
%>