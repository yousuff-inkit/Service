package com.dashboard.inkit.changeassigngroup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.dashboard.projectexecution.serviceScheduler.ServiceSchedulerBean;
import com.project.execution.callRegister.ClsCallRegisterBean;

import net.sf.json.JSONArray;


public class ClsChangeAssignGroupDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray serCountgrid(HttpSession session,String date,String branchid,String clientid,int id, int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();
		if(date.equalsIgnoreCase("0")){
			return RESULTDATA;
		}
		Enumeration<String> Enumeration = session.getAttributeNames();
		
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}
		java.sql.Date fromdate=null;
		fromdate=com.changeStringtoSqlDate(fromdates);
		java.sql.Date todate=null;
		todate=com.changeStringtoSqlDate(date);

		//String brcid=branchid.toString();

		String sql1="",sql2="",sql3="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql1=sql1+" and x.cldocno in ("+clientid+")";
			sql2=sql2+" and m.cldocno in ("+clientid+")";
		}
		if(priority>0){
			sql1=sql1+" and p.priorno=1";
		}

		if(chkfromdate.equalsIgnoreCase("1")){
			if(!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))){
				sql1=sql1+" and p.date between '"+fromdate+"' and '"+todate+"' "; 
				
			}
		}else{
			if(!(date.equals("0") || date.equals("") || date.equals("undefined"))) {
				sql1=sql1+" and p.date<='"+todate+"' "; 

			}
		}
			
		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql1=sql1+" and x.brhid in ("+branchid+")";
			sql2=sql2+" and m.brhid in ("+branchid+")";
		}
		
		if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
			sql1=sql1+" and p.empgroupid in ("+grp+")";
			sql2=sql2+" and d.empgroupid in ("+grp+")";
		}
		
		if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
			sql1=sql1+" and p.empid in ("+emp+")";
			sql2=sql2+" and d.empid in ("+emp+")";
		}
		
		if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
			//sql1=sql1+" and d.areaid in ("+area+")";
			sql3=sql3+" and d.areaid in ("+area+")";
		}
		

		Connection conn =null;
		Statement stmt =null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			String sql12=" select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) "
					+ " where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			//System.out.println("sql12   "+sql12);
			ResultSet resultSet12=stmt.executeQuery(sql12);
			   String sqls1="",joins="";
		    if(resultSet12.next()){
		    	sql1=sql1+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
		    	sqls1=sqls1+" and (cm.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
                joins=joins+"left join cm_serteamd md on (md.rdocno=cm.doc_no and sa.empid=md.empid)";
		    } 

			if(id>0){
				String sql= ("select count(*) as count,p.dtype from cm_servplan p inner join (select tr_no,dtype,brhid,cldocno,m.date dates,validupto "
						+ "from  cm_srvcontrm m where m.dtype='sjob' and m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,cldocno,c.date dates,'' validupto FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) "
						+ ") as x on(x.tr_no=p.doc_no  and x.dtype=p.dtype) left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on "
						+ "(md.rdocno=m.doc_no and p.empid=md.empid) where p.status<5  union all "
						+ "select count(*),'STC' dtype from  cm_staffcontrm m left join cm_staffcontrd d on  m.doc_no=d.rdocno  left join gl_enqm e on e.doc_no=m.refno left join cm_srvassign sa on (sa.refdocno=m.doc_no and sa.dtype='STC' ) left join cm_serteamm cm on(d.empgroupid=cm.doc_no)    where e.typess=4 and '"+todate+"' between fromdt and todt and m.status=3  "+sql2+"  "
						+ "union all select count(*),'AMS' dtype from (select count(*),'AMS' dtype from  cm_amscontrm m  left join cm_amssited d on m.doc_no=d.rdocno  left join gl_enqm e on e.voc_no=m.refno and m.brhid=e.brhid left join cm_srvassign sa on (sa.refdocno=m.doc_no and sa.dtype='AMS') left join cm_serteamm cm on(d.empgroupid=cm.doc_no)  where e.typess=3 and '"+todate+"' between fromdt and todt and m.status=3 "+sql2+sql3+" group by m.doc_no)t ");

				System.out.println("===sqlassign===="+sql);

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=com.convertToJSON(resultSet);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}

	public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brid=session.getAttribute("BRANCHID").toString();






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray serSchedulegrid(HttpSession session,String date,String branchid,String clientid,String dtype) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brcid=branchid.toString();


		String sql11="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11="and m.cldocno in ("+clientid+")";
		}

		if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
			java.sql.Date todate=com.changeStringtoSqlDate(date);
			sql11="and m.date<='"+todate+"'"; 
		}

		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11="and m.brhid in ("+branchid+")";
		}



		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();


			String sql= ("select count(*) as count,dtype from  cm_srvcontrm m where and status=3 "+sql11+" group by dtype " );
			//			System.out.println("------branchid---"+branchid+"-----serCountgrid-------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}

	public JSONArray assignfrm(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select grpcode,doc_no  from cm_serteamm where status=3";

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray assignteam(HttpSession session,int assignid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
			//+ "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no="+assignid+"";

			String dbSql="select db1,db2 from my_comp;";
			ResultSet dbRs = stmt.executeQuery(dbSql);	
			
			String db1="";
			String db2="";
			while(dbRs.next()){
				db1=dbRs.getString("db1");
				db2=dbRs.getString("db2");
			}
			
			String sql="select name, doc_no empid, '"+db1+"' dbname from "+db1+".hr_empm where status=3 "
					+ "union all select name, doc_no empid, '"+db2+"' dbname from "+db2+".hr_empm where status=3;";
			
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}

	public JSONArray assignmode(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname assign,codeno,doc_no docno from my_groupvals where grptype='assignmode' and status=3";

			//			System.out.println("===getassign===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray serviceScheduleGridLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		if(date.equalsIgnoreCase("0")){
			return RESULTDATA1;
		}
		
		if(id!=1){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		try {
			java.sql.Date fromdate=null;
			fromdate=com.changeStringtoSqlDate(fromdates);
			java.sql.Date todate=null;
			todate=com.changeStringtoSqlDate(date);
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql1="",sql2="",sql3="";
			

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql1+=" and x.cldocno in ("+clientid+")";
				sql2+=" and m.cldocno in ("+clientid+")";
			}
			if(priority>0){
				sql1=sql1+" and p.priorno=1";
			}
			if(chkfromdate.equalsIgnoreCase("1")){
				if(!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))){
					
					sql1=sql1+" and p.date between '"+fromdate+"' and '"+todate+"' "; 
				}
			}else{
				
				if(!(date.equals("0") || date.equals("") || date.equals("undefined")))
				
				sql1=sql1+" and p.date<='"+todate+"' "; 
			}
			

			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql1=sql1+" and x.brhid in ("+branchid+")";
				sql2=sql2+" and m.brhid in ("+branchid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql1=sql1+" and x.dtype='"+dtype+"'";
			}
			if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
				sql1=sql1+" and p.empgroupid in ("+grp+")";
				sql2=sql2+" and d.empgroupid in ("+grp+")";
			}
			
			if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
				sql1=sql1+" and p.empid in ("+emp+")";
				sql2=sql2+" and d.empid in ("+emp+")";
			}
			
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql1=sql1+" and s.areaid in ("+area+")";
				sql3=sql3+" and d.areaid in ("+area+")";
			}
			
			String dbSql="select db1,db2 from my_comp;";
			ResultSet dbRs = stmt.executeQuery(dbSql);	
			String db1="";
			String db2="";
			while(dbRs.next()){
				db1=dbRs.getString("db1");
				db2=dbRs.getString("db2");
			}
			
			/*
			 * String
			 * sql12=" select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) "
			 * +
			 * " where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").
			 * toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").
			 * toString().trim()+"')"; //System.out.println("sql12   "+sql12); ResultSet
			 * resultSet12=stmt.executeQuery(sql12); String sqls1="",joins="";
			 * if(resultSet12.next()){
			 * sql1=sql1+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString
			 * ().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString
			 * ().trim()+"')";
			 * sqls1=sqls1+" and (cm.serteamuserlink='"+session.getAttribute("USERID").
			 * toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").
			 * toString().trim()+"')"; joins=
			 * joins+"left join cm_serteamd md on (md.rdocno=cm.doc_no and sa.empid=md.empid)"
			 * ;
			 * 
			 * }
			 */
			if(id>0){

				 if(dtype.equalsIgnoreCase("STC"))
				 {

					 sql="select null calld, null profomadate,null profomarecievedate, m.doc_no doctrno,'Staffing Contract' name,'com/it/staffingcontract/staffingcontract.jsp' path,"
					 		+ "'STC' dtype,'view' contr,m.doc_no refdocno,rowno tr_no,'' sr_no,'' site,'' groupname,ac.refname,'' sal_name,ac.doc_no docno2, ac.acno, '' claddress,"
					 		+ "m.date pldate, m.date pldte,0 priority,m.date apprdate,m.doc_no contracttrno,0 siteid,'' contractdetails,0 areaid, 0 sport, coalesce(grpcode,'') asgngrp, 0 teampid,"
					 		+ "d.empgroupid grpid,coalesce(coalesce(em.name,em2.name),'') as emp,d.empid,d.dbname,'' asgnmode,0 asignid,h.desc1 sertype,h.doc_no serdocno,null compl,m.brhid branch,'' description "
					 		+ "from  cm_staffcontrm m  left join cm_staffcontrd d on m.doc_no=d.rdocno left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
					 		+ "left join my_salm sm on sm.doc_no=ac.sal_id left join cm_srvassign sa on (sa.refdocno=m.doc_no and sa.dtype='STC' ) left join cm_serteamm cm on(d.empgroupid=cm.doc_no)  "
					 		+ "left join "+db1+".hr_empm em on d.empid=em.doc_no and d.dbname='"+db1+"' left join "+db2+".hr_empm em2 on d.empid=em2.doc_no and d.dbname='"+db2+"' "
					 		+ "left join hr_setdesig h on (h.doc_no=d.desigid) left join gl_enqm e on e.doc_no=m.refno "
					 		+ "where e.typess=4 and '"+todate+"' between fromdt and todt and m.status=3 "+sql2;
					 
				 } 
				 else if(dtype.equalsIgnoreCase("AMS"))
				 {
					 sql="select null calld, null profomadate,null profomarecievedate, m.doc_no doctrno,'AMS Contract' name,'com/it/amscontract/amsContract.jsp' path,"
						 		+ "'AMS' dtype,'view' contr,m.doc_no refdocno,rowno tr_no,coalesce(d.site,'')site,'' groupname,ac.refname,'' sal_name,ac.doc_no docno2, ac.acno, '' claddress,"
						 		+ "m.date pldate, m.date pldte,0 priority,m.date apprdate,m.doc_no contracttrno,0 siteid,'' contractdetails,0 areaid, 0 sport, coalesce(grpcode,'') asgngrp, 0 teampid,"
						 		+ "d.empgroupid grpid,group_concat(distinct coalesce(coalesce(em.name,em2.name),'')) as emp,d.empid,d.dbname,'' asgnmode,0 asignid,h.desc1 sertype,h.doc_no serdocno,null compl,m.brhid branch,'' description "
						 		+ "from  cm_amscontrm m  left join cm_amssited d on m.doc_no=d.rdocno left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
						 		+ "left join my_salm sm on sm.doc_no=ac.sal_id left join cm_srvassign sa on (sa.refdocno=m.doc_no and sa.dtype='AMS') left join cm_serteamm cm on(d.empgroupid=cm.doc_no)  "
						 		+ "left join "+db1+".hr_empm em on d.empid=em.doc_no and d.dbname='"+db1+"' left join "+db2+".hr_empm em2 on d.empid=em2.doc_no and d.dbname='"+db2+"' "
						 		+ "left join hr_setdesig h on (h.doc_no=d.desigid) left join gl_enqm e on e.voc_no=m.refno  and m.brhid=e.brhid "
						 		+ "where e.typess=3 and '"+todate+"' between fromdt and todt and m.status=3"+sql2+sql3+" group by m.doc_no";
				 } 
				 else 
				 {
					  sql="select cd.tr_no calld,x.profomadate,x.profomarecievedate,x.tr_no as doctrno,me.menu_name as name,me.func path,p.dtype,'view' contr,p.refdocno,p.tr_no,p.sr_no,s.site,a.groupname,ac.refname,coalesce(sm.sal_name,'')sal_name,ac.doc_no docno2,ac.acno,ac.address claddress,"
								+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) pldate,"
								+ "p.plannedon pldte,priorno priority,coalesce (DATE_FORMAT(apprdate,'%d-%m-%Y %H:%i:%d'),concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) ) apprdate,"
								+ "convert(x.contracttrno,char(50)) contracttrno,p.siteid,x.contractdetails,s.areaid,'Service Report' sport ,"
								+ "coalesce(grpcode,'') as asgngrp,0 teampid, m.doc_no grpid,coalesce(coalesce(em.name,em2.name),'') as emp,p.empid,p.dbname,"
								+ "coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,ser.doc_no as serdocno,gv.groupname compl,x.brhid branch,coalesce(p.remarks,'')  description  "
								+ "from (select sal_id,tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
								+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
								+ "m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m  left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
								+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
								+ "SELECT sal_id,tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate "
								+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
								+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
								+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join my_salm sm on sm.doc_no=x.sal_id "
								+ "left join cm_serteamm m on(p.empgroupid=m.doc_no)  left join cm_serteamd md on "
								+ "(md.rdocno=m.doc_no and p.empid=md.empid) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') "
								+ "left join "+db1+".hr_empm em on p.empid=em.doc_no and p.dbname='"+db1+"' left join "+db2+".hr_empm em2 on p.empid=em2.doc_no and p.dbname='"+db2+"' "
								+ "left join (select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
								+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
								+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
								+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status<5 "+sql1+" group by p.tr_no order by p.plannedon ";
								
				 }
				 
				System.out.println("gridload==========>"+sql);
				ResultSet resultSet1 = stmt.executeQuery(sql);
				
				/*while(resultSet1.next())
				{
					bean.setLblrefdocno(resultSet1.getString("refdocno"));
				}*/
				RESULTDATA1=com.convertToJSON(resultSet1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}

	public JSONArray serviceScheduleGridLoadExcel(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();
if(date.equalsIgnoreCase("0")){
	return RESULTDATA1;
}
		Connection conn=null;
		try {
			java.sql.Date fromdate=null;
			fromdate=com.changeStringtoSqlDate(fromdates);
			java.sql.Date todate=null;
			todate=com.changeStringtoSqlDate(date);
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="",esql="";
			
			String comp="";



			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and x.cldocno in ("+clientid+")";
			}
			//			System.out.println("===priority===="+priority);
			if(priority>0){
				//	System.out.println("inside");
				sql11=sql11+" and p.priorno=1";
			}

			if(chkfromdate.equalsIgnoreCase("1")){
				if(!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))){
					
					sql11=sql11+" and p.date between '"+fromdate+"' and '"+todate+"' "; 
				}
			}
			
			else
				{
				
		if(!(date.equals("0") || date.equals("") || date.equals("undefined")))
				
				sql11=sql11+" and p.date<='"+todate+"' "; 
			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and x.brhid in ("+branchid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and x.dtype='"+dtype+"'";
				if(dtype.equalsIgnoreCase("CREG"))
				{
					comp=comp+" ,gv.groupname complaint ";
				}
			}
			if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
				sql11=sql11+" and p.empgroupid in ("+grp+")";
			}
			
			if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
				sql11=sql11+" and p.empid in ("+emp+")";
			}
			
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql11=sql11+" and s.areaid in ("+area+")";
			}
			

			//System.out.println("==sql11===="+sql11);
			if(id>0){

				/*
				 * String
				 * sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"
				 * +session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"
				 * +session.getAttribute("USERID").toString().trim()+"')"; ResultSet
				 * resultSet12=stmt.executeQuery(sql12);
				 * 
				 * while(resultSet12.next()){
				 * sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").
				 * toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").
				 * toString().trim()+"')"; }
				 */
				sql="select p.dtype as DocType,p.refdocno ContractNo,p.tr_no ScheduleNo,p.sr_no SRNO,s.site,if(s.siteadd='0','',s.siteadd) 'site address',"
						+ "coalesce(cont.cperson,'') 'Contact Person',coalesce(cont.tel,cont.mob,'') 'Mobile Number',a.groupname Area,ac.refname Clientname,"
						+ "concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) planneddate,"
						+ "priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,coalesce (DATE_FORMAT(apprdate,'%d-%m-%Y %H:%i:%d'),concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) ) apprdate,"
						+ " x.Profomadate,x.profomarecievedate,x.contractdetails,if(x.dtype='CREG',gvd.groupname,ser.groupname) as 'Service Type', coalesce(grpcode,'') as 'ASSIGN GROUP',coalesce(em.name,'') as 'EMPLOYEE',coalesce(cd.description,'') 'Description' "+comp+" "
						+ " from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno, DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate,"
						+ "m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ " left join my_crmcontact cont on cont.row_no=s.contactid left join my_acbook ac onin+(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no"
						+ " left join my_menu me on(me.doc_type=p.dtype) where p.status<5 "+sql11+" group by p.tr_no order by p.plannedon ";

// System.out.println("==serviceScheduleGridLoadExcel==="+sql);
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=com.convertToEXCEL(resultSet1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return RESULTDATA1;
	}
	
	
	public JSONArray areaSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";


			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray loadSubGridData(String docno,String brhid,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			
			String dbSql="select db1,db2 from my_comp;";
			ResultSet dbRs = stmt.executeQuery(dbSql);	
			
			String db1="";
			String db2="";
			while(dbRs.next()){
				db1=dbRs.getString("db1");
				db2=dbRs.getString("db2");
			}
				
			String sqldata = "select @id:=@id+1 srno,a.* from (select sm.grpcode empgroup,coalesce(em.name,em2.name) emp,gp.groupname asgnMode,sa.plannedon,sa.pltime,sa.description from cm_srvassign sa "
					+ "left join cm_serteamm sm on sm.doc_no=sa.empGroupId "
					+ "left join "+db1+".hr_empm em on sa.empid=em.doc_no and sa.dbname='"+db1+"' left join "+db2+".hr_empm em2 on sa.empid=em2.doc_no and sa.dbname='"+db2+"' "
					+ "left join my_groupvals gp on gp.doc_no=sa.asgnmode and gp.grptype='assignmode' "
					+ "where sa.inactive=0 and sa.refdocno="+docno+" and sa.brhid="+brhid+" and sa.dtype='"+dtype+"' group by sa.tr_no order by sa.entrydate) a,(select @id:=0)r";
		
			System.out.println(sqldata);
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}

	

	
}
