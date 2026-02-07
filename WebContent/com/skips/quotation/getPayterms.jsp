<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
String billingmethod=request.getParameter("billingmethod")==null || request.getParameter("billingmethod")==""?"0":request.getParameter("billingmethod").trim().toString(); 
	Connection conn = null;
	String billtype="";
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		if(billingmethod.equalsIgnoreCase("1")){
			billtype="Monthly";
		}else if(billingmethod.equalsIgnoreCase("2")){
			billtype="Yearly";
		}else if(billingmethod.equalsIgnoreCase("3")){
			billtype="Adhoc";  
		}else{}
		
		String strSql = "select desc1,srno from sk_payterms where status=3 and billtype='"+billtype+"'";  
		ResultSet rs = stmt.executeQuery(strSql);
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("desc1")+",";
					sr+=rs.getString("srno")+",";
		} 
		if(!pro.equalsIgnoreCase("")){
			String procc[]=pro.split(",");
			String brnId[]=sr.split(",");
			
			pro=pro.substring(0, pro.length()-1);
			sr=sr.substring(0, sr.length()-1);
		}  
		response.getWriter().write(sr+"####"+pro);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  