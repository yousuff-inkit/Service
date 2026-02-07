package com.dashboard.skips.contractmanagement;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsContractManagementDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	Connection conn;  
	public int insert(String rowno, String brhid, String contrno, String srno, ArrayList<String> schedulearray, HttpSession session, HttpServletRequest request) throws SQLException {
		try{  
			conn=objconn.getMyConnection();  
			Statement stmt =conn.createStatement();
			conn.setAutoCommit(false);     
			//System.out.println("IN DAO");  
			int val=0;
			int delid=0;   
	 		String strsql1="select doc_no from sk_srvcontrdel where rdocno='"+contrno+"' and srno='"+srno+"'";        
			//System.out.println("strsql1==="+strsql1);
			ResultSet rs1 = stmt.executeQuery(strsql1);    
			while(rs1.next()) {
					 delid=rs1.getInt("doc_no");
			}
			for(int i=0;i< schedulearray.size();i++){  

				String[] schedule=schedulearray.get(i).split("::");  
				
				if(!(schedule[0].trim().equalsIgnoreCase("undefined") || schedule[0].trim().equalsIgnoreCase("NaN") || schedule[0].trim().equalsIgnoreCase("") || schedule[0].isEmpty()))
				{
					java.sql.Date sqlstartdate = null;      
					sqlstartdate = schedule[0].trim().equalsIgnoreCase("undefined") || schedule[0].trim().equalsIgnoreCase("NaN") || schedule[0].trim().equalsIgnoreCase("") || schedule[0].trim().isEmpty()?null:objcommon.changeStringtoSqlDate(schedule[0].trim().toString());    
	 				String time = schedule[1].trim().equalsIgnoreCase("undefined") || schedule[1].trim().equalsIgnoreCase("NaN") || schedule[1].trim().equalsIgnoreCase("") || schedule[1].trim().isEmpty()?"":schedule[1].trim().toString();
	 				String days = schedule[2].trim().equalsIgnoreCase("undefined") || schedule[2].trim().equalsIgnoreCase("NaN") || schedule[2].trim().equalsIgnoreCase("") || schedule[2].trim().isEmpty()?"":schedule[2].trim().toString();
	 				  
	 				String inssql="insert into sk_srvcontrsch(rdocno, srno, brhid, delid, date, time, days) values('"+contrno+"', '"+srno+"', '"+brhid+"', '"+delid+"', '"+sqlstartdate+"', '"+time+"', '"+days+"')";                  
	 				// System.out.println("inssql--->>>"+inssql);    
	 				val= stmt.executeUpdate(inssql);   
					if(val<=0) {
						conn.close();
						stmt.close();
						return 0;
					}	
				}
			}
			if (val > 0) {   
				conn.commit();
				stmt.close();
				conn.close();
				return val;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}	 
	public JSONArray contractGridLoad(HttpSession session,int id, String todate, String datechk) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String  sql="", sqltest="";  
			if(datechk.equalsIgnoreCase("1")) {   
				if(!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("0")) {
					sqltest+=" and m.enddt>'"+objcommon.changeStringtoSqlDate(todate)+"'";     
				}
			}
			if(id==2) {
				    sqltest+=" and d.srdocno>0";       
			}
			   
			sql="select a.*,round((coalesce(round(nooftrips,0),0)*a.rate)+(coalesce(round(nooftrips,0),0)*a.tippingfee),0) cntvalue from(select CASE WHEN m.status in(10) THEN 'TER' WHEN (m.status=3 and m.revision_no>0) THEN 'REV' WHEN (m.status=3 and m.oldcnttrno>0 and m.revision_no=0) THEN 'REN' when m.status in(3) THEN 'NEW' when m.status in(0) THEN 'NOTAPPR' when m.status in(9) THEN 'EXP' when m.status in(6) THEN 'CLD' ELSE '' END srfstatus,m.startdt startdt1,m.revision_no, case when m.billingmethod=1 then 'Monthly' when m.billingmethod=2 then 'Yearly' when m.billingmethod=3 then 'Adhoc' end billingmethod, m.skipstatus, if(m.inctipfee=1,'Yes','No') inctipfee,round(coalesce(d.addrate,0),2) addrate,r6.name ctype, round(coalesce(d.securityval,0),2) security, round(coalesce(d.tippingfee,0),2) tippingfee, round(coalesce(d.tippingsecurity,0),2) tippingsecurity, cast((case when m.billingmethod=1 then 1 when m.billingmethod=2 then 12 else 0 end)*d.scheduledays*d.nos*r3.tripsinmonth as decimal) nooftrips,d.hold,coalesce(dd.delqty,0) delqty,r.pullqty,if(m.status=9,'R','N') cnttype,dd.skipid,dd.skipno,case when m.statusid=2 then 'Emailed' when m.statusid=3 then 'Acknowledgement Done' when m.statusid=4 then 'Final invoice raise' when m.statusid=5 then 'Account approved' when m.statusid=6 then 'Printed' else 'Entered' end as docstatus,convert(case when m.status=10 then 'Terminated' when d.hold = 1 then 'Hold' when m.status=9 then 'Renewed' when (m.status=3 and m.enddt<=curdate()) then 'Expired' when m.status=0 then 'Not Approved' when m.status=3 then 'Approved' when m.status=6 then 'Closed'  else m.status end,char(30)) as cntstatus,dd.dlname,dd.dlmobile,dd.dlemail,dd.dldayshift,d.srno,convert(coalesce(d.srdocno,''),char(45)) srdocno,d.srdesc,m.email,sm.sal_name salesman,coalesce(a1.name,'') groupcompanies,m.refno,m.remarks oldcontno,dd.gpsx gpsx1,dd.gpsy gpsy1,dd.route,dd.skip,"
					+ "d.statusid,case when d.statusid=1 then 'Skip Assigned' when d.statusid=2 then 'Delivery Scheduled' when d.statusid=3 then 'Delivered' when d.statusid=4 then 'Route Assigned' when d.statusid=5 then 'Scheduled' when d.statusid=6 then 'Pull out requested' when d.statusid=7 then 'Terminated / Cancel job requested' else 'Entered' end as status,"
					+ "m.brhid,if(s.gpsx=0,'',s.gpsx) gpsx, if(s.gpsy=0,'',s.gpsy) gpsy,ac.refname,m.cldocno,m.tr_no,m.doc_no,date_format(m.date,'%d.%m.%Y') date,d.wastetype wastedoc,d.skiptype skipdoc,"
					+ "sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, "
					+ "d.specid, d.collectionid, round(coalesce(d.rate,0),2) rate, round(coalesce(0,0),2) adminfee, round(coalesce(d.rent,0),2) rent, d.foc,r1.name ownership,r2.name serviceby,"
					+ "r3.name serviceterm,sp.name spec,r4.name collection,if(s.rowno is null,0,s.rowno) siteid,date_format(m.enddt,'%d.%m.%Y') enddt, m.cperson, m.cpemail, m.cpersonid,m.mob,s.areaid,aa.area,date_format(m.startdt,'%d.%m.%Y') startdt,m.tel,ct.extn,ct.actvty_id,de.ay_name from sk_srvcontrm m "  
					+ "inner join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype "
					+ "left join sk_srvcsited s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') "
					+ "left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') "
					+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join (SELECT SUM(if(coalesce(del.doc_no,0)>0 and del.type!='P',1,if(coalesce(del.doc_no,0)>0 and del.type='P',0,1))) delqty,m.name skipno,del.skipid,group_concat(distinct del.gpsx) gpsx,group_concat(distinct del.gpsy) gpsy,group_concat(distinct r.name) route,group_concat(distinct m.name) skip,rdocno,srno,group_concat(distinct del.name) dlname,group_concat(distinct del.email) dlemail,group_concat(distinct del.mobile) dlmobile,group_concat(distinct del.dayshift) dldayshift FROM sk_srvcontrdel del left join sk_skipm m on m.doc_no=del.skipid left join sk_route r on r.doc_no=del.routeid group by rdocno) dd on dd.rdocno=d.rdocno and dd.srno=d.srno  LEFT JOIN (SELECT COUNT(*) pullqty, typeid, cnttrno, detsrno FROM sk_srvcontrrep WHERE typeid='P' GROUP BY cnttrno) r ON r.cnttrno=d.rdocno and r.detsrno=d.srno left join gl_enqm em on em.doc_no=m.refdocno "
					+ "left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) left join my_area aa on aa.doc_no=s.areaid left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') left join my_crmcontact	ct on ct.row_no=m.cpersonid left join my_activity de on de.doc_no=ct.actvty_id where m.status<>7 "+sqltest+" group by d.rowno order by m.tr_no desc)a";  
			//System.out.println("===sqlmaingrid===="+sql);                                    
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
         System.out.println();
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
			sql="select del.gpsx,del.gpsy,rt.name route,del.driverid, del.helperid, del.schdate, del.schtime, del.fleetno, del.name, del.mobile, del.email, del.dayshift, del.location, sm.name skip,coalesce(del.doc_no,0) delid,del.skipid,e.* from(select @i:=@i+1 slno,a.*,n4.num*1000+n3.num*100+n2.num*10+n1.num qty2 from(select d.srno,d.rdocno,round(d.nos-d.balqty,0) balqty,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos qty from sk_srvcontrdet d  left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid  where d.rdocno='"+rdocno+"' and d.srno='"+srno+"')a,(select @i:=0)c,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4 where 1=1 having qty2<=qty and qty2!=0)e left join sk_srvcontrdel del on e.rdocno=del.rdocno and e.srno=del.srno and del.slno=e.slno left join sk_route rt on rt.doc_no=del.routeid left join sk_skipm sm on sm.doc_no=del.skipid where 1=1 group by e.slno";
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
	public JSONArray skipSearch(HttpSession session,String skiptype) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;  
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String  sql="select name,doc_no from sk_skipm where status<>7 and skipstatus=1 and typeid='"+skiptype+"'";      
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
				 String clsql= "select cp.cperson,cp.row_no cpersonid,coalesce(a1.name,'') groupcompanies,cp.mob,cp.email,ac.refname,ac.cldocno from my_acbook ac left join sk_clgroup a1 on ac.grpcmp=a1.docno left join my_crmcontact cp on cp.cldocno=ac.cldocno where ac.dtype='crm' and ac.status<>7 "+sqltest+" group by ac.cldocno order by ac.refname";
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
		public JSONArray skipHistoryLoad(HttpSession session, int id, String rdocno, String srno, String delid) throws SQLException{ 
			JSONArray RESULTDATA1=new JSONArray();
			if(id!=1) {
				return RESULTDATA1;    
			}
			Connection conn=null;  
			try {
				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();

				String  sql="select rp.remarks,rp.entrydatetime,case when rp.typeid='R' then 'Replacement' when rp.typeid='E' then 'Exchange' when rp.typeid='P' then 'Pull Out' else '' end as status,u.user_name user,s1.name oldskip,s2.name newskip,date_format(rp.date,'%d.%m.%Y') date,rp.time from sk_srvcontrrep rp left join my_user u on u.doc_no=rp.userid left join sk_skipm s1 on s1.doc_no=rp.oldskipno left join sk_skipm s2 on s2.doc_no=rp.newskipno where rp.cnttrno='"+rdocno+"' and rp.detsrno='"+srno+"'";           
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
		public JSONArray hrLogLoad(HttpSession session, int id, String rdocno, String srno) throws SQLException{ 
			JSONArray RESULTDATA1=new JSONArray();
			if(id!=1) {
				return RESULTDATA1;    
			}
			Connection conn=null;  
			try {
				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql="select date_format(r.date,'%d.%m.%Y') date,r.reason remarks,u.user_name user,r.status from sk_srvcontrhr r left join my_user u on u.doc_no=r.userid where r.rdocno='"+rdocno+"' and r.srno='"+srno+"'"; 
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
		public JSONArray activitySearch(HttpSession session) throws SQLException {
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
			String brcid=session.getAttribute("BRANCHID").toString();

			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;
			try {
				conn = objconn.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select doc_no as adocno,ay_name from my_activity where status=3" );
			//	System.out.println("------------------"+sql);
				resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;

		}
}
