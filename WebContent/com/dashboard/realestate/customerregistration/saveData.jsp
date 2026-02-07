<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>  
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>  
<%@page import="javax.servlet.http.HttpSession" %>   
<%@page import="com.common.*"%>                   
<%  
    int docno=request.getParameter("docno")==null || request.getParameter("docno")==""?0:Integer.parseInt(request.getParameter("docno").toString());
	String status=request.getParameter("status")==null || request.getParameter("status")==""?"0":request.getParameter("status");     
    String remarks=request.getParameter("remarks")==null || request.getParameter("remarks")==""?"":request.getParameter("remarks");
    String userid=session.getAttribute("USERID").toString();                   
	ClsConnection objconn=new ClsConnection();    
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;
	int val=0;          
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement(); 
				 String sql="update rl_guestregm set sdocno='"+status+"' where doc_no="+docno+"";                 
				 //System.out.println("====sql===="+sql);   
				 val=stmt.executeUpdate(sql);     
			 /*  String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','PIV',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                       
			 //System.out.println(val+"====sqllog===="+sqllog);
			 stmt.executeUpdate(sqllog);   */             
			 conn.commit(); 
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}   
	response.getWriter().print(val);                              
%>