<%@page import="com.common.ClsEncrypt"%>
<%@page  import="com.common.ClsCommon"%>                    
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>   
<%
	System.out.println("IN  Next Followup1");    
	String flwupdate=request.getParameter("flwupdate")==null?"":request.getParameter("flwupdate").toString();
	String flwuptime=request.getParameter("flwuptime")==null?"":request.getParameter("flwuptime").toString();
	String flwupdesc=request.getParameter("flwupdesc")==null?"":request.getParameter("flwupdesc").toString();
	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
	String nextflwuptype=request.getParameter("nextflwuptype")==null?"":request.getParameter("nextflwuptype").toString();
	System.out.println("flwupdate="+flwupdate+"=flwuptime="+flwuptime+"=flwupdesc="+flwupdesc+"=docno="+docno+"=nextflwuptype="+nextflwuptype); 
	ClsCommon objcommon=new ClsCommon();   
    ClsConnection  ClsConnection=new ClsConnection();  
	Connection conn=null;
	int val=0,flwpdocno=0;
	String meetdate="",meettime="";     
	try    
	{
		conn=ClsConnection.getMyConnection();
		CallableStatement stmt=null; 
		conn.setAutoCommit(false);
		Statement stmtss=conn.createStatement();       
		java.sql.Date sqlflwupdate= null;        
        if(!(flwupdate.equalsIgnoreCase("undefined"))&&!(flwupdate.equalsIgnoreCase(""))&&!(flwupdate.equalsIgnoreCase("0")))
     	{
        	sqlflwupdate=objcommon.changeStringtoSqlDate(flwupdate);    
     	}
        String sql="insert into cm_appointmentflwup(date, time, userid, remarks, flwuptype, appntdocno) values('"+sqlflwupdate+"','"+flwuptime+"',"+session.getAttribute("USERID").toString()+",'"+flwupdesc+"','"+nextflwuptype+"','"+docno+"')";                   
        System.out.println("sql--->>>"+sql);  
        val=stmtss.executeUpdate(sql);  
		System.out.println("==val=="+val);      
		if(val>0){
				if(nextflwuptype.equalsIgnoreCase("Extent")){
					String getsql1="select max(coalesce(rowno,0)) docno from cm_appointmentflwup";                                                          	                       
					ResultSet rs1=stmtss.executeQuery(getsql1); 
					while(rs1.next()){
						flwpdocno=rs1.getInt("docno");      
					}
					String getsql2="select date_format(meetdate,'%d.%m.%Y') meetdate,meettime from cm_appoinment where doc_no='"+docno+"'";                                                          	                       
					ResultSet rs2=stmtss.executeQuery(getsql2); 
					while(rs2.next()){
						meetdate=rs2.getString("meetdate");   
						meettime=rs2.getString("meettime");   
					}
					String sqlupdate1="update cm_appointmentflwup set meetdate='"+objcommon.changeStringtoSqlDate(meetdate)+"',meettime='"+meettime+"' where rowno='"+flwpdocno+"'";     
					val= stmtss.executeUpdate(sqlupdate1);
					
					String sqlupdate2="update cm_appoinment set meetdate='"+sqlflwupdate+"',meettime='"+flwuptime+"' where doc_no='"+docno+"'";         
					val= stmtss.executeUpdate(sqlupdate2);  
				}
			}
			if(val>0){   
				String sql111="insert into cm_activitylog(indatetime, inuserid, remarks, apdocno) values (now(),"+session.getAttribute("USERID").toString()+",'"+nextflwuptype+"','"+docno+"')";    
				System.out.println("sql111--->>>"+sql111);    
				val= stmtss.executeUpdate(sql111);   
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