<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<% 
    String psrno = request.getParameter("psrno")==null || request.getParameter("psrno")==""?"0":request.getParameter("psrno").trim();
	String prodoc = request.getParameter("prodoc")==null || request.getParameter("prodoc")==""?"0":request.getParameter("prodoc").trim();
	int qty = request.getParameter("qty")==null || request.getParameter("qty")==""?0:Integer.parseInt(request.getParameter("qty").trim());  
	String oldbinid = request.getParameter("oldbinid")==null || request.getParameter("oldbinid")==""?"0":request.getParameter("oldbinid").trim();
	String newbinid = request.getParameter("newbinid")==null || request.getParameter("newbinid")==""?"0":request.getParameter("newbinid").trim();  
	String rdocno = request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim();
	String rdtype = request.getParameter("rdtype")==null || request.getParameter("rdtype")==""?"":request.getParameter("rdtype").trim();
	String rbrhid = request.getParameter("rbrhid")==null || request.getParameter("rbrhid")==""?"0":request.getParameter("rbrhid").trim();
	Connection conn=null;
	int val=0;  
	 try{
		  ClsConnection ClsConnection=new ClsConnection();
 	      conn = ClsConnection.getMyConnection();
 	      conn.setAutoCommit(false);
	      Statement stmt = conn.createStatement ();
	      System.out.println(rdocno+"=rdocno=rdtype="+rdtype);        
		     
          String sql1="insert into my_whm(psrno, prdid, binid, qty, rdocno, rdtype, rbrhid) values('"+psrno+"','"+prodoc+"','"+oldbinid+"','"+qty*-1+"','"+rdocno+"','"+rdtype+"','"+rbrhid+"')";      
		  System.out.println("-----sql1----"+sql1) ;  
		  val = stmt.executeUpdate(sql1);   
		  
		  String sql2="insert into my_whm(psrno, prdid, binid, qty, rdocno, rdtype, rbrhid) values('"+psrno+"','"+prodoc+"','"+newbinid+"','"+qty+"','"+rdocno+"','"+rdtype+"','"+rbrhid+"')";      
		  System.out.println("-----sql2----"+sql2) ;    
		  val = stmt.executeUpdate(sql2);    
			  
		  String logdesc="Warehouse Management - Transfer slip created.";              
	      String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+rdocno+",'"+rbrhid+"','WHM',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
		   //System.out.println(val+"====sqllog===="+sqllog);   
		  stmt.executeUpdate(sqllog);    
	  
		 if(val>0) {
			  conn.commit();
		 }
	 	stmt.close();
	 	conn.close();
	 	response.getWriter().print(1);  
	 }
	 catch(Exception e){
			conn.close();
			e.printStackTrace();  
	 }
	%>
