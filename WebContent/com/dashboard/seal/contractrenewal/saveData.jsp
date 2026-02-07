<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
   
<%	
	ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon= new ClsCommon();
	Connection conn = null;
 int val=0;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String tempdocno = request.getParameter("tempdocno")==null?"":request.getParameter("tempdocno").trim().toString();  
		String trno = request.getParameter("trno")==null || request.getParameter("trno").trim().equals("")?"0":request.getParameter("trno").trim().toString();
		String expdate = request.getParameter("expdate")==null?"":request.getParameter("expdate").trim().toString();
		String expdesc = request.getParameter("expdesc")==null?"":request.getParameter("expdesc").trim().toString();
		String userid = session.getAttribute("USERID").toString();     
		java.sql.Date sqlDate=null;       

	    if(!(expdate.equalsIgnoreCase("undefined"))&&!(expdate.equalsIgnoreCase(""))&&!(expdate.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(expdate);
		}
			String sqlup="UPDATE cm_srvcontrm SET validUpto = '"+sqlDate+"' WHERE tr_no="+trno+"";
			//System.out.println("sqlup=="+sqlup);
			val = stmt.executeUpdate(sqlup);
		if (val>0){
			String sqlup3="INSERT INTO sa_srvcontrren ( entrydate, remarks, rdocno, expirydate,userid) VALUES (now(),'"+expdesc+"','"+trno+"','"+sqlDate+"','"+userid+"')";
			//System.out.println("sqlup3=="+sqlup3);     
			val = stmt.executeUpdate(sqlup3);
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