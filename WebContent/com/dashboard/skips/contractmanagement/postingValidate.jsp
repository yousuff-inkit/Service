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
	 	Statement stmt = conn.createStatement();
	 	String rowno=request.getParameter("rowno")==null || request.getParameter("rowno").trim()==""?"0":request.getParameter("rowno").trim();
	 	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
	 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
	 	
		int val1=1,val2=0,val=0;   
		
		/*String strsql1="select if(invdate is null,0,1) val from sk_srvcontrdet where rowno='"+rowno+"'"; 
		//System.out.println("strsql1==="+strsql1);
		ResultSet rs1 = stmt.executeQuery(strsql1);      
		while(rs1.next()) {
			val1=rs1.getInt("val");     
		}*/    
		
		String strsql2="select doc_no from sk_srvcontrsch where rdocno='"+contrno+"' and srno='"+srno+"'";          
		//System.out.println("strsql2==="+strsql2);  
		ResultSet rs2 = stmt.executeQuery(strsql2);    
		while(rs2.next()) {
			val2=rs2.getInt("doc_no");     
		}
		response.getWriter().print(val1+"####"+val2);  
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
