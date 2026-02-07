<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String groupid =request.getParameter("groupid")==null?"0":request.getParameter("groupid").toString();
 String grpmemberid =request.getParameter("grpmemberid")==null?"0":request.getParameter("grpmemberid").toString();
 String grpempid =request.getParameter("grpempid")==null?"0":request.getParameter("grpempid").toString();
 String assignid =request.getParameter("assignid")==null?"0":request.getParameter("assignid").toString();
 String trno =request.getParameter("trno")==null?"0":request.getParameter("trno").toString();
 String srno =request.getParameter("srno")==null?"0":request.getParameter("srno").toString();
 String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
 String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
 String brchid =request.getParameter("brchid")==null?"0":request.getParameter("brchid").toString();
 String desc =request.getParameter("desc")==null?"":request.getParameter("desc").toString();
 String pdate =request.getParameter("pdate")==null?"":request.getParameter("pdate").toString();
 String ptime =request.getParameter("ptime")==null?"":request.getParameter("ptime").toString();
 
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		
		String sql1="";
		if(!(clientid.equalsIgnoreCase("0") || clientid.equalsIgnoreCase("undefined") || clientid.equalsIgnoreCase("") )){
			sql1=" and cldocno="+clientid+"";
		}
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
		
		String[] empdoc=grpempid.split(",");
		
		String empid1=empdoc[0].split("::")[0];
		String empdb1=empdoc[0].split("::")[1];
		
		
		String Sql="select empgroupid from cm_srvassign where refdocno='"+trno+"' and ptrno='"+srno+"' and inactive=0 and brhid="+branchid+"";
		ResultSet dbRs = stmt.executeQuery(Sql);	
		System.out.println("sqlempgroup===="+Sql);
		int oldgrpid=0;
		while(dbRs.next()){
			oldgrpid=dbRs.getInt("empgroupid");
		}
		
		if(dtype.equalsIgnoreCase("STC"))
		{
			strSql = "update cm_staffcontrd set empGroupId="+groupid+" where rdocno='"+trno+"' and rowno='"+srno+"'";
		}
		else if(dtype.equalsIgnoreCase("AMS"))
		{
			strSql = "update cm_amssited set empGroupId="+groupid+" where rdocno='"+trno+"' and rowno='"+srno+"' ";
		}
		else
		{
			strSql = "update cm_servplan set empGroupId="+groupid+" where TR_NO="+srno+" and refdocno="+trno+" and dTYPE='"+dtype+"'  "+sql1+"";      
		} 
		System.out.println("strsql="+strSql);
		int rs = stmt.executeUpdate(strSql);
		
		
		if(rs>0){
			
			if(!(grpempid.equalsIgnoreCase("0")) && !(grpempid.equalsIgnoreCase(""))){
				
				for(int i=0;i<empdoc.length;i++) {
			 		String sqlassign="update  cm_srvassign set  empGroupId="+groupid+" where refdocno='"+trno+"'  and inactive=0 and dtype='"+dtype+"'and brhid="+branchid+"";
			 		stmt.executeUpdate(sqlassign);
			 		System.out.println("sqlassign="+sqlassign);
				}
			}
			
			String sqls="insert into gl_assigngrplog (doc_no, brhId, dtype, edate, userId, ENTRY,oldgrpid,newgrpid) values ('"+trno+"','"+branchid+"','CAG',now(),'"+userid+"','E','"+oldgrpid+"','"+groupid+"')";
	 		System.out.println("sqlassignLog====="+sqls);

			int datas= stmt.executeUpdate(sqls);
			if(datas<=0){
				 stmt.close();
				 conn.close();
			}
		}
		
		response.getWriter().write(rs+"###"+dtype);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  