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
		
		String doc_no=request.getParameter("doc_no")==""?"":request.getParameter("doc_no");
        String wastetypeid=request.getParameter("wastetypeid")==""?"0":request.getParameter("wastetypeid");
        String skipsizeid=request.getParameter("skipsizeid")==""?"0":request.getParameter("skipsizeid");
		String disposalfee=request.getParameter("disposalfee")==""?"0":request.getParameter("disposalfee");
		String weight=request.getParameter("weight")==""?"0":request.getParameter("weight");

		

		String sql=null;
		int val=0,row_no=0;
		
		sql="select coalesce(max(doc_no)+1,1) doc_no from sk_tippingtariff";
        ResultSet resultSet = stmt.executeQuery(sql);
  
       
       
  
        if (doc_no=="")
        {
        	
       
		
	     sql="insert into sk_tippingtariff(wastetypeid,skipsizeid,disposalfee,weight) values("+wastetypeid+", '"+skipsizeid+"', '"+disposalfee+"','"+weight+"'); ";

	     val= stmt.executeUpdate(sql);
	// System.out.println("==========="+sql);
        
        }
        else
        {
        	sql="update sk_tippingtariff set skipsizeid= '"+skipsizeid+"' , wastetypeid= '"+wastetypeid+"' , disposalfee= '"+disposalfee+"' , weight= '"+weight+"' where doc_no= '"+doc_no+"' ";

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
