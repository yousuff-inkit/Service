package com.dashboard.skips.serviceexecution;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsServiceExecutionDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	Connection conn;  
	public int insert(String rowno, String brhid, String contrno, String srno, String delsrno, ArrayList<String> schedulearray, HttpSession session, HttpServletRequest request) throws SQLException {
		try{  
			conn=objconn.getMyConnection();    
			Statement stmt =conn.createStatement();
			Statement stmt2 =conn.createStatement();
			conn.setAutoCommit(false);     
			//System.out.println("IN DAO");  
			int val=0;
			int delid=0, driveridsch=0, helperidsch=0, routeidsch=0, fleetnosch=0;   
			String sqltest="";
			if(!delsrno.equalsIgnoreCase("All")) {   
				sqltest+=" and slno='"+delsrno+"'";     
			}
	 		String strsql1="select doc_no, driverid, helperid, routeid, fleetno from sk_srvcontrdel where rdocno='"+contrno+"' and srno='"+srno+"' "+sqltest+"";           
			//System.out.println("strsql1==="+strsql1);  
			ResultSet rs1 = stmt.executeQuery(strsql1);    
			while(rs1.next()) {
					delid=rs1.getInt("doc_no");
					 driveridsch = rs1.getInt("driverid");
					 helperidsch = rs1.getInt("helperid");
					 routeidsch = rs1.getInt("routeid");
					 fleetnosch = rs1.getInt("fleetno");
					for(int i=0;i< schedulearray.size();i++){  
						String[] schedule=schedulearray.get(i).split("::");  
						if(!(schedule[0].trim().equalsIgnoreCase("undefined") || schedule[0].trim().equalsIgnoreCase("NaN") || schedule[0].trim().equalsIgnoreCase("") || schedule[0].isEmpty()))
						{
							java.sql.Date sqlstartdate = null;      
							sqlstartdate = schedule[0].trim().equalsIgnoreCase("undefined") || schedule[0].trim().equalsIgnoreCase("NaN") || schedule[0].trim().equalsIgnoreCase("") || schedule[0].trim().isEmpty()?null:objcommon.changeStringtoSqlDate(schedule[0].trim().toString());    
			 				String time = schedule[1].trim().equalsIgnoreCase("undefined") || schedule[1].trim().equalsIgnoreCase("NaN") || schedule[1].trim().equalsIgnoreCase("") || schedule[1].trim().isEmpty()?"":schedule[1].trim().toString();
			 				String days = schedule[2].trim().equalsIgnoreCase("undefined") || schedule[2].trim().equalsIgnoreCase("NaN") || schedule[2].trim().equalsIgnoreCase("") || schedule[2].trim().isEmpty()?"":schedule[2].trim().toString();
			 				  
			 				String inssql="insert into sk_srvcontrsch(rdocno, srno, brhid, delid, date, time, days, driverid, helperid, routeid, fleetno) values('"+contrno+"', '"+srno+"', '"+brhid+"', '"+delid+"', '"+sqlstartdate+"', '"+time+"', '"+days+"','"+driveridsch+"','"+helperidsch+"','"+routeidsch+"','"+fleetnosch+"')";                  
			 				// System.out.println("inssql--->>>"+inssql);    
			 				val= stmt2.executeUpdate(inssql);     
							if(val<=0) {
								conn.close();
								stmt2.close();
								return 0;
							}	
						}
					}
			}
			if (val > 0) {     
				String upsql="update sk_srvcontrdet set statusid=5 where rdocno='"+contrno+"' and srno='"+srno+"'";                     
 				// System.out.println("upsql--->>>"+upsql);    
 				val= stmt.executeUpdate(upsql);   
 				
 				String upsql1="update sk_srvcontrdel set statusid=4 where rdocno='"+contrno+"' and srno='"+srno+"'";                       
 				// System.out.println("upsql1--->>>"+upsql1);    
 				val= stmt.executeUpdate(upsql1);   
				if(val<=0) {
					conn.close();
					stmt.close();
					return 0;
				}
				if(val<=0) {
					conn.close();
					stmt.close();
					return 0;
				}
			}
			if (val > 0) {   
				conn.commit();
				stmt.close();
				stmt2.close();  
				conn.close();
				return val;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}	 
	public JSONArray contractGridLoad(HttpSession session, int id, String widgetname) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();  
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String  sql="", sqltest=""; 
			
			if(widgetname.equalsIgnoreCase("all")){ 
		        sqltest+=" and m.status in(3,6,10) ";      
			}else if(widgetname.equalsIgnoreCase("new")){ 
		        sqltest+=" and m.status in(3,6) and m.oldcnttrno=0 and m.revision_no=0 and d.hold=0";      
			}else if(widgetname.equalsIgnoreCase("renew")){
					sqltest+=" and m.status in(3,6) and m.oldcnttrno>0 and m.revision_no=0 and d.hold=0";  
			}else if(widgetname.equalsIgnoreCase("rev")){
					sqltest+=" and m.status in(3,6) and m.revision_no>0 and d.hold=0 and m.status not in(10) ";
			}else if(widgetname.equalsIgnoreCase("ter")){  
					sqltest+=" and m.status in(10) and d.hold=0 ";       
			}else if(widgetname.equalsIgnoreCase("hold")){
					sqltest+=" and d.hold>0 and m.status in(3,6,10)";  
			}else{}      
			 
			sql="select sch.schdate,CONVERT(IF(COALESCE(d.nos-dd.ds,0)=0,'C',CONCAT('P',COALESCE(d.nos-dd.ds,0))),CHAR(20)) delsch, CONVERT(IF(COALESCE(d.nos-dd.ra,0)=0,'C',CONCAT('P',COALESCE(d.nos-dd.ra,0))),CHAR(20)) routeasgn, "
					+ "CONVERT(IF(d.collectionid=2,'CB',IF(sch.schdate is not null and (month(m.enddt)!=month(sch.schdate) or year(m.enddt)!=year(sch.schdate)),CONCAT('P',COALESCE(d.nos,0)),IF(COALESCE(d.nos-dd.cs,0)=0,'C',CONCAT('P',COALESCE(d.nos,0))))),CHAR(20)) collsch,CONVERT(IF(COALESCE(dd.po,0)=0,'',CONCAT('P',COALESCE(dd.po,0))),CHAR(20)) pullout,if(m.status=9,'R','N') cnttype,dd.skipid,dd.skipno,case when m.statusid=2 then 'Emailed' when m.statusid=3 then 'Acknowledgement Done' when m.statusid=4 then 'Final invoice raise' when m.statusid=5 then 'Account approved' when m.statusid=6 then 'Printed' else 'Entered' end as docstatus,convert(case when m.status=9 then 'Renewed' when (m.status=3 and m.enddt<curdate()) then 'Expired' when m.status=0 then 'Not Approved' when m.status=3 then 'Approved' when m.status=6 then 'Closed' when m.status=10 then 'Termintaed' else m.status end,char(30)) as cntstatus,dd.dlname,dd.dlmobile,dd.dlemail,dd.dldayshift,d.srno,convert(coalesce(d.srdocno,''),char(45)) srdocno,d.srdesc,m.email,sm.sal_name salesman,coalesce(a1.name,'') groupcompanies,m.refno,m.remarks oldcontno,dd.gpsx gpsx1,dd.gpsy gpsy1,dd.route,dd.skip,"
					+ "d.statusid,case when d.statusid=1 then 'Skip Assigned' when d.statusid=2 then 'Delivery Scheduled' when d.statusid=3 then 'Delivered' when d.statusid=4 then 'Route Assigned' when d.statusid=5 then 'Scheduled' when d.statusid=6 then 'Pull out requested' when d.statusid=7 then 'Terminated / Cancel job requested' else 'Entered' end as status,"
					+ "m.brhid,if(s.gpsx=0,'',s.gpsx) gpsx, if(s.gpsy=0,'',s.gpsy) gpsy,ac.refname,m.cldocno,d.rowno,m.tr_no,m.doc_no,date_format(m.date,'%d.%m.%Y') date,d.wastetype wastedoc,d.skiptype skipdoc,"
					+ "sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, "
					+ "d.specid, d.collectionid, round(coalesce(d.rate,0),2) rate, round(coalesce(0,0),2) adminfee, round(coalesce(d.rent,0),2) rent, d.foc,r1.name ownership,r2.name serviceby,"
					+ "r3.name serviceterm,sp.name spec,r4.name collection,if(s.rowno is null,0,s.rowno) siteid,date_format(m.enddt,'%d.%m.%Y') enddt, m.cperson, m.cpemail, m.cpersonid,m.mob,s.areaid,aa.area from sk_srvcontrm m "
					+ "inner join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype "
					+ "left join sk_srvcsited s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') "
					+ "left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') "
					+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' INNER JOIN (SELECT m.name skipno,del.skipid,GROUP_CONCAT(DISTINCT del.gpsx) gpsx,GROUP_CONCAT(DISTINCT del.gpsy) gpsy,GROUP_CONCAT(DISTINCT r.name) route,GROUP_CONCAT(DISTINCT m.name) skip,d.rdocno,d.srno,GROUP_CONCAT(DISTINCT del.name) dlname,GROUP_CONCAT(DISTINCT del.email) dlemail,GROUP_CONCAT(DISTINCT del.mobile) dlmobile,GROUP_CONCAT(DISTINCT del.dayshift) dldayshift,SUM(IF(COALESCE(del.statusid,0)>=1,1,0)) ds, SUM(IF(COALESCE(del.statusid,0)>=3,1,0)) ra, SUM(IF(COALESCE(del.statusid,0)>=4,1,0)) cs,SUM(IF(COALESCE(del.statusid,0)=5,1,0)) po FROM sk_srvcontrdet d LEFT JOIN sk_srvcontrdel del ON del.rdocno=d.rdocno AND del.srno=d.srno LEFT JOIN sk_skipm m ON m.doc_no=del.skipid LEFT JOIN sk_route r ON r.doc_no=del.routeid GROUP BY d.rdocno) dd ON dd.rdocno=m.tr_no "
					+ "left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno) left join my_area aa on aa.doc_no=s.areaid left join (select max(date) schdate, rdocno, srno from sk_srvcontrsch sch group by rdocno,srno) sch on sch.rdocno=m.tr_no and sch.srno=d.srno left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno where d.srdocno>0 and coalesce(sf.confirm,0)=0 "+sqltest+" order by m.tr_no desc";
			System.out.println("SRM Grid===="+sql);                          
			ResultSet resultSet1 = stmt.executeQuery(sql);  
			RESULTDATA1=objcommon.convertToJSON(resultSet1);
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;   
	}
	public JSONArray scheduleLoad(HttpSession session, String date, String enddate, String time, String noofvisit, String serviceterm,
			String days, String alternatedays, String daynos, int id) throws SQLException{        
		JSONArray jsonArray = new JSONArray();

		if(id==0){
			return jsonArray;
		}
		Connection conn = null; 
		try {
			java.sql.Date xdate=null;
			java.sql.Date fdate=null;
			java.sql.Date endsdate=null;
            String day="",dates="";
			int xsrno=0;
			date.trim();
			if(alternatedays.equalsIgnoreCase("1")) {
				serviceterm="ALTERNATIVE";
			}  
			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
				xdate = objcommon.changeStringtoSqlDate(date);
				fdate = objcommon.changeStringtoSqlDate(date);  
			}

			enddate.trim();
			if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
				endsdate = objcommon.changeStringtoSqlDate(enddate);
			}

			String xsql="";

			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();  
			Statement stmt2 = conn.createStatement();  
            int duelen=0;
            String type=serviceterm.equalsIgnoreCase("DAILY")?" Day ":serviceterm.equalsIgnoreCase("MONTHLY")?" Month ":serviceterm.equalsIgnoreCase("WEEKLY")?" Week ":" Day "; 
			String strsql1="SELECT TIMESTAMPDIFF("+type+", '"+fdate+"', '"+endsdate+"') duelen";   
			//System.out.println("strsql1==="+strsql1);
			ResultSet rs1 = stmt.executeQuery(strsql1);  
			while(rs1.next()) {
				duelen=rs1.getInt("duelen");
			}
			if(serviceterm.equalsIgnoreCase("ALTERNATIVE")) {
				duelen=duelen/2; 
				xsql=2 + type;
			}else {
				xsql=1 + type;
			}
			//System.out.println(days+"=days===serviceterm="+serviceterm); 
			//System.out.println("noofvisit="+noofvisit);      
			do							
			{	

				if (Integer.parseInt(noofvisit)>0 && xsrno>duelen) break;

				JSONObject obj = new JSONObject();
				if(xsrno>duelen) break; 
				if(!alternatedays.equalsIgnoreCase("1")) {   
					//System.out.println("=IN 1=");   
					String sqltst="";   
					if(!days.equalsIgnoreCase("8")) {     
						 sqltst+=" AND DAYOFWEEK(DATE) in("+days+")";  
					}
					if(!daynos.equalsIgnoreCase("0")) {
						 sqltst+=" and DAY(a.DATE) in("+daynos+")";     
					}
					String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
				    //System.out.println("sql="+sql);      
	                ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()) {
						xdate=rs.getDate("date");  
						if(!(xdate==null) || !(endsdate.after(xdate))){
							String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";    
							//System.out.println("sql1="+sql1);    
			                ResultSet rs2 = stmt2.executeQuery(sql1);
							if(rs2.next()) {
								day=rs2.getString("day"); 
								dates=rs2.getString("date");    
							}
							obj.put("date",dates);
							obj.put("time",time); 
							obj.put("day",day);  
						}
						jsonArray.add(obj);
					}
					rs.close();
					break;   
				}else {  
					//System.out.println("=IN 2=");   
					if(!(xdate==null) || !(endsdate.after(xdate))){
						String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";    
						//System.out.println("sql1="+sql1);    
		                ResultSet rs2 = stmt2.executeQuery(sql1);
						if(rs2.next()) {
							day=rs2.getString("day"); 
							dates=rs2.getString("date");    
						}
						
						obj.put("date",dates);
						obj.put("time",time); 
						obj.put("day",day);  
					}
					jsonArray.add(obj);
					String sql="Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(noofvisit)+",'-',day('"+xdate+"')))) fdate";
					//System.out.println("sql="+sql);      
	                ResultSet rs = stmt.executeQuery(sql);
					if(rs.next()) xdate=rs.getDate("fdate");     
					rs.close(); 
				}
				xsrno++;
			}while(true); 
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jsonArray;
	}
	public JSONArray quotedetLoad(HttpSession session, String rdocno, String srno, int id) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="";
			/*if(id==1) {
				 sql="select round(d.nos-d.balqty,0) balqty,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos qty from sk_srvcontrdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid where d.rdocno='"+rdocno+"' and d.srno='"+srno+"'";     
			}else if(id==2 || id==3 || id==4){    
				 sql="select round(d.nos-d.balqty,0) balqty,coalesce(del.doc_no,0) delid,del.skipid,sm.name skip,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos qty from sk_srvcontrdet d left join sk_srvcontrdel del on d.rdocno=del.rdocno and d.srno=del.srno left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid left join sk_skipm sm on sm.doc_no=del.skipid where d.rdocno='"+rdocno+"' and d.srno='"+srno+"'";
			}else {}*/  
			sql="select del.routeid,drv.sal_name driver,concat(veh.reg_no,' - ',veh.flname) vehicle,del.gpsx,del.gpsy,rt.name route,del.driverid, del.helperid, del.schdate, del.schtime, del.fleetno, del.name, del.mobile, del.email, del.dayshift, del.location, sm.name skip,coalesce(del.doc_no,0) delid,coalesce(del.skipid,0) skipid,e.* from(select @i:=@i+1 slno,a.*,n4.num*1000+n3.num*100+n2.num*10+n1.num qty2 from(select d.srno,d.rdocno,round(d.nos-d.balqty,0) balqty,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos qty from sk_srvcontrdet d  left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid  where d.rdocno='"+rdocno+"' and d.srno='"+srno+"')a,(select @i:=0)c,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4 where 1=1 having qty2<=qty and qty2!=0)e left join sk_srvcontrdel del on e.rdocno=del.rdocno and e.srno=del.srno and del.slno=e.slno left join sk_route rt on rt.doc_no=del.routeid left join sk_skipm sm on sm.doc_no=del.skipid left join my_salesman drv on drv.doc_no=del.driverid left join gl_vehmaster veh on veh.fleet_no=del.fleetno where 1=1 group by e.slno";
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
	
	public JSONArray skipSearch(HttpSession session,String skiptype,String selectedskips) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;  
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String  sql="select name,doc_no from sk_skipm where status<>7 and skipstatus=1 and typeid='"+skiptype+"' and doc_no not in("+selectedskips.substring(0, selectedskips.length()-1)+")";      
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
	public JSONArray routeSearch(HttpSession session) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;  
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String  sql="select sm.sal_name driver,h1.sal_name helper1,h2.sal_name helper2,v.reg_no,r.code,r.name,g.gname ,s.name site,dt.name wastetype,r.doc_no from sk_route r left join gl_vehgroup g on r.grpid=g.doc_no left join sk_dumpsite s on s.doc_no=r.dumpsiteid left join sk_dumptype dt on dt.doc_no=s.typeid left join my_salesman sm on sm.doc_no=r.driverid and sm.sal_type='DRV' left join my_salesman h1 on h1.doc_no=r.helper and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=r.helper2 and h2.sal_type='HLR' left join gl_vehmaster v on v.fleet_no=r.fleetno where r.status<>7";
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
	 public  JSONArray contactSearch(String cldocno) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn=null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

				String salsql="select e.mob,e.email,e.tel,e.cperson,e.row_no cpersonid,e.actvty_id ,ac.ay_name,ac.doc_no aydocno from my_crmcontact e  left join my_activity ac on e.actvty_id=ac.doc_no where e.cldocno='"+cldocno+"' ";
				//System.out.println("contactSearch="+salsql); 
				ResultSet resultSet = stmtVeh.executeQuery(salsql);
				RESULTDATA=objcommon.convertToJSON(resultSet);    
				stmtVeh.close();
				conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return RESULTDATA;
		}
	 public JSONArray searchClient(HttpSession session,String clnames,String docno,int id) throws SQLException {    
			JSONArray RESULTDATA=new JSONArray();  
			if(id!=1){  
				return RESULTDATA;
			}  
			String sqltest="";
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";  
			}
			if(!(clnames.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";  
			}
			Connection conn = null;

			try {
				 conn = objconn.getMyConnection();
				 Statement stmtenq1 = conn.createStatement ();  
				 String clsql= "select cp.cperson,cp.row_no cpersonid,coalesce(a1.refname,'') groupcompanies,cp.mob,cp.email,ac.refname,ac.cldocno from my_acbook ac left join my_acbook a1 on ac.grpcmp=a1.cldocno and a1.dtype='crm' left join my_crmcontact cp on cp.cldocno=ac.cldocno where ac.dtype='crm' and ac.status<>7 "+sqltest+" group by ac.cldocno order by ac.refname";
				 //System.out.println("====Client Search===="+clsql);                            
				ResultSet resultSet = stmtenq1.executeQuery(clsql);  

				RESULTDATA=objcommon.convertToJSON(resultSet);  
				stmtenq1.close();
				conn.close();
			}
			catch(Exception e){
				conn.close();
				e.printStackTrace();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
		public JSONArray areaSearch(HttpSession session,int id) throws SQLException{
			JSONArray RESULTDATA1=new JSONArray();
			if(id!=1) {
				return RESULTDATA1;     
			}
			Connection conn=null;
			try {
				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
//				System.out.println("===sql===="+sql);  

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
		public JSONArray skipsizeSearch(int id,String rdocno,String srno) throws SQLException {    
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
		    
			  try {
			    conn = objconn.getMyConnection();
			    Statement stmt = conn.createStatement ();  
			    String sql = "",sqltest="";
			    
			    sql="select m.name,m.doc_no from sk_srvcontrdel l left join sk_skipm m on l.skipid=m.doc_no where l.rdocno='"+rdocno+"' and srno='"+srno+"'";         
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
	   public JSONArray scheduleMultipleLoad(HttpSession session, String date, String enddate, String time, String noofvisit, String serviceterm,
				String days, String alternatedays, String daynos, int id) throws SQLException{           
			JSONArray jsonArray = new JSONArray();

			if(id==0){
				return jsonArray;
			}
			Connection conn = null; 
			try {
				java.sql.Date xdate=null;
				java.sql.Date fdate=null;
				java.sql.Date endsdate=null;
	            String day="",dates="";
				int xsrno=0;
				date.trim();
				if(alternatedays.equalsIgnoreCase("1")) {
					serviceterm="ALTERNATIVE";
				}  
				if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
					xdate = objcommon.changeStringtoSqlDate(date);
					fdate = objcommon.changeStringtoSqlDate(date);  
				}

				enddate.trim();
				if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
					endsdate = objcommon.changeStringtoSqlDate(enddate);
				}

				String xsql="";

				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();  
				Statement stmt2 = conn.createStatement();  
	            int duelen=0;
	            //System.out.println("serviceterm="+serviceterm);
	            String type=serviceterm.equalsIgnoreCase("DAILY")?" Day ":serviceterm.equalsIgnoreCase("MONTHLY")?" Month ":serviceterm.equalsIgnoreCase("WEEKLY")?" Week ":" Day "; 
				String strsql1="SELECT TIMESTAMPDIFF("+type+", '"+fdate+"', '"+endsdate+"') duelen";   
				//System.out.println("strsql1==="+strsql1);   
				ResultSet rs1 = stmt.executeQuery(strsql1);  
				while(rs1.next()) {
					duelen=rs1.getInt("duelen");
				}
				if(serviceterm.equalsIgnoreCase("ALTERNATIVE")) {
					duelen=duelen/2; 
					xsql=2 + type;
				}else {
					xsql=1 + type;
				}
				//System.out.println(days+"=days===serviceterm="+serviceterm); 
				//System.out.println("noofvisit="+noofvisit);
				int t2=0,a1=0,a2=1,a3=0;
				t2=Integer.parseInt(noofvisit);  
				do							
				{	
					if (Integer.parseInt(noofvisit)>0 && xsrno>duelen) break;

					JSONObject obj = new JSONObject();
					if(xsrno>duelen) break; 
					
					if(!alternatedays.equalsIgnoreCase("1") && serviceterm.equalsIgnoreCase("DAILY")) {                
						//System.out.println("=IN 1=");  
						int t1=1;    
						String sqltst="";   
						if(!days.equalsIgnoreCase("8")) {     
							 sqltst+=" AND DAYOFWEEK(DATE) in("+days+")";  
						}
						if(!daynos.equalsIgnoreCase("0")) {
							 sqltst+=" and DAY(a.DATE) in("+daynos+")";     
						}
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							xdate=rs.getDate("date");  
							while(!(xdate==null) || !(endsdate.after(xdate))){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";        
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
								}
								if(t1 <= t2) {      
									obj.put("date",dates);
									obj.put("time",time); 
									obj.put("day",day);
									jsonArray.add(obj);
									t1++;  
								}else { 
									t1 = 1;
									break;
								}
							}
						}
						rs.close();
						break;   
					}else if(!alternatedays.equalsIgnoreCase("1") && (serviceterm.equalsIgnoreCase("MONTHLY"))) {     
						//System.out.println("=IN 2=");   
						int t1=0,t3=0,m1=0,m2=0;   
						String sqltst="";   
						if(!days.equalsIgnoreCase("8")) {     
							 sqltst+=" AND DAYOFWEEK(DATE) in("+days+")";  
						}
						if(!daynos.equalsIgnoreCase("0")) {
							 sqltst+=" and DAY(a.DATE) in("+daynos+")";     
						}
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							t1++;
							xdate=rs.getDate("date");  
							if(!(xdate==null) || !(endsdate.after(xdate))){
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') m1";        
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									m1 = rs2.getInt("m1");
								}
								if((m1 == m2) && (t1 <= t2)) {      
									obj.put("date",dates);
									obj.put("time",time); 
									obj.put("day",day);
									jsonArray.add(obj);
								}else if(m1 != m2) {
									t1 = 1;
									obj.put("date",dates);
									obj.put("time",time); 
									obj.put("day",day);
									jsonArray.add(obj);
								}else { 
								}
								m2=m1;
							}
						}
						rs.close();
						break;
					}else if(!alternatedays.equalsIgnoreCase("1") && (serviceterm.equalsIgnoreCase("WEEKLY"))) {      
						//System.out.println("=IN 3=");      
						int t1=0,t3=0,m1=0,m2=0,w1=0,w2=2;                 
						String sqltst="";   
						if(!days.equalsIgnoreCase("8")) {     
							 sqltst+=" AND DAYOFWEEK(DATE) in("+days+")";  
						}
						if(!daynos.equalsIgnoreCase("0")) {
							 sqltst+=" and DAY(a.DATE) in("+daynos+")";     
						}
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							t1++;
							xdate=rs.getDate("date");  
							if(!(xdate==null) || !(endsdate.after(xdate))){
								String sql1="Select DAYNAME('"+xdate+"') day, date_format('"+xdate+"','%d.%m.%Y') date, DAYOFWEEK('"+xdate+"') w1";           
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									w1 = rs2.getInt("w1");     
								}
								if(w1 == w2) {   
									t1 = 1;
									obj.put("date",dates);
									obj.put("time",time); 
									obj.put("day",day);
									jsonArray.add(obj);
								}else if((w1 != w2) && (t1 <= t2)) {   
									obj.put("date",dates);
									obj.put("time",time); 
									obj.put("day",day);
									jsonArray.add(obj);
								}else { 
									 
								}
							}
						}
						rs.close();
						break;
					}else if(!alternatedays.equalsIgnoreCase("1") && serviceterm.equalsIgnoreCase("Daily (Except Holiday)")) {                
						//System.out.println("=IN 1=");  
						int t1=1,t3=0,d1=0;      
						String sqltst="";   
						if(!days.equalsIgnoreCase("8")) {     
							 sqltst+=" AND DAYOFWEEK(DATE) in("+days+")";
							 t3=1; 
						}
						if(!daynos.equalsIgnoreCase("0")) {
							 sqltst+=" and DAY(a.DATE) in("+daynos+")";
							 t3=1; 
						}
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							xdate=rs.getDate("date");  
							while(!(xdate==null) || !(endsdate.after(xdate))){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, DAYOFWEEK('"+xdate+"') d1";         
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									d1 = rs2.getInt("d1"); 
								}
								if(t1 <= t2) { 
									if(t3 == 1) {
										obj.put("date",dates);
										obj.put("time",time); 
										obj.put("day",day);
										jsonArray.add(obj);
										t1++;
									}else if(d1 != 1) {
										obj.put("date",dates);
										obj.put("time",time); 
										obj.put("day",day);
										jsonArray.add(obj);
										t1++;
									}else {
										t1++;
									}
								}else { 
									t1 = 1;
									break;
								}
							}
						}
						rs.close();
						break;   
					}else if(alternatedays.equalsIgnoreCase("1")){    
						//System.out.println("=IN 4="); 
						while(!(xdate==null) || !(endsdate.after(xdate))){
							//System.out.println("=a2="+a2);   
							String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') a1";       
							//System.out.println("sql1="+sql1);    
			                ResultSet rs2 = stmt2.executeQuery(sql1);
							if(rs2.next()) {
								day=rs2.getString("day"); 
								dates=rs2.getString("date"); 
								a1 = rs2.getInt("a1");     
							}
							if((a1 == a3) && (a2 <= t2)) {         
								obj.put("date",dates);
								obj.put("time",time); 
								obj.put("day",day);
								jsonArray.add(obj);
							}else if(a1 != a3) {  
								a2=1;   
								obj.put("date",dates);
								obj.put("time",time); 
								obj.put("day",day);
								jsonArray.add(obj);
							}else {
								a2=1;   
								break;
							}
							a2++; 
							a3 = a1; 
						}
						String sql="Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(noofvisit)+",'-',day('"+xdate+"')))) fdate";
						//System.out.println("sql="+sql);          
		                ResultSet rs = stmt.executeQuery(sql);
						if(rs.next()) xdate=rs.getDate("fdate");     
						rs.close(); 
					}
					xsrno++;
				}while(true); 
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return jsonArray;
		}
}
