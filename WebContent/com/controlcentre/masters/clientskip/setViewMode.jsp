<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String masterdoc =request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").toString();
 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();
 ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	cldocno="",refname="",com_mob="",grpcmp="",contact="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		int rs=0;
		String str1Sql= "select cldocno,refname,com_mob,grpcmp,contactperson as contact from my_acbook where dtype='CRM' and status<>7 and cldocno='"+masterdoc+"'";
		System.out.println("view====="+str1Sql);      
		ResultSet rst=stmt.executeQuery(str1Sql);  
        while(rst.next()) {
        	cldocno=rst.getString("cldocno");
        	refname=rst.getString("refname");
        	com_mob=rst.getString("com_mob");
        	grpcmp=rst.getString("grpcmp"); 
        	contact=rst.getString("contact");
        }    
		response.getWriter().write(cldocno+"###"+refname+"###"+com_mob+"###"+grpcmp+"###"+contact);    

		stmt.close();
		conn.close();  
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  