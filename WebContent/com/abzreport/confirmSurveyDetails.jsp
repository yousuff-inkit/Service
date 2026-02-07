<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>     
<%	

	ClsConnection connDAO=new ClsConnection();
	Connection conn = null;
	java.sql.Date sqlDate=null;
	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();
	try{                                                      
		String sql=null;
		int val=0;
	 	conn=connDAO.getMyConnection();
	 	Statement stmt=conn.createStatement(); 
        String sqlup="update gl_enqm set pconfirm=1 where doc_no="+docno+"";  
        //System.out.println("sqlup=="+sqlup);
		int val1=stmt.executeUpdate(sqlup); 
		if(val1>0){
				val=1;     
		}    
        response.getWriter().print(val);          

	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>

