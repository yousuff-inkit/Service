package com.dashboard.inkit.removeassignment;

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

public class RemoveAssignmentDAO {

	ClsConnection conobj = new ClsConnection();
	ClsCommon com = new ClsCommon();

	public JSONArray searchClient(HttpSession session, String clname, String mob) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a = 0;
		while (Enumeration.hasMoreElements()) {
			if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
				a = 1;
			}
		}
		if (a == 0) {
			return RESULTDATA;
		}

		String brid = session.getAttribute("BRANCHID").toString();

		String sqltest = "";

		if (!(clname.equalsIgnoreCase(""))) {
			sqltest = sqltest + " and refname like '%" + clname + "%'";
		}
		if (!(mob.equalsIgnoreCase(""))) {
			sqltest = sqltest + " and per_mob like '%" + mob + "%'";
		}

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement();

			String clsql = ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  "
					+ sqltest);
			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA = com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray areaSearch(HttpSession session) throws SQLException {

		JSONArray RESULTDATA1 = new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1 = com.convertToJSON(resultSet1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}

		return RESULTDATA1;
	}

	public JSONArray serCountgrid(HttpSession session, String chkfromdate, String fromdates, String date,
			String branchid, String clientid, String area, int id) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		if (date.equalsIgnoreCase("0")) {
			return RESULTDATA;
		}
		Enumeration<String> Enumeration = session.getAttributeNames();

		int a = 0;
		while (Enumeration.hasMoreElements()) {
			if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
				a = 1;
			}
		}
		if (a == 0 || id != 1) {
			return RESULTDATA;
		}
		java.sql.Date fromdate = null;
		fromdate = com.changeStringtoSqlDate(fromdates);
		java.sql.Date todate = null;
		todate = com.changeStringtoSqlDate(date);

		String sql1 = "", sql2 = "";

		Connection conn = null;
		Statement stmt = null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement();

			if (chkfromdate.equalsIgnoreCase("1")) {
				if (!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))) {
					sql1 += " and sa.plannedon between '" + fromdate + "' and '" + todate + "' ";
				}
			} else {
				if (!(date.equals("0") || date.equals("") || date.equals("undefined")))
					sql1 += " and sa.plannedon<='" + todate + "' ";
			}

			if (!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")
					|| branchid.equals("a"))) {
				sql1 += " and m.brhid in (" + branchid + ")";
			}

			if (!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))) {
				sql1 += " and m.cldocno in (" + clientid + ")";
			}

			if (!(area.equals("0") || area.equals("") || area.equals("undefined"))) {
				sql2 += " and d.areaid in (" + area + ")";
			}

			String sql12=" select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) "
					+ " where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			//System.out.println("sql12   "+sql12);
			ResultSet resultSet12=stmt.executeQuery(sql12);
			   String sqls1="",joins="";
		    if(resultSet12.next()){
		    	//sql1=sql1+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
		    	sqls1=sqls1+" and (cm.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
                joins=joins+"left join cm_serteamm cm on(sa.empgroupid=cm.doc_no)  left join cm_serteamd md on (md.rdocno=cm.doc_no and sa.empid=md.empid) ";

		    } 
			
			
			String sql = "select count(*)count,dtype from (select 'STC' dtype from cm_srvassign sa "
					+ "inner join cm_staffcontrm m on m.doc_no=sa.refdocno left join cm_staffcontrd d on m.doc_no=d.rdocno "+joins+" "
					+ "where m.status=3 and sa.dtype='STC' and sa.inactive=0 " + sql1 +sqls1+ " group by sa.tr_no "
					+ "union all select 'AMS' dtype from cm_srvassign sa "
					+ "inner join cm_amscontrm m on m.doc_no=sa.refdocno left join cm_amssited d on m.doc_no=d.rdocno "+joins+""
					+ "where m.status=3 and sa.dtype='AMS' and sa.inactive=0 " + sql1 + sql2 +sqls1+ " group by sa.tr_no "
					+ "union all select 'SJOB' dtype from cm_srvassign sa "
					+ "inner join cm_srvcontrm m on m.doc_no=sa.refdocno and m.dtype=sa.dtype "
					+ "inner join cm_servplan p on m.tr_no=p.doc_no and m.dtype=p.dtype left join cm_srvcsited d on p.siteid=d.rowno "+joins+" "
					+ "where m.status=3 and sa.dtype='SJOB' and sa.inactive=0 " + sql1 + sql2 +sqls1+ " group by sa.tr_no)a group by dtype";
			System.out.println("remove count==========>"+sql);

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = com.convertToJSON(resultSet);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
		return RESULTDATA;

	}

	public JSONArray serviceScheduleGridLoad(HttpSession session, String chkfromdate, String fromdates, String date,
			String branchid, String clientid, String area, String dtype, int id) throws SQLException {

		JSONArray RESULTDATA1 = new JSONArray();
		if (date.equalsIgnoreCase("0")) {
			return RESULTDATA1;
		}

		if (id != 1) {
			return RESULTDATA1;
		}

		Connection conn = null;
		try {
			java.sql.Date fromdate = null;
			fromdate = com.changeStringtoSqlDate(fromdates);
			java.sql.Date todate = null;
			todate = com.changeStringtoSqlDate(date);
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "", sql1 = "", sql2 = "";

			if (chkfromdate.equalsIgnoreCase("1")) {
				if (!(fromdates.equals("0") || fromdates.equals("") || fromdates.equals("undefined"))) {
					sql1 += " and sa.plannedon between '" + fromdate + "' and '" + todate + "' ";
				}
			} else {
				if (!(date.equals("0") || date.equals("") || date.equals("undefined")))
					sql1 += " and sa.plannedon<='" + todate + "' ";
			}

			if (!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")
					|| branchid.equals("a"))) {
				sql1 += " and m.brhid in (" + branchid + ")";
			}

			if (!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))) {
				sql1 += " and m.cldocno in (" + clientid + ")";
			}

			if (!(area.equals("0") || area.equals("") || area.equals("undefined"))) {
				sql2 += " and d.areaid in (" + area + ")";
			}

			String dbSql = "select db1,db2 from my_comp;";
			ResultSet dbRs = stmt.executeQuery(dbSql);
			String db1 = "";
			String db2 = "";
			while (dbRs.next()) {
				db1 = dbRs.getString("db1");
				db2 = dbRs.getString("db2");
			}
			String sql12=" select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) "
					+ " where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			//System.out.println("sql12   "+sql12);
			ResultSet resultSet12=stmt.executeQuery(sql12);
			   String sqls1="",joins="";
		    if(resultSet12.next()){
		    	//sql1=sql1+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
		    	sqls1=sqls1+" and (tm.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
                joins=joins+"left join cm_serteamd md on (md.rdocno=tm.doc_no and sa.empid=md.empid)";

		    } 
			if (dtype.equalsIgnoreCase("STC")) {

				sql = "select sa.dtype,sa.refdocno,''site,tm.grpcode empgroup,coalesce(em.name,em2.name) emp,gp.groupname asgnMode, "
						+ "ac.refname,''sal_name,sa.plannedon,sa.pltime,sa.description,sa.empid,sa.dbname,m.brhid  "
						+ "from cm_srvassign sa inner join cm_staffcontrm m on m.doc_no=sa.refdocno "
						+ "left join cm_staffcontrd d on m.doc_no=d.rdocno "
						+ "left join my_groupvals gp on gp.doc_no=sa.asgnmode and gp.grptype='assignmode'  "
						+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
						+ "left join cm_serteamm tm on tm.doc_no=sa.empGroupId "+joins+" " + "left join " + db1
						+ ".hr_empm em on sa.empid=em.doc_no and sa.dbname='" + db1 + "' " + "left join " + db2
						+ ".hr_empm em2 on sa.empid=em2.doc_no and sa.dbname='" + db2 + "' "
						+ "where m.status=3 and sa.dtype='" + dtype + "' and sa.inactive=0 " + sql1+sqls1
						+ " group by sa.tr_no order by sa.refdocno";

			} else if (dtype.equalsIgnoreCase("AMS")) {

				sql = "select sa.dtype,sa.refdocno,coalesce(d.site,'')site,tm.grpcode empgroup,coalesce(em.name,em2.name) emp,gp.groupname asgnMode, "
						+ "ac.refname,''sal_name,sa.plannedon,sa.pltime,sa.description,sa.empid,sa.dbname,m.brhid  "
						+ "from cm_srvassign sa inner join cm_amscontrm m on m.doc_no=sa.refdocno "
						+ "left join cm_amssited d on m.doc_no=d.rdocno "
						+ "left join my_groupvals gp on gp.doc_no=sa.asgnmode and gp.grptype='assignmode'  "
						+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
						+ "left join cm_serteamm tm on tm.doc_no=sa.empGroupId "+joins+" " + "left join " + db1
						+ ".hr_empm em on sa.empid=em.doc_no and sa.dbname='" + db1 + "' " + "left join " + db2
						+ ".hr_empm em2 on sa.empid=em2.doc_no and sa.dbname='" + db2 + "' "
						+ "where m.status=3 and sa.dtype='" + dtype + "' and sa.inactive=0 " + sql1 + sql2+sqls1
						+ " group by sa.tr_no order by sa.refdocno";

			} else {

				sql = "select sa.dtype,sa.refdocno,d.site,tm.grpcode empgroup,coalesce(em.name,em2.name) emp,gp.groupname asgnMode, "
						+ "ac.refname,coalesce(sm.sal_name,'')sal_name,sa.plannedon,sa.pltime,sa.description,sa.empid,sa.dbname,m.brhid  "
						+ "from cm_srvassign sa "
						+ "inner join cm_srvcontrm m on m.doc_no=sa.refdocno and m.dtype=sa.dtype "
						+ "inner join cm_servplan p on m.tr_no=p.doc_no and m.dtype=p.dtype "
						+ "left join cm_srvcsited d on p.siteid=d.rowno  "
						+ "left join my_groupvals gp on gp.doc_no=sa.asgnmode and gp.grptype='assignmode'  "
						+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
						+ "left join my_salm sm on sm.doc_no=m.sal_id "
						+ "left join cm_serteamm tm on tm.doc_no=sa.empGroupId "+joins+" " + "left join " + db1
						+ ".hr_empm em on sa.empid=em.doc_no and sa.dbname='" + db1 + "' " + "left join " + db2
						+ ".hr_empm em2 on sa.empid=em2.doc_no and sa.dbname='" + db2 + "' "
						+ "where m.status=3 and sa.dtype='" + dtype + "' and sa.inactive=0 " + sql1 + sql2+sqls1
						+ " group by sa.tr_no order by sa.refdocno";

			}
			//System.out.println("gridload==========>"+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1 = com.convertToJSON(resultSet1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}

		return RESULTDATA1;
	}

}
