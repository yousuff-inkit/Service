<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		
		String enqprocess=request.getParameter("enqprocess");
		String date=request.getParameter("date");
		String rdtype=request.getParameter("rdtype");
	    String docno=request.getParameter("docno");
		String brhid=request.getParameter("brhid");
		String remarks=request.getParameter("remarks");
		//System.out.println("enqprocess=="+enqprocess);
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

	    
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		 if(enqprocess.equalsIgnoreCase("1")){  
			 sql="insert into gl_bqot(date, rdocno, reftype, fdate, remarks , userid) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+session.getAttribute("USERID").toString()+")";
			 //System.out.println("sql6===="+sql);
			 val= stmt.executeUpdate(sql);
			 if(val>0){
				 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','PSMT',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 stmt.executeUpdate(logsql);  
			 }  
		}else if(enqprocess.equalsIgnoreCase("2")){  
			 sql="update gl_bqot set status=7 where rdocno="+docno+" and reftype='"+rdtype+"'";
			 //System.out.println("sql6===="+sql);
			 val= stmt.executeUpdate(sql);
			 if(val>0){
				 String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','PSMT',now(),'"+session.getAttribute("USERID").toString()+"','E')";
				 stmt.executeUpdate(logsql);  
			 }  
		}   
		 System.out.println("val===="+val);  
		 if(val>0){  
			 conn.commit();
		 }
		 response.getWriter().print(val);    
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
