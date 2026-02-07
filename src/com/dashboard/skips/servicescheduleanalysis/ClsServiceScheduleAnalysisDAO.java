package com.dashboard.skips.servicescheduleanalysis;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsServiceScheduleAnalysisDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	Connection conn;  
	 
	public JSONArray serScheduleLoad(HttpSession session, int id, String fromdate, String todate) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement(); 
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
			String sqltest="",sqlgrp="";
			if(!fromdate.equalsIgnoreCase("undefined") && !fromdate.equalsIgnoreCase("")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);  
			}
			if(!todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);         
			}
			String sql="select dv.sal_name driver,h1.sal_name helper,h1.sal_name helper2,concat(veh.reg_no,' - ',veh.flname) regno,ac.refname,case when sc.status=1 then 'Normal Schedule' when (sc.status=2 or sc.status=5) then 'Pull Out' when sc.status=4 then 'Dropped' else '' end as skipstatus,"
					+ "sk.name skipsize,d.skiptype skiptypeid,	dl.skipid,dl.doc_no delid,coalesce(sc.routeid,dl.routeid) routeid, coalesce(sc.driverid,dl.driverid) driverid, "
					+ "coalesce(sc.helperid,dl.helperid) helperid, coalesce(sc.helperid2,0) helperid2, coalesce(sc.fleetno,dl.fleetno) fleetno,dm.name wastetype,d.wastetype wastetypeid,"
					+ "cm.brhid,sc.doc_no,date_format(sc.date,'%d.%m.%Y') date,sc.time,days,s.name skipno,r.name route,cm.doc_no contrno,cm.tr_no,d.srno,d.site,"
					+ "ss.name status, sb.name substatus, sc.remarks "
					+ "from sk_srvcontrsch sc left join sk_srvcontrdel dl on dl.doc_no=sc.delid left join sk_skipm s on s.doc_no=dl.skipid "  
					+ "left join sk_route r on r.doc_no=dl.routeid left join sk_srvcontrm cm on cm.tr_no=sc.rdocno left join my_acbook ac on ac.cldocno = cm.cldocno and ac.dtype='crm' "
					+ "left join sk_srvcontrdet d on d.rdocno=sc.rdocno and d.srno=sc.srno left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_skiptype sk on sk.doc_no=d.skiptype "
					+ "left join sk_status ss on ss.doc_no = sc.statusid left join sk_substatus sb on sb.doc_no = sc.substatusid left join my_salesman dv on (dv.doc_no=sc.driverid or dv.doc_no=dl.driverid) and dv.sal_type='DRV' "
					+ "left join my_salesman h1 on (h1.doc_no=sc.helperid or h1.doc_no=dl.helperid) and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=sc.helperid2 and h2.sal_type='HLR' "
					+ "left join gl_vehmaster veh on (veh.fleet_no=sc.fleetno or veh.fleet_no=dl.fleetno) where cm.status<>7 "+sqltest+"";    
			//System.out.println("===sql===="+sql);                                          
			ResultSet resultSet1 = stmt.executeQuery(sql);  
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	public JSONArray groupwiseLoad(HttpSession session, int id, String fromdate, String todate, String grptype) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement(); 
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
			String sqltest="",sqlgrp="";
			if(!fromdate.equalsIgnoreCase("undefined") && !fromdate.equalsIgnoreCase("")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);  
			}
			if(!todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);         
			}
			String sql="";
			if(grptype.equalsIgnoreCase("Customer")){  
					sql="select count(*) count,ac.refname type from sk_srvcontrsch sc left join sk_srvcontrm cm on cm.tr_no=sc.rdocno "
						+ "left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='crm' where cm.status<>7 group by cm.cldocno";
			}else if(grptype.equalsIgnoreCase("Vehicle")) {
					sql="select count(*) count,dv.sal_name type from sk_srvcontrsch sc left join sk_srvcontrm cm on cm.tr_no=sc.rdocno "
						+ "left join sk_srvcontrdel dl on dl.doc_no=sc.delid left join my_salesman dv on (dv.doc_no=sc.driverid or dv.doc_no=dl.driverid) and dv.sal_type='DRV' where cm.status<>7 group by dv.doc_no";
			}else if(grptype.equalsIgnoreCase("Driver")) {    
					sql="select count(*) count,concat(veh.reg_no,' - ',veh.flname) type from sk_srvcontrsch sc left join sk_srvcontrm cm on cm.tr_no=sc.rdocno left join sk_srvcontrdel dl on dl.doc_no=sc.delid "
						+ "left join gl_vehmaster veh on (veh.fleet_no=sc.fleetno or veh.fleet_no=dl.fleetno) where cm.status<>7 group by veh.fleet_no";
			}else {}     
			//System.out.println("===sql===="+sql);                                            
			ResultSet resultSet1 = stmt.executeQuery(sql);  
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
}
