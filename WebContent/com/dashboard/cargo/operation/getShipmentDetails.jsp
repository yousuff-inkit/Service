<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();       
Connection conn=null;         
String msg="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sql="select mawb, mbl, hawb, hbl, shipper, consignee, carrier, flightno, voage, etd, eta, ttime, boe, contno, truckno from cr_cfim where doc_no='"+docno+"'";
	System.out.println("sql===="+sql);            
	ResultSet rs=stmt.executeQuery(sql);       
	while(rs.next()){
			msg=rs.getString("mawb")+"::"+rs.getString("mbl")+"::"+rs.getString("hawb")+"::"+rs.getString("hbl")+"::"+rs.getString("shipper")
					+"::"+rs.getString("consignee")+"::"+rs.getString("carrier")+"::"+rs.getString("flightno")+"::"+rs.getString("voage")+"::"+rs.getString("etd")
					+"::"+rs.getString("eta")+"::"+rs.getString("ttime")+"::"+rs.getString("boe")+"::"+rs.getString("contno")+"::"+rs.getString("truckno");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}  
response.getWriter().write(msg);
%>