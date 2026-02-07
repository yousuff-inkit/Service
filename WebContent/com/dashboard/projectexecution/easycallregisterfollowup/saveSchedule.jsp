<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sms.SmsAction"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>


<% 
 String groupid =request.getParameter("groupid")==null?"0":request.getParameter("groupid").toString();
 String grpmemberid =request.getParameter("grpmemberid")==null?"0":request.getParameter("grpmemberid").toString();
 String statusid =request.getParameter("statusid")==null || request.getParameter("statusid").trim().equalsIgnoreCase("")?"0":request.getParameter("statusid").toString();
 String trno =request.getParameter("trno")==null?"0":request.getParameter("trno").toString();
 String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
 String desc =request.getParameter("desc")==null?"":request.getParameter("desc").toString();
 String brchid =request.getParameter("brchid")==null?"":request.getParameter("brchid").toString();
 String oldstatus =request.getParameter("oldstatus")==null?"":request.getParameter("oldstatus").toString();
 String hidcldocno =request.getParameter("hidcldocno")==null?"":request.getParameter("hidcldocno").toString();
 String cregno =request.getParameter("cregno")==null?"":request.getParameter("cregno").toString();

Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	try{
		
        conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement ();
		
		String userid=session.getAttribute("USERID").toString();
		String branchid=session.getAttribute("BRANCHID").toString();
		String datecount="";
		String strSql ="";
		
	    strSql = "update cm_cuscallm set empgroupid='"+groupid+"', empid='"+grpmemberid+"', statusid='"+statusid+"' where TR_NO='"+trno+"' ";
	   // System.out.println("strSql==="+strSql);
	    String strSql1="update cm_cuscallm set clstatus=3 where doc_no='"+trno+"'";
	    int rs1 = stmt.executeUpdate(strSql1);
			 
		int rs = stmt.executeUpdate(strSql);
		
		if(rs>0){
			if(!statusid.equalsIgnoreCase(oldstatus)){
			 String sqlup="update cm_srvassign set closetime=now() where refdocno="+trno+" and statusid="+oldstatus;
			// System.out.println("sqlup==="+sqlup);
			 stmt.executeUpdate(sqlup);
			}
			
			 String sqlassign="insert into cm_srvassign (brhid,refDocNo, empGroupId, empId, statusId, description,entrydate) values ('"+branchid+"','"+trno+"','"+groupid+"','"+grpmemberid+"','"+statusid+"','"+desc+"',now())";
			 //System.out.println("sqlassign==="+sqlassign);
			 stmt.executeUpdate(sqlassign);
			

			  String strSqls = "select method from gl_config where field_nme='smsstatus'";
							ResultSet rs3 = stmt.executeQuery(strSqls);
							//System.out.println("CONFIG VAL-----"+strSqls);
							int method=0;
							while(rs3.next()) {
								method=rs3.getInt("method");
							} 
							
							if(method==1){
								 int sms=0;
								 String sql1="SELECT typeid,max(srno) maxstatus FROM cm_cuscallstatus c group by typeid";
								 ResultSet rs11=stmt.executeQuery(sql1);
								 while(rs11.next()){
									 if(rs11.getString("maxstatus").equalsIgnoreCase(statusid)){
										 sms=1;
									 }
								 }
								 
								 if(sms==1){
								    String per_mob="",refname="";
									String strsql="select b.per_mob,b.refname from my_acbook b left join cm_cuscallm c on b.cldocno=c.cldocno where dtype='CRM' and b.cldocno='"+hidcldocno+"' and c.tr_no='"+trno+"'";
									ResultSet rs12=stmt.executeQuery(strsql);
									while(rs12.next()){
										per_mob = rs12.getString("per_mob");
										refname = rs12.getString("refname");  
									}
									
									
									String msgtxt="";String msgval="";
									String msgsql="select msg from my_msgsettings where dtype='BCR' ";
									ResultSet rs123=stmt.executeQuery(msgsql);
									while(rs123.next()){
										msgtxt=rs123.getString("msg").replaceAll("documentno", cregno);
										
									}
									ResultSet rs1234=stmt.executeQuery(msgtxt);
									while(rs1234.next()){
										msgval=rs1234.getString("msg");
										
									}
									
								    SmsAction smsAc=new SmsAction();   
									smsAc.doSendSmsBasicAuto(per_mob, refname,msgval, trno, "BCR", branchid, conn,"1",userid);
						
								 }
	        	  	}

			 
		
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+branchid+"','BCR',now(),'"+userid+"','E')";
			 int datas= stmt.executeUpdate(sqls);
			 if(datas<=0){
				 stmt.close();
				 conn.close();
			 }
			 else{
				 conn.commit();
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
  