<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();
	 String upsql=null;
	 int val=0;
	 int docval=0;
	 Connection conn=null;
	 try{
 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	Statement stmt1 = conn.createStatement ();
				   upsql="select method from gl_config where field_nme = 'servicesalebankdetails'";
				   //System.out.println("===show bank details======"+upsql);
				   ResultSet resultSet = stmt.executeQuery(upsql);
				    
				    if (resultSet.next()) {
				    	docval=resultSet.getInt("method");
				    }		  
			
			 response.getWriter().print(docval);
	 	stmt.close();
	 	stmt1.close();
	 	conn.close();
	 }
	 catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
	%>