package com.dashboard.skips.changesalesman;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsChangeSalesmanDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
		 
	public JSONArray contractGridLoad(HttpSession session, int id, String fromdate, String todate, String salid) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();   
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			java.sql.Date sqlfromdate = null, sqltodate = null;
		    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		    }  
		    
		    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		    	sqltodate=objcommon.changeStringtoSqlDate(todate);
		    }  
			String sqltest="";
			 
			if(sqlfromdate!=null && sqltodate!=null) {
				sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";   
			}
		    
			if(!salid.equals("0") && !salid.equals("")) {   
				sqltest+=" and m.sal_id='"+salid+"'";
			} 
			
			String sql="select round(coalesce(d.addrate,0),2) addrate,r6.name ctype,m.billingmethod billingmethodid,case when m.billingmethod=1 then 'Monthly' "
					+ "when m.billingmethod=2 then 'Yearly' when m.billingmethod=3 then 'Adhoc' end billingmethod, m.skipstatus,m.email,sm.sal_name salesman,"
					+ "coalesce(a1.name,'') groupcompanies,m.refno,m.remarks oldcontno,round(coalesce(d.tippingfee,0),2) tippingfee, r5.name tippingmethod,"
					+ "round(coalesce(d.tippingsecurity,0),2) tippingsecurity,round(coalesce(d.tariffrate,0),2) tariffrate,d.statusid,case when d.statusid=1 "
					+ "then 'Skip Assigned' when d.statusid=2 then 'Delivery Scheduled' when d.statusid=3 then 'Delivery Updated' when d.statusid=4 then 'Route Assigned'"
					+ " else 'Entered' end as status,m.brhid,if(s.gpsx=0,'',s.gpsx) gpsx, if(s.gpsy=0,'',s.gpsy) gpsy,ac.refname,m.cldocno,d.rowno,m.tr_no,m.doc_no,"
					+ " date_format(m.date,'%d.%m.%Y') date,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, "
					+ "if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, "
					+ "round(coalesce(d.rate,0),2) rate, round(coalesce(d.securityval,0),2) security, round(coalesce(d.rent,0),2) rent, r1.name ownership,"
					+ "r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,if(s.rowno is null,0,s.rowno) siteid,date_format(m.enddt,'%d.%m.%Y') enddt,"
					+ "date_format(m.startdt,'%d.%m.%Y') startdt,m.remarks, rnw.doc_no renewalno, m.revision_no,coalesce(del.cnt,0)delqty from sk_srvcontrm m "
					+ "inner join sk_srvcontrdet d  on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype "
					+ "left join sk_srvcsited s on s.site=d.site and s.tr_no=d.rdocno left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') "
					+ "left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') "
					+ "left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') "
					+ "left join sk_enqrelated r5 on (r5.srno=d.tippingmethod and r5.type='TIPPINGFEEMETHOD') left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm'  "
					+ "left join gl_enqm em on em.doc_no=m.refdocno left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) "
					+ "left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') left join sk_srvcontrm rnw on rnw.tr_no=m.oldcnttrno "
					+ "left join (select rdocno,srno,count(*) cnt from sk_srvcontrdel group by rdocno ,srno) del on del.rdocno=d.rdocno and del.srno=d.srno where m.status<=3 "+sqltest+" ORDER BY M.DOC_NO desc";
			//System.out.println("sql="+sql);      
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