<%@page import="com.common.ClsEncrypt"%>
<%@page  import="com.common.ClsCommon"%>                    
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>   
<%
	System.out.println("IN  AP");
    String mob=request.getParameter("mob")==null?"":request.getParameter("mob").toString();   
    String tel=request.getParameter("tel")==null?"":request.getParameter("tel").toString();
    String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno").toString();
    String commmode=request.getParameter("commmode")==null || request.getParameter("commmode")==""?"":request.getParameter("commmode").toString();
    String clienttype=request.getParameter("clienttype")==null || request.getParameter("clienttype")==""?"":request.getParameter("clienttype").toString();
    String actdate=request.getParameter("actdate")==null || request.getParameter("actdate")==""?"0":request.getParameter("actdate").toString();
    String acttime=request.getParameter("acttime")==null || request.getParameter("acttime")==""?"":request.getParameter("acttime").toString();
    String client=request.getParameter("client")==null || request.getParameter("client")==""?"":request.getParameter("client").toString();
    String meetdate=request.getParameter("meetdate")==null || request.getParameter("meetdate")==""?"0":request.getParameter("meetdate").toString();
    String meettime=request.getParameter("meettime")==null || request.getParameter("meettime")==""?"":request.getParameter("meettime").toString();
    String venue=request.getParameter("venue")==null || request.getParameter("venue")==""?"":request.getParameter("venue").toString();
    String cperson=request.getParameter("cperson")==null || request.getParameter("cperson")==""?"":request.getParameter("cperson").toString();
    String description=request.getParameter("description")==null || request.getParameter("description")==""?"":request.getParameter("description").toString();

	ClsCommon objcommon=new ClsCommon(); 
    ClsConnection  ClsConnection=new ClsConnection(); 
	Connection conn=null;
	int i=0,val=0,apdocno=0;
	try    
	{
		conn=ClsConnection.getMyConnection();
		CallableStatement stmt=null; 
		conn.setAutoCommit(false);
		Statement stmtss=conn.createStatement();       
		java.sql.Date sqlactdate= null;        
		java.sql.Date sqlmeetdate = null;  
		java.sql.Date flwup= null;  
        if(!(actdate.equalsIgnoreCase("undefined"))&&!(actdate.equalsIgnoreCase(""))&&!(actdate.equalsIgnoreCase("0")))
     	{
        	sqlactdate=objcommon.changeStringtoSqlDate(actdate);
     	}
        if(!(meetdate.equalsIgnoreCase("undefined"))&&!(meetdate.equalsIgnoreCase(""))&&!(meetdate.equalsIgnoreCase("0")))  
     	{
        	sqlmeetdate=objcommon.changeStringtoSqlDate(meetdate);      
     	}
		    stmt=conn.prepareCall("insert into cm_appoinment(clienttype, cldocno, refname, appntdate, appnttime, meetdate, meettime, commmode, venue, cperson, description, mob, tel) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			stmt.setString(1,clienttype);
			stmt.setString(2,cldocno);
			stmt.setString(3,client);
			stmt.setDate(4,sqlactdate);
			stmt.setString(5,acttime);
			stmt.setDate(6,sqlmeetdate);            
			stmt.setString(7,meettime);
			stmt.setString(8,commmode);
			stmt.setString(9,venue);
			stmt.setString(10,cperson);
			stmt.setString(11,description);  
			stmt.setString(12,mob);  
			stmt.setString(13,tel);  
			i=stmt.executeUpdate();
			//System.out.println(i+"==IN  AP=="+stmt);      
			if(i>0){
				String getsql="select max(coalesce(doc_no,0)) docno from cm_appoinment";                                                        	                       
				ResultSet rs=stmtss.executeQuery(getsql); 
				while(rs.next()){
					apdocno=rs.getInt("docno");    
				}
				String remarks="Appointment Fix";         
				String sql111="insert into cm_activitylog(indatetime, inuserid, remarks, apdocno) values (now(),"+session.getAttribute("USERID").toString()+",'"+remarks+"','"+apdocno+"')";
				val= stmtss.executeUpdate(sql111);  
				//System.out.println(val+"==IN  AP=="+sql111);           
			} 
			if(val>0){         
				conn.commit();
			}
			 response.getWriter().print(val);              
	 	     stmt.close();
	 	     conn.close();
	}catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	finally
	{
		conn.close();
	}
%>