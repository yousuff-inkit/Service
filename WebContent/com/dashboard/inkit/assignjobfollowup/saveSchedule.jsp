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
 String eedate =request.getParameter("eedate")==null?"":request.getParameter("eedate").toString();
 String chkupdateall =request.getParameter("chkupdateall")==null?"":request.getParameter("chkupdateall").toString();
 String etime =request.getParameter("etime")==null?"":request.getParameter("etime").toString();

Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		Statement stmt1 = conn.createStatement ();

		String datecount="";
		String strSql ="",strSql1="";
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
		if(!(eedate.equalsIgnoreCase("0") || eedate.equalsIgnoreCase("undefined") || eedate.equalsIgnoreCase("a") )){
			edate = ClsCommon.changeStringtoSqlDate(eedate);
		}
		String userid=session.getAttribute("USERID").toString();
		
		String[] empdoc=grpempid.split(",");
		
		String empid1=empdoc[0].split("::")[0];
		String empdb1=empdoc[0].split("::")[1];
		
		if(dtype.equalsIgnoreCase("STC"))
		{
			if (chkupdateall.equalsIgnoreCase("1"))
			strSql = "update cm_staffcontrd set empGroupId="+groupid+", empId="+empid1+", dbname='"+empdb1+"' where rdocno='"+trno+"' ";
			else
			strSql = "update cm_staffcontrd set empGroupId="+groupid+", empId="+empid1+", dbname='"+empdb1+"' where rdocno='"+trno+"' and rowno='"+srno+"'";
		}
		else if(dtype.equalsIgnoreCase("AMS"))
		{
			if (chkupdateall.equalsIgnoreCase("1"))
			strSql = "update cm_amssited set empGroupId="+groupid+", empId="+empid1+", dbname='"+empdb1+"' where rdocno='"+trno+"' ";
			else
			strSql = "update cm_amssited set empGroupId="+groupid+", empId="+empid1+", dbname='"+empdb1+"' where rdocno='"+trno+"' and rowno='"+srno+"'";
	
		}
		else
		{
			if (chkupdateall.equalsIgnoreCase("1"))
			strSql = "update cm_servplan set empGroupId="+groupid+", empId="+empid1+", dbname='"+empdb1+"', asgnMode="+assignid+" ,remarks='"+desc+"',plannedon='"+sdate+"',date='"+sdate+"',pltime='"+ptime+"',status=4 where  refdocno="+trno+" and dTYPE='"+dtype+"'  "+sql1+"";      
			else
			strSql = "update cm_servplan set empGroupId="+groupid+", empId="+empid1+", dbname='"+empdb1+"', asgnMode="+assignid+" ,remarks='"+desc+"',plannedon='"+sdate+"',date='"+sdate+"',pltime='"+ptime+"',status=4 where TR_NO="+srno+" and refdocno="+trno+" and dTYPE='"+dtype+"'  "+sql1+"";      

		} 
		//System.out.println("strsql=============="+strSql);
		int rs = stmt.executeUpdate(strSql);
		String empgroupid="",empid="",dbs="",trnos="";
		//System.out.println("values=============="+rs+"==chkupdateall=="+chkupdateall+"==dtype=="+dtype+"==");

		if(rs>0){
			
			if(chkupdateall.equalsIgnoreCase("1"))
			{
				if(dtype.equalsIgnoreCase("STC"))
				{
					strSql1 = "select empGroupId,empId,dbname,rowno trnos from cm_staffcontrd where rdocno='"+trno+"'  ";

				}
				else if(dtype.equalsIgnoreCase("AMS"))
				{
					strSql1 = "select empGroupId,empId,dbname,rowno trnos from cm_amssited where rdocno='"+trno+"'  ";

				}
				else 
				{
					strSql1 = "select empGroupId,empId,dbname,tr_no trnos from cm_servplan  where  refdocno="+trno+"   and dTYPE='"+dtype+"'  "+sql1+"";      

				}
				//System.out.println("strsqlselects=============="+strSql1);
String sqlassign="";
				ResultSet rs1 = stmt.executeQuery(strSql1);	
				while(rs1.next())
				{
					empgroupid=rs1.getString("empGroupId");
					empid=rs1.getString("empId");
					dbs=rs1.getString("dbname");
					trnos=rs1.getString("trnos");

					for(int i=0;i<empdoc.length;i++) {

					 		 sqlassign="insert into cm_srvassign (brhid,refDocNo, empGroupId, empId, dbname, asgnMode, plannedOn, plTime, description,dtype,ptrno,inactivedate,inactivetime) values "
					 				+"('"+brchid+"','"+trno+"',"+groupid+","+empdoc[i].split("::")[0]+",'"+empdoc[i].split("::")[1]+"',"+assignid+",'"+sdate+"','"+ptime+"','"+desc+"','"+dtype+"','"+trnos+"','"+edate+"','"+etime+"')";
					 		//System.out.println("sqlassignupdateall=="+sqlassign);
					 		stmt1.executeUpdate(sqlassign);
					}
				}
					
					String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+brchid+"','SRCH',now(),'"+userid+"','E')";
					int datass= stmt.executeUpdate(sqls);
			 		//System.out.println("sglbiblog=="+sqls);

					if(datass<=0)
					{
						 stmt.close();
						 conn.close();
					}
				
				
			}
			else if(chkupdateall.equalsIgnoreCase("0"))
			{
			if(!(grpempid.equalsIgnoreCase("0")) && !(grpempid.equalsIgnoreCase(""))){
				
				for(int i=0;i<empdoc.length;i++) {
			 		String sqlassign1="insert into cm_srvassign (brhid,refDocNo, empGroupId, empId, dbname, asgnMode, plannedOn, plTime, description,dtype,ptrno,inactivedate,inactivetime) values "
			 				+"('"+brchid+"','"+trno+"',"+groupid+","+empdoc[i].split("::")[0]+",'"+empdoc[i].split("::")[1]+"',"+assignid+",'"+sdate+"','"+ptime+"','"+desc+"','"+dtype+"','"+srno+"','"+edate+"','"+etime+"')";
			 		//System.out.println("sqlassign=="+sqlassign1);
			 		stmt.executeUpdate(sqlassign1);
				}
			}
			
			String sqls1="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+brchid+"','SRCH',now(),'"+userid+"','E')";
			int datas= stmt.executeUpdate(sqls1);
			if(datas<=0){
				 stmt.close();
				 conn.close();
			}
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
  