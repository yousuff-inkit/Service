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
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String rowno=request.getParameter("rowno")==""?"":request.getParameter("rowno");
        String skipsizeid=request.getParameter("skipsizeid")==""?"0":request.getParameter("skipsizeid");
		String froms=request.getParameter("froms")==""?"0":request.getParameter("froms");
		String tos=request.getParameter("tos")==""?"0":request.getParameter("tos");
		String client=request.getParameter("client")==""?"0":request.getParameter("client");
		String own=request.getParameter("own")==""?"0":request.getParameter("own");
		
		

		String sql=null;
		int val=0,row_no=0;
		
		
       
  
        if (rowno=="")
        {
        	
       
		
	     sql="insert into sk_skiptarif(skiptypeid, `from`, `to`, `client`, own) values("+skipsizeid+", '"+froms+"', '"+tos+"', '"+client+"', '"+own+"'); ";

	     val= stmt.executeUpdate(sql);
	// System.out.println("==========="+sql);
        
        }
        else
        {
        	sql="update sk_skiptarif set skiptypeid= '"+skipsizeid+"' ,`from`= '"+froms+"' ,`to`= '"+tos+"' ,`client`= '"+client+"' , own= '"+own+"' where rowno= '"+rowno+"' ";

   		 val= stmt.executeUpdate(sql);
   		// System.out.println("==========="+sql);

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
