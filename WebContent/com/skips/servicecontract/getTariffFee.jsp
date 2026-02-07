<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String skipsize =request.getParameter("skipsize")==null || request.getParameter("skipsize")==""?"0":request.getParameter("skipsize").toString(); 
 String wastetype =request.getParameter("wastetype")==null || request.getParameter("wastetype")==""?"0":request.getParameter("wastetype").toString(); 
 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();  
 ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		Double tariff=0.0;
		String str1Sql= "select coalesce(disposalfee,0) tippingfee from sk_tippingtariff where  wastetypeid='"+wastetype+"' and skipsizeid='"+skipsize+"'";
		//System.out.println("tariff Fee====="+str1Sql);         
		ResultSet rst=stmt.executeQuery(str1Sql);  
        while(rst.next()) {
        	tariff=rst.getDouble("tippingfee");
        }       
		response.getWriter().print(tariff);     

		stmt.close();
		conn.close();  
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  