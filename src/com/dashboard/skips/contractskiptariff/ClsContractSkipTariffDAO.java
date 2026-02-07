package com.dashboard.skips.contractskiptariff;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsContractSkipTariffDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
 
	 public  JSONArray cstLoad(int chk,String fromdate,String todate) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			if(chk!=1) {
				return RESULTDATA;  
			}
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
			String sqltest="";
			try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
			       sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
			    }else {}
				if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			       sqltodate=cmn.changeStringtoSqlDate(todate);
			    }else {}  
			   
				String sqldata="select round(coalesce(d.addrate,0),2) addrate,r6.name ctype,m.billingmethod billingmethodid,case when m.billingmethod=1 then 'Monthly' when m.billingmethod=2 then 'Yearly' when m.billingmethod=3 then 'Adhoc' end billingmethod, m.skipstatus,m.email,sm.sal_name salesman,coalesce(a1.name,'') groupcompanies,m.refno,m.remarks oldcontno,round(coalesce(d.tippingfee,0),2) tippingfee, r5.name tippingmethod,round(coalesce(d.tippingsecurity,0),2) tippingsecurity,round(coalesce(d.tariffrate,0),2) tariffrate,dd.gpsx gpsx1,dd.gpsy gpsy1,dd.route,dd.skip,d.statusid,case when d.statusid=1 then 'Skip Assigned' when d.statusid=2 then 'Delivery Scheduled' when d.statusid=3 then 'Delivery Updated' when d.statusid=4 then 'Route Assigned' else 'Entered' end as status,m.brhid,if(s.gpsx=0,'',s.gpsx) gpsx, if(s.gpsy=0,'',s.gpsy) gpsy,ac.refname,m.cldocno,d.rowno,m.tr_no,m.doc_no, date_format(m.date,'%d.%m.%Y') date,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, round(coalesce(d.rate,0),2) rate, round(coalesce(d.securityval,0),2) security, round(coalesce(d.rent,0),2) rent, r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,if(s.rowno is null,0,s.rowno) siteid,date_format(m.enddt,'%d.%m.%Y') enddt,date_format(m.startdt,'%d.%m.%Y') startdt,m.remarks, rnw.doc_no renewalno, m.revision_no,coalesce(del.cnt,0)delqty "
						+ "from sk_srvcontrm m inner join sk_srvcontrdet d  on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.site=d.site and s.tr_no=d.rdocno left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') left join sk_enqrelated r5 on (r5.srno=d.tippingmethod and r5.type='TIPPINGFEEMETHOD') left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join (select group_concat(distinct del.gpsx) gpsx,group_concat(distinct del.gpsy) gpsy,group_concat(distinct r.name) route,group_concat(distinct m.name) skip,rdocno from sk_srvcontrdel del left join sk_skipm m on m.doc_no=del.skipid left join sk_route r on r.doc_no=del.routeid group by rdocno) dd on dd.rdocno=d.rowno left join gl_enqm em on em.doc_no=m.refdocno left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') left join sk_srvcontrm rnw on rnw.tr_no=m.oldcnttrno left join (select rdocno,srno,count(*) cnt from sk_srvcontrdel group by rdocno ,srno) del on del.rdocno=d.rowno and del.srno=d.srno where m.status=3 and d.tariffrate<d.rate "+sqltest+"  and curdate() between m.startdt and m.enddt ORDER BY M.DOC_NO desc";
				System.out.println("detail==="+sqldata);  
				resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=cmn.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
}
