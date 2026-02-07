package com.dashboard.skips.serviceschedule;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsServiceScheduleDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	Connection conn;  
	 
	public JSONArray serScheduleLoad(HttpSession session, int id, String fromdate, String todate, String routeid, String cldocno, String frmdtchk, String widgetname) throws SQLException{
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
			String sqltest="", sqltest2="";
			if(!fromdate.equalsIgnoreCase("undefined") && !fromdate.equalsIgnoreCase("")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);  
			}
			if(!todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);         
			}
			if(!widgetname.equalsIgnoreCase("delp") && !widgetname.equalsIgnoreCase("delc")){
				if(!routeid.equalsIgnoreCase("undefined") && !routeid.equalsIgnoreCase("") && !routeid.equalsIgnoreCase("0")) {  
					sqltest+=" and sc.routeid='"+routeid+"' ";                    
				}
			}else {
				if(!routeid.equalsIgnoreCase("undefined") && !routeid.equalsIgnoreCase("") && !routeid.equalsIgnoreCase("0")) {  
					sqltest+=" and dl.routeid='"+routeid+"'";                    
				}
			}
			if(!widgetname.equalsIgnoreCase("delp") && !widgetname.equalsIgnoreCase("delc")){ 
				if(frmdtchk.equalsIgnoreCase("1")) {  
					sqltest+=" and sc.date between '"+sqlfromdate+"' and '"+sqltodate+"'";             
				}else {
					sqltest+=" and sc.date<='"+sqltodate+"'";            
				} 
			}
			
			if(!cldocno.equalsIgnoreCase("undefined") && !cldocno.equalsIgnoreCase("") && !cldocno.equalsIgnoreCase("0")) {  
				sqltest+=" and cm.cldocno='"+cldocno+"'";                        
			}
			
			if(widgetname.equalsIgnoreCase("delp")){ 
		        	sqltest+=" and sc.doc_no is null and dl.statusid<2 ";      
			}else if(widgetname.equalsIgnoreCase("pop")){ 
		        	sqltest+=" and sc.status=2 and sc.statusid=0 ";      
			}else if(widgetname.equalsIgnoreCase("comschp")){
					sqltest+=" and sk.exchange=0 and sc.status not in(2,4) and sc.statusid=0 ";  
			}else if(widgetname.equalsIgnoreCase("ldschp")){
					sqltest+=" and sk.exchange=1 and sc.status not in(2,4) and sc.statusid=0 ";
			}else if(widgetname.equalsIgnoreCase("totp")){  
				    sqltest2+=" and sc.doc_no is null and dl.statusid<2 "; 
					sqltest+=" and ((sk.exchange in(0,1) and sc.status not in(2,4)) or sc.status in(2)) and sc.statusid=0 ";       
			}else{} 
			
			if(widgetname.equalsIgnoreCase("delc")){ 
	        		sqltest+=" and sc.doc_no is null and dl.statusid>=2 ";      
			}else if(widgetname.equalsIgnoreCase("poc")){ 
		        	sqltest+=" and sc.status=2 and sc.statusid!=0 ";      
			}else if(widgetname.equalsIgnoreCase("comschc")){
					sqltest+=" and sk.exchange=0 and sc.status not in(2,4) and sc.statusid!=0 ";  
			}else if(widgetname.equalsIgnoreCase("ldschc")){
					sqltest+=" and sk.exchange=1 and sc.status not in(2,4) and sc.statusid!=0 ";
			}else if(widgetname.equalsIgnoreCase("totc")){ 
					sqltest2+=" and sc.doc_no is null and dl.statusid>=2 ";    
					sqltest+=" and ((sk.exchange in(0,1) and sc.status not in(2,4)) or sc.status in(2)) and sc.statusid!=0 ";       
			}else{}  
			
			String sql="";
			if(widgetname.equalsIgnoreCase("delp") || widgetname.equalsIgnoreCase("delc")){  
				sql="select 1 skipscollected, coalesce(ds.name,'') disposalsite, coalesce(s.name,'') deliveredskipno, coalesce(sm2.name,'') pulloutskipno, TIME_FORMAT(sf.dtime, '%H:%i') intime, date_format(sf.signdatetime,'%H:%i') outtime, t.dno, t.weight, t.rate tippingfee, dv.sal_name driver,h1.sal_name helper,h1.sal_name helper2,concat(veh.reg_no,' - ',veh.flname) regno,ac.refname, 'Delivery' skipstatus,"
						+ "sk.name skipsize,d.skiptype skiptypeid,	dl.skipid,dl.doc_no delid,coalesce(sc.routeid,dl.routeid) routeid, coalesce(sc.driverid,dl.driverid) driverid, "
						+ "coalesce(sc.helperid,dl.helperid) helperid, coalesce(sc.helperid2,0) helperid2, coalesce(sc.fleetno,dl.fleetno) fleetno,dm.name wastetype,d.wastetype wastetypeid,"
						+ "cm.brhid,sc.doc_no,date_format(sc.date,'%d.%m.%Y') date,sc.time,days,s.name skipno,r.name route,cm.doc_no contrno,cm.tr_no,d.srno,d.site,"
						+ "ss.name status, sb.name substatus, sc.remarks "
						+ "from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno left join sk_skipm s on s.doc_no=dl.skipid "  
						+ "left join sk_route r on r.doc_no=dl.routeid left join my_acbook ac on ac.cldocno = cm.cldocno and ac.dtype='crm' "
						+ "left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_skiptype sk on sk.doc_no=d.skiptype "
						+ "left join sk_status ss on ss.doc_no = sc.statusid left join sk_substatus sb on sb.doc_no = sc.substatusid left join my_salesman dv on dv.doc_no=dl.driverid and dv.sal_type='DRV' "
						+ " left join my_salesman h1 on  h1.doc_no=dl.helperid and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=sc.helperid2 and h2.sal_type='HLR' "
						+ "left join gl_vehmaster veh on (veh.fleet_no=dl.fleetno) left join sk_tippingdet t on sc.rdocno=t.contno and t.ddate=sc.date left join sk_serviceinfo sf on sf.schno=sc.doc_no left join (select cnttrno, delid, max(doc_no) repdocno from sk_srvcontrrep group by delid, cnttrno)rp on rp.delid=dl.doc_no and rp.cnttrno=cm.tr_no left join sk_srvcontrrep rep on rep.doc_no=rp.repdocno left join sk_skipm sm2 on sm2.doc_no=rep.oldskipno	left join (select dumpsiteid, tripstartdocno from sk_dumping group by tripstartdocno) dm on dm.tripstartdocno=sf.tripstartdocno left join sk_dumpsite ds on ds.doc_no=dm.dumpsiteid where cm.status=3 "+sqltest+"";
			}else if(widgetname.equalsIgnoreCase("totp") || widgetname.equalsIgnoreCase("totc")){ 
				 sql="select 1 skipscollected, coalesce(ds.name,'') disposalsite, coalesce(s.name,'') deliveredskipno, coalesce(sm2.name,'') pulloutskipno, TIME_FORMAT(sf.dtime, '%H:%i') intime, date_format(sf.signdatetime,'%H:%i') outtime, t.dno, t.weight, t.rate tippingfee, dv.sal_name driver,h1.sal_name helper,h1.sal_name helper2,concat(veh.reg_no,' - ',veh.flname) regno,ac.refname, 'Delivery' skipstatus,"
							+ "sk.name skipsize,d.skiptype skiptypeid,	dl.skipid,dl.doc_no delid,coalesce(sc.routeid,dl.routeid) routeid, coalesce(sc.driverid,dl.driverid) driverid, "
							+ "coalesce(sc.helperid,dl.helperid) helperid, coalesce(sc.helperid2,0) helperid2, coalesce(sc.fleetno,dl.fleetno) fleetno,dm.name wastetype,d.wastetype wastetypeid,"
							+ "cm.brhid,sc.doc_no,date_format(sc.date,'%d.%m.%Y') date,sc.time,days,s.name skipno,r.name route,cm.doc_no contrno,cm.tr_no,d.srno,d.site,"
							+ "ss.name status, sb.name substatus, sc.remarks "
							+ "from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno left join sk_skipm s on s.doc_no=dl.skipid "  
							+ "left join sk_route r on r.doc_no=dl.routeid left join my_acbook ac on ac.cldocno = cm.cldocno and ac.dtype='crm' "
							+ "left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_skiptype sk on sk.doc_no=d.skiptype "
							+ "left join sk_status ss on ss.doc_no = sc.statusid left join sk_substatus sb on sb.doc_no = sc.substatusid left join my_salesman dv on dv.doc_no=dl.driverid and dv.sal_type='DRV' "
							+ " left join my_salesman h1 on  h1.doc_no=dl.helperid and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=sc.helperid2 and h2.sal_type='HLR' "
							+ "left join gl_vehmaster veh on (veh.fleet_no=dl.fleetno) left join sk_tippingdet t on sc.rdocno=t.contno and t.ddate=sc.date left join sk_serviceinfo sf on sf.schno=sc.doc_no left join (select cnttrno, delid, max(doc_no) repdocno from sk_srvcontrrep group by delid, cnttrno)rp on rp.delid=dl.doc_no and rp.cnttrno=cm.tr_no left join sk_srvcontrrep rep on rep.doc_no=rp.repdocno left join sk_skipm sm2 on sm2.doc_no=rep.oldskipno left join (select dumpsiteid, tripstartdocno from sk_dumping group by tripstartdocno) dm on dm.tripstartdocno=sf.tripstartdocno left join sk_dumpsite ds on ds.doc_no=dm.dumpsiteid where cm.status=3 "+sqltest2+" union all "
							+ "select 1 skipscollected, coalesce(ds.name,'') disposalsite, coalesce(s.name,'') deliveredskipno, coalesce(sm2.name,'') pulloutskipno, TIME_FORMAT(sf.dtime, '%H:%i') intime, date_format(sf.signdatetime,'%H:%i') outtime, t.dno, t.weight, t.rate tippingfee, dv.sal_name driver,h1.sal_name helper,h1.sal_name helper2,concat(veh.reg_no,' - ',veh.flname) regno,ac.refname,case when sc.status=1 then 'Normal Schedule' when (sc.status=2 or sc.status=5) then 'Pull Out' when sc.status=4 then 'Dropped' else '' end as skipstatus,"
							+ "sk.name skipsize,d.skiptype skiptypeid,	dl.skipid,dl.doc_no delid,coalesce(sc.routeid,dl.routeid) routeid, coalesce(sc.driverid,dl.driverid) driverid, "
							+ "coalesce(sc.helperid,dl.helperid) helperid, coalesce(sc.helperid2,0) helperid2, coalesce(sc.fleetno,dl.fleetno) fleetno,dm.name wastetype,d.wastetype wastetypeid,"
							+ "cm.brhid,sc.doc_no,date_format(sc.date,'%d.%m.%Y') date,sc.time,days,s.name skipno,r.name route,cm.doc_no contrno,cm.tr_no,d.srno,d.site,"
							+ "ss.name status, sb.name substatus, sc.remarks "
							+ "from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno left join sk_skipm s on s.doc_no=dl.skipid "  
							+ "left join sk_route r on r.doc_no=sc.routeid left join my_acbook ac on ac.cldocno = cm.cldocno and ac.dtype='crm' "
							+ " left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_skiptype sk on sk.doc_no=d.skiptype "
							+ "left join sk_status ss on ss.doc_no = sc.statusid left join sk_substatus sb on sb.doc_no = sc.substatusid left join my_salesman dv on dv.doc_no=sc.driverid and dv.sal_type='DRV' "
							+ " left join my_salesman h1 on  h1.doc_no=sc.helperid and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=sc.helperid2 and h2.sal_type='HLR' "
							+ "left join gl_vehmaster veh on (veh.fleet_no=sc.fleetno) left join sk_tippingdet t on sc.rdocno=t.contno and t.ddate=sc.date left join sk_serviceinfo sf on sf.schno=sc.doc_no left join (select cnttrno, delid, max(doc_no) repdocno from sk_srvcontrrep group by delid, cnttrno)rp on rp.delid=dl.doc_no and rp.cnttrno=cm.tr_no left join sk_srvcontrrep rep on rep.doc_no=rp.repdocno left join sk_skipm sm2 on sm2.doc_no=rep.oldskipno left join (select dumpsiteid, tripstartdocno from sk_dumping group by tripstartdocno) dm on dm.tripstartdocno=sf.tripstartdocno left join sk_dumpsite ds on ds.doc_no=dm.dumpsiteid where cm.status=3 "+sqltest+"";
			}else {
				 sql="select 1 skipscollected, coalesce(ds.name,'') disposalsite, coalesce(s.name,'') deliveredskipno, coalesce(sm2.name,'') pulloutskipno, TIME_FORMAT(sf.dtime, '%H:%i') intime, date_format(sf.signdatetime,'%H:%i') outtime, t.dno, t.weight, t.rate tippingfee,dv.sal_name driver,h1.sal_name helper,h1.sal_name helper2,concat(veh.reg_no,' - ',veh.flname) regno,ac.refname,case when sc.status=1 then 'Normal Schedule' when (sc.status=2 or sc.status=5) then 'Pull Out' when sc.status=4 then 'Dropped' else '' end as skipstatus,"
							+ "sk.name skipsize,d.skiptype skiptypeid,	dl.skipid,dl.doc_no delid,coalesce(sc.routeid,dl.routeid) routeid, coalesce(sc.driverid,dl.driverid) driverid, "
							+ "coalesce(sc.helperid,dl.helperid) helperid, coalesce(sc.helperid2,0) helperid2, coalesce(sc.fleetno,dl.fleetno) fleetno,dm.name wastetype,d.wastetype wastetypeid,"
							+ "cm.brhid,sc.doc_no,date_format(sc.date,'%d.%m.%Y') date,sc.time,days,s.name skipno,r.name route,cm.doc_no contrno,cm.tr_no,d.srno,d.site,"
							+ "ss.name status, sb.name substatus, sc.remarks "
							+ "from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno "
							+ "left join sk_skipm s on s.doc_no=dl.skipid "  
							+ "left join sk_route r on r.doc_no=sc.routeid left join my_acbook ac on ac.cldocno = cm.cldocno and ac.dtype='crm' "
							+ " left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_skiptype sk on sk.doc_no=d.skiptype "
							+ "left join sk_status ss on ss.doc_no = sc.statusid left join sk_substatus sb on sb.doc_no = sc.substatusid left join my_salesman dv on dv.doc_no=sc.driverid and dv.sal_type='DRV' "
							+ " left join my_salesman h1 on  h1.doc_no=sc.helperid and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=sc.helperid2 and h2.sal_type='HLR' "
							+ "left join gl_vehmaster veh on (veh.fleet_no=sc.fleetno) left join sk_tippingdet t on sc.rdocno=t.contno and t.ddate=sc.date left join sk_serviceinfo sf on sf.schno=sc.doc_no "
							+ "left join (select cnttrno, delid, max(doc_no) repdocno from sk_srvcontrrep group by delid, cnttrno)rp on rp.delid=dl.doc_no and rp.cnttrno=cm.tr_no left join sk_srvcontrrep rep on rep.doc_no=rp.repdocno "
							+ "left join sk_skipm sm2 on sm2.doc_no=rep.oldskipno	left join (select dumpsiteid, tripstartdocno from sk_dumping group by tripstartdocno) dm on dm.tripstartdocno=sf.tripstartdocno "
							+ "left join sk_dumpsite ds on ds.doc_no=dm.dumpsiteid where cm.status=3 "+sqltest+"";
			}   
			//System.out.println("===Schedule Grid===>"+sql);                                          //and sc.status!=2---pullout requested not listing , so commented this 
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
	public JSONArray skipsizeSearch(int id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select name, doc_no from sk_skiptype where status=3";    
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONArray wastetypeSearch(int id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select name, doc_no from sk_dumptype where status=3";  
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONArray routeSearch(HttpSession session) throws SQLException{   
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;  
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String  sql="select r.fleetno,r.driverid,r.helper helperid,r.helper2 helperid2,sm.sal_name driver,h1.sal_name helper1,h2.sal_name helper2,"
					+ "v.reg_no,r.code,r.name,g.gname ,s.name site,dt.name wastetype,r.doc_no from sk_route r left join gl_vehgroup g on r.grpid=g.doc_no "
					+ "left join sk_dumpsite s on s.doc_no=r.dumpsiteid left join sk_dumptype dt on dt.doc_no=s.typeid left join my_salesman sm on sm.doc_no=r.driverid and sm.sal_type='DRV' "
					+ "left join my_salesman h1 on h1.doc_no=r.helper and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=r.helper2 and h2.sal_type='HLR' "
					+ "left join gl_vehmaster v on v.fleet_no=r.fleetno where r.status<>7";   
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
	public JSONArray contractSearch(HttpSession session,int id) throws SQLException{     
		JSONArray RESULTDATA1=new JSONArray();
		if(id!=1) {
			return RESULTDATA1;  
		}
		Connection conn=null;  
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String  sql="select d.srno,cm.doc_no,cm.tr_no,d.site,ac.refname from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='crm' where cm.status<>7";   
			System.out.println("===contractSearch===="+sql);                

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
	public JSONArray skipnoSearch(String delsrno,String cnttrno,String cntsrno,String type) throws SQLException {         
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
	    if(type.equalsIgnoreCase("0")) {
	    	return RESULTDATA;   
	    }
		try {
		    conn = objconn.getMyConnection();
		    Statement stmt = conn.createStatement ();  
		    String sql = "",sqltest="";
		    if(type.equalsIgnoreCase("1")) {
		    	sql="select m.name,m.doc_no from sk_srvcontrdel l left join sk_skipm m on l.skipid=m.doc_no where l.slno='"+delsrno+"' and l.rdocno='"+cnttrno+"' and l.srno='"+cntsrno+"'";                
		    }else if(type.equalsIgnoreCase("2")) {   
		    	sql="select name,doc_no from sk_skipm where skipstatus=1";                    
		    }else {}        
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmt.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);
		    stmt.close();   
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
	   return RESULTDATA;
   }
	public JSONArray skipnoSearch() throws SQLException {         
		JSONArray RESULTDATA=new JSONArray();  
		Connection conn = null;
		try {
		    conn = objconn.getMyConnection();
		    Statement stmt = conn.createStatement ();  
		    String sql = "select name,doc_no from sk_skipm where skipstatus=1";                        
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmt.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);
		    stmt.close();   
		    conn.close();
		  }
		  catch(Exception e){
			  e.printStackTrace();   
			  conn.close();
		  }
	   return RESULTDATA;
   }
}
