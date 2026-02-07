<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String groupid =request.getParameter("groupid")==null || request.getParameter("groupid")==""?"0":request.getParameter("groupid").toString();
 String grpmemberid =request.getParameter("grpmemberid")==null || request.getParameter("grpmemberid")==""?"0":request.getParameter("grpmemberid").toString();
 String grpempid =request.getParameter("grpempid")==null || request.getParameter("grpempid")==""?"0":request.getParameter("grpempid").toString();
 String assignid =request.getParameter("assignid")==null || request.getParameter("assignid")==""?"0":request.getParameter("assignid").toString();
 String trno =request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
 String schtrno =request.getParameter("schtrno")==null || request.getParameter("schtrno")==""?"0":request.getParameter("schtrno").toString();
 String brchid =request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();
 String desc =request.getParameter("desc")==null?"":request.getParameter("desc").toString();
 String pdate =request.getParameter("pdate")==null?"":request.getParameter("pdate").toString();   
 String ptime =request.getParameter("ptime")==null?"":request.getParameter("ptime").toString();  
 //System.out.println("schtrno=="+schtrno);
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="",process="ASN";  
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		
		String sql1="",strdelSql="",strupSql="";
		int rs=0,rsup=0;
		if(!(brchid.equalsIgnoreCase("0") || brchid.equalsIgnoreCase("undefined") || brchid.equalsIgnoreCase("a") )){
			sql1=" and brhid="+brchid+"";
		}
		else{
			brchid="0";
		}
		if(!(pdate.equalsIgnoreCase("0") || pdate.equalsIgnoreCase("undefined") || pdate.equalsIgnoreCase("a") )){
			sdate = ClsCommon.changeStringtoSqlDate(pdate);
		}
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		
		if(!(schtrno.equalsIgnoreCase("0") || schtrno.equalsIgnoreCase("undefined") || schtrno.equalsIgnoreCase(null)|| schtrno.equalsIgnoreCase("") )){
			 strdelSql = "delete from gl_beqs where tr_no="+schtrno+" ";      
		//	 System.out.println("strdelSql=="+strdelSql);
			 int rs1 = stmt.executeUpdate(strdelSql);
		}
	
		strupSql = "update gl_enqm set sh_empid="+grpempid+" where doc_no="+trno+" and status=3 ";       
		rsup = stmt.executeUpdate(strupSql);
		if(rsup>0){      
			 String sqlassign="insert into gl_beqs (brhid,rdocno, empGroupId, empId, asgnMode, plannedOn, plTime, description, process) values ('"+brchid+"','"+trno+"',"+groupid+","+grpempid+","+assignid+",'"+sdate+"','"+ptime+"','"+desc+"','"+process+"')";
			 stmt.executeUpdate(sqlassign);
			
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+branchid+"','BEQS',now(),'"+userid+"','E')";
			 rs= stmt.executeUpdate(sqls);
			 if(rs<=0){
				 stmt.close();
				    conn.close();
			 }
		}
		response.getWriter().print(rs);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  