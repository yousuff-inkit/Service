package com.dashboard.skips.revenueanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsRevenueAnalysisDAO {

	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();

	public JSONArray getRevenueAnalysisSummary(String fromdate,String todate,String brhid,String groupby,String id, String topclschk) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqlfilters="",colname="",sqljoin="",groupcol="", ordercol="";
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(sqlfromdate!=null && sqltodate!=null){
				sqlfilters+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			
			if(groupby.equalsIgnoreCase("AC")) {
				colname="md.description";
				groupcol="d.idno";
				sqljoin=" left join sk_invmode md on md.idno=d.idno ";
				
			}else if(groupby.equalsIgnoreCase("CT")) {
				colname="case when c.billingmethod=1 then 'Monthly' when c.billingmethod=2 then 'Yearly' when c.billingmethod=3 then 'Adhoc' else '' end as ";
				groupcol="c.billingmethod";
				
			}else if(groupby.equalsIgnoreCase("SM")) {
				colname="sm.sal_name";
				sqljoin=" left join my_salm sm on sm.doc_no=c.sal_id ";
				groupcol="c.sal_id";
				
			}else if(groupby.equalsIgnoreCase("SS")) {
				colname="sk.name";
				sqljoin=" left join sk_skiptype sk on sk.doc_no=sd.skiptype ";
				groupcol="sd.skiptype";
				
			}else if(groupby.equalsIgnoreCase("WT")) {
				colname="ds.name";
				sqljoin=" left join sk_dumptype ds on ds.doc_no=sd.wastetype ";
				groupcol="sd.wastetype";
				
			}else if(groupby.equalsIgnoreCase("OW")) {
				colname="r1.name";
				sqljoin=" left join sk_enqrelated r1 on (r1.srno=sd.ownershipid and r1.type='SERVICEBY') ";
				groupcol="sd.ownershipid";
				
			}else if(groupby.equalsIgnoreCase("CL")) {
				colname="ac.refname";
				sqljoin=" left join my_acbook ac on (ac.cldocno=m.cldocno and ac.dtype='CRM') ";
				groupcol="m.cldocno";
			}else if(groupby.equalsIgnoreCase("MO")) {
				colname="monthname(m.date)";
				sqljoin="";
				groupcol="month(m.date)";
			}else {}
			
			if(topclschk.equalsIgnoreCase("1") && groupby.equalsIgnoreCase("CL")) {     
				ordercol=" sum(coalesce(d.nettotal,0)) desc limit 25";  
			}else {
				ordercol=groupcol;         
			}
			
			conn=objconn.getMyConnection();
			
			String strsql="select "+colname+" refname,sum(coalesce(d.nettotal,0)) amount from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "+
					sqljoin+"where m.status=3 "+sqlfilters+" group by "+groupcol+" order by "+ordercol+"";  

			System.out.println(strsql);
			
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getRevenueAnalysisDetails(String fromdate,String todate,String brhid,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqlfilters="";
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(sqlfromdate!=null && sqltodate!=null){
				sqlfilters+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			
			conn=objconn.getMyConnection();
			
			String strsql="select m.voc_no invno,m.date invdate, md.description account,case when c.billingmethod=1 then 'Monthly' when c.billingmethod=2 then 'Yearly' when c.billingmethod=3 then 'Adhoc' else '' end as contracttype," + 
					"sm.sal_name,sk.name skipsize, ds.name wastetype, r1.name ownership, coalesce(d.nettotal,0) amount from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_invmode md on md.idno=d.idno left join sk_srvcontrm c on c.tr_no=m.cnttrno " + 
					"left join my_salm sm on sm.doc_no=c.sal_id left join sk_srvcontrdet sd on sd.rdocno=c.tr_no left join sk_skiptype sk on sk.doc_no=sd.skiptype left join sk_dumptype ds on ds.doc_no=sd.wastetype left join sk_enqrelated r1 on (r1.srno=sd.ownershipid and r1.type='SERVICEBY') " + 
					"where m.status=3 "+sqlfilters+" group by d.rowno order by m.doc_no,d.rowno";
			
		    //System.out.println("Details="+strsql);   
			
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
}
