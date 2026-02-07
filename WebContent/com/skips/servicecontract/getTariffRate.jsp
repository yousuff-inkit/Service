<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
String ownership =request.getParameter("ownership")==null || request.getParameter("ownership")==""?"0":request.getParameter("ownership").toString();   
Double noofvisit =request.getParameter("noofvisit")==null || request.getParameter("noofvisit")==""?0.0:Double.parseDouble(request.getParameter("noofvisit").toString()); 
String skipdoc =request.getParameter("skipdoc")==null || request.getParameter("skipdoc")==""?"0":request.getParameter("skipdoc").toString();   
Double tripsinmonth =request.getParameter("tripsinmonth")==null || request.getParameter("tripsinmonth")==""?0.0:Double.parseDouble(request.getParameter("tripsinmonth").toString());     
 Connection conn = null;  
 ClsConnection ClsConnection=new ClsConnection();    
 ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();  
		Double tariff=0.0;
		String str1Sql= "select if('"+ownership+"'='CLIENT SKIP',t.client,t.own) tariff from sk_skiptarif t where "+noofvisit+"*"+tripsinmonth+" between t.from and t.to and t.skiptypeid='"+skipdoc+"'";
		//System.out.println("tariff rate====="+str1Sql);          
		ResultSet rst=stmt.executeQuery(str1Sql);  
        while(rst.next()) {
        	tariff=rst.getDouble("tariff");
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
  