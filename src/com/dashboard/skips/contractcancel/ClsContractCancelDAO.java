package com.dashboard.skips.contractcancel;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsContractCancelDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray contractGridLoad(HttpSession session,int id) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String  sql="select d.cancelapprove approve,ac.acno,dd.gpsx gpsx1,dd.gpsy gpsy1,dd.route,dd.skip,d.statusid,case when d.statusid=1 then 'Skip Assigned' when d.statusid=2 then 'Delivery Scheduled' when d.statusid=3 then 'Delivery Updated' when d.statusid=4 then 'Route Assigned' else 'Entered' end as status,m.brhid,if(s.gpsx=0,'',s.gpsx) gpsx, if(s.gpsy=0,'',s.gpsy) gpsy,ac.refname,m.cldocno,d.rowno,m.tr_no,m.doc_no,m.date,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, round(coalesce(d.rate,0),2) rate, round(coalesce(0,0),2) adminfee, round(coalesce(d.rent,0),2) rent, d.foc,r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,if(s.rowno is null,0,s.rowno) siteid,date_format(m.enddt,'%d.%m.%Y') enddt from sk_srvcontrm m left join sk_srvcontrdet d  on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.site=d.site and s.tr_no=d.rdocno left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join (select group_concat(distinct del.gpsx) gpsx,group_concat(distinct del.gpsy) gpsy,group_concat(distinct r.name) route,group_concat(distinct m.name) skip,rdocno from sk_srvcontrdel del left join sk_skipm m on m.doc_no=del.skipid left join sk_route r on r.doc_no=del.routeid group by rdocno) dd on dd.rdocno=d.rowno where m.status<>7 order by m.tr_no desc";
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
	public JSONArray scheduleLoad(HttpSession session,String date,String enddate,String time,String noofvisit,String serviceterm,int days,int id) throws SQLException{  
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
			//System.out.println("days==="+days); 
			do							
			{	

				if (Integer.parseInt(noofvisit)>0 && xsrno>duelen) break;

				JSONObject obj = new JSONObject();

				if(xsrno>duelen) break; 
				if(days!=0) {    
					String sqltst="";   
					if(days!=8) {  
						 sqltst=" AND DAYOFWEEK(DATE) in("+days+")";  
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
	public JSONArray quotedetLoad(HttpSession session,String rowno,int id) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="";
			if(id==1) {
				 sql="select round(d.nos-d.balqty,0) balqty,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos qty from sk_srvcontrdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumpsite ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.site=d.site and s.tr_no=d.rdocno where d.rowno='"+rowno+"'"; 
			}else if(id==2 || id==3 || id==4){    
				 sql="select del.doc_no delid,del.skipid,sm.name skip,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos qty from sk_srvcontrdel del left join sk_srvcontrdet d on d.rowno=del.rdocno left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumpsite ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.site=d.site and s.tr_no=d.rdocno left join sk_skipm sm on sm.doc_no=del.skipid where del.rdocno='"+rowno+"'";
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
}
