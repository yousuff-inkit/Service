<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
	String sessionid = session.getAttribute("COMPANYID")==null?"0":session.getAttribute("COMPANYID").toString();

ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = ClsConnection.getMyConnection();
	Statement stmtsys = conn.createStatement ();
	String amtdec="",curdec="";
	String strSys = "select cvalue,codeno from my_system where comp_id='"+sessionid+"'";
	System.out.println("======"+strSys);
	ResultSet rsSys = stmtsys.executeQuery (strSys);
	while(rsSys.next ()) {
		session.setAttribute(rsSys.getString("codeno").toUpperCase().trim(), rsSys.getString("cvalue").trim());
		if(rsSys.getString("codeno").equalsIgnoreCase("amtdec")){
			amtdec=rsSys.getString("cvalue").trim();
			System.out.println("iiiiiii  == "+amtdec);
		}
		if(rsSys.getString("codeno").equalsIgnoreCase("curdec")){
			curdec=rsSys.getString("cvalue").trim();
			System.out.println("iiiiiii  == "+curdec);
		}
	}
	
	stmtsys.close();
	conn.close ();
	response.getWriter().write(amtdec+"####"+curdec);
  %>
  
