<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
	String statusid=request.getParameter("doc_no")==null || request.getParameter("doc_no")==""?"0":request.getParameter("doc_no");
    String subremarks=request.getParameter("subremarks")==null || request.getParameter("subremarks")==""?"0":request.getParameter("subremarks");
    String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");
    String vocno=request.getParameter("vocno")==null?"0":request.getParameter("vocno");
    String adocno=request.getParameter("adocno")==null?"0":request.getParameter("adocno");   
	Connection conn=null;
	int val=0;
	try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 conn = ClsConnection.getMyConnection();
		 conn.setAutoCommit(false);
		 Statement stmt = conn.createStatement ();
		 int aaa=0;
		 int docval=0;
		
		 String sql="update cr_assignment set  cur_substatus="+statusid+",subremarks='"+subremarks+"' where doc_no="+adocno+"";   
	     aaa= stmt.executeUpdate(sql); 
	     
	     String status=""; 
		 String strSql = "select name from cr_substatus where doc_no="+statusid+"";    
		 ResultSet rs = stmt.executeQuery(strSql);
		 while(rs.next()) {
			 status=rs.getString("name");      
		 } 
		 
		 if(aaa>0){   
				String logdesc=status;               
				String upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY, description) values ('"+vocno+"','"+brhid+"','COPN',now(),'"+session.getAttribute("USERID").toString()+"','S','"+logdesc+"')";
		        val= stmt.executeUpdate(upsql);       
         }  
	     if(val>0){
		   conn.commit();    
           conn.close();
		 }			
		response.getWriter().print(val);
	 	stmt.close();
	 	conn.close();
	 }catch(Exception e){   
		 response.getWriter().print(0);
	 	 conn.close();
	 	 e.printStackTrace();
	 }
	%>