<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
    String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
	String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");
	String vocno=request.getParameter("vocno")==null?"0":request.getParameter("vocno");
	Connection conn=null;  
	int val=0;
	try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement ();
		 int aaa=0;
		 int docval=0;
		 
		 String sql="update cm_srvcontrm set cficonfirm=1 where tr_no="+docno+"";             
		 aaa= stmt.executeUpdate(sql);   
		
		 if(aaa>0){   
				String logdesc="CFI Confirmed";                     
				String upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY, description) values ('"+vocno+"','"+brhid+"','COPN',now(),'"+session.getAttribute("USERID").toString()+"','E','"+logdesc+"')";
		        val= stmt.executeUpdate(upsql);        
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