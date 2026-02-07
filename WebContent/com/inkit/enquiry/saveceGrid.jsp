
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

ClsConnection ClsConnection=new ClsConnection();

	String [] cearray=request.getParameterValues("cearray");
	String enq_id=request.getParameter("enq_id");
	

	 String upsql=null;

	 int val=0;
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	 

		/*  upsql="INSERT INTO is_costestimate(doc_no, enq_id, costfield_id, Nhr, Hhr, Thr,Mday8Hr, Mday10Hr, Hmday8Hr, Hmday10Hr, Mn22x8Hr, Mn22x10Hr, Hmn22x8Hr, Hmn22x10Hr, otabv8Hr, otabv10Hr, Hotabv8Hr, Hotabv10Hr, Magepkm, Magepmi, peridum, lodging, carchg, trainchg, buschg, taxichg, flightchg, mealschg, tollchg, fuelchg, othrchg)" 
		 "+values('"+enq_id+"','"+insp_id+"','"+priority+"')"; */
		
		     val= stmt.executeUpdate(upsql);
	
		
			 
	
		 				
		 response.getWriter().print(enq_id);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	    
	
	%>