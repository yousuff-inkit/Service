package com.dashboard.skips.schedulereport;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsScheduleReportDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	Connection conn;  
	 
	public JSONArray serScheduleLoad(HttpSession session, int id, String fromdate, String todate, String routeid,String cldocno,String contrno, String widget) throws SQLException{
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
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("undefined") && !fromdate.equalsIgnoreCase("")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);  
			}
			if(!todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);         
			}
			if(!routeid.equalsIgnoreCase("undefined") && !routeid.equalsIgnoreCase("") && !routeid.equalsIgnoreCase("0")) {  
				sqltest+=" and (sc.routeid='"+routeid+"' or dl.routeid='"+routeid+"')";                    
			}
			if(!cldocno.equalsIgnoreCase("undefined") && !cldocno.equalsIgnoreCase(null) && !cldocno.equalsIgnoreCase("0")&& !cldocno.equalsIgnoreCase("")) {  
				sqltest+=" and (cm.cldocno='"+cldocno+"' )";                    
			}
			if(!contrno.equalsIgnoreCase("undefined") && !contrno.equalsIgnoreCase(null) && !contrno.equalsIgnoreCase("0")&& !contrno.equalsIgnoreCase("")) {  
				sqltest+=" and (cm.tr_no='"+contrno+"' )";                    
			}
			
            if(widget.equalsIgnoreCase("comp")){ 
                    sqltest+=" and sc.statusid=1";      
            }else if(widget.equalsIgnoreCase("drop")){
                    sqltest+=" and sc.statusid=2";  
            }else if(widget.equalsIgnoreCase("nosho")){
                    sqltest+=" and sc.statusid=3";
            }else if(widget.equalsIgnoreCase("deliv")){  
                    sqltest+=" and d.statusid=2";       
            }else if(widget.equalsIgnoreCase("visitfree")){
                    sqltest+=" and sc.statusid=5";
            }else if(widget.equalsIgnoreCase("cancel")){
                sqltest+=" and sc.statusid=6";
            }else if(widget.equalsIgnoreCase("charge")){
                sqltest+=" and sc.statusid=4";
            }else if(widget.equalsIgnoreCase("repreq")){
                sqltest+=" and sc.statusid not in (1,2,3,4,5,6)";
            }else{}    
			
			
			String sql="select case when sc.status=1 then 'Normal Schedule' when sc.status=2 then 'Pull Out' when sc.status=4 then 'Dropped' else '' end as skipstatus,"
					+ "sk.name skipsize,d.skiptype skiptypeid,	dl.skipid,dl.doc_no delid,coalesce(sc.routeid,dl.routeid) routeid, coalesce(sc.driverid,dl.driverid) driverid, "
					+ "coalesce(sc.helperid,dl.helperid) helperid, coalesce(sc.helperid2,0) helperid2, coalesce(sc.fleetno,dl.fleetno) fleetno,dm.name wastetype,d.wastetype wastetypeid,"
					+ "cm.brhid,sc.doc_no,date_format(sc.date,'%d.%m.%Y') date,sc.time,days,s.name skipno,r.name route,cm.doc_no contrno,cm.tr_no,d.srno,d.site,"
					+ "case when sc.statusid='1' then 'Completed' when sc.statusid='2' then 'Dropped' when sc.statusid='3' then 'No Show' when sc.statusid='4' then 'Visit Chargeable' when sc.statusid='5' then 'Visit Free' when sc.statusid='6' then 'Cancelled' else 'Pending' end as status "
					+ "from sk_srvcontrsch sc left join sk_srvcontrdel dl on dl.doc_no=sc.delid left join sk_skipm s on s.doc_no=dl.skipid "
					+ "left join sk_route r on r.doc_no=dl.routeid left join sk_srvcontrm cm on cm.tr_no=sc.rdocno "
					+ "left join sk_srvcontrdet d on d.rdocno=sc.rdocno and d.srno=sc.srno left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_skiptype sk on sk.doc_no=d.skiptype where sc.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"";	
			System.out.println("===sql===="+sql);                                        
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

			String  sql="select d.srno,cm.doc_no,cm.tr_no,d.site,ac.refname from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='crm' where cm.status=7";   
			//System.out.println("===contractSearch===="+sql);                

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
	public JSONArray skipnoSearch(String delid,String type) throws SQLException {         
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
		    	sql="select m.name,m.doc_no from sk_srvcontrdel l left join sk_skipm m on l.skipid=m.doc_no where l.doc_no='"+delid+"'";            
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
