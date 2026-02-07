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
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	 	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();
	 	String rowno=request.getParameter("rowno")==null || request.getParameter("rowno").trim()==""?"0":request.getParameter("rowno").trim();
		String trno=request.getParameter("trno")==null || request.getParameter("trno").trim()==""?"0":request.getParameter("trno").trim();  
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		String reason=request.getParameter("reason")==null || request.getParameter("reason").trim()==""?"":request.getParameter("reason").trim();
		String date=request.getParameter("date")==null?"":request.getParameter("date").trim(); 
		String time=request.getParameter("time")==null?"":request.getParameter("time").trim();
		String statusid=request.getParameter("status")==null || request.getParameter("status")==""?"0":request.getParameter("status").trim();	
		String wasteweight=request.getParameter("wasteweight")==null || request.getParameter("wasteweight").trim()==""?"0":request.getParameter("wasteweight").trim();
		String exweight=request.getParameter("exweight")==null || request.getParameter("exweight").trim()==""?"0":request.getParameter("exweight").trim();
		String exprice=request.getParameter("exprice")==null || request.getParameter("exprice").trim()==""?"0":request.getParameter("exprice").trim(); 
		System.out.println("process--->>>"+processid+"===rowno==="+rowno);        
	    
		String sql="",sqlsub="",sql1="";  
		String temp="";
		int val=0;
		java.sql.Date sqldate = null;
	   
		if(processid.equalsIgnoreCase("Cancel")){  
			 if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {  
				 sqldate=ClsCommon.changeStringtoSqlDate(date);  
		      }else{}
			 String upsql="update sk_srvcontrdet set cancel=1, cdate='"+sqldate+"', ctime='"+time+"', creason='"+reason+"' where rowno='"+rowno+"'";                 
				 // System.out.println("upsql--->>>"+upsql);
			  val= stmt.executeUpdate(upsql);
			  if(val>0){ 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+rowno+"','"+brhid+"','CCL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			  }
			  if(val>0){
				 temp="1";  
			  }
	     }else if(processid.equalsIgnoreCase("Approve")){  
			 String upsql="update sk_srvcontrdet set cancelapprove=1 where rowno='"+rowno+"'";                   
				 // System.out.println("upsql--->>>"+upsql);
			  val= stmt.executeUpdate(upsql);
			  if(val>0){ 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+rowno+"','"+brhid+"','CCL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			  }
			  if(val>0){
				 temp="1";  
			  }
	     }else if(processid.equalsIgnoreCase("Collection")){   
			 if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {  
				 sqldate=ClsCommon.changeStringtoSqlDate(date);  
		      }else{}
			 String upsql="insert into sk_collection(drowno, date, time, reason, statusid, wsweight, exweight, exprice) values('"+rowno+"', '"+sqldate+"', '"+time+"', '"+reason+"', '"+statusid+"', "+Double.parseDouble(wasteweight)+", "+Double.parseDouble(exweight)+", "+Double.parseDouble(exprice)+")";                     
				 // System.out.println("upsql--->>>"+upsql);
			  val= stmt.executeUpdate(upsql);
			  if(val>0){ 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+rowno+"','"+brhid+"','CCL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			  }
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
