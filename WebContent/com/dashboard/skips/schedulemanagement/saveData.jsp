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
<%@page import="com.email.*"%>
<%@page import="com.controlcentre.masters.dumpmaster.route.ClsRouteDAO"%>    
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		ClsRouteDAO DAO=new ClsRouteDAO();
	 	Statement stmt = conn.createStatement();
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		
		String schdate=request.getParameter("schdate")==null?"":request.getParameter("schdate").trim();
		String schtime=request.getParameter("schtime")==null?"":request.getParameter("schtime").trim();	
		String driverid=request.getParameter("driverid")==null || request.getParameter("driverid").trim()==""?"0":request.getParameter("driverid").trim();
		String helperid=request.getParameter("helperid")==null || request.getParameter("helperid").trim()==""?"0":request.getParameter("helperid").trim(); 
		String routeid=request.getParameter("routeid")==null || request.getParameter("routeid").trim()==""?"0":request.getParameter("routeid").trim(); 
		
		String code=request.getParameter("code")==null?"":request.getParameter("code").trim();  
		String name=request.getParameter("name")==null?"":request.getParameter("name").trim();	
		String dumpsiteid=request.getParameter("dumpsiteid")==null || request.getParameter("dumpsiteid").trim()==""?"0":request.getParameter("dumpsiteid").trim();
		String vehgroupid=request.getParameter("vehgroupid")==null || request.getParameter("vehgroupid").trim()==""?"0":request.getParameter("vehgroupid").trim(); 
		String areaid=request.getParameter("areaid")==null || request.getParameter("areaid").trim()==""?"0":request.getParameter("areaid").trim();   
		
		System.out.println("process--->>>"+processid);        
	    
		String sql="",sqlsub="",sql1="";    
		String temp="";
		int val=0;
		java.sql.Date sqldate = null;
		 /*Submit */
		if(processid.equalsIgnoreCase("Schedule")){     
			 if(!(schdate.equalsIgnoreCase("undefined"))&&!(schdate.equalsIgnoreCase(""))&&!(schdate.equalsIgnoreCase("0"))) {     
				 sqldate=ClsCommon.changeStringtoSqlDate(schdate);  
		      }else{}  
			  String inssql="insert into sk_schedule(driverid, helperid, routeid, date, time) values('"+driverid+"','"+helperid+"','"+routeid+"','"+sqldate+"','"+schtime+"')";                   
			  // System.out.println("inssql--->>>"+inssql);  
		      val= stmt.executeUpdate(inssql);    
			 if(val>0){
				 temp="1";  
			 }
	     }if(processid.equalsIgnoreCase("Route")){     
			 if(!(schdate.equalsIgnoreCase("undefined"))&&!(schdate.equalsIgnoreCase(""))&&!(schdate.equalsIgnoreCase("0"))) {     
				 sqldate=ClsCommon.changeStringtoSqlDate(schdate);  
		      }else{}  
			 val=DAO.insert( code, name , vehgroupid, dumpsiteid, areaid,  "A",  session, "RTE", "", "", "", "");
			 if(val>0){
				 temp="1";   
			 }
	     }else{}        
		 
		if(temp.equalsIgnoreCase("1")){  
			conn.commit();
		}
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
