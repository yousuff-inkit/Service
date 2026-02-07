package com.dashboard.skips.schedulemanagement;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsScheduleManagementDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray routeSearch(HttpSession session) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;  
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String  sql="select r.code,r.name,g.gname ,s.name site,dt.name wastetype,r.doc_no from sk_route r left join gl_vehgroup g on r.grpid=g.doc_no left join sk_dumpsite s on s.doc_no=r.dumpsiteid left join sk_dumptype dt on dt.doc_no=s.typeid where r.status<>7";
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
	 public JSONArray searchVehgrp(HttpSession session) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();

				ResultSet resultSet = stmtVehclr.executeQuery ("select doc_no,gname from gl_vehgroup where status=3 order by doc_no");

				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}


	 public JSONArray searchDump(HttpSession session) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();

				ResultSet resultSet = stmtVehclr.executeQuery ("select doc_no,name dump from sk_dumpsite where status=3 order by doc_no");

				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}

	 public JSONArray searchArea(HttpSession session) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();

				ResultSet resultSet = stmtVehclr.executeQuery ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3");

				RESULTDATA=objcommon.convertToJSON(resultSet);     
				stmtVehclr.close();
				conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
	 public JSONArray routeData(HttpSession session,String id) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return RESULTDATA;
			}
			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
                String sql="select r.code,r.name,r.doc_no,d.name dumpsite,v.gname vehgroup,a.area from sk_route r left join sk_dumpsite d on d.doc_no=r.dumpsiteid left join gl_vehgroup v on v.doc_no=r.grpid left join my_area a on a.doc_no=r.area where r.status<>7";
				ResultSet resultSet = stmtVehclr.executeQuery (sql);  

				RESULTDATA=objcommon.convertToJSON(resultSet);     
				stmtVehclr.close();
				conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
	 public JSONArray scheduleData(HttpSession session,String id) throws SQLException {  
			JSONArray RESULTDATA=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return RESULTDATA;
			}
			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVehclr = conn.createStatement ();
				String sql="select r.name route,s.doc_no,date_format(s.date,'%d.%m.%Y') date,s.time,s1.sal_name driver,s2.sal_name helper from sk_schedule s left join my_salesman s1 on s1.doc_no=s.driverid and s1.sal_type='DRV'  left join my_salesman s2 on s2.doc_no=s.helperid and s2.sal_type='HLR' left join sk_route r on r.doc_no=s.routeid where s.status<>7";
				ResultSet resultSet = stmtVehclr.executeQuery (sql);
				
				RESULTDATA=objcommon.convertToJSON(resultSet);     
				stmtVehclr.close();
				conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
}
