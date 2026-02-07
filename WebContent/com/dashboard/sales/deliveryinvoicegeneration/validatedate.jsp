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

<%ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
 
 
String dates=request.getParameter("date")==null?"0":request.getParameter("date");
String duedates=request.getParameter("duedate")==null?"0":request.getParameter("duedate");
	

Connection conn=null;
String sql="";
try
{
	
	int method=0;
	int value=0;
	
					conn = ClsConnection.getMyConnection();
					Statement st=conn.createStatement();
	 
	 int days=0;
	       				 
	       				 Statement stmtqty=conn.createStatement();
	       				 String chkw="select method,coalesce(value,0) value  from gl_prdconfig where field_nme='duedatechk'";
	       				  
	       				 ResultSet rsszs=stmtqty.executeQuery(chkw); 
	       				 if(rsszs.next())
	       				 {
	       					 
	       					  
	       					method=rsszs.getInt("method");
	       					value=rsszs.getInt("value");
	       					 
	       				 }
	       				 if(method>0)
	       				 {
	       					 
	       			        java.sql.Date date = null;
	       			     	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
	       			     	{
	       			     	date=ClsCommon.changetstmptoSqlDate(dates);
	       			     		
	       			     	}
	       			     	else{
	       			     
	       			     	}

	       			        java.sql.Date duedate = null;
	       			     	if(!(duedates.equalsIgnoreCase("undefined"))&&!(duedates.equalsIgnoreCase(""))&&!(duedates.equalsIgnoreCase("0")))
	       			     	{
	       			     	duedate=ClsCommon.changetstmptoSqlDate(duedates);
	       			     		
	       			     	}
	       			     	else{
	       			     
	       			     	}
	       					 
	       					 
	       				 
			       				String sqls1="SELECT DATEDIFF('"+duedate+"', '"+date+"') dayval ";

 
 
			       			 ResultSet rsszs1=stmtqty.executeQuery(sqls1); 
		       				 if(rsszs1.next())
		       				 {
		       					 
		       					  
		       					days=rsszs1.getInt("dayval");
		       					 
		       					 
		       				 }
		       				 
		       				if(days>value) 
		       				{
		       					response.getWriter().print(value);
		       				}
		       			 
		       				else  
		       				{
		       					response.getWriter().print(1);
		       				}
		       				 
			       				
	       				 }
	       				 else
	       				 {
	       					response.getWriter().print(1);
	       				 }
	       					
				       
				    	
	       				conn.close(); 		
						
	
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(0);
    }
	 	
	 	
	 	
%>



 