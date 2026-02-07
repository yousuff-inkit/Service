<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>   
<%

		//System.out.println("dipatchcreation");
	
		//String task=request.getParameter("task");
		
//docno,sdate,stime,asuser,ashiduser,client,hidclient,location,contact,dispatch,collect,msg,userid,hiduser
		//String refno=request.getParameter("docno");
		String sdate=request.getParameter("sdate");
		String stime=request.getParameter("stime");
		String asuser=request.getParameter("asuser");
		String ashiduser=request.getParameter("ashiduser");
		String hidcldocno=request.getParameter("hidclient");  
		String address=request.getParameter("address");
		String contact=request.getParameter("contact");
		String location=request.getParameter("location");          
		String collect=request.getParameter("collect");
		String dispatch=request.getParameter("dispatch");
		String message=request.getParameter("msg");
		String userid=request.getParameter("userid");
		String cltype=request.getParameter("cltype");
		String type="";  
		
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	
	
	Connection conn=null;
	
	
	int i=0;
	String msg="";
	String doc="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		
		
		
		    CallableStatement stmt=conn.prepareCall("{call in_dispatchcreationDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(13, java.sql.Types.INTEGER);
			//stmt.setString(1,refno);
			stmt.setString(1,sdate);
			stmt.setString(2,stime);
			stmt.setString(3,hidcldocno);
			stmt.setString(4,address);
			stmt.setString(5,location);
			stmt.setString(6,contact);
			stmt.setString(7,dispatch);
			stmt.setString(8,collect);
			stmt.setString(9,message);
			stmt.setString(10,userid);
			stmt.setString(11,ashiduser);
			stmt.setString(12,cltype);
			stmt.executeUpdate();
			i=stmt.getInt("docno");
			if(i>0)
			{
				doc=Integer.toString(i);
				
				//System.out.println("msg");
				msg="1";
				
				 
				
			}
			
			else
			{
				msg="0";
			}
		

	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	finally
	{
		conn.close();
	}
	response.getWriter().write(msg);
%>