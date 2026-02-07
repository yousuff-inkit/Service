
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
	
	String groupno = request.getParameter("groupno")==null?"0":request.getParameter("groupno").trim();
	String issue_ret= request.getParameter("issue_ret")==null?"0":request.getParameter("issue_ret").trim();
	String issue_to = request.getParameter("issue_to")==null?"0":request.getParameter("issue_to").trim();
	String hiassetno=request.getParameter("hiassetno")==null?"0":request.getParameter("hiassetno").trim();
	String hidaccount=request.getParameter("hidaccount")==null?"0":request.getParameter("hidaccount").trim();
	String userid = request.getParameter("userid")==null?"0":request.getParameter("userid").trim();
	String issueddate= request.getParameter("issueddate")==null?"0":request.getParameter("issueddate").trim();

//String aa=session.getAttribute("BRANCHID").toString();

	 Connection conn=null;

	 try{
		 
			int val=0;
			
			java.sql.Date sqlIssuedDate=null;
            
			issueddate.trim();
            if(!(issueddate.equalsIgnoreCase("undefined"))&&!(issueddate.equalsIgnoreCase(""))&&!(issueddate.equalsIgnoreCase("0"))) {
            	sqlIssuedDate = ClsCommon.changeStringtoSqlDate(issueddate);
            }
            
		 	conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			Statement stmt1 = conn.createStatement();
	
			String maxdocno="";
			String issu_status="";
			String upfixmsql="";
			String insql="";
			if(issue_ret.equalsIgnoreCase("issue")){
				issu_status="1";
				insql="insert into gl_bfai(date, issueret_stat, issuedt, type, type_no, asset_no, userid, status) values(now(),"+issu_status+", '"+sqlIssuedDate+"', '"+issue_to+"',"+hidaccount+","+hiassetno+","+userid+",3);";
				upfixmsql="update my_fixm set issue_status='"+issu_status+"',issuedt='"+sqlIssuedDate+"' where sr_no='"+hiassetno+"' ;" ;
			}
			if(issue_ret.equalsIgnoreCase("ret")){
				issu_status="0";
				insql="insert into gl_bfai(date, issueret_stat, returneddt, type, type_no, asset_no, userid, status) values(now(),"+issu_status+", '"+sqlIssuedDate+"', '"+issue_to+"',"+hidaccount+","+hiassetno+","+userid+",3);";
				upfixmsql="update my_fixm set issue_status='"+issu_status+"' where sr_no='"+hiassetno+"' ;" ;
			}
			
			
			val= stmt.executeUpdate(insql);
			val= stmt.executeUpdate(upfixmsql);
			
			String getdocno="select max(doc_no)  docNo from gl_bfai";
			ResultSet result = stmt1.executeQuery(getdocno); 
    		while(result.next()){
    	 		maxdocno=result.getString("docNo");
    		}
			String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+maxdocno+"','1','BFAI',now(),'"+userid+"','A')";
			stmt.executeUpdate(datalog);
	
    		response.getWriter().print(val);
    		
	 		stmt.close();
	 		conn.close();
	 	  
	 }
	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
