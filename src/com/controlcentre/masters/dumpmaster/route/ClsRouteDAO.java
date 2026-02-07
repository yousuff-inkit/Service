package com.controlcentre.masters.dumpmaster.route;



	import java.sql.CallableStatement;
	import java.sql.Connection;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;

	import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	public class ClsRouteDAO {
		Connection conn;
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		public int insert(String txtcode,String txtname , String vehgrpid,String dumpid,String areaid, String mode, HttpSession session,String formdetailcode,String driverid,String helperid,String helperid2,String vehicleid) throws SQLException {

			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				int docno;
				
				CallableStatement stmtRoute = conn.prepareCall("{CALL routeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtRoute.registerOutParameter(8, java.sql.Types.INTEGER);
				stmtRoute.setString(1,txtcode);
				stmtRoute.setString(2,txtname);
				stmtRoute.setString(3,vehgrpid==null||vehgrpid==""||vehgrpid.equalsIgnoreCase("")?"0":vehgrpid);
				stmtRoute.setString(4,dumpid==null||dumpid==""||dumpid.equalsIgnoreCase("")?"0":dumpid);
				stmtRoute.setString(5,areaid==null||areaid==""||areaid.equalsIgnoreCase("")?"0":areaid);
				stmtRoute.setString(6,session.getAttribute("USERID").toString());
				stmtRoute.setString(7,session.getAttribute("BRANCHID").toString());
				stmtRoute.setString(9,mode);
				stmtRoute.setString(10, formdetailcode);
				stmtRoute.setString(11, driverid.equalsIgnoreCase("")?"0":driverid);
				stmtRoute.setString(12, helperid.equalsIgnoreCase("")?"0":helperid);
				stmtRoute.setString(13, helperid2.equalsIgnoreCase("")?"0":helperid2);
				stmtRoute.setString(14, vehicleid.equalsIgnoreCase("")?"0":vehicleid);

			    stmtRoute.executeQuery();    
			    docno=stmtRoute.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtRoute.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtRoute.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtRoute.close();
					conn.close();
					return docno;
				}
				
			  stmtRoute.close();
			  conn.close();
			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
			    return 0;
			}finally{
				conn.close();
			}
			return 0;
		}
		
		public int edit(String txtcode,String txtname ,String vehgrpid,String dumpid,String areaid,int docno,String mode, HttpSession session,String formdetailcode,String driverid,String helperid,String helperid2,String vehicleid) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				   
				CallableStatement stmtRoute = conn.prepareCall("{CALL routeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				

				stmtRoute.setInt(8,docno);
				stmtRoute.setString(1,txtcode);
				stmtRoute.setString(2,txtname);
				stmtRoute.setString(3,vehgrpid==null||vehgrpid==""||vehgrpid.equalsIgnoreCase("")?"0":vehgrpid);
				stmtRoute.setString(4,dumpid==null||dumpid==""||dumpid.equalsIgnoreCase("")?"0":dumpid);
				stmtRoute.setString(5,areaid==null||areaid==""||areaid.equalsIgnoreCase("")?"0":areaid);
				stmtRoute.setString(6,session.getAttribute("USERID").toString());
				stmtRoute.setString(7,session.getAttribute("BRANCHID").toString());
				stmtRoute.setString(9,mode);
				stmtRoute.setString(10, formdetailcode);
				stmtRoute.setString(11, driverid.equalsIgnoreCase("")?"0":driverid);
				stmtRoute.setString(12, helperid.equalsIgnoreCase("")?"0":helperid);
				stmtRoute.setString(13, helperid2.equalsIgnoreCase("")?"0":helperid2);
				stmtRoute.setString(14, vehicleid==null || vehicleid==""||vehicleid.equalsIgnoreCase("")?"0":vehicleid);

			    stmtRoute.executeUpdate();
			    	
			    
			    docno=stmtRoute.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtRoute.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtRoute.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtRoute.close();
					conn.close();
					return docno;
				}
				
			  stmtRoute.close();
			  conn.close();
			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
			    return 0;
			}finally{
				conn.close();
			}
			return 0;
		}

		public boolean delete(int docno, HttpSession session,String mode,String formdetailcode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
CallableStatement stmtRoute = conn.prepareCall("{CALL routeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				

				stmtRoute.setInt(8,docno);
				stmtRoute.setString(1,null);
				stmtRoute.setString(2,null);
				stmtRoute.setString(3,null);
				stmtRoute.setString(4,null);
				stmtRoute.setString(5,null);
				stmtRoute.setString(6,session.getAttribute("USERID").toString());
				stmtRoute.setString(7,session.getAttribute("BRANCHID").toString());
				stmtRoute.setString(9,mode);
				stmtRoute.setString(10, formdetailcode);
				stmtRoute.setString(11, null);
				stmtRoute.setString(12, null);
				stmtRoute.setString(13, null);
				stmtRoute.setString(14, null);

		
				int docNo = stmtRoute.executeUpdate();
				if (docNo > 0) {
					conn.commit();
					stmtRoute.close();
					conn.close();
					return true;
				}
			   stmtRoute.close();
			   conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
				return false;
			}finally{
				conn.close();
			}
			return false;
		}

		 public   JSONArray list() throws SQLException {
		        
			    JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null;

		        try {
						conn = ClsConnection.getMyConnection();
						Statement stmtVeh = conn.createStatement();
		            	
						ResultSet resultSet = stmtVeh.executeQuery ("Select s.doc_no,s.name,s.code,m.name cmbtype from sk_dumpsite s left join sk_dumptype m on s.typeid=m.doc_no ");
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtVeh.close();
						conn.close();
				}catch(Exception e){
					e.printStackTrace();
					conn.close();
				}finally{
					conn.close();
				}
		        return RESULTDATA;
		    }
		 
		 
		 public   JSONArray searchDetails() throws SQLException {

		        JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null;
				try {
						conn=ClsConnection.getMyConnection();
						Statement stmtVeh1 = conn.createStatement ();
		            	String sqldata="select r.fleetno vehicleid,r.doc_no ,r.code,r.name,v.gname,v.doc_no vehgrpid,d.name dump,d.doc_no dumpid,a.area,a.doc_no areaid,r.driverid,r.fleetno,r.helper helperid,r.helper2 helperid2,concat(gv.reg_no,' - ',gv.flname) vehicle,m.sal_name driver,m1.sal_name helper,m2.sal_name helper2 from sk_route r "
		            			+ "left join gl_vehgroup v on r.grpid=v.doc_no  "
		            			+ "left join sk_dumpsite d on r.dumpsiteid=d.doc_no  "
		            			+ "left join my_area a on r.area=a.doc_no "
		            			+ "left join gl_vehmaster gv on gv.fleet_no=r.fleetno "
		            			+ "left join my_salesman m on m.doc_no=r.driverid and m.sal_type='DRV' "
		            			+ "left join my_salesman m1 on m1.doc_no=r.helper and m1.sal_type='HLR' "
		            			+ "left join my_salesman m2 on m2.doc_no=r.helper2 and m2.sal_type='HLR' "
		            			+ " where r.status=3 order by r.doc_no";
		            	//System.out.println("=========="+sqldata);
						ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtVeh1.close();
						conn.close();
						 return RESULTDATA;

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }
	
		 public JSONArray searchVehgrp(HttpSession session) throws SQLException {

				JSONArray RESULTDATA=new JSONArray();

				Connection conn = null;
				try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVehclr = conn.createStatement ();

					ResultSet resultSet = stmtVehclr.executeQuery ("select doc_no,gname from gl_vehgroup where status=3 order by doc_no");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
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


		 public JSONArray searchDriver(HttpSession session) throws SQLException {

				JSONArray RESULTDATA=new JSONArray();

				Connection conn = null;
				try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVehclr = conn.createStatement ();

					ResultSet resultSet = stmtVehclr.executeQuery (" select sal_name driver,doc_no driverid from my_salesman where status<>7 and sal_type='DRV' ");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
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

		 public JSONArray searchHelper(HttpSession session) throws SQLException {

				JSONArray RESULTDATA=new JSONArray();

				Connection conn = null;
				try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVehclr = conn.createStatement ();

					ResultSet resultSet = stmtVehclr.executeQuery (" select sal_name helper,doc_no helperid from my_salesman where status<>7 and sal_type='HLR' ");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
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

		 public JSONArray searchVehicle(HttpSession session,String vehgrpids) throws SQLException {

				JSONArray RESULTDATA=new JSONArray();

				Connection conn = null;
				try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVehclr = conn.createStatement ();
					String sql="";
					if (!vehgrpids.equalsIgnoreCase("")) {
						sql=" and vgrpid='"+vehgrpids+"'";
					}
					String sqldata=" select vgrpid,concat(reg_no,' - ',flname) vehicle,fleet_no  vehicleid from gl_vehmaster where status<>7 "+sql+"";
					//System.out.println("sqldata7==="+sqldata);
					ResultSet resultSet = stmtVehclr.executeQuery (sqldata);

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
					conn = ClsConnection.getMyConnection();
					Statement stmtVehclr = conn.createStatement ();

					ResultSet resultSet = stmtVehclr.executeQuery ("select doc_no,name dump from sk_dumpsite where status=3 order by doc_no");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
					conn = ClsConnection.getMyConnection();
					Statement stmtVehclr = conn.createStatement ();

					ResultSet resultSet = stmtVehclr.executeQuery ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3");

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
