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
 String memberdocno =request.getParameter("memberdocnos")==null?"":request.getParameter("memberdocnos").toString();  		 
 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();
 ClsCommon ClsCommon=new ClsCommon();
 int val1=0, val2=0, datas=0;
 try{
		conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);  
		Statement stmt = conn.createStatement ();
		Statement stmt2 = conn.createStatement ();
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
		
		strSql = "update cm_servplan set status=4,empGroupId="+groupid+", empId="+grpempid+", asgnMode="+assignid+" ,remarks='"+desc+"',date='"+sdate+"',plannedon='"+sdate+"',pltime='"+ptime+"' where TR_NO="+srno+" and refdocno="+trno+" and dTYPE='"+dtype+"' and status=3 "+sql1+"";      
		val1 = stmt.executeUpdate(strSql);
		
		if(val1>0){
			String empgrpid="0",empid="0";		
			String strsql="select s.doc_no, s.rdocno, s.empid from cm_serteamd s left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and s.doc_no in("+memberdocno+")";   
 			//System.out.println("===strsql===="+strsql);
			ResultSet rs1 = stmt2.executeQuery(strsql);   
			while(rs1.next()){
				 empgrpid = rs1.getString("rdocno");
				 empid = rs1.getString("empid");  
				 String sqlassign="insert into cm_srvassign (brhid,refDocNo, empGroupId, empId, asgnMode, plannedOn, plTime, description, ptrno) values ('"+branchid+"','"+trno+"',"+empgrpid+","+empid+","+assignid+",'"+sdate+"','"+ptime+"','"+desc+"', '"+srno+"')";
				 //System.out.println("--sqlassign--"+sqlassign);
				 val2 = stmt.executeUpdate(sqlassign);  
			}
		}
		if(val2>0 || val1>0){
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+branchid+"','SRCH',now(),'"+userid+"','E')";
			 datas= stmt.executeUpdate(sqls);
		}
		if(datas>0){
			conn.commit();
			stmt2.close();
			stmt.close();
		}
		response.getWriter().write(val1+"###"+dtype);  
	}catch(Exception e){
	 	e.printStackTrace();
	}finally{
		conn.close();
	}
  %>