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
		String docno=request.getParameter("docno");
		String comment=request.getParameter("comment");
		String cldocno=request.getParameter("cldocno");
		String sql=null;
		String sqlb=null;
		int count=0,val=0;
		if(!(docno.equalsIgnoreCase("undefined"))&&!(docno.equalsIgnoreCase(""))&&!(docno.equalsIgnoreCase("0"))){
			sql ="update gw_compintcomments set comment='"+comment+"', date=now(), userid='"+session.getAttribute("USERID").toString()+"' where doc_no= '"+docno+"' ";
			sqlb = "insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','ICL',now(),'"+session.getAttribute("USERID").toString()+"','E')";
		} else {
			String sqls="select coalesce(max(doc_no)+1,1) doc_no from gw_compintcomments";
	        ResultSet resultSet = stmt.executeQuery(sqls);
	        while (resultSet.next()) {
			   docno+=resultSet.getInt("doc_no");
	        }
			sql ="insert into gw_compintcomments (doc_no,cldoc_no, comment, status, date, userid) values('"+docno+"','"+cldocno+"','"+comment+"', 3, now(), '"+session.getAttribute("USERID").toString()+"')";
			sqlb="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','ICL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		}
	    val= stmt.executeUpdate(sql);
		if(val<=0) {
			stmt.close();
			conn.close();
		}
		int data= stmt.executeUpdate(sqlb);
		response.getWriter().print(val);
	 	stmt.close();
	 	conn.close();
	} catch(Exception e) {
	 	e.printStackTrace();
	 	conn.close();
   	} finally {
	   conn.close();
 	}
%>
